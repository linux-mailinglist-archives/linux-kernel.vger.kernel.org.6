Return-Path: <linux-kernel+bounces-207978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2E2901EAC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EDD11F2401F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3821757FD;
	Mon, 10 Jun 2024 09:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uHQXAN7f"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1BB42AA1
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 09:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718013514; cv=none; b=OK/OGDV6QTxgiL1YGJNjrkF1yfSkmJh74+60J0p6iCuZOL3wwhn68lRYaYOqHjnYkvzyIFzQQq1eT6NL8+CWhXgLgImd2TnUORDaCbTTChS9OcIkvlfBMplykHMrmat8+5WUoZmwTfBknWpRwgxMV1kAfC4iCMSwFy/9rie331A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718013514; c=relaxed/simple;
	bh=vL+e4B6rQelOhW3SQ+8ffC0Kvp6DIcq6ImI5X4iou8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iwL4WCXRAhH1tECen3m+64c5bGezsQCWo1N7x9RjjTQ36x65ivX6Z1bvAYYD74wUcJ0D4MEPUAY9AnT1ntd7S7uV2sMaqemk7r++TG30Y3kyMwDMDLpP9Gi8EOwyGjVYi8wRzyDWI5/9DcLXSrgqhFQkQ3Ep/ZRXYDFhOPem5DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uHQXAN7f; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dfa5b9274feso4696902276.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 02:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718013511; x=1718618311; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=grzyUJy9kcHXf/MxmuiGPzY3cLbCYDEM6U0m2F2h4IM=;
        b=uHQXAN7frRdgbA3LlVD4JO+xtPX4TVGBteiuvpX41wfXEM/1JfD8qCtAhOFjGRuJM+
         MeMoRift4GlGyYTyACHPeDGUYgfouH6Hh7XA9jtYmmmjGwNjmDx1RFet+bCg95KlrUtv
         llfZ7pIChiycwQI4lF0ksBiJQyCzUE7nrRYLuJVKEW2qMhBOLDc1zZO/qMUyDU+usZ2f
         SYlEXJKvYYEWKjsGqncB7/qD8zK4+mbbtL0CLpYNmsFccV5MBHXi6W2m+kxww3E9f36Y
         +YeF8snxBSshmOkf7aJOyWhTVsSpsOmCJWHh3ylYpqShHEtSqZy6GhjtUufWk5vxgTe4
         jpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718013511; x=1718618311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=grzyUJy9kcHXf/MxmuiGPzY3cLbCYDEM6U0m2F2h4IM=;
        b=tNT5myLIwcJUpcTxWdN6TfriO6bsaJMZwEnMRT+tN3Q/ai+Xcxcr10c7ZIF+mFhsS1
         yea4LNlXHwbMjvT/89CPIL3lYJU2m8H/+yMfvYHF9PKhSqdxZ+BO3m5oPv6LRhol2Awe
         fLgbnhAx3dxB8yh2QUXoj4N7yaNiOMSOa1kHoRC+QG5ny2GMT5PZ0/hccZGRwfz8EDQD
         3c5KEWzEgTLB/MlHUapzqxCK4OTWwS5a+8mXOj/0hCExOvqiqHVdLXwgTh9tltRDOXn4
         Tkc/4b+vZQfh6/FbEvJJuqHJ+JGoDI+bhbViBGXt+6c1gFT9SX08fojifmHPFYLl6eyf
         z0gw==
X-Forwarded-Encrypted: i=1; AJvYcCUOE9KUieugyDb1p19tUIZsJGgwJ+iGGMo8E67PUx05l4F/yv5/cO2R/Ix2tOQTiG+uw6nC/OsKUv0FTI0VeSoHx8E+eWcDWCB273+u
X-Gm-Message-State: AOJu0Ywnzdw2DquM+u8GVTrDw4Qjki8TayuNKW7XRHSORAWteQHJpdtS
	gOjN2MdS145YOxaAX6fkCQp1hAN7RMxY7I2c6AL7fRyvtQgWpSR7PAb6RoorZ2SRuv4wgBAiGYx
	PavQC/WX3vVLk9GbpX6NqRKR/JVqNkduvVyfiLg==
