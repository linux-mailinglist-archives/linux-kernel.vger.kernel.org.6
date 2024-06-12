Return-Path: <linux-kernel+bounces-210956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2599904B1D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 07:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CE15B22171
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 05:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2435A0F4;
	Wed, 12 Jun 2024 05:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gWLeN/I3"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACD35821A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 05:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718171923; cv=none; b=h2V507P4JGlb1gqMpbddnkFmKtsds43FZhvHz26mAuVqKrZEeinSSTTD2iETa7h50S0KsarUXrv/7RHK82xXso+TE9+gQ5kEbxg/YDlZ6H2vuDpF/Wi5xyrS1FPMEKJBWrR33TfvkOELQ0gsEN+Z4TxQJL7eGzRH9yF5xvdFGKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718171923; c=relaxed/simple;
	bh=d++qrIBCc+v23jCIkE3wM8GRAf2ykGEp/AZ6F2A5P88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zx8bq10LtfcQLbNws5rnhIsUjyvTCHRK2irO/v4hqrpUB7etSo3lexco0CBTXy4q652o5/C8ssWIANqNsLRBDukcJCOZq3q6An5MYgPH9mgqjL1drpQnRlV93T3MO7nqOigtCli8JJOeTna/JbS0Ob1sY41t9l+lryvw7pQgiAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gWLeN/I3; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: shahuang@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718171919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vr7nODWIwz/w7nv174lBINiHccBj0qhYAvXZmJBwsYk=;
	b=gWLeN/I39iPxX1I5XAr2UFfDEzZo2t7i7+tcRhaZP7LnQHVgj0uEnvXd063+cQTUINfKl0
	MheewWr+mqicvBVvE3iuVrUIr3cYrWSt/N+4HFdBT4c3ZIzK1D84HRtXRu9F/hqUmLtI96
	yK/kwMHNIWKZT/diTVvpl9rgPdY4sXU=
X-Envelope-To: maz@kernel.org
X-Envelope-To: kvmarm@lists.linux.dev
X-Envelope-To: eauger@redhat.com
X-Envelope-To: sebott@redhat.com
X-Envelope-To: cohuck@redhat.com
X-Envelope-To: james.morse@arm.com
X-Envelope-To: suzuki.poulose@arm.com
X-Envelope-To: yuzenghui@huawei.com
X-Envelope-To: catalin.marinas@arm.com
X-Envelope-To: will@kernel.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Tue, 11 Jun 2024 22:58:30 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Shaoqin Huang <shahuang@redhat.com>
Cc: Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev,
	Eric Auger <eauger@redhat.com>, Sebastian Ott <sebott@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/2] KVM: arm64: Allow BT field in ID_AA64PFR1_EL1
 writable
Message-ID: <Zmk5Bj4w_CFxrabg@linux.dev>
References: <20240612023553.127813-1-shahuang@redhat.com>
 <20240612023553.127813-2-shahuang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612023553.127813-2-shahuang@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jun 11, 2024 at 10:35:51PM -0400, Shaoqin Huang wrote:
> When migrating from MtCollins to AmpereOne, the BT field value in
> ID_AA64PFR1_EL1 register is different and not writable. This causes
> the migration to fail.
> 
> The BT field means Branch Target Identification mechanism support in
> AArch64 state. The value 0 means BT is not implemented, the value 1
> means BT is implemented.
> 
> On MtCollins(Migration Src), the BT value is 0.
> On AmpereOne(Migration Dst), the BT value is 1.
> 
> As it defined in the ftr_id_aa64dfr0, the samller value is safe. So if

typo: smaller

> we make the BT field writable, on the AmpereOne(Migration Dst) the BT
> field will be overrided with value 0.
> 
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> ---
> But there is a question, the ARM DDI mentions from Armv8.5, the only
> permitted value is 0b01. Do you guys know if there are any consequence
> if the userspace write value 0b0 into this field? Or we should restrict
> that at some level, like in VMM or kernel level?

There's no directly visible attribute in the CPU registers to determine
what level of the architecture the implementation supports, and I
don't really want KVM to go about policing this.

The general guidance for ID register fields is that we allow userspace
to select a subset of CPU features supported by KVM / the
implementation, which in this case would include the _NI encoding for
the field. This has been slightly opinionated so far, leaving features
that userspace selects via a separate mechanism (e.g. KVM_ARM_VCPU_INIT)
read only.

Userspace can (and should) come up with its own heuristics for
determining the feature set for the vCPU.

> ---
>  arch/arm64/kvm/sys_regs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index c9f4f387155f..8e0ea62e14e1 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -2292,7 +2292,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>  		   ID_AA64PFR0_EL1_GIC |
>  		   ID_AA64PFR0_EL1_AdvSIMD |
>  		   ID_AA64PFR0_EL1_FP), },
> -	ID_SANITISED(ID_AA64PFR1_EL1),
> +	ID_WRITABLE(SYS_ID_AA64PFR1_EL1, ID_AA64PFR1_EL1_BT),

This doesn't compile. The macro prefixes "SYS_" to the register name.

-- 
Thanks,
Oliver

