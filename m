Return-Path: <linux-kernel+bounces-206447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDD69009DC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D9C7288BA7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 16:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8785E199E8D;
	Fri,  7 Jun 2024 16:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fGAkLpvV"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9D4199234
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 16:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717776190; cv=none; b=H/csInGDvqnrqI8A+QYlKnT5EPj6h4ADIF/oLVYuXNOOcNC5YMP/MI4ehFCbItIrGpPLkPVZuTiBNOG7FOPA5saS+Y+ug+jpDWExrl00Xnik/GqSz5WD4+cX+lYI90m4YXu/lNsYGDqYq7ggut0fMEoaC+8xigbsZ7iYraKYg0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717776190; c=relaxed/simple;
	bh=xlgOpuS/A5Kz53/GQF3LeAz0uLtEN/bOkSTX4DhgimM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l+ngaCnPFSvADsoJNXfqrU+vkUzS3q68Z/JRorXirivho4L16HS/Q/0+BWBTOl/GdG0qfTKtwCNyHkOY8/YJb0FF0NZ+7PSn+pX+b9yQZTQLWJ9mMXrEL8Dyis+jEabSOoxhlFlt/2+0H3AgOYJ9MGsR7JeP/EGZsaJAb3ZV1RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fGAkLpvV; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7953110482aso143304385a.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 09:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717776186; x=1718380986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5HjrqfjoancIL7kR24mNO8YF+vCoL3WsNLPn7C0tdzM=;
        b=fGAkLpvVyjKK1FlWyJhO2IQiUNGJFAPSI5oDRtM3ArQs95SeG1ibKM9l7BblR2YtPT
         EB6ocy1Gj51JwPJ2hBadRLTn2BcWpOUOe3iQu2PMOdn90Z5QtQFaLYL/ac4vqFpfpvWF
         f/2Ia1rBuIPmALUExzftweqvspIZQaiX3WgME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717776186; x=1718380986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5HjrqfjoancIL7kR24mNO8YF+vCoL3WsNLPn7C0tdzM=;
        b=Yj1vYAksuT9v61VrGzCnII3X9wYoWNr1Jp6uvGXXsQVvb0oCTdtYqs59ovE9YahfK7
         2ADqM8kXB11e0a8Pvwq/mdqLwEXdKjpryK8N9mYCdIn6cQuYN5DvZVh7Sq4EhBBlejhI
         1IJDQuCtfO8SkapN8x+XyxBhrc8IPdSNF8IbhX0r3gDM558fp8dVIZuAkXwY8tEj86ZL
         Iz9ukFA5qK2pY+5/p0TlfzNGUupgbnYy6e4ohugwJhtHBjgfXtzulZR7UopaSH79VKb4
         f8SbbED7CVlGwBmjUea8+K+amnURAwJjMwq+I958LqjYlGnXt6HLolXdYc76c+19PWzR
         OMIw==
X-Forwarded-Encrypted: i=1; AJvYcCXDuCe/HpgHT6CyWTU/7wUJUzAWd4G84ObpKt9za31DlaCc9E0we9c0bemtG+3BKq15wjbSNo6wDR5VmeQdMMApQ+7qfKVXe47a9j+9
X-Gm-Message-State: AOJu0YyIZAbQoQ5w753+P4KbMXGgtZ3UpOF8R5aQBhaNWm2TOM0O5Wvz
	nD2AIVRIL66E8ev5rHaBoz97YGVljTWAuey0XIjVMLbb7lwe11MlMQE5gQtydMnDD995snni4nc
	=
X-Google-Smtp-Source: AGHT+IEFNdC0WSyjqPEnS47CpiFz30BufbDi+G3wCrEuosrI3N8ClS2qPBeoQyyIr1d9YjmVKqXxig==
X-Received: by 2002:a05:620a:459e:b0:795:4fdd:675f with SMTP id af79cd13be357-7954fdd68d6mr76505185a.77.1717776185952;
        Fri, 07 Jun 2024 09:03:05 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7954de1c077sm29677385a.48.2024.06.07.09.03.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 09:03:04 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-44036ce0adaso406451cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 09:03:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX+FtqsbGI3WO+ZN2OTwkPuYr3gTtTbfa23tyVoxVRuVrFaLQFRRaFBVTqFkqWB2x2RJPalqq6jdwjDFcfndv5YH4anF+UsUNEiVK1f
X-Received: by 2002:a05:622a:510e:b0:43f:f54d:8a6d with SMTP id
 d75a77b69052e-4403721b6ecmr9997161cf.4.1717776183734; Fri, 07 Jun 2024
 09:03:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607074716.4068975-1-ruanjinjie@huawei.com>
In-Reply-To: <20240607074716.4068975-1-ruanjinjie@huawei.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 7 Jun 2024 09:02:47 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W6Y+sUcOZ02DrsNDAkd2eOJ8VAC_ke04gOO6s5OgMvzw@mail.gmail.com>
Message-ID: <CAD=FV=W6Y+sUcOZ02DrsNDAkd2eOJ8VAC_ke04gOO6s5OgMvzw@mail.gmail.com>
Subject: Re: [PATCH] arm64: smp: Fix missing IPI statistics
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
	swboyd@chromium.org, sumit.garg@linaro.org, frederic@kernel.org, 
	scott@os.amperecomputing.com, misono.tomohiro@fujitsu.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 7, 2024 at 12:45=E2=80=AFAM Jinjie Ruan <ruanjinjie@huawei.com>=
 wrote:
>
> commit 83cfac95c018 ("genirq: Allow interrupts to be excluded from
> /proc/interrupts") is to avoid IPIs appear twice in /proc/interrupts.
> But the commit 331a1b3a836c ("arm64: smp: Add arch support for backtrace
> using pseudo-NMI") and commit 2f5cd0c7ffde("arm64: kgdb: Implement
> kgdb_roundup_cpus() to enable pseudo-NMI roundup") set CPU_BACKTRACE and
> KGDB_ROUNDUP IPIs "IRQ_HIDDEN" flag but not show them in
> arch_show_interrupts(), which cause the interrupt kstat_irqs accounting
> is missing in display.
>
> Fixes: 331a1b3a836c ("arm64: smp: Add arch support for backtrace using ps=
eudo-NMI")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  arch/arm64/kernel/smp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

While I won't object to your patch if everyone agrees that we want it,
fully excluding "cpu backtrace" and "kgdb roundup" from
/proc/interrupts was more of a design decision than a bug. Those two
IPIs are really special cases and not something that I'd expect anyone
to care about knowing the count of. Keeping them out of
"/proc/interrupts" just avoids noise. I'd also note that I believe
arm32 makes the same design choice for "cpu backtrace".

In any case, if we truly think people want the count of these IPIs
then it feels like we should report them in arch_show_interrupts()
where we can give them a nice string.

-Doug

