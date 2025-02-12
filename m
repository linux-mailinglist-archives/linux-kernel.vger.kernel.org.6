Return-Path: <linux-kernel+bounces-510988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA18BA32481
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 055F2188C692
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2ED209F49;
	Wed, 12 Feb 2025 11:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cQ4IutSq"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3622C20A5D2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739358773; cv=none; b=eodTCawEhFz067vHR1uXHoAjyrs9YMfXY0/RKVDd6eRo64lGOa/E/vu05auDrYbLY6T8UMeDjRsKGymTOdjA8alX92VMTMQ1UhEnHzZ07fOoPEYDgGvommGCU06BCIgkgb8RJyVLIhxTwJAtWwoBvRn/Lmc77+s7cUJ3WLJQRD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739358773; c=relaxed/simple;
	bh=czDBhXds2774fwZNyEeYA03Jzlh2/wYesLkUERE8+UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7056ej9HGqzjVAaY7NyJihuYC0yl+phATS+SX8VyHpdq3Gp9+LC2t4YnNwAYtFxcy7Da0gUzwVlNZZYAeLgpuvx4fYZGrlqI8KMlQtB6BMIx3lmaDSuKAj+BH3xwehBMMZik8WOfCtI+Q/AYLTsLCZpc48wxxbQTBWZ5FKV2to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cQ4IutSq; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-308f32984bdso24708101fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739358769; x=1739963569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zi7NSGVlmdukYXP2xLDE0jItD13dYbVjBU6ou/KCEC8=;
        b=cQ4IutSqVBqRUrbXKbHaw/NNLr1RNmie25Y/MVG8IodnPJSqJa1cPFbqwN103Z0JrV
         oQD/xEU3XgRSarfKrcXiX1R6KEago3ox9oIBsnI0DjB9UJsWl5sDcNop4HlLguL/G1hu
         GxTT24uzp3zZ4xPySTjF/eTz1vun4CLeFjc33jlvNrBwu6cGZBt5hl0Rt8fbjQf+H/rZ
         eUaZpg1KGuoSAJWBY++4lRaSip9zdagPjDMryJPbVXhf7eYMR4rUviwCv5HHeZUxfMTw
         0myu+Z8dFmtj8OsLAL07GSg9YY4qwgAAg4x0xyfKZRR1n/bfa4Un0GDIw6/E2zW6vQa0
         gw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739358769; x=1739963569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zi7NSGVlmdukYXP2xLDE0jItD13dYbVjBU6ou/KCEC8=;
        b=XP9GNyiaN9NR9eeq7tcMtlLNFFRPDtsseYgMLggEZbWGzSkQagvZnjzmNWixAZW8JO
         ByFYX1hihrGaLMyE7a3OpAndmyyJx0t//1wHkya9cWtj456tkNcF//nvoRzbWJKAqDTP
         AJw2/UlCkIWnVGresguIMZFN5HQIoWf5JJpL2JmoZwRFkd0pqLR0CAJvyr7/IalYupdJ
         KVQv/flwp9ZX+fuIJowJFOeV5sRWXgmInV27uptSuyLJvsTBdw7zgL0UgxuMA92rirQc
         rZrLmvbNgtRnyZsJ3vyGcIiiqUfDlf+QWmSqgZQHctO+6jT/hTUFiLx9uU4aR8Lg2JWY
         HNUg==
X-Forwarded-Encrypted: i=1; AJvYcCUNbOHZw2FiOyMjTUoDkffrXnEWBc2he0/0mf+TIhzAY3sh6oj0ss30tnoXk6EF5WDFAEgxI6k0oHGfuuA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp+SK2mync2B6BhtLjGpEd2qEP/faiamaNY+gYqYtzu/EOjiXd
	tuHCrh7wTGfM6YNorNFMcIivvLjtkstQ5ZCwb+td+cXPObwXjTXemqxjhxDuFqE=
X-Gm-Gg: ASbGncurwSNnFziVyeuASWpqXrQ5oeLDZPuSpbAdpFk9G4lTZTkBStsxNCJ6b4mF0TM
	erUJ/jJgLVM9czLjqZ89llM+AwUZGzCoqIitAdcC8qx/S9BDtsMqkCbzIN5+HqtVfrvB//4F/6G
	epTWVj6e3cYoNxzoCg/H0uUljyheHQ6mmJh0HiNbC6xK16C8y7k2+e7HpogdPTVLH2O8SaMe9Th
	ZAFDkKt52yUBnN6soYt5yh+y8D0xfc03mL8GiDljo1zlh3a9MQ+FYWnzytSIF6zzHjDdJWKXGio
	VNsNrVWnfkF4ptROdMhWTvytWlQPRebXA8ibsFtQE34e6V1rNhQgk3UxSqDIjD9fuJZdHkQ=
