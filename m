Return-Path: <linux-kernel+bounces-356456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EAF99615D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B59D1C21E48
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 07:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECF8183CD1;
	Wed,  9 Oct 2024 07:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="o+cdpHiA"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558E4181D00
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 07:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728460060; cv=none; b=PftKz4EEzUhLywuMqv0VEcdfkl+mmIfZzZW4LKz+U8kBfCgro+cC61PET5p0Qn2bGmUcVPBfeueDRsfz5hkwckRg/LmkPP5nRoAGEviKVImd1QPIecwc92SOC3zEtM4hvKI0jo1C2Cujy6ZP9509zDzvz2og6Q/U3+7w//uaJ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728460060; c=relaxed/simple;
	bh=M3yxsY+9PPnN46n9uKc3CclIdd+jGD1Dvn1W9uL3vZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pj676/183SWOf+68jkC+1R6KKmyQA6mT8GFSdl0jSSHH9TYZQJXmzP3EFfOdjEtS2jfAcFUr38thzqjMuPhyCVfyTVSWDHZrrnNLjggZxWJiXFyX0dDY/UqbuGKrqjTZCie1yjvLbnLa4QsH6Pd2xajomHfouqyBpd5ZVhNjGx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=o+cdpHiA; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 73F483F5B5
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 07:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1728460048;
	bh=64u7S06vuCARV2d1jETcvXWsb00VtP72rN9+doc72U8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=o+cdpHiAtVvX2YPnHUemaTziKTAM/meku++JoaUO/0+8dpV41bAfwBdcwqBy+9+Ud
	 0kD1s0Zf2Ndek84RjeJt2udNO/5E1Vxt1uAfwVzcx9iS3YCqqNHRsL1oGGRvW/lA3c
	 Kv+GKwKlxqSb83MFYuNm/wZxQ6bV/uqFHSYhAufF5ul+2AXc+oCfx9akwusZskdfaH
	 ZPv+PqDTwp8VijuGsoGo3Zy4MZDjVqppFoJNxz05Bop5acVxqtjkEE3jDS8F+oUalx
	 0W1zIuSmZaRwS1cjdFPf1okXX/i3Zf57q4uyD6d4w77vMpTc7PSQf6ID+C3U3pLJbG
	 hXQrS/9nJ/0hQ==
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d2e7860d7so869889f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 00:47:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728460047; x=1729064847;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=64u7S06vuCARV2d1jETcvXWsb00VtP72rN9+doc72U8=;
        b=Mkjl50Rl9C01vloXOlA4OhilfeC8WHpH/vnB9v9wC9OliA70CgT4Cn+S1KbX7xPLP1
         pc9CRzYMhfjemyv0nLCeAH3uo8MLD4+UQECDc6wHFCP4jXI8/qEZBbJqfLN/xWMu1jvL
         3p1qEF4nVHctCICrx3tvxE0bpOgtdBOrx6GPNcJaC/i3aw56weFAt18sSFfQAQYVoJgI
         khQDGc4smJlNsPIVzpsT5ioPmMrygYJAcjwnzZBsxzR5gBBmmizMLsrlqGPYmbSfgVcX
         m5XGI64hyUjqz4G+2HbbVidc03Ip9oGEfKasjIthKqMqxaqNwj4wiGNxDwpnxIiVk0xO
         gqiw==
X-Forwarded-Encrypted: i=1; AJvYcCVnoOD5G7Zf8CfVqrsTL6IooA12h6+UejFOcEB0ePBlNYMkTnbr1SPwHxshIZNThUldnzEEXC02BZyeICw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHswVQzhsbKUx1aPfzWAK+qiCjQqBPCrmY8vO6p1c8s2irnbKk
	CKSkgXD/OTtjw86qMNjgLRdWdAyPDA/aj2OYnmSlXKyW5SoUzMeZu6q9xN0x3NuCm0oJuxW/WRh
	qDPowe1OVPEaFq6cHrKq7MkN8x64Ir698KM2hVl91tNgtHoMrTXHNKGGtSrPK9YbFX1rDN4ns6R
	Twpg==
X-Received: by 2002:a5d:5e11:0:b0:37d:3bad:a50b with SMTP id ffacd0b85a97d-37d3bada7a8mr652283f8f.45.1728460047169;
        Wed, 09 Oct 2024 00:47:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjy0iSj86RuRw+Xk9XUJOj0zHUIng80b/tKMspPKiIgG0uuvHQFCiq0VNFpthVXphITx593A==
