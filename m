Return-Path: <linux-kernel+bounces-376575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 592C19AB369
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9199B231F9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9D21A3AAD;
	Tue, 22 Oct 2024 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="chph8PR8"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC9A19AD93
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 16:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729613312; cv=none; b=lsP27IWufx91N28PbliYNxQdbRLM3yEBITlmZwv9ACzqXWWXU1FBI6bd+CNiFmnRuzbyCB8SsOgHRy607DoZLbJKbzaBW5ZoOdq3wxT2VfpR9KWTUB00aR3HJ2OKjTV1dijWpmtZqVQQrfpY7/QFkJiQy3Mcq8Ug2qSp3yQpoXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729613312; c=relaxed/simple;
	bh=0CHSxzGHSpOiPt9WcAvSbDM9ekxyaGEUtj1RW+kBdeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EgW4VISqnr8pul0v7p2YwKqejEM1GQnWoukFakY+HgIXoNPsqQnSYqY7SulrRtl50TJ/XesvHF6oWxw9ONJS7oA9fwPmthArJslQJ7xSTCtYM84uTGT3uWmVPdAhAk+ddvNOElM4sFH5M0MhzhdSIm9Smwk20YmdEqzEpPbJpe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=chph8PR8; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e2a97c2681so4244698a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 09:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729613310; x=1730218110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O34N6hV8NTFWFEECvWQoNtBGAXpFQDcnaZf0oYg4B1E=;
        b=chph8PR8R224gik1sefWJmywsoEDOh0noKWfofb0vqu1RymEZPmvK2vuk0OvmPx7/C
         nmVkBsoQFVyvw7VkY64ucjjhv5YOI1yvzYyKJXwuBu8nasWBo6S9mPPMH9S0ircGg1tW
         L1sQJedzEoC9TA2MHduIYi091IB+cK/3gT5eFBLpjj01v9487Jj2pIz5D9QbbKdaYZp/
         jlihCoYJJ/hpR/RtNbpYkE2bdOnph5QeQW+Ickui8eHz4BVuunf91CTQ/r6lCbQ4gXZ9
         ofBJEfcWXWukP74OGyvGu0ZKkH3iNaNJHrWsPbPTds+XvxnrpkI5E4+raxUKe8nLgDTo
         ZDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729613310; x=1730218110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O34N6hV8NTFWFEECvWQoNtBGAXpFQDcnaZf0oYg4B1E=;
        b=Xb6Bmq097RsbLn0rsyqsZGG0KNnRjV9wldLvqE2ePN3Laq/FUiiMVkjwOKYciq2b8e
         T2kNLnX2UKKfPaNsJZemWjgjPHkWe0sKTIHJYD4XHovey2+CqODw17/HGPSDQ6ow7MO7
         xYS/Qsd4MDxRdoH5Ska1wfPwciYCVg012KZtRHQMA2d/A095NG7Gu+F2Fb8GFP1bH69m
         gUGEHSHaeC4tVkZuxp7HFH4/OSj3QaFsLD5aZ8O33ElgQmfRmkVqvotcIWyKe2eUTzBL
         u+2otWqiH/jEjI1b/KhN9G1kk+hvco9SGQ6Jfe+kboSM0G4Vxv29wiwhGOIpvRBru/bn
         81Kg==
X-Forwarded-Encrypted: i=1; AJvYcCV/CiSU5QO0gm/jElEdG7O8qf/k4x8F35z4Cs7pX4ZHFlzWuIfge5ybBKdAbYLDL8ZhQ+M8ej08IbwLqzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUMV00B3F3EUpOyXwDXKPyocmFPPdpY0F8GezRJSJIRxu+0kMA
	LLZ8JYfh9pZjSc0viIDYQYPsI+lfOdYhRlyX9aLgdz82NH28mtillVx4Ya52geYOw0tAGxtQLnl
	xqF4K6bAR1pWstwzEvLZIXohQhWcwNVXjZBkV
