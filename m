Return-Path: <linux-kernel+bounces-512470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B299A339B2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FE3C188C66F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 08:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C85620B7F9;
	Thu, 13 Feb 2025 08:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iY2m6CO8"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E4D20B818
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739434172; cv=none; b=EUizBYgcqLElC5MIyNve7agI8wKtRuY9laytYqk5+0fYAhNs0OpMHzSUuXGUa0zJq4V7Z69ZPEjf4mKwD9/zoY1icxJgaMhnNqXIg4IIlhyEWeWpEAz9hVkjRU0lDZh6nPOo7+zzYxJ1pcX6Ny9Qlg5V0XT5JMEPKbZ2NgULxUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739434172; c=relaxed/simple;
	bh=ljPgT1sFuCalfu0Uk3Du6RFDHpdGg4hwNFV66uJbmuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JnY9sXjxtA6ldgpuC6BE8SrN542QwGiYqVgsflkpiDJyPEg/A5Hb4Yoy5A5KkutPCGWJeE5Ei1RzpniUXxMzifMaUyI2TT5eXoxgVf32hcQzuPoE19pWm7sJ2EJ91a2sK6OEll1GqOP5VTx9yn9WoU0cRaoUfLadCY3SGszIs6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iY2m6CO8; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-308ef06b4e1so5658261fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 00:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739434169; x=1740038969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hm48X7lqAOA0dqAbrf9aRcbVAhVDW4f4LNNKI9FF/e8=;
        b=iY2m6CO8UF5Pwhw3mBFM8ch5kk1wpSI5uXr0Tl8tAPHcZ1ZOF1GUyHejekjgZ4yiPm
         +1KVLB5TNaVuU+K0rH4/x3VKRoggkSL23z2/LCr61bawVV03ZaKLDLtOOlCiyDETGpZQ
         BcCYa/DRyfEZiyZWx45exz2S5Sz1B5qsytNPS4KZwM7sBoJ9TbGf++0N46yfaPAqlruf
         M4mcgYloe26BWstplwDzXfJLoISKMWAyRYDJqZ7NrFXZDfQ4maUvcn/9lAgOz3GyQ2ct
         wstw+bTbFKI3IHW1On6ZLOoYWPiVAT4pgBvOYq0BEwBdTks1DgRRCEIJx1ZBxsXY4fT7
         XRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739434169; x=1740038969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hm48X7lqAOA0dqAbrf9aRcbVAhVDW4f4LNNKI9FF/e8=;
        b=W60y8Mh5S5MRH8Iwyl4/iwQIg87pYuk7uzJxOEXG2BQI8naZq2hDvQ+iut7wnoiI+X
         wXsCV9ZfDOiqw2Y5pCkaCZu7LQCDLkY7BRIiwMgx/kTcZbwM6bcG1Sa9MKMZqEi5uQPg
         hjS3TkJ/B3daSin1XC3UrWavXPNw9LP/Tq58G6aOCK5XMjjrCrT5z/+tZgAW9s7ADRzl
         fCJe+7bPyCKXTjFxTVY3Rpl44pcZQ2wJ08iLnxGBDW4V2X005v4osJzSNjcIP2f59KWa
         xr3f+UPLnu88NKJTggiXYv0mezJ+BArNLwNSWIehCR1kFUMuNbOuhFufr5qk7RXo5wcN
         CXxw==
X-Forwarded-Encrypted: i=1; AJvYcCXtlLvjZU5aCGmatkt45dXczVBrQ6QGf/5Ny1qSsKYub9rWAIIL1FgOvhAXO39Bo5LYQnBOoD2dEdMm8ro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq76jScG0mo8y8I6HotAGoF2ehH/pGVRo5k5WrdLubua/64gKP
	uJPox50n9lGFmxxAtoUBKQ+ZwRJeM8VPSvR8j81sUFHKnIMvaYMz9sgIztHHch+dLCT7Up4oct8
	tFE/KdA3p4JQLbMFrDizlJ3q7blB3WJXqN/ng
X-Gm-Gg: ASbGncsdTZemJyKb9AqV8R3CCX8A2sPCqBRwS7JaN2kdcqBcfJAiAh8GVvOhBn146i3
	lizkEPIIvax2Qp4ZlvLSPtPPzk3OLIDwkLpaWmdrj49/KXoAtKx1NxLHMopmncb7fzyftYmU=
