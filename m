Return-Path: <linux-kernel+bounces-324950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B293975315
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D45A1C22F56
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D60F19C548;
	Wed, 11 Sep 2024 12:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="C2XHxjbJ"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE5E199948
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 12:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726059586; cv=none; b=LZvy44Q+8mXW956e3iosEB4RgXeXjMbBQxhb1cQWzLAO2Nuvzs557Y0huIhtfSBhKj7VBvwCNDMkvFJtOgflr9WmoFrT6wOx6gR7f6evznsg0k2GySKJKv54Tz27nILGBdm66EOEQPM5A/rOyPYYBwk6R7CMsFWeKI0Gb3uQNj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726059586; c=relaxed/simple;
	bh=9WUvBHsRbfKWUclL3qSAJX3oZZ34GnEzUgLUdNclYR0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tLUSkMEnww/hDFZc3uk6ppmfxkMs7dP/NmrBPEoj/w0jUQtgENT72mMsvh2YnyiORipVNW2AJHn7mBLlZpXwQWk17fHfagk3EimFUj8/mxiv1Za0/LL7Z8MCRhch5ef2Lk/x2yTv2FS28w5mUo6rPsebKfTPZkqsNiNEX9xSnzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=C2XHxjbJ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cbe624c59so17928585e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 05:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726059581; x=1726664381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3qjI5qOQu62ZKLI3JamK6EKP4HWBl9hmGbETmi4+LoQ=;
        b=C2XHxjbJudSRehlrivNrqcvtozOEKlau1N4/9eE0XGge08KV+wB9HoxUFmI6fOT6Ks
         R9+k8raN1W835LYCaTwTNVPWo2AKucWCLUfg11PzWyKF8M7hvaUs2/uw4MLTZVyqIf2L
         FJok9Aqs+fGgKpL1pcrRFeyYKcGsNBhWDbWXAW7AzTkgiuYuXCjAThfE6Toro8yTkW00
         crAdGmkFKINHxAWiH01Exz5+OYEuC0BlFcT4EPynuee79W9menLswYxulogc5atYySVk
         f2YRPePoxACgbiy8AYxk07sUO2Tc+nYSvECD3mPGn6M5tR/W+BGwG7FuKbol/PTgNkKQ
         TyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726059581; x=1726664381;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3qjI5qOQu62ZKLI3JamK6EKP4HWBl9hmGbETmi4+LoQ=;
        b=GZQxs0Yuq9skJ/skxGlPjDH+fESvM0ZD+h10iOBKN7yB5PWdoT4R3iju97tjxGrxSS
         B9drvkKnnzqyi8GojFGCUHYKO3Dqyh7TnSfQlqINksSaeR2SICkryhnKDWnjyfmmhywl
         OyjIkDOMsBtYqtrwd0pKdINS/9eUo6Rvx9W275AGsYgnVETtNSuxhsvFuwqMpxtsLvRl
         QrCvfDMDpFFO+mpj3We2BEgmFQntGXru/tCT32C6mqD5IKe/ATvftwQ1KhJSnyqfF0dt
         ymWe6c8177jYv9O7wt4KqZLmB4nTqlmaPayKztnJ0R1/boNVDBkCGdWmN3EncqAVsXip
         ox8w==
X-Forwarded-Encrypted: i=1; AJvYcCVH0/vTY5F9x3ybgQ6yGMFzoFKjavqOQ5nOJ2Wyie5Xa/FjG88QdV4A6HlHdTjzuqLeWE4R3ssCvo9T7RE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx66xhuPrkP+HMetgy6t3aq7I466Eb64HMc9Pn/1oKe0RqBSZli
	hG/nnktTjjkuw2awXqPCLr5ndokdahI7UvppblF3HRPHvtyf5KAN6JCDog1U0y4=
