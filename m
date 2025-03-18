Return-Path: <linux-kernel+bounces-566124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C66A9A67384
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0438175056
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD7220AF88;
	Tue, 18 Mar 2025 12:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grvNgoci"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F13290F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 12:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742299786; cv=none; b=O/akVsehOR0nhq+4Y0qlw/FCywx+lF9iwr10Jhq2kXZYlQe0U0vnT2ZW7lnp5wS6w/ZEqGU97gaV1W2TfBfoeSGvo4Iv3p95Or4Tlsf55i7kFJ8Oaa7tnDzEPApMVsbtu7pVX4cnf9BUlyvRaT/N7+rjwYCWHlN476LX3sSZ4sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742299786; c=relaxed/simple;
	bh=uGHNU2DsP84xRwgi4w1ID/9AeHuJu963tJNjfb4DVzY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=qKfRCtTUO0CpSpM2H8rId+8+2zdlf19beHANxovVrq2pPj2FLwo+4iKoPN3cWqNJoKfZCM6CPduabbbdWUVOtTm3m9OmWquvv4raNh0k5w5E4QxBVM59Fl8np4SDxAqXFnYQzIxVDjW8frWf7vn/SHWH3NL/acGuxWr+8NYYuag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grvNgoci; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3fea67e64caso241771b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 05:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742299783; x=1742904583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uGHNU2DsP84xRwgi4w1ID/9AeHuJu963tJNjfb4DVzY=;
        b=grvNgociWiokoO9+EwxWkAD39OnshnM/Xruze0R8XqGOA1aicinw3M5jw+gCpcsGLH
         +B5tt8cbGUzdjaHDTNnZTKKQNJJhzAdrw3yCjq7sSadw/9Cmb9R2q0nPWtvKm1KaQn0B
         XL3gwnrtEmAFkzDL38gQBrmy1JpZl8TfyVE/oge2nT+5dUSwLUHhTALbWDGSSO1sRJwS
         UAo5hWDSPxGM3E4tI6f+OAFb2y5LtC1xX72SBOX4axbTmtNPz3ANcEKgLSeS0rY3q97m
         1u4XD2fXV5cK2JdFkmYCuotZmtxevm9rvuvLUIn+BQe5M2vnwH3oh25vhMHcPuCzgxap
         7l3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742299783; x=1742904583;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uGHNU2DsP84xRwgi4w1ID/9AeHuJu963tJNjfb4DVzY=;
        b=WmsVqPSdB38yIFItpNMzkNGK/PeBiPF55Ng6IJfcRxIVC8gJLJJoKpbSQZl6o0iYfc
         tkJyI3IkannbeB2g+Nfdie3/K1vNC+hdxeKgwRjIY/ADXLwGpBbDRDW5+IV9VSzDBkP8
         N/7e/Rb3/NVTOdGbAxvg+6yV4Ch4oJjgtCcGUc/Y3sjK1K7tVE5ql+hB7rRiKy1eOzai
         GSyii3B0LEzytc4lFjPs6HLRkR16PJkGgCn5C0e3UMLgNM6fWJ2JRCrDbeT+w9C+v65Q
         3fdkaIExSw0/2LaNkz7tZYA3+oXDmAlEm5et1qVJuqDhJOM2rYXbNYIu+XN3ZtZsWSup
         D2yg==
X-Forwarded-Encrypted: i=1; AJvYcCVOe3ciG6k3xYQbeZWM0QtOJDBMR4taJ9Zvog7ApzcgY6rhtGaX8sNdLxonC/aMDOMK91tEHd0qpYuoRnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEQ/3wGeexujgWRQgEW/OCGH7cPRG1vhyte7ePIiTlZ2hwyK+O
	Z7Pd5UggeNSmafxqyFpJ+/CNPh8RMK5ezaA68ADdDFNWOchisqBo
