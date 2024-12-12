Return-Path: <linux-kernel+bounces-442926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0029EE41B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 11:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69583188754E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 10:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF2C211467;
	Thu, 12 Dec 2024 10:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="H/Q2HDH0"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD292101A3
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 10:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733999362; cv=none; b=a45EBPzld0q0P3gMhrFgcUEkbrkGwmgTrUmAZ4AqDjU67NwsuLtGcQlgg1SAxm+hELjX1huanMhxRToPFXkxl90cYBG+KhwW6I+4whDEWrGq9hcZsxkNgQXep/VNvw1VvXURtMvn8SFg6MRQqWAz/CkkDXuFRyijoAeJRsKj0R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733999362; c=relaxed/simple;
	bh=iHa5QT8JkD1B/JMzxQ4HqhQQvv6uKOMk6Hbk4+UNj+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uIJBZboyVi3CD6+hjiBBxagRD5yiXy6980OrsuSsfRX2PF0z47s6Z7MGu0y2G1eyGIDIBj5byMNOC+RkeG7I5d8DzYFyGLu2surLaXG88QmjGkPxxCgnkiQX4L/jPy5AV3cehltuFgag0UsyLe++IMJ7NaFHdEygL/cLV/vc4gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=H/Q2HDH0; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5401c52000fso398665e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 02:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733999358; x=1734604158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHa5QT8JkD1B/JMzxQ4HqhQQvv6uKOMk6Hbk4+UNj+I=;
        b=H/Q2HDH0HBRV2/sPhMvMxj4gsuUcP/qJGF/ao069FSpE5LbZa6RYcCYPYrMA0whE2T
         l4f+tQIRstzzOOC9RhBDkdOVICe8xtmjBS662el58OVjeLVsn6vSJL+nPaBVVVbQeLE6
         QIA57MHEjX8EAcQgISwtYEdc7WLCA4aL1oYWzvoyQWrob9356mb1Q8sWyy/BYZXFpD50
         w1P90OaFIo0VaKoBGQTzYNEaO7KLfgMAMJkClvZr8oMgjRbXEo+Ozg7xZYKkZtVFdlc/
         QWitARsK/YTmE0pS/vAXJBPZ/0bHwIxqOJt4k2eG5UlwabzbsvsgDaxUYaKtUjBzCitG
         VsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733999358; x=1734604158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iHa5QT8JkD1B/JMzxQ4HqhQQvv6uKOMk6Hbk4+UNj+I=;
        b=YCma1Oe1axC4Nvs1ecsqz4NW7wo/eMM+z9GsmAgk0hQKtA7yIG4JVd3mW2OQYGsFVE
         TJbJRz7RBqVKtrRtb3Mlfv41rbtx7EUD6O8XtN9QKdcEvd5o8iE3gw+wHBYv4Lf6+L/0
         yvKhvz2onp8Xo5Tydp7HLiB8MlAD369MtlcZbOmDcxyc+j2e1PzdrlYpb5ht4tmIWvlX
         QeNse/a1NUqGvUVtDo/OpjKpkI508Pu6JjlJ75ywvWSVI0R+KGv8meKbAHwApz6RWQZF
         2pKPB/kL32vwqI4XcUc+w2Zwk7uSi3be6S0ssJLHs8QbQgEDHiPzyzjXThUIAsOXQv5V
         z9lA==
X-Forwarded-Encrypted: i=1; AJvYcCX1lypqiP/Qm1Wd9F1+R66afHTvFLVfLGrrel6StN9pA6fcf4EZ3dycM0USzPg/3bZcUHbKcAfuOLcT970=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw15kHdBcAKYg/NpUGr6YVmO8a9WWv4IdRe9Mv6wIlZLjVjZZpG
	Qn4N0CCINYdyWstd6og43HVCBahq+vxnWQFknVXXFY9vK1gvnF8WXXO8FbmyPIQ3c42bZ2Zg6fG
	4TfvU1cn+dewKXiw2sSeLfl02bBP49hUTNrD/V25VhfsKuV8a
X-Gm-Gg: ASbGncuD+MOjPKX+ccVc6dw5Vx4XxhxBjtZDCnC3Er3IN0JPVaaoIaygkUALsmHIaLV
	tXhcQSqjOGyYh2u2bU7p288fXYsFbUJGUvMMA0g==
X-Google-Smtp-Source: AGHT+IF5MRQjPv1qupkMKerR3TJa8F5ojOtH623jRIzHbwh2Yva4cWRDsheROKwicK7oG1R3ozY2p7TYivltOFVglY0=
X-Received: by 2002:a05:6512:3a96:b0:540:1ea7:44db with SMTP id
 2adb3069b0e04-54032c2f4a0mr306284e87.4.1733999358191; Thu, 12 Dec 2024
 02:29:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211051019.176131-1-chensong_2000@189.cn> <CAMRc=MfpwuMh-MH1UEHKky09iAs4g9=iGFPptARXzoZrVS8hdQ@mail.gmail.com>
 <efade71b-76ce-4dfe-949e-b231b3e411f0@189.cn>
In-Reply-To: <efade71b-76ce-4dfe-949e-b231b3e411f0@189.cn>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 12 Dec 2024 11:29:07 +0100
Message-ID: <CAMRc=Medmy5EqTUWuQ-4YrQamOArKOK788iAY-=Cy42Od7y_Sw@mail.gmail.com>
Subject: Re: [PATCH v2] regulator:s5m8767: Fully convert to GPIO descriptors
To: Song Chen <chensong_2000@189.cn>
Cc: krzk@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, lee@kernel.org, 
	linus.walleij@linaro.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 6:55=E2=80=AFAM Song Chen <chensong_2000@189.cn> wr=
ote:
>
> Or we can use devm_gpiod_get_array, it's pretty much equivalent effect
> in s5m8767 even without fwnode specified.
>

Can you use it though? I was thinking you need the fwnode variant
because it's the child (regulator) node of the device?

If you can, that would be great.

Bart

