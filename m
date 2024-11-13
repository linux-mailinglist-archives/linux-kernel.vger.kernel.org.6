Return-Path: <linux-kernel+bounces-407162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4099B9C6988
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 07:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7655B251DC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 06:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF88187346;
	Wed, 13 Nov 2024 06:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="pSQlZt1W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE7E14F9FD
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 06:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731480766; cv=none; b=cWhKa+ekF5Eau4h2GzFqKcoXbg2wGYjq7K86mIfiILzT9Sx6xG4p6eGHpLeIYX6YFgc6vt0QRA88iyu+D14VW+u4UOP1v0AkifM4g+G78WlCdmRl3/co9vhlffcml9Ri20Mwx1KzKNBELdvei20NA2ZcboeYqJAI/wkDHmeeVQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731480766; c=relaxed/simple;
	bh=xOpcl2VEYuCAnW+x7NWomeilL+Xx2LUb6LUm1ijdC00=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=o7ati69KHaGHJOESlFKipYcNWAgWLDWl6BJMzlXmhC70KwAhNInjM+YKQX2eyP0bWrEbFfbZkRg72sQbsCCWscRGybwFkOWRPSwcLFEuqn/1Fn9etgadnWbTs+JqdZxVsj4nSs5A1Rm1Vqq0QPH4Yh6KDqPRRFlblOP+B2ZNsoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=pSQlZt1W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6B4C4CEDF;
	Wed, 13 Nov 2024 06:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1731480766;
	bh=xOpcl2VEYuCAnW+x7NWomeilL+Xx2LUb6LUm1ijdC00=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pSQlZt1WbgDhVKpE1A9GMSjJDjfDqOR/P0Lg6FEI2p4tqRQmkRR1qle8LaC9uDRPU
	 6Om0S9Cm6kof/BkO8gQBWiMJYxPRrffbBKf9gIOVsYvCDh7cJaZ5L9LFrnFwY6M/Ng
	 VcwbODd2YhVwvW4Q85DRF5rt/pT2UjOYtqCcCuPU=
Date: Tue, 12 Nov 2024 22:52:45 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, Sourabh Jain
 <sourabhjain@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, Zi Yan
 <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Mahesh J
 Salgaonkar <mahesh@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, "Aneesh Kumar K . V"
 <aneesh.kumar@kernel.org>, Donet Tom <donettom@linux.vnet.ibm.com>, LKML
 <linux-kernel@vger.kernel.org>, Sachin P Bappalige <sachinpb@linux.ibm.com>
Subject: Re: [RFC v3 -next] cma: Enforce non-zero pageblock_order during
 cma_init_reserved_mem()
Message-Id: <20241112225245.52d0858536c6fb9ba4a683c0@linux-foundation.org>
In-Reply-To: <87h68bnbko.fsf@gmail.com>
References: <054b416302486c2d3fdd5924b624477929100bf6.1728656994.git.ritesh.list@gmail.com>
	<87h68bnbko.fsf@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 07:23:43 +0530 Ritesh Harjani (IBM) <ritesh.list@gmail.com> wrote:

> "Ritesh Harjani (IBM)" <ritesh.list@gmail.com> writes:
> 
> > cma_init_reserved_mem() checks base and size alignment with
> > CMA_MIN_ALIGNMENT_BYTES. However, some users might call this during
> > early boot when pageblock_order is 0. That means if base and size does
> > not have pageblock_order alignment, it can cause functional failures
> > during cma activate area.
> >
> > So let's enforce pageblock_order to be non-zero during
> > cma_init_reserved_mem().
> >
> > Acked-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> > ---
> > v2 -> v3: Separated the series into 2 as discussed in v2.
> > [v2]: https://lore.kernel.org/linuxppc-dev/cover.1728585512.git.ritesh.list@gmail.com/
> >
> >  mm/cma.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> 
> Gentle ping. Is this going into -next?

I pay little attention to anything marked "RFC".  Let me take a look.

