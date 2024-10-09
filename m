Return-Path: <linux-kernel+bounces-356833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6013D996773
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 12:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84A901C23E53
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 10:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685BE18FDC2;
	Wed,  9 Oct 2024 10:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uDEQ0r7U"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E005D18E751
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 10:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728470294; cv=none; b=Y+9hlEU47CywTAkr4hjVf15FO0mI74i2pQTGF3Ad6ji4MQJnlc1jT1+Qjs4iPj7VeYJpGxSL3oa9qSPNo5wf6o7P7L+bL9ojsgcy68WbKy+kp8VjFhFUYZNDFpTq2LNtaQueJIFV4mqGysE1axgnFZhrAxlVcmoPD/WwmUkCXec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728470294; c=relaxed/simple;
	bh=Bh+XjD17aMUarcdTO7uSWw8kcbNLHSX05G1HB+CCinQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LPZJExJK9udYaCAoUiBbDMkWOGSG9SCqcrzegTf5JaDrZs9snyUohexB8OoaSFIlrfY0jdh/KiiLU2tVxPmkNN0oM6GOmbfA9R4nWH7MFhknFFSCzYzr1uSbzwUQ2B+EzbhhOWlVlk9KUjUPxt4ah0Zwo77SLopr1YThQ+f1/NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uDEQ0r7U; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso6673616276.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 03:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728470292; x=1729075092; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3VJeVYBfKYnkpG7DLQGKL9U1kDI2Y0lA6CnEfPiWNjA=;
        b=uDEQ0r7UsdCBEie321mD9kTD5XPt/TkiNXq0y8J1qbWoHeE6/avuS/S3XMWztUHlVW
         jaJ7iTzYjTNv9kY367j/7wtwKzJV+p0gMeW+qeido7ZYvFWadMCMI5mr4SQxOhDlWs7a
         nVGGkKI9r0YtY9sQSzuVUssQm1giDtusceDvcTiHvGIrLKQZ8ff9r5nRaCdaBLB+NjKr
         vC3fdHxsZDdz8gXPzQNYODCKCWzsuckxppF8dexeQmV4TAi+Q03blhOg5yY7uU5fN4v1
         JUWjWEfI75fbs0NZ6yjumRD1bX/xhyfGi4fz6MlXYc3x80omjnd4gVRZnQJpTyMjSi5J
         gBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728470292; x=1729075092;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3VJeVYBfKYnkpG7DLQGKL9U1kDI2Y0lA6CnEfPiWNjA=;
        b=sjElfCX35qu95loBYDyi1MoqQee/CJn7oO39J2avQrhEG15P/Uv+9gOLxtKADyQ6tx
         fw5oCxO1Nt0Nd093XocTU1rm03qaN5xRcRZYAprxgAh7nmdsnD0t8MJ5u4A+4VzAhljG
         HUWpY7JKcNCapx6FQ+K31PTgeCIvsRkki9UUkh6qYfUeJuxGn0LyQnQjGfZkIoAeB6FP
         usATEQhn9tpZs5tWoP5sbk7hwoTV8pYuyzV0ASbiSnE8hZalb4SsRD04/FxcBeBM4aDE
         D0KVU+cL5cvDiJ5hRnly/VHiDWAsPk9OYXppGYyIn161A8iC18o9dzVVSkLN2ll4ivwC
         5QbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyNOi+C1EjTUYhiUy781jGXkv+gP8grU5DJxz+MA1y5P1j//DiHMjTBV+vNtDz1xvd0Yx3hdoqh06qVOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKmJuMh2JBgUjBs912ZtoY3AexpMUnrcbjoER6B8GlOTRUKErQ
	sHc/r9tCEoxZuYI36xCa2xICxZJpyDYMOyypyXBtNcHKVy3DiyGqEM7nBnPbLqjKFJWD1s7JElx
	EYq3PeBj71rtA3h0Kz4HwttSkDh1/H0n70Z49bg==
X-Google-Smtp-Source: AGHT+IEaCqT2FEb0CIjrhdIKMtBmr3sjquXjMBesp6gahz+RMRdDBcgXZh9L7SRu1wzN7reOTF/jLVAAQ5XdWvmbnAY=
X-Received: by 2002:a05:6902:1a4a:b0:e28:67b3:d731 with SMTP id
 3f1490d57ef6-e28fe4cf0cbmr1708003276.9.1728470291883; Wed, 09 Oct 2024
 03:38:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913102836.6144-1-victorshihgli@gmail.com>
 <20240913102836.6144-3-victorshihgli@gmail.com> <c053b350-f1ef-4a1c-b19e-4fe704279f49@ijzerbout.nl>
In-Reply-To: <c053b350-f1ef-4a1c-b19e-4fe704279f49@ijzerbout.nl>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Oct 2024 12:37:36 +0200
Message-ID: <CAPDyKFpLOdydbOEe4KSmVc_C=umAieR_+Bo--JmVRDtPiX3YuQ@mail.gmail.com>
Subject: Re: [PATCH V22 02/22] mmc: core: Prepare to support SD UHS-II cards
To: Kees Bakker <kees@ijzerbout.nl>
Cc: Victor Shih <victorshihgli@gmail.com>, adrian.hunter@intel.com, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	benchuanggli@gmail.com, Lucas.Lai@genesyslogic.com.tw, 
	HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw, dlunev@chromium.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Oct 2024 at 21:56, Kees Bakker <kees@ijzerbout.nl> wrote:
