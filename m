Return-Path: <linux-kernel+bounces-229633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C745C917218
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 22:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7650B1F2467B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 20:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3220417CA10;
	Tue, 25 Jun 2024 20:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JiDMYVRc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF0817C228
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 20:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719345671; cv=none; b=TTWRVz3P3n+3TD49y7pMuWyfI3FuJMMcz2RbFic0LAkWoMyl3KgDxoukzjgNyndohbVx+9GlO6XVZ9ctxm8Ys556jNzDWdeijOnZuR+CsSfd3BqLCjgvw74FmBCUfklGVP/SXxLeAhvqd8Vzb+7u6w+7YL6BSrUPE0vDkGpPJIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719345671; c=relaxed/simple;
	bh=zZ1WlPuLtQUUBhZxGe7cmlWwIsqGh50hsMvMLAtG8UY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=O30D0LIHcMsw6qE77PDu9/QYFtfz9s21INRjSwE/Oxv4GkAdgpA2Wq+WnaOFcOv9IvNcG5pFktjmY5yllTCDpeSvZPrI0GbNKBkfX6z5LQZKCBNJ8m6KBTER1naP5zq5C0MlGII2XnBu7TjbX8fWpTc34UiJPnxrVow8+heg06s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JiDMYVRc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0574C32789;
	Tue, 25 Jun 2024 20:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719345671;
	bh=zZ1WlPuLtQUUBhZxGe7cmlWwIsqGh50hsMvMLAtG8UY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JiDMYVRczeaVLOdjVsTW2/yNIOijSTcrPtfBSrYKgaNz82Zll5e8FWrwGROMQhoIB
	 u212mj/vB0yu3syi1qGVoA+yfCM+5aN/J8lrps22BZoNal7ZPR76n2COqc3KNNdQzy
	 miIom1gHy40SPxf0W1U9sD+JSvhCfqVMPThB5IkM=
Date: Tue, 25 Jun 2024 13:01:10 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Rui Qi <qirui.001@bytedance.com>
Cc: linmiaohe@huawei.com, nao.horiguchi@gmail.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/memory-failure: allow memory allocation from
 emergency reserves
Message-Id: <20240625130110.ae4f6c3265559d1b1f979a3b@linux-foundation.org>
In-Reply-To: <20240625022342.6158-1-qirui.001@bytedance.com>
References: <20240625022342.6158-1-qirui.001@bytedance.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 10:23:42 +0800 Rui Qi <qirui.001@bytedance.com> wrote:

> we hope that memory errors can be successfully handled quickly, using
> __GFP_MEMALLOC can help us improve the success rate of processing
> under memory pressure, because to_kill struct is freed very quickly,
> so using __GFP_MEMALLOC will not exacerbate memory pressure for a long time,
> and  more memory will be freed after killed task exiting, which will also
> reduce memory pressure.

Has this been observed to improve behavior in some situation?  In
other words, please fully describe the observed runtime effects of this
change.


