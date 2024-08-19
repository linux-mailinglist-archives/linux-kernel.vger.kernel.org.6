Return-Path: <linux-kernel+bounces-292500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EECE957032
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 604851C22190
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197D6172BCE;
	Mon, 19 Aug 2024 16:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DA0zKqhF"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D4A47F46
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724084821; cv=none; b=Q4oJYh9x0evm7gtklJBMLEtnxv5Vk3isRGZ2dyUf4Bm6sOzStygYMPvSbR211HO0H5xFQ4voIavlpcyAScYHwiDKsFaHkz9JGCV1otlZvBLtt3mFQRdr5irK8ftnnjR/jeM3EGOAqrWG9VBb+pLwrilwJotQzDrm1sGTQqwgXEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724084821; c=relaxed/simple;
	bh=BeG96sLKNi1TFbn65BaLHfUheDtSwpLdRfYAZIQofHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tH91CrlMCj0T0dMd/cy5RTpq8QXInD0s8BnjUQPMBCR5w+WmN+iKX7xDEsqszX+nXgYYKWuOjVJoSLoQbc9XVk2k7QyS9/MuLJNNZwFtEoeAz3lU5keI2ErgUXLLgydp/kqcOyNM8Hvdxf2/XZcljlmH68svs59NMk0xd/IHmcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DA0zKqhF; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 19 Aug 2024 09:26:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724084815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AsK28yHmfsApUch3ci6Pzhi4GLlWPP29RXZc1Ds3IyI=;
	b=DA0zKqhFxpybDfL5Z45D02TvTiKVCUI402G2mvw/UFkpdus/5RUA3xXm49eeD6u5hgTB5T
	fSKKMN+3XF8UjAKwuHlhVUX5VebqC9G4N7SxgHzVuJ74sZuSyaEekMpS47+mbwp8KlUd7k
	cGZhnieInUL6orETKfgOhJKVPMHVqzc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Zenghui Yu <yuzenghui@huawei.com>
Cc: Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	james.morse@arm.com, suzuki.poulose@arm.com,
	wanghaibin.wang@huawei.com
Subject: Re: [PATCH] KVM: arm64: vgic-debug: Don't put unmarked LPIs
Message-ID: <ZsNySeySMxxcpUTS@linux.dev>
References: <20240817101541.1664-1-yuzenghui@huawei.com>
 <86a5hbzbrt.wl-maz@kernel.org>
 <99900ad4-6b05-4bba-ec7a-f4f4d36ab71b@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99900ad4-6b05-4bba-ec7a-f4f4d36ab71b@huawei.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Aug 17, 2024 at 06:31:45PM +0800, Zenghui Yu wrote:
> On 2024/8/17 18:25, Marc Zyngier wrote:
> > On Sat, 17 Aug 2024 11:15:41 +0100,
> > Zenghui Yu <yuzenghui@huawei.com> wrote:
> > >
> > > If there were LPIs being mapped behind our back (i.e., between .start() and
> > > .stop()), we would put them at iter_unmark_lpis() without checking if they
> > > were actually *marked*, which is obviously not good.
> > >
> > > Switch to use the xa_for_each_marked() iterator to fix it.

Urgh, that's what I'd meant to do. Thanks for catching this Zenghui.

> > > Fixes: 85d3ccc8b75b ("KVM: arm64: vgic-debug: Use an xarray mark for debug iterator")
> > > Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> > > ---
> > >  arch/arm64/kvm/vgic/vgic-debug.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm64/kvm/vgic/vgic-debug.c b/arch/arm64/kvm/vgic/vgic-debug.c
> > > index bc74d06398ef..e1397ab2072a 100644
> > > --- a/arch/arm64/kvm/vgic/vgic-debug.c
> > > +++ b/arch/arm64/kvm/vgic/vgic-debug.c
> > > @@ -85,7 +85,7 @@ static void iter_unmark_lpis(struct kvm *kvm)
> > >  	struct vgic_irq *irq;
> > >  	unsigned long intid;
> > >  
> > > -	xa_for_each(&dist->lpi_xa, intid, irq) {
> > > +	xa_for_each_marked(&dist->lpi_xa, intid, irq, LPI_XA_MARK_DEBUG_ITER) {
> > >  		xa_clear_mark(&dist->lpi_xa, intid, LPI_XA_MARK_DEBUG_ITER);
> > >  		vgic_put_irq(kvm, irq);
> > >  	}
> > 
> > Ouch. Nicely caught. I think this deserves a
> > 
> > Cc: stable@vger.kernel.org # v6.10
> 
> Yup. I guess Oliver will help to add it when applying ;-)

Indeed, I'll grab it here in a moment.

> > 
> > With that,
> > 
> > Reviewed-by: Marc Zyngier <maz@kernel.org>
> 

Thanks both!

-- 
Best,
Oliver

