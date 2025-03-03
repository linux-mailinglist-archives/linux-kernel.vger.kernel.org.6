Return-Path: <linux-kernel+bounces-541074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D181A4B81B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 08:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46FBF18912C3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 07:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B301E9B07;
	Mon,  3 Mar 2025 07:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SWblF8Di"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520D31E5B72
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 07:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740985699; cv=none; b=nZQ3svMXYgqGTvG7OyBlAyuXq7kCgUfLuupwYe07IKXTS5hGh2D+DAxDNbSonanhaSBOEH2Wd1+g3nb+KwQRE6Jx/nZBBhi8vxGkHosbRUaIClu1T5xt0t6kch1S3EUnlM4TM44HjOYYVejsYmzYvFkdF24n6WhMj02EON+Izm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740985699; c=relaxed/simple;
	bh=AfwoLDxtt+un9QaIe0gjqSA+BcKTtkK/lo1w1S7u5uw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IZTyz9+IH/nfDmBaHvxUaPMCKROrmyK/TAPsVFfmd08nvyyNlymOkrH+i5U8OMragflz0679yweuL9BndVnnRzfx0L/fU1QrJ/q8OJqBwDz+DcscCQ4pcM9EYwhcRhEiRYpz9HMEPFTndR3wkHQD7jj1AE9OgGVnCiGreDRkuho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SWblF8Di; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740985696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TAZt9bZkuhMK3xl5j9Jo0Thv7hZQ7De0iSCYDAJHnkY=;
	b=SWblF8DifiHTUSRmx4KPYrItggb3vRJ1p3pnYojRvZvOD2RwgVSlw/fmGBLcGnjyY+7KlZ
	1E+5/x6YZ/H31I14zZe28S/ICE7yT3nHDhtw0MUTfyrt5ttKrqm0IzYXOQMJeSYjh0I71r
	LxXs32TtoN/w1d9k/FOJmaZQzJ/j1kQ=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-sVQI12OaNQ-mnRji-wtesQ-1; Mon, 03 Mar 2025 02:08:15 -0500
X-MC-Unique: sVQI12OaNQ-mnRji-wtesQ-1
X-Mimecast-MFC-AGG-ID: sVQI12OaNQ-mnRji-wtesQ_1740985694
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-22379af38e0so33559775ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 23:08:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740985693; x=1741590493;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TAZt9bZkuhMK3xl5j9Jo0Thv7hZQ7De0iSCYDAJHnkY=;
        b=Ejd7MORMYj5hk8+ENv4xlBylZVn4TSBnmTfF8hkjQ5GivO4XAaMuwC11ERI/018C8n
         29X0PT3qdVhQn3IwlHu2BG+LqoQanSaf7dGzAaEF8xdkRcrf/mAm36Ud5gcIgVmktc0W
         mNidLWpCdVjKn3eeEh+IefAvewc01ZWVnIX5M5on+vWt9vN1PT8JgrBZG+xPqPO+P1KA
         qWUFE20+0IwAUlw+sN0+RfEntQTYWEy83HhOfiFmjlc/jdPkwnfLCEHdDu4y34QOFQyD
         3sxgfwbL3A2OKUm82W2VuZzkICiBfA4odBP2YPCLc6uvVyO9t9qDJelMJMjZGsoXzgx0
         NMmg==
X-Forwarded-Encrypted: i=1; AJvYcCXcCv6Xn459OGEHOO2+bzCKHX+nUcpvhNtzD5EozuXCW/JWAchmmIchpLp5mzFarcMvOTng9+ofyaTVA08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs/eCimqj29eCKts2EyV0A5Je9Y8b2GXDAcfbzeDjQEl4UUpLG
	e66Xmn1opQHKz/aE89agNBEVyD8UAUcLMjJBilCUxpDlVfuvxB/+37kEOIKcXG+E+VZ7XqrDMmQ
	9o5PLCL8EB0FOSph+4OHPlAv4H8ule8Gz4C0828561DZcBvnM6QA+0IAVKnEHnyD6fAJLmA==
X-Gm-Gg: ASbGnctpCRRJrbl8AO5XJOnFTL7TQQ5p3QeZz3VU0XaUS7sB8McF0FTF2iehSrAuAx5
	i4HUiM35i69dAKPDWpARTXAAXorrRpERGyR9q/HXmpgddqxI348QZxt402QhV3Rgzh/RI5mVxj8
	YCxpc8DigqtsfUuj14X9FwSeoRPYTUgbxwojv50/LybvQWnifP15AY18he5OZ1Viu70T1qVZZO0
	r43NKi+kNb7gI90ixmKhg2iIflyU8zjDDU7oEm1nwSkBtg7czvYgrddu2gezAtrACWALpcGM8ns
	Ja9haTBQQQFq7VbUUQ==
X-Received: by 2002:a17:902:c951:b0:221:78a1:27fb with SMTP id d9443c01a7336-22368f72060mr189619905ad.11.1740985693567;
        Sun, 02 Mar 2025 23:08:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFj6AXAjs67EIGwQMhzQQGbQbpNnv+WHLAlTElHzKGobUYvRKx1SI4QHA9TpJnCJTfgJ55bPw==
