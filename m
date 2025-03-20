Return-Path: <linux-kernel+bounces-569123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E02A69ED6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 04:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07E7F7A1314
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 03:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CB01DD9D1;
	Thu, 20 Mar 2025 03:31:40 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080BF3987D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 03:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742441500; cv=none; b=aa1QNWF+XuKp6/KOHfF9lc/dTuRyi8x2HxSZzTk3GSjk6LervjKPPd0EnulLMu1qLtQZ722cvgWUJSkxozIEKDeF8uQtpPuQeQTgv7b5500ISJOyzalXyMj2hRO+yttnspEPVUj/TP+DKP37U8uS8/UODyjq5kmcNXr3yi0GWZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742441500; c=relaxed/simple;
	bh=5GmMr7sONuv6fDugtC4v698xa1pa+WZCdXaYZ4FxEeM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BvWYwB5dB9K4GB3usxc1ZS157jINEi0bH5bKNVKD9XORZq8QsM0MZrDfopK++jlsdmPI3l0J46HplAOkjv/mCCn1bKStuipyPkxqGbSrPceh+0XzwqsJcPS4lrCVxxEXB5vo08VrJorlXPetFIVYCC6NoYqA50zvdj96TrT7FZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.62])
	by gateway (Coremail) with SMTP id _____8AxTWsRjNtnVPGdAA--.4406S3;
	Thu, 20 Mar 2025 11:31:29 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
	by front1 (Coremail) with SMTP id qMiowMDx_MQKjNtnM_hUAA--.47363S3;
	Thu, 20 Mar 2025 11:31:26 +0800 (CST)
Subject: Re: [PATCH v3 1/1] KVM: arm64: Allow cacheable stage 2 mapping using
 VMA flags
To: Oliver Upton <oliver.upton@linux.dev>,
 David Hildenbrand <david@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Marc Zyngier <maz@kernel.org>,
 Ankit Agrawal <ankita@nvidia.com>, "joey.gouly@arm.com"
 <joey.gouly@arm.com>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
 "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
 "will@kernel.org" <will@kernel.org>,
 "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
 "shahuang@redhat.com" <shahuang@redhat.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 Aniket Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>,
 Vikram Sethi <vsethi@nvidia.com>, Andy Currid <acurrid@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, John Hubbard <jhubbard@nvidia.com>,
 Dan Williams <danw@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 Matt Ochs <mochs@nvidia.com>, Uday Dhoke <udhoke@nvidia.com>,
 Dheeraj Nigam <dnigam@nvidia.com>, Krishnakant Jaju <kjaju@nvidia.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "sebastianene@google.com" <sebastianene@google.com>,
 "coltonlewis@google.com" <coltonlewis@google.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "ardb@kernel.org"
 <ardb@kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "gshan@redhat.com" <gshan@redhat.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "tabba@google.com" <tabba@google.com>,
 "qperret@google.com" <qperret@google.com>,
 "seanjc@google.com" <seanjc@google.com>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <86r033olwv.wl-maz@kernel.org>
 <SA1PR12MB7199500A3683B15A64B663D6B0D12@SA1PR12MB7199.namprd12.prod.outlook.com>
 <87tt7y7j6r.wl-maz@kernel.org>
 <SA1PR12MB7199B320DAE42A8D7038A78EB0D32@SA1PR12MB7199.namprd12.prod.outlook.com>
 <8634fcnh0n.wl-maz@kernel.org> <Z9h98RhunemcFhhz@arm.com>
 <86wmcmn0dp.wl-maz@kernel.org> <20250318125527.GP9311@nvidia.com>
 <Z9nJH38Em9XEx3U7@arm.com> <ed25f5a6-dad6-4b5e-b42b-58e6ced6c7a2@redhat.com>
 <Z9nMHW-OqTLEqDRs@linux.dev>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <bbb361bd-6cb8-7b9d-f689-d52bb1a05605@loongson.cn>
Date: Thu, 20 Mar 2025 11:30:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z9nMHW-OqTLEqDRs@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDx_MQKjNtnM_hUAA--.47363S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7WFW5WFW5Kr47Ww15ZF4fJFc_yoW8ZF1Dpr
	yxt3ZFka1kXrySyws29w42gF40yw4Fqr4UXw15Kr1UCwn09FnrKFWFya12kFsrAF1Sq39F
	vFZ0q347JFya9abCm3ZEXasCq-sJn29KB7ZKAUJUUUUJ529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Wrv_ZF1l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4UJwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5UR67UUUU
	U==



On 2025/3/19 上午3:40, Oliver Upton wrote:
> On Tue, Mar 18, 2025 at 08:35:38PM +0100, David Hildenbrand wrote:
>> On 18.03.25 20:27, Catalin Marinas wrote:
>>> On Tue, Mar 18, 2025 at 09:55:27AM -0300, Jason Gunthorpe wrote:
>>>> On Tue, Mar 18, 2025 at 09:39:30AM +0000, Marc Zyngier wrote:
>>>>> The memslot must also be created with a new flag ((2c) in the taxonomy
>>>>> above) that carries the "Please map VM_PFNMAP VMAs as cacheable". This
>>>>> flag is only allowed if (1) is valid.
>>>>>
>>>>> This results in the following behaviours:
>>>>>
>>>>> - If the VMM creates the memslot with the cacheable attribute without
>>>>>     (1) being advertised, we fail.
>>>>>
>>>>> - If the VMM creates the memslot without the cacheable attribute, we
>>>>>     map as NC, as it is today.
>>>>
>>>> Is that OK though?
>>>>
>>>> Now we have the MM page tables mapping this memory as cachable but KVM
>>>> and the guest is accessing it as non-cached.
>>>
>>> I don't think we should allow this.
>>>
>>>> I thought ARM tried hard to avoid creating such mismatches? This is
>>>> why the pgprot flags were used to drive this, not an opt-in flag. To
>>>> prevent userspace from forcing a mismatch.
>>>
>>> We have the vma->vm_page_prot when the memslot is added, so we could use
>>> this instead of additional KVM flags.
>>
>> I thought we try to avoid messing with the VMA when adding memslots; because
>> KVM_CAP_SYNC_MMU allows user space for changing the VMAs afterwards without
>> changing the memslot?
> 
> Any checks on the VMA at memslot creation is done out of courtesy to
> userspace so it 'fails fast'. We repeat checks on the VMA at the time of
> fault to handle userspace twiddling VMAs behind our back.
yes, I think it is better to add cachable attribute in memslot, it can 
be checked on the VMA at memslot creation. Also cache attribute can be 
abstracted with cachable/uc/wc type rather than detailed arch specified.

Regards
Bibo Mao
> 
> VM_MTE_ALLOWED is an example of this.
> 
> Thanks,
> Oliver
> 


