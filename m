Return-Path: <linux-kernel+bounces-543195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B75A4D2B2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 05:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E57593A7A1A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 04:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10001F4264;
	Tue,  4 Mar 2025 04:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W6jF0xPz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEB91F03E0
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 04:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741063986; cv=none; b=nZYVIl18JDZX8P9RlfuuFuot1gjdTZWwzQKFSQYjhLIOdkN+FiuC5sSEFtSzTPXtz6chlkO67mbLw8yiTeUq195XXfr1A4+oYtek4GEhAAozN8I+OiJYaIBklkjT2rISFxtqhGAOdF1bjJRNQIRpVF7a68MbvCdOtLKLKb7ruQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741063986; c=relaxed/simple;
	bh=zfjVZcx2cE/z0JCBIXKs0CNEtspZuks9Gv3CVhRkmYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ulM6buzRtrDFLP+HKch8wES03RwbKDdH8J/EPrOSiNrrDY8z6IcdiBpV617wU+BtCeU1bWnqsgJyKZiXhFhHfC+2I52kPt55F/8RVT/cV0cC0SCbs20rff3fgfm8zfQsKjqNrxlgnzyl55cWAbWUPp7t6FyzvfZ0PhyKlfhTvT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W6jF0xPz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741063983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AxELm9JZG3yKkBZZ33qtCi2pLAO/qCPDSQRXT6O3LAA=;
	b=W6jF0xPzzINshIkDXfI7c1bYn1VDP2vJT94Gymg3aKhjtIYyVZXcZCKAQ5v2rkSx4ilzJO
	0M9UZWfAVuI71t3OoaS0hL/NHo3DoOgms9tzJzG0PZiyCPHlmobk5fBFmpbzaomBTBZspZ
	DXT60igXr/MhQ6+YsrroZ0OWtss6bQw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-1CR51JPFN86uMvEShuFgoA-1; Mon, 03 Mar 2025 23:53:01 -0500
X-MC-Unique: 1CR51JPFN86uMvEShuFgoA-1
X-Mimecast-MFC-AGG-ID: 1CR51JPFN86uMvEShuFgoA_1741063981
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22367f4e9b9so69308635ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 20:53:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741063981; x=1741668781;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AxELm9JZG3yKkBZZ33qtCi2pLAO/qCPDSQRXT6O3LAA=;
        b=YzSAhdaQW+6nM+po/zEOLC19407lW/ea9nL1/b1EPeKTWHuQIOJA71wPcV4kJ+RdtL
         es8M62XisTBbmwj1pEkOMs5F5Ju7bimYbomCchIOxVxUZh/i4TuMjBrxF+yXWG2QQkNj
         fPwZmnCl0kqXSjO9ZjNffHpCrxVfnp8QbxgRLVCptbBBiQ8R2IfINgup6TuCgXzA4tJe
         E5WXb/JzWfE1Jb7/tD6T5nL7lFxc3/RRgDjyRoOC6aNS/A5ZXdgwBdXEKBdiPUtxBYHv
         5KlFEIrQiyheQJgKC7JAsQO/iJS1yuD00jnUFP6s2/bKu8lmBoTiJ5c1FCm43MqjTlYZ
         +mgA==
X-Forwarded-Encrypted: i=1; AJvYcCU/t8ntzyn7VEbbC5PsVXvSx/1svvt8CG9n/quRClk18Hz2QgHjl5AMl77FOYiycygRSDShzYuWq17c7N0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyHLhNs6bMlEUmc3AnCIC4Du21radqt+kkQxHPubRL9YfB2Bcw
	VbbLL7SzK6PlxSyBKl8i8KQeqhe8vRQYK6rE0IgN20JKeph//VSUwDejJJhwkJaMv2zQJlg8wgl
	24YAphEp5veD0GHf2rX2mMtk7yG5agqPVEWfHcOv+XnIi42jS5u1yAn6K5nzTfw==
