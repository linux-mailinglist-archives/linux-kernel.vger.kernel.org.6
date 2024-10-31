Return-Path: <linux-kernel+bounces-390873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DC49B7F7E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D2451F225A3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8841B1D65;
	Thu, 31 Oct 2024 15:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VNNqa6/9"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5325E1A0BE3
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730390390; cv=none; b=gnuFjMmOGo5Cd75m6zRjvsE4/KOoO99LwDACEx/LxN0aoZgJanvDlpC30bi2IShLlECSM5TioxmgJ5KM+uHVZ4EKmeTb7TKeDkdnMoPKBWNIOh3ghfhL0qTslR3jzljCMF8E9F7zRtNUmMGznm15nEGbVkzJDKZeLPt8E3nhCDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730390390; c=relaxed/simple;
	bh=LyB2DEhOyrEht4YV7takGh8criFP5u606uMPfx01BHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fI5C2izeYUyfGKFCwWN2xDpXkW9BwSsGS78mK3hL0oGD79sx3l1KL5fErwPjdu1DY4cT83K8HYTuCC1oSO/iMBacdFpYbd3s/4sAhm3yBCdRUUj8tIDfgP4dpkWmypz3nyz3LzIia00/thOzsXo3QMrq3aknX+0Hf9Uq+azJqKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VNNqa6/9; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e30d0d84d23so946045276.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730390387; x=1730995187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xca1ept+92DMjyNI9CzVvRQSPKz6IaZIO4ifLsUYWvI=;
        b=VNNqa6/9AAfaTMkLEGYCcSIiq3ipr5yz+XXmFzobiaOS/TUFTuF8Nj9AbInyi0t4sU
         Aq7X4RDN+28bGxCbE5p3KdB62svBdW5iNyj3xw4Ud44/o195kXso6dpeI/1Q4gaHYPqx
         iRTF9nFPMG3vTmIpgw+e+q/PUMTn/CE/ccLGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730390387; x=1730995187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xca1ept+92DMjyNI9CzVvRQSPKz6IaZIO4ifLsUYWvI=;
        b=bIpNjkyMOUbveR4wnvfwyN948Juvxz1g+YneXiMZyK/gkI5pduHJPKjuQrko0OmVUA
         KsYL5KYOrE4N1B6zbr+WRzaE/RkG7Bg30F6Ba6C9A7w6wujA6VhOpGzUJCIneQ2Yp6wx
         DjN10FVuD/zJi1/RTLi2olyL8e6JBdzWoXHFMShVYumKooRSB0WKar/KZlKV+LtxB/1f
         2fjOxrnurXVLkJWWfFz7Ts0fxgrfK4WwStQwZ3yyxB5tOBMg9llApYCFbLe5ntd26FYZ
         4Tr/o+6eA66wYgbEIMsKnsoJHkoQ2R3yzI5geDeUEy9jv5kwGxstYswFFpMK4w5hG6Rd
         eWJA==
X-Forwarded-Encrypted: i=1; AJvYcCUM8/FH5IGEkizkPgeZDLpU6oG1kSIolIs0b7ssi6VoXNQ7Xft+5EzvjCivO1N0Z58IDQDiouZuRaSYCsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWHHlH2CkvZxIL4QNIj1qZV0PP304AZFaAUQQY8P2t1eDBMn6d
	1lqd502JI/bAsrJkU52p2o+6gnWUzc1tG4WD//gIIZUtsVlM12sii8/u8Ei93wN0g0a6pAg+05z
	JPta+4Z2d5mVgyxdLAnRMQJrRNiNSn53ikiX9
X-Google-Smtp-Source: AGHT+IFOyYozlE73lPD2ZV41iHuGfC/FA6HmPwSnrdF8QEMMo9raWnMAX36+0QpomZhLGKmCdQZYQ+XkXjur6yF7cMg=
X-Received: by 2002:a05:6902:161b:b0:e2e:3701:7824 with SMTP id
 3f1490d57ef6-e3087949dadmr20282651276.2.1730390387062; Thu, 31 Oct 2024
 08:59:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729865485.git.namcao@linutronix.de>
In-Reply-To: <cover.1729865485.git.namcao@linutronix.de>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Thu, 31 Oct 2024 11:59:35 -0400
Message-ID: <CABQX2QO_2zFyz-P0N7PAd=FP9EBi4X5cdCQo9GsOATOotuOLNA@mail.gmail.com>
Subject: Re: [PATCH 00/44] hrtimers: Switch to new hrtimer interface functions (4/5)
To: Nam Cao <namcao@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>, 
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Sebastian Reichel <sre@kernel.org>, Will Deacon <will@kernel.org>, 
	Jon Mason <jdmason@kudzu.us>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Pavel Machek <pavel@ucw.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Alex Deucher <alexander.deucher@amd.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Rob Clark <robdclark@gmail.com>, Lucas De Marchi <lucas.demarchi@intel.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 3:35=E2=80=AFAM Nam Cao <namcao@linutronix.de> wrot=
