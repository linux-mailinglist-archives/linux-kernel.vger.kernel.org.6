Return-Path: <linux-kernel+bounces-244396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E81E92A3B8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B9DF1F22016
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 13:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1607F48C;
	Mon,  8 Jul 2024 13:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="O4W42dZA"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3D36A022
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 13:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720445689; cv=none; b=XvujXmqhug+QPSoFTAlz4PwfrpY/4OCM1+QoRzqxQj6mYMjRqLF6b/mwEhXUMeQjByOxOlMW/MLQZR30LgepaN43LJMmevGRQpEcXCydQvRgReKFSDfJ+leg/PjRDcujGtTn8Dg/EMDcvy7ZdNdkufQx14ojJbKga+ua7HduWqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720445689; c=relaxed/simple;
	bh=ZEzWRO2LpDgyJB3Z+NE8SgN6LUV6fHcQtsqrgS8Yc10=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WNHnHq2/Q28xtXbFr+KngXpSmYtvW7g0UOKd4tI1EG2zN8m6Uv+/boET38EIQEFHqsPO+CWa3bH6/rEENMnZy7AzPl031/QdyzZBcY+o8BqKWGdAWQKaK+ZDatmlUKg+g60YLO2j9o/DBKliNq7OSvjsYwqsd43ZOgBEz8HRk3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=O4W42dZA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4266f344091so611265e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 06:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720445686; x=1721050486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZEzWRO2LpDgyJB3Z+NE8SgN6LUV6fHcQtsqrgS8Yc10=;
        b=O4W42dZAnR8unNf7Ibw16d5DKnl83zlDTzZbIPAPjZjzMD2Q6KHMbq3GqQBRXuhhgS
         zZeX9upqcOGtsAkdTUP5PEAoaWSs6bBp560fdb3EPJmWECWBhWkHJBRmE0Z/c1q31pVq
         F/BBHZga+Oh33kx7+Jr++HuzHhQ8lTqOFF/nyeCVhnhdTC4Ivh/OMT6gu6cKYiHWD/8p
         t+0I4yY1QTjowHQDebos3PY1XzP7kTWpO1lfklvgQ6NHxyQG0OI9QGv2phuPL8bxPL2s
         /MKBGICHc7dEJSaa2PmNDMLTCXzv0WoPwBohhETaGTzsaSUEgWDA5E7oMAuUfFz0XdLO
         d93w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720445686; x=1721050486;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEzWRO2LpDgyJB3Z+NE8SgN6LUV6fHcQtsqrgS8Yc10=;
        b=DounzjqPzJ06U5lMe3a4qOjlMaePe88PNU0XXmx+LAWYNBBDdv7VLZv8Rt8tdW0ljm
         bBzk3FzH62FaL7IvkKaGrkJsQ+v7R3psEbQliJPVPRyIWJCccm1mSG0AieJsY8OLepKk
         H+2F+NxZcQG2+GWaHVuBFR4xv/xhejw4OnIS94+WkZK/C7UjC3SiU7JnSy4rg2Ne8VTy
         YATZbvIKhwUvqWQkSmQLMPS32cuCD+5r0c/Yvx/k4zr/x1ydlAMtkM7itSjB5UkeXDJt
         N/weRxPfzQP49zk3+kYAGuEz7J2sEbc6FsomFOirIzO/82HryNyRJQ5KqeSl2llFeKT3
         LnaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPEZ0oSz8Xdfa69uK4nnsPTCkdO1U/JI2ai17thQDBry50xePI5+6+tO1fRDX5lvXnSweugRHVD4QG48Xk1cUrcxFrMfb2PuReh02u
X-Gm-Message-State: AOJu0YzfzpMgIevODAbVDImkgsl7+5H4GsRbL8EIGV+qrZon20q38xYl
	awO6ROZIA3vJtux+oKIVtV59Z93Z+tywSuH6RNotYWpODCiUwepEOjpjRAr9aJo=
