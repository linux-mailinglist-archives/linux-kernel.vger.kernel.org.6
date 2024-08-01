Return-Path: <linux-kernel+bounces-271761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE6C9452F8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 20:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1F5028436B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BBF143897;
	Thu,  1 Aug 2024 18:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="fdfMBAsl"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C087E1EB489
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 18:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722538050; cv=none; b=pjrYtoPuVWEBzq22OlzKTsFj6oaaI77iBSrT2OMPZg1d+MJa//2Oskr1MTQuJUW1wPiXPuKDRX8O9KCzuI4WEElLK8gyFrJ8FMDSY81uGHFo+/zHu8buo1UyshBj9NXdFQaiC5ZEVfz+rj/ryw/FQ3T5LeDoojuAYz1dQRRYuZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722538050; c=relaxed/simple;
	bh=szztjeP1MU/nnmgTvNRpcAGEUfX89yNhdtBaJwncAls=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=PbCnMIsKBPV5GVU9gAzEA5zxJSTivBWTYS9qmFvZVmhT6TVU4ZCOYYRRFcG1TCMyB26O2iQpeUEu91jeQMucDRj1eOWviwdwV8zG+v3oZ7h7YRnyQtT04RY23mBlH5Oo0Kij4+VOnYMJxh20aEUrdFDRycQIdCmub/d/9F6Xdlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=fdfMBAsl; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7105043330aso1740477b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 11:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1722538048; x=1723142848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J7Tgg9cuzRhQime+MvrA+O4z2pgv3NTD6cHJUCBgHjQ=;
        b=fdfMBAslQyCs1mtGtTPnV5otpmD3J3+ekoKU2Z/a9VavY/uu6R6pP+XkaqeaVV2KSO
         BkZBsDhcNa0YRCyZusGYdZ1oNRYQEdyr6T6oZ8HHOEFR217jWVUBMnv1agyTKAxN/f6R
         HZ3ZUGl3MTNxDdl4VK7W5PoIl7DZjRY7OS+kY/bqp6xMqeLKcHg2HRUFGpU4fMCYRzi3
         iiWHKVLgJi/QG6qzZpw09A6Z+gt51qSPOdY4LgOdw5QR/TuzHaqM8OAmEVVpeTNnE6rI
         SSDgXvWJTRMddB1wdl3LjTP6tlDxHgAuoTJr1M2h6tyaIm0KTfPzZof4cDyuP8wiCn7Y
         vxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722538048; x=1723142848;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7Tgg9cuzRhQime+MvrA+O4z2pgv3NTD6cHJUCBgHjQ=;
        b=UqxC8gcdBV+dJ1PJh6fe/RkECFyDqVkUB0GWbCK19McDIuzoDK0QjcOnYEAXtpNvGM
         P6PsxiRNV+OT86zMmwJ537QEtS8Q+A5KXnvgAsCpAl1DtM58Qst12EGMmFnwnnr1ZbiD
         CR4JzcThDT+tbHhRdt4k4p//W/KWo8EMlMFAGjKD4FNzjQJ5m8xx93eghovDYZWDMVBY
         2GHm38p6OiwejOrf3klkC8ZvdjJPtMssvk778xj/jRnBdeCtiOabwwamXqGueceR9zSC
         kf9qKFTC3asNB4WSMqSyszF6Qrl0ixvKml2OxcDDOU2TS7jIqJzuiPI7ZZK15L62G98O
         JwDw==
X-Forwarded-Encrypted: i=1; AJvYcCW1c11IUl3Ho2WLm0EL/CQUAOuu8KOXvfBRC9RP9Y42ttbefbrKuaWw57TJn3MXo4H3WkbS9h7Wz7v0F6dTN74rgRrEuiOCRjhFeGqZ
X-Gm-Message-State: AOJu0YzvoTibW/mO3VvE72MS8Gy6ENgBke0TwxPR69biD6Y35eT9Al6h
	6FQhfDhWagcz6j53PP31ZrKIohrvXtsbXiAIev5xL6Bvmnp6sMo3owGC7th74C0=
