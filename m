Return-Path: <linux-kernel+bounces-318493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC1D96EEB5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 11:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EC041F257FA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 09:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206BC1AE021;
	Fri,  6 Sep 2024 09:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m9PtT39z"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DD21AD9C7
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 09:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725613248; cv=none; b=AqalNRftOX6Q5DXsLSbux0wgI5dm5WnJcmf6oay/yR0O6RN0Sy3iJrv3d5RMwEud92vXJ31Rc0q2aVYG294IHo3dfkFNm1a6tSnI5rWwMCIG2YLSW37QSBhiBMN5LG8ErRUUeJdDbNo4I6/DJfra+adORgS0AhhIsv8nto3XQnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725613248; c=relaxed/simple;
	bh=dneSZjJ2vPgl3hyYtX8hzcDr4+dBqK3UtPDLTWshofM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J5SZvgVyJEdq6tap8xoCdihPz6OpuHWXFguC/DmkrlCkoKUtl6FmzUbMoEsuzv1bGzBUZU5cdXDEFTT0Z9ms/CwaG0xNWvqrZtcuEPPJjL7frhylctjUJivNZeg/7ip1Bh94z+G8cVbVUNTHa5/WrC1+3T/J9WsLI2yLEE9yIPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m9PtT39z; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso1927952276.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 02:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725613245; x=1726218045; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DIQkSBKbbP3m5236+1FfLCnUNpyzVmpYKde35NrXJBM=;
        b=m9PtT39zdImH+FD9B323RUTLQwVMVT7khOPqKi3D7sY7fwOMGHThbweXvIdpYAKUiq
         o4KKmslIuxfCqBHMZHpSmn7JyHW3n/Sk+WIOTyzUdPi7SjKaLXi8+JeaNC/ou3Pqg6O6
         bs2b9/XOx6ybzsfVVg10bx3da4sKn+3dhQrnqqK8f+U25k1fS+u2Pwb78rfCsyFZz6UJ
         wJo9xgDyElAN16RSG4i67l3+FGJck/Dvo9sWBFGDrq320JrNf3dScHIO4xWFXL3p5pYs
         QuGVembFdr8RrH16NqRyVo0IQwRGWzFpqMTrnIwitAsn+po/7mMdHa/0LwMv/vtdeZl2
         IUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725613245; x=1726218045;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DIQkSBKbbP3m5236+1FfLCnUNpyzVmpYKde35NrXJBM=;
        b=er5yK8W+S4cw5MBzdn6rSGNrjFyCG6tsYeS3oDCaUHlJD8JDeQOOcKSwm8b/GlmpSF
         baAiH0qB+JRcEbEZ2EbWa8NtI+ZN84P18w0Z19pDz617I4qhSS42+rpiB/7Pv6bh0FQ7
         Epj+5tvcByl3UxTVnye3y+BFPPgD292TvKIK9DRzp0aF+Rtgrv8SEIqz6WM8f7KI1viD
         xsM/CFXYxdfdFvM0pJoPjccGNHNoxSfRZ0jsNDzcBlGrtN3Bz8vx9o9dYIgeO2Ds5WuL
         ku9MmdYNiPp499JVUIcu23mGC554EAy0m/HAhd+3y3yyc8CZ2odu6ayETJriTz2skvP/
         bivg==
X-Forwarded-Encrypted: i=1; AJvYcCXyYXIQmMzqRgpuXr4LGdj5d8nHsb09MuTepCeaJlUe7XalrqmwfQgfiWZTewnitdLsDWFQo6rD8xGoqPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVZ93NQfgZPdrO7iHkoXBmQ603HgokXYjiV7zcY++qRUZkAg0f
	Cf8JF+i3sTiiyEFGsXTFPuFN5uggD+UBQMO4q7DjHK5UV9qW0wGLtpVM7xc9r6eycP9BWOXgvDa
	Nslxta6d7GLcBNxKbQZWewUwHEWDLGj7YBO/eVg==
X-Google-Smtp-Source: AGHT+IEbGZeRmX6gvEeu1yF0puP76+awMCQf5K3ZBbrl3NdKFa3jl2iTSCp/Xzi2oPXO/ImUW54dLgh1F0yGvuVCvbA=
X-Received: by 2002:a05:6902:1005:b0:e1d:318c:d841 with SMTP id
 3f1490d57ef6-e1d34a0b18fmr2402394276.48.1725613245474; Fri, 06 Sep 2024
 02:00:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819-lpm-v6-10-constraints-pmdomain-v2-0-461325a6008f@baylibre.com>
 <CAPDyKFrFX_UeYWuZtQPoxHbZb0CwpLRA=QcMFsALwuiFTY3T5Q@mail.gmail.com> <7hplphah5w.fsf@baylibre.com>
