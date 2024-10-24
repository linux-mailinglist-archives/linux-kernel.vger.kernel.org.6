Return-Path: <linux-kernel+bounces-379866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC099AE53B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41772B21A4F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76BA1D63C1;
	Thu, 24 Oct 2024 12:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rp/LtimV"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5761BDABD
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 12:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729773711; cv=none; b=ffVOolaJS0v7G7CVv2NEb3oesziPdYGPbnJnicskqHvqOxzJqFj77E/ZmqffhrrBpT1HS2C2ttp1eCwG8x0ifMeFcTbiW8apXeEl35siAkPXnqEpLgf5szBrXpkGiVJTQukv4jy1GuaZg8heg2MIu6sNoj7uLkZn+SrADDl/S24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729773711; c=relaxed/simple;
	bh=oWPA/2U1Bgaa+ki5dn0LOSX4WA4bXxtkFxP76lA9Kkk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nQpupz09d/1LD2FXcG4bk5I770zv/pAdUwVluk3ww1eKdIxxc/ALLNtfxRR8UQY6UyvvZ3RHRvRbq0Zp3SXTcm2XEbzFHGPuzw4beggRunZ39onnk4SoN9B8L/BYHo01q4Ayvs6LgTVqSxhqBNst4y2IB6AJM8v3uvptokchwAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rp/LtimV; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e305c2987bso8281337b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 05:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729773708; x=1730378508; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6nrguRJ1ngVjVKk6xWYfwqCRJTmyUYBAOWkMRtDC6UA=;
        b=rp/LtimV7z3cMOnnWer6TKNi7RNs6fqJYFP3KCIQqtjdPhYKv8Db6rW3X0P55dIwM/
         nMtrDkYYhNugOraCjtujCDUNRrIzkTepMJE0TL7+y5Hmclr2Pt4s9+iQDsJgXBCHFoQf
         JNnl6QvmDAetH8NfQmoTsrEDgHS7Tl9/dHYFsrnuBDrgvakQpCeMkks4lOt49tvfLCT8
         s22la8I/C5qBlyIlgnOk8i40/KM69Gd9EXp4wGx8UsfZSe/0YGFlYtDjdlccqY7QGFx6
         pTuvCeqGK/q/v13j3Pfk5mlzFNPgpMcnj5o9EW332ntdvhxvL7jzV7l2H6pdelD7NOR4
         0n0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729773708; x=1730378508;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6nrguRJ1ngVjVKk6xWYfwqCRJTmyUYBAOWkMRtDC6UA=;
        b=OLhaq1Z9hTUQcwbTQJni/AoH+BmWGPqQnsumOZ/p5tF70n50UuMly6iVrQNbCJiqVH
         D8/O02MRnVqoGj54oFF7RjbCa5IK+Bksnh2RIKl93+vdMoTmYc4Mc5Z+zYWyDeb1gS+2
         meQyHkIK5e7TRyDF8yAAXy74hkpDoOMo/p6SvL4hdEe5dhGzUbZgZ8SpFek7yL3XD8st
         +8ac+tYcvNgarzpGDIeBYKmyEBS479TelkuGee6ntp84N5ATRxmLoSLwGJJ9uaOq6MRS
         QnvTGxeH43axg6Vk4YNn9BIPMVwAw/4l0KBkMPL39pE6q7kQWEH+Y+RjXdCEVDYrr7N1
         Teew==
X-Forwarded-Encrypted: i=1; AJvYcCU7x5GupecDsiqkAOYs2MifBnwM2uLi+mIAcw3BHdyi6gjqFEaOA9QeS/guVr6QczIjbobu7SoOiiAJGJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJAXP7wnM3K7+UztaTv18VE3xriXaMUjr4UGuWr0YmFdW/TmuJ
	fGZ8DGu7nKxQQNGGJS8aIcwWIiBRrtUU2QHKQaIxPeUh0Lo2jC5KC8DdQwYjw9y9YRHBGgRl615
	z4/W3v50eUX4zklgd/dpp2202YvurnEIbatziiQ==
X-Google-Smtp-Source: AGHT+IE69ezedNUOLVOrv8Tbf/4XuiEwvQr/cDlHISG8tirVX4Epc9Z1eC9+3p0MK2qi9f6jO1pGRtjZYSuh0snLGOE=
X-Received: by 2002:a05:690c:fc6:b0:6e7:e76e:5852 with SMTP id
 00721157ae682-6e7f0fa4112mr72569707b3.32.1729773707683; Thu, 24 Oct 2024
 05:41:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018105333.4569-1-victorshihgli@gmail.com>
 <20241018105333.4569-2-victorshihgli@gmail.com> <a8033f18-7836-4de4-b21a-b81f52c1698d@intel.com>
