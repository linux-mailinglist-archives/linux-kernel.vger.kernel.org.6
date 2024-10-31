Return-Path: <linux-kernel+bounces-390342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4A89B789F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF450282D16
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73E51990AE;
	Thu, 31 Oct 2024 10:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="blljDZwE"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6619198E8C
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 10:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730370368; cv=none; b=uoAleVFdkWLwzoCp93ZsqtDRCF0x5XKxltx5aGtXJPrMTLNXM7pAwnGSbE7u7RdwpR8EareCBq4bDU2/yenZT2n5pfDtF22M4wmjy8pNdRLe2qMZ95gPX4yIZUmXRIrqlPqe+MjDZokOZbN2RrH6NZyHK74ZDNqx9JiahS2j76k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730370368; c=relaxed/simple;
	bh=jdoVubndjXT0Snb1ihqLSb57sLn8R4s6WkzBF1b6vKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LDnjsGvdwiCzixEIsbIZdRN45+27adYURBzaX+Kppw65igberixLTL25L1SRvtvoFxBkW5YfOqztudsKWYx33hgCfpLmzNRP4hXTbSaKKY6LSYCfSr2bU6wsgMdltUbFkmupriBiFT9+tSflwyTl+DKBPb4joEBAK5UTSJltLKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=blljDZwE; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e30eca40dedso335304276.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 03:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730370365; x=1730975165; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f5+EavlWdyO9mIBzplaKVzqRvhj0odhaF59om4fXhNI=;
        b=blljDZwEPjGoCVN0iCMZW3JXX7J9vEQRSpsUHwysbX4xH76il89q0odMAr3DvO1C0d
         dRHtMJiaNVhNZTksQnXAUsya6Ly6MSep2WsN+wLEHKPF2TQyj0jPyRGIWrmRSPJcW4yN
         wAWFqzBGYm9e1eiqwOICJHERyaHkQYl+vtZWuAu8m/vuf5dRvrsm4tVEnvceXeLHues0
         B8IQjvZydJoFpnwcwoXGYrPov0O6Ki8pW/ph9mchLfyD5pnl7qJnb8+F4Lwehq1EaIVe
         UflVT7CnTr0Q/vARvlGSo6wigFtqAZAtLRddrYNgLQm8ZYUtI3OCgyP/s2qwFDVwMl2y
         /7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730370365; x=1730975165;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f5+EavlWdyO9mIBzplaKVzqRvhj0odhaF59om4fXhNI=;
        b=P8cIb8siyJL0UZQ3ptekzZIS7gHyi70C4h6oDrKHL/1eAdaSs1CE3Uj5saGcpC9RNs
         N9TAqYQAJiocB8onoTDJ6apOvCxUmKHo3ALqhCpKmtHgRJKxYzlBbxAuU3dzeKQ90/xT
         JOc+QCy6RTAyI2H3Sjav+dflM/bUjlTKeWck6CK92Za7XtaFhTu3KO77T6p/vJSJoyE3
         70j8A43e7nEF72QoQND/f37ECtlHWRehf8+3YEDDu9YmYJnRoOY92uzOvOPOflVeV8FQ
         SJroaPry1Pj7Hps6Lnt2qzQx1uDZW0zbsJFhBn3fYWLghr7xdhtZKE86E/TBbzNIDYez
         K8Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVD6uOJqwKYYXmBv65ZxYm8XHDue878DfW9wZqpmrc+vPjUIPNJ38OUHXxkWpRCVwca8hQDTu7sMczmNpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzevgObp4pb8nMUFS5AMyCta1AmYPjlM/P4APmL7BypeJ2//W3X
	wbondRJxHjY+cYY7lxY2MBD/UNJfNyCXuaUwgLOrhY3kNI6QKIjEpsxIbQikC2CwsfqjslnxNwL
	1qifPW48DDKnbzq3Gi4P802ibdv2mCLDVvdq9Gw==
X-Google-Smtp-Source: AGHT+IED7ORvK8ZV2gzBVmXLObiKch/Cqk/NhnIXHt1YeB2LkWDkoQQR0h/2v8YDvtpi/KE6By4guMk7YscOzcSA2Kk=
X-Received: by 2002:a05:690c:6a0a:b0:6e2:1b8c:ad28 with SMTP id
 00721157ae682-6e9d897c900mr199964757b3.24.1730370364810; Thu, 31 Oct 2024
 03:26:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022-tisci-pd-boot-state-v1-1-849a6384131b@ideasonboard.com>
 <7hmsilqrw3.fsf@baylibre.com> <0f027b8e-9c41-4754-923b-2a285fb9593a@ideasonboard.com>
