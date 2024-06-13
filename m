Return-Path: <linux-kernel+bounces-214064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2A0907EE0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 00:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 231371F23386
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 22:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A578814D712;
	Thu, 13 Jun 2024 22:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I8DqDQU6"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3757C14D6FB
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 22:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718317827; cv=none; b=dX1YXFXHUWJehKUp9L/p1EoBlkFXlDzBrhxj4jqmTODkikZznhxhAtv8r2Mz40WO0j9jv7sduJxT50/7jvHjPMssKS1VfVe2NjVgGrHh0mUOupcOs9Lqd+ZNZqxq2IGKtSPQNw0Kj1lCuZshx8czCsIGS6CE2G3BAfQqkZ8w2CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718317827; c=relaxed/simple;
	bh=WtLUY3gMVMTzsvduKOwbMoFtAc7ptyRvEHjh8N5faqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ys60Wlb3p5vR2kq1/F8MPSpHTZBi8PSW42mHdgvhET5xnwmB4rt5t6PHcuWH7BJLmAYsevju2BAFljyh8UppdQs1XOFDi1A1tOpXLxDeqhNzR/ho3p8m4iyN3cMMduJzq6MgcReqfkSMVFQ2CjkKjp9jObOgo5MGG6nADN9YLLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I8DqDQU6; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: sebott@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718317823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dNle85tnfECNbiSxlEDa4ToUm+q1l8NGFSjlQ5FgLMc=;
	b=I8DqDQU6s25I1HEdwsGKxf0jwRIok9IGiN/75kIktfKUDl64p/7eF0bYjQLmjU3vlSfTxD
	+RJ8a1fF3d29X9CdNgQKQiKeJWfoz3GLooySvmQzMca/yEUWMgpbdwjjodOS4mKCDfVHou
	ft3dBuo6zvZCMEaY2SbUV0G0IxQa8Kw=
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: kvmarm@lists.linux.dev
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: maz@kernel.org
X-Envelope-To: james.morse@arm.com
X-Envelope-To: suzuki.poulose@arm.com
X-Envelope-To: catalin.marinas@arm.com
X-Envelope-To: will@kernel.org
X-Envelope-To: shahuang@redhat.com
X-Envelope-To: eric.auger@redhat.com
Date: Thu, 13 Jun 2024 22:30:15 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Sebastian Ott <sebott@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shaoqin Huang <shahuang@redhat.com>,
	Eric Auger <eric.auger@redhat.com>
Subject: Re: [PATCH v4 3/6] KVM: arm64: add emulation for CTR_EL0 register
Message-ID: <Zmty99X4hnYwtRS4@linux.dev>
References: <20240603130507.17597-1-sebott@redhat.com>
 <20240603130507.17597-4-sebott@redhat.com>
 <ZmtwjLbP283ra0Xq@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmtwjLbP283ra0Xq@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Thu, Jun 13, 2024 at 10:19:56PM +0000, Oliver Upton wrote:
> Hi Sebastian,
> 
> On Mon, Jun 03, 2024 at 03:05:04PM +0200, Sebastian Ott wrote:
> 
> [...]
> 
> > +static int validate_cache_topology(struct kvm_vcpu *vcpu, u64 ctr_el0)
> > +{
> > +	const struct sys_reg_desc *clidr_el1;
> > +	unsigned int i;
> > +	int ret;
> > +
> > +	clidr_el1 = get_sys_reg_desc(SYS_CLIDR_EL1);
> > +	if (!clidr_el1)
> > +		return -ENOENT;
> 
> This doesn't actually matter if we agree on dropping the cross-checking,
> but if this lookup fails it is 100% a KVM bug. Returning ENOENT isn't
> exactly right here, since it gives userspace the impression that the
> sysreg index it tried to access does not exist.
> 
> So in the future it'd be good to return EINVAL in places where the
> kernel did something stupid, probably with a warning for good measure.
> 
> > +static int set_ctr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
> > +		   u64 val)
> > +{
> > +	u64 ctr, writable_mask = rd->val;
> > +	int ret = 0;
> > +
> > +	mutex_lock(&vcpu->kvm->arch.config_lock);
> > +	ctr  = vcpu->kvm->arch.ctr_el0;
> > +	if (val == ctr)
> > +		goto out_unlock;
> > +
> > +	ret = -EBUSY;
> > +	if (kvm_vm_has_ran_once(vcpu->kvm))
> > +		goto out_unlock;
> > +
> > +	ret = -EINVAL;
> > +	if ((ctr & ~writable_mask) != (val & ~writable_mask))
> > +		goto out_unlock;
> > +
> > +	if (((ctr & CTR_EL0_DIC_MASK) < (val & CTR_EL0_DIC_MASK)) ||
> > +	    ((ctr & CTR_EL0_IDC_MASK) < (val & CTR_EL0_IDC_MASK)) ||
> > +	    ((ctr & CTR_EL0_DminLine_MASK) < (val & CTR_EL0_DminLine_MASK)) ||
> > +	    ((ctr & CTR_EL0_IminLine_MASK) < (val & CTR_EL0_IminLine_MASK))) {
> > +		goto out_unlock;
> 
> I'd prefer if we addressed the issue w/ arm64_check_features() by making
> CTR_EL0 behave like the other registers in the ID space instead of
> open-coding these sorts of checks.
> 
> I believe that can be accomplished by using kvm_read_sanitised_id_reg()
> as the ::reset() function in the descriptor and initializing
> kvm->arch.ctr_el0 in kvm_reset_id_regs().

Durr, I got rid of kvm_reset_id_regs() in commit 44cbe80b7616 ("KVM: arm64:
Reset VM feature ID regs from kvm_reset_sys_regs()"), I should engage
brain before responding.

Adding a check for encoding == CTR_EL0 to is_vm_ftr_id_reg() seems to be
the best way out.

-- 
Thanks,
Oliver