X-Google-Smtp-Source: AGHT+IEMn8iZiKlFU+7gC3G8gJjn8JaGTVqTPbCt/8M1TQXtAKatmFKIXaUeG8TU0c1jgxwmxPvC0BXzz5fbJXK/Jow=
X-Received: by 2002:a17:90a:e390:b0:2e2:8fb4:502d with SMTP id
 98e67ed59e1d1-2e5da5817c1mr4330711a91.16.1729613309523; Tue, 22 Oct 2024
 09:08:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1a1ab663-d068-40fb-8c94-f0715403d276@ideasonboard.com>
 <CAGETcx-LtuMJM1205FwMy0U-fetAKhFdon65qAxHKV3Q2cUOGQ@mail.gmail.com> <4a25cd50-06be-4e95-b29e-4f5eb23d8bca@ideasonboard.com>
In-Reply-To: <4a25cd50-06be-4e95-b29e-4f5eb23d8bca@ideasonboard.com>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 22 Oct 2024 09:07:50 -0700
Message-ID: <CAGETcx9dTokpRGwZrE2t0LfVOOFxGn83O60KOnt7D+D2-YMx+g@mail.gmail.com>
Subject: Re: fw_devlinks preventing a panel driver from probing
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Linux Kernel List <linux-kernel@vger.kernel.org>, Aradhya Bhatia <aradhya.bhatia@linux.dev>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Devarsh Thakkar <devarsht@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 12:51=E2=80=AFAM Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
>
> Hi,
>
> On 22/10/2024 02:29, Saravana Kannan wrote:
> > Hi Tomi,
> >
> > Sorry it took a while to get back.
> >
> > On Mon, Sep 16, 2024 at 4:52=E2=80=AFAM Tomi Valkeinen
> > <tomi.valkeinen@ideasonboard.com> wrote:
> >>
> >> Hi,
> >>
> >> We have an issue where two devices have dependencies to each other,
> >> according to drivers/base/core.c's fw_devlinks, and this prevents them
> >> from probing. I've been adding debugging to the core.c, but so far I
> >> don't quite grasp the issue, so I thought to ask. Maybe someone can
> >> instantly say that this just won't work...
> >>
> >> So, we have two devices, DSS (display subsystem) and an LVDS panel. Th=
e
> >> DSS normally outputs parallel video from its video ports (VP), but it
> >> has an integrated LVDS block (OLDI, Open LVDS Display Interface). The
> >> OLDI block takes input from DSS's parallel outputs. The OLDI is not
> >> modeled as a separate device (neither in the DT nor in the Linux devic=
e
> >> model) as it has no register space, and is controlled fully by the DSS=
.
> >>
> >> To support dual-link LVDS, the DSS has two OLDI instances. They both
> >> take their input from the same parallel video port, but each OLDI send=
s
> >> alternate lines forward. So for a dual-link setup the connections woul=
d
> >> be like this:
> >>
> >> +-----+-----+         +-------+         +----------+
> >> |     |     |         |       |         |          |
> >> |     | VP1 +----+--->| OLDI0 +-------->|          |
> >> |     |     |    |    |       |         |          |
> >> | DSS +-----+    |    +-------+         |  Panel   |
> >> |     |     |    |    |       |         |          |
> >> |     | VP2 |    +--->| OLDI1 +-------->|          |
> >> |     |     |         |       |         |          |
> >> +-----+-----+         +-------+         +----------+
> >>
> >> As the OLDI is not a separate device, it also does not have an
> >> independent device tree node, but rather it's inside DSS's node. The D=
SS
> >> parallel outputs are under a normal "ports" node, but OLDI ports are
> >> under "oldi-txes/ports" (see below for dts to clarify this).
> >>
> >> And I think (guess...) this is the root of the issue we're seeing, as =
it
> >> means the following, one or both of which might be the reason for this
> >> issue:
> >>
> >> - OLDI fwnodes don't have an associated struct device *. I think the
> >> reason is that the OLDI media graph ports are one level too deep in th=
e
> >> hierarchy. So while the DSS ports are associated with the DSS device,
> >> OLDI ports are not.
> >
> > This is the root cause of the issue in some sense. fw_devlink doesn't
> > know that DSS depends on the VP. In the current DT, it only appears as
> > if the OLDI depends on VP. See further below for the fix.
> >
> >>
> >> - The VP ports inside the DSS point to OLDI ports, which are also insi=
de
> >> DSS. So ports from a device point to ports in the same device (and bac=
k).
> >>
> >> If I understand the fw_devlink code correctly, in a normal case the
> >> links formed with media graphs are marked as a cycle
> >> (FWLINK_FLAG_CYCLE), and then ignored as far as probing goes.
> >>
> >> What we see here is that when using a single-link OLDI panel, the pane=
l
> >> driver's probe never gets called, as it depends on the OLDI, and the
> >> link between the panel and the OLDI is not a cycle.
> >>
> >> The DSS driver probes, but the probe fails as it requires all the pane=
l
> >> devices to have been probed (and thus registered to the DRM framework)
> >> before it can finish its setup.
> >>
> >> With dual-link, probing does happen and the drivers work. But I believ=
e
> >> this is essentially an accident, in the sense that the first link
> >> between the panel and the OLDI still blocks the probing, but the secon=
d
> >> links allows the driver core to traverse the devlinks further, causing
> >> it to mark the links to the panel as FWLINK_FLAG_CYCLE (or maybe it on=
ly
> >> marks one of those links, and that's enough).
> >>
> >> If I set fw_devlink=3Doff as a kernel parameter, the probing proceeds
> >> successfully in both single- and dual-link cases.
> >>
> >> Now, my questions is, is this a bug in the driver core, a bug in the D=
T
> >> bindings, or something in between (DT is fine-ish, but the structure i=
s
> >> something that won't be supported by the driver core).
> >>
> >> And a follow-up question, regardless of the answer to the first one:
> >> which direction should I go from here =3D).
> >>
> >> The device tree data (simplified) for this is as follows, first the
> >> dual-link case, then the single-link case:
> >>
> >> /* Dual-link */
> >>
> >> dss: dss@30200000 {
> >>          compatible =3D "ti,am625-dss";
> >>
> >>          oldi-txes {
> >>                  oldi0: oldi@0 {
> >>                          oldi0_ports: ports {
> >>                                  port@0 {
> >>                                          oldi_0_in: endpoint {
> >>                                                  remote-endpoint =3D <=
&dpi0_out0>;
> >>                                          };
> >>                                  };
> >>
> >>                                  port@1 {
> >>                                          oldi_0_out: endpoint {
> >>                                                  remote-endpoint =3D <=
&lcd_in0>;
> >>                                          };
> >>                                  };
> >>                          };
> >>                  };
> >>
> >>                  oldi1: oldi@1 {
> >>                          oldi1_ports: ports {
> >>                                  port@0 {
> >>                                          oldi_1_in: endpoint {
> >>                                                  remote-endpoint =3D <=
&dpi0_out1>;
> >>                                          };
> >>                                  };
> >>
> >>                                  port@1 {
> >>                                          oldi_1_out: endpoint {
> >>                                                  remote-endpoint =3D <=
&lcd_in1>;
> >>                                          };
> >>                                  };
> >>                          };
> >>                  };
> >>          };
> >>
> >>          dss_ports: ports {
> >>                  port@0 {
> >>                          dpi0_out0: endpoint@0 {
> >>                                  remote-endpoint =3D <&oldi_0_in>;
> >>                          };
> >>                          dpi0_out1: endpoint@1 {
> >>                                  remote-endpoint =3D <&oldi_1_in>;
> >>                          };
> >>                  };
> >>          };
> >> };
> >>
> >> display {
> >>          compatible =3D "microtips,mf-101hiebcaf0", "panel-simple";
> >
> > In here, add this new property that I added some time back.
> >
> > post-init-providers =3D <&oldi-txes>;
>
> Thanks! This helps:
>
> post-init-providers =3D <&oldi0>;
>
> or for dual-link:
>
> post-init-providers =3D <&oldi0>, <&oldi1>;
>
> > This tells fw_devlink that VP doesn't depend on this node for
> > initialization/probing. This property is basically available to break
> > cycles in DT and mark one of the edges of the cycles as "not a real
> > init dependency".
> >
> > You should do the same for the single link case too.
>
> While this helps, it's not very nice... Every new DT overlay that uses
> OLDI display needs to have these.

Actually, taking a closer look at the DT and assuming I am visualizing
it correctly in my head, fw_devlink should notice the cycle between
oldi-txes and display and shouldn't block display from probing. Can
you check the cycle detection code and see where it's bailing out
early and not marking the fwnode link with the CYCLE flag?

__fw_devlink_relax_cycles() is where you want to look. There are a
bunch of debug log messages inside it and around where it's called
from.

Also, can you check debugfs/devices_deferred, or the
"wait_for_supplier" file under /sys/devices/..../display/ to make sure
it's actually stuck on oldi-txes? Just to make cure it's not some
other corner case that's triggered by oldi-txes?

> I'm still confused about why this is needed. OF graphs are _always_
> two-way links. Doesn't that mean that OF graphs never can be used for
> dependencies, as they go both ways?

Good question :) Yes, they'll always be ignored as cycles. But with
post-init-providers, it's actually better to add it so that cycles are
broken and better ordering is enforced. See my talk at LPC referee
talk about fw_devlink to see all the benefits you get from it. :)

