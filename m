Return-Path: <linux-kernel+bounces-309012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6587296652C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7539B2217A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAF81B4C49;
	Fri, 30 Aug 2024 15:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JcDCZ7+Z"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52D719ABB7
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725031206; cv=none; b=r8ADTRcq16Iqdt0MoccujkPBkiBPJJwqv1UcznuOxN0HM6d/T8NAsfHSRc1o15RCSoeJueL1QJO5AImGlJQ1DzXFxXEvlj6LvmdNqPfm4bJwUqkrh+25fHKVj8j/JGJRKCmPZ+t7NXG9wAITk5XXPcCHSkMibOkqK6nETO8+/pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725031206; c=relaxed/simple;
	bh=IZVb7HUaCckefGq1d8dAOvfWHArhc/80owEl5Mr2oQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ED/1atspPw4A6t+80mIIw/26tA3SxSJ8419gWGsvihrHmonyQydbyqffNPZYuwFuffaI3qNEaGbNaxBMNhc+9KMGhUFa31QpKV3vgYBUrhVmeuI52rMAl2QCmJnu8paMyfzWv3AHNpZiN1RuQ/5NkVNapHVAPDuyvXgAZObJtC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JcDCZ7+Z; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42bbf138477so2898375e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 08:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725031203; x=1725636003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o8gDLcdemCUhQhHJ5CRUyOJRFqr6ikAul9YHR14ZnX4=;
        b=JcDCZ7+ZuSXm0WXznXgTx/q4uSZ0Z7S5HhatkuxkxpAGBa+DKo76FWjSAdZtLHZOoK
         9c45KplkwD/8RlS7hrMS0XKaylXWwxkPsk/z5FYn9P27tFoWDrEjHRsq4bkXOXPJgGSv
         fyLrO9TJ3wb/P6g+W6AlUFlPQxzZj6Hhucm6RPyhBhF+L1fDIXr0K0XyVvmUlCNGUxfh
         EZbUAKL+JTTWjwy0RdUttGtQn/PoS9/y8hPMYur0yeP8tGa+DTN1xsAw2oN7KFo0Q6VW
         MOF/A3HCpi5gzInorz7Izc/fu/egUUAjuG8ZEKLl9AjQuIxv1QHGkKyZdwCZm521Glpi
         OObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725031203; x=1725636003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8gDLcdemCUhQhHJ5CRUyOJRFqr6ikAul9YHR14ZnX4=;
        b=WIX6bxew15CT3LUBjGdVEpCeYYFNyfaBd1fR71z6VZujBXZ953KImpLNVD0Arxz9ZC
         JlyoHRa82xgGK8IoIBuIu7WbdAT0MCiKenBKhf14axZg6fFg2YFyjcygAKJxwCqO3O33
         MV220I6lh4TSDAt0UO+WdKPJ/tg74SJmdXAQyYoNjSzUa0ELG/XPH2Uro4Hhv1CeD25n
         9iYgWW1KnCXhiltHVD6A0IwbWa1vlLCIzo+S0+za0uD+diucNJKtxEFTtw0xIZp12nRD
         5tu0pvYGQKXhQZSPOXihBW1orBhlgo4UWfpXZnt9hpIvoHB747Ax+KGXZf6m1+g43czq
         t/KA==
X-Forwarded-Encrypted: i=1; AJvYcCX0lwmK6lkwoPMrUr4qYxmUoNIYlyczlfasBR0ELV1ocqdpVpS7raLxdz9hYpwTqnBQvYNBOCtacSBNB40=@vger.kernel.org
X-Gm-Message-State: AOJu0YynApj7PVgQhwc0ZjV5/M4B0NTRR7SDA4+l/Q7r7j4XMp2bWx/z
	JUONC+zTvV3Vi9z/gImVpXRg3c+oxugz9gXkZap7M+1odWVjB7//yoErcxA/0lg=
