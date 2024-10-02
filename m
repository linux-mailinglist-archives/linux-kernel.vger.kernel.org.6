Return-Path: <linux-kernel+bounces-347540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B70898D40F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DAC61C21459
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95921D040A;
	Wed,  2 Oct 2024 13:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SYdCdKe/"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D97A1D017F
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 13:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727874752; cv=none; b=so6yZVRH8wez+JDUaezYO+yQBT7VDE6MjEBOBts/nWqb8zXwnVeJ3Y7uUFXHcIbEOOb3BYDdT/4rB5+lyyviULWni8+85Xiqc6D1mPTkAJ121AvNvkPq0NggNTHUOUa3FoMdWhTeX6CCaORBxYQrl8D7lsXljRgelAteNo6gf3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727874752; c=relaxed/simple;
	bh=86TuBDV0vAhYuQnDZLlmLtjJ2pueFco3PS2XYXQtzzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oii6Zh425MtYccRlGXTJY8hvyg8UpwWadK9e9qkqg1G/DH2TAroVbxbkwGNAUAHWb5bIhtQWkOTXJnJAs3NKkpJhgvSYmR+ytB4UQdT08xYnufR+vLWu0+OmC6r19TGY0o9VCI7sJGJsr0vsmKCZUeW9EzIRbaiMJ6p2tq1K9o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SYdCdKe/; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5398e58ceebso781336e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 06:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727874748; x=1728479548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86TuBDV0vAhYuQnDZLlmLtjJ2pueFco3PS2XYXQtzzk=;
        b=SYdCdKe/zCU3Mc1lhCXCdNhC47E0EfGNHs3NobXVTFCH7MYm0M3bwLXiY2KRKyTFbq
         fGf33vXhYl6ufyCCWUDUm6+MsqvOKP3vsvfQsmlH05HVbet3M53ErRm/KvFCbZNZvnzA
         OwoFetB4M9wCCXokYohQnuDZmBd8eUj4nmbkh2bEmFdRQ4mRZOSticcBiZ2yCxBAZykN
         nDKxtjD2kboPrbJYQy72DewNz5hdqriV1qfAHOAHMnQRB+LfCXF1l1Q6a1FKshGma+jf
         ubuUkuiiOm7CQsamJ204N3G1bQtMRZnXyRpCZhAjaTpy+Z7mdIt/jHMPFkFC+s+qduEK
         HrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727874748; x=1728479548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=86TuBDV0vAhYuQnDZLlmLtjJ2pueFco3PS2XYXQtzzk=;
        b=Ax0qcD9r27xBUMbnP2cloETemSt+9rzo/LCrLWgCk9fSaJadVJQfYnXQO52lKwhYMq
         wG8eX33m5Jqg8sSxb4UVIYsWkLxd+B5a0MSuZwcyj2REdUvOpb1b2AIhfU7g8QIWHq0l
         jMFwfzkY4TQJt1wD/gc5blAneh0Pw06b2vu1DpNBMzVxFMtRLTAZ0dBXv144SolCAs7x
         5w+RdsMMDEuh7CpfY8tT+0oL5wm7gMqIUR0oe2TNL0x3GBY4ff+Q8bG+VCrAX0pdDK/9
         WhXCMD0/2LpJFO7pFHpOCRFJ8CvlBtdOagUy/36en/7kzGtVYuoqUjDpEfsLaAss3pNo
         d2eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgrW4nSWezFG5tAWh9jDujyPLnYCilAsqpWnSQHq+czWaFBqe4ga4Pwg+NiNirewgW/HdTfrDW3L2423Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRkAmO1KiXeGQTue7PIzX6v44PIbIcGZR2ye1VXiafF7RQsDMZ
	JDZO36qBhxpJBGA4HjG72l8cXNdIHzjbpGPYg/V9v9WEvVi2tDWjEN2ffDLuPAOWZqDVP/NWbv7
	FE5y8CLZYfjDVXXvpjxw5HlBQJSfNBuyWby4vpQ==
X-Google-Smtp-Source: AGHT+IGXo6veCPGVgUohayZbnucvoN5MkHSygvEuoO251m5v7FH27BZFsKkwA23paH7JFWH2iPbm6lW5dnbQppQuu38=
X-Received: by 2002:a05:6512:1596:b0:539:8fc5:f241 with SMTP id
 2adb3069b0e04-5399a294240mr2332739e87.28.1727874748249; Wed, 02 Oct 2024
 06:12:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927074221.9985-1-brgl@bgdev.pl>
In-Reply-To: <20240927074221.9985-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 Oct 2024 15:12:17 +0200
Message-ID: <CACRpkdb_1LrtbUssBEgYqOLgUY9XAbVBr+tezt5FCM3tdB9RYw@mail.gmail.com>
Subject: Re: [RFC PATCH] gpio: sysfs: make the sysfs export behavior consistent
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 9:42=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> For drivers or board files that set gpio_chip->names, the links to the
> GPIO attribute group created on sysfs export will be named after the
> line's name set in that array. For lines that are named using device
> properties, the names pointer of the gpio_chip struct is never assigned
> so they are exported as if they're not named.
>
> The ABI documentation does not mention the former behavior and given
> that the majority of modern systems use device-tree, ACPI or other way
> of passing GPIO names using device properties - bypassing gc->names -
> it's better to make the behavior consistent by always exporting lines as
> "gpioXYZ".
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

I'm in favor of this.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> Story time:

That's a good story :) Fun to see how you arrived at this.

Yours,
Linus Walleij

