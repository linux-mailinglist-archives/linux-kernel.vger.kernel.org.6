Return-Path: <linux-kernel+bounces-213709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1454907928
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29CAB286E96
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26E41494D1;
	Thu, 13 Jun 2024 17:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="L3YIEwSX"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A817E135A71
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 17:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718298082; cv=none; b=hMXTGk+BMH47606HlpDoIAPoGHsexcvdwDuSBk0ZUuy/O8xsrDMLtORKOrz98Okf9ukgxZ+currKrIeOV/ESlzW2ipZhAlMs7Yf912GqwIUhnuDccF2sVVthpD0L9g8mglbSAayziAZ+3cyOCQQspPBpRCHSpKlzP4OA9JS0umA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718298082; c=relaxed/simple;
	bh=gJK0UDphBtrN9oQubpPivSr7zBTGED/OtaE/r3rrEhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y1i5oUfu0jTKVYFxSVlzGNPhhiNMgEg94JZ8T3b61MjL8fZPVVhRbYjQdM5zhX4QJw4O9qAjM/AiueQuc8vArtVXNG7CbnPhDwXx5MwjkNHIjjgOz+m7AJmwtFxMVBi9tAbljinneEU+tUKTuMMU9NrNzoPXNjE/nwefPwUx6Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=L3YIEwSX; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7eb7c0f9784so52791539f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 10:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718298080; x=1718902880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nXgRk1tU//tFI0/4EBA3Dtf7/hVOKmlMTOUM0+rp8Mc=;
        b=L3YIEwSXrkSbXwm2ralStUvnjmWu/qa/4Y2Ft1qiv0DORy8nK6SLxSaeIuTzrDggti
         g2fCH/3gGlJjjvvakaLGA9PzGYo/GCeKH9g9hAiaELcKurYOLGoKcQ5QSWZjol+i1BBZ
         Uv1XzuIplF4Fh5LlYCb+Qa8QQvw4sIawWGC+lQrR/RT9WB9S2swgKZDrv8XeGsw7vd2p
         01L6MPIfTif67iqVZa1HCmtkAvycuXC4ix2ccZWNZMhOGPPYYRLF5z5BOBf8z63Glm24
         zGiv9GGsfclD8sHAb9MjfssNWQhV9q6b3nkefvv/ZGpM38QgsxTotJumb7x7ygVbwPKA
         5mBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718298080; x=1718902880;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nXgRk1tU//tFI0/4EBA3Dtf7/hVOKmlMTOUM0+rp8Mc=;
        b=VmgwMQ/0CtXVCkXRWl6Hh7P8xbJddwNA/gAj+97KP9YGJaH2pYgcnifzPVufvFcFo1
         pv5t2eR0NDqcq3pxZOtXIHuRK5rxalyZmZjqLvB47ZmYVsFnPpHiexVPP80+UtSpFK1A
         FKuzI+xvU7CQy1a6Py2HdtdCdVodpZfbphvowGycj4THtQcPbdieZcUQR07UDGh1+Rne
         2V3IkjJ9U/w0MNydMrx4mXbcidDoBXZ1SbCiZSRZ3NmVoLICP0xqhSdPVFe+3TaojZQl
         4fZGzo6lpAEWjStFLuhf+9YNmmO3S9UN/gmsZ1I0+9u6o9016ewqSlbvjU+Drd5a7zru
         5kIg==
X-Forwarded-Encrypted: i=1; AJvYcCVHH+Id6fQoNVxEo7MTsiJ5jqPcZVxRI3Oy6Y34EY1n2TjOqQantC1WG2itthLdherdRxAT/gisFsY91GLZSBCbJ2SIRaoup590EGFy
X-Gm-Message-State: AOJu0Yzv1bVNWw8yPTrCRDKL4kwgBzHalvB1iiGpGT71vIh+G3R/4pd3
	4xsKgpOeSzFFguSUirqKfJOA3wWIO4WceJCmAWhCein+FojiTopntGkw0tZNaN4=
X-Google-Smtp-Source: AGHT+IG5tU0xWTgcG9SKUXHYg/s/bHtvZgR61ZCm0hnc0Gjrp6KBhXa5jceqwo/n9HtldwaweEX36A==
X-Received: by 2002:a05:6602:13c6:b0:7eb:81d6:c929 with SMTP id ca18e2360f4ac-7ebeb49936fmr9110339f.1.1718298079597;
        Thu, 13 Jun 2024 10:01:19 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7ebdba37b01sm38068739f.12.2024.06.13.10.01.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 10:01:19 -0700 (PDT)
Message-ID: <75ade6bc-ce34-4a2c-9768-2754830caf5c@sifive.com>
Date: Thu, 13 Jun 2024 12:01:18 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] riscv: Per-thread envcfg CSR support
To: Deepak Gupta <debug@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Jones <ajones@ventanamicro.com>, Conor Dooley <conor@kernel.org>,
 linux-kernel@vger.kernel.org
References: <20240605205658.184399-1-samuel.holland@sifive.com>
 <ZmODR+EMn5zW2Iu1@debug.ba.rivosinc.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <ZmODR+EMn5zW2Iu1@debug.ba.rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Deepak,

On 2024-06-07 5:01 PM, Deepak Gupta wrote:
> Hi Samuel,
> 
> Thanks for working on these.
> Patches looks good to me. I've given some suggestion for patch organization
> and squashing. You can take it or leave it.

Thanks for the review! I'd like to keep the patches separate so it is clear
which part is the behavior change (patch 1), and which part is the new
functionality (patch 2).

Regards,
Samuel

> Other than that.
> 
> Reviewed-By: Deepak Gupta <debug@rivosinc.com>
> 
> On Wed, Jun 05, 2024 at 01:56:44PM -0700, Samuel Holland wrote:
>> This series (or equivalent) is a prerequisite for both user-mode pointer
>> masking and CFI support, as those are per-thread features are controlled
>> by fields in the envcfg CSR. These patches are based on v1 of the
>> pointer masking series[1], with significant input from both Deepak and
>> Andrew. By sending this as a separate series, hopefully we can converge
>> on a single implementation of this functionality.
>>
>> [1]:
>> https://lore.kernel.org/linux-riscv/20240319215915.832127-6-samuel.holland@sifive.com/
>>
>>
>> Samuel Holland (3):
>>  riscv: Enable cbo.zero only when all harts support Zicboz
>>  riscv: Add support for per-thread envcfg CSR values
>>  riscv: Call riscv_user_isa_enable() only on the boot hart
>>
>> arch/riscv/include/asm/cpufeature.h |  2 +-
>> arch/riscv/include/asm/processor.h  |  1 +
>> arch/riscv/include/asm/switch_to.h  |  8 ++++++++
>> arch/riscv/kernel/cpufeature.c      | 13 +++++++++----
>> arch/riscv/kernel/smpboot.c         |  2 --
>> arch/riscv/kernel/suspend.c         |  4 ++--
>> 6 files changed, 21 insertions(+), 9 deletions(-)
>>
>> -- 
>> 2.44.1
>>


