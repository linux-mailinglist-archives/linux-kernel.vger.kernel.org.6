Return-Path: <linux-kernel+bounces-332750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA4497BE5B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 17:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 482FAB2207B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D92F1C8FBB;
	Wed, 18 Sep 2024 15:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u8Dv+xMf"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49901C3F1E
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 15:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726671888; cv=none; b=NeuIwDhrSXgb2+20hRqcOO7SvA/gVcp67HOmNl7tM7x3/LHqSQdQukdhOGE5OyyrzvqLyzMBfnyZLuVv+Vw0qXTZnWVXN0Xwa2KQgcdXiNU3xyvVojrd/bgqYfbgPQoyRt85DBxm/Swx0ExrRdf13SoexJnXUYM8ORapQ252QEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726671888; c=relaxed/simple;
	bh=L1NHWyy0NjF2dTP/ARc8BHAy85ATCfvirgTS6lcHILE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pxy/Q6HYW0rK8sfaKHJfe/V5gBHdKVQPGEyfL5HPpCah2HK0RQt45pT3BVAZy4wFuXANGxoVZBylcjMr6tADHVR/3ecvJ4f9x0DApGn4YkimjWoOw8mF2SlnWnpzEYcEMHfn7MP0d9Kpu3zIfP9T0QmNsIrevEqiRK+IG7P65pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u8Dv+xMf; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8a837cec81so402997966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 08:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726671885; x=1727276685; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rAUj5z86FV+d6rAd4UOajymFlz61iSG2wpZ0JHsQ42s=;
        b=u8Dv+xMf99nDwj/LZ89SRX6Xtt13al6gnFfD0R/U3FVBL1KkmkDugiCKEYXojPa7mr
         G1ZIW3zCHcawyA+3x1oDERVpGMRdV2PTp/jJsxAJMOKH4w8/3msA9R6L7BbSw1DP5J1g
         v6Y73KwvrQNac5MjcFyzVQShlLqBlyyfQnJPhOXkwDbMJJA5wjcFCQueLQrqDtrGsutT
         Luj3xbjdcH30wbUxn0XXmxUAfC/R4EFK4KGBlK9tlH2caOOLqlf8nDdg+YIN2j8xhD8f
         zdRJ09fs1H+2CSEpdxtpgWYghSZjaZISIqkEr2UlS/85RWDr6nPzdwPNIEK2l5LN+R26
         bG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726671885; x=1727276685;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rAUj5z86FV+d6rAd4UOajymFlz61iSG2wpZ0JHsQ42s=;
        b=M8Sp5/YoFLCk3eIjt4bMIGBk7znMiDvZO0NqTm+Sut7kXKhGO8zQk80eUIkwxHPtuA
         VH72I7MSZjjENuJB8SHvC6ExsT/pqnU3Kwt619PPfZ/wyRbcOM+aUd8rkYbnje+zCvHI
         cG3wYQOh54a4a2JOxQdogZ5kAFpowGMpVQv8jl3G5luxu1G6/6Q7xrv7caBtxRUKW7Hn
         5P8mNGmAx7VMDpefTUnK0EJQDkUx55WYw8ul9vs8tcnTJD6pV7AUutw5pLPw2ZF+koew
         9Tx/rdyz2cTrZB2n/O+uoOZ4USFwWGATEMYAzEGM3202UMiZVXAbOrkOcZk8lVFX0IQf
         jmqg==
X-Forwarded-Encrypted: i=1; AJvYcCUzQPIDoaJKd1/SBUewYMss+zlUdh+Tg0EIuF72KxZlFiUcLOeabWTpJIeVBslIW7tT8Q0jIeyHe/nF/NQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7mWUNJr/V2M4lOuFRgOzVeipvNl1MwVOuJK92bG9+eMjwRQCI
	8H5gghb+PqhvaBCSbu/fptRaO9ecdQyIMYh1ez6Q6Hz7zPvoAT7GjCdD74pov/RPkKY0OELILfX
	dm17OtgvkMh2C7foE8Pd+zvhl1EbRERDil7mkP4wCuVXs2ogwaRw=
X-Google-Smtp-Source: AGHT+IGEa1MCEaD0bdULC6b+TJ4wo1e1Num6uxETKpo/Rg0Pz+70M8LeHhF+ZrzyZIixLx67E+kqWhsRXxF1Divl44g=
X-Received: by 2002:a05:6402:5108:b0:5c2:6311:c9d1 with SMTP id
 4fb4d7f45d1cf-5c41e1b5325mr25680316a12.22.1726671885023; Wed, 18 Sep 2024
 08:04:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909095529.2325103-1-marcin.juszkiewicz@linaro.org>
In-Reply-To: <20240909095529.2325103-1-marcin.juszkiewicz@linaro.org>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Wed, 18 Sep 2024 20:34:32 +0530
Message-ID: <CAKohpokMUqaMUJaSfdyY39idmh_ycYj+hi5sMSBmZV1CQ511qA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: use proper units for frequency
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Sept 2024 at 15:25, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> When I booted my RK3588 based system I noticed that cpufreq complained
> about system clock:
>
> [  +0.007211] cpufreq: cpufreq_online: CPU0: Running at unlisted initial frequency: 816000 KHz, changing to: 1008000 KHz
>
> Then I realized that unit is displayed wrong: "KHz" instead of "kHz".
>
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 04fc786dd2c0..76da29c2bd3f 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1539,7 +1539,7 @@ static int cpufreq_online(unsigned int cpu)
>                          * frequency for longer duration. Hence, a BUG_ON().
>                          */
>                         BUG_ON(ret);
> -                       pr_info("%s: CPU%d: Running at unlisted initial frequency: %u KHz, changing to: %u KHz\n",
> +                       pr_info("%s: CPU%d: Running at unlisted initial frequency: %u kHz, changing to: %u kHz\n",
>                                 __func__, policy->cpu, old_freq, policy->cur);
>                 }
>         }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