X-Google-Smtp-Source: AGHT+IHqz16v0hYO4hjfMD0/cvunbHpItzUfiQ27fnJaZcbUsv3C/XWXRPkEAzG04WgB5BXS7pQOGEiiSV3LWnxQGVs=
X-Received: by 2002:a25:7453:0:b0:df7:40de:5b72 with SMTP id
 3f1490d57ef6-dfaf66d0c5bmr7521213276.47.1718013511292; Mon, 10 Jun 2024
 02:58:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606090050.327614-1-christian.loehle@arm.com>
 <20240606090050.327614-2-christian.loehle@arm.com> <20240609224701.pc6om2o5ep6btywe@airbuntu>
In-Reply-To: <20240609224701.pc6om2o5ep6btywe@airbuntu>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 10 Jun 2024 11:57:55 +0200
Message-ID: <CAPDyKFoHc6Zcg8i-y3HxUp0=S_N2GhmKcT0w2e-NkzR498mp2Q@mail.gmail.com>
Subject: Re: [PATCH 1/6] cpuidle: teo: Increase util-threshold
To: Qais Yousef <qyousef@layalina.io>, Christian Loehle <christian.loehle@arm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rafael@kernel.org, 
	vincent.guittot@linaro.org, peterz@infradead.org, daniel.lezcano@linaro.org, 
	anna-maria@linutronix.de, kajetan.puchalski@arm.com, lukasz.luba@arm.com, 
	dietmar.eggemann@arm.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 10 Jun 2024 at 00:47, Qais Yousef <qyousef@layalina.io> wrote:
>
> On 06/06/24 10:00, Christian Loehle wrote:
> > Increase the util-threshold by a lot as it was low enough for some
> > minor load to always be active, especially on smaller CPUs.
> >
> > For small cap CPUs (Pixel6) the util threshold is as low as 1.
> > For CPUs of capacity <64 it is 0. So ensure it is at a minimum, too.
> >
> > Fixes: 9ce0f7c4bc64 ("cpuidle: teo: Introduce util-awareness")
> > Reported-by: Qais Yousef <qyousef@layalina.io>
> > Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Suggested-by: Kajetan Puchalski <kajetan.puchalski@arm.com>
> > Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> > ---
> >  drivers/cpuidle/governors/teo.c | 11 +++++------
> >  1 file changed, 5 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
> > index 7244f71c59c5..45f43e2ee02d 100644
> > --- a/drivers/cpuidle/governors/teo.c
> > +++ b/drivers/cpuidle/governors/teo.c
> > @@ -146,13 +146,11 @@
> >   * The number of bits to shift the CPU's capacity by in order to determine
> >   * the utilized threshold.
> >   *
> > - * 6 was chosen based on testing as the number that achieved the best balance
> > - * of power and performance on average.
> > - *
> >   * The resulting threshold is high enough to not be triggered by background
> > - * noise and low enough to react quickly when activity starts to ramp up.
> > + * noise.
> >   */
> > -#define UTIL_THRESHOLD_SHIFT 6
> > +#define UTIL_THRESHOLD_SHIFT 2
> > +#define UTIL_THRESHOLD_MIN 50
> >
> >  /*
> >   * The PULSE value is added to metrics when they grow and the DECAY_SHIFT value
> > @@ -671,7 +669,8 @@ static int teo_enable_device(struct cpuidle_driver *drv,
> >       int i;
> >
> >       memset(cpu_data, 0, sizeof(*cpu_data));
> > -     cpu_data->util_threshold = max_capacity >> UTIL_THRESHOLD_SHIFT;
> > +     cpu_data->util_threshold = max(UTIL_THRESHOLD_MIN,
> > +                             max_capacity >> UTIL_THRESHOLD_SHIFT);
>
> Thanks for trying to fix this. But I am afraid this is not a solution. There's
> no magic number that can truly work here - we tried. As I tried to explain
> before, a higher util value doesn't mean long idle time is unlikely. And
> blocked load can cause problems where a decay can take too long.
>
> We are following up with the suggestions I have thrown back then and we'll
> share results if anything actually works.
>
> For now, I think a revert is more appropriate. There was some perf benefit, but
> the power regressions were bad and there's no threshold value that actually
> works. The thresholding concept itself is incorrect and flawed - it seemed the
> correct thing back then, yes. But in a hindsight now it doesn't work.
>

For the record, I fully agree with the above. A revert seems to be the
best option in my opinion too.

Besides for the above reasons; when using cpuidle-psci with PSCI OSI
mode, the approach leads to disabling *all* of cluster's idle-states
too, as those aren't even visible for the teo governor. I am sure,
that was not the intent with commit 9ce0f7c4bc64.

[...]

Kind regards
Uffe

