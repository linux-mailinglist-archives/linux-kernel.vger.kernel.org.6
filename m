Return-Path: <linux-kernel+bounces-523812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F38FEA3DB8A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 097B219C242A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22151F91D6;
	Thu, 20 Feb 2025 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="QIjnlpuZ"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900BD1F4262
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 13:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740058961; cv=none; b=drri/L1OsxKQZ9beuZJ44mBDodahX33VQZYzhVoZBgPOwiLySF1xMNtIkJjQtq5p9FemZ4Byhy4gMwxj2Xd/IjbwaS3nuimgwpxIQoNHCp1/TgW37HexWXUdJg4KkmUimqxqIo0GckGow47s4zzPEWh/fga6BGKyZx0Lnr88y2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740058961; c=relaxed/simple;
	bh=D6ilmU1e0gmJQ4XQmzFLPc+miX+i/mTkflP7SE2H/e4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u3rsFqQgnH07vHs5bdI1ymaKdeYSsELdnK4ms7eNXB52iFQRID+XfyCxhCIJ7vDr3xEyN6kdqmmrx6xpM9J0Z6vRvLFxJUZ0zKfen3B5esiohdRMC2w/l5PZo+7CvV0mPkzKfkU0rkZdyt9UOYjGEuOwPdGHp+NBciXIYExpHxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=QIjnlpuZ; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5462ea9691cso1105612e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 05:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740058958; x=1740663758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6ilmU1e0gmJQ4XQmzFLPc+miX+i/mTkflP7SE2H/e4=;
        b=QIjnlpuZ95kgaJ5CQqDPYSshx35VPid2Xn/upCjT1NdAT9cN679UxP/8peYNnOmZlT
         2rPvbaW9V1bUmY5EFKevWkonvCBaRj7E/TT5nwFhGPOeq+LUEznPVP7On8zZcv6R2E4I
         SIZTf4dPiP6RawNmPaugi1fu4qhlRoWsyqPlwdEzmKQxbh9ejn8P8FNNxn7aG8gUDqnb
         D84e5syTO5GdDaGdLsyXDai1Ax22uXFgfOFZvpwlM/St5XshuVX2SYE4LEfjF2jFwb7Q
         i4FC8dmIz11zuIHXAd9zFssa60TcZpyRx1hEDUow1ZqKEdcrIpLDbjwBZD8k8mOCFHLM
         Mgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740058958; x=1740663758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6ilmU1e0gmJQ4XQmzFLPc+miX+i/mTkflP7SE2H/e4=;
        b=CVfEnztQyntIVbi2SmFxauOZLzPgjWym0o3e9KAE6cGgSTbzJ3NOFpHMNjMZPCz1Wc
         KQ2D1Y7Dyyglvqu1Sd9LBFOOyj6GEKcPnoVdno5JUFceG5+3IyiNWR8V0dQf/Ypa5m9h
         XishT2vYvsqpwkzLz2fToJMdsPRUrhSBZxevKrOwIZy2SkHWiFhU2oC2Y03ZGwGo1EuY
         SyxMVLkDUO/OtDA2UHaL+jH7p0U0QvkaRTKwkd+Zw8amlr2l7voUwJY5Rxu8ThNsmZgN
         oGu9aZt56BSmrzr7Y86BC8LZSXVo0Hf7IIpD6/2IvggZy2h0NKbyjXM+wXvvseiqZstU
         JPaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUASCmBFCTyBoevaiOIMMzxFzVoeLoxNQ7t5eZal0pHWoVnZPSosTTlY86DZspFGprLL8eKdKVs7sU3sCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfPTwPXEHYXcLOwq24lyKjoRPKde2zoAtGs6Msx+qYjV0Ij0DC
	nMyu2zxDstY9VivQLtE5xJ+TTY+eIR1/x8zoyh+kvsoMXNXpd57xlCJSB1G/w4HVv3+RE2W4xUp
	KPVFXFAoO2x+NTb2bkjwBRZXZyIFLy75ONkfIPA==
X-Gm-Gg: ASbGncvaGR07w5BFR8oWvbbbrmopLcv+NfO/3MzAcl3INbpto7e9NkazQrHikFYe5/y
	x5SvDYbHW/yjlJzJU2MnhW8iM4eXPa9UlawcCYI2VtY/XCgE+4xMctzdRbyFXpkCozL7AVzHbOG
	C/P8Fy67Qg2+okS/rUuaTlgQpJbJw=
X-Google-Smtp-Source: AGHT+IE/QljvxqQOucYkKkwJsqN1S8vDsR+44Cm6ZQGIEf/EuvBZuQI9TpJokvET0ulMZPKCYxVR86kKaprszD9K74A=
X-Received: by 2002:a05:6512:3d0f:b0:545:646:7519 with SMTP id
 2adb3069b0e04-5462ec7d6e7mr3495227e87.0.1740058957607; Thu, 20 Feb 2025
 05:42:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213195621.3133406-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdao27pu+9qFH2LBYNwYkBbWq1B-hE9nZGfTTCnQxhTiAQ@mail.gmail.com>
 <Z7crrgl2iFn34gck@smile.fi.intel.com> <CAMRc=MfSn6xB4eNkFG7E2gQPiF+AmnaidO5=FbvPtvW0N4iDjQ@mail.gmail.com>
 <Z7cwv0gxRFFGBjR1@smile.fi.intel.com> <Z7cxGOmwMIkkTRLs@smile.fi.intel.com>
In-Reply-To: <Z7cxGOmwMIkkTRLs@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Feb 2025 14:42:26 +0100
X-Gm-Features: AWEUYZliCPB3V_r_oONc5tJdN0FzpW2Pf5o6wREFCqkcv8bP8WF1k2YFby64Wmo
Message-ID: <CAMRc=Mc0gaRxOBDFXf2WB2_mNxaQo+UjCc6oTM-azLzV=c3VgA@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] gpio: regmap: Make use of 'ngpios' property
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Michael Walle <mwalle@kernel.org>, 
	athieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 2:41=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Feb 20, 2025 at 03:40:15PM +0200, Andy Shevchenko wrote:
> > On Thu, Feb 20, 2025 at 02:22:29PM +0100, Bartosz Golaszewski wrote:
> > > On Thu, Feb 20, 2025 at 2:18=E2=80=AFPM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Fri, Feb 14, 2025 at 11:50:53AM +0100, Linus Walleij wrote:
>
> ...
>
> > > > Bart, do you think it can be applied?
> > >
> > > Andy,
> > >
> > > I really rarely lose track of patches. It's been just under a week
> > > since this was posted. Please don't ping me to pick things up unless
> > > I'm not reacting for at least two weeks. I typically leave patches on
> > > the list for some time to give bots some time to react.
> >
> > I see, I thought your cadence is one week, that's why I have pinged you=
.
> > Will try to keep this in mind for the future and sorry to interrupt!
>
> Btw, if it's easier to you, I can just combine this to my usual PR to you=
.
>

No, that's fine, let's stick to ACPI-only PRs.

Bart

