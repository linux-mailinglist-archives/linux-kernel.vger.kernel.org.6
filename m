Return-Path: <linux-kernel+bounces-375286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 306A29A942F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 01:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E4CDB226AA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 23:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EC61FF02B;
	Mon, 21 Oct 2024 23:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mERK4iuG"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331CF178370
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 23:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729553399; cv=none; b=GvxuJ9ODgULB0V5bfsRhpRHaLZSyOUkCf/1gR2I2zCYiYXicgFyQqo37Nh4DpyjNDnK+WLoPjI0+RdeeBFJdzr0rynWt3hOtJY0E+0yXFcFEkyPnrUJgq3CasKE8j1j9kZHCo1gXshm7DxpraUX4kpAr8bmCyeG8UUINdHfp6Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729553399; c=relaxed/simple;
	bh=Z2WtKd6O2fmX/1ODuyVjapnZpocrcjgu3ALWC6pnK0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DcMi8FcsZ5fR9wEBF6Jc8IlbMTHn3DUbBP09CPyx0TncnP1a8VB4wW+tpaj+ca5DHoxGAYMJHAcXPO5XWaprZFcTGGTscL0W5ZhtY6fVAtFk5SPheHkGBoHfS34/wkdHBTzUxvd4Hjtdx0o6/sLxd+LoXmdyyC1AirIpzh55nJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mERK4iuG; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e681bc315so3217443b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 16:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729553397; x=1730158197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2NyHY7mFxB4hr1x5ym1c1fkuAGIeYy0qR52394v8ow=;
        b=mERK4iuGCyvzjT6N/xH/3/oY2oSWXKLik/tytNhhMGdsJE+g3InX1RrOEMt0yGDQEH
         j3q4D2c23j0qRnBoHx4XAouvhLkAOU9XZAoggMGGXNybQNkmr1ZqBWUWOjAiNPd/2MjZ
         y9yuop0aVKMixoJ/GK5srB8aPu1IgMdbBbknF2aa21tVZ5Lai9RpcECCaH3z5kjDqEid
         8FEbXepdeo9K3k+LlrSFK/lS5LuEUFLOVmf7wJru1oBWm0qktJiMLWBRXpXDS5NT3YjR
         60Mi7zVOpA+fVh8EElw6ps/m/e4Qqd4kiNladHg6upSTlq95NEUC3Eb2Ao5PJVzn8hzw
         w3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729553397; x=1730158197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2NyHY7mFxB4hr1x5ym1c1fkuAGIeYy0qR52394v8ow=;
        b=sQaSrEjYNhzDsCBaNYq73Q1t155c/D67ZErz4s1bwD0lCXDrhSZzo0UA6ovqYF7yCw
         y5zWoUVnYcsiAEIRxzsnvmfLdEtAG/dLt5iGt7gm/tk1cLYr//muYqFXahVAL2jaeOD4
         Wa0bY9e1hdXF4ZUXCAo8IT+R8MF4wvXJVyFWFo6WiUZUw5PU4LZmRGG6+uMCfo02/IhA
         LDuJLCDJl1N06/cuKmWDnwB+wdc1fGjCk7jgPq69xyHRJkoPWxUqoDB81P6gWxzavR6U
         vHSRmZazCfWGMMsybDSEcPtA/vhC9LD29NTnPMSZEUU0ftZRS+Sin4z9LKqNJRUJoQwF
         Optg==
X-Forwarded-Encrypted: i=1; AJvYcCUkweGMIgltVYnNK0jAKZu7bUCshmS42qv74eOlnYXD7YDkFdM1qdOjQex4TsE3yRjWHqr2N/HAVD/Ue8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOYu6VEQjowini+QwOKXmjnETvMEgm/jwD3rjftpWLKx68Q33h
	ADU50lYvNZWfqw56rsNQeCSM26tylM2g7nosFcfjtKr0OBCxxOxfIkh0T+cIYx9EKq3Dzrm6GOM
	sg+RPh+el2QcsgaedLWvh8FMCQt7EHt79DM7e
