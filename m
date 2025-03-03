Return-Path: <linux-kernel+bounces-541179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14119A4B9B8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80AC77A5FFA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 08:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F034C1F03D9;
	Mon,  3 Mar 2025 08:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n9G/kfvZ"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1FA1EFFA5
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 08:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991553; cv=none; b=I1jan27Y6QkH6OokSadd46hUduBdp8CXbugXnFKJ78acC0d5zbj4W7mCaeMfUxS/ssLz/2PnR7iSE59++PVhSiD91hcnErfwOCrKeWPvgl9rdnzEAmsFcbozlQsDUm+J0v6SHFf4+AGz1lsdMFwMR+1y/it/p52bcFlPRDzbxCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991553; c=relaxed/simple;
	bh=fg7ScFrpAhGYL1bOoOF2peNB6lfD3/GoDR0u+tz557k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FTzXIE56wGLwF9w/cmeV+9/ShGKM4Yd8E0SX1lW/5oyHP5U5Z2AFMoC5Ere+f0Bw0g/Vii+jQBJ7LoPwbeTOX7HLgobRnX4wUBa4J3+na8Q2J+2AjU71Sid3dPHzLqaAuWkqIAhV7l9ivAMgKfV3TsU4PLTYgX1BwT3JpsQPg0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n9G/kfvZ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4399d14334aso38207005e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 00:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740991549; x=1741596349; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fg7ScFrpAhGYL1bOoOF2peNB6lfD3/GoDR0u+tz557k=;
        b=n9G/kfvZUuKXK3EZX64mpWhqdmN1j1OYK7oiCsE7ihLQRsDnyozQ04T9ROLlGD9gDp
         9gOcM4O7GEvACnhyhEmPDjaSQqtoXIb/tC5+QuLCwAgCnv/OuBrtNScqjQ4SfmDJNK26
         p4Gxgchd8L1bznzd/tG74wBYnUYvsKsCOVpajZu7vJ3IQSP68JOf25yzIQqnqCTZBn+A
         Sh0yQKtxZpeRsbC5sLI2WXBwc8EN3RNM9O01Azh7yv3/Z8vqu0HnQ0yh5/GF8JisQOcK
         4vte0r9AUXsHvAMeZksLp3eKByPYT2Xjq/pZ2jKCX/fANxSVdPTmh+p2OMwkEBRRqZfc
         7pSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740991549; x=1741596349;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fg7ScFrpAhGYL1bOoOF2peNB6lfD3/GoDR0u+tz557k=;
        b=PBKkdm06vGaR1H0cOgm+4yeGX9FxGBev1mq1CtZE7LYvRjHWIIco9uNz8erK9oCl4s
         fm8Y397Mdb1e5wnS6WIIlr9IsvoFjKuQs7wDaUgByKrBPyNcvYHMleuQ1PAyQZgRbP1V
         lkyrtTWO1SBmVUcy/5XjfDsK6WdXbYxbWiTdQPV2qBwSaBgxjl26K3DCGntTOtpwuM1k
         3cCoY+UzhBsE8eCv+80qgUnczbOZiaH5t5DIS11oVj8cMKrn8T3cDK5IlVASawuDLHWm
         +te81JVqbp/BXD+cL0sGsyu1IVmYXlTaGwlU3qZ2ASNVCHHq61A2KxNHz+cTl+Wf0yv5
         EMZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMJQ3nxC2213LTNHYD1wyX70OHoZp0l8y1JZCRBFVkXMHhoxIoqbOCmRU1DpijSBFzWLKUvsg2zxlK3SA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMPCrxFfjJ/YXDsV63z1qDWySU5BsEtbwxTP77vjmoCH8T/dwW
	LiHrUU6ddOsS2+WDtWWG3kkb3FB1EB4MHdkXwMgr3wvPaJU/gJcWa4G1yOmq3UM=
X-Gm-Gg: ASbGncu3xwAI4SMQ98q1gjfoJL81Ky/niIarZgftj9f9AyjoR+TVu03RXpuuIgSy3gJ
	h4cF+mp8X+Tfh8JoeiR6VhLuJXonYOGh+juZ9JzacYH/Foz9iAPUp63wYzZrWE1MpVtc7yBs+o4
	snXjp6/jNJ5T0cVJZpKJUr8VfFhvwXzEP/ehhtpx4zkiF1Ey6Spz+MJpOmI1IzE8Mp70YWyIqaP
	sRTFvdebMHB2YT3zFA1RDuMBHSgqigSq5DHlSVWksYgyqADRDO78jR9WARP/JYTwMCSqDkvxuXp
	rx4zU8Q9OX7VmLv4saQ8kHRrLGZUNI6JyO9YfDiPQoSKFu9i