X-Gm-Gg: ASbGncuq3JOA1fsNoHa5c4PysoYsV0G2b5CS/KMhVGzjBLfS1u+0pVQxvrCTc7z51/g
	qOed40Br2J8s2z3UydbCRvlpztcwWI1OX0nRaJEtVlaYCUhuXjRBRcGPFGEzzn+VmVUcg9yAx3f
	IukaAeDajhkqSoxPxuyoAyQcUSVWLy0LifSO6MI/EbvrTt+AHDyG5qojlu377t4qe2cyFRWrh89
	9iAsibIr6kQftE7eoXzgWjZqRwHIacwHE5c/7DW9RDML8jYfLltq/jn+kLVH6uLA3PVQPxerBPg
	Pb7JOh3st8itQSSOlg==
X-Received: by 2002:a05:6a00:3916:b0:730:79bf:c893 with SMTP id d2e1a72fcca58-734ac33818amr25659483b3a.4.1741063980683;
        Mon, 03 Mar 2025 20:53:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHrKK12tR3N+mbAAVfdfQ2dTRLheKip2yCmHrOCAijBgggtR8kRt8J5JVYj+IuDCpb/96NhUg==
X-Received: by 2002:a05:6a00:3916:b0:730:79bf:c893 with SMTP id d2e1a72fcca58-734ac33818amr25659458b3a.4.1741063980378;
        Mon, 03 Mar 2025 20:53:00 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7362dbde43bsm6584335b3a.25.2025.03.03.20.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 20:52:59 -0800 (PST)
Message-ID: <abec92a5-0158-4d97-bfdc-03e805a4c96b@redhat.com>
Date: Tue, 4 Mar 2025 14:52:51 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 19/45] KVM: arm64: Handle realm MMIO emulation
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun
 <alpergun@google.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>
References: <20250213161426.102987-1-steven.price@arm.com>
 <20250213161426.102987-20-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250213161426.102987-20-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/25 2:13 AM, Steven Price wrote:
> MMIO emulation for a realm cannot be done directly with the VM's
> registers as they are protected from the host. However, for emulatable
> data aborts, the RMM uses GPRS[0] to provide the read/written value.
> We can transfer this from/to the equivalent VCPU's register entry and
> then depend on the generic MMIO handling code in KVM.
> 
> For a MMIO read, the value is placed in the shared RecExit structure
> during kvm_handle_mmio_return() rather than in the VCPU's register
> entry.
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes since v5:
>   * Inject SEA to the guest is an emulatable MMIO access triggers a data
>     abort.
>   * kvm_handle_mmio_return() - disable kvm_incr_pc() for a REC (as the PC
>     isn't under the host's control) and move the REC_ENTER_EMULATED_MMIO
>     flag setting to this location (as that tells the RMM to skip the
>     instruction).
> ---
>   arch/arm64/kvm/inject_fault.c |  4 +++-
>   arch/arm64/kvm/mmio.c         | 16 ++++++++++++----
>   arch/arm64/kvm/rme-exit.c     |  6 ++++++
>   3 files changed, 21 insertions(+), 5 deletions(-)
> 

