Return-Path: <linux-kernel+bounces-332808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C062F97BF1D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 18:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7E6E1F21E4C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 16:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A984B1C9871;
	Wed, 18 Sep 2024 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="s9DkwCyg"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8B61C984F
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 16:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726676841; cv=none; b=ui3ZXA7VEn3zCavuJybfgZHvSreH7vf5IOuhThaJex7JyB5akgyWBEDBXD+apvM5yq5XugRjlVhna0nlVkV5Itnuz6RyVN0nHxrsaZaMeP/QIUdRp2KGAjWGFU8RRooIiTx479Qchk406O15bCOr7RjixLYvhTxpT0IgKrFJ49Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726676841; c=relaxed/simple;
	bh=qaNX7vM2eu7o+Gsy14Z6mTRn8W4B/VlyO9csZeGxIJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MpxXBK6v6lGEn3sZojRkJkTn5A1fd9MfukBJZ/wFb1DNSyYMr0RCoSOr+HleUSKlfpjrAp3uK3pQbI8gr/kIpa1q1KvdkBnwRWBb2b3hNwolRupR8YmJiTxWOGuFgS399pnRkaQwoW8oCwBy25RYCHOClneR3hQF2jpn9+OSwVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=s9DkwCyg; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D9B9F3F664
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 16:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1726676836;
	bh=iEkJdohtSWik4fNSGLkaPeBerSCz1v1hA1g/Oi9GQoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=s9DkwCygGJ/vqJ5Yk+lqtoIzy7PPX4wmZqp1YqhiETobXXmhRy5KUNaCcL8wvZ8qV
	 zwAhxAOgEU65KXvSLbf6tm06y7hq2gowxYp+0QWIJrSAe840OdE58eZG/Z+cwqNrbv
	 KanAfrqnXL0j7NWYToCVFflxNXGVWXOMLXY22hPn/UZRzCJKm+q3B1O4sylk1IIiEo
	 v7A0pNuOenXbuzDCaJbacD3sQi1QPl2MnNsTIUXyJTUoymgbx3y/cC/9/klGNtQMkW
	 6D+5mn0bFpl2Ar2Jvzzni1QPaNIH1o9rN3SsTVNm1ouUbtBzjKWyvx0fiU5zDcfUNf
	 sKF1rjaLVGxjw==
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-374c9b0daf3so2411078f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 09:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726676836; x=1727281636;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iEkJdohtSWik4fNSGLkaPeBerSCz1v1hA1g/Oi9GQoQ=;
        b=r+96YmwTmOe100zM5aUsRmdykaNqydm2/kI93babZqghJLppSEwUz3LJp0jWuNGh2l
         15AisdQA80hSxznlgYElIFAZguTuLbzX3QsM83+LSQMorY5o0Ya9b+9KwsKE0dzqrdRp
         64bYOtUClMKQZXS2ZHndB3QA+KsW6wbXdSWlBqL/v4uel1J6dIBjCeRidSu5vl926d50
         0vEb5DKyer9k0LIy5U7prGCSeHRo5WYfH+rySMJELoGVLtw97AGmsd5slTFH4+j6/B0h
         uXGApKeMdMnjp0dKBtdqUDQdZokpmQWQpiIp3xcYukcD3ExZ56IUIUgA1p4Z4MmkOF4p
         QR0g==
X-Forwarded-Encrypted: i=1; AJvYcCV2/Zt+xVTJWU1fVssU9sx83PqY6Mde0aMM8XS/H+VoOmMftLi4vlYsWR4YkMNrpRD6bJ3xX2OJkih6bQk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx63Dmqx2PWGdRWkiL8m5nYN5B7oImgQ+F/FWlchHrBK5+BAPr
	XRFxtOOLLv0M4JmzjQXu/8FaT/QSmAQ811hXdZwUtlBg65jiAPmXZq29XYPLT030atWL3QM9Qu9
	F6EQhbn4nT4yAFadYAVCIMDhEXt/M05VPQUkJ5JeeJu3DBtEYN8OSIK//fca4aJX3BI0PwMaCTR
	Gcig==
X-Received: by 2002:a5d:66c4:0:b0:371:8845:a3af with SMTP id ffacd0b85a97d-378d623b7d4mr11461422f8f.39.1726676836342;
        Wed, 18 Sep 2024 09:27:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq7GTsYYXDPhTkQjL35nwxJT/xKz4RyECHixjHF7LH26VDJ/F0Ct2Etb+lGYO2yRNM4mRfMA==
