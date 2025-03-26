Return-Path: <linux-kernel+bounces-577508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C502AA71E09
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 19:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4F207A2531
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA8F24EF8A;
	Wed, 26 Mar 2025 18:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="f0Q6OfJ3"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363071F4E49
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 18:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743012488; cv=none; b=dE4PfpMFbyRjDvcuzsqWfiSmMihHdN7a9KG9j9LBHVycEDQXJPsR6EwKtvzkTPOP+F+ZENBER5Tp+TgHnu3Ngj+U5jmRP6Z3z+DwI5Wcdet5OCvZS6XHbHpsn1+feMGJuzsaK4G2ULUqW6QDqPvpyFg/lqP8asX5cfCDTcP4t18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743012488; c=relaxed/simple;
	bh=URQyl4tH0PzKLy9WC/RO3oiK4xPAoEVpfwup1t9IpIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iiMHIb2oba+wZgHNOpApKtm0BzTs2MdVVTZxDZV2POPoKMOPwouFN2KazoGaq1roreflsU2vAqoSfmPU94TBH51NRaC3BgqPjX0v/lpQZ74eO09QjNfHiQFj2WeIUgU8Fa4IVF0YQHsMXAAx6paVp6D6ks4HpFq5AsUXpfBdtCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=f0Q6OfJ3; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ff784dc055so135454a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 11:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1743012485; x=1743617285; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xwyWpp6NjyzViTEy9V1FeJk96O+ppn1vtjZNle+TRUw=;
        b=f0Q6OfJ3rYVqBGovNfKxJg3ZeCCXWv5QmLZ96853Z3kc+qo7Hk1cXoME7NYujhsjd3
         wryAWY6/AbtiIs+eURqmYViJEFeQ52qr5/L5SUMqpQDDXbRVko7JroaPawfpZFgcBjCi
         lqll2r84dnwNS8ygcU7c1rFbtF16a3WsVheTVyXWV+yO5cLmvcuog9kq0E53Pg8tfUdu
         MN3Lj1ChYIOKfNpZNaZduA999yEt4fITUeUMhGau25MOhwmp15t99Lr2lFbxQGvsGrtQ
         f8J0yAKPfn2ASNxYfJRR3+RkWPjUW06lRZu2bMkXL8cIJ3Apr2zGBxhE+a/RAvyi3gAa
         APGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743012485; x=1743617285;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xwyWpp6NjyzViTEy9V1FeJk96O+ppn1vtjZNle+TRUw=;
        b=uYMqZZWfKptmoSvz+wvO7bflt+SUI+E7PDkq1mQhfVh3uHFMXLV9iTULe4nmZr44hS
         hEJzQ7huz7m0oW/n82HjmAbMpT3KpFFiaqRFcJ0RlG8iYIznsnn4zly4AGT8LfJDKuAB
         P3ToRXb8bjT11/D/Zo9WLAgzK5Ouqeh7mzIdemcuSPoiBuR13XOiJbp1cQ4ch/rG6CNE
         UmHN8t235kD/ogGFIqbgnY8dBz3MBNyICVw+k3n9ymltrZf9C831gCHC4bdx2P4tUyeM
         EW9sz3KmI0mmI0Zb4OlZFacrpZ+tDi/sNGGhi5q5Z2lmT3E3x8EsoLtQowYR2/4NBiov
         Xwbw==
X-Forwarded-Encrypted: i=1; AJvYcCVmkNSmGLli0tkHmtM1jtlcNOQBVs7daulfdfj3uZQL56/oHv9An+RjhTlUR20YvpJS9mtrWPNYQQSjz1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO8pSTk1opImTCMz4sZYmPPFa+xj3ROd9l1kQ+mhw6IKEkcFR6
	lqqKnyNGQcRmlllokdHIQ3MPoQjml5AfkVp/t4pR7H+kYua11AacXmXqHV+lQ2iSuxWpu/wRONl
	MGTNGhErjVz7gBmkYwroDAsEFTOCdNLzOoVCFzw==
X-Gm-Gg: ASbGnculrpjxfSGeL5Ih3OiEuzJ1ohZauLQVCxszh7MeVCgmPDu2W2WcPh4Aeh2jJfQ
	rLcbhihYmNRbFKtWaIxZW77Oe4vWa62XyEhfu2poFRN/8kmZN9F8tTDe3ycOWdGfPNQclUy/s4B
	aM2xc5cMJyf5IB4yCMQ8+lDP4UGTQ=
