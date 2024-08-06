Return-Path: <linux-kernel+bounces-275930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC5A948C1A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 11:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31EBCB21FBD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 09:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BAD1BDA9F;
	Tue,  6 Aug 2024 09:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mUx2mhlw"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC79161900
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 09:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722936116; cv=none; b=geCEMSqpFnoF/07grQX3ZgjFAN7B944PjRl83/qOlObrFpx89pdbFf01g3kXdWp77cJBFadTtPkjng2PPOe4UjhCrWh4n6Y1+F9x1cRJf1sWUmBKflP+jl/HaQdXfgRLBoOgwD+gp6vw8ahmlUHII1puMoxQgfQXfKUrTN37UAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722936116; c=relaxed/simple;
	bh=sqkJhDv+6oUT4nQ2lKcK8oFvGgPM/oPyq4n6jeUGC6E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SGzgYxL1fM1oXgCpCaj1VBszVY8oBjqYfBOT+K7g6W9ur4/FnSdqCNJ93ytfqE316KMY/vXwF1LJsr3Z65Zp375zq1RmGly4yxJXXzqMn+iOSX3f7DOsrXQm6A5pznyDjgmdH20aH4s7j6ICIScaXb4eQvrjvTcsi3Hl7g6ZZGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mUx2mhlw; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2f149845d81so5593211fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 02:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722936112; x=1723540912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sqkJhDv+6oUT4nQ2lKcK8oFvGgPM/oPyq4n6jeUGC6E=;
        b=mUx2mhlwrHE7NpMqRc7OoWNAbcYrI0hTggaPF0j9KQjvZfsLNo1a+cDshumuOkAXST
         5h9d5HPFpjiHjC4bhk0c+2UFh3zVs5oH/2OPt9BDK0rMjW0v6/yUcAORkxtSSv7PdLfj
         gNpHXJysPpGPAzPZol99w8C8xr8NoWy8QDR75NWiCahQJHS5PWnWHSSeyCWnJln2cxbr
         dbHKJwGiopid5VZ9xXUP93iTWOnRaKgti7ktGNTpDJ4iaMFT9OXwF7vvsnr/e1kfITlR
         gopDkKVIHdQ1ipEcRohZO8wB7JW+kHuye7z4c9Xq1LE4ppqmRFJ5tzUVTD26qjD31DdK
         jOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722936112; x=1723540912;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sqkJhDv+6oUT4nQ2lKcK8oFvGgPM/oPyq4n6jeUGC6E=;
        b=bEYqKKL9N28IPOWPV4Em8RqBePKA/Gjc1RxjNW2l60aw84rw9v3naJiJtOGtrEq4a3
         5bCyXwGwjt3hh6YSpSNQNyvJEVdID9ewt4NxCWcNec9c1hz6FASxTI7faiFf01RGqOau
         sL1uIR/Kjjv6xdU7Cd9WM1LsgE2UVrAvXBr8wtnk+zPy2uONiusiNNL3hyJz0+GEZhts
         FQ8v2P858z9getE/70IIvqwU7InkHXGhtupPcy8OaKy2mgs7wJP+bHzj7thR/OCspkc5
         MywJ61ry4Mm4//z8JNtaQ01P0w/1i7C/RAkOx/iqpQ9ObcuPaLNg79NTk1eUn40Af9oU
         iXhw==
X-Forwarded-Encrypted: i=1; AJvYcCWyADC0sUnVvsOUX0y0dJfWOlw6Bd69uzOwoyqF1Ao3V2t+syWu2EnFB6OFFFlNri2neWIjwPxF4W+FT19WPV1SkHzfl25SrM2Z1khY
X-Gm-Message-State: AOJu0YwXVZ16XG6gW0GGX/W8/tIGtDJnC0Qkh2vteFYdyyG67s04CLji
	Av4RSwgSOf9dMeQZkxBKxpHm3MBJiiCxFjqdc7BblmxLZzboY0odmXu4JPrkqKM=