> If so, shouldn't we just always
> ignore all OF graphs for dependency checking?

There are cases when two devices A and B have remote-endpoints between
them and ALSO have for example a gpio dependency between them. Where
the gpio is the "post-init-supplier". If we don't parse
remote-endpoint and mark the cycles, cases like these don't get to
probe.

-Saravana

>
>   Tomi
>
> >
> > Hope that helps. Let me know.
> >
> > Thanks,
> > Saravana
> >
> >>
> >>          ports {
> >>                  port@0 {
> >>                          lcd_in0: endpoint {
> >>                                  remote-endpoint =3D <&oldi_0_out>;
> >>                          };
> >>                  };
> >>
> >>                  port@1 {
> >>                          lcd_in1: endpoint {
> >>                                  remote-endpoint =3D <&oldi_1_out>;
> >>                          };
> >>                  };
> >>          };
> >> };
> >>
> >>
> >> /* Single-link */
> >>
> >> dss: dss@30200000 {
> >>          compatible =3D "ti,am625-dss";
> >>
> >>          oldi-txes {
> >>                  oldi0: oldi@0 {
> >>                          oldi0_ports: ports {
> >>                                  port@0 {
> >>                                          oldi_0_in: endpoint {
> >>                                                  remote-endpoint =3D <=
&dpi0_out0>;
> >>                                          };
> >>                                  };
> >>
> >>                                  port@1 {
> >>                                          oldi_0_out: endpoint {
> >>                                                  remote-endpoint =3D <=
&lcd_in0>;
> >>                                          };
> >>                                  };
> >>                          };
> >>                  };
> >>          };
> >>
> >>          dss_ports: ports {
> >>                  port@0 {
> >>                          dpi0_out0: endpoint@0 {
> >>                                  remote-endpoint =3D <&oldi_0_in>;
> >>                          };
> >>                  };
> >>          };
> >> };
> >>
> >> display {
> >>          compatible =3D "microtips,mf-101hiebcaf0", "panel-simple";
> >>
> >>          ports {
> >>                  port@0 {
> >>                          lcd_in0: endpoint {
> >>                                  remote-endpoint =3D <&oldi_0_out>;
> >>                          };
> >>                  };
> >>          };
> >> };
> >>
> >>    Tomi
> >>
>

