Return-Path: <linux-kernel+bounces-511514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7580BA32C04
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCE5D188BCD2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C0E250BF1;
	Wed, 12 Feb 2025 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="OqJ+9dpa"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689FF256C8E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 16:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378372; cv=none; b=qzy83N4XYjYG7zJIxmaEjGckDcIhNqNUwcELQyxK7bQUEYnEZvxs4delGjdRYMrFsenXTbpw2P+oIjeOhHZIAwFhMiOp08iIeP6kAI24sO+nWiXnt561+pn4KJmQpkA6zeceEvrEGMUEEE3N8/H+Fk+RAY9dghjqSwDh+WEB6Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378372; c=relaxed/simple;
	bh=SqrHKzrnFGepf7djcq2JyOhODUv+D2vmoBsZ1xq9Mfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SX2C89UddQyMtBSXTPsIisPBX2ixWRxMOJ2ByYrPF6JVQzjnBY4RC2h+m84f2Z9ZT+RlYh1od4ezSiGyke4cldt35zlvUPQ+7uO5+URMEHGbbWHj+VYvk0QF5Sxc4HzQJVPpceGHDC7f18A5hRrB555aw26BcSVKI7MTAQRZDYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=OqJ+9dpa; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-308edbc368cso36321841fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 08:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739378368; x=1739983168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9J4VAMrvjFIthFOUeNoRIlqfbAqCet1lDNYxHiSCoI=;
        b=OqJ+9dpa0raGWq3XzwnErmo6krpYzKu4f4rZe4TPClXbR68Ls746QAppIxzOlmd0vB
         4vtIq7km1jfFTqW8mZZGyEoi2mSEnfL8F/IJZWcHZIV37N967atcIOjLLeohwbDTHh58
         QRo/qqNGTlkGcfjMMgxqNjFZKeeQfcYPo5wYdavpeLtCQ3k0tGNcFOed8d5ZTjXXq5Et
         6tdNMe2qBDmYdGMMXqveuVAs+tZS5b34GtVMv2U9+pfwgHNele+tIuyVmtB2QiU8fsdQ
         W4saen6qbjVA1bgH8ChEjeZRGUXJLGsgcOx1EyD9pZTiB5Gn/s3BYm3WKFOiOC9XjqWG
         TiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739378368; x=1739983168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g9J4VAMrvjFIthFOUeNoRIlqfbAqCet1lDNYxHiSCoI=;
        b=SeyfHipGpxGngclgXSV3srutqjKysc3kL5xLHn4zugkXhaFuNpquI82G2qKbSEgV1u
         pXMLwcKFMjPU1pg7D/Dt3nvlAxKVBzP3Zblcyu4zkJMhCb3mrwZrss9DaawWDFdLUJrY
         DZe3HiOZw4pP5iNhuvh9UNBnXk6PtUVNyq675YU7y7jVt7Tugg3CRxOSUEY6YZbNgj4Y
         Fmx8mWDTRsH5V0gwXd2OZDWqdjzhGZL8mXhWimCDDMXQyYNf88h9gFJZOvIK2uQGQu5y
         odfHFKdWw1yn9dr7H91VouGWPc1xfRvou3cGviUDbZPr5NGZGwsey7p+IbRSHbHw0Y34
         Mviw==
X-Forwarded-Encrypted: i=1; AJvYcCW+Ol/OP/mnBVDWDWxCV1DUf+9a3UggGGp/MtfQhXVrG1HLPGVocgBvMpVFKOqwRgXhCy4laQbF7Vm2byI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoSpzI0HWzVKyqkPK4/qNjOeIkqUy/cmm/hgBthiCgzHE8B1la
	WoaKP1RWiaL5tdE145hH4TO5/rtdyfarNIEWis+7jpNy8VXafpyjb94SA8ZFLAIWnyUAJ2CE0/T
	D3bRdMsQExb0MmUsmqwYmUIy09MTdfxF9CgJFEIhS5rhrYhQfTy/oKQ==