X-Received: by 2002:a5d:5e11:0:b0:37d:3bad:a50b with SMTP id ffacd0b85a97d-37d3bada7a8mr652267f8f.45.1728460046709;
        Wed, 09 Oct 2024 00:47:26 -0700 (PDT)
Received: from ?IPV6:2a02:3035:6e0:2015:a58c:a3d4:2675:9367? ([2a02:3035:6e0:2015:a58c:a3d4:2675:9367])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf51770sm11658085e9.22.2024.10.09.00.47.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 00:47:26 -0700 (PDT)
Message-ID: <a3308767-eb30-446b-8c70-32b36a3075e4@canonical.com>
Date: Wed, 9 Oct 2024 09:47:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] riscv: efi: Set NX compat flag in PE/COFF header
To: Alexandre Ghiti <alex@ghiti.fr>
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
References: <20240929140233.211800-1-heinrich.schuchardt@canonical.com>
 <3c2ff70d-a580-4bba-b6e2-1b66b0a98c5d@ghiti.fr>
 <811ea10e-3bf1-45a5-a407-c09ec5756b48@canonical.com>
 <2d907c14-5b43-446e-9640-efb0fa0ba385@ghiti.fr>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <2d907c14-5b43-446e-9640-efb0fa0ba385@ghiti.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09.10.24 09:34, Alexandre Ghiti wrote:
> Hi Heinrich,
> 
> On 01/10/2024 17:24, Heinrich Schuchardt wrote:
>> On 01.10.24 15:51, Alexandre Ghiti wrote:
>>> Hi Heinrich,
>>>
>>> On 29/09/2024 16:02, Heinrich Schuchardt wrote:
>>>> The IMAGE_DLLCHARACTERISTICS_NX_COMPAT informs the firmware that the
>>>> EFI binary does not rely on pages that are both executable and
>>>> writable.
>>>>
>>>> The flag is used by some distro versions of GRUB to decide if the EFI
>>>> binary may be executed.
>>>>
>>>> As the Linux kernel neither has RWX sections nor needs RWX pages for
>>>> relocation we should set the flag.
>>>>
>>>> Cc: Ard Biesheuvel <ardb@kernel.org>
>>>> Cc: <stable@vger.kernel.org>
>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>>>> ---
>>>>   arch/riscv/kernel/efi-header.S | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/riscv/kernel/efi-header.S b/arch/riscv/kernel/efi- 
>>>> header.S
>>>> index 515b2dfbca75..c5f17c2710b5 100644
>>>> --- a/arch/riscv/kernel/efi-header.S
>>>> +++ b/arch/riscv/kernel/efi-header.S
>>>> @@ -64,7 +64,7 @@ extra_header_fields:
>>>>       .long    efi_header_end - _start            // SizeOfHeaders
>>>>       .long    0                    // CheckSum
>>>>       .short    IMAGE_SUBSYSTEM_EFI_APPLICATION        // Subsystem
>>>> -    .short    0                    // DllCharacteristics
>>>> +    .short    IMAGE_DLL_CHARACTERISTICS_NX_COMPAT    // 
>>>> DllCharacteristics
>>>>       .quad    0                    // SizeOfStackReserve
>>>>       .quad    0                    // SizeOfStackCommit
>>>>       .quad    0                    // SizeOfHeapReserve
>>>
>>>
>>> I don't understand if this fixes something or not: what could go 
>>> wrong if we don't do this?
>>>
>>> Thanks,
>>>
>>> Alex
>>>
>>
>>
>> Hello Alexandre,
>>
>> https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/ 
>> uefi-ca-memory-mitigation-requirements
>> describes Microsoft's effort to improve security by avoiding memory 
>> pages that are both executable and writable.
>>
>> IMAGE_DLL_CHARACTERISTICS_NX_COMPAT is an assertion by the EFI binary 
>> that it does not use RWX pages. It may use the 
>> EFI_MEMORY_ATTRIBUTE_PROTOCOL to set whether a page is writable or 
>> executable (but not both).
>>
>> When using secure boot, compliant firmware will not allow loading a 
>> binary if the flag is not set.
> 
> 
> Great, so that's a necessary fix, it will get merged in the next rc or so:
> 
> Fixes: cb7d2dd5612a ("RISC-V: Add PE/COFF header for EFI stub")

Thanks for reviewing.

At the time of commit cb7d2dd5612a (2020-10-02) the requirement did not 
exist. I guess a Fixes: tag is not applicable under these circumstances.

Best regards

Heinrich

