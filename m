Return-Path: <linux-kernel+bounces-214445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEC390849C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02527B24B87
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5323148FE5;
	Fri, 14 Jun 2024 07:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="V24Y9oKI"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C8614883F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 07:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718349874; cv=none; b=uwwXtGgQFnk7VQatncVAn1exwgpELUym9secdbg+ejrLqIAoKNnQA0FbxAK5+YY4tI/d/4mq+XJtoIpE+1P2MygC7te4079twQnpJYqig07QanjVym7cagLQi70pMz2d7FNN5awP4XiTO5/sFFrepVG5iFEe9ao1phDg+LX2Wp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718349874; c=relaxed/simple;
	bh=hFujVRhuXxRz8ZuRuWxpcKWlBAtuti8B0cXxJN/IHR0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EnedjrxccI87RmIMwi867myAUhWWtvYjxJglM9CECNIGVNu3T3wrWjyo+DRILzdEtSWvKcJj4qaIYLEnvsMp8IFg+uGsfJwjCboh30CXPwZ1fuCwENE7Z/6FQ69OwNi47NGQZtvqxEj1GCPbon77b0Mi3xaqELVCbSxJ5djZLF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=V24Y9oKI; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e724bc466fso21318861fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 00:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718349870; x=1718954670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XonQmSzUMViZ2/5nnwAc3UPbyjH2uWZ224DMU7aSdNw=;
        b=V24Y9oKIJEgl//G+OjBCSZiezZY4EOmSGBq+l5PLkIHhpLvqv8cxYktutVvstsoQRY
         PA3Jm3RxvTUbYU03uKV5PbDv4WDkxbrACh0ReJRPZpy/zbM8/Grro/bhKcEfkyEbjSPW
         KBt9ClXeNH345OZMh9Irjq7tEQSslR/02Jk/qtkpn+AIs8TBuC7gUXoVMDfkpI+2YzAl
         9qI2HTsiIKSWr44aGExkVS3+QFPzXScvBZzCn4tlnPV7guyuUvslOHEp3CnVd+niO0Z7
         JPhutp0AicDiD97i7P7jeJI2eZXGDRxJczbHQ8xMGZXcFBK7GnrLr9vyLRSbJVnc9T0n
         ymiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718349870; x=1718954670;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XonQmSzUMViZ2/5nnwAc3UPbyjH2uWZ224DMU7aSdNw=;
        b=IBswPZvewhvVvI9E/Z2jrR4roaFM5It0ygNPFuKs7XvCm+iHzI+HXZ9oBN1671Jpy7
         RZcR0n2Dctz0mEFDOEQ3uRUUWf6gkOh5vZVK2yxyubFsa9xFQVBunLqkQr5UjFSFQcYZ
         Bg9pUaRXQZMru8oT3UYEVoTuyNrydf7DaX2SpeMnH+Lzbef8VnZhZcVg+1Duzuy9MfpI
         lR4Ye3XofDoGFjSK7b5OLHFWrDETd9NaAKmOnLY8Eqs+O7CzfOvJ+BmPeLV+hr5FMiI0
         ceyaMVS/s4brRTRcNfOZ31EpDamSCvbh5Q5jvo0CynPKxfX0SsJttIzlWJ56/W2l/yWo
         3M8w==
X-Forwarded-Encrypted: i=1; AJvYcCXtmgIqBfTpFPEeXU1/OpNixIcYR4Sx5XSC4zJGtaCjdxecsE9yv7j0aj6OYdNSuTLgMzOpxmHKMHiqd/Ev9F5SQRuxBChFWDao29Gh
X-Gm-Message-State: AOJu0YyheknLW8hwPa087CUnKZgNVQjKw39LlM7vo7QRLpYiYLMyW9lS
	tja2IYEWPCz3tc8jr0h7kZyE6YpSH5lTZvO2mvC8NQyA3hcVXLGF7S46ddwMW4Y=
X-Google-Smtp-Source: AGHT+IF0xf98UlruLSknNwRYcad83nIcooBh7OBYmO1Yav9pdgNNBUl4LOUE3c3U17ltnbt3pXsw8A==
X-Received: by 2002:a2e:9ac4:0:b0:2ea:eaaf:bb72 with SMTP id 38308e7fff4ca-2ec0e601029mr16962341fa.33.1718349869805;
        Fri, 14 Jun 2024 00:24:29 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:d811:babc:4f8c:772b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f5f33ccesm48817915e9.3.2024.06.14.00.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 00:24:29 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Kelvin Zhang via B4 Relay <devnull+kelvin.zhang.amlogic.com@kernel.org>,
  Neil Armstrong <neil.armstrong@linaro.org>,  Kevin Hilman
 <khilman@baylibre.com>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>,  kelvin.zhang@amlogic.com,
  linux-pwm@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-amlogic@lists.infradead.org,  linux-kernel@vger.kernel.org,
  devicetree@vger.kernel.org,  Junyi Zhao <junyi.zhao@amlogic.com>
Subject: Re: [PATCH v8 1/2] pwm: meson: Add support for Amlogic S4 PWM
In-Reply-To: <tnwdnwiruoty5yd42bmkupgg6hjxib5lblhqcyouoyx5y3zvnq@2d7cnrei24m4>
	("Uwe =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Thu, 13 Jun 2024
 22:46:30 +0200")
References: <20240613-s4-pwm-v8-0-b5bd0a768282@amlogic.com>
	<20240613-s4-pwm-v8-1-b5bd0a768282@amlogic.com>
	<1jfrtgj0so.fsf@starbuckisacylon.baylibre.com>
	<tnwdnwiruoty5yd42bmkupgg6hjxib5lblhqcyouoyx5y3zvnq@2d7cnrei24m4>
Date: Fri, 14 Jun 2024 09:24:28 +0200
Message-ID: <1jbk44htqr.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu 13 Jun 2024 at 22:46, Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibr=
e.com> wrote:

> Hello,
>
> On Thu, Jun 13, 2024 at 05:54:31PM +0200, Jerome Brunet wrote:
>> > +	for (i =3D 0; i < MESON_NUM_PWMS; i++) {
>> > +		meson->channels[i].clk =3D of_clk_get(np, i);
>> > +		if (IS_ERR(meson->channels[i].clk))
>> > +			return dev_err_probe(dev,
>> > +					     PTR_ERR(meson->channels[i].clk),
>> > +					     "Failed to get clk\n");
>>=20
>> here it is ok but ..
>>=20
>> > +
>> > +		ret =3D devm_add_action_or_reset(dev, meson_pwm_s4_put_clk,
>> > +					       meson->channels[i].clk);
>> > +		if (ret)
>> > +			return dev_err_probe(dev, ret,
>> > +					     "Failed to add clk_put action\n");
>>=20
>> ... here, devm_add_action_or_reset cannot defer, so dev_err_probe is not=
 useful.
>> dev_err() if you must print something. Just "return ret;" would be fine
>> by me
>
> I don't agree. dev_err_probe() has several purposes. Only one of them is
> handling -EPROBE_DEFER. See also commit
> 532888a59505da2a3fbb4abac6adad381cedb374.

I was stuck on the -EPROBE_DEFER usage. Thanks for the heads up

>
> So yes, please use dev_err_probe() also to handle
> devm_add_action_or_reset().

My point here is also that devm_add_action_or_reset() can only fail on
memory allocation, like (devm_)kzalloc. Looking around the kernel, we
tend to not add messages for that and just return the error code,
presumably because those same 'out of memory' messages would proliferate
everywhere.

>
> Best regards
> Uwe

--=20
Jerome

