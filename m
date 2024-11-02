Return-Path: <linux-kernel+bounces-393447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F1A9BA0C7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 15:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BC261F21AA2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 14:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AC919F101;
	Sat,  2 Nov 2024 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KKwe0FRo"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ECF18A6AC
	for <linux-kernel@vger.kernel.org>; Sat,  2 Nov 2024 14:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730557799; cv=none; b=eJ5s6g77FUohi3N13TRK6b1E9ET9lxYE917eYxZjPzWMm8oo8SBro1+ICtRkgqBY9GLeoamQCS9JKimsU/Do5De0NBjhUSfJ5r33y1sg+GZ8kBRwNzYVwYH7m8DXf21yQGtcyWT5z0y5gpnlo0O4b3EzGR+shNMoHD8ogwfovDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730557799; c=relaxed/simple;
	bh=2UVnWDWLwjZZg8pZVfZsO0SQswQZMcoz+OATPckU8PI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ivNGSLRCaqrgMQnLsASTQvvKw2eGblT/Fcn6h0GTJWldBoUt3pPKxpvLEb9b/YO3IZv9BV/RpLpNM+5H1ZdWtLcXxSfSwisyKYmeOqB5B9gJPTNVfa0yS1FlhVVN8cCKLdkqdZ420lFVMeXf1pggnf36OzmsIWsiUZ9CgfyNZPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KKwe0FRo; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9e71401844so182664266b.3
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 07:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730557794; x=1731162594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3OMGiouzrJ8irZX2X/fJQXvldwhLjCzScMS8OtJ3x8=;
        b=KKwe0FRosS23dHg2olRCQNxwQQna20aH3xhPazWYp+x6w7gWAW8XnxPGLQGHBbaLuH
         Ikq1rKWQDLnAv6rmKMDUXZJYJP598blvPRsBv/mTqas+D9LCwHn1UgAxz4/UzosPlYzO
         VL+WhcZGGbmlsDzkEsOHNcw8YZeakaWh17GcnaHF8dVr5Xun3aL9qZgDu4ccNcB+9K6F
         DvZH7R0/7T8QBIswj1cXpBeLqaf0h637nkemqY5I8qwRz8/zDJKZC59IquMPvv2hOJVY
         RKJoLeSZ+frnxYJ5gWBDsl6ZtcD5PcGNIX6EIGBg5Up5QeJ+ttUTmFz1VUOmH32ihK7P
         1ReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730557794; x=1731162594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D3OMGiouzrJ8irZX2X/fJQXvldwhLjCzScMS8OtJ3x8=;
        b=w2/973iMtpvFIekFlD8z2g0cQnwZ2GtiGfIYptEcJE1iJfgzh8Q5sCPuRKp+cMY5oc
         Ddo+OQ5+0e7S9eRHJh9MCcdbU/6H1qbDI8r26+JSqkZ+gkVf9WdKX32FSVf/K767BlZc
         +lC+nSwvdOnS0V4dduFHsbuA0V/nrvOno3Ga5sDf9+8U5GWhhvDivTLKtLhYWv5ePKuI
         +gvoFoOAZekEs4C7u2x3kvtepcIFj3zbBuFWQhAzYtR8rbXrDeh7Pz/vGfGUmdQU8iaP
         iGEByBRSblroRafJi7cjWcqHxEUIgXCFJx2cz9GLxcAiG6w2fjhqn3V0OggoaEf4gnX3
         PtnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMtFYUx//YZvmSLTn5w5ByTB7Pt5BsyunET4hx0J1bwtFVbBzYz1cJF0bUmVyvXSd+FmQiqGKJBDk9MMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPYibFObM0NjmLgzUQtvL+SDExMinp6cfBYq4KxaH2Vxd5BJ9A
	YYlVnRFS7Ox4w4ePL4PNL6qraQJGF4De4LQEMYnM9/qactUDWIQP1dzGOQiJu6GVosGtm0SSmlg
	GL1OPPfgGFg0OxCchRH1l0/d0YP88lNNxO3E1aA==
