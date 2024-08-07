Return-Path: <linux-kernel+bounces-277620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A4194A3E1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 11:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 337E01C20BE6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D901CB317;
	Wed,  7 Aug 2024 09:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pYmgXlIz"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D92942AAA
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 09:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723021978; cv=none; b=N54CTsyMltfGx3LnnUju3GTf1+p9Wl/NvCjfZbzh7x1SMHIdizAvd8sFZIMQLVkj/yPSZ4C+ie0GbEpibmTDlfiI2fReqDBSc3BeA4Bv127QPttQUuysKO1nFsInV0qCGOtYWhUlNmy/WDAwCgn6kyVSjjihB/i3AQ1IDQZy8qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723021978; c=relaxed/simple;
	bh=EmrHe7JMNgEBRN8Yu0a1cUXBhUbIcysYmrm5Bl1aLY0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tjUVejVXKziQuOu5wKUF2txKykoEknANWIOwa1IxG+5se7N4AQF4/SQBc/DrhHUi2Sow1uVVfNyDBHdWlTPOpFxj4DhYiPUyyVBXrriQcgzELKGMBWCt+pmkkNGdcebEJVXvFRXn2pPzOlMoiN6BRUzPNWtJYXWygcgqWf3+Qok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pYmgXlIz; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f15e48f35bso15186251fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 02:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723021973; x=1723626773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AXJcefWBGwCjqo+n8nUM/WZjz4KUu6Dr7gpS34TWtOM=;
        b=pYmgXlIzAxLDqM6nWB6+uY1+TV2MZNzPsYSFVeni78UgaY6itI/I38XHnKubmpd+/e
         6+nTaQbKy1dkBXGHne8tkYu/2smaKHVMgETwb1qJBw0lOZSn7y2Ii4xSqU3kN6h5RJEk
         kDO5tb6uR4RxvBizyANB48Xhz950CiJLIkZMlRTRuYYUDkxrgmlrdfhR6WynjcBaPXzP
         IAuchnJJHrQByHf/Z5PKuJZRObkwbIywMnZ9XL6uX/1+mXsT6rHg8dwDz5Ne+aDXSusW
         ovULKq91AhKD+rHXb+O50ZVtPDFtZ0o2I+A8jR6EoTmYYuqM4xTnWX+muVIiZLBZnsCt
         lduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723021973; x=1723626773;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AXJcefWBGwCjqo+n8nUM/WZjz4KUu6Dr7gpS34TWtOM=;
        b=wik8aRdcZvfhgx0urbTLDozD24RY5ksMha823OrlBHg/9VJLE0IDC2rDare8kgnl1R
         AEnIpQAnvuw77vY7z4nRqmP3wMhrRhwl+8dsZRAeKd2XIaGBLyvsOCgOfr+LxgYTJdeR
         /aQN30ykwo18HVp9r3ngBEaCg8FEPl8srpsemBWi9G70aVmU1f1bhCM0oePttOYOqV8R
         6kO/jvHTOBh4qC5whIUXb5nubBwtFh8LDG/0DCOLnsvGP+Ojvgk7FQx+06V7o+NerGMj
         ue90FTetCxjD8Fb9PObJ3A1gArcDofLwHwr9AWPhrhc/Z2RMZt9P4qioo0rUhV6gfJTh
         JMAg==
X-Forwarded-Encrypted: i=1; AJvYcCUwCI9twQoiQw2SGAakaheEOLFBK9YCHv0EiU6FUzMOkQstiM61oedxWUFm2EaDK27OcfLGCbGtdQ6PzWuXYChMpx+wCxDNpWRgmX17
X-Gm-Message-State: AOJu0Yxayt3IvTBHMFzIOBsJPHZOtWwR9hdpw6y1d38uuQS+YbRuy+qe
	4MXd5wgyGUd9oxV9PTfotgq6v8IT87OnWpLa7EcT0nNb7RKofcXWHKUuyz4MPqw=