In-Reply-To: <0f027b8e-9c41-4754-923b-2a285fb9593a@ideasonboard.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 31 Oct 2024 11:25:29 +0100
Message-ID: <CAPDyKFqoXfooy-ipo_aE91TwFQOaj=Z5SZJ4G_4Hh7jCvkyTVQ@mail.gmail.com>
Subject: Re: [PATCH RFC] pmdomain: ti-sci: Set PD on/off state according to
 the HW state
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, vishalm@ti.com, 
	sebin.francis@ti.com, d-gole@ti.com, Devarsh Thakkar <devarsht@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 31 Oct 2024 at 08:39, Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
>
> Hi,
>
> On 30/10/2024 22:04, Kevin Hilman wrote:
> > Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> writes:
> >
> >> At the moment the driver sets the power state of all the PDs it creates
> >> to off, regardless of the actual HW state. This has two drawbacks:
> >>
> >> 1) The kernel cannot disable unused PDs automatically for power saving,
> >>     as it thinks they are off already
> >>
> >> 2) A more specific case (but perhaps applicable to other scenarios
> >>     also): bootloader enabled splash-screen cannot be kept on the screen.
> >>
> >> The issue in 2) is that the driver framework automatically enables the
> >> device's PD before calling probe() and disables it after the probe().
> >> This means that when the display subsystem (DSS) driver probes, but e.g.
> >> fails due to deferred probing, the DSS PD gets turned off and the driver
> >> cannot do anything to affect that.
> >>
> >> Solving the 2) requires more changes to actually keep the PD on during
> >> the boot, but a prerequisite for it is to have the correct power state
> >> for the PD.
> >>
> >> The downside with this patch is that it takes time to call the 'is_on'
> >> op, and we need to call it for each PD. In my tests with AM62 SK, using
> >> defconfig, I see an increase from ~3.5ms to ~7ms. However, the added
> >> feature is valuable, so in my opinion it's worth it.
> >>
> >> The performance could probably be improved with a new firmware API which
> >> returns the power states of all the PDs.
> >
> > Agreed.  I think we have to pay this performance price for correctness,
> > and we can optimizie it later with improvements to the SCI firmware and
> > a new API.
> >
> >> There's also a related HW issue at play here: if the DSS IP is enabled
> >> and active, and its PD is turned off without first disabling the DSS
> >> display outputs, the DSS IP will hang and causes the kernel to halt if
> >> and when the DSS driver accesses the DSS registers the next time.
> >
> > Ouch.
> >
> >> With the current upstream kernel, with this patch applied, this means
> >> that if the bootloader enables the display, and the DSS driver is
> >> compiled as a module, the kernel will at some point disable unused PDs,
> >> including the DSS PD. When the DSS module is later loaded, it will hang
> >> the kernel.
> >>
> >> The same issue is already there, even without this patch, as the DSS
> >> driver may hit deferred probing, which causes the PD to be turned off,
> >> and leading to kernel halt when the DSS driver is probed again. This
> >> issue has been made quite rare with some arrangements in the DSS
> >> driver's probe, but it's still there.
> >>
> >> So, because of the DSS hang issues, I think this patch is still an RFC.
> >
> > Like you said, I think that DSS hang is an issue independently of this
> > patch, so it shouldn't hold this up IMO.
>
> In current upstream, if the bootloader has enabled the display, we most
> likely won't hit the DSS hang issue as the PD will stay on until the DSS
> driver has had a chance to probe, and the driver takes actions to avoid
> the hang issue.
>
> With this patch applied, the PD may be turned off before the DSS driver
> has had a chance to probe, causing the board to hang when the DSS driver
> probes the first time.
>
> That's why I'm a bit hesitant to apply this. It could mean that for some
> people their board stops booting.
>
> I'm not even sure what would be the perfect fix for this hang problem...
>
> We could have some built-in early boot code which checks if the DSS is
> enabled, and disables it, so that the hang issue won't happen. But
> that's not good if we try to keep the boot splash on the screen until
> the userspace takes over.
>
> Alternatively we could, somehow, mark the DSS powerdomain to be handled
> in a special way: if the PD is enabled at boot time, it will be kept
> enabled until the DSS driver (somehow) changes the PD back to normal
> operation (and if DSS driver is never loaded, PD will stay on).

This option is kind of what I am working on. Although, the goal is to
keep the code generic, so ideally we should not need any changes in
the DSS driver to make this work. Let's see.

That said, it sounds like we should defer $subject patch until we have
a solution for the above, right?

[...]

Kind regards
Uffe