X-Received: by 2002:a5d:66c4:0:b0:371:8845:a3af with SMTP id ffacd0b85a97d-378d623b7d4mr11461375f8f.39.1726676835857;
        Wed, 18 Sep 2024 09:27:15 -0700 (PDT)
Received: from [192.168.103.101] (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e780519esm12698302f8f.103.2024.09.18.09.27.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 09:27:15 -0700 (PDT)
Message-ID: <ca16bb60-9745-478d-afba-1330b385027e@canonical.com>
Date: Wed, 18 Sep 2024 18:27:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] target/riscv: enable floating point unit
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
 kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 Andrew Jones <ajones@ventanamicro.com>
References: <20240916181633.366449-1-heinrich.schuchardt@canonical.com>
 <20240917-f45624310204491aede04703@orel>
 <15c359a4-b3c1-4cb0-be2e-d5ca5537bc5b@canonical.com>
 <20240917-b13c51d41030029c70aab785@orel>
 <8b24728f-8b6e-4c79-91f6-7cbb79494550@canonical.com>
 <20240918-039d1e3bebf2231bd452a5ad@orel>
 <CAFEAcA-Yg9=5naRVVCwma0Ug0vFZfikqc6_YiRQTrfBpoz9Bjw@mail.gmail.com>
 <bab7a5ce-74b6-49ae-b610-9a0f624addc0@canonical.com>
 <CAFEAcA-L7sQfK6MNt1ZbZqUMk+TJor=uD3Jj-Pc6Vy9j9JHhYQ@mail.gmail.com>
 <f1e41b95-c499-4e06-91cb-006dcd9d29e6@canonical.com>
 <CAFEAcA_ePVwnpVVWJSx8=-8v2h_z2imfSdyAZd62RhXaZUTojA@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <CAFEAcA_ePVwnpVVWJSx8=-8v2h_z2imfSdyAZd62RhXaZUTojA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.09.24 17:32, Peter Maydell wrote:
> On Wed, 18 Sept 2024 at 14:49, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
>>
>> On 18.09.24 15:12, Peter Maydell wrote:
>>> On Wed, 18 Sept 2024 at 14:06, Heinrich Schuchardt
>>> <heinrich.schuchardt@canonical.com> wrote:
>>>> Thanks Peter for looking into this.
>>>>
>>>> QEMU's cpu_synchronize_all_post_init() and
>>>> do_kvm_cpu_synchronize_post_reset() both end up in
>>>> kvm_arch_put_registers() and that is long after Linux
>>>> kvm_arch_vcpu_create() has been setting some FPU state. See the output
>>>> below.
>>>>
>>>> kvm_arch_put_registers() copies the CSRs by calling
>>>> kvm_riscv_put_regs_csr(). Here we can find:
>>>>
>>>>        KVM_RISCV_SET_CSR(cs, env, sstatus, env->mstatus);
>>>>
>>>> This call enables or disables the FPU according to the value of
>>>> env->mstatus.
>>>>
>>>> So we need to set the desired state of the floating point unit in QEMU.
>>>> And this is what the current patch does both for TCG and KVM.
>>>
>>> If it does this for both TCG and KVM then I don't understand
>>> this bit from the commit message:
>>>
>>> # Without this patch EDK II with TLS enabled crashes when hitting the first
>>> # floating point instruction while running QEMU with --accel kvm and runs
>>> # fine with --accel tcg.
>>>
>>> Shouldn't this guest crash the same way with both KVM and TCG without
>>> this patch, because the FPU state is the same for both?
> 
>> By default `qemu-system-riscv64 --accel tcg` runs OpenSBI as firmware
>> which enables the FPU.
>>
>> If you would choose a different SBI implementation which does not enable
>> the FPU you could experience the same crash.
> 
> Ah, so KVM vs TCG is a red herring and it's actually "some guest
> firmware doesn't enable the FPU itself, and if you run that then it will
> fall over, whether you do it in KVM or TCG" ? That makes more sense.
> 
> I don't have an opinion on whether you want to do that or not,
> not knowing what the riscv architecture mandates. (On Arm this
> would be fairly clearly "the guest software is broken and
> should be fixed", but that's because the Arm architecture
> says you can't assume the FPU is enabled from reset.)
> 
> I do think the commit message could use clarification to
> explain this.
> 
> thanks
> -- PMM

I have not found a specification defining what the status of the FPU 
should be when M-Mode is stared and when moving from M-Mode to S-Mode.

OpenSBI (which is the dominating M-Mode firmware and invoked by default 
in TCG mode) enables the FPU before jumping to S-Mode. KVM should to the 
same for consistency.

Best regards

Heinrich