In-Reply-To: <a8033f18-7836-4de4-b21a-b81f52c1698d@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 24 Oct 2024 14:41:11 +0200
Message-ID: <CAPDyKFqrkzDTakhzZOsF2mBpko0XG_v5mKManhTQzj1XRJfxxg@mail.gmail.com>
Subject: Re: [PATCH V23 01/16] mmc: core: Support UHS-II card control and access
To: Victor Shih <victorshihgli@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	benchuanggli@gmail.com, Lucas.Lai@genesyslogic.com.tw, 
	HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw, dlunev@chromium.org, 
	Jason Lai <jason.lai@genesyslogic.com.tw>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"

[...]

> > +
> >  static int sd_uhs2_power_up(struct mmc_host *host)
> >  {
> >       int err;
> > @@ -42,12 +70,46 @@ static int sd_uhs2_power_off(struct mmc_host *host)
> >
> >       host->ios.vdd = 0;
> >       host->ios.clock = 0;
> > +     /* Must set UHS2 timing to identify UHS2 mode */
>
> That comment is stale, but...
>
> >       host->ios.timing = MMC_TIMING_LEGACY;
>
> MMC_TIMING_UHS2_SPEED_A is also checked by mmc_card_uhs2()
> which is used a lot.
>
> It might be that ios.timing should be MMC_TIMING_UHS2_SPEED_A
> until after calling host->ops->uhs2_control() ?

I agree, that was also how the code looked before my previous comment for v22.

Victor, sorry for the confusion, I simply didn't realize that
mmc_card_uhs2() was using MMC_TIMING_UHS2_SPEED_A.

It looks like we should set MMC_TIMING_LEGACY, *after* calling
host->ops->uhs2_control(). Just to make sure we have the correct
initial state after powering-off.

I will fix this when applying, see more comments about that below.

>
> >       host->ios.power_mode = MMC_POWER_OFF;
> > +     host->uhs2_sd_tran = false;
> >
> >       return host->ops->uhs2_control(host, UHS2_SET_IOS);
> >  }

[...]

> > +static int sd_uhs2_init_card(struct mmc_host *host, struct mmc_card *oldcard)
> >  {
> >       struct mmc_card *card;
> >       u32 node_id = 0;
> > @@ -131,33 +818,211 @@ static int sd_uhs2_init_card(struct mmc_host *host)
> >       if (err)
> >               return err;
> >
> > -     card = mmc_alloc_card(host, &sd_type);
> > -     if (IS_ERR(card))
> > -             return PTR_ERR(card);
> > +     if (oldcard) {
> > +             card = oldcard;
> > +     } else {
> > +             card = mmc_alloc_card(host, &sd_type);
> > +             if (IS_ERR(card))
> > +                     return PTR_ERR(card);
> > +     }
> >
> >       card->uhs2_config.node_id = node_id;
> >       card->type = MMC_TYPE_SD;
> >
> >       err = sd_uhs2_config_read(host, card);
> >       if (err)
> > -             goto err;
> > +             return err;
>
> This leaks card if !oldcard.  Still need:
>
> err:
>         if (!oldcard)
>                 mmc_remove_card(card);
>
>
> >
> >       err = sd_uhs2_config_write(host, card);
> >       if (err)
> > -             goto err;
> > +             return err;
>
> Ditto
>
> >
> >       host->card = card;
> > +     /* If change speed to Range B, need to GO_DORMANT_STATE */
> > +     if (host->ios.timing == MMC_TIMING_UHS2_SPEED_B ||
> > +         host->ios.timing == MMC_TIMING_UHS2_SPEED_B_HD) {
> > +             err = sd_uhs2_go_dormant_state(host, node_id);
> > +             if (err)
> > +                     return err;
>
> And here host->card is assigned but we have failed.
> The other card types do not set host->card until
> just before return 0.  Then this can be goto err
> instead of return err.

In regards to the error path and how to handle the cleanup of the
mmc_card, indeed things are still not correct.

However, I realize these parts are somewhat a bit tricky to get right.
Therefore, I am simply going to leave this as is when applying and I
am going to send patches that fixes things on top.

In this way we can move things forward and avoid additional new
versions of the complete series to be sent.

> > +     }
> > +
> > +     host->uhs2_sd_tran = true;
> > +
> > +     return 0;
> > +}
> > +
>

[...]

Kind regards
Uffe

