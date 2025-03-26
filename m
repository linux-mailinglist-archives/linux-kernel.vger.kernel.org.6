Return-Path: <linux-kernel+bounces-577404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D92A71CA0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 18:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6315F1896284
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3508919D07A;
	Wed, 26 Mar 2025 16:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="DPD/rkpe"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF441DED5F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 16:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743008387; cv=none; b=Yu1lG3cWGyvaP/TMT3wHbOIx62U9rlOQcS4DhHCR48edReVoahtzTwndwBgbaJ0/585iuGTGuqxKGraM05tibgyroD09RUZQHApCvQ7XV/VWdrQr4arEd/P6roRfUwgEMXSxduRkGltD/4Q8WXQ8k/NWFMcUiBtlneXnT0eC4ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743008387; c=relaxed/simple;
	bh=z8v4HgNksasV6Ym9ZoHWSxFb1Pm6JPjkpNDX7QGI6w0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7ZtMu1dRhqNxrPE9ElPzNnspZ9FLG4HGgB3xRbYM0FkDuxMc2SGan1fOSpIRZdrJDeAcNDgD0omrGz9bdAe4LOnvh6hR7GwFh5QB/ODRrU787jJkkeyZORjykmGBLKyCx/H5GnxgSrkIhoxLhOdDWvoyODDPtlhvfcdRODc+wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=DPD/rkpe; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ff615a114bso1957149a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 09:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1743008385; x=1743613185; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k1ta+e4yZg+E/JBqDKl34KJtyjkMqGr/ZUFNKEBvHrc=;
        b=DPD/rkpetSSW/NtLwL8QyYBd8SWFIvgKt8xEt0+rQ4HSIEPPE/2+e4usYpEwVdKij0
         ap75QrGZ1b+j8fANYs9J46fZeeGFSbKsdwn2OVDTY+ibXDJyqBkE0JX85RzcQ3rYojGs
         Tq5HLTh6IKlqLnodtYEOsdsMm9pbMOvmLudQW7pGgDYagvR2ec9TOIn9vSJQzmdz2y8T
         Vo23yU33cqr/J0Ksv/WS5H6l3RYRL1dF8K4DAK0u43NRQUrxrOs/bkdz5JZnQpUZQUXD
         qcSxrv4pVsK83uVZheeTfeSsS1NgwmRzUqPHsbFnq6sOW7bgA/yAEcP48YNDcGM/EsjN
         u99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743008385; x=1743613185;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k1ta+e4yZg+E/JBqDKl34KJtyjkMqGr/ZUFNKEBvHrc=;
        b=Vu5/a9u73qR3BiUXzDl9TqWPlJC652inR3L9VGulIaLogLVokTPA7NZA1QFJLUW2qU
         XlW+5M/f/SELzsn9oiGuTqSvfPcSyO4OitCBIpltHiJQuBUddHuxnRrKkaohiY5SnrLC
         IgBFVtPawjOduK/TVi/Gw66Ft9oe1szJHuBd3veDaQwjb56XyA9+i76SUR372pCc3sS4
         Z+Ip65WJ5UTnULvUq8083T27DqYLqNIVbqzjM5b9jonp5g4/MRMHnR9dMcDyt3axm6HF
         /pve23UOdcrB8Gind4/eDR7UnC6XP9DsSJLdiidVhygJl7U2O0J4Sb3pjkkg21f2tYMk
         +PfA==
X-Forwarded-Encrypted: i=1; AJvYcCWSupsSFDtDbiEEY0QQ3A9cDqbDBkRIe6wUQBxN4lnjwI5vXPy/5g08ig/qbDtBXzIzsR6E+m75nmQ5bAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWLXXsYAw4eg0H2NE2y8EVb2UsgpLwyNoSg+O18CyilNTmYauA
	zVz4ZU2kuDjL40UPT+VDfa5mXobFI52KaWPZOoLDDWjNnNTHe6ib4u06GXfRdXX7Y5zalGstcJn
	185UA7E9Dckz80DnA8uH0aLOKld/wVbXK5gGxjQ==
