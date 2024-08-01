Return-Path: <linux-kernel+bounces-271820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A23A9945394
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 21:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DBC01F240FA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3772314A612;
	Thu,  1 Aug 2024 19:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Nw/I0cmj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B71614A4ED
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 19:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722542154; cv=none; b=HENBYlrupfXcdoRzT70o0sk3B5DY5DcMtSDcCvp0wBHHw7a7T19fZfW+55hwu9zBQYrq7LGAobnGOjQDlV9j1THnjctgloJdvYAumOEyr1yypWQuRJHFx/0Vtma65lbEUA2JhjmKxENHXpc+BqU3xOJRTz834B1k7A2j99YIrjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722542154; c=relaxed/simple;
	bh=hvG2IaT/irZIdJ2c+z07bjwA9zbf73XRgNBNvBw4bW8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FKPF1TECQBVfG29URaX2vIUMLFete2M2ZuVuNO/rAMelN6UGN0TopuvaqyMBavGXvqWaaDz+uQME127RHkEgejvz6YTufvjhZaWuJ6FOFkAZCRfHqOdAA3yzQJ+XmQ7vHlpekvrN8Ipl/zareJZmFLAvnL69XjmmPB32scbTnFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Nw/I0cmj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696DEC4AF0B;
	Thu,  1 Aug 2024 19:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1722542153;
	bh=hvG2IaT/irZIdJ2c+z07bjwA9zbf73XRgNBNvBw4bW8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Nw/I0cmji9Zl94+2UQWkdbSontHJnY5+ax1eBnLcXsRKSggj7MBEWEIVx1If9RWCH
	 anf+Th58N7QLLPs+ffiyOgXyc08o+xfQA2viU/J7SDKM80xSIZJLfpiSWAJ6vUPn8b
	 3PJJ5m6dyvxezZV6nBE7OjODaCwsZo3Y3h41c+wk=
Date: Thu, 1 Aug 2024 12:55:52 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song
 <21cnbao@gmail.com>, hughd@google.com, willy@infradead.org,
 david@redhat.com, ryan.roberts@arm.com, ziy@nvidia.com, gshan@redhat.com,
 ioworker0@gmail.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: shmem: avoid allocating huge pages larger than
 MAX_PAGECACHE_ORDER for shmem
Message-Id: <20240801125552.12dc70cbe7220205a4a1a9ce@linux-foundation.org>
In-Reply-To: <bf97923f-b59a-4d91-95b5-67e555fb4cd3@linux.alibaba.com>
References: <117121665254442c3c7f585248296495e5e2b45c.1722404078.git.baolin.wang@linux.alibaba.com>
	<CAGsJ_4xmHY06VAKzXxCFcovPkrR0WOR28jXbaeD5VyUBHWzn_w@mail.gmail.com>
	<c55d7ef7-78aa-4ed6-b897-c3e03a3f3ab7@linux.alibaba.com>
	<87769ae8-b6c6-4454-925d-1864364af9c8@huawei.com>
	<ba3e3dfa-d019-4991-9e3a-d73ffa83bb36@linux.alibaba.com>
	<20240731134802.00541e78813997f3c59df36c@linux-foundation.org>
	<bf97923f-b59a-4d91-95b5-67e555fb4cd3@linux.alibaba.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Aug 2024 08:06:59 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> 
> 
> On 2024/8/1 04:48, Andrew Morton wrote:
> > On Wed, 31 Jul 2024 18:22:17 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> > 
> >> (Hope Andrew can help to squash these changes :))
> > 
> > I'm seeing some rejects against, amongst other things, your own "Some
> > cleanups for shmem" series.
> > 
> > So... v2, please?
> 
> These two bugfix patches are based on the mm-hotfixes-unstable branch 
> and need to be merged into 6.11-rcX, so they should be queued first.

OK.

> For the 'Some cleanups for shmem' series, I can send a new V4 version to 
> you after resolving conflicts with the shmem bugfix patches. Sorry for 
> the inconvenience.

I fixed things up.

