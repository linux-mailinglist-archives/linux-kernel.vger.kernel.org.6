Return-Path: <linux-kernel+bounces-423017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1979DA14D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 05:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90B9D283CBA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 04:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F367C13A869;
	Wed, 27 Nov 2024 04:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWSDBNHP"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAF128EB;
	Wed, 27 Nov 2024 04:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732680350; cv=none; b=VlddcrBqT8XKco7X8T1vUerUsUU4/GoMx0yAcFy9VZdlHlRp0vpXYaiAgwFbaL4X3qzUdUpVe/vLR7YQuRvMvOca10t2Efu1J6Re3/jPf1xwsIaNLPBmYmsXKYvNu13kgbI8qPVdMD2PLQSInY+r6WpxJnhZyEdq5Di1QBn46Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732680350; c=relaxed/simple;
	bh=eGMgbMDKyJQFsX2FhhmL+N7rAH4Be2hXmFG8guEZ4I4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BgdPi4gveb3yXvEzs9X5mA1sD0JYrZfkVUsRih+pA2kUviPKy9Ast/3Kul0rETmKkvp3pRvtKDGFpxDolR0uCL7APGzIEhyGDMcmzTvIbtpPh4pwQdFwZ3rJMuJCKJZK7PG1M9qXQwopB2M7zsh6cHv1XOABZxUuJY3YqRmY4Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWSDBNHP; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3822ba3cdbcso3931556f8f.0;
        Tue, 26 Nov 2024 20:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732680347; x=1733285147; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGMgbMDKyJQFsX2FhhmL+N7rAH4Be2hXmFG8guEZ4I4=;
        b=DWSDBNHPZk9lVUMnWDMJQQ2stuGjqio+OTlF6yvE2Z012k0rOYuKaHhfHUe9be2kkC
         42hgVl7RGDuAZzAh6/5mXJOmAcB/uz/evWP4IBexY7rdXqyRMZ0BLqiB9wZY0FYoA/Pa
         yzBf46zxjGxsgxFCoXBGZxOvijlhs+aJRQbVX9gAwMoEp0QwgftYxYPmkK1UWzcK1YD6
         7EoxPKQC3BblJ+th+tEy7KjUID2dvOvHGbUrk59tA0fbwHPOhMxy+4L/z7JywJYCC+15
         RO+bRBib/ucdHK8Cm5kbghEkB/WLdiYmeg07/HAIaRSZmpEtEwiD6Zn1JkRU5WDe0YKJ
         JMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732680347; x=1733285147;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGMgbMDKyJQFsX2FhhmL+N7rAH4Be2hXmFG8guEZ4I4=;
        b=mr/szQyVA6M6WXRyx9WBwYD8w6M5ZM5P2IC6eHppqutSYWh1S12Pj7nirlJTKZHDI3
         18KJSjFdJXtsPjr76I/RJrx+gkvOCt9zrLgLcx+sqBwHzOGcJZhoO+mVVF17H7fd96zz
         2UZjTjW8nS7grNmz5guF0e4+Rg1jT5JsjKeu3b2fxQSdfzEDlhSKhba7xiIGTMyc9fUj
         4Adlk8ivVocR4oq/dohO8kP/GbKeTCGFHbRpmdj9friQhr+R5QUezPSEXH2cWUwCv93P
         qD3FOUm7s62Py343R0mz/VUpkaSAG/NUXOaNf3w50fUm4wHFYTcki6wF/lPY/nwjrzUh
         +B1g==
X-Forwarded-Encrypted: i=1; AJvYcCVdoIqQfl+o0cY7U/y4kM9kg23KlV47PRnIIT6MJ5jbsQnSBJ+U0bUnCV6+t8U6y6pu7GqcPdH+ei25@vger.kernel.org, AJvYcCXLmjl03fBJoxZPdGiS66K8JZLAdlHXQnNHr3QS5VRSkQaIGJJEEpG1NRqG/EWiaoJrOSfvR09IkFp+DaME@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz8HhJRVK58l1K5wwW7zSisbpHID7zSDjHHoLcA8HoTthEcMsD
	CCl6QppqsaeSeSbcwoplQmAMA4uGEUAGBFv0HtEa54pEiApbFHs/
X-Gm-Gg: ASbGnctQsFfc+ccfYex+RkSzzY4ly7CKUhDKErJIf/b1Al9VbDQFjMKldG9wnfji+O9
	7q6AcPupa72b1zD5heEsn1ANQQseUEE7raxtvenhV6EGj9zR/QWxuORNduszyDYzNcVGkErrqMq
	EcTJ382b2e+frfOEf73WJq6xrx3pzrHi3heuiJU7XBruL+oOVGfkChtzIuK2/13twT3D1YKpgn5
	OGfe8KiE4fbKhGab9Fgzs/nQXqipf4t0LtZRHdwaqaCJ4A2M67dBF352KDk6bkIMlbfe+wy
X-Google-Smtp-Source: AGHT+IHc99eGtijXfEAq6+Nq0ctt6V5ES855jF/j39G6AUo9KVVVWLSlAJEn/iJyJYwFhVzX13IpTQ==
X-Received: by 2002:a5d:59a3:0:b0:37c:cc67:8b1f with SMTP id ffacd0b85a97d-385c6ef477amr1008941f8f.48.1732680346883;
        Tue, 26 Nov 2024 20:05:46 -0800 (PST)
Received: from smtpclient.apple ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fafe504sm14932923f8f.25.2024.11.26.20.05.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Nov 2024 20:05:46 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH] WIP: arm64: dts: meson: drop broadcom compatible from
 reference board SDIO nodes
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <027767d4-89e7-4665-b840-294a84a89869@linaro.org>
Date: Wed, 27 Nov 2024 08:05:33 +0400
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2B479B54-2784-4D75-BEE8-23A52EEFBF17@gmail.com>
References: <20241124083453.900368-1-christianshewitt@gmail.com>
 <027767d4-89e7-4665-b840-294a84a89869@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: Apple Mail (2.3826.200.121)

> On 24 Nov 2024, at 8:11=E2=80=AFpm, Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org> wrote:
>=20
> On 24/11/2024 09:34, Christian Hewitt wrote:
>> Drop the Broadcom compatible and use a generic sdio identifier with =
the Amlogic
>=20
> 1. Heh, what? Why? This is not really explained and does not look
> sensible at all.
> 2. What is "generioc sdio identifier"?
>=20
>> reference boards. This allows a wider range of Android STB devices =
with QCA9377
>> and RTL8189ES/FS chips to have working WiFi when booting from the =
reference dtb
>=20
> Please wrap commit message according to Linux coding style / =
submission
> process (neither too early nor over the limit):
> =
https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/sub=
mitting-patches.rst#L597
>=20
>=20
>> files. There is no observed impact on Broadcom devices.
>=20
> So how does it allow wider range of devices to have working wifi?

Sending patches while recovering from a 100km Triathlon last weekend
resulted in some formatting and submission mistakes - sorry for that :(

I=E2=80=99ll send a v2 shortly with reduced subject/line length and a =
better
description of the change and reasoning.

Christian=

