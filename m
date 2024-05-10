Return-Path: <linux-kernel+bounces-175818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BABF8C2598
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 15:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD2751C21F57
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B7112C46C;
	Fri, 10 May 2024 13:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTl/9Qry"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7D3129E7A;
	Fri, 10 May 2024 13:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715347388; cv=none; b=fpB56oVlrXQs9azoXPtJQWAOMPQPZjfWyyxY8Qd5i+tPn+rdySjEH13oMs5oWHKUCI2d/nQ4AiqTZwdEEQXGgbiILz2KjYc0zGcwPpBjQR5LkM4oeTavSFxRMkujq4adYm/mUnm0BziLcaA+ERTGgzoWsip3IJiNMoHPnRYuHEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715347388; c=relaxed/simple;
	bh=tYhskMo0rXSumUEeBpvmlx1SbCm7JZfH6Sx8+QpS5CA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nelCXdktFPzmq+iKHBkWUr9vrPMSouUx+P3AcEXbemtjsBzMacfz2NKfvnH2vAWM94D2E4yG/fcdS+PFIPGm/QvrL+20xuMMFWkIksIiAqaSWeIKEAOXWRPfwkJN16yrDyXLlJyH6hw4XiWXBV5DqjwjNBfRpmzZmgJZdX2FcjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTl/9Qry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA95C32781;
	Fri, 10 May 2024 13:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715347388;
	bh=tYhskMo0rXSumUEeBpvmlx1SbCm7JZfH6Sx8+QpS5CA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iTl/9QryRDw5m6CI9fHWDlqfd+WgiPIjjwmVmxh9Y+HKDsz5HJr3zOdFIV0ISuMpf
	 ZYRsomgmN++PBr3+k4xbr8npEB14Bwdbs+wV2TNoARERT5HFfjOFKA84a/3q2YkOb+
	 7McgvfcnEwz1wIfC4b0rz+dl6f1QOXnd978pV2i8OL7W79nle/cvCwbSPqeqMrE3u9
	 Z9vtzPLKzfAC9uPILO0j2Yz3zhGHNbzixj4EGQyRSNDOyVLgWEKVI3ubIzodmI6QJC
	 ZdGsWF3WnRC/ozb7k2rTeZtifP/fjezzM6hh66RN5Ld1fSG6hJGvNXvWZzyhkj7cNV
	 ForFdv6Gbj3LQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51f0602bc58so2826476e87.0;
        Fri, 10 May 2024 06:23:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUaBLLL9lWr9eEzOtq+rF5UwPuwYXiGcIeqNa+pDXAwzoW3zuic5HKF3Df8eo+CBS3KFEiJhopHTodLScK09XmY4Uops5JhIaoIw2hSguV9IulsusRtIHxer+7RCsadMKwgtNKv7ZZyQA==
X-Gm-Message-State: AOJu0Yxh/QUMW7Ac4/ihOEELmnffXx5EnvHNCc26bE2TYzYOP+0jL2hr
	CrWUKav8tUVwwSWq7tniF19y2BlmllUeeiPidjGVokg/WpeO9AyMpvJOYESIcP4ln830yqkH2Z0
	5EadTXbOC5evCUH9/9JQGIxlorQ==
X-Google-Smtp-Source: AGHT+IEJUcElvfTVu1yNEdpP3G4HTKH4TMjcX6DBrmz3x3jO6gk043nAqUWr2yavjxlCjyZwuuW1s4qLooweEnK1zis=
X-Received: by 2002:a05:6512:684:b0:51c:590f:4305 with SMTP id
 2adb3069b0e04-5220e3736c2mr957712e87.8.1715347386370; Fri, 10 May 2024
 06:23:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510-hotplug-drm-bridge-v2-0-ec32f2c66d56@bootlin.com>
 <20240510-hotplug-drm-bridge-v2-1-ec32f2c66d56@bootlin.com>
 <171533049583.3304069.11759668175103213313.robh@kernel.org> <20240510123717.437ffe6e@booty>
In-Reply-To: <20240510123717.437ffe6e@booty>
From: Rob Herring <robh@kernel.org>
Date: Fri, 10 May 2024 08:22:53 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+mZLkq16OcVBcspxLrMZ=M+h57yOQohhsgn3VXVfyiLQ@mail.gmail.com>
Message-ID: <CAL_Jsq+mZLkq16OcVBcspxLrMZ=M+h57yOQohhsgn3VXVfyiLQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: connector: add GE SUNH hotplug addon connector
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Dragan Cvetic <dragan.cvetic@amd.com>, Maxime Ripard <mripard@kernel.org>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Paul Kocialkowski <paul.kocialkowski@bootlin.com>, 
	Robert Foss <rfoss@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, =?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Arnd Bergmann <arnd@arndb.de>, Derek Kiernan <derek.kiernan@amd.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	David Airlie <airlied@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Paul Kocialkowski <contact@paulk.fr>, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>, 
	linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>, 
	Jonas Karlman <jonas@kwiboo.se>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 10, 2024 at 5:37=E2=80=AFAM Luca Ceresoli <luca.ceresoli@bootli=
n.com> wrote:
>
> Hello Rob,
>
> On Fri, 10 May 2024 03:41:35 -0500
> "Rob Herring (Arm)" <robh@kernel.org> wrote:
>
> > On Fri, 10 May 2024 09:10:37 +0200, Luca Ceresoli wrote:
> > > Add bindings for the GE SUNH add-on connector. This is a physical,
> > > hot-pluggable connector that allows to attach and detach at runtime a=
n
> > > add-on adding peripherals on non-discoverable busses.
> > >
> > > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > >
> > > ---
> > >
> > > NOTE: the second and third examples fail 'make dt_binding_check' beca=
use
> > >       they are example of DT overlay code -- I'm not aware of a way t=
o
> > >       validate overlay examples as of now
>
> As mentioned here...
>
> > >
> > > This patch is new in v2.
> > > ---
> > >  .../connector/ge,sunh-addon-connector.yaml         | 197 +++++++++++=
++++++++++
> > >  MAINTAINERS                                        |   5 +
> > >  2 files changed, 202 insertions(+)
> > >
> >
> > My bot found errors running 'make dt_binding_check' on your patch:
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > Error: Documentation/devicetree/bindings/connector/ge,sunh-addon-connec=
tor.example.dts:49.9-14 syntax error
> > FATAL ERROR: Unable to parse input tree
>
> ...this is expected.
>
> Any hints on how this can be managed in bindings examples would be very
> useful.

Overlays in examples are not supported. Add actual .dtso files if you
want examples of overlays (maybe you did, shrug).

Overlays are somewhat orthogonal to bindings. Bindings define the ABI.
It only makes sense to validate applied overlays. Now maybe overlays
contain complete nodes and we could validate those, but that's a
problem for actual overlay files and not something we need to
complicate examples with.

Rob