X-Google-Smtp-Source: AGHT+IETRJaHZlsiEAbTMWW5Y1/SYutPSqWlhc6bkNiSz1EnikRwyl+TiP+yLXrp3hPim9RxQluBfbx5mI1dAsLBdQc=
X-Received: by 2002:aa7:8d4e:0:b0:71e:7f08:492c with SMTP id
 d2e1a72fcca58-71edc13b786mr1742285b3a.1.1729553397078; Mon, 21 Oct 2024
 16:29:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1a1ab663-d068-40fb-8c94-f0715403d276@ideasonboard.com>
In-Reply-To: <1a1ab663-d068-40fb-8c94-f0715403d276@ideasonboard.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 21 Oct 2024 16:29:18 -0700
Message-ID: <CAGETcx-LtuMJM1205FwMy0U-fetAKhFdon65qAxHKV3Q2cUOGQ@mail.gmail.com>
Subject: Re: fw_devlinks preventing a panel driver from probing
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Linux Kernel List <linux-kernel@vger.kernel.org>, Aradhya Bhatia <aradhya.bhatia@linux.dev>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Devarsh Thakkar <devarsht@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tomi,

Sorry it took a while to get back.

On Mon, Sep 16, 2024 at 4:52=E2=80=AFAM Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
>
> Hi,
>
> We have an issue where two devices have dependencies to each other,
> according to drivers/base/core.c's fw_devlinks, and this prevents them
> from probing. I've been adding debugging to the core.c, but so far I
> don't quite grasp the issue, so I thought to ask. Maybe someone can
> instantly say that this just won't work...
>
> So, we have two devices, DSS (display subsystem) and an LVDS panel. The
> DSS normally outputs parallel video from its video ports (VP), but it
> has an integrated LVDS block (OLDI, Open LVDS Display Interface). The
> OLDI block takes input from DSS's parallel outputs. The OLDI is not
> modeled as a separate device (neither in the DT nor in the Linux device
> model) as it has no register space, and is controlled fully by the DSS.
>
> To support dual-link LVDS, the DSS has two OLDI instances. They both
> take their input from the same parallel video port, but each OLDI sends
> alternate lines forward. So for a dual-link setup the connections would
> be like this:
>
> +-----+-----+         +-------+         +----------+
> |     |     |         |       |         |          |
> |     | VP1 +----+--->| OLDI0 +-------->|          |
> |     |     |    |    |       |         |          |
> | DSS +-----+    |    +-------+         |  Panel   |
> |     |     |    |    |       |         |          |
> |     | VP2 |    +--->| OLDI1 +-------->|          |
> |     |     |         |       |         |          |
> +-----+-----+         +-------+         +----------+
>
> As the OLDI is not a separate device, it also does not have an
> independent device tree node, but rather it's inside DSS's node. The DSS
> parallel outputs are under a normal "ports" node, but OLDI ports are
> under "oldi-txes/ports" (see below for dts to clarify this).
>
> And I think (guess...) this is the root of the issue we're seeing, as it
> means the following, one or both of which might be the reason for this
> issue:
>
> - OLDI fwnodes don't have an associated struct device *. I think the
> reason is that the OLDI media graph ports are one level too deep in the
> hierarchy. So while the DSS ports are associated with the DSS device,
> OLDI ports are not.

This is the root cause of the issue in some sense. fw_devlink doesn't
know that DSS depends on the VP. In the current DT, it only appears as
if the OLDI depends on VP. See further below for the fix.