X-Google-Smtp-Source: AGHT+IGHiEBJBF5KRvnu0JX8oj3+lob88L1DiWChI4O/LjZnN4eigemIgLFo34c5mCQ/aiM8I4/UK94ELFsdq1LZ9qc=
X-Received: by 2002:a17:90b:3d0a:b0:2ff:53ad:a0f4 with SMTP id
 98e67ed59e1d1-303a7d6a99cmr1026340a91.12.1743012484659; Wed, 26 Mar 2025
 11:08:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324185744.2421462-1-you@example.com> <b6668968-897f-4864-913c-d4d557f1d7cc@roeck-us.net>
 <CABqG17h8cpnFkdD-nnqyr+UnwADU9XWK6TGBxj_FCH37Y3Q1Lw@mail.gmail.com>
 <be099cf4-338b-45c8-b0d3-24b2cefe386e@roeck-us.net> <CABqG17gZV7ZBKOz0gTsrfsuHQENF3VM2T-=O27sWdc1PP9OmPA@mail.gmail.com>
 <efa85637-7a6b-475c-b7ca-3a3c8fc3429b@roeck-us.net>
In-Reply-To: <efa85637-7a6b-475c-b7ca-3a3c8fc3429b@roeck-us.net>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Wed, 26 Mar 2025 23:37:54 +0530
X-Gm-Features: AQ5f1Jp1TnSfzXTfnxX16bIfsZs5x0-AMtYogN6IxXwde82G70bCr5raS6qugbQ
Message-ID: <CABqG17iUvv_9+_PhWcAwtQbu5-LNwqO5HOFONK6R3vgv4mU4qA@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (max6639) : Allow setting target RPM
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Guenter,

