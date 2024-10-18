Return-Path: <linux-kernel+bounces-371340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F349A39CF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F6A91F253F8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 762881EF0A3;
	Fri, 18 Oct 2024 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iZWU85ec"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5CE193084
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 09:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729243264; cv=none; b=m+Em9jSpBKsf4bBv8VeuO7H1HTnav6RUv2w4fpKvUX7mzneacyA6WtuubicaE9xqAvdnvuzh46s63AMKhhPEWRHOJ7+QmYRc/D36f08qAOtwfPTEt5XmxHmco+a2TaEEX7UPatXJ55uts+m0T7UahdY/I/AcnwSpuE23IyFoogg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729243264; c=relaxed/simple;
	bh=2m70Uo5edm0oou27BOFno3Tc7nrR3KC/y7H2rhdo2cI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Kguve2Oxb+GImRciwZjhfFDWsSVMXczJqYqmcl6dNiTzrMd/Y+w93d2FrvvEkuCSIUn2TQrYUSVr0mNPIrSOcnEl1D/4q/5QHg1mp6HigI+OyF9fjkmFsVJ0gWx0XGc+cerrwymcBt108cOJ4wy4oM+qGVyqjGA4btoQHxQOJnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iZWU85ec; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d50fad249so1342656f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 02:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729243260; x=1729848060; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/6CJlVFCdkLnXR5mIG5TznNaMuOGXx1zBL9Ig1xKknA=;
        b=iZWU85ecUfM5JfobrqRPohtE6Qaq+tJ4NSord7rOJxlYRdln2IuKS6HVBKTNMHDsp3
         gmp9ghZn3PSSunfL5ExtHg0FSdVDzrfz9+RY2cSBT9cCZsM9U2wPGEu2sCP4sUvL6EAn
         E0qB4OpnkJNeDd/y4Fy0FlS70JerECngT4o3n8UrgU62H947D4SHKJjC4tNPR/TaVJl4
         fOhoRS+b3oihaoNNlp9VSD+sWG8lEOKwpDotonmNP5EBIxsx3P1MENKu3yPVYW7y8Kj0
         9u1ByKHB/dhFIhnm6OEQ0MsVa1NScCVgFysJfroTCOVC7kvpNOUItbMWLORfjdiyTUqX
         4b0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729243260; x=1729848060;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/6CJlVFCdkLnXR5mIG5TznNaMuOGXx1zBL9Ig1xKknA=;
        b=JMI0cnXanLuvESJPivX2ve/iSPr18UdVckF6CbOPz4oqbzcrNb3/RlLJ0xmI5TkQLv
         C1js96EzZIkkStajiIWlY+8myHTxmDxKAP7VaJkzCbU450aCaJXu4w7IKGBCEKNcZDmp
         0ACyc/Pr/2WxS8f02l75EhTCOHBsrj2ZJGOyM2heQxzC4aCWjCFi1RvCpdYQZMosNHc0
         wGAnLxL4ipSG6qw5BzGo221bgv36qA/zvcg8iGbenArrajS/l1GELc7D2gj/kE3Ddqt9
         FsK9/f3WZ5JySixiQAoejK1WoJun0V06B1Xb5V/u3E1A5NsfjeNtgOsD4WYQAlMPDgiK
         Re+A==
X-Forwarded-Encrypted: i=1; AJvYcCUHbWNriBMWZwP92OrNrdft6NJgStx6fgChL8SDc6tBxHVZVbwrxTJQ+nRDMKLsl6Fq634BddwFVIp4pBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKoPe55YE0S90VYfeVwoLfAt2GmIdhvUhFUK4zxvQcM6gxn/4z
	ZrtOyI+gyNXH1j4iWnh6WSEXLbuCr2m0JWneDKtULyhRifm6HMqpBaat8bzXAN0=
X-Google-Smtp-Source: AGHT+IEjc8x6P1fiXZXvuy0RRWf3NASza2rMgKQJv+Xo7tziKvwCXEKE7ppPcNk2dKWu+ZlA7d9gqg==
X-Received: by 2002:adf:9bce:0:b0:374:c3e4:d6de with SMTP id ffacd0b85a97d-37eb47693ebmr1176601f8f.41.1729243259689;
        Fri, 18 Oct 2024 02:20:59 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:6e2b:4562:2d66:575e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf0eccbasm1390562f8f.81.2024.10.18.02.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 02:20:59 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,  Linus Walleij
 <linus.walleij@linaro.org>,  Rob Herring <robh@kernel.org>,  Krzysztof
 Kozlowski <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Neil
 Armstrong <neil.armstrong@linaro.org>,  Kevin Hilman
 <khilman@baylibre.com>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  Bartosz Golaszewski
 <brgl@bgdev.pl>,  linux-gpio@vger.kernel.org,  devicetree@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-amlogic@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: pinctrl: Add support for Amlogic A4
 SoCs
In-Reply-To: <4127b448-a914-4c69-b938-29512995326f@amlogic.com> (Xianwei
	Zhao's message of "Fri, 18 Oct 2024 17:01:09 +0800")
References: <20241018-a4_pinctrl-v3-0-e76fd1cf01d7@amlogic.com>
	<20241018-a4_pinctrl-v3-1-e76fd1cf01d7@amlogic.com>
	<4a79f996-9d82-48b2-8a93-d7917413ed8c@kernel.org>
	<1jttd9rein.fsf@starbuckisacylon.baylibre.com>
	<4127b448-a914-4c69-b938-29512995326f@amlogic.com>
Date: Fri, 18 Oct 2024 11:20:58 +0200
Message-ID: <1jmsj1rclh.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri 18 Oct 2024 at 17:01, Xianwei Zhao <xianwei.zhao@amlogic.com> wrote:

> Hi Jerome,
>    Thanks for your reply.
>
> On 2024/10/18 16:39, Jerome Brunet wrote:
>> [ EXTERNAL EMAIL ]
>> On Fri 18 Oct 2024 at 10:28, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> 
>>> On 18/10/2024 10:10, Xianwei Zhao via B4 Relay wrote:
>>>> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>>>
>>>> Add the new compatible name for Amlogic A4 pin controller, and add
>>>> a new dt-binding header file which document the detail pin names.
>> the change does not do what is described here. At least the description
>> needs updating.
>> 
>
> Will do.
>
>> So if the pin definition is now in the driver, does it mean that pins have
>> to be referenced in DT directly using the made up numbers that are
>> created in pinctrl-amlogic-a4.c at the beginning of patch #2 ?
>> 
>
> Yes.
>
>> If that's case, it does not look very easy a read.
>> 
>
> It does happen. The pin definition does not fall under the category of
> binding.
>
> https://lore.kernel.org/all/106f4321-59e8-49b9-bad3-eeb57627c921@amlogic.com/

So the expectation is that people will write something like:

 reset-gpios = <&gpio 42 GPIO_ACTIVE_LOW>;

And others will go in the driver to see that is maps to GPIOX_10 ? the number
being completly made up, with no link to anything HW/Datasheet
whatsoever ?

This is how things should be done now ?

>
>>>>
>>>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>>
>>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>
>>> Best regards,
>>> Krzysztof
>> --
>> Jerome

-- 
Jerome

