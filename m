Return-Path: <linux-kernel+bounces-287994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 969E2952F68
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E5B61F27482
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 13:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D916B18D627;
	Thu, 15 Aug 2024 13:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PzAHX10Y"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787257DA78
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 13:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723728739; cv=none; b=KMS1rpNguRjya8kx4YTnKeTaXlcUm7pj2tgQB7avBElVzRfDPtcfR9N9++lWct2fxEjuHfPP2dKdVj+TNi923UROc4+MYXcX/5eTD3i6XYt1I/COFvtJFJwbJg5Nj9/WHdicEtM2VVvSIC7ZTKKAMXWjHAVbIp2lB83n4EhzFNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723728739; c=relaxed/simple;
	bh=/TAmiKj3TJje3yEkw53SwjfDuWFvKzp/CRga5BntAgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EWuLWodh1xkhNEH+Q0E9CUkz246eo9qYLpNzV78h7tLiXMPWEDu9PCj5BFM/9UIPMG3hFf0rKcZVVR2tsXZfd/qLrdCrEl06ISBL3pyvHv1Ude5Cy9GecaX4cla5N3aeRc4mdQK3GsynxnSdn9Du/qbSaSW2y0DAGKxxlxIKDis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=PzAHX10Y; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-39834949f27so3644185ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 06:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1723728736; x=1724333536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c90FMbGqmHJsy39PbcUXujyRxpEVVDaAYWfFKvTYmOY=;
        b=PzAHX10YbLjMSQ+XqMirIUrmQCFThCuzNA6eZ8csmNN+qtOdjhwA+NswR0fXVQ2Ecv
         +v+SMgSHu9OsqutsDZU15wqV6sHBFq9gSOQyamO/4YnRHlwPiyMY2QSC9VFjHGA4NYCR
         usNuc+5gINgxQs4/y2pSBkTROR5WOKS7ZF2F2sjahHib+9dSDliuckbNChr3JGQ2bYSD
         tWK1smLza+yZB7P5F9UkptdXBXNQCa5IajArubQIM4tYj/x+LkJDToWL6MFIocl8fGPU
         rpk9jJcw0jp43XtHTUz4uNDmPYg1T+jLk8Gc2w/QcREjQilRCYyO4FJ+quToFBizZc0k
         A3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723728736; x=1724333536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c90FMbGqmHJsy39PbcUXujyRxpEVVDaAYWfFKvTYmOY=;
        b=Oed0y/U6TvKZkYgqhc0SzDp373YyFEpZ79a8E+gN8s1mMR9MKjHnBQSNiJkGcqFH/J
         PzyCi/avBkt3lDg3OHon5y3Ve+6bomLwNq35DkneVymZQjjq9rxD2uSBcQ8Z1HfGNDus
         h5dJ8v4LF3iRRFJBADhn3mIXNto8OJZdEu8dC2S7uSTQRiw9hMeHjjnHAFeoWXJfYpLk
         bvoA8/z1rrRriIZJCsaCXc+FI3hjDMcoAsO1oFrMzkglTph/j1TPARMFVTyfc7mhNCQe
         ttkAeaFo8ypnBW7JM9gj/YE/NjukcGr50tY1+HebXk4XB/Yxu1hAYRtqTdYDCp2f/nwJ
         ymiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpTLCbVlz3tgR30ui9HXkwnGPFRt9YlBPtqd1FDVh5M7VElayWqr8OGwwm25OARNfPo6s9qOmF6nj5XlOCPIoQ/PklutAio2W6MvKD
X-Gm-Message-State: AOJu0YxOvUJsHgqSZHdPYABB1HEBHehEQNuZyRCAY/Cy14FF7VeYDL7u
	ZwvH4F0AuS5BY5L9KM0c/dfpnj9Xcx+ayqCMOeDvtnZm2kQlv3BuVsoBbdmxB9g=
X-Google-Smtp-Source: AGHT+IHI7UfNjjro7QbfS9BfRNW6H3aTBH/ngYckglkBrk5LzBa9PTiRaSVPXPfCdh4Pdsz1Ab81yg==
X-Received: by 2002:a05:6e02:1808:b0:375:dc39:cfd2 with SMTP id e9e14a558f8ab-39d1245483amr76389715ab.11.1723728736498;
        Thu, 15 Aug 2024 06:32:16 -0700 (PDT)