X-Google-Smtp-Source: AGHT+IEmpPPGGq0TkyXzSWbo270QTcdVB4AMwtq/Q7Fk3MRctFhGprBM179Axvf+UAmvyBdQylGglvzV/yxU/7hXKf8=
X-Received: by 2002:a2e:bc83:0:b0:2fb:8c9a:fe3f with SMTP id
 38308e7fff4ca-3090dd56bd0mr9826931fa.22.1739434168471; Thu, 13 Feb 2025
 00:09:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030171009.1853340-1-saravanak@google.com>
 <20241204124826.2e055091@booty> <20241206103143.755f5e87@booty> <20250212163320.24d30adb@booty>
In-Reply-To: <20250212163320.24d30adb@booty>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 13 Feb 2025 00:08:51 -0800
X-Gm-Features: AWEUYZnBn-KXzThN1gAzgIG62fJwLZAG87XdCRdCGXUKPP5nnCbr9ljamDaIj_A
Message-ID: <CAGETcx-iZ67NMZtAQLDj5CnftsYoEetMvu1fpsgJjb6ar7bCeQ@mail.gmail.com>
Subject: Re: [PATCH v3] driver core: fw_devlink: Stop trying to optimize cycle
 detection logic
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Francesco <francesco.dolcini@toradex.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Conor Dooley <conor@kernel.org>, 
	=?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 7:33=E2=80=AFAM Luca Ceresoli <luca.ceresoli@bootli=
n.com> wrote:
>
> Hello,
>
> On Fri, 6 Dec 2024 10:31:43 +0100
> Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
>
> > > After rebasing my work for the hotplug connector driver using device
> > > tree overlays [0] on v6.13-rc1 I started getting these OF errors on
> > > overlay removal:
> > >
> > > OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get=
()/of_node_put() unbalanced - destroy cset entry: attach overlay node /addo=
n-connector/devices/panel-dsi-lvds
> > > OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get=
()/of_node_put() unbalanced - destroy cset entry: attach overlay node /addo=
n-connector/devices/backlight-addon
> > > OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get=
()/of_node_put() unbalanced - destroy cset entry: attach overlay node /addo=
n-connector/devices/battery-charger
> > > OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get=
()/of_node_put() unbalanced - destroy cset entry: attach overlay node /addo=
n-connector/devices/regulator-addon-5v0-sys
> > > OF: ERROR: memory leak, expected refcount 1 instead of 2, of_node_get=
()/of_node_put() unbalanced - destroy cset entry: attach overlay node /addo=
n-connector/devices/regulator-addon-3v3-sys
> > >
> > > ...and many more. Exactly one per each device in the overlay 'devices=
'
> > > node, each implemented by a platform driver.
> > >
> > > Bisecting found this patch is triggering these error messages, which
> > > in fact disappear by reverting it.
> > >
> > > I looked at the differences in dmesg and /sys/class/devlink/ in the
> > > "good" and "bad" cases, and found almost no differences. The only
> > > relevant difference is in cycle detection for the panel node, which w=
as
> > > expected, but nothing about all the other nodes like regulators.
> > >
> > > Enabling debug messages in core.c also does not show significant
> > > changes between the two cases, even though it's hard to be sure given
> > > the verbosity of the log and the reordering of messages.
> > >
> > > I suspect the new version of the cycle removal code is missing an
> > > of_node_get() somewhere, but that is not directly visible in the patc=
h
> > > diff itself.
> >
> > I collected some more info by adding a bit of logging for one of the
> > affected devices.
> >
> > It looks like the of_node_get() and of_node_put() in the overlay
> > loading phase are the same, even though not completely in the same
> > order. So after overlay insertion we should have the same refcount with
> > and without your patch.
> >
> > There is a difference on overlay removal however: an of_node_put() call
> > is absent with 6.13-rc1 code (errors emitted), and becomes present by
> > just reverting your patch (the "good" case). Here's the stack trace of
> > this call:
> >
> >  Call trace:
> >   show_stack+0x20/0x38 (C)
> >   dump_stack_lvl+0x74/0x90
> >   dump_stack+0x18/0x28
> >   of_node_put+0x50/0x70
> >   platform_device_release+0x24/0x68
> >   device_release+0x3c/0xa0
> >   kobject_put+0xa4/0x118
> >   device_link_release_fn+0x60/0xd8
> >   process_one_work+0x158/0x3c0
> >   worker_thread+0x2d8/0x3e8
> >   kthread+0x118/0x128
> >   ret_from_fork+0x10/0x20
> >
> > So for some reason device_link_release_fn() is not leading to a
> > of_node_put() call after adding your patch.
> >
> > Quick code inspection did not show any useful info for me to understand
> > more.
>
> I just sent a patch fixing
> this: https://lore.kernel.org/20250212-fix__fw_devlink_relax_cycles_missi=
ng_device_put-v1-1-41818c7d7722@bootlin.com

Thanks a lot for debugging and fixing this! I'll review that patch.

-Saravana