X-Google-Smtp-Source: AGHT+IGGuihy01UVG9qtEpMnoM6jrsoEqBueNqLxQZUmecP8v5t35MiWuJCPX37Fz6yDIzLQLBwF4Q==
X-Received: by 2002:a05:6300:668b:b0:1c4:98f8:9ccb with SMTP id adf61e73a8af0-1c699620ef3mr1315223637.34.1722538047805;
        Thu, 01 Aug 2024 11:47:27 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecfaf1asm147821b3a.142.2024.08.01.11.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 11:47:27 -0700 (PDT)
Date: Thu, 01 Aug 2024 11:47:27 -0700 (PDT)
X-Google-Original-Date: Thu, 01 Aug 2024 11:47:25 PDT (-0700)
Subject:     Re: [PATCH -fixes] riscv: Re-introduce global icache flush in patch_text_XXX()
In-Reply-To: <0719e155-0a07-4878-87e3-cd96fed7a1dd@sifive.com>
CC: alexghiti@rivosinc.com, Paul Walmsley <paul.walmsley@sifive.com>,
  aou@eecs.berkeley.edu, andy.chiu@sifive.com, linux-riscv@lists.infradead.org,
  linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: samuel.holland@sifive.com
Message-ID: <mhng-b8350c55-39e7-4502-b797-2b4a2c4dd758@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Thu, 01 Aug 2024 10:32:28 PDT (-0700), samuel.holland@sifive.com wrote:
> Hi Alex,
>
> On 2024-07-30 8:59 AM, Alexandre Ghiti wrote:
>> commit edf2d546bfd6 ("riscv: patch: Flush the icache right after
>> patching to avoid illegal insns") mistakenly removed the global icache
>> flush in patch_text_nosync() and patch_text_set_nosync() functions, so
>> reintroduce them.
>>
>> Fixes: edf2d546bfd6 ("riscv: patch: Flush the icache right after patching to avoid illegal insns")
>> Reported-by: Samuel Holland <samuel.holland@sifive.com>
>> Closes: https://lore.kernel.org/linux-riscv/CAHVXubh8Adb4=-vN4cSh0FrZ16TeOKJbLj4AF09QC241bRk1Jg@mail.gmail.com/T/#m800757c26f72a1d45c240cb815650430166c82ea
>
> Shouldn't this use the permalink for the specific message, not the thread?
>
>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> ---
>>  arch/riscv/kernel/patch.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
>> index ab03732d06c4..91edfd764ed9 100644
>> --- a/arch/riscv/kernel/patch.c
>> +++ b/arch/riscv/kernel/patch.c
>> @@ -205,6 +205,9 @@ int patch_text_set_nosync(void *addr, u8 c, size_t len)
>>
>>  	ret = patch_insn_set(tp, c, len);
>>
>> +	if (!ret)
>> +		flush_icache_range((uintptr_t)tp, (uintptr_t)tp + len);
>
> This patch was based on an old tree from before
> https://git.kernel.org/riscv/c/47742484ee16 removed the "tp" variable. While it
> still compiles because flush_icache_range() is a macro that discards its
> arguments, it will be confusing to anyone reading the code.

Thanks.  Alex is going to spin a new one, so I dropped this.

>
> Regards,
> Samuel
>
>> +
>>  	return ret;
>>  }
>>  NOKPROBE_SYMBOL(patch_text_set_nosync);
>> @@ -237,6 +240,9 @@ int patch_text_nosync(void *addr, const void *insns, size_t len)
>>
>>  	ret = patch_insn_write(tp, insns, len);
>>
>> +	if (!ret)
>> +		flush_icache_range((uintptr_t) tp, (uintptr_t) tp + len);
>> +
>>  	return ret;
>>  }
>>  NOKPROBE_SYMBOL(patch_text_nosync);

