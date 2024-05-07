Return-Path: <linux-kernel+bounces-171198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0058BE100
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 13:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 782BC2847AB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A14915250D;
	Tue,  7 May 2024 11:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqGBT+06"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC731514E6;
	Tue,  7 May 2024 11:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715081279; cv=none; b=QEp+lgI3QvuhPT2aFple18yIxUZBudcAuzRwzmEsMzpTRJaIckqqMmIdHTmiWXVGmiq9klGe6cTiATKzTss4BvNfjsKzTz2kewcLY+4SMEvobsGU8o6wieikC6ZPZ4HWDV7Cga2IW56Wc2K0c2VzWqUdLVtY827YKw4tIfZzWiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715081279; c=relaxed/simple;
	bh=KemOQ3OEdXs4N4TiysfvGJ8uvPz0kTFQBgkdhCVp+yM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NMAfynJLxAiHymCXbr13SaTnn9c/WSXJ5qizam6sRqSNGGn2WNlrU3nwRgYD6SmwFAfgKptYxChqFfCsVzqNZoh0S94PzMtix1cYF7dreucKQ53fyzRZR61yn8rVlhOF/Cz0j98lejVRBFp53rwRbBwPgP36T5lPjal1ECMslbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MqGBT+06; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a59c448b44aso555602766b.2;
        Tue, 07 May 2024 04:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715081276; x=1715686076; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hbVTAeRTrLCTl9qsRyOsPTqbHQbwmcvwqOAgl6yj31c=;
        b=MqGBT+06QFWAS0rJ3du76g9VW+e9FSFFP0hNwh1JosAiEKJEpOVcKBP1X9Zp9srFqf
         qUjuyB84xGjq2sAS7LLOa66h0JIpmQ+TyyxkHlXD1kkADb1ytjyQbD8hYtnYmGnBj+jX
         A2a2Q4jdlGbpr2MwY7FDZAznbxBxnNzBc6vpj53kKoXMe1+mxIhInrV33o3RkRladeAl
         r7OwDFiCqw2lFM6TCU00blic6smEL+WMY45mmZ44gS+MlgjoFUspfzI0pQlkHJBHseIb
         CPC0Ixz2E/4EQVEoIjMka2e/iptyZsSg5mPyPH0brYZXNSLL+HNZAtNlXJpq6pUREYUb
         Z7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715081276; x=1715686076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hbVTAeRTrLCTl9qsRyOsPTqbHQbwmcvwqOAgl6yj31c=;
        b=TZCLe/q+SI7FeKLSKvPNdZFMJkSZn8kpnTqKpH9RYWa40Ym6qm5FOIvjn2HsLwUTR1
         29dD4UsdYH1/3Ufu2Z79AhJnqNAaDQEHRl9mMH6kRY0NQW4gFgtf1XjkuebuBnCHnaWf
         8Z6nT2FskkidRdhZjjxXtBXLPGJyHVr25kSTwJm2P84zx+MPQnlwTooiFZYqb11lSOnV
         Lui2JVfM4wTgjK3TIhIhihR4ucCvyojXqKrrHE9D/6DRMOtalkWr1FYoky7z45gTdpjM
         4tFmduq9xHfFle/T8jG4nQcNol7Il/Y3R1DJseV8E825O5HVc7qg4c4UpTSXICa6nOoj
         4Jnw==
X-Forwarded-Encrypted: i=1; AJvYcCXO/BVRo+I2PyahS9m49EyGuHe1PktCC8589AH2LuGf5fUjX4IfuVIxKWigJcrc0dU+yposizrpXaRi8engm7Azqp1AvyP67dYgOJf8
X-Gm-Message-State: AOJu0YzFw/cKCVWjoR5Og36RdEoWxjUiw8nLjBfczX3Qs1mRsTyhvKq1
	Riwevrr9BwI3OLvNgfJaeSw03zvhPkQtsG2Y6lf2nwEH9RPGQ0I2tQsIu1J+qZoqjUIQafnSEu2
	evntPQxQHwO7xGX8cDs7YhDo5z8W4OZ4d
X-Google-Smtp-Source: AGHT+IFC2cfEQaM4xKdTt2kGk9z+vAhIvihA6thMi3zCsKLgKOVUgsSzNY5n22HGqmtSy6tS20TpI2kCpM3YBeXZbI4=
X-Received: by 2002:a17:907:72c3:b0:a59:bdb0:e9eb with SMTP id
 du3-20020a17090772c300b00a59bdb0e9ebmr4275573ejc.77.1715081275868; Tue, 07
 May 2024 04:27:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240503154324.517246-1-linux@roeck-us.net> <20240506144412.139300-1-lars.petter.mostad@appear.net>
 <f0a2ce94-5610-4f0b-91ae-2d16d1b80dff@roeck-us.net>
In-Reply-To: <f0a2ce94-5610-4f0b-91ae-2d16d1b80dff@roeck-us.net>
From: Lars Petter Mostad <larspm@gmail.com>
Date: Tue, 7 May 2024 13:27:44 +0200
Message-ID: <CAC-Dm24im6hB71ijDS2rtO2W5ZEdQ=LnwGGzR0Oxir2=PA0u3Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] hwmon: (emc1403) Various improvements
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> It would be great if you can reply to the patches with a
> Tested-by: tag.

Tested-by: Lars Petter Mostad <lars.petter.mostad@appear.net>

Of course, I had to do some light modifications to the patches to be able
to test on emc1438. I will post these modifications as an RFC patch once
the above patches are available on the hwmon-next (right?) branch.

Note that checkpatch.pl --strict fails a couple of checks.

> Also, could you send me a register dump of emc1438 ?
> I'd like to use a real register dump for the unit test code if possible.

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 2b 2d 00 80 06 55 00 55 00 80 06 55 00 55 00 00
10: 00 00 00 00 00 55 00 00 00 55 55 00 00 00 00 00
20: 55 0a 70 2d 00 0d 0d 00 00 80 00 00 55 00 00 00
30: 55 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 00 2b 60 00 00 2e c0 00 00 00 00 00 00 00 00 00
50: 55 00 00 00 55 00 00 00 55 00 00 00 55 00 00 00
60: 0e 00 00 00 55 55 55 55 00 00 00 00 00 00 00 00
70: 00 0f 0f 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 6b 60 00 00 23 00 3f 13 ad 03 20 02
b0: 20 00 00 00 20 00 20 00 00 00 00 00 12 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 59 5d 00

Regards,
Lars Petter