X-Google-Smtp-Source: AGHT+IFbIGp4ZrQaJ90YwFplNTUhCUyHuJV1afpYMx6O37zO6sB00HkkVAoLCw2eEVQexlkgHuX0ng==
X-Received: by 2002:a05:600c:34ca:b0:42c:b9a0:c17c with SMTP id 5b1f17b1804b1-42cb9a0c52bmr60194685e9.35.1726059580554;
        Wed, 11 Sep 2024 05:59:40 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:7388:2adc:a5d5:ff63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956653c6sm11536866f8f.32.2024.09.11.05.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 05:59:40 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>,  =?utf-8?Q?P=C3=A9ter?= Ujfalusi
 <peter.ujfalusi@linux.intel.com>,  Pierre-Louis Bossart
 <pierre-louis.bossart@linux.intel.com>, 	Takashi Iwai <tiwai@suse.com>,
 	David Rhodes <david.rhodes@cirrus.com>, 	Richard Fitzgerald
 <rf@opensource.cirrus.com>,  Liam Girdwood <lgirdwood@gmail.com>, 	Mark
 Brown <broonie@kernel.org>,  Cezary Rojewski <cezary.rojewski@intel.com>,
 	Liam Girdwood <liam.r.girdwood@linux.intel.com>, 	Bard Liao
 <yung-chuan.liao@linux.intel.com>, 	Ranjani Sridharan
 <ranjani.sridharan@linux.intel.com>, 	Kai Vehmanen
 <kai.vehmanen@linux.intel.com>, 	Srinivas Kandagatla
 <srinivas.kandagatla@linaro.org>, 	Chen-Yu Tsai <wens@csie.org>, 	Jernej
 Skrabec <jernej.skrabec@gmail.com>, 	Samuel Holland <samuel@sholland.org>,
  linux-sound@vger.kernel.org, 	linux-kernel@vger.kernel.org,
  patches@opensource.cirrus.com, 	alsa-devel@alsa-project.org,
  linux-arm-msm@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
  linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 01/13] ALSA: pcm: add more sample rate definitions