One nitpick below, with it addressed:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
> index a640e839848e..2a9682b9834f 100644
> --- a/arch/arm64/kvm/inject_fault.c
> +++ b/arch/arm64/kvm/inject_fault.c
> @@ -165,7 +165,9 @@ static void inject_abt32(struct kvm_vcpu *vcpu, bool is_pabt, u32 addr)
>    */
>   void kvm_inject_dabt(struct kvm_vcpu *vcpu, unsigned long addr)
>   {
> -	if (vcpu_el1_is_32bit(vcpu))
> +	if (unlikely(vcpu_is_rec(vcpu)))
> +		vcpu->arch.rec.run->enter.flags |= REC_ENTER_FLAG_INJECT_SEA;
> +	else if (vcpu_el1_is_32bit(vcpu))
>   		inject_abt32(vcpu, false, addr);
>   	else
>   		inject_abt64(vcpu, false, addr);
> diff --git a/arch/arm64/kvm/mmio.c b/arch/arm64/kvm/mmio.c
> index ab365e839874..bff89d47a4d5 100644
> --- a/arch/arm64/kvm/mmio.c
> +++ b/arch/arm64/kvm/mmio.c
> @@ -6,6 +6,7 @@
>   
>   #include <linux/kvm_host.h>
>   #include <asm/kvm_emulate.h>
> +#include <asm/rmi_smc.h>
>   #include <trace/events/kvm.h>
>   
>   #include "trace.h"
> @@ -136,14 +137,21 @@ int kvm_handle_mmio_return(struct kvm_vcpu *vcpu)
>   		trace_kvm_mmio(KVM_TRACE_MMIO_READ, len, run->mmio.phys_addr,
>   			       &data);
>   		data = vcpu_data_host_to_guest(vcpu, data, len);
> -		vcpu_set_reg(vcpu, kvm_vcpu_dabt_get_rd(vcpu), data);
> +
> +		if (vcpu_is_rec(vcpu))
> +			vcpu->arch.rec.run->enter.gprs[0] = data;
> +		else
> +			vcpu_set_reg(vcpu, kvm_vcpu_dabt_get_rd(vcpu), data);
>   	}
>   
>   	/*
>   	 * The MMIO instruction is emulated and should not be re-executed
>   	 * in the guest.
>   	 */
> -	kvm_incr_pc(vcpu);
> +	if (vcpu_is_rec(vcpu))
> +		vcpu->arch.rec.run->enter.flags |= REC_ENTER_FLAG_EMULATED_MMIO;
> +	else
> +		kvm_incr_pc(vcpu);
>   
>   	return 1;
>   }
> @@ -162,14 +170,14 @@ int io_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa)
>   	 * No valid syndrome? Ask userspace for help if it has
>   	 * volunteered to do so, and bail out otherwise.
>   	 *
> -	 * In the protected VM case, there isn't much userspace can do
> +	 * In the protected/realm VM case, there isn't much userspace can do
>   	 * though, so directly deliver an exception to the guest.
>   	 */
>   	if (!kvm_vcpu_dabt_isvalid(vcpu)) {
>   		trace_kvm_mmio_nisv(*vcpu_pc(vcpu), kvm_vcpu_get_esr(vcpu),
>   				    kvm_vcpu_get_hfar(vcpu), fault_ipa);
>   
> -		if (vcpu_is_protected(vcpu)) {
> +		if (vcpu_is_protected(vcpu) || vcpu_is_rec(vcpu)) {
>   			kvm_inject_dabt(vcpu, kvm_vcpu_get_hfar(vcpu));
>   			return 1;
>   		}
> diff --git a/arch/arm64/kvm/rme-exit.c b/arch/arm64/kvm/rme-exit.c
> index aae1adefe1a3..c785005f821f 100644
> --- a/arch/arm64/kvm/rme-exit.c
> +++ b/arch/arm64/kvm/rme-exit.c
> @@ -25,6 +25,12 @@ static int rec_exit_reason_notimpl(struct kvm_vcpu *vcpu)
>   
>   static int rec_exit_sync_dabt(struct kvm_vcpu *vcpu)
>   {
> +	struct realm_rec *rec = &vcpu->arch.rec;
> +
> +	if (kvm_vcpu_dabt_iswrite(vcpu) && kvm_vcpu_dabt_isvalid(vcpu))
> +		vcpu_set_reg(vcpu, kvm_vcpu_dabt_get_rd(vcpu),
> +			     rec->run->exit.gprs[0]);
> +

A comment may be needed to explain why GPR[0] has to be copied over. The contexnt
in GPR[0] isn't needed by all cases, being handled by kvm_handle_guest_abort().
Something like below.

	/*
	 * Copy over GPR[0] to the target GPR, preparing to handle MMIO write
	 * fault. The content to be written has been saved to GPR[0] by RMM.
	 * It's overhead to other cases like fault due to MMIO read, shared
	 * or private space access.
	 */

>   	return kvm_handle_guest_abort(vcpu);
>   }
>   

Thanks,
Gavin


