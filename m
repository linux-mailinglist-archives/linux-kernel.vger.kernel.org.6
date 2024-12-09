Return-Path: <linux-kernel+bounces-437001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 629579E8DDA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 09:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C8F162B4F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 08:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEEB2156EA;
	Mon,  9 Dec 2024 08:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="CnU1vpov"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173FE2156E4
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733734277; cv=none; b=ZuYNshCwnySGXBs1CgE0pbvtQ7v9fJeczG5J11MHGfx2OWiHIkEwUy4hIDxJyMJnIisyPeZ0ixWu2jqEzUbZaiG0KMOf37UIlGzwdNuJ/NLa3psXKygxAPObUsuBQD3NwpRIY0HlwvurRqUZ0bFaNiuH8iAb7coccDjvdpNjA3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733734277; c=relaxed/simple;
	bh=3vFC/T8pkufuXOBciI8qpD+8xiXD21BBWbTTY8D6JZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d+ClXRo4VWzvYsIq76Hr6u2IH6RapFtw/3CcnoEo74nbB4O34Aykv4X/kOX8fWwljiLTmmO3AHy/bH8mgUMTxun1I1MQHC9dPmn/s0k/kTEV9eba3IxVpNyqJQaR9TfOEWa3HdOXhfEyheeyRxepwjbRD8prwuye9cFFW+P6G2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=CnU1vpov; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5d3f28881d6so1374839a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 00:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733734272; x=1734339072; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E9Hc3xjrHfup8nIdLq37wXKGA2i5zetjweZEAd4L3ro=;
        b=CnU1vpov7xBbpEGwTJbU8CkxZi8+sm7IyAmZZQN2YcGWHEm1U9S2bMMfCy3ctyIhiZ
         VEGsKfDeeBFnapxVW7Uf9Vg4qtOB+YS87uyb2BrY5gSjtH2+HLc4LuWxXSRwt7corkTc
         hkRLdKdT3jmd3p4eeQZhL4xIqrow4K8qZnK26LR0HpfOranSlXR0XssI+NDjtdtzAzkK
         Ci2dmwShiwTea/4iwUUb24823K2RUKJMhd08+Yavy/g5/RI/JHRB2mr46PgQR9UwaXgw
         0SPDn8uzdhWY+6a3e6k6ni6Gstw1nVDmlEusA433fE1DuEjg76Zw2rAUUuvlJsDJLNlG
         t8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733734272; x=1734339072;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E9Hc3xjrHfup8nIdLq37wXKGA2i5zetjweZEAd4L3ro=;
        b=uekKfyGOQGyPcpAPQIMMAYa1nEM6iCg/Xg+GUXyA7AQh/G2bWvCgqYokY3s6AHz9Py
         4Va78wjKg/6n/9sjx/xkw8MiZJniZT1Z1o22l8t8x3WWETRXOgti4LT3kfYpYEwXorrf
         dFc6nl5ztlyG2V3pt8xcscYHCboOIefR60nCWqC1zZxDC87TkCTbcMZfksvf+/guO7k4
         LpjbeYghzp3bs8NpiqFKrKQp+HmRzC3607E6g/qTwwMkNE0LYLVLyLAl6j1A+x9Da3v8
         KHPRyLx6y3LDA0Xn5yhmhTHqrb3QZfazkK+6iAjZgkm7L0jlpahzkLQ5WXMb04+L9Hl3
         Po0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVGCufKdP42NsF35fVDh9I7AZgjzbG3inDNgnBYGK+BAWlQDo8MfBsrw3YbUlgCiiUhgqM5fg4nistmn/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7lmggp+KeIUUAEzFJP8kRf+MTqMQ4ndHq6vWeuTFrLCUACfSZ
	EMMbxujQgCZ4BSnu1cpxrvY76EEBNxSSeOqe+we0kKfjk2w9sQputLbbnJpM0BM=
X-Gm-Gg: ASbGncsHlxoF9e2GGd78WpiTgHlMdtRbxk9Q28Qtzw7pKyX5tkS2cCJtsqIsx3kKDzx
	Fw1E8Y/3yVFPBrhFmANGGkCTLpq+zosxhBLdUXOBfc7kkZsrHJ01v0cOffKgbk/NcOo1+JlK6AX
	U1UzPpbH5C17//QW6g8vfH+a8AYMuIeEcSuvj8HdRHuAZzvRm3FvUahQRwX/bGHN/MGbcwAqhdw
	Ag2OqsktvU328PROjCy+z4z/uYDuuG/QDwwrXELbHnjPFdwoteOLRCy8E90ESg=
X-Google-Smtp-Source: AGHT+IGTTSAOMWti4zwyd2JGUoVCQStjHBohMUQcMUwJfOa0IHr7CHbtGAw0XbsqZPj/g1XSSxcatA==
X-Received: by 2002:a05:6402:1d55:b0:5d0:ea4f:972f with SMTP id 4fb4d7f45d1cf-5d3be68007emr30680021a12.8.1733734272022;
        Mon, 09 Dec 2024 00:51:12 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.161])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3d76f3892sm3614673a12.28.2024.12.09.00.51.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 00:51:11 -0800 (PST)
Message-ID: <7857083f-e138-48f2-ab86-abb80173cc24@tuxon.dev>
Date: Mon, 9 Dec 2024 10:51:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/15] iio: adc: rzg2l_adc: Add support for Renesas
 RZ/G3S
Content-Language: en-US
To: Jonathan Cameron <jic23@kernel.org>
Cc: prabhakar.mahadev-lad.rj@bp.renesas.com, lars@metafoo.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com,
 sboyd@kernel.org, p.zabel@pengutronix.de, linux-iio@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20241206111337.726244-1-claudiu.beznea.uj@bp.renesas.com>
 <20241206111337.726244-14-claudiu.beznea.uj@bp.renesas.com>
 <20241207183423.4af1f988@jic23-huawei>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20241207183423.4af1f988@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Jonathan,

On 07.12.2024 20:34, Jonathan Cameron wrote:
> On Fri,  6 Dec 2024 13:13:35 +0200
> Claudiu <claudiu.beznea@tuxon.dev> wrote:
> 
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Add ADC support for the Renesas RZ/G3S SoC. The key features of this IP
>> include:
>> - 9 channels, with one dedicated to reading the temperature reported by the
>>   Thermal Sensor Unit (TSU)
>> - A different default ADCMP value, which is written to the ADM3 register.
>> - Different default sampling rates
>> - ADM3.ADSMP field is 8 bits wide
>> - ADINT.INTEN field is 11 bits wide
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Hi Claudiu
> 
> As my comments were all minor stuff, I have applied this.
> However they were the sort of minor changes that result in lots of
> fuzz and hand editing when applying so please check the result.
> Applied to the testing branch of iio.git.

I checked and tested testing branch at iio.git. Everything is good.

Thank you for taking care of this,
Claudiu


> 
> Thanks,
> 
> Jonathan