In-Reply-To: <87ldzy2wgc.wl-tiwai@suse.de> (Takashi Iwai's message of "Wed, 11
	Sep 2024 14:42:27 +0200")
References: <20240905-alsa-12-24-128-v1-0-8371948d3921@baylibre.com>
	<20240905-alsa-12-24-128-v1-1-8371948d3921@baylibre.com>
	<1ab3efaa-863c-4dd0-8f81-b50fd9775fad@linux.intel.com>
	<87ed5q4kbe.wl-tiwai@suse.de>
	<5c309853-c82c-475e-b8c2-fcdcfde20efc@linux.intel.com>
	<87y13y31kq.wl-tiwai@suse.de>
	<4f58ebe8-78fe-41f3-9fc6-720d314c026e@perex.cz>
	<87ldzy2wgc.wl-tiwai@suse.de>
Date: Wed, 11 Sep 2024 14:59:39 +0200
Message-ID: <1jy13yqrb8.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed 11 Sep 2024 at 14:42, Takashi Iwai <tiwai@suse.de> wrote:

> On Wed, 11 Sep 2024 12:58:53 +0200,
> Jaroslav Kysela wrote:
>>=20
>> On 11. 09. 24 12:51, Takashi Iwai wrote:
>> > On Wed, 11 Sep 2024 12:33:01 +0200,
>> > P=C3=A9ter Ujfalusi wrote:
>> >>=20
>> >> On 11/09/2024 12:21, Takashi Iwai wrote:
>> >>>> Wondering if this is backwards compatible with the alsa-lib definit=
ions,
>> >>>> specifically the topology parts which did unfortunately have a list=
 of
>> >>>> rates that will map to a different index now:
>> >>>>=20
>> >>>>=20
>> >>>> typedef enum _snd_pcm_rates {
>> >>>> 	SND_PCM_RATE_UNKNOWN =3D -1,
>> >>>> 	SND_PCM_RATE_5512 =3D 0,
>> >>>> 	SND_PCM_RATE_8000,
>> >>>> 	SND_PCM_RATE_11025,
>> >>>> 	SND_PCM_RATE_16000,
>> >>>> 	SND_PCM_RATE_22050,
>> >>>> 	SND_PCM_RATE_32000,
>> >>>> 	SND_PCM_RATE_44100,
>> >>>> 	SND_PCM_RATE_48000,
>> >>>> 	SND_PCM_RATE_64000,
>> >>>> 	SND_PCM_RATE_88200,
>> >>>> 	SND_PCM_RATE_96000,
>> >>>> 	SND_PCM_RATE_176400,
>> >>>> 	SND_PCM_RATE_192000,
>> >>>> 	SND_PCM_RATE_CONTINUOUS =3D 30,
>> >>>> 	SND_PCM_RATE_KNOT =3D 31,
>> >>>> 	SND_PCM_RATE_LAST =3D SND_PCM_RATE_KNOT,
>> >>>> } snd_pcm_rates_t;
>> >>>=20
>> >>> As far as I understand correctly, those rate bits used for topology
>> >>> are independent from the bits used for PCM core, although it used to
>> >>> be the same.  Maybe better to rename (such as SND_TPLG_RATE_*) so th=
at
>> >>> it's clearer only for topology stuff.
>> >>=20
>> >> Even if we rename these in alsa-lib we will need translation from
>> >> SND_TPLG_RATE_ to SND_PCM_RATE_ in kernel likely?
>> >>=20
>> >> The topology files are out there and this is an ABI...
>> >>=20
>> >>> But it'd be better if anyone can double-check.
>> >>=20
>> >> Since the kernel just copies the rates bitfield, any rate above 11025
>> >> will be misaligned and result broken setup.
>> >=20
>> > Yep, I noticed it now, too.
>> >=20
>> > Below is the fix patch, totally untested.
>> > It'd be appreciated if anyone can test it quickly.
>> >=20
>> >=20
>> > thanks,
>> >=20
>> > Takashi
>> >=20
>> > -- 8< --
>> > From: Takashi Iwai <tiwai@suse.de>
>> > Subject: [PATCH] ALSA: pcm: Fix breakage of PCM rates used for topology
>> >=20
>> > It turned out that the topology ABI takes the standard PCM rate bits
>> > as is, and it means that the recent change of the PCM rate bits would
>> > lead to the inconsistent rate values used for topology.
>> >=20
>> > This patch reverts the original PCM rate bit definitions while adding
>> > the new rates to the extended bits instead.  This needed the change of
>> > snd_pcm_known_rates, too.  And this also required to fix the handling
>> > in snd_pcm_hw_limit_rates() that blindly assumed that the list is
>> > sorted while it became unsorted now.
>> >=20
>> > Fixes: 090624b7dc83 ("ALSA: pcm: add more sample rate definitions")
>> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
>>=20
>> This looks fine. But the topology rate bits should not depend on those
>> bits. It's a bit pitty that the standard PCM ABI does not use those
>> bits for user space and we are doing this change just for topology
>> ABI.
>
> Yeah, and theoretically it's possible to fix in topology side, but
> it'll be more cumbersome.
>
> Although it's not really a part of PCM ABI, I believe we should move
> the PCM rate bit definitions to uapi, for showing that it's set in
> stone.  Something like below.
>
>
> Takashi
>
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: pcm: Move standard rate bit definitions into uapi
>
> Since the standard PCM rate bits are used for the topology ABI, it's a
> part of public ABI that must not be changed.  Move the definitions
> into uapi to indicate it more clearly.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  include/sound/pcm.h         | 26 --------------------------
>  include/uapi/sound/asound.h | 26 ++++++++++++++++++++++++++
>  2 files changed, 26 insertions(+), 26 deletions(-)
>
> diff --git a/include/sound/pcm.h b/include/sound/pcm.h
> index 824216799070..f28f6d6ac996 100644
> --- a/include/sound/pcm.h
> +++ b/include/sound/pcm.h
> @@ -105,32 +105,6 @@ struct snd_pcm_ops {
>=20=20
>  #define SNDRV_PCM_POS_XRUN		((snd_pcm_uframes_t)-1)
>=20=20
> -/* If you change this don't forget to change rates[] table in pcm_native=
.c */
> -#define SNDRV_PCM_RATE_5512		(1U<<0)		/* 5512Hz */
> -#define SNDRV_PCM_RATE_8000		(1U<<1)		/* 8000Hz */
> -#define SNDRV_PCM_RATE_11025		(1U<<2)		/* 11025Hz */
> -#define SNDRV_PCM_RATE_16000		(1U<<3)		/* 16000Hz */
> -#define SNDRV_PCM_RATE_22050		(1U<<4)		/* 22050Hz */
> -#define SNDRV_PCM_RATE_32000		(1U<<5)		/* 32000Hz */
> -#define SNDRV_PCM_RATE_44100		(1U<<6)		/* 44100Hz */
> -#define SNDRV_PCM_RATE_48000		(1U<<7)		/* 48000Hz */
> -#define SNDRV_PCM_RATE_64000		(1U<<8)		/* 64000Hz */
> -#define SNDRV_PCM_RATE_88200		(1U<<9)		/* 88200Hz */
> -#define SNDRV_PCM_RATE_96000		(1U<<10)	/* 96000Hz */
> -#define SNDRV_PCM_RATE_176400		(1U<<11)	/* 176400Hz */
> -#define SNDRV_PCM_RATE_192000		(1U<<12)	/* 192000Hz */
> -#define SNDRV_PCM_RATE_352800		(1U<<13)	/* 352800Hz */
> -#define SNDRV_PCM_RATE_384000		(1U<<14)	/* 384000Hz */
> -#define SNDRV_PCM_RATE_705600		(1U<<15)	/* 705600Hz */
> -#define SNDRV_PCM_RATE_768000		(1U<<16)	/* 768000Hz */
> -/* extended rates */

It is cosmetic but I wonder, does the extended really start here ?

From the table Pierre-Louis sent, I suppose that all the recently added rat=
es could
been seen as extended too (352.8 to 768). Those did not mess with the
order though=20

> -#define SNDRV_PCM_RATE_12000		(1U<<17)	/* 12000Hz */
> -#define SNDRV_PCM_RATE_24000		(1U<<18)	/* 24000Hz */
> -#define SNDRV_PCM_RATE_128000		(1U<<19)	/* 128000Hz */
> -
> -#define SNDRV_PCM_RATE_CONTINUOUS	(1U<<30)	/* continuous range */
> -#define SNDRV_PCM_RATE_KNOT		(1U<<31)	/* supports more non-continuous ra=
tes */
> -
>  #define SNDRV_PCM_RATE_8000_44100	(SNDRV_PCM_RATE_8000|SNDRV_PCM_RATE_11=
025|\
>  					 SNDRV_PCM_RATE_16000|SNDRV_PCM_RATE_22050|\
>  					 SNDRV_PCM_RATE_32000|SNDRV_PCM_RATE_44100)
> diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
> index 4cd513215bcd..715ceb3eac7c 100644
> --- a/include/uapi/sound/asound.h
> +++ b/include/uapi/sound/asound.h
> @@ -272,6 +272,32 @@ typedef int __bitwise snd_pcm_subformat_t;
>  #define	SNDRV_PCM_SUBFORMAT_MSBITS_24	((__force snd_pcm_subformat_t) 3)
>  #define	SNDRV_PCM_SUBFORMAT_LAST	SNDRV_PCM_SUBFORMAT_MSBITS_24
>=20=20
> +/* Standard rate bits */
> +#define SNDRV_PCM_RATE_5512		(1U<<0)		/* 5512Hz */
> +#define SNDRV_PCM_RATE_8000		(1U<<1)		/* 8000Hz */
> +#define SNDRV_PCM_RATE_11025		(1U<<2)		/* 11025Hz */
> +#define SNDRV_PCM_RATE_16000		(1U<<3)		/* 16000Hz */
> +#define SNDRV_PCM_RATE_22050		(1U<<4)		/* 22050Hz */
> +#define SNDRV_PCM_RATE_32000		(1U<<5)		/* 32000Hz */
> +#define SNDRV_PCM_RATE_44100		(1U<<6)		/* 44100Hz */
> +#define SNDRV_PCM_RATE_48000		(1U<<7)		/* 48000Hz */
> +#define SNDRV_PCM_RATE_64000		(1U<<8)		/* 64000Hz */
> +#define SNDRV_PCM_RATE_88200		(1U<<9)		/* 88200Hz */
> +#define SNDRV_PCM_RATE_96000		(1U<<10)	/* 96000Hz */
> +#define SNDRV_PCM_RATE_176400		(1U<<11)	/* 176400Hz */
> +#define SNDRV_PCM_RATE_192000		(1U<<12)	/* 192000Hz */
> +#define SNDRV_PCM_RATE_352800		(1U<<13)	/* 352800Hz */
> +#define SNDRV_PCM_RATE_384000		(1U<<14)	/* 384000Hz */
> +#define SNDRV_PCM_RATE_705600		(1U<<15)	/* 705600Hz */
> +#define SNDRV_PCM_RATE_768000		(1U<<16)	/* 768000Hz */
> +/* extended rates */
> +#define SNDRV_PCM_RATE_12000		(1U<<17)	/* 12000Hz */
> +#define SNDRV_PCM_RATE_24000		(1U<<18)	/* 24000Hz */
> +#define SNDRV_PCM_RATE_128000		(1U<<19)	/* 128000Hz */
> +
> +#define SNDRV_PCM_RATE_CONTINUOUS	(1U<<30)	/* continuous range */
> +#define SNDRV_PCM_RATE_KNOT		(1U<<31)	/* supports more non-continuous ra=
tes */
> +
>  #define SNDRV_PCM_INFO_MMAP		0x00000001	/* hardware supports mmap */
>  #define SNDRV_PCM_INFO_MMAP_VALID	0x00000002	/* period data are valid du=
ring transfer */
>  #define SNDRV_PCM_INFO_DOUBLE		0x00000004	/* Double buffering needed for=
 PCM start/stop */

--=20
Jerome