>
> Op 13-09-2024 om 12:28 schreef Victor Shih:
> > From: Ulf Hansson <ulf.hansson@linaro.org>
> >
> > The SD UHS-II interface was introduced to the SD spec v4.00 several years
> > ago. The interface is fundamentally different from an electrical and a
> > protocol point of view, comparing to the legacy SD interface.
> >
> > However, the legacy SD protocol is supported through a specific transport
> > layer (SD-TRAN) defined in the UHS-II addendum of the spec. This allows the
> > SD card to be managed in a very similar way as a legacy SD card, hence a
> > lot of code can be re-used to support these new types of cards through the
> > mmc subsystem.
> >
> > Moreover, an SD card that supports the UHS-II interface shall also be
> > backwards compatible with the legacy SD interface, which allows a UHS-II
> > card to be inserted into a legacy slot. As a matter of fact, this is
> > already supported by mmc subsystem as of today.
> >
> > To prepare to add support for UHS-II, this change puts the basic foundation
> > in the mmc core in place, allowing it to be more easily reviewed before
> > subsequent changes implements the actual support.
> >
> > Basically, the approach here adds a new UHS-II bus_ops type and adds a
> > separate initialization path for the UHS-II card. The intent is to avoid us
> > from sprinkling the legacy initialization path, but also to simplify
> > implementation of the UHS-II specific bits.
> >
> > At this point, there is only one new host ops added to manage the various
> > ios settings needed for UHS-II. Additional host ops that are needed, are
> > being added from subsequent changes.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Updates in V10:
> >   - Drop unnecessary definitions and code.
> >
> > Updates in V9:
> >   - move sd_uhs2_operation definition of PatchV8[05/23] to
> >     PatchV9[02/23] for avoid compilation errors.
> >   - move uhs2_control definition of PatchV8[05/23] to
> >     PatchV9[02/23] for avoid compilation errors.
> >   - move mmc_host flags definition of PatchV8[05/23] to
> >     PatchV9[02/23] for avoid compilation errors.
> >   - move mmc_host flags MMC_UHS2_SUPPORT definition of PatchV8[05/23] to
> >     PatchV9[02/23] for avoid compilation errors.
> >   - move mmc_host flags MMC_UHS2_SD_TRAN definition of PatchV8[05/23] to
> >     PatchV9[02/23] for avoid compilation errors.
> >
> > Updates in V7:
> >   - Drop sd_uhs2_set_ios function.
> >   - Used ->uhs2_control() callback for uhs2_set_ios in sd_uhs2_power_up().
> >   - Used ->uhs2_control() callback for uhs2_set_ios in sd_uhs2_power_off().
> >   - Drop MMC_TIMING_SD_UHS2 in favor of MMC_TIMING_UHS2_SPEED_A.
> >   - Modify sd_uhs2_legacy_init to avoid sd_uhs2_reinit cycle issue.
> >
> > Updates in V4:
> >   - Re-based, updated a comment and removed white-space.
> >   - Moved MMC_VQMMC2_VOLTAGE_180 into a later patch in the series.
> >
> > ---
> >
> >   drivers/mmc/core/Makefile  |   2 +-
> >   drivers/mmc/core/core.c    |  17 ++-
> >   drivers/mmc/core/core.h    |   1 +
> >   drivers/mmc/core/sd_uhs2.c | 292 +++++++++++++++++++++++++++++++++++++
> >   include/linux/mmc/card.h   |   7 +
> >   include/linux/mmc/host.h   |  23 +++
> >   6 files changed, 340 insertions(+), 2 deletions(-)
> >   create mode 100644 drivers/mmc/core/sd_uhs2.c
> >
> > [...]
> > +/*
> > + * Run the enumeration process by sending the enumerate command to the card.
> > + * Note that, we currently support only the point to point connection, which
> > + * means only one card can be attached per host/slot.
> > + */
> > +static int sd_uhs2_enum(struct mmc_host *host, u32 *node_id)
> > +{
> > +     return 0;
> > +}
> > [...]
> > +/*
> > + * Allocate the data structure for the mmc_card and run the UHS-II specific
> > + * initialization sequence.
> > + */
> > +static int sd_uhs2_init_card(struct mmc_host *host)
> > +{
> > +     struct mmc_card *card;
> > +     u32 node_id;
> > +     int err;
> > +
> > +     err = sd_uhs2_dev_init(host);
> > +     if (err)
> > +             return err;
> > +
> > +     err = sd_uhs2_enum(host, &node_id);
> node_id is still uninitialized, see implementation of sd_uhs2_enum above
> > +     if (err)
> > +             return err;
> > +
> > +     card = mmc_alloc_card(host, &sd_type);
> > +     if (IS_ERR(card))
> > +             return PTR_ERR(card);
> > +
> > +     card->uhs2_config.node_id = node_id;
> Using uninitialized node_id

I practise this should not happen as the thought is that
sd_uhs2_enum() should return an error code, unless it can provide the
node_id.

In any case, it's better to initialize node_id at declaration, so I
have amended the patch like that.

[...]

Thanks for reviewing!

Kind regards
Uffe