Received: from [100.64.0.1] ([147.124.94.167])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39d1ec03005sm5645905ab.28.2024.08.15.06.32.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 06:32:16 -0700 (PDT)
Message-ID: <686d61c4-e7ac-4dca-a7fd-decdd72e84d9@sifive.com>
Date: Thu, 15 Aug 2024 08:32:13 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/9] Fix Allwinner D1 boot regression
To: Thomas Gleixner <tglx@linutronix.de>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 Anup Patel <apatel@ventanamicro.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
References: <20240814145642.344485-1-emil.renner.berthing@canonical.com>
 <87jzgjnh9z.ffs@tglx>
 <CAJM55Z8WERQgs=QMyFGWvAHOpwcnOAudBqovaEuDudPSXCvL5Q@mail.gmail.com>
 <87ttfmm2ns.ffs@tglx>
 <CAJM55Z88H635Crc-Aeq+K0qcAk7NC89WVTAFdXDd2aQKQ7QmEg@mail.gmail.com>
 <CAJM55Z_qQX7n8tAeOFqrAH1BFjA9vaWA8rtsPG2BcKmiO88m=Q@mail.gmail.com>
 <87plqalyd4.ffs@tglx>
Content-Language: en-US
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <87plqalyd4.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Thomas, Emil,

On 2024-08-15 8:16 AM, Thomas Gleixner wrote:
> On Thu, Aug 15 2024 at 05:14, Emil Renner Berthing wrote:
>> Emil Renner Berthing wrote:
>>> 6.11-rc3 + these reverts:  https://us01.z.antigena.com/l/Er4kZWDmvL5-bLzHHJoZv0k71iwW2jCD5qNpiz0x0XdYY6oORF_nXh7U7jw6oubhi~32HI4i71jUW9v8~NvSvPeUWrdYx3WJBr2GPDUjOu6LYPCOBfR2dVQuMWvlNj4tDjXFp3QEQAmeawZflD4JrIJjtSYIbKfe6v-tgH7SEuHMeSSriU633Lv 
>>> 6.11-rc3 + Samuel's patch: https://us01.z.antigena.com/l/EULtAYky6ZvgqZ49KGS-WBsYTg~Ht1NoQtEYmUVb56ymS9jDagqYHLK90WDjnVt69GfB4IX5NSRQXmSfkNsTzB8lJmFvDihHQmGrsCv9FzlorD9yGfXDlQ6rG6vmn5BNDwlipmssGaOGfh9yko8n9ArWR4TLhEf~f9ODqme~NXXwA9DLLc9p 
>>
>> I think this confirms what Charlie found here:
>> https://lore.kernel.org/linux-riscv/ZoydV7vad5JWIcZb@ghost/
> 
> Yes. So the riscv timer is not working on this thing or it stops
> somehow.

That's correct. With the (firmware) devicetree that Emil is using, the OpenSBI
firmware does not have a timer device, so it does not expose the (optional[1])
SBI time extension, and sbi_set_timer() does nothing.

I wrote a patch (not submitted) to skip registering riscv_clock_event when the
SBI time extension is unavailable, but this doesn't fully solve the issue
either, because then we have no clockevent at all when
check_unaligned_access_all_cpus() is called.

How early in the boot process are we "required" to have a functional clockevent?
Do we need to refactor check_unaligned_access_all_cpus() so it works on systems
where the only clockevent is provided by a platform device?

Regards,
Samuel

[1] https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/src/intro.adoc

> Can you apply the debug patch below and check whether you see the
> 'J: ....' output at all and if so whether it stops at some point.
> 
> Thanks,
> 
>         tglx
> 
> ---
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -2459,6 +2459,9 @@ static void run_local_timers(void)
>  {
>  	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_LOCAL]);
>  
> +	if (!(jiffies & 0xFF))
> +		pr_info("J: %lx\n", jiffies);
> +
>  	hrtimer_run_queues();
>  
>  	for (int i = 0; i < NR_BASES; i++, base++) {
> 
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 