X-Google-Smtp-Source: AGHT+IEQ5gIerplrLBCNz9iWi2EjC22riC6x2aUD9LPOL3RMv31foO6V/nmZEr2WkFVBKnwbDjXW6Q==
X-Received: by 2002:a05:600c:4e8b:b0:43a:b8ef:4dce with SMTP id 5b1f17b1804b1-43ba67041bamr112726745e9.11.1740991549553;
        Mon, 03 Mar 2025 00:45:49 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b736f75ebsm153130965e9.3.2025.03.03.00.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 00:45:49 -0800 (PST)
Message-ID: <4d0042850eb4d9898559b56505291c4e849d44c5.camel@linaro.org>
Subject: Re: [PATCH 00/18] a few rtc driver cleanups
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski
 <krzk@kernel.org>,  Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Hans Ulli Kroll	
 <ulli.kroll@googlemail.com>, Linus Walleij <linus.walleij@linaro.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet	 <jbrunet@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  =?ISO-8859-1?Q?T=F3th_J=E1nos?=	
 <gomba007@gmail.com>, Dianlong Li <long17.cool@163.com>, 
	linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-amlogic@lists.infradead.org
Date: Mon, 03 Mar 2025 08:45:47 +0000
In-Reply-To: <20250301203658839d5482@mail.local>
References: <20250228-rtc-cleanups-v1-0-b44cec078481@linaro.org>
	 <20250301203658839d5482@mail.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Alexandre,

On Sat, 2025-03-01 at 21:36 +0100, Alexandre Belloni wrote:
> On 28/02/2025 14:07:13+0000, Andr=C3=A9 Draszik wrote:
> > Hi,
> >=20
> > While looking at RTC, I noticed that various drivers are keeping
> > pointers to data that they're not using themselves throughout their
> > lifetime.
> >=20
> > So I took the liberty to drop these pointers and this series is the
> > result.
> >=20
> > The last two patches also convert two drivers to using dev_err_probe(),
> > as I looked slightly closer into those two. They don't exactly fit the
> > general subject of removal of unneeded pointers, but I wanted to share
> > them anyway, since they're ready.
> >=20
> > All of this was compile-tested only.
> >=20
> > Cheers,
> > Andre'
> >=20
> > Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> > ---
> > Andr=C3=A9 Draszik (18):
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtc: max77686: drop needless struct max7=
7686_rtc_info::rtc member
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtc: s5m: drop needless struct s5m_rtc_i=
nfo::i2c member
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtc: aspeed: drop needless struct aspeed=
_rtc::rtc_dev member
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtc: ds2404: drop needless struct ds2404=
::rtc member
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtc: ep93xx: drop needless struct ep93xx=
_rtc::rtc member
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtc: ftrtc010: drop needless struct ftrt=
c010_rtc::rtc_dev member
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtc: m48t86: drop needless struct m48t86=
_rtc_info::rtc member
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtc: meson: drop needless struct meson_r=
tc::rtc member
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtc: meson-vrtc: drop needless struct me=
son_vrtc_data::rtc member
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtc: pl030: drop needless struct pl030_r=
tc::rtc member
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtc: rx8581: drop needless struct rx8581=
::rtc member
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtc: s35390a: drop needless struct s3539=
0a::rtc member
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtc: sd2405al: drop needless struct sd24=
05al::rtc member
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtc: sd3078: drop needless struct sd3078=
::rtc member
>=20
> My main concern with this is that as soon as we introduce irq support,
> we are going to need the rtc pointer back in the struct. But I guess
> that most of them are old enough to say that nobody is interested in irq
> support.

Thanks for your thoughts Alexandre - I don't know the history of
these drivers and don't mind either way. I can drop those patches
that would require reintroducing if irq support is added in the
future. I think overall you're OK with keeping them, but please
let me know if I'm misunderstanding :-)

>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtc: rx8581: drop needless struct rx8581
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtc: sd3078: drop needless struct sd3078
>=20
> I guess you could squash those two with the previous ones touching the
> respective drivers because you are the one removing the last remaining
> struct member.

Will do.

Cheers,
Andre'