X-Gm-Gg: ASbGnct42ozfatHbMEpyf0OJc5ajgIysYToeLcnqZJsKJpIAcLs+L2Ijg1SdH8sFJZ8
	a+vtPD3TUv4NrJ3yklQVBpujssjKV2+7nYfsQ9goKtWutTVyydmKZSWrsp+k/a27MVSbqKSAARW
	e8dXcdC9L0WqK7j7qyfujd6Xt0TZw=
X-Google-Smtp-Source: AGHT+IF/ZIUOzoCMXkmF9NPMBJoRs7scjT/WUjWYTeNlhns68B6x95FZ4W9S/inkhtFJoFewTokWWenkVY3WgzQlTmY=
X-Received: by 2002:a17:90b:54c4:b0:2fa:562c:c1cf with SMTP id
 98e67ed59e1d1-303788c2685mr7077910a91.1.1743008385079; Wed, 26 Mar 2025
 09:59:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324185744.2421462-1-you@example.com> <b6668968-897f-4864-913c-d4d557f1d7cc@roeck-us.net>
 <CABqG17h8cpnFkdD-nnqyr+UnwADU9XWK6TGBxj_FCH37Y3Q1Lw@mail.gmail.com> <be099cf4-338b-45c8-b0d3-24b2cefe386e@roeck-us.net>
In-Reply-To: <be099cf4-338b-45c8-b0d3-24b2cefe386e@roeck-us.net>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Wed, 26 Mar 2025 22:29:33 +0530
X-Gm-Features: AQ5f1JqHhKNucZ4ApFXKvUPExSvoJwEGxZ88fxC3KKffOUHRX87iCId87ML5ll0
Message-ID: <CABqG17gZV7ZBKOz0gTsrfsuHQENF3VM2T-=O27sWdc1PP9OmPA@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (max6639) : Allow setting target RPM
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Guenter,

