Return-Path: <linux-kernel+bounces-346232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DD298C17F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E91F91F228EE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521D91C8FB2;
	Tue,  1 Oct 2024 15:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="wdt9lXqO"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D47645
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 15:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727796276; cv=none; b=TOFyC+XVe5+ya/NsdijNjHKklJ75QXBczw6tuaWq8sVccLcnL2m9PT5F0pI7p00sE9AI/5+pbpbSUnvUoi0WLCApafl8vMDFopqhqzHMbSti/8yyMPIzFbOJjbkwZ7yZqEqB0r7VE2D0kAV5gE9Ma62Sbky1Lps1AvE3oEwzcBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727796276; c=relaxed/simple;
	bh=niSGvh9NK28TTMNw+oIdMqrrpOCq9aq3rPkpfjc4Kxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lZ5eDVtErUG8iH+i9mCcZwQSKsW2IkZFfVLQHCqXDulICkQzbhfpv1asRG6vai4aMmnnsZxMY3VgGSGRrZBQtl+mJHKWn88y9civSMDAYWRjoeoXP6OS3lAoxNUY+gY7pNX4IUKWov1p4gafgbM2hCIz8vDHZqh0OPiErmKiuEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=wdt9lXqO; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id BB34E3F690
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 15:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727796264;
	bh=IfyD3J08rpFUiSXRGVfyNTQZMlD+U8b9QEj2MDOV6RI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=wdt9lXqOJTT3WqCBVHdUXIfCN2P6GRcRZm99rSmrSL3DcAAuEE7bfkYR2lv3IC1jC
	 LMXztOlajxgslunrQ07nPkdKHGi5PyFB1IZTacyRUkcspFqlmbPy9O7DsyyyblPI4T
	 HrgM8C/wUx1kFyyVhVRY4HhmDtyCHZCxciAHLVhMWtIhvilJqqUjj/+N3u0VGkpRxd
	 hOMwCksO124Ob8W0wSr4rhR2FUlLRbPAL511XinNcfkakV8SIs0U+11fCLEb8tXVWY
	 lE99RLIGv4On99DZBlAwmVUDvvcjBMyq4Yypp9CI8Z4gn9Qwx4F7rWo7hzC6KG6HPu
	 a8m33PbKF920Q==
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb08ed3a6so32842905e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 08:24:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727796264; x=1728401064;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IfyD3J08rpFUiSXRGVfyNTQZMlD+U8b9QEj2MDOV6RI=;
        b=VIN1QU66hTrDdQDqsHTh1QdovIRqt6PONoUB+v3u0KgGs2jRBQBeB9U356zJIr5pis
         1UBhDGqOr3kA/iJnNZd8igqtZLVa29Qgt62WlEAcwq0RMZSTMYtdy/OiEQSq0HTjpJ36
         6zSFUGlhqha/sLA3lcSDJjsS3+xiUyaPl2/Juh3C9T9FqZ7s2nAohPE3S5ZspoPug4ZU
         DZemUtGHRxJSSYxBVnUBMc90QjLbuPYc/LxFF1A1MTq8qEfA3o4DO4mZaWT9jazVX+8a
         MAkksEmaXOZCxXDG97vLMzn9TLUAxnQVtETi1D2p1UCjIZfR56VbV615GjLy+gHlAosv
         u+2w==
X-Forwarded-Encrypted: i=1; AJvYcCWbvegEtnzaLGS66ma09bldTSaKhXzYg1EvGBmrV7ULH9pRSP866IzOAS1GhjP69EHt6RmWda//lOOhGqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3WwjMnwC3LuRgp5XUA/ceTWcY9qUP/45kTPIuuN+pUTYGpanU
	H6za6VOvc+YlsuoIVadGuHBwEGdALvKewJX0/L1TI44MACjqMqFsV+Oa0T/ZtRcT/IQ4WmgglNv
	1adz+lvMXbKfiLJMe2q8sl95s6nbQvQaQnsmIR64fh2+9SKZNaMfonG21KPmZCCNcfqjNBcFAtZ
	z2aA==
X-Received: by 2002:a05:600c:4686:b0:42f:6878:a68c with SMTP id 5b1f17b1804b1-42f7136168cmr23360665e9.13.1727796264173;
        Tue, 01 Oct 2024 08:24:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyHrSnHUcpAuWIVTs8rbNU+pK4oUSWrI04JLpfK1vnvT+GLbyBxh3h1bUViQwuHwGkJjXDwg==
X-Received: by 2002:a05:600c:4686:b0:42f:6878:a68c with SMTP id 5b1f17b1804b1-42f7136168cmr23360415e9.13.1727796263594;
        Tue, 01 Oct 2024 08:24:23 -0700 (PDT)
Received: from [192.168.103.101] (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cdddd86c7sm9461654f8f.26.2024.10.01.08.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 08:24:23 -0700 (PDT)
Message-ID: <811ea10e-3bf1-45a5-a407-c09ec5756b48@canonical.com>
Date: Tue, 1 Oct 2024 17:24:21 +0200
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
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <3c2ff70d-a580-4bba-b6e2-1b66b0a98c5d@ghiti.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01.10.24 15:51, Alexandre Ghiti wrote:
> Hi Heinrich,
> 
> On 29/09/2024 16:02, Heinrich Schuchardt wrote:
>> The IMAGE_DLLCHARACTERISTICS_NX_COMPAT informs the firmware that the
>> EFI binary does not rely on pages that are both executable and
>> writable.
>>
>> The flag is used by some distro versions of GRUB to decide if the EFI
>> binary may be executed.
>>
>> As the Linux kernel neither has RWX sections nor needs RWX pages for
>> relocation we should set the flag.
>>
>> Cc: Ard Biesheuvel <ardb@kernel.org>
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>> ---
>>   arch/riscv/kernel/efi-header.S | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/kernel/efi-header.S b/arch/riscv/kernel/efi- 
>> header.S
>> index 515b2dfbca75..c5f17c2710b5 100644
>> --- a/arch/riscv/kernel/efi-header.S
>> +++ b/arch/riscv/kernel/efi-header.S
>> @@ -64,7 +64,7 @@ extra_header_fields:
>>       .long    efi_header_end - _start            // SizeOfHeaders
>>       .long    0                    // CheckSum
>>       .short    IMAGE_SUBSYSTEM_EFI_APPLICATION        // Subsystem
>> -    .short    0                    // DllCharacteristics
>> +    .short    IMAGE_DLL_CHARACTERISTICS_NX_COMPAT    // 
>> DllCharacteristics
>>       .quad    0                    // SizeOfStackReserve
>>       .quad    0                    // SizeOfStackCommit
>>       .quad    0                    // SizeOfHeapReserve
> 
> 
> I don't understand if this fixes something or not: what could go wrong 
> if we don't do this?
> 
> Thanks,
> 
> Alex
> 


Hello Alexandre,

https://learn.microsoft.com/en-us/windows-hardware/drivers/bringup/uefi-ca-memory-mitigation-requirements
describes Microsoft's effort to improve security by avoiding memory 
pages that are both executable and writable.

IMAGE_DLL_CHARACTERISTICS_NX_COMPAT is an assertion by the EFI binary 
that it does not use RWX pages. It may use the 
EFI_MEMORY_ATTRIBUTE_PROTOCOL to set whether a page is writable or 
executable (but not both).

When using secure boot, compliant firmware will not allow loading a 
binary if the flag is not set.

Best regards

Heinrich

