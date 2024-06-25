Return-Path: <linux-kernel+bounces-228986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31363916968
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94676B20DE8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E832E1662F1;
	Tue, 25 Jun 2024 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Y5xmCo7v"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5814117C98
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 13:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719323517; cv=none; b=M4CnTcfBeBW46bWMWhFNn596P3qv/zPHkAAbsH1bhlYrLXFInLNJcyXGvTVfZgNDd1Y0VcJX/R2U9VQadKwMjMvce/7l55SS3Tt+dBXoDW1O4hLtGTiXYAjBWRVdYq9+5uKy1jNXKBwvF2FKePS5Q5fCyv4F6vgyjAdPVx9ai58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719323517; c=relaxed/simple;
	bh=fa8b4BpEQtXMPhHpbCTwaXqzX0p5RuNLjoKLCfp+7dA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=joXqiu93g4zyEfzr/Le52GiZ/gXHp4G8OO2bb3eWNc8y2LljlZHFeAZB5218y+tWk4fMiYCZ8qKlFdfj1ihJxBSAZQEaHOeVZmoM5LlvE57VFHGxvRIZEVPqEuB5J2/IeWoLR7f0f+2xR/YUDFBDo71rQ4Lv1MKkbT8Y7dSmm/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Y5xmCo7v; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42108856c33so39015255e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 06:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1719323513; x=1719928313; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KTXG/FRxZ0m4qvnOPb2W46Bb/zdn6G2YXIXWD74rp1w=;
        b=Y5xmCo7vMEEfI0O94N5GRmGWt8foJ1TwyEDTXxP3hzhYCYtwyhBS6Ji3WKcYaiwVv9
         b83gTvWzKH6k5hCz4BIeGU3leceHC+m7gJF+c7/8YvYFklqnhtf3HMWkB1t3rPFxBq+M
         6MUAq70yZvxuRDQd1Ne9CLlvpChN37iwQ/hhJ5FJUo7ifzTDWod8aMxkKl1/W9M1yuOD
         U6oRrp5MbCNmUm3JJol8IoaHJEFeqZ1zTLWVZ2CYJV8cU/ifZ5A6AiGfFOQBGt3exQ/h
         2aVZUKu+mbTKvQ88BraaG+htM5NDdJbquTPX+CjFMVEMy0dtxL/SGI9W+BLRP+oPZI43
         w0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719323513; x=1719928313;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KTXG/FRxZ0m4qvnOPb2W46Bb/zdn6G2YXIXWD74rp1w=;
        b=X+5lFU+gKSmSLc4hTPkR1kK9pWQpboX0EhlOkaBjmogdW5JjIqK3WuvHqIhyw3Hcmk
         NpLNemiulK4yCAfuDWisYuHDYYSawfXqERkXN5ijupTwRpLPeBR1Bo0bf0aIBqYZJpsb
         Klqn3aOGJpeCkOL8RYPS22fPumPGIfN0hj9S0smqeuik1nCgbTIBhZnETP6TyTU4QbEq
         6+cDj3ltvrVVGUaRszZherdldXA4Kg1mF8OKYX1B+RmfvVgtSnOCAWeL/l+EA8IHuUOt
         l2LIVxW1h6FcNy3lrpCo2J41TGZPksa+rVNaD2msxIjZy+KStFfTx7/MujfAflRibnH5
         48cw==
X-Forwarded-Encrypted: i=1; AJvYcCW4wSJbrs+cfPQT5tjEOBjjRlXKKXM6uovLptroZJA7IALCRaQUCQIgNG3fRWGV4AYTgulS1wDlLqit/vt7quIpy5CmKQBhwyqghFYI
X-Gm-Message-State: AOJu0YzgT6zvNcm+/nx/UR3VTkuI6gLiAxeh8csHoDSKtrrmYdGl1KrP
	/QcMiOJSve1yWpFe4VspF1VlGsu9/iomgkqfj5Io8f4Ljf2UhqNCjbycvUogBPLmII0WP58KWwN
	XDz8=
X-Google-Smtp-Source: AGHT+IEalVLvF2V4HVuOBDYasPTatv9mBYVJq42aJr3idMXc9t+1AfV6Rij0cOM4lR1IMYrnqTV/bQ==
X-Received: by 2002:a05:600c:56cd:b0:424:8a34:9890 with SMTP id 5b1f17b1804b1-4248a349975mr68512565e9.7.1719323512709;
        Tue, 25 Jun 2024 06:51:52 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:b30c:4c5e:f49e:ab33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424abf622cdsm172075e9.28.2024.06.25.06.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 06:51:52 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,  Lars-Peter Clausen
 <lars@metafoo.de>,  Kevin Hilman <khilman@baylibre.com>,
  linux-kernel@vger.kernel.org,  linux-amlogic@lists.infradead.org,
  linux-iio@vger.kernel.org,  Rob Herring <robh@kernel.org>,  Krzysztof
 Kozlowski <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,
  linux-arm-msm <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH 0/2] iio: frequency: add iio support for Amlogic clock
 measure
