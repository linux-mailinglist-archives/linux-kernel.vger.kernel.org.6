Return-Path: <linux-kernel+bounces-225497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD1D91314A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 03:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B3AD2865D4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 01:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AA9441D;
	Sat, 22 Jun 2024 01:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="xxNmm44z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8405315CB
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 01:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719018587; cv=none; b=elvCuEE1QNnEAJaNSJiS0QIpXZ4UuCntEGy+kq2VLqotkUg6SH9QwpctWydKrtTxB7Gpo0DX+3fGg3+URe9sf0nRhB7/rR3aiRWdYF4Ir2XH5yx535DBY3C4dICiQLqecYzoGgumk1dnYLuchw5DHAlpJ+r8LuW/KJdfQslFsO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719018587; c=relaxed/simple;
	bh=LVTh94A1jauJYphn+nG3MymM/ZJGA6DGwzXLough9Dk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rCY1rr3AqGztVFOBC4Ruazza3880YnWXEQo16+ZSN1DMz2zqqfuhRvfJQodhMZ1HFSOq+xObWor0vWkmWRxcNWaI4KVTz4kbJihEY+vxuYl4uoexL/qV2R4ViNoKLDKwuy+f/zcZI/mZui6uM95fsKpEzQxX7CljR4Srz7ssqgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=xxNmm44z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D664C2BBFC;
	Sat, 22 Jun 2024 01:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719018586;
	bh=LVTh94A1jauJYphn+nG3MymM/ZJGA6DGwzXLough9Dk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=xxNmm44zXLOZqcfkeFOsvJveH90r+q68CRILnUt0Yx1tM9cRu+ZCxQxs+UyYBZfkf
	 09h99++wu6RCK3tJfTNtw7Y+PRWtzWf38bZ92y/PtmcmwSaUFjvCdwz4PBbovL2iiY
	 ++qDGpAnmR1bSIZ7H/ruALjBksyLWAcNvV88kdG8=
Date: Fri, 21 Jun 2024 18:09:46 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: david@redhat.com, aarcange@redhat.com, hughd@google.com,
 shr@devkernel.io, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 zhouchengming@bytedance.com
Subject: Re: [PATCH v2 3/3] mm/ksm: optimize the chain()/chain_prune()
 interfaces
Message-Id: <20240621180946.151e28c8f0fb080299ed2c57@linux-foundation.org>
In-Reply-To: <20240621-b4-ksm-scan-optimize-v2-3-1c328aa9e30b@linux.dev>
References: <20240621-b4-ksm-scan-optimize-v2-0-1c328aa9e30b@linux.dev>
	<20240621-b4-ksm-scan-optimize-v2-3-1c328aa9e30b@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jun 2024 15:54:31 +0800 Chengming Zhou <chengming.zhou@linux.dev> wrote:

> mm/ksm.c | 152 ++++++++++++---------------------------------------------------
>  1 file changed, 27 insertions(+), 125 deletions(-)

That got my attention.

Thanks.  I merged it for testing, pending additional review.

