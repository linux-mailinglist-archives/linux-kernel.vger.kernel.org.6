Return-Path: <linux-kernel+bounces-214873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3454908B60
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 14:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A95AB21CA0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140DC196C8C;
	Fri, 14 Jun 2024 12:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c6e+MIqG"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DCB195FE8
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 12:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718367282; cv=none; b=TlIwhyP1Zm55PTaD1NBAmLqHLjWlBAPM5jQ9/Xf6uQJgrl2yx/ONS+Hh0n07WHga25r/mZIKfuZJC1VcYDUhoiMeP9k3DePA2gWZthaqFOEiwj+4vXZ7fvLZuQpiEmaNzXksupykYOf7KMjYiAai6eU2fbr8ptK2kh061ahtKcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718367282; c=relaxed/simple;
	bh=UeIz4uU4kZAhCILh2YT+bY1os8za4dxW/SfvNJ0sd/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jba50Urgq2dzR+SX0YstM/IQUv+NMPrA5fTGtJtvMU6qdeEdyv1TwbBpNDws6p9fkI4w7AUOSH466gZ4KoYtzbtGf/+/nYgzmSkRiTK2rb+LW0zZW+/eOPp0fRflDP5rjYiLaAlMpc17NkOFOxk+JHpWq+OvClWfHvQ4423y0Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c6e+MIqG; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52bc035a7ccso2328000e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 05:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718367279; x=1718972079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UeIz4uU4kZAhCILh2YT+bY1os8za4dxW/SfvNJ0sd/U=;
        b=c6e+MIqGUC0Viwf8qStWLKm+KW0JHcw+e7FjluKyvpA+Y6VWoXq5imyudd0sT0xe78
         70a/8omNLpgoxKDoiQXQplH4Hwm9DC0+zn3+VQJG3E+wGl1ZNqeV6XNqMWtUtWSCsLzt
         VsEFkOVwLafWx5PgZ9a24kU5udruMzQLtcAydsV6RNVuQcTzi3YRDZ/oSPIGCDAKm59D
         pRgrtOob9DGtyocBfA8mJjK7IGTQw7/McP/PRQ+yHQIFbUX4pGPYxIY9ocMJoiD6H6re
         qEyyQTOB7sS9p4jrFKFFLjhu8m7IcDy/nboEt1ZIBoT1/O2+nAq7bCeM/B35SQu1nVe0
         mtpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718367279; x=1718972079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UeIz4uU4kZAhCILh2YT+bY1os8za4dxW/SfvNJ0sd/U=;
        b=cl2FBicdLBQLNTq+MuQb2+KZWnQ+lCa1dDd/VYPUgg+2eMLx4Z8AtGs3ysadp+ZxgB
         +SOjktAC1o2oe/v19N6pCllGvwZwdBGBKKM34esrv/oj7md3uxRyKfCHzXryUjCYCB/h
         WnQfKtkTlJSOQNt+wt8ocBO4wvRwHdU2wGuG7ErlbDf/Ej8Dy2en9lnR8Zaeug0gYuz+
         vmVEPhq6apZzaOtjJXy1CrdBXGAoAmgc6auywN/rdn9BKtPZX/2Z68TI8DyKXH2emwBc
         Kerzk8tuOYkVbSj1CbbXQ/kc0wjX03ik9Mkuxah/F6howoQ/Z+zKFQi/EUYzeCvQHWht
         jPxQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2bM/6ePbEJZHNvTS3nY1AwFrO146u0biEMRU3Is93Ao0AY5kOdHSnwg8Gt89lF0nMIOtUjuKJXVP524BONq+aAG3Camll8nmtFgTN
X-Gm-Message-State: AOJu0YyJq3FeAP1h6G6v/+ef3c9vuckDBBbfcCAUl+oi2JHeZYEdbrR+
	HpagqZdYi+oyYQiQ70iEs51Esc66kq8kZVjccWSeWejYfyzdYu2tsn4wRWcG+No4GeEm5BqhOY6
	9Vw3vKNPNmQrZEz4a+kDO659Izguq2px0GPsnTcifExtfviet
X-Google-Smtp-Source: AGHT+IFaxCTVrnHsD0s5raeXhDL6tWd0FwAoXnrdVcIz+EXgoHNwqTOyJh6q+ZBvtPjCY+PsQDhhi0usOpQGjDVCmoY=
X-Received: by 2002:a19:9107:0:b0:52c:9d68:7425 with SMTP id
 2adb3069b0e04-52ca6e55b90mr1516079e87.14.1718367278806; Fri, 14 Jun 2024
 05:14:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610112700.80819-2-wsa+renesas@sang-engineering.com>
 <CAMRc=MfZ11U+kAh1+K=DxtJ=QL+cY7Q_sBN4sQDF-RNgjpV0QA@mail.gmail.com>
 <jvnvx7a4pn6evrp5ehfrt4qsiuprq6ogvrue2a3uupwtydmgcm@2rvat7ibvgb4>
 <CAMRc=Mc4__0zzJZG3BPnmbua88SLuEbX=Wk=EZnKH5HQvB+JPg@mail.gmail.com>
 <CACRpkda==5S75Bw6F3ZLUmf7kwgi_JkByiizR=m-61nrMDWuvQ@mail.gmail.com>
 <ce1d8150-c595-44d5-b19a-040920481709@app.fastmail.com> <CAMRc=McpRjQO8mUrOA4bU_YqO8Tc9-Ujytfy1fcjGUEgH9NW0A@mail.gmail.com>
 <CACRpkdYtLDA3518uSYiTpu1PJuqNErHr9YMAKuar0CeFbfECPA@mail.gmail.com>
 <CAMRc=Mem6HN13FOA_Ru8zC-GqGGLTsQiktLWs5bN4JD1aM3gHQ@mail.gmail.com>
 <a7463c6e-2801-4d0e-b723-fc1cf77a04ed@app.fastmail.com> <slpwvai5q24qwymh7nktihvykmlhi5j3nhqjxruxb6yacruu47@27b7rhykw2f3>
 <3bb9b39c-c15f-49e3-987b-26cd47e05f3e@app.fastmail.com>
In-Reply-To: <3bb9b39c-c15f-49e3-987b-26cd47e05f3e@app.fastmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Jun 2024 14:14:27 +0200
Message-ID: <CACRpkdaC6i54qUfJ5H16m2wQhR89bXq26Pn0rZ-80m3a60-_mw@mail.gmail.com>
Subject: Re: [PATCH v9 1/1] gpio: add sloppy logic analyzer using polling
To: Arnd Bergmann <arnd@arndb.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Kent Gibson <warthog618@gmail.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 1:59=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:

> Of course we don't want to make it a first-class interface
> because of the reasons you explain in the cover letter,
> but it would totally make sense to me to call it a
> debugging feature of libgpio instead of calling it a
> standalone driver.

I second this opinion. The logic analyzer does in my mind
classify as a GPIO debugging feature. Surely someone
debugging anything connected to GPIO, such as a key or
MMC card detect or whatever could use this feature to see
what is going on on that line.

Yours,
Linus Walleij