On Wed, 26 Mar 2025 at 22:19, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 3/26/25 09:36, Naresh Solanki wrote:
> > Hi Guenter,
> >
> > On Tue, 25 Mar 2025 at 05:00, Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >> On 3/24/25 11:57, Your Name wrote:
> >>> From: Naresh Solanki <naresh.solanki@9elements.com>
> >>>
> >>> Currently, during startup, the fan is set to its maximum RPM by default,
> >>> which may not be suitable for all use cases.
> >>> This patch introduces support for specifying a target RPM via the Device
> >>> Tree property "target-rpm".
> >>>
> >>> Changes:
> >>> - Added `target_rpm` field to `max6639_data` structure to store the
> >>>     target RPM for each fan channel.
> >>> - Modified `max6639_probe_child_from_dt()` to read the `"target-rpm"`
> >>>     property from the Device Tree and set `target_rpm` accordingly.
> >>> - Updated `max6639_init_client()` to use `target_rpm` to compute the
> >>>     initial PWM duty cycle instead of defaulting to full speed (120/120).
> >>>
> >>> Behavior:
> >>> - If `"target-rpm"` is specified, the fan speed is set accordingly.
> >>> - If `"target-rpm"` is not specified, the previous behavior (full speed
> >>>     at startup) is retained.
> >>>
> >>
> >> Unless I am missing something, that is not really correct. See below.
> >>
> >>> This allows better control over fan speed during system initialization.
> >>>
> >>> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> >>> ---
> >>>    drivers/hwmon/max6639.c | 15 ++++++++++++---
> >>>    1 file changed, 12 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/drivers/hwmon/max6639.c b/drivers/hwmon/max6639.c
> >>> index 32b4d54b2076..ca8a8f58d133 100644
> >>> --- a/drivers/hwmon/max6639.c
> >>> +++ b/drivers/hwmon/max6639.c
> >>> @@ -80,6 +80,7 @@ struct max6639_data {
> >>>        /* Register values initialized only once */
> >>>        u8 ppr[MAX6639_NUM_CHANNELS];   /* Pulses per rotation 0..3 for 1..4 ppr */
> >>>        u8 rpm_range[MAX6639_NUM_CHANNELS]; /* Index in above rpm_ranges table */
> >>> +     u32 target_rpm[MAX6639_NUM_CHANNELS];
> >>>
> >>>        /* Optional regulator for FAN supply */
> >>>        struct regulator *reg;
> >>> @@ -560,8 +561,14 @@ static int max6639_probe_child_from_dt(struct i2c_client *client,
> >>>        }
> >>>
> >>
> >> target_rpm[] is 0 here.
> >>
> >>>        err = of_property_read_u32(child, "max-rpm", &val);
> >>> -     if (!err)
> >>> +     if (!err) {
> >>>                data->rpm_range[i] = rpm_range_to_reg(val);
> >>> +             data->target_rpm[i] = val;
> >>> +     }
> >>
> >> If there is no max-rpm property, or if there is no devicetree support,
> >> target_rpm[i] is still 0.
> >>
> >>> +
> >>> +     err = of_property_read_u32(child, "target-rpm", &val);
> >>> +     if (!err)
> >>> +             data->target_rpm[i] = val;
> >>
> >> If there is neither max-rpm nor target-rpm, target_rpm[i] is still 0.
> >>
> >>>
> >>>        return 0;
> >>>    }
> >>> @@ -573,6 +580,7 @@ static int max6639_init_client(struct i2c_client *client,
> >>>        const struct device_node *np = dev->of_node;
> >>>        struct device_node *child;
> >>>        int i, err;
> >>> +     u8 target_duty;
> >>>
> >>>        /* Reset chip to default values, see below for GCONFIG setup */
> >>>        err = regmap_write(data->regmap, MAX6639_REG_GCONFIG, MAX6639_GCONFIG_POR);
> >>> @@ -639,8 +647,9 @@ static int max6639_init_client(struct i2c_client *client,
> >>>                if (err)
> >>>                        return err;
> >>>
> >>> -             /* PWM 120/120 (i.e. 100%) */
> >>> -             err = regmap_write(data->regmap, MAX6639_REG_TARGTDUTY(i), 120);
> >>> +             /* Set PWM based on target RPM if specified */
> >>> +             target_duty = 120 * data->target_rpm[i] / rpm_ranges[data->rpm_range[i]];
> >>
> >> If there is no devicetree support, or if neither max-rpm nor target-rpm are
> >> provided, target_duty will be 0, and the fans will stop.
> >>
> >> Maybe my interpretation is wrong, but I think both target_rpm[] and rpm_range[]
> >> will need to be initialized. Also, it seems to me that there will need to be an
> >> upper bound for target_rpm[]; without it, it is possible that target_duty > 120,
> >> which would probably not be a good idea.
> > Yes you're right. I missed it in my analysis.
> >
> > Here is the logic that would address:
> >                  target_rpm = 120;
> >                  /* Set PWM based on target RPM if specified */
> >                  if (data->target_rpm[i] != 0 &&
> >                      data->target_rpm[i]  <= rpm_ranges[data->rpm_range[i]]) {
> >
> >                          target_duty = 120 * data->target_rpm[i] /
> > rpm_ranges[data->rpm_range[i]];
> >                  }
> >
> > Please let me know your thoughts & suggestions.
> >
>
> I would prefer if target_rpm[] and rpm_range[] were pre-initialized with default
> values in the probe function. That would avoid runtime checks.
rpm_range is pre-initialized to 4000 RPM [1]
I can also init target_rpm[] to 4000 RPM as default along with above init.

But still there might be a case wherein DT doesn't provide max-rpm but
target-rpm is set to greater than 4000 RPM
Thus there will be a need to check to cover this kind of scenario.

Please let me know your thoughts & will implement that.

[1]https://kernel.googlesource.com/pub/scm/linux/kernel/git/groeck/linux-staging/+/hwmon-next/drivers/hwmon/max6639.c#586

Regards,
Naresh
>
> Thanks,
> Guenter
>