X-Received: by 2002:a17:902:c951:b0:221:78a1:27fb with SMTP id d9443c01a7336-22368f72060mr189619505ad.11.1740985693207;
        Sun, 02 Mar 2025 23:08:13 -0800 (PST)
Received: from [192.168.68.55] ([180.233.125.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5cd2sm71285075ad.143.2025.03.02.23.08.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 23:08:12 -0800 (PST)
Message-ID: <7639eca7-8fd8-491c-90bd-1be084fbd710@redhat.com>
Date: Mon, 3 Mar 2025 17:08:04 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/45] arm64: RME: Allocate/free RECs to match vCPUs
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
 <20250213161426.102987-13-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250213161426.102987-13-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/14/25 2:13 AM, Steven Price wrote:
> The RMM maintains a data structure known as the Realm Execution Context
> (or REC). It is similar to struct kvm_vcpu and tracks the state of the
> virtual CPUs. KVM must delegate memory and request the structures are
> created when vCPUs are created, and suitably tear down on destruction.
> 
> RECs must also be supplied with addition pages - auxiliary (or AUX)
> granules - for storing the larger registers state (e.g. for SVE). The
> number of AUX granules for a REC depends on the parameters with which
> the Realm was created - the RMM makes this information available via the
> RMI_REC_AUX_COUNT call performed after creating the Realm Descriptor (RD).
> 
> Note that only some of register state for the REC can be set by KVM, the
> rest is defined by the RMM (zeroed). The register state then cannot be
> changed by KVM after the REC is created (except when the guest
> explicitly requests this e.g. by performing a PSCI call). The RMM also
> requires that the VMM creates RECs in ascending order of the MPIDR.
> 
> See Realm Management Monitor specification (DEN0137) for more information:
> https://developer.arm.com/documentation/den0137/
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes since v6:
>   * Avoid reporting the KVM_ARM_VCPU_REC feature if the guest isn't a
>     realm guest.
>   * Support host page size being larger than RMM's granule size when
>     allocating/freeing aux granules.
> Changes since v5:
>   * Separate the concept of vcpu_is_rec() and
>     kvm_arm_vcpu_rec_finalized() by using the KVM_ARM_VCPU_REC feature as
>     the indication that the VCPU is a REC.
> Changes since v2:
>   * Free rec->run earlier in kvm_destroy_realm() and adapt to previous patches.
> ---
>   arch/arm64/include/asm/kvm_emulate.h |   7 ++
>   arch/arm64/include/asm/kvm_host.h    |   3 +
>   arch/arm64/include/asm/kvm_rme.h     |  18 +++
>   arch/arm64/kvm/arm.c                 |  13 +-
>   arch/arm64/kvm/reset.c               |  11 ++
>   arch/arm64/kvm/rme.c                 | 179 +++++++++++++++++++++++++++
>   6 files changed, 229 insertions(+), 2 deletions(-)
> 

With the following one comment addressed:

Reviewed-by: Gavin Shan <gshan@redhat.com>

[...]

>   
>   /*
> diff --git a/arch/arm64/include/asm/kvm_rme.h b/arch/arm64/include/asm/kvm_rme.h
> index 698bb48a8ae1..5db377943db4 100644
> --- a/arch/arm64/include/asm/kvm_rme.h
> +++ b/arch/arm64/include/asm/kvm_rme.h
> @@ -6,6 +6,7 @@
>   #ifndef __ASM_KVM_RME_H
>   #define __ASM_KVM_RME_H
>   
> +#include <asm/rmi_smc.h>
>   #include <uapi/linux/kvm.h>
>   
>   /**
> @@ -65,6 +66,21 @@ struct realm {
>   	unsigned int ia_bits;
>   };
>   
> +/**
> + * struct realm_rec - Additional per VCPU data for a Realm
> + *
> + * @mpidr: MPIDR (Multiprocessor Affinity Register) value to identify this VCPU
> + * @rec_page: Kernel VA of the RMM's private page for this REC
> + * @aux_pages: Additional pages private to the RMM for this REC
> + * @run: Kernel VA of the RmiRecRun structure shared with the RMM
> + */
> +struct realm_rec {
> +	unsigned long mpidr;
> +	void *rec_page;
> +	struct page *aux_pages[REC_PARAMS_AUX_GRANULES];
> +	struct rec_run *run;
> +};
> +

REC_PARAMS_AUX_GRANULES represents the maximal number of the auxiliary granules.
Since the base page size is always larger than or equal to granule size (4KB).
The capacity of array @aux_pages[] needs to be REC_PARAMS_AUX_GRANULES. Ideally,
the array's size can be computed dynamically and it's allocated in kvm_create_rec().

Alternatively, to keep the code simple, a comment is needed here to explain why
the array's size has been set to REC_PARAMS_AUX_GRANULES.

An relevant question: Do we plan to support differentiated sizes between page
and granule? I had the assumption this feature will be supported in the future
after the base model (equal page and granule size) gets merged first.

Thanks,
Gavin