>
> - The VP ports inside the DSS point to OLDI ports, which are also inside
> DSS. So ports from a device point to ports in the same device (and back).
>
> If I understand the fw_devlink code correctly, in a normal case the
> links formed with media graphs are marked as a cycle
> (FWLINK_FLAG_CYCLE), and then ignored as far as probing goes.
>
> What we see here is that when using a single-link OLDI panel, the panel
> driver's probe never gets called, as it depends on the OLDI, and the
> link between the panel and the OLDI is not a cycle.
>
> The DSS driver probes, but the probe fails as it requires all the panel
> devices to have been probed (and thus registered to the DRM framework)
> before it can finish its setup.
>
> With dual-link, probing does happen and the drivers work. But I believe
> this is essentially an accident, in the sense that the first link
> between the panel and the OLDI still blocks the probing, but the second
> links allows the driver core to traverse the devlinks further, causing
> it to mark the links to the panel as FWLINK_FLAG_CYCLE (or maybe it only
> marks one of those links, and that's enough).
>
> If I set fw_devlink=3Doff as a kernel parameter, the probing proceeds
> successfully in both single- and dual-link cases.
>
> Now, my questions is, is this a bug in the driver core, a bug in the DT
> bindings, or something in between (DT is fine-ish, but the structure is
> something that won't be supported by the driver core).
>
> And a follow-up question, regardless of the answer to the first one:
> which direction should I go from here =3D).
>
> The device tree data (simplified) for this is as follows, first the
> dual-link case, then the single-link case:
>
> /* Dual-link */
>
> dss: dss@30200000 {
>         compatible =3D "ti,am625-dss";
>
>         oldi-txes {
>                 oldi0: oldi@0 {
>                         oldi0_ports: ports {
>                                 port@0 {
>                                         oldi_0_in: endpoint {
>                                                 remote-endpoint =3D <&dpi=
0_out0>;
>                                         };
>                                 };
>
>                                 port@1 {
>                                         oldi_0_out: endpoint {
>                                                 remote-endpoint =3D <&lcd=
_in0>;
>                                         };
>                                 };
>                         };
>                 };
>
>                 oldi1: oldi@1 {
>                         oldi1_ports: ports {
>                                 port@0 {
>                                         oldi_1_in: endpoint {
>                                                 remote-endpoint =3D <&dpi=
0_out1>;
>                                         };
>                                 };
>
>                                 port@1 {
>                                         oldi_1_out: endpoint {
>                                                 remote-endpoint =3D <&lcd=
_in1>;
>                                         };
>                                 };
>                         };
>                 };
>         };
>
>         dss_ports: ports {
>                 port@0 {
>                         dpi0_out0: endpoint@0 {
>                                 remote-endpoint =3D <&oldi_0_in>;
>                         };
>                         dpi0_out1: endpoint@1 {
>                                 remote-endpoint =3D <&oldi_1_in>;
>                         };
>                 };
>         };
> };
>
> display {
>         compatible =3D "microtips,mf-101hiebcaf0", "panel-simple";

In here, add this new property that I added some time back.

post-init-providers =3D <&oldi-txes>;

This tells fw_devlink that VP doesn't depend on this node for
initialization/probing. This property is basically available to break
cycles in DT and mark one of the edges of the cycles as "not a real
init dependency".

You should do the same for the single link case too.

Hope that helps. Let me know.

Thanks,
Saravana

>
>         ports {
>                 port@0 {
>                         lcd_in0: endpoint {
>                                 remote-endpoint =3D <&oldi_0_out>;
>                         };
>                 };
>
>                 port@1 {
>                         lcd_in1: endpoint {
>                                 remote-endpoint =3D <&oldi_1_out>;
>                         };
>                 };
>         };
> };
>
>
> /* Single-link */
>
> dss: dss@30200000 {
>         compatible =3D "ti,am625-dss";
>
>         oldi-txes {
>                 oldi0: oldi@0 {
>                         oldi0_ports: ports {
>                                 port@0 {
>                                         oldi_0_in: endpoint {
>                                                 remote-endpoint =3D <&dpi=
0_out0>;
>                                         };
>                                 };
>
>                                 port@1 {
>                                         oldi_0_out: endpoint {
>                                                 remote-endpoint =3D <&lcd=
_in0>;
>                                         };
>                                 };
>                         };
>                 };
>         };
>
>         dss_ports: ports {
>                 port@0 {
>                         dpi0_out0: endpoint@0 {
>                                 remote-endpoint =3D <&oldi_0_in>;
>                         };
>                 };
>         };
> };
>
> display {
>         compatible =3D "microtips,mf-101hiebcaf0", "panel-simple";
>
>         ports {
>                 port@0 {
>                         lcd_in0: endpoint {
>                                 remote-endpoint =3D <&oldi_0_out>;
>                         };
>                 };
>         };
> };
>
>   Tomi
>