X-Google-Smtp-Source: AGHT+IFQOHCltwKQCBXQPLStP2Dg6b510B5NipglQzmC2gXIAhpoliwnnvlnRgikWAIyVrNs5a43UQ==
X-Received: by 2002:a2e:91d0:0:b0:2ef:1c0f:d490 with SMTP id 38308e7fff4ca-2f15ab0c2a1mr126633751fa.39.1723021973213;
        Wed, 07 Aug 2024 02:12:53 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:90f1:3c4c:261c:b0f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429059cbfaesm17923005e9.42.2024.08.07.02.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 02:12:52 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
  Thomas Zimmermann <tzimmermann@suse.de>,  David Airlie
 <airlied@gmail.com>,  Daniel Vetter <daniel@ffwll.ch>,  Kevin Hilman
 <khilman@baylibre.com>,  dri-devel@lists.freedesktop.org,
  linux-amlogic@lists.infradead.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] drm/meson: dw-hdmi: use matched data
In-Reply-To: <CAFBinCAaZumGU6dOq0RrHRTQV=MejTJ=RW0P_6tQFOG9vybY6g@mail.gmail.com>
	(Martin Blumenstingl's message of "Tue, 6 Aug 2024 23:03:25 +0200")
References: <20240730125023.710237-1-jbrunet@baylibre.com>
	<20240730125023.710237-8-jbrunet@baylibre.com>
	<CAFBinCAaZumGU6dOq0RrHRTQV=MejTJ=RW0P_6tQFOG9vybY6g@mail.gmail.com>
Date: Wed, 07 Aug 2024 11:12:52 +0200
Message-ID: <1j5xsczoff.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue 06 Aug 2024 at 23:03, Martin Blumenstingl <martin.blumenstingl@googl=
email.com> wrote:

> Hi Jerome,
>
> On Tue, Jul 30, 2024 at 2:50=E2=80=AFPM Jerome Brunet <jbrunet@baylibre.c=
om> wrote:
> [...]
>> +       }, {
>> +               .limit =3D 297000,
>> +               .regs =3D gxbb_3g_regs,
>> +               .reg_num =3D ARRAY_SIZE(gxbb_3g_regs)
> Just as a side-note: this looked odd when reading for the first time
> as I thought that it's a typo (and it should be gxbb_2g97_regs - but
> that name is not used).

I know it looks odd but there is a (perhaps silly) reason for it.

The names are derived from PHY modes used in the Amlogic vendor tree.
Those are magic pokes and we don't really know anything about it. The
vendor tree often update and mainline does not always follow. I know
that we are not 100% aligned right now. No one knows what branch is the
reference to follow anyway.

Using the same names is way to leave breadcrumbs that may help people
linking this to vendor code later on (if necessary)

I think the modes are named after the (rounded) bandwidth they provide,
not necessarily the limit we are using to pick it ... except for def,
which might just mean 'default' I guess.

https://github.com/khadas/linux/blob/khadas-vims-5.4.y/drivers/amlogic/medi=
a/vout/hdmitx/hdmi_tx_20/hw/hw_g12a.c#L589

I focused on keeping mainline as it was for the value poked, retaining
as much information as possible to find our way back.

Your proposed naming convention is fine by me as well.

>
> [...]
>> +static const struct meson_dw_hdmi_speed gxl_speeds[] =3D {
>> +       {
>> +               .limit =3D 371250,
>> +               .regs =3D gxl_3g7_regs,
>> +               .reg_num =3D ARRAY_SIZE(gxl_3g7_regs)
>> +       }, {
>> +               .limit =3D 297000,
>> +               .regs =3D gxl_3g_regs,
>> +               .reg_num =3D ARRAY_SIZE(gxl_3g_regs)
>> +       }, {
>> +               .limit =3D 148500,
>> +               .regs =3D gxl_def_regs,
>> +               .reg_num =3D ARRAY_SIZE(gxl_def_regs)
> this is not consistent with what we have above or below so it either
> needs to be updated or a comment.
> I think this should be called gxl_1g48_regs
>
>> +       }, {
>> +               .regs =3D gxl_270m_regs,
>> +               .reg_num =3D ARRAY_SIZE(gxl_270m_regs)
> and this should be called gxl_def_regs

def in not the last one, it is another name used by AML

It so happens that on mainline with we have only put the SD/270M for
gxl. In the AML tree, it does exist for G12 too. Maybe it will be needed so=
meday.

>
>
>
> Best regards,
> Martin

--=20
Jerome

