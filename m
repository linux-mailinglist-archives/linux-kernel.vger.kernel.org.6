Return-Path: <linux-kernel+bounces-271678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E61F3945188
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5DAD1F2368C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5024C1B4C25;
	Thu,  1 Aug 2024 17:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RFPnmUO2"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F315F13D62B
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 17:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722533552; cv=none; b=gArXHjV13oTVKfupyW4qdPoIsMOk9WsEkwg40jJxW/cAyML4l00nHuwIIDmmDHJMS+oE3PAbWKvAveb3y/hc2LnP+fflOsS2+0djanul0I3VEZDHyEoZ7bqBE5lllBz1oQOmchEBkaYwBTHwIRmJCAo7Naez76gDCixlzQStrTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722533552; c=relaxed/simple;
	bh=TjMDSHWY5Igoffs0sPVEqbTSyCYscpk6athICFQ4/Gc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=T0d6I8FiUwVmSfv7DMPqP5tJsi5yPnFoAECfJNpBHHfpxKcr+VVFo4HAyev2ewhyK0GW0abfLtc9anCPHcuw+sm85WgMDIdK8KigiGa7Pb+LKPnZt7lMkb3j5OozQkY7SrOGnGxq6S0mr5SJL3zkhZMooNpD43rW5akgYr61Uz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=RFPnmUO2; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-81f96ea9ff7so248705739f.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 10:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1722533550; x=1723138350; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bS2/f0MUierH/zQOzYcFrgW7IacC2rV2Pf3VZgOc8QA=;
        b=RFPnmUO2AWrQplaw4WptW/q+1M83XxUGNc42WdJlsdA1cjOwAPFwJ92OTROMU2hBwd
         zDBRyJZjjPlIqBT+b4RLq508cmufnFODCHFBHeEn/tY6YQXIomrGzyGMsQH8qAGbbRh+
         c1VlO3TBelvyvFYhAbx3Qxb958aCKJVrAiGHyZFso+lNIfuMfGyxBQlgv3bQiEPVqJGf
         Ob7eAMx1ms95veQa1fjUOd+OYvqfxoghlnGPSWI++6Ak0cMmiNzXiRZ9IZKXld6Y9EW5
         fuvJdC/pWTdvRQJJQCdzGKNced8OesioNO7RdlIzk/aWIITnQT3viECtn4eU5am+Tq32
         lhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722533550; x=1723138350;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bS2/f0MUierH/zQOzYcFrgW7IacC2rV2Pf3VZgOc8QA=;
        b=MCHxbsdV+h/LE6JOeKUw+16lXVEkMoRP5qbpI8bY4s/38sI3h0Y9e31pMLIdqtExC4
         MAdYsQSMpvaBXK6tNPOx4ePiX5K7059ioHjxjjMJNtnW/7mVlf6bGpLnxHb7m7F3Xmrg
         lq22ShiS9ZOENeMuhE0UuDGK9vHQcS6qjadrPhXnuVeLGYDBfnpx2TycOonLD4ICJzyM
         NZDZQChTErJNkVHYALpv1SKJQP5oYny9sfiLVwoVEKwSDh3WMvVJGWP1kVtfBecTOGJq
         cgQAg7qygcMrWrvrm17o254BRcIeUz2mLDCtjiRSwMPzDb6Xf413/58FhnVngPk/H7S4
         8XKg==
X-Forwarded-Encrypted: i=1; AJvYcCUX3FD5iicRXaMOoH2UYv1CtA+kfvQF+Mf7XETdBbrYNjqGy94SL9sGQwCuWq67rj3vu1thQlpuEBl/jpg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8MW0om3pu67mdowNEnDyjY6n3yVqlNX32eQDntuR7fni1oAga
	BNoUlZaOiMVDLK5e2nrmC93lrAtmfwsOasXHERRb/ZDUNBfTP/ehR0uU4yssY3I=
X-Google-Smtp-Source: AGHT+IEW29DvT927BXE65AEWASyCF+zwd6XCxK7iEu1GTTZ94NlmL1vnW2UIMzI/7NaHio7Cnzi6DA==
X-Received: by 2002:a05:6602:6d10:b0:7fb:790c:a317 with SMTP id ca18e2360f4ac-81fd4367709mr110631939f.6.1722533549872;
        Thu, 01 Aug 2024 10:32:29 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d6a3e19asm21674173.127.2024.08.01.10.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 10:32:29 -0700 (PDT)
Message-ID: <0719e155-0a07-4878-87e3-cd96fed7a1dd@sifive.com>
Date: Thu, 1 Aug 2024 12:32:28 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -fixes] riscv: Re-introduce global icache flush in
 patch_text_XXX()
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20240730135921.156508-1-alexghiti@rivosinc.com>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Andy Chiu <andy.chiu@sifive.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240730135921.156508-1-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Alex,

On 2024-07-30 8:59 AM, Alexandre Ghiti wrote:
> commit edf2d546bfd6 ("riscv: patch: Flush the icache right after
> patching to avoid illegal insns") mistakenly removed the global icache
> flush in patch_text_nosync() and patch_text_set_nosync() functions, so
> reintroduce them.
> 
> Fixes: edf2d546bfd6 ("riscv: patch: Flush the icache right after patching to avoid illegal insns")
> Reported-by: Samuel Holland <samuel.holland@sifive.com>
> Closes: https://lore.kernel.org/linux-riscv/CAHVXubh8Adb4=-vN4cSh0FrZ16TeOKJbLj4AF09QC241bRk1Jg@mail.gmail.com/T/#m800757c26f72a1d45c240cb815650430166c82ea

Shouldn't this use the permalink for the specific message, not the thread?

> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/kernel/patch.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> index ab03732d06c4..91edfd764ed9 100644
> --- a/arch/riscv/kernel/patch.c
> +++ b/arch/riscv/kernel/patch.c
> @@ -205,6 +205,9 @@ int patch_text_set_nosync(void *addr, u8 c, size_t len)
>  
>  	ret = patch_insn_set(tp, c, len);
>  
> +	if (!ret)
> +		flush_icache_range((uintptr_t)tp, (uintptr_t)tp + len);

This patch was based on an old tree from before
https://git.kernel.org/riscv/c/47742484ee16 removed the "tp" variable. While it
still compiles because flush_icache_range() is a macro that discards its
arguments, it will be confusing to anyone reading the code.

Regards,
Samuel

> +
>  	return ret;
>  }
>  NOKPROBE_SYMBOL(patch_text_set_nosync);
> @@ -237,6 +240,9 @@ int patch_text_nosync(void *addr, const void *insns, size_t len)
>  
>  	ret = patch_insn_write(tp, insns, len);
>  
> +	if (!ret)
> +		flush_icache_range((uintptr_t) tp, (uintptr_t) tp + len);
> +
>  	return ret;
>  }
>  NOKPROBE_SYMBOL(patch_text_nosync);


