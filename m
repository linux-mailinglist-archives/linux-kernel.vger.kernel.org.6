Return-Path: <linux-kernel+bounces-567861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 973D8A68B5E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84D851659CF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 11:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF11325A354;
	Wed, 19 Mar 2025 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VufXH5Rj"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5928725524F
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 11:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382824; cv=none; b=RtKwqNyI1vBqoTYfoENT4b3BcNb/dRzSzW6ZSmzeQwYq87fK5eGbVZt64RKCa1soRQT6WhjnBGGJ4w/SVg05y2y5TJIRH1n55hjH2S8eQT30F1+C7LDphdTpc7op8XGmrOvEmga43atOs1jN5gUo3EfeOJTLrE2NifdOW6wq2bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382824; c=relaxed/simple;
	bh=eM1NFwNHExQMu9IqlxfrNERkiCBjA0eydss8KyJJbgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MLz69q1b5YGHs8nsRUYPh/0ipQGcXkNkEztjZlnjighpz5JxwbmkOWSHhltqU8FSLRqi5mo2h7PwGtD5J0U15mqwfEi7xHO84dRpoeTjzj3jx21MPK0P6VIuS6QyfgJq2/xcgZ2XcuAQoiPotAeahEtDF2gq1EtzNVb/fbXlnME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VufXH5Rj; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30bee278c2aso6768571fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 04:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742382820; x=1742987620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eM1NFwNHExQMu9IqlxfrNERkiCBjA0eydss8KyJJbgQ=;
        b=VufXH5RjCnSbxJndaVGG+arlQNRDtC/uzxFIp9SbOng+sOLtgmCDOYrJe+kee9PBuz
         jkrkcAnNxMWMoE+qKsKrd8EzM7vSIMdS1+jWzXWEij7A02YN5Yn2mxzdHmDgckYljNVD
         7H31c45EmsRQvM1ei1KA3sRohCMC2UZbFLo5W+oa23wGA7xohspUO/z8Gk1+C7yfg9rs
         SSyM+OWDQ8zLo8cYL7DdcsFag0UgciW32k1EiJS3RQg99vcntU0L9XEmP5pG40ala14n
         bYpOQ68slv/AjQfnRFmZmtwelvpN8e/5Twpbr7HqbOX/GqnkSQc9LXm3b7EupxeqEOd3
         XF9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742382820; x=1742987620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eM1NFwNHExQMu9IqlxfrNERkiCBjA0eydss8KyJJbgQ=;
        b=ay/2PBkfeHiElgW8QDFUFpJM+kyIeqCT181kcEVkAD87e9cfqZpXonv1+MtWb04eq9
         yWx0g7opb1AjfkRrrE4BfghF5/a12BEGZjUsb35t5z49X6iIdBEmd31codFkjTDnlVYj
         AlhgjebSMOjTzP4JqCs8pl7pZc/MppqEdHR0sx9o0VbW/HhmdPUu+yIopDEfVbYaBbCh
         7JXAulMwZzb2mz0FdQzHPAWkkYNaR+KVzIE5VJaDG4IoeU6Igb26FF5NG8cw5p1+/ixU
         lZAc5PV8Jy0F8zSOtP+1cy+9deIJ9YH5sHnV4WcJaWotM5I/XQxVOxSHzRreanaWtyqN
         shQA==
X-Forwarded-Encrypted: i=1; AJvYcCUzBYuKG/XUzVVK8j+KyQWEpg9uGFlN2SnAPW4dtWRzZ7SgGN9UDFKNIf2JV85N5SLevnOi3H5sTT7PERg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyioP9QXqyX8s1NNho1gvz7z0FwUDZDZcjdsOM4Rsi7w8Uo1ZcT
	/fLcDrOPp32QJLUsJ7NZHGI0zMgrGrY88GC77motcsB4NiJ7+yel+/OnrYVufVR6iHy3NNf1PFc
	VSnUNkRyLBjCTXfDZETJ7nE1Ied9Sq/L40wAwsQ==
X-Gm-Gg: ASbGncsYTX/3k29iNjVxh70nSHuoplAoN9oITmp7/2/WmRlnCzBaIrcutyNDw/iDMS6
	c4t1EfpVu7sZCNln1eAWnYA7PpdtIebRsx0VlpZJY9ob8oeRQ4JPfcQ5uCcbvh3PYQmAplCswb+
	AF+7Q1M4b4VCY4npCyHUO96cV3CQ==
X-Google-Smtp-Source: AGHT+IGC6Ct6HFPL2vEp9At/inBMPgzs8sxHCIO/aS1qZLyW0rZUkecws01dh5D4an+xPjvVxC7ooHe2QmSBoNRyYSg=
X-Received: by 2002:a05:6512:3da7:b0:549:90ac:cca2 with SMTP id
 2adb3069b0e04-54acab43be7mr912779e87.1.1742382820322; Wed, 19 Mar 2025
 04:13:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com> <20250318-mdb-max7360-support-v5-3-fb20baf97da0@bootlin.com>
In-Reply-To: <20250318-mdb-max7360-support-v5-3-fb20baf97da0@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 19 Mar 2025 12:13:28 +0100
X-Gm-Features: AQ5f1JoKYGT4lUy8nZOG2LsqkFU5YAmf-ngKXbzyf3RX7_XIhXpPO4Vz-qGj2r8
Message-ID: <CACRpkdamZV1ZHf8JNLMu5zby4O-NRwES_F4BCd6DByytSKSqCw@mail.gmail.com>
Subject: Re: [PATCH v5 03/11] pinctrl: Add MAX7360 pinctrl driver
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kamel Bouhara <kamel.bouhara@bootlin.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-pwm@vger.kernel.org, andriy.shevchenko@intel.com, 
	=?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mathieu,

thanks for your patch!

On Tue, Mar 18, 2025 at 5:26=E2=80=AFPM Mathieu Dubois-Briand
<mathieu.dubois-briand@bootlin.com> wrote:

> Add driver for Maxim Integrated MAX7360 pinctrl on the PORT pins. Pins
> can be used either for GPIO, PWM or rotary encoder functionalities.
>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

Overall it's a clean and simple pin control driver, so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

