Return-Path: <linux-kernel+bounces-405538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E96169C52A3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A17BA1F222C5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 10:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D712101A9;
	Tue, 12 Nov 2024 10:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="R3BxD8MQ"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AF8210184
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731405879; cv=none; b=LonuAh+4QiRBc+kf5KoujjDzT7whmhWDxxR7AMsOjBMY6+c+8NsFy80RENAaTfTeSovxFkeSFSOBLoC/8Ewc0AvFfdq2LfrAUkozQ+3CthSWosyNlNzaB/x3ciyPnJ5R+ROS5336olJLegd6q28H/kr0cE9sFVk9hF9j2nqdtLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731405879; c=relaxed/simple;
	bh=Lky7EDG/REpPPiw8rct1MOXvKZzPhMNCA0wViUPzBIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d38KjmyVwfgzGTYbB9DRh/xXOZrXyOnfQUPk6tKTgH/Ftz9bhRszj3hWa+W0bByDNrQSoMfbCWlxPFgU0bxxwEa4kIfOuBdxDEnAw6HM0KSqVpf6/md6F/OGyl+H5pH0/4SMxyxdRooDgbCBoTO9lTG5QEOX3/lTZxB/Z9yT4+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=R3BxD8MQ; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539fbe22ac0so5294800e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 02:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1731405875; x=1732010675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lky7EDG/REpPPiw8rct1MOXvKZzPhMNCA0wViUPzBIg=;
        b=R3BxD8MQxLPgCLgc39Cg8nAc4tfk7yqlFbjqcZehVfxfUhcY+c7nVEYETatOioIo4e
         QrOi5lfLjHgHi3khn+WWTDt3WPTb4Tjzi5SRwumFZ+zT8vwVaPfRckpwg30CGUu2U0IW
         B6ERUQlKkKmbSXTpj/cqi//ZTagV+ldlher2xME81QwfWrH+a5c794Xsqz28RJSCLXF5
         QKI5tZoWvBn7RXsAP29h24MlnkPRiwwlikXTfeBmcDjFTg0gKKnMNZPU/MPkr24C+dfo
         k+fbTOF8n0Pxk/YCeUSR9d++gXau106A2ZRvzGTO6EfHClPzTt85nZrbeQ0DnOTkxXkV
         isbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731405875; x=1732010675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lky7EDG/REpPPiw8rct1MOXvKZzPhMNCA0wViUPzBIg=;
        b=mF2po5Tv5zf6Q1kSuNc5n7ZphIRSVmo8XZtUCBTgImGFbjXQXKPTGE9wWLeABbWNvm
         2C9k1+aTH2NkuLG6CRChPLG5GFCbDGQdExmVJAc3fAIwqZy7wnncyOLdxHT11yxby3XU
         87gMqPI8I4O2vnBveFEm8MQYxZ2R+54ZchBWl+wgU26188amHIBKXnHdbMqkRLvlqE1z
         y+IzvgfnTp5IarDLt+nLQP6U9GfzqBmn/gg3XEiLBI75Dmb0TU31KBEaxngucsvofosQ
         sAVKeAJYVpQcp/RwkR9ybuDSes0cnd0Q0tbjf1svsfReXeEm62qMHhdf4/XMS2grIzn7
         uCNg==
X-Forwarded-Encrypted: i=1; AJvYcCU05Aaoxd8MNKt3y2olod3tzFFrPhMD7Os/5MHU/K7iqU780XbdWx6YpWTFx6SQtchB+0DWMUs9kvUx7cM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwASSCIRtBHG77IKCnz/5I8dTn29Poqfsmr93J1U+iEuLpQ4RhM
	Q4/G2eh0TJKhaswp1iCvzQSPRYip5FyIYWuVZZAvvo8X7LSPRDkk32tvkZMHxA5Uo7mGT2cwQEq
	tZpRKj+avxrK45Zv1l88ZdSG8OzhVIq1M7D3aow==
X-Google-Smtp-Source: AGHT+IGPj6WMZ1mWnYfqUQi7z48ltE3m/RULiEy0hpxdJ8Vip5CZMGk1vI1DTyaqo5BSVjAeS9FP1W1qdztcMkyqN2Y=
X-Received: by 2002:a05:651c:512:b0:2fb:4b0d:9092 with SMTP id
 38308e7fff4ca-2ff201e6ddfmr60122781fa.1.1731405875299; Tue, 12 Nov 2024
 02:04:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015-gpio-class-mountpoint-v2-0-7709301876ef@linaro.org>
 <2024101531-lazy-recollect-6cbe@gregkh> <CAMRc=Mea=W-1UoHMew3Si=baW3ayERrHjxjG0NPdmkCfp9dUHw@mail.gmail.com>
 <2024101535-wrangle-reoccupy-5ece@gregkh>
In-Reply-To: <2024101535-wrangle-reoccupy-5ece@gregkh>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 12 Nov 2024 11:04:24 +0100
Message-ID: <CAMRc=Md6cnxz=L99aaM7a-zeHNnJGXm0P-rNJJ5r0WwRAwb2tg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] gpio: create the /sys/class/gpio mount point with
 GPIO_SYSFS disabled
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Kent Gibson <warthog618@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 2:46=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> >
> > What if we just add a Kconfig option allowing to disable the sysfs
> > attributes inside /sys/class/gpio but keep the directory? It's not
> > like it's a new one, it's already there as a baked in interface.
>
> That's up to you, but again, please do not mount a filesystem there,
> that's going to cause nothing but problems in the end (like debugfs and
> tracefs and configfs do all the time when people get confused and start
> poking around in sysfs code looking for the logic involved in other
> places.)
>

Fortunately no kernel change is required after all. The user-space can
work around it ekhm... "elegantly" by mounting a read-only overlay on
top of /sys/class that contains the gpio directory and mounting the
user-space compatibility layer onto it. I know you don't like it
either but at least I won't be submitting any such proposal to the
kernel anymore. :)

Bartosz