e:
>
> This is the forth part of a 5-part series (split for convenience). All 5
> parts are:
>
> Part 1: https://lore.kernel.org/lkml/cover.1729864615.git.namcao@linutron=
ix.de
> Part 2: https://lore.kernel.org/lkml/cover.1729864823.git.namcao@linutron=
ix.de
> Part 3: https://lore.kernel.org/lkml/cover.1729865232.git.namcao@linutron=
ix.de
> Part 4: https://lore.kernel.org/lkml/cover.1729865485.git.namcao@linutron=
ix.de
> Part 5: https://lore.kernel.org/lkml/cover.1729865740.git.namcao@linutron=
ix.de
>
> To use hrtimer, hrtimer_init() (or one of its variant) must be called, an=
d
> also the timer's callfack function must be setup separately.
>
> That can cause misuse of hrtimer. For example, because:
>   - The callback function is not setup
>   - The callback function is setup while it is not safe to do so
>
> To prevent misuse of hrtimer, this series:
>   - Introduce new functions hrtimer_setup*(). These new functions are
>     similar to hrtimer_init*(), except that they also sanity-check and
>     initialize the callback function.
>   - Introduce hrtimer_update_function() which checks that it is safe to
>     change the callback function. The 'function' field of hrtimer is then
>     made private.
>   - Convert all users to use the new functions.
>   - Some minor cleanups on the way.
>
> Most conversion patches were created using Coccinelle with the sematic
> patch below; except for tricky cases that Coccinelle cannot handle, or fo=
r
> some cases where a Coccinelle's bug regarding 100 column limit is
> triggered. Any patches not mentioning Coccinelle were done manually.
>
> virtual patch
> @@ expression timer, clock, mode, func; @@
> - hrtimer_init(timer, clock, mode);
>   ...
> - timer->function =3D func;
> + hrtimer_setup(timer, func, clock, mode);
>
> @@ expression timer, clock, mode, func; @@
> - hrtimer_init(&timer, clock, mode);
>   ...
> - timer.function =3D func;
> + hrtimer_setup(&timer, func, clock, mode);
>
> @@ expression timer, clock, mode, func; @@
> - hrtimer_init_on_stack(&timer, clock, mode);
>   ...
> - timer.function =3D func;
> + hrtimer_setup_on_stack(&timer, func, clock, mode);
>
> @@ expression timer, clock, mode; @@
> - hrtimer_init_sleeper_on_stack(timer, clock, mode);
> + hrtimer_setup_sleeper_on_stack(timer, clock, mode);
>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Jon Mason <jdmason@kudzu.us>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Andi Shyti <andi.shyti@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> Cc: Zack Rusin <zack.rusin@broadcom.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: "Uwe Kleine-K=C3=B6nig" <ukleinek@kernel.org>
> Cc: Takashi Iwai <tiwai@suse.com>
>
> Nam Cao (44):
>   USB: chipidea: Switch to use hrtimer_setup()
>   usb: dwc2: Switch to use hrtimer_setup()
>   usb: fotg210-hcd: Switch to use hrtimer_setup()
>   usb: gadget: Switch to use hrtimer_setup()
>   usb: ehci: Switch to use hrtimer_setup()
>   usb: musb: cppi41: Switch to use hrtimer_setup()
>   usb: typec: tcpm: Switch to use hrtimer_setup()
>   serial: 8250: Switch to use hrtimer_setup()
>   serial: imx: Switch to use hrtimer_setup()
>   serial: sh-sci: Switch to use hrtimer_setup()
>   serial: xilinx_uartps: Switch to use hrtimer_setup()
>   scsi: Switch to use hrtimer_setup()
>   rtc: class: Switch to use hrtimer_setup()
>   pps: generators: pps_gen_parport: Switch to use hrtimer_setup()
>   powercap: Switch to use hrtimer_setup()
>   power: supply: ab8500_chargalg: Switch to use hrtimer_setup()
>   power: reset: ltc2952-poweroff: Switch to use hrtimer_setup()
>   drivers: perf: Switch to use hrtimer_setup()
>   ntb: ntb_pingpong: Switch to use hrtimer_setup()
>   mmc: dw_mmc: Switch to use hrtimer_setup()
>   misc: vcpu_stall_detector: Switch to use hrtimer_setup()
>   media: Switch to use hrtimer_setup()
>   mailbox: Switch to use hrtimer_setup()
>   leds: trigger: pattern: Switch to use hrtimer_setup()
>   Input: Switch to use hrtimer_setup()
>   iio: Switch to use hrtimer_setup()
>   i2c: Switch to use hrtimer_setup()
>   stm class: heartbeat: Switch to use hrtimer_setup()
>   drm/amdgpu: Switch to use hrtimer_setup()
>   drm/i915/huc: Switch to use hrtimer_setup()
>   drm/i915/gvt: Switch to use hrtimer_setup()
>   drm/i915/perf: Switch to use hrtimer_setup()
>   drm/i915/pmu: Switch to use hrtimer_setup()
>   drm/i915/uncore: Switch to use hrtimer_setup()
>   drm/i915/request: Switch to use hrtimer_setup()
>   drm/msm: Switch to use hrtimer_setup()
>   drm/vkms: Switch to use hrtimer_setup()
>   drm/xe/oa: Switch to use hrtimer_setup()
>   drm/vmwgfx: Switch to use hrtimer_setup()

Acked-by: Zack Rusin <zack.rusin@broadcom.com>

FWIW, even if there's no current errors in those paths, that's a nice
change. I remember looking at the hrtimer initialization code the
first time and thinking that setting the function member of the struct
after initialization must be a bug or some hack... Now it will
instinctively make sense to anyone reading it for the first time.

z