X-Google-Smtp-Source: AGHT+IGWDa45dg3xRQlPrBCB2RykQBWQjwcAddvmjkqC+H/VzwhKqUGo6U53A3FTwTYDMQ62clov2A==
X-Received: by 2002:a05:651c:220c:b0:307:e0c3:5293 with SMTP id 38308e7fff4ca-309036ea829mr7444151fa.36.1739358769271;
        Wed, 12 Feb 2025 03:12:49 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-308fe555e5dsm4932671fa.72.2025.02.12.03.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:12:48 -0800 (PST)
Date: Wed, 12 Feb 2025 13:12:46 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Lee Jones <lee@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, quic_kamalw@quicinc.com, quic_jprakash@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/5] dt-bindings: thermal: Add MBG thermal monitor
 support
Message-ID: <iuzhsmcfmc5kxpxirqdacxgaqqufs3hdhlvhw2mds2wq3rb6si@pcsvops5yd6h>
References: <20241212-mbg-v2-support-v2-0-3249a4339b6e@quicinc.com>
 <20241212-mbg-v2-support-v2-1-3249a4339b6e@quicinc.com>
 <ojukpywkhu72cimujmijzidf26654g5vkjaj477imcf4suz2o6@cmow62jcqsfz>
 <7a5db383-914c-4c1e-846e-5d68cc6a7765@quicinc.com>
 <fcd718be-fe8a-466f-bd2b-7b75d5f8dd6c@kernel.org>
 <c85903c6-6a89-4382-bfa2-2fed95f0cbc0@kernel.org>
 <sybrfmrpegq7fcqykgsfhm56wjyx5vp6zafqw2d73tiral64aw@hg4di55fzdle>
 <9a61e73d-29d1-4189-89eb-1299b8934af9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a61e73d-29d1-4189-89eb-1299b8934af9@kernel.org>

On Wed, Feb 12, 2025 at 07:06:56AM +0100, Krzysztof Kozlowski wrote:
> On 12/02/2025 00:57, Dmitry Baryshkov wrote:
> > On Tue, Feb 11, 2025 at 12:50:12PM +0100, Krzysztof Kozlowski wrote:
> >> On 11/02/2025 12:46, Krzysztof Kozlowski wrote:
> >>> On 11/02/2025 12:15, Satya Priya Kakitapalli wrote:
> >>>>
> >>>> On 12/13/2024 2:08 PM, Krzysztof Kozlowski wrote:
> >>>>> On Thu, Dec 12, 2024 at 09:41:20PM +0530, Satya Priya Kakitapalli wrote:
> >>>>>> +
> >>>>>> +required:
> >>>>>> +  - compatible
> >>>>>> +  - reg
> >>>>>> +  - interrupts
> >>>>>> +  - io-channels
> >>>>>> +  - io-channel-names
> >>>>> Binding looks ok, but this wasn't tested due to unneeded dependency.
> >>>>> Please decouple from dependency, so automation can properly test it.
> >>>>
> >>>>
> >>>> The dependency is needed because this mbg peripheral is present on only 
> >>>> targets which have GEN3 ADC5, for which the bindings support is added in 
> >>>> the series [1]
> >>>>
> >>>>
> >>>> [1] 
> >>>> https://lore.kernel.org/linux-arm-msm/c4ca0a4c-e421-4cf6-b073-8e9019400f4c@quicinc.com/
> >>>
> >>> Sure. Then this cannot be merged due to resulting test failure.
> >>>
> >>> Please don't post new versions before this can be actually tested and
> >>> applied.
> >>
> >> Heh, you responded *after two months*, to an old email so even previous
> >> discussion is gone from my inbox.
> > 
> > Are you responding to your own email?
> 
> Look at the timeline of these emails. Satya responded after two months
> with some comment. I responded now. Then I noticed that it is talk about
> something two months old, so I responded again. Two responses from me,
> that's correct.

I see, Satya's email didn't get to lore.kernel.org, so it wasn't fetched
by lei.

> I recently got way too many such 2-month old clarifications.
> 
> That's indeed right of the contributor to respond in their own pace, I
> am also sometimes slow, but really there should be some limit. It's
> putting unnecessary burden on reviewers as now I should dig some old
> discussion.

-- 
With best wishes
Dmitry