In-Reply-To: <7hplphah5w.fsf@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 6 Sep 2024 11:00:09 +0200
Message-ID: <CAPDyKFrBSHRmP+CFd7xWXnN6LXKaAtihYv22b60wYsgSShCD+g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] pmdomain: ti_sci: collect and send low-power mode constraints
To: Kevin Hilman <khilman@baylibre.com>
Cc: linux-pm@vger.kernel.org, Nishanth Menon <nm@ti.com>, Vibhore Vardhan <vibhore@ti.com>, 
	Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
	Markus Schneider-Pargmann <msp@baylibre.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Sept 2024 at 00:07, Kevin Hilman <khilman@baylibre.com> wrote:
>
> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
> > On Tue, 20 Aug 2024 at 02:00, Kevin Hilman <khilman@baylibre.com> wrote:
> >>
> >> The latest (10.x) version of the firmware for the PM co-processor (aka
> >> device manager, or DM) adds support for a "managed" mode, where the DM
> >> firmware will select the specific low power state which is entered
> >> when Linux requests a system-wide suspend.
> >>
> >> In this mode, the DM will always attempt the deepest low-power state
> >> available for the SoC.
> >>
> >> However, Linux (or OSes running on other cores) may want to constrain
> >> the DM for certain use cases.  For example, the deepest state may have
> >> a wakeup/resume latency that is too long for certain use cases.  Or,
> >> some wakeup-capable devices may potentially be powered off in deep
> >> low-power states, but if one of those devices is enabled as a wakeup
> >> source, it should not be powered off.
> >>
> >> These kinds of constraints are are already known in Linux by the use
> >> of existing APIs such as per-device PM QoS and device wakeup APIs, but
> >> now we need to communicate these constraints to the DM.
> >>
> >> For TI SoCs with TI SCI support, all DM-managed devices will be
> >> connected to a TI SCI PM domain.  So the goal of this series is to use
> >> the PM domain driver for TI SCI devices to collect constraints, and
> >> communicate them to the DM via the new TI SCI APIs.
> >>
> >> This is all managed by TI SCI PM domain code.  No new APIs are needed
> >> by Linux drivers.  Any device that is managed by TI SCI will be
> >> checked for QoS constraints or wakeup capability and the constraints
> >> will be collected and sent to the DM.
> >>
> >> This series depends on the support for the new TI SCI APIs (v10) and
> >> was also tested with this series to update 8250_omap serial support
> >> for AM62x[2].
> >>
> >> [1] https://lore.kernel.org/all/20240801195422.2296347-1-msp@baylibre.com
> >> [2] https://lore.kernel.org/all/20240807141227.1093006-1-msp@baylibre.com/
> >>
> >> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> >> ---
> >> Changes in v2:
> >>
> >> - To simplify this version a bit, drop the pmdomain ->power_off()
> >>   changes.  Constraints only sent during ->suspend() path.  The pmdomain
> >>   path was an optimization that may be added back later.
> >> - With the above simplification, drop the extra state variables that
> >>   had been added to keep track of constraint status.
> >> - Link to v1: https://lore.kernel.org/r/20240805-lpm-v6-10-constraints-pmdomain-v1-0-d186b68ded4c@baylibre.com
> >>
> >> ---
> >> Kevin Hilman (3):
> >>       pmdomain: ti_sci: add per-device latency constraint management
> >>       pmdomain: ti_sci: add wakeup constraint management
> >>       pmdomain: ti_sci: handle wake IRQs for IO daisy chain wakeups
> >>
> >>  drivers/pmdomain/ti/ti_sci_pm_domains.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 76 insertions(+)
> >> ---
> >> base-commit: ad7eb1b6b92ee0c959a0a6ae846ddadd7a79ea64
> >> change-id: 20240802-lpm-v6-10-constraints-pmdomain-f33df5aef449
> >>
> >> Best regards,
> >> --
> >> Kevin Hilman <khilman@baylibre.com>
> >
> > Besides a couple of minor things that I have commented on for each
> > patch, this looks okay to me!
> >
> > Taking into account the other series that this depends on, what is the
> > best merging strategy? Is it safe for me to take it through my
> > pmdomain tree?
>
>
> That other series should be merged shortly, so I will check with
> Nishanth (on cc) if he can create an immutable branch/tag that you could
> use in your tree.
>
> It has a build-time dependency on that other series, so I think this is
> the best way.
>
> Alternatively, if you don't expect this to clash with other changes in
> your tree, with your ack/reviewed-by, Nishanth could merge this series
> via his tree and we could avoid the cross-tree shuffle.

At the moment there shouldn't be any clashes I think. Let's use
Nishanth's tree and see how it goes.

I will ack/review the patches when they are ready.

Kind regards
Uffe