X-Google-Smtp-Source: AGHT+IHmMaoPuHCX8oqUiJ2GAJojyzCvnKuAF650y2r5dVCpByhVut9O1RRSbUZGBDSt5PzipQLZjWLX9kkXAj3eKcA=
X-Received: by 2002:a17:907:94d0:b0:a9a:cf84:2e4b with SMTP id
 a640c23a62f3a-a9e50915893mr967262166b.25.1730557794334; Sat, 02 Nov 2024
 07:29:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031-iio-fix-write-event-config-signature-v2-0-2bcacbb517a2@baylibre.com>
 <20241031-iio-fix-write-event-config-signature-v2-13-2bcacbb517a2@baylibre.com>
 <20241101164118.687be624@jic23-huawei> <4e4e5281-d489-42b5-b358-c44958cfa4f9@tweaklogic.com>
In-Reply-To: <4e4e5281-d489-42b5-b358-c44958cfa4f9@tweaklogic.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Sat, 2 Nov 2024 15:29:35 +0100
Message-ID: <CAEHHSva6+Br9rXE9n0wqXuwQqetXN=Ae5vg0rxmPRfCVdw9atA@mail.gmail.com>
Subject: Re: [PATCH v2 13/15] iio: light: apds9306: simplifies if branch in apds9306_write_event_config
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Mudit Sharma <muditsharma.info@gmail.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Anshul Dalal <anshulusr@gmail.com>, 
	Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Cosmin Tanislav <cosmin.tanislav@analog.com>, 
	Ramona Gradinariu <ramona.gradinariu@analog.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	Dan Robertson <dan@dlrobertson.com>, Marcelo Schmitt <marcelo.schmitt@analog.com>, 
	Matteo Martelli <matteomartelli3@gmail.com>, 
	Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>, Michal Simek <michal.simek@amd.com>, 
	Mariel Tinaco <Mariel.Tinaco@analog.com>, Jagath Jog J <jagathjog1996@gmail.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Kevin Tsai <ktsai@capellamicro.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	chrome-platform@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le sam. 2 nov. 2024 =C3=A0 14:21, Subhajit Ghosh
<subhajit.ghosh@tweaklogic.com> a =C3=A9crit :
>
> On 2/11/24 03:11, Jonathan Cameron wrote:
> > On Thu, 31 Oct 2024 16:27:08 +0100
> > Julien Stephan <jstephan@baylibre.com> wrote:
> >
> >> Simplifies the regmap_wite if branch in apds9306_write_event_config.
> > Applied.
> >>
> >> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> >> ---
> >>   drivers/iio/light/apds9306.c | 5 +----
> >>   1 file changed, 1 insertion(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306=
.c
> >> index 8adc74040db2bddf93fbb773e3519abcc726b9a6..9c08e7c3ad0c17519689a6=
30d42fe9b90438dfe8 100644
> >> --- a/drivers/iio/light/apds9306.c
> >> +++ b/drivers/iio/light/apds9306.c
> >> @@ -1125,10 +1125,7 @@ static int apds9306_write_event_config(struct i=
io_dev *indio_dev,
> >>              }
> >>      }
> >>      case IIO_EV_TYPE_THRESH_ADAPTIVE:
> >> -            if (state)
> >> -                    return regmap_field_write(rf->int_thresh_var_en, =
1);
> >> -            else
> >> -                    return regmap_field_write(rf->int_thresh_var_en, =
0);
> >> +            return regmap_field_write(rf->int_thresh_var_en, state);
> >>      default:
> >>              return -EINVAL;
> >>      }
> >>
> >
> Hi Julien,
> Sorry for the delay.
> "int_thresh_var_en" corresponds to APDS9306_INT_CFG_REG bit 3 (Datasheet:=
 INT_CFG, Address: 0x19) which
> is a single bit value only. If user does "echo 4 > /sys/bus/iio/devices/i=
io:device0/events/thresh_adaptive_either_en",
> which trickles down to the "state" variable, do we really want to write a=
ny other value except "0" or "1"?
> Correct me if I am wrong here.

Hi Subhajit,
In drivers/iio/industrialio-event.c, iio_ev_state_store is actually
using kstrtobool to check user input, then gives the converted boolean
value to write_event_config.
So state is a boolean. By the way the purpose of this series is to
clean up code and use a bool instead of int for the state parameter.

So new code is equivalent to what was there before.
Cheers
Julien


> Regards,
> Subhajit Ghosh