X-Google-Smtp-Source: AGHT+IGa2f7spyxbcRGnpXyEx6q7etRa1xCqAahHQAa+kiLePXz7HVlF3+WsMhp6MCjFv1+atTgi0A==
X-Received: by 2002:a05:600c:474c:b0:428:1965:450d with SMTP id 5b1f17b1804b1-42bb02a82c4mr55229275e9.17.1725031202813;
        Fri, 30 Aug 2024 08:20:02 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba642594dsm84203405e9.47.2024.08.30.08.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 08:20:02 -0700 (PDT)
Date: Fri, 30 Aug 2024 18:19:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Yu Jiaoliang <yujiaoliang@vivo.com>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1] soc: qcom: pbs: Simplify with dev_err_probe()
Message-ID: <63162b67-22ef-482f-9600-861e9dbaf4fc@stanley.mountain>
References: <20240829124813.3264437-1-yujiaoliang@vivo.com>
 <894145dc-46fb-451f-a461-d0b9ff1e50dd@kernel.org>
 <10fad15b-d2a6-4ec1-8af7-bde8f7bf39be@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10fad15b-d2a6-4ec1-8af7-bde8f7bf39be@kernel.org>

On Fri, Aug 30, 2024 at 12:03:20PM +0200, Konrad Dybcio wrote:
> On 30.08.2024 10:08 AM, Krzysztof Kozlowski wrote:
> > On 29/08/2024 14:48, Yu Jiaoliang wrote:
> >> Error handling in probe() can be a bit simpler with dev_err_probe().
> >>
> >> Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
> >> ---
> >>  drivers/soc/qcom/qcom-pbs.c | 7 +++----
> >>  1 file changed, 3 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/soc/qcom/qcom-pbs.c b/drivers/soc/qcom/qcom-pbs.c
> >> index 77a70d3d0d0b..ab9de12ec901 100644
> >> --- a/drivers/soc/qcom/qcom-pbs.c
> >> +++ b/drivers/soc/qcom/qcom-pbs.c
> >> @@ -201,10 +201,9 @@ static int qcom_pbs_probe(struct platform_device *pdev)
> >>  	}
> >>  
> >>  	ret = device_property_read_u32(pbs->dev, "reg", &val);
> >> -	if (ret < 0) {
> >> -		dev_err(pbs->dev, "Couldn't find reg, ret = %d\n", ret);
> >> -		return ret;
> >> -	}
> >> +	if (ret < 0)
> >> +		return dev_err_probe(pbs->dev, ret, "Couldn't find reg\n");
> > 
> > This cannot defer, so not much benefits. And you ignore other place in
> > the probe()... That's like a weird pattern with all your patches change
> > something irrelevant, but leave other places unchanged.
> > 
> > That's pointless and churn.
> 
> Hm, that's a good point.. Maybe the static checker folks could come up
> with a way that would find functions that call something that can defer
> at one point or another and suggest (not) using dev_err_probe with W=1/2..
> (although that is probably not going to be very high prio given all the
> other static checker issues we're still yet to resolve)
> 
> Unless we have something like that already? +CC Dan

I believe these patches are from people writing their own Coccinelle scripts to
do the conversions.  There aren't any published scripts which care one way or
the other.

device_property_read_u32() can't return -EPROBE_DEFER.  It's documented in a
comment.  So this is just a question of preferred style.  There isn't a kernel
wide preferred style on this.  Some maintainers prefer to not use dev_err_probe()
where it "doesn't make sense because ret isn't -EPROBE_DEFER".  Other maintainers
use it all the time even for error code literals like:
	return dev_err_probe(pbs->dev, -EINVAL, "invalid input.\n");
Because "it's cleaner, more uniform and only takes one line".  I think Julia
said she didn't want to get involved with this debate and I definitely don't.

There are a few things which we could do:

1) Returning -EPROBE_DEFER to an ioctl or something besides a probe()
   This is a bug right?  -EPROBE_DEFER is basically kernel internal for probe()
   functions.  It tried to write this but it was complicated so I gave up.

2) Printing an error message for -EPROBE_DEFER warnings
   I've written this check and I can test it tonight.

3) Not propagating the -EPROBE_DEFER returns
   This shouldn't be too hard to write.

Let me add a KTODO in case anyone wants to do this before I get around to it.

KTODO: write Smatch EPROBE_DEFER warnings

regards,
dan carpenter