On Wed, 26 Mar 2025 at 23:12, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 3/26/25 09:59, Naresh Solanki wrote:
> > Hi Guenter,
> >
> > On Wed, 26 Mar 2025 at 22:19, Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >> On 3/26/25 09:36, Naresh Solanki wrote:
> >>> Hi Guenter,
> >>>
> >>> On Tue, 25 Mar 2025 at 05:00, Guenter Roeck <linux@roeck-us.net> wrote:
> >>>>
> >>>> On 3/24/25 11:57, Your Name wrote:
> >>>>> From: Naresh Solanki <naresh.solanki@9elements.com>
> >>>>>
> >>>>> Currently, during startup, the fan is set to its maximum RPM by default,
> >>>>> which may not be suitable for all use cases.
> >>>>> This patch introduces support for specifying a target RPM via the Device
> >>>>> Tree property "target-rpm".
> >>>>>
> >>>>> Changes:
> >>>>> - Added `target_rpm` field to `max6639_data` structure to store the
> >>>>>      target RPM for each fan channel.
> >>>>> - Modified `max6639_probe_child_from_dt()` to read the `"target-rpm"`
> >>>>>      property from the Device Tree and set `target_rpm` accordingly.
> >>>>> - Updated `max6639_init_client()` to use `target_rpm` to compute the
> >>>>>      initial PWM duty cycle instead of defaulting to full speed (120/120).
> >>>>>
> >>>>> Behavior:
> >>>>> - If `"target-rpm"` is specified, the fan speed is set accordingly.
> >>>>> - If `"target-rpm"` is not specified, the previous behavior (full speed
> >>>>>      at startup) is retained.
> >>>>>
> >>>>
> >>>> Unless I am missing something, that is not really correct. See below.
> >>>>
> >>>>> This allows better control over fan speed during system initialization.
> >>>>>
> >>>>> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> >>>>> ---
> >>>>>     drivers/hwmon/max6639.c | 15 ++++++++++++---
> >>>>>     1 file changed, 12 insertions(+), 3 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
> >>>>> index 32b4d54b2076..ca8a8f58d133 100644
> >>>>> --- a/drivers/hwmon/max6639.c
> >>>>> +++ b/drivers/hwmon/max6639.c
> >>>>> @@ -80,6 +80,7 @@ struct max6639_data {
> >>>>>         /* Register values initialized only once */
> >>>>>         u8 ppr[MAX6639_NUM_CHANNELS];   /* Pulses per rotation 0..3 for 1..4 ppr */
> >>>>>         u8 rpm_range[MAX6639_NUM_CHANNELS]; /* Index in above rpm_ranges table */
> >>>>> +     u32 target_rpm[MAX6639_NUM_CHANNELS];
> >>>>>
> >>>>>         /* Optional regulator for FAN supply */
> >>>>>         struct regulator *reg;
> >>>>> @@ -560,8 +561,14 @@ static int max6639_probe_child_from_dt(struct i2c_client *client,
> >>>>>         }
> >>>>>
> >>>>
> >>>> target_rpm[] is 0 here.
> >>>>
> >>>>>         err = of_property_read_u32(child, "max-rpm", &val);
> >>>>> -     if (!err)
> >>>>> +     if (!err) {
> >>>>>                 data->rpm_range[i] = rpm_range_to_reg(val);
> >>>>> +             data->target_rpm[i] = val;
> >>>>> +     }
> >>>>
> >>>> If there is no max-rpm property, or if there is no devicetree support,
> >>>> target_rpm[i] is still 0.
> >>>>
> >>>>> +
> >>>>> +     err = of_property_read_u32(child, "target-rpm", &val);
> >>>>> +     if (!err)
> >>>>> +             data->target_rpm[i] = val;
> >>>>
> >>>> If there is neither max-rpm nor target-rpm, target_rpm[i] is still 0.
> >>>>
> >>>>>
> >>>>>         return 0;
> >>>>>     }
> >>>>> @@ -573,6 +580,7 @@ static int max6639_init_client(struct i2c_client *client,
> >>>>>         const struct device_node *np = dev->of_node;
> >>>>>         struct device_node *child;
> >>>>>         int i, err;
> >>>>> +     u8 target_duty;
> >>>>>
> >>>>>         /* Reset chip to default values, see below for GCONFIG setup */
> >>>>>         err = regmap_write(data->regmap, MAX6639_REG_GCONFIG, MAX6639_GCONFIG_POR);
> >>>>> @@ -639,8 +647,9 @@ static int max6639_init_client(struct i2c_client *client,
> >>>>>                 if (err)
> >>>>>                         return err;
> >>>>>
> >>>>> -             /* PWM 120/120 (i.e. 100%) */
> >>>>> -             err = regmap_write(data->regmap, MAX6639_REG_TARGTDUTY(i), 120);
> >>>>> +             /* Set PWM based on target RPM if specified */
> >>>>> +             target_duty = 120 * data->target_rpm[i] / rpm_ranges[data->rpm_range[i]];
> >>>>
> >>>> If there is no devicetree support, or if neither max-rpm nor target-rpm are
> >>>> provided, target_duty will be 0, and the fans will stop.
> >>>>
> >>>> Maybe my interpretation is wrong, but I think both target_rpm[] and rpm_range[]
> >>>> will need to be initialized. Also, it seems to me that there will need to be an
> >>>> upper bound for target_rpm[]; without it, it is possible that target_duty > 120,
> >>>> which would probably not be a good idea.
> >>> Yes you're right. I missed it in my analysis.
> >>>
> >>> Here is the logic that would address:
> >>>                   target_rpm = 120;
> >>>                   /* Set PWM based on target RPM if specified */
> >>>                   if (data->target_rpm[i] != 0 &&
> >>>                       data->target_rpm[i]  <= rpm_ranges[data->rpm_range[i]]) {
> >>>
> >>>                           target_duty = 120 * data->target_rpm[i] /
> >>> rpm_ranges[data->rpm_range[i]];
> >>>                   }
> >>>
> >>> Please let me know your thoughts & suggestions.
> >>>
> >>
> >> I would prefer if target_rpm[] and rpm_range[] were pre-initialized with default
> >> values in the probe function. That would avoid runtime checks.
> > rpm_range is pre-initialized to 4000 RPM [1]
> > I can also init target_rpm[] to 4000 RPM as default along with above init.
> >
> Yes.
>
> > But still there might be a case wherein DT doesn't provide max-rpm but
> > target-rpm is set to greater than 4000 RPM
> > Thus there will be a need to check to cover this kind of scenario.
> >
> > Please let me know your thoughts & will implement that.
> >
>
> You'll need to validate target_rpm against max-rpm either way,
> to make sure that target_rpm <= max_rpm.
Will update in V2 accordingly.
Thanks for your inputs.

Regards,
Naresh
>
> Thanks,
> Guenter
>