X-Google-Smtp-Source: AGHT+IFeTtsP8+6H91ULn+8s1Jzamf9Fh+dKBHWwa5CDk0Tz2O9PLeglp+ALCgLSDZU90YcDG0s7Ig==
X-Received: by 2002:a2e:9548:0:b0:2ef:265e:bb93 with SMTP id 38308e7fff4ca-2f15aa84e0cmr94527721fa.3.1722936111909;
        Tue, 06 Aug 2024 02:21:51 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:c541:c0a5:2f43:ca78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb98109sm230716785e9.39.2024.08.06.02.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 02:21:51 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Mark Brown <broonie@kernel.org>,  linux-rt-users@vger.kernel.org,
  Arseniy Krasnov <avkrasnov@salutedevices.com>,  Liam Girdwood
 <lgirdwood@gmail.com>,  Jaroslav Kysela <perex@perex.cz>,  Takashi Iwai
 <tiwai@suse.com>,  Neil Armstrong <neil.armstrong@linaro.org>,  Kevin
 Hilman <khilman@baylibre.com>,  Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>,  alsa-devel@alsa-project.org,
  linux-sound@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-amlogic@lists.infradead.org,  linux-kernel@vger.kernel.org,
  kernel@sberdevices.ru,  oxffffaa@gmail.com,  Thomas Gleixner
 <tglx@linutronix.de>
Subject: Re: [PATCH v1] ASoC: meson: axg-fifo: set option to use raw spinlock
In-Reply-To: <20240806065021.PINvpze_@linutronix.de> (Sebastian Andrzej
	Siewior's message of "Tue, 6 Aug 2024 08:50:21 +0200")
References: <20240729131652.3012327-1-avkrasnov@salutedevices.com>
	<1ja5i0wags.fsf@starbuckisacylon.baylibre.com>
	<2b16b95e-196e-4d8a-98c3-3be568cdd18a@sirena.org.uk>
	<1j5xsow839.fsf@starbuckisacylon.baylibre.com>
	<7dfdade5-3a57-4883-bfac-067c50ec0ffb@sirena.org.uk>
	<1j1q3cw5ri.fsf@starbuckisacylon.baylibre.com>
	<20240805153309.k_SfHw62@linutronix.de>
	<1jplqnuf5r.fsf@starbuckisacylon.baylibre.com>
	<20240806065021.PINvpze_@linutronix.de>
Date: Tue, 06 Aug 2024 11:21:50 +0200
Message-ID: <1jle1auhu9.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue 06 Aug 2024 at 08:50, Sebastian Andrzej Siewior <bigeasy@linutronix.=
de> wrote:

> On 2024-08-05 18:07:28 [+0200], Jerome Brunet wrote:
>> Hi Sebastian,
> Hi Jerome,
>
>> Thanks a lot for taking the time to dig into the driver specifics.
>> The IRQ handler is actually not awfully critical in this case. The HW
>> will continue to run regardless of the IRQ being acked or not
>>=20
>> The purpose of the handler is mainly to let Alsa know that 1 (or more)
>> period is ready. If alsa is too slow to react, and the buffer allows
>> just a few periods, the HW may under/overflow the buffer.
>>=20
>> IRQF_ONESHOT is fine because snd_pcm_period_elapsed() 'notifies'
>> all past periods, not just one. The irq handler does not need to
>> run again until this function has been called. It also helps if the
>> period is ridiculously small, to try to reduce the number of IRQs.
>
> IRQF_ONESHOT is used to disable to keep the IRQ line disabled (after the
> primary handler) while the threaded handler is running. This implies
> that the primary handler must not be threaded under PREEMPT_RT.
> =E2=80=A6

This is the point I was missing. It is clear now. Thanks a lot.

I have tweaked #1 and added a few tags but the gist remains the same.
I was going to add you under 'Suggested-by' but maybe putting you as the
actual Author would be more appropriate.=20

What do you prefer ?

