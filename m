Return-Path: <linux-kernel+bounces-173613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7078C02F3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CF711C21AFB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CFD53387;
	Wed,  8 May 2024 17:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NwDJPz8e"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAC914A8C
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 17:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715188731; cv=none; b=DdYS+8JCHNGK8GZ0IDNCHZvDF9HkxOQkehYWWmS7i/rkYYOPicApxTxCFaU9vDewUuxq1bL+MKR9OpTB4c2uBgVXVbGXz+IHhLFuOUeer0U7JEcbJJHU7I6hWR5/bm3QORtjB2UVqZR2tIjzan35WJzXx0aSoM3a6bmajrYM8Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715188731; c=relaxed/simple;
	bh=OWpnNJ8rKooM+3S2sS4vhuD1egQMYUMnJc2NoPV4lBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHH/Gu8BFZmjKdqg/wAhaTj8u9yht4RSe0mon3OgnsSynazGvt8l3+/dQkqeY0sxAD+7mMtuhHBe1DEZDJOM+Qi7xbLY842ksYNpO5/apkoKCj15cHd9YVlr8vYE04gMO5aYvj6TH6LajejEkLmvtkkdQ4HsheZLmiDIdMB10Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NwDJPz8e; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 8 May 2024 12:18:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715188727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BZ3larZmFR+bN7ztPWWRwB/fEtXJTQLP/bM1SI4qrog=;
	b=NwDJPz8ekvICd3m5pf6iNYs5hxpRkt3eaSBLs1IpNNmQS42Udd+l+0C49g/GiWe7SSb7dI
	htEdA2rASUwPs+3HHkF+ag4xw1h+CKZVsRW/RmOhkx0WYFfBtua/ecjURjrexVXMD6yyXX
	L5V3LDOObgWF3yWn+TYc+kC8nGgVa2w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Sebastian Ott <sebott@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 4/6] KVM: arm64: add emulation for CTR_EL0 register
Message-ID: <Zjuz87jRcrHXebpx@linux.dev>
References: <20240426104950.7382-1-sebott@redhat.com>
 <20240426104950.7382-5-sebott@redhat.com>
 <ZjH6DcedmJsAb6vw@linux.dev>
 <29e7b97b-7a61-9b64-2c57-5a5d0e5f190e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29e7b97b-7a61-9b64-2c57-5a5d0e5f190e@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Wed, May 08, 2024 at 05:17:25PM +0200, Sebastian Ott wrote:
> Hej Oliver,
> 
> On Wed, 1 May 2024, Oliver Upton wrote:
> > > +static u64 reset_ctr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd)
> > > +{
> > > +	vcpu->kvm->arch.ctr_el0 = read_sanitised_ftr_reg(SYS_CTR_EL0);
> > > +	return vcpu->kvm->arch.ctr_el0;
> > > +}
> > > +
> > 
> > We definitely do not want this value to change across a vCPU reset, it
> > should be handled like the other ID registers where they only get reset
> > once for the VM lifetime.
> 
> Hm, maybe I'm misreading the code here but I don't think this is true
> for existing regs e.g. CLIDR_EL1 or the stuff defined via ID_WRITABLE().

This works for the feature ID registers we maintain per-VM, but not for
the feature ID registers local to a vCPU. Sent some fixes out for this
but forgot to Cc you on it, apologies.

https://lore.kernel.org/kvmarm/20240502233529.1958459-1-oliver.upton@linux.dev/

-- 
Thanks,
Oliver