X-Google-Smtp-Source: AGHT+IGRHXzVP8vWodoy2IVaw2YC8m/sDvIPSISv1qKc25IfTFheIsZdbD3qEGLVm1zTHYZ1DPNdZQ==
X-Received: by 2002:a05:600c:22d0:b0:426:5e1c:1ad0 with SMTP id 5b1f17b1804b1-4265e1c1db8mr42383885e9.37.1720445685795;
        Mon, 08 Jul 2024 06:34:45 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:5158:f510:c35c:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42649dec1cbsm66323985e9.1.2024.07.08.06.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 06:34:45 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?=
 <amadeuszx.slawinski@linux.intel.com>,  Mark Brown
 <broonie@kernel.org>,  Liam Girdwood <lgirdwood@gmail.com>,  Takashi Iwai
 <tiwai@suse.com>,  Jaroslav Kysela <perex@perex.cz>,
  alsa-devel@alsa-project.org,  linux-sound@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ALSA: pcm: add support for 128kHz sample rate
In-Reply-To: <874j99434a.wl-tiwai@suse.de> (Takashi Iwai's message of "Mon, 01
	Jul 2024 16:07:49 +0200")
References: <20240628122429.2018059-1-jbrunet@baylibre.com>
	<20240628122429.2018059-2-jbrunet@baylibre.com>
	<326792b9-e706-4ab0-a1e8-cc48943e357d@linux.intel.com>
	<874j99434a.wl-tiwai@suse.de>
Date: Mon, 08 Jul 2024 15:34:44 +0200
Message-ID: <1j4j90hurv.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon 01 Jul 2024 at 16:07, Takashi Iwai <tiwai@suse.de> wrote:

> On Mon, 01 Jul 2024 10:50:02 +0200,
> Amadeusz S=C5=82awi=C5=84ski wrote:
>>=20
>> On 6/28/2024 2:23 PM, Jerome Brunet wrote:
>> > The usual sample rate possible on an SPDIF link are
>> > 32k, 44.1k, 48k, 88.2k, 96k, 172.4k and 192k.
>> >=20
>> > With higher bandwidth variant, such as eARC, and the introduction of 8
>> > channels mode, the spdif frame rate may be multiplied by 4. This happe=
ns
>> > when the interface use an IEC958_SUBFRAME format.
>> >=20
>> > The spdif 8 channel mode rate list is:
>> > 128k, 176.4k, 192k, 352.8k, 384k, 705.4k and 768k.
>> >=20
>> > All are already supported by ASLA expect for the 128kHz one.
>> > Add support for it but do not insert it the SNDRV_PCM_RATE_8000_192000
>> > macro. Doing so would silently add 128k support to a lot of HW which
>> > probably do not support it.
>> >=20
>> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> > ---
>>=20
>> From what I remember the recommendation is to not add new rates, but
>> use SNDRV_PCM_RATE_KNOT for all rates not included already.
>
> In general yes -- unless the new rate is used for significant amount
> of drivers.
>
> So this case is a sort of on a border line; if it's only for ASoC
> SPDIF codec driver, I'd rather implement with an extra rate list
> instead of extending the common bits (that has some potential risks by
> breaking the existing numbers).

At the moment it would be used by ASoC spdif codec yes (and with Amlogic
eARC support reasonnably soon, hopefully)=20

However it is likely to be a common rate of any derivative of an IEC958
interface, with a sufficiently high bandwidth. I suspect there might be
more of those in the future. Also, it is not an exotic rate for some obscure
codec no one really has. It is part of specified interface that every TV
with HDMI 2 is likely to have nowadays. This is why I thought it made
sense to add it to the usual list. It is the only rate missing,
everything else is already there.

Changing the spdif codecs with SNDRV_PCM_RATE_KNOT and a custom rate
list is doable I suppose, if the new ID is not OK.=20

BTW, I tried not changing the existing numbers and add 128k last but that
broke. I guess something requires the IDs to be ordered. I did not check
this further since updating the IDs worked fine (for me, at least :) )

> OTOH, if we can take this for further
> cleanups of the existing requirement of 128khz rate, we can go with
> it.
>

Apart from the problem reported in sound/usb/caiaq/audio.c, is there
another clean up expected ?

>
> thanks,
>
> Takashi

--=20
Jerome

