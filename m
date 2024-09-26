Return-Path: <linux-kernel+bounces-340258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA81987095
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5388A283558
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00651ABECE;
	Thu, 26 Sep 2024 09:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="o38Hv11o"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DFE482EB
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 09:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727344038; cv=none; b=mLbyvYtCgPlUu5SxhtgbqeN+jOGZnI29KQxdtQa2ey4uIG4I9USqCONwHGMEkxTU7KEyqo7gGQ81oBdcNXuU7Yeuc2AJ64MUgBPtvb3dsAU/dv0zv/ebJpC9y2gOnQ9COEuv1e8pO8opwSWg0+u4rh+PW0wFYHe0DC3y0b8OwOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727344038; c=relaxed/simple;
	bh=Kq5R389tQQ2B78EwGqSvI9hBK+iAe4QHQG9BhsNCVws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mKcRFKYv2NkVrHmw7tbwAHr1rQ0DOSRtlT1HQcMJG+Zg88jPC8khChsta/VQkAi794nUESarOvxNnPGCxjDucLST1hH2J5WmfsIIYFJemJ0KLV26TXlktFlNtk5I1q7CDWGYsUh0CjcYcnAznMg+rzuaq/IOMyB0o2Ipye38kbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=o38Hv11o; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cb806623eso6221275e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 02:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1727344035; x=1727948835; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/LSQ02N1RzZQqc2enuj2Tvq1BwqNOjenbSCTfQ1lHxM=;
        b=o38Hv11opbvbhMmYxVQb6mg81eEEPLyRBJ7A8+P5vUaxBDyAIqJhsCvYTOpEZbY/OL
         3DeeJiFR+3yT/GR8HG9GoQZ+8iuJamcdsIX043hrGpbzKuNKjYV1WdD6gkJtS05pjLGV
         VX/6537l3Mr+bTktSizIKHGwjhEJ5walhE6pKuLaTNx7wu4mwlynZYAtdjIPr2XFXwU4
         gR4gkdf7d/niFBu/216Azy7WpVBC7F00EsjetWvtrykXjseXrRHbaXHNL0BNDY9lLi9I
         klI09bOL0NFUvjCzhNeJv8OYDebMcRUfK48c2Sfzsta4/46rxVlMnwGfzWrey5gqWyjb
         UNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727344035; x=1727948835;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LSQ02N1RzZQqc2enuj2Tvq1BwqNOjenbSCTfQ1lHxM=;
        b=wGyM6x57JW/j+ebokJBi9XrMKfK7CftzOMQzH0zCfxBKyT2N1Z8+XdTp027AeV2snC
         dELwIl6iFTSJltdz3I+IkbI9RYALik8a4KQyoO05yRxYjQ/BJZsANJD05xyLCNA54Bz8
         7t4G1D/FgTGQhIEcexpYP120fSD4DG3PfVI1hbPWydZSWURxgX5TF3+rICH7+XGc+Iv4
         PmIhF3sUIBO+0m0QkFxCPBGGBcHtLvQ8a1jVF/oReuZTtGA7F39lP2m1RN58dOznN1Vb
         p2z4t7oCmT+CPlaQsU+3tWlQ0inKn2p9TOK6krwqFNBpGfaokyieg8wR1zna2qvdRkCI
         xvMg==
X-Forwarded-Encrypted: i=1; AJvYcCUonY4A7dJPYLhm6WTRgpHjwSDAq9qJCIT52iqliEFQBDk2o8vMyWvl3My1p65wJKkmC55gKl/giT6XvZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc5RuhTRjPiryn1ZL02LBTg4XGRClW5QQZ4jK3CO0R9UtTvSZ+
	XsWQHndZReeRmLH+VZq19yWcfHv6fN0VYeQdLcs1YNeGvU0yAT6K0GeGQOR9128=
X-Google-Smtp-Source: AGHT+IE3qgHzuWsAu9qO4coJy5+IsI0h/T+zUZ764Cb+dgkVLEukEcIucL3ssR2DiXM47S3CNpjY2w==
X-Received: by 2002:a05:600c:468a:b0:42c:b950:680a with SMTP id 5b1f17b1804b1-42e96119222mr43160685e9.20.1727344034778;
        Thu, 26 Sep 2024 02:47:14 -0700 (PDT)
Received: from localhost (cst2-173-13.cust.vodafone.cz. [31.30.173.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969ddad1sm41992855e9.9.2024.09.26.02.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 02:47:14 -0700 (PDT)
Date: Thu, 26 Sep 2024 11:47:11 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Nick Hu <nick.hu@sifive.com>
Cc: greentime.hu@sifive.com, zong.li@sifive.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Pavel Machek <pavel@ucw.cz>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Anup Patel <anup@brainfault.org>, 
	Mayuresh Chitale <mchitale@ventanamicro.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Atish Patra <atishp@rivosinc.com>, Samuel Holland <samuel.holland@sifive.com>, 
	Samuel Ortiz <sameo@rivosinc.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 3/3] clocksource/drivers/timer-riscv: Stop stimecmp
 when cpu hotplug
Message-ID: <20240926-b0d87e489410fd9f83796a71@orel>
References: <20240926065422.226518-1-nick.hu@sifive.com>
 <20240926065422.226518-4-nick.hu@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926065422.226518-4-nick.hu@sifive.com>

On Thu, Sep 26, 2024 at 02:54:18PM GMT, Nick Hu wrote:
> Stop the stimecmp when the cpu is going to be off otherwise the timer
> stimecmp register while cpu non retention suspend.

This commit message seems to be missing some words. The comment below
reads much better.

Thanks,
drew

> 
> Suggested-by: Anup Patel <anup@brainfault.org>
> Link: https://lore.kernel.org/lkml/20240829033904.477200-3-nick.hu@sifive.com/T/#u
> Signed-off-by: Nick Hu <nick.hu@sifive.com>
> ---
>  drivers/clocksource/timer-riscv.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> index 48ce50c5f5e6..166dee14e46b 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -127,6 +127,12 @@ static int riscv_timer_starting_cpu(unsigned int cpu)
>  static int riscv_timer_dying_cpu(unsigned int cpu)
>  {
>  	disable_percpu_irq(riscv_clock_event_irq);
> +	/*
> +	 * Stop the timer when the cpu is going to be offline otherwise
> +	 * the timer interrupt may be pending while performing power-down.
> +	 */
> +	riscv_clock_event_stop();
> +
>  	return 0;
>  }
>  
> -- 
> 2.34.1
> 

