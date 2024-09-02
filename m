Return-Path: <linux-kernel+bounces-310998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4139683C0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 11:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADEA31C22786
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 09:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD091D4175;
	Mon,  2 Sep 2024 09:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2I/ab+BM"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2158B76035
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 09:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725270814; cv=none; b=pBG1LdDMpgDpw49VY1QcfS/rryardOQODuTxjFzpcW3dS2Z5NsGgrN2kwrO/8xXqFU4sZlsW7avuIaRmON8XfNhwxvnTkCZCXZsneA/E8Osu4txDDEE9IiXdQHrvyyRZD61YZPXmHCm4tPhPwSXd5uvOnumB8rh/TMO0Q4aajvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725270814; c=relaxed/simple;
	bh=H8i8ekLgn7mMzXvjHDwxzcGucNAxDGS/vjF5gwmh2qw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=puanPkbdFr7fSkHomeqqd1kAbB9HLtY1cvPmQChmGaMwyBPyGSVOjy9pS+y9KxSTKoGq2OuWarNba5xZHsi2ntWmrwq6fnarTdn4NeWG3pEZ0gRmcDeIERQT8+E+WnU7hfmJ5312p2eBwIqakQ6p6qrKoiuxwmnTpJBmpQLmHSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2I/ab+BM; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42bbe908380so22150145e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 02:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725270809; x=1725875609; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ap1TFjvG1Ip3qZtO+pSCOcSztVaGL1F8QNxcVrxFmH8=;
        b=2I/ab+BM4Bx1utUzaaYoF+o2v2aosISuEqPcAAllJQs8yQa30xfaMNbLLTNnA5yB3/
         UFt/CHo3KkAEG4RA83dvBJIKwpyxxrjCp+k1y5STEOTQ3sfc9CZIUtjm5nvGrRkc7bzZ
         fcrBVJzfFYnxtuvUVle1p2s1gxUndglFb2IGuPCZj75s/UnttRYYDzHr8+cCtcCPx2x0
         /45axP9hsmlsjK4XAdrLD6KWYFh+fPuBzxM1cEtY8/0321/0jMvGj9fan219LETbkCKk
         +ml+3JBbVE3eJKUI5qfNRFRjxUbR24NtPu4vE9DxHpWYDtNhzVZZtSIK3RXAqpCYwMAs
         8A5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725270809; x=1725875609;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ap1TFjvG1Ip3qZtO+pSCOcSztVaGL1F8QNxcVrxFmH8=;
        b=NC4SmSKWCmPXPoVZ1qVtX4lB2bCTv7rm/Q7etkUuTviKCUyVnxj9V4XYT4pnC9YWIj
         MdhvGkNkTEDziPkkQX0It7z6UpjaquCGDQsqCRKAByVjE+2Og42dmSY+U6lCzS2tq03X
         bPoNNBzynSKWhqKujj4uSk5K7AfUBCYJ3yH73jLHIJpXyCkcW1PDTperD9kHxZJyqPBy
         tW+2qbqejz2UD7Or2hNZd9t2H5DQCxyV/5pUTkN0TViA950WAbK/pbeTasYwNqW45U1r
         gmNVtFvsFx2LSUnLZQJPSe+NyyzQVaCPnkSTm3rUjnBp0Lb5pXgB8e3CtHymwvdkgqC0
         42rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwhuOiC0xoRGNra7NbF60MFq5YNiMU6CVoWrSbCNV8mNIHVIetVPTMfsywqAreM+YMK3EzwZpyJpkLtsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGh7rLxZ5WNQ53+fXEBTZQ9Re6qrxERo/WOdCV7d4LA9qSP2ak
	7cg62AU3r7ahBwY2zZqU+XnsArggXyIQkrz+RJJHCOM9mygbUx6r7TauwOYUpuI=
X-Google-Smtp-Source: AGHT+IEBNwIDeLBGu5sJyen1fHV8CZ+NfcZkdnYwyDXfXu0Okz+GmfMqYb27o4OdqdSGbmDR+fVhEQ==
X-Received: by 2002:adf:f206:0:b0:366:eade:bfbb with SMTP id ffacd0b85a97d-374bcfe5bd4mr4272968f8f.46.1725270808862;
        Mon, 02 Sep 2024 02:53:28 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:a2ea:8e6e:d881:76ec])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374c5ae48e4sm4162458f8f.90.2024.09.02.02.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 02:53:28 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,  Stephen Boyd
 <sboyd@kernel.org>,  linux-kernel@vger.kernel.org,
  linux-amlogic@lists.infradead.org,  linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 8/9] reset: amlogic: split the device core and
 platform probe
In-Reply-To: <34bc2d1ceef7bcab3d9b78de588e996c2d2ecdd3.camel@pengutronix.de>
	(Philipp Zabel's message of "Mon, 02 Sep 2024 11:47:34 +0200")
References: <20240808102742.4095904-1-jbrunet@baylibre.com>
	<20240808102742.4095904-9-jbrunet@baylibre.com>
	<812c6ddc-1929-46c4-bac7-4bd0f5ccc213@linaro.org>
	<1jsev0wj8y.fsf@starbuckisacylon.baylibre.com>
	<34bc2d1ceef7bcab3d9b78de588e996c2d2ecdd3.camel@pengutronix.de>
Date: Mon, 02 Sep 2024 11:53:27 +0200
Message-ID: <1jbk16s7oo.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon 02 Sep 2024 at 11:47, Philipp Zabel <p.zabel@pengutronix.de> wrote:

> On Mo, 2024-08-19 at 18:49 +0200, Jerome Brunet wrote:
>> On Mon 19 Aug 2024 at 18:33, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>> 
>> > On 08/08/2024 12:27, Jerome Brunet wrote:
>> > > To prepare the addition of the auxiliary device support, split
>> > > out the device core function from the probe of the platform device.
>> > > The device core function will be common to both the platform and
>> > > auxiliary
>> > > driver.
>> > > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> > > ---
>> > >   drivers/reset/amlogic/Kconfig                 |  10 +-
>> > >   drivers/reset/amlogic/Makefile                |   3 +-
>> > >   .../{reset-meson.c => reset-meson-core.c}     | 101 +++---------------
>> > >   drivers/reset/amlogic/reset-meson-pltf.c      |  92 ++++++++++++++++
>> > 
>> > Are we still in 1983 ?
>> 
>> I don't quite get that remark or how it is helping the review.
>>
>> > please use reset-meson-platform and drop pltf completely
>> 
>> You are requesting auxiliary -> aux on the patch.
>> So which one will it be ?
>
> I would prefer to drop the -pltf suffix completely and also to drop the
> "reset driver" -> "reset platform driver" documentation changes.

Hi Philipp,

I'm not sure what you mean with the last documentation bit ? Could you add some
details, I'd like to get the next version right.

Thanks 

>
> regards
> Philipp

-- 
Jerome

