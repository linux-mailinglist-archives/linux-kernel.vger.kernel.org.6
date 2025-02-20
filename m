Return-Path: <linux-kernel+bounces-523863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB08A3DC2B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9ED727A74E3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BF11DE4FF;
	Thu, 20 Feb 2025 14:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="E9Cesglt"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192271B85CC
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740060678; cv=none; b=jQZAOMPeqNZq6+cLBlQuDvRc0Oy41YgmvSV9+pSwUSYNrucfPlB7AII11+vcnNE/tDObKnLPcE4A7TnvD49/CEZbaaagGSAJUlBfdHJR1MyiKgOXHIQnXeLWY4CYYqVow1rGQcCgESqV51s50fQsHo+ib+6lHLwKp/MroLaoQZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740060678; c=relaxed/simple;
	bh=D84La+FZX+T3BhihEP6KqrPV6UfjhGT/+lhO0X5r49E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u/gAiLijTkhf3Mgn9KevzYD1UtNniGt5bOZKfYiTsqkWkv/evJs9Gist36U8xN5NysnacO+vckGTQ9UsomjjtmkmzFY3HtwcfLkGbauJkPCyqjEZOfe82orFghbR8HiVhEW+dl/0SRftBlWbALEIXdovVd1o3gFVyUadWRjQvXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=E9Cesglt; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5461f2ca386so854965e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 06:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1740060675; x=1740665475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D84La+FZX+T3BhihEP6KqrPV6UfjhGT/+lhO0X5r49E=;
        b=E9Cesglt93werXtv0olMlcxKqy/jD+FjePWfRktzJk1E41WnsETJIqSxi5lqIuajmA
         BMGSOn4uUtohd+sVHjWAd2WUmHyZtGsBjX3tknMOJcjiKRkk/gbCfAvkhAQ3xjDglJ21
         i3qnW7FpRXumw3WCtwZkP2SkMGrumd9boueaFQtA9SjP9zXRFWN6XXGvDE/rHtnOkJjp
         5lfYjrfQ4zS01Ci3TgTV8787Y4CRGukrkBX+nooPjk4s0+Seiu4i1dCDdroGdgOfwv8l
         YumCSAyS4l3GsIRbIOGfi9BJU5MJwW5qxuQBTy2tsf8jLhDDLi2cMCMTxrJKaQgYa4y1
         A+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740060675; x=1740665475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D84La+FZX+T3BhihEP6KqrPV6UfjhGT/+lhO0X5r49E=;
        b=p3nwjp5uTVmXrXVo/KxmCD5jEURvecI90pXfKnMKff6xJbp78hkEb7jaapub6g2qz9
         lwukMf39qFQZYqOFwI6BbcjWhqEbYjgGkhHssl8N7UtcbohZHWc6kxq5YIvrLegqsTgY
         0dJP0jmC/G9tHfJ0bDm0KkUEnOHRz0SgQ3Bbt1MGsNX3gWdrLejVs+W6hhABO+uV0/Sv
         l799MIoC61o4+ZWk8JDJRqgaNHLVjcuh0GV1sLLMbyel3aSp/uSe0i8FsAyYEi2fb1/j
         6o0K/zPxSXCAdfDsaPTsI2CdxGRaQFLWibPb8DKSNAS7xVzdBLF0I1yQhD9O6mSBb84a
         5mzQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0123C1GiPI4KEy4Vjn0S0kqlmcKL7tzAimiNn3uAKBd64fFDRW9XPsK+l5AAwphJYUF/iiwW8NTmCUso=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4vpbdEcLSheNLBNlddaI2QwIy+e2581uwRbf8yL+YaLWq+BZ0
	WGVyZ+8ZbPlGvjmGLCVroC8yvvdBNKNkjSLfla6qxokCguFnWZPgLaGO6gta326j8W30R3goaFB
	onxHeeUOqhzO2YYzdG0qd0etvC9QwQc7Ry4c5ng==
X-Gm-Gg: ASbGncvLQH5ApKwhuGuG/Vs/cGn0MRtKESTg/3xZDo1win7H1fTOFYtaDEeFHmsdjw4
	6Wm6MsRXlQ2HccatY1SuQcNj2x+MQr/QQVT9qZ8ftJC4jHeXsF8M66zIjvieS+7juNCYPADDFOx
	0MaY5D9uzcUX+X3l0bQ1qqWtyxIxs=
X-Google-Smtp-Source: AGHT+IFX7TS5KlNJP6wwwhX+vEjDQzGBHd5DUoKERp4YFmcW66414sQ/5EW6kjCkFYSw59mRMeSJu2eYmY92sjQ5ZDQ=
X-Received: by 2002:a05:6512:b0a:b0:544:ffbe:cd22 with SMTP id
 2adb3069b0e04-5452fe8f8bfmr7169309e87.46.1740060675084; Thu, 20 Feb 2025
 06:11:15 -0800 (PST)
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
 <CAMRc=Mc0gaRxOBDFXf2WB2_mNxaQo+UjCc6oTM-azLzV=c3VgA@mail.gmail.com> <Z7c3IhC115rPbTMw@smile.fi.intel.com>
In-Reply-To: <Z7c3IhC115rPbTMw@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 20 Feb 2025 15:11:04 +0100
X-Gm-Features: AWEUYZn0SG982QrT8tRmd7an762Y3uM2rOO25QY3qtqimqDOvruzsJbqzs3FxM8
Message-ID: <CAMRc=MeBCQrm14TiH99a-xLo5PMah9W05TO=8mzsxfXFXGjazQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] gpio: regmap: Make use of 'ngpios' property
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Michael Walle <mwalle@kernel.org>, 
	athieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 20, 2025 at 3:07=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Feb 20, 2025 at 02:42:26PM +0100, Bartosz Golaszewski wrote:
> > On Thu, Feb 20, 2025 at 2:41=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, Feb 20, 2025 at 03:40:15PM +0200, Andy Shevchenko wrote:
> > > > On Thu, Feb 20, 2025 at 02:22:29PM +0100, Bartosz Golaszewski wrote=
:
> > > > > On Thu, Feb 20, 2025 at 2:18=E2=80=AFPM Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > On Fri, Feb 14, 2025 at 11:50:53AM +0100, Linus Walleij wrote:
>
> ...
>
> > > > > > Bart, do you think it can be applied?
> > > > >
> > > > > Andy,
> > > > >
> > > > > I really rarely lose track of patches. It's been just under a wee=
k
> > > > > since this was posted. Please don't ping me to pick things up unl=
ess
> > > > > I'm not reacting for at least two weeks. I typically leave patche=
s on
> > > > > the list for some time to give bots some time to react.
> > > >
> > > > I see, I thought your cadence is one week, that's why I have pinged=
 you.
> > > > Will try to keep this in mind for the future and sorry to interrupt=
!
> > >
> > > Btw, if it's easier to you, I can just combine this to my usual PR to=
 you.
> >
> > No, that's fine, let's stick to ACPI-only PRs.
>
> Hmm... Is the Intel GPIO stuff should go directly to your tree? Seems I m=
issed
> some changes in the flow...
>

Ah, no, sure, intel and ACPI and whatever you did up until this point.

Bart