X-Gm-Gg: ASbGnctsB8SF7rJI+PfVZwnrwtpDuWjc0zRjxIoc31LSVWO3JFnHQYRimMxkGgE7e9V
	ejPEPUDNaU+IBn0BtvCGIcsy+hLpHVjTDc+MOyq09ARnozkt3rUut8MNv0NDoKVui8oO7Trr6P2
	vrHfAEz/fxryofe3ETTOTo9mlIqDaX
X-Google-Smtp-Source: AGHT+IGJSilHTkyG543GwkVXgOCLC5wxxAUOH6Du13FUEkPkgsZP4J+t1m6e3kH+6mL7xYbhbLX9btLHN1Ux9+Vvxyw=
X-Received: by 2002:a2e:a99e:0:b0:308:e9ae:b5a8 with SMTP id
 38308e7fff4ca-30904fe6b6fmr12180011fa.13.1739378368403; Wed, 12 Feb 2025
 08:39:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212085918.6902-1-brgl@bgdev.pl> <CAMRc=MdFwe2onYhwY__n-kAOSrXKKDWJ38hpbYb0711Nx60DHw@mail.gmail.com>
 <20250212155512.GE2274105@google.com>
In-Reply-To: <20250212155512.GE2274105@google.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 12 Feb 2025 17:39:16 +0100
X-Gm-Features: AWEUYZmGJUAGvgR0rK_Au78KUTPXxd0-vdf5bbSOE6eZxG3UNG7JHjJD80yu-r0
Message-ID: <CAMRc=Met68e5c16ShiJ1mHQM-GSvautN_whVMGh53g3mx7OQSg@mail.gmail.com>
Subject: Re: [PATCH] leds: aw200xx: don't use return with gpiod_set_value() variants
To: Lee Jones <lee@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>, linux-leds@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 4:55=E2=80=AFPM Lee Jones <lee@kernel.org> wrote:
>
> On Wed, 12 Feb 2025, Bartosz Golaszewski wrote:
>
> > On Wed, Feb 12, 2025 at 9:59=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev=
.pl> wrote:
> > >
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > While it now returns void, it will soon be converted to return an
> > > integer instead. Don't do `return gpiod_set...`.
> > >
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202502121512.CmoMg9Q7-l=
kp@intel.com/
> > > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > ---
> > >  drivers/leds/leds-aw200xx.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/leds/leds-aw200xx.c b/drivers/leds/leds-aw200xx.=
c
> > > index 08cca128458c..fe223d363a5d 100644
> > > --- a/drivers/leds/leds-aw200xx.c
> > > +++ b/drivers/leds/leds-aw200xx.c
> > > @@ -379,7 +379,7 @@ static void aw200xx_enable(const struct aw200xx *=
const chip)
> > >
> > >  static void aw200xx_disable(const struct aw200xx *const chip)
> > >  {
> > > -       return gpiod_set_value_cansleep(chip->hwen, 0);
> > > +       gpiod_set_value_cansleep(chip->hwen, 0);
> > >  }
> > >
> > >  static int aw200xx_probe_get_display_rows(struct device *dev,
> > > --
> > > 2.45.2
> > >
> >
> > Lee, Pavel:
> >
> > If this is OK for you, can you please provide me with an immutable
> > branch so that I can pull it into the GPIO tree? It seems it's the
> > only such use-case in the tree apart from the gpio.h header that I can
> > fix locally. Alternatively you can just Ack this and let me take it
> > through the GPIO tree.
>
> I'm okay with it, but why do you need it?
>

For historical reasons gpiod_set_value() and its variants don't have a
return value. However, we now support all kinds of hardware that can
fail to set a line value: I2C, SPI, USB (hot-unpluggable chips), etc.
I want to rework the GPIO subsystem to make these functions return int
and become able to indicate failures. Build-bot complained about my
series[1] and pointed at this driver after the interface for
gpiod_set_value_cansleep() changed in patch 1. This is why I want to
fix it, get it into my tree and then pick up the series.

Sorry for not explaining it in detail earlier.

Bart

[1] https://lore.kernel.org/linux-gpio/20250211-gpio-set-retval-v1-0-52d3d6=
13d7d3@linaro.org/

