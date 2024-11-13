Return-Path: <linux-kernel+bounces-407853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 700C69C75CE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 344C12863C0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3A620401A;
	Wed, 13 Nov 2024 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="Z7tHTncR"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B96D202F70
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731510715; cv=none; b=EecYjFOeoqpeBCVFFs6aPsLQRJEYmOnNdwcMKhssEKMObRlR/xWbMiN/hmsiehod6i6p1VcirYOatKasMwsrcF24pzh47EhNKkPWUvAkkHAOZnBqd7qETb0HlbXr/edHp127FIB4X6SZKs9Dm0u6PfPbH5CYTUKyB3VX79hBjJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731510715; c=relaxed/simple;
	bh=lST0PC6zFH04QzDR5n00PEFVv1bzoE62EvVlFXG3HEw=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=lwiPVwIqNGifdu6oMnPJVhMz0UA3+DCoKMugm5mbve5hRFOYCLzSfBAwWP/ysjKtGIHSU60sY8pL7Ibw22OM0nfCO1xO84nEQlLZLLUaNEmQEHSaTtYDsILdUQQHECRwBsfMExr+VUlDSELvpwhp/lCAbhzPt2+1dI0eoFydV7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=Z7tHTncR; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-720be27db27so5925935b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 07:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1731510712; x=1732115512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FEevrCGgnCHKu+tn27c1hkwB55o+zkSlf6ER/b6dXcA=;
        b=Z7tHTncR2OOqoAPFeg+UVSCoqQ8gq0BR4mJpw7092OAE16XAMqDY+t5uVRzNLpnUne
         WBYsb9Sp9y8NdHTU2Wz0Z3G5QPgYxtPDu5DzRmjsFoJX6cZyBDl60m+nuQwHexni7/As
         qbmpSPCW6PnP2XG598/QIaGftBTpJPyUN4mBsojgKt4N/fHyPa71ls9uYn5HX1Uv9VhP
         YAY2VUN80DQH6m9sRsMFS4e1QlC2TLS4mvafko+R1nA+hIFbl8mSblBb8SYdM2X5gsHA
         ruMkJ5gCMHGPpAk7uJmTv28fsJ2PV8KiD0AjnwlIfYGVuU+48gZP2FF6dYe8x2SrlBOI
         jNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731510712; x=1732115512;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FEevrCGgnCHKu+tn27c1hkwB55o+zkSlf6ER/b6dXcA=;
        b=GDBoYshj7gqT4uhrUGhTISoxAmqMyogX0YTh0otDCld+qaOHCmbp8rgsulwqGbVYLx
         yLVRfLw8fepvEK8Z9FqGGvq4DRX3nVHIdTCEPzwTCgudXFlxBdpujbt2oLDHrvh4cyg+
         NTycXfA+ycF68GBloNlmPuuGVwH7tTGSYu/EdAqesKRtSc+rE0OZ+/D0YnESzL2gq00z
         IHxaSzOCx1yVSl/r6KoCV1Yzl6BIPAXddCGwTEceb0P/RxaxASdM7tAB3xli4Mrl+kby
         T9qAAkBGz1DPQCUuGo1QLKJWMed9CHtdkSpGu9m02+o2q5eFBGg1t8qP9FrGU53Vaytq
         GJEg==
X-Forwarded-Encrypted: i=1; AJvYcCWWg3y30jH4Y5bPq4z6EUpmUV0gHvQElU+btMO64aFlC9zQRicqqG3Gytn5hL/wywug5LxWbZgNXOThcds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+z5gmDBTqfgi5W0ERQYdX3ciKt6/uBJ/mT8y7SLqCHBVCV+ak
	K4IN+zecHjMhFusXVswYKkbGLIiGFfVU9nX4SOoqqk1V6jnNo7lvoFvbqQlZU50=
X-Google-Smtp-Source: AGHT+IF6dAQuXHH8zuadNr4w3nttjCNk1A405ajbo0+ieSOKAPOHNFkbBktOyltiO9TJiFCXE2hQKg==
X-Received: by 2002:a05:6a00:3c96:b0:71e:5b4a:66d4 with SMTP id d2e1a72fcca58-7244a516913mr9121240b3a.9.1731510712360;
        Wed, 13 Nov 2024 07:11:52 -0800 (PST)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a1a87bsm13098811b3a.158.2024.11.13.07.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 07:11:51 -0800 (PST)
Date: Wed, 13 Nov 2024 07:11:51 -0800 (PST)
X-Google-Original-Date: Wed, 13 Nov 2024 07:11:50 PST (-0800)
Subject:     Re: [PATCH] RISC-V: Enable Zicbom in usermode
In-Reply-To: <20241025-puritan-sank-b8a828ef5872@spud>
CC: cuiyunhui@bytedance.com, punit.agrawal@bytedance.com,
  Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu, cleger@rivosinc.com,
  Charlie Jenkins <charlie@rivosinc.com>, Evan Green <evan@rivosinc.com>, samuel.holland@sifive.com, andybnac@gmail.com,
  linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: Conor Dooley <conor@kernel.org>
Message-ID: <mhng-cee266c4-3485-423a-b769-aae7ae034a1a@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Fri, 25 Oct 2024 03:16:44 PDT (-0700), Conor Dooley wrote:
> On Fri, Oct 25, 2024 at 05:15:27PM +0800, Yunhui Cui wrote:
>> Like Zicboz, by enabling the corresponding bits of senvcfg,
>> the instructions cbo.clean, cbo.flush, and cbo.inval can be
>> executed normally in user mode.
>> 
>> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
>> ---
>>  arch/riscv/kernel/cpufeature.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>> index 1992ea64786e..bc850518ab41 100644
>> --- a/arch/riscv/kernel/cpufeature.c
>> +++ b/arch/riscv/kernel/cpufeature.c
>> @@ -924,7 +924,7 @@ unsigned long riscv_get_elf_hwcap(void)
>>  void __init riscv_user_isa_enable(void)
>>  {
>>  	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_ZICBOZ))
>> -		current->thread.envcfg |= ENVCFG_CBZE;
>> +		current->thread.envcfg |= ENVCFG_CBIE | ENVCFG_CBCFE | ENVCFG_CBZE;
>
> I believe we previously decided that userspace should not be allowed to

Ya, we didn't want to expose this because it opens up a can of worms.  
Is there a use case for this?  It's not like this is entirely impossible 
to do, it just requires a bit of thought (and should probably be gated 
behind some per-process disabling).

> use zicbom, but that not withstanding - this is wrong. It should be
> checking for Zicbom, not Zicboz.