X-Gm-Gg: ASbGncsCWt8c4zogLuV4E+o2p4pcn8atkspayLL1F0pGj8H+QBlF2zaZ4ZW7LSQGYtD
	2MNzGWdkrHM3QPMeZnN4ePPjvmZ2/AKg5YoOR7dspJ5awjLrzBIEHFoYWP04Y+GCjgqWsl0/QLF
	BQwkgrH/0QBBZ3brKil1Jb5X9Z3HlTYhAMmeM2L3jO7Uekf1jwl6uVVqNRiY98LCAmeR76hEAHl
	dwAGFxJXtqFWfYQ/K1FkOFnYsxMsDAeeBAwUQSK3FIgocnY//Fkz5UbVIUZhRwqxuIs+VoQgq3E
	714/y/od/yjQZ2rIDqq85QiJ1TzFZRAb7XkHVgtZ4gHMxDmnbdhxhkM8ARXohhfAVs/GNpAt4uL
	ss8c790D+KkbyTP+3buXaAXeuf6wmFZej
X-Google-Smtp-Source: AGHT+IEW78k9wNth5JPTc3R5dsmjV5XBvdSNHd8lJmrl6+l1LE2JxmLVQBK59fJRMKBk9FFdWIUX/g==
X-Received: by 2002:a05:6808:1b22:b0:3fc:105c:430 with SMTP id 5614622812f47-3fdf08346a4mr9692684b6e.39.1742299783614;
        Tue, 18 Mar 2025 05:09:43 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:dff5:4180:2562:4c1e? ([2603:8080:7400:36da:dff5:4180:2562:4c1e])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-601db67bc6csm1998224eaf.12.2025.03.18.05.09.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 05:09:42 -0700 (PDT)
Message-ID: <cd304874-9782-4213-adb6-f27e5e699355@gmail.com>
Date: Tue, 18 Mar 2025 07:09:41 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] panic: reduce CPU consumption when finished handling panic
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
To: pmladek@suse.com, Andrew Morton <akpm@linux-foundation.org>,
 jani.nikula@intel.com, open list <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, takakura@valinux.co.jp,
 john.ogness@linutronix.de
References: <f2272f04-510e-4c92-be5e-fedcbb445eb0@gmail.com>
Content-Language: en-US
Cc: jglauber@digitalocean.com
In-Reply-To: <f2272f04-510e-4c92-be5e-fedcbb445eb0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

+CCed Jan Glauber as he'd figure as Co-developed-by if this goes through.

Thanks,

Carlos


On 3/17/25 17:01, Carlos Bilbao wrote:
> After the kernel has finished handling a panic, it enters a busy-wait loop.
> But, this unnecessarily consumes CPU power and electricity. Plus, in VMs,
> this negatively impacts the throughput of other VM guests running on the
> same hypervisor.
>
> I propose introducing a function cpu_halt_end_panic() to halt the CPU
> during this state while still allowing interrupts to be processed. See my
> commit below.
>
> Thanks in advance!
>
> Signed-off-by: Carlos Bilbao <carlos.bilbao@kernel.org>
> ---
>  kernel/panic.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/panic.c b/kernel/panic.c
> index fbc59b3b64d0..c00ccaa698d5 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -276,6 +276,21 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
>          crash_smp_send_stop();
>  }
>  
> +static void cpu_halt_end_panic(void)
> +{
> +#ifdef CONFIG_X86
> +    native_safe_halt();
> +#elif defined(CONFIG_ARM)
> +    cpu_do_idle();
> +#else
> +    /*
> +     * Default to a simple busy-wait if no architecture-specific halt is
> +     * defined above
> +     */
> +    mdelay(PANIC_TIMER_STEP);
> +#endif
> +}
> +
>  /**
>   *    panic - halt the system
>   *    @fmt: The text string to print
> @@ -474,7 +489,7 @@ void panic(const char *fmt, ...)
>              i += panic_blink(state ^= 1);
>              i_next = i + 3600 / PANIC_BLINK_SPD;
>          }
> -        mdelay(PANIC_TIMER_STEP);
> +        cpu_halt_end_panic();
>      }
>  }
>  

