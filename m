Return-Path: <linux-kernel+bounces-269841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1824943760
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 22:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D3BCB2302F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 20:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6B216C6B5;
	Wed, 31 Jul 2024 20:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="qwcUqi1h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E74B49627
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 20:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722458884; cv=none; b=a6kIsl7sriMaM61eGu4ZhAccxeVCBrCgahNSTnG7uB+rbyAkQPDRougMKQFu1xG/qO8vwkZW/hjQmAbfq2Su2P0WJmYHJTtO0QImihr+KgR8xFvu8685nUnwU2b3cxsjhSLM9kXQ51HQuyUaJNT2++72OMr7u7EhgNIXzhE4JFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722458884; c=relaxed/simple;
	bh=PSaPdi28XoaempYPw+RXfe8/xzBZuoeOybNEl21zYoE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fkuxMn6UCKPP8lTzLX1K+HurzdRwzc4gVH1qeyWyM0Bb5TRhg/gKmCVNhtse9n1V3MR2xjVsSMUPNkwA7A+Zx4Fn19EiEs/4BNrbKE951GbX0OYlaU9OEfYjoMzY6My+Q48H0q1sLrWsSJL/2DSls4ZhyuryAuON4NlQAwhaDtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=qwcUqi1h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C460C116B1;
	Wed, 31 Jul 2024 20:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1722458883;
	bh=PSaPdi28XoaempYPw+RXfe8/xzBZuoeOybNEl21zYoE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qwcUqi1hzuisu0LrRAQbFXdBMb7neYQ3HeFU1np54OtirE66pV0hKqXOkv7qN86Tr
	 stfBVFpvVAyLXg0yKy56Mv/rowAlbd8o7GlCP9Ze9ME2qmUaCk+2TydZhgUv49pdLt
	 SU/9+1rvgOB3YuPmEH7rh4CE3LJ1ymZDQOjI4lt4=
Date: Wed, 31 Jul 2024 13:48:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song
 <21cnbao@gmail.com>, hughd@google.com, willy@infradead.org,
 david@redhat.com, ryan.roberts@arm.com, ziy@nvidia.com, gshan@redhat.com,
 ioworker0@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: shmem: avoid allocating huge pages larger than
 MAX_PAGECACHE_ORDER for shmem
Message-Id: <20240731134802.00541e78813997f3c59df36c@linux-foundation.org>
In-Reply-To: <ba3e3dfa-d019-4991-9e3a-d73ffa83bb36@linux.alibaba.com>
References: <117121665254442c3c7f585248296495e5e2b45c.1722404078.git.baolin.wang@linux.alibaba.com>
	<CAGsJ_4xmHY06VAKzXxCFcovPkrR0WOR28jXbaeD5VyUBHWzn_w@mail.gmail.com>
	<c55d7ef7-78aa-4ed6-b897-c3e03a3f3ab7@linux.alibaba.com>
	<87769ae8-b6c6-4454-925d-1864364af9c8@huawei.com>
	<ba3e3dfa-d019-4991-9e3a-d73ffa83bb36@linux.alibaba.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 18:22:17 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> (Hope Andrew can help to squash these changes :))

I'm seeing some rejects against, amongst other things, your own "Some
cleanups for shmem" series.

So... v2, please?