In-Reply-To: <c092ec67-e384-411d-8885-665597547523@linaro.org> (Neil
	Armstrong's message of "Tue, 25 Jun 2024 15:18:11 +0200")
References: <20240624173105.909554-1-jbrunet@baylibre.com>
	<52fab9b5-2b44-49c0-8b90-cb2a74eb6633@linaro.org>
	<1jzfr9gxh4.fsf@starbuckisacylon.baylibre.com>
	<c092ec67-e384-411d-8885-665597547523@linaro.org>
Date: Tue, 25 Jun 2024 15:51:51 +0200
Message-ID: <1jv81xgmfc.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue 25 Jun 2024 at 15:18, Neil Armstrong <neil.armstrong@linaro.org> wrote:

> On 25/06/2024 11:53, Jerome Brunet wrote:
>> On Tue 25 Jun 2024 at 11:38, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>> 
>>> Hi,
>>>
>>> [+cc people from linux-msm]
>>>
>>> On 24/06/2024 19:31, Jerome Brunet wrote:
>>>> Add support for the HW found in most Amlogic SoC dedicated to measure
>>>> system clocks.
>>>> This drivers aims to replace the one found in
>>>> drivers/soc/amlogic/meson-clk-measure.c with following improvements:
>>>> * Access to the measurements through the IIO API:
>>>>     Easier re-use of the results in userspace and other drivers
>>>> * Controllable scale with raw measurements
>>>> * Higher precision with processed measurements
>>>> Jerome Brunet (2):
>>>>     dt-bindings: iio: frequency: add clock measure support
>>>>     iio: frequency: add amlogic clock measure support
>>>>    .../iio/frequency/amlogic,clk-msr-io.yaml     |  50 ++
>>>>    drivers/iio/frequency/Kconfig                 |  15 +
>>>>    drivers/iio/frequency/Makefile                |   1 +
>>>>    drivers/iio/frequency/amlogic-clk-msr-io.c    | 802 ++++++++++++++++++
>>>>    4 files changed, 868 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/iio/frequency/amlogic,clk-msr-io.yaml
>>>>    create mode 100644 drivers/iio/frequency/amlogic-clk-msr-io.c
>>>>
>>>
>>> While I really appreciate the effort, and the code looks cool, the clkmsr is really
>>> a debug tool, and I'm not sure IIO is the right place for such debug tool ?
>> The reason why I went through the trouble of doing an IIO port is
>> because I need that for other purposes than debug. I need to to be able
>> to check a frequency from another driver. I don't see a reason to invent
>> another API when IIO provide a perfectly good one.
>> The HW does measurements. IIO seems like the best place for it.
>> For the record, I need this for a eARC support.
>> eARC has a PLL that locks on incoming stream. eARC registers show wether
>> the PLL is locked or not, but not at which rate. That information is
>> needed in ASoC. Fortunately the eARC PLL is one of measured clock, which
>> is a life saver in that case.
>
> This is a very interesting use-case, and quite weird nothing is provided
> on the eARC side.

Indeed.

>
> So yes it's definitely a valid use-case, but:
> - we should keep the debugfs interface, perhaps move it in the iio driver ?

I considered this initially but it would add a lot of boiler plate
code to provide over debugfs exactly what iio already provides over
sysfs. As you pointed out, the previous driver only provided debug
information, the debugfs interface it provided is hardly a
critical/stable one.

> - we should keep a single compatible, so simply update the current bindings with iio cells

Using a new compatible allows to split the memory region, making the
interface between DT and driver a lot easier to implement seemlessly
between old and new SoCs. Eventually it may allow to implement the duty
part too.

> - for s4 & c3, it's ok to either add a second reg entry in the bindings

Doing that for s4 and c3 only would still make a mess of offset handling
the region because duty prepend the region on old SoC. The goal is to
have an interface that seemlessly support both old and new SoCs.

>
> Neil
>
>> Everything that was available through the old driver still is, with more
>> precision and more control.
>> 
>>>
>>> There's almost the same interface on qcom SoCs (https://github.com/linux-msm/debugcc) but
>>> they chose to keep it in userspace until we find an appropriate way to expose
>>> this from the kernel the right way.
>>>
>>> If it enabled us to monitor a frequency input for a product use-case, IIO would be
>>> the appropriate interface, but AFAIK it's only internal clocks and thus I'm worried
>>> it's not the best way to expose those clocks.
>>>
>>> Neil
>> 

-- 
Jerome

