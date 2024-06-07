Return-Path: <linux-kernel+bounces-205956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9F690029A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87CE1F246C8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE9018FC8E;
	Fri,  7 Jun 2024 11:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oHKUKYSz"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDDB18C328
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 11:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717760943; cv=none; b=srcrVpU5M7m7yoo0+8kOUjrkXIg36kS8UjSxPvZvDvW6boqabcXRdULwkdr4chqj16CGqV8VeD70T0q2+r2mMwpUGsloeX0+UF4dLCuOSvXj2WWN/HA4WeJnSW+tPiIeAswmUjuHURpNluD2te2zq/M/EmxnBdBLIZTGmbjNMb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717760943; c=relaxed/simple;
	bh=9RBdun848oyGcaKII1pvPRbUGsBtrYjKBBsCinPoZw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LCxJKGUa1C7un/uagionjhLb5OnCYE+2cIclOpb6LRUSsiJVKe04abZNAxB/aRhRln1K0s2JrqIN946Lih+yXcQ5jg/ATbpEStISouI7Iti4bleBd57JXY7eVczX7BvsCoCeooMcTRmVoy7gXAkjmjQpMVH9wnHCKtMoLRCWUPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oHKUKYSz; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dfa67a3e702so2112241276.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 04:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717760941; x=1718365741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aaxauWMNivX2Xh96RfVBzt0WPh7okmPnKiLgSACVt0o=;
        b=oHKUKYSzjMck6aSSnYbg+mwHDVzlENejPoIFx7zkvcBgmSSm/0X0NdcHF8TCTg4cMR
         43d6FC3LUUY0lMJn+ZzOeUJ2ua3yqS+lN8o1IUCUvQ0zyQuXPDmnZZIR7Xs1hZpRaCpH
         GAHsREap8PMid8xvr5ed0QcW6nReMHWnNhdYrLKXZqRlYRoxwEAMb7SSroNKtJhIjEo4
         mxTiEhUQMiLueOgqKw1685hmH5Om8fjsyQ/GmUhIJ8T/wPj6Ix6Xl+JEYqmHhWBZzqM4
         i9Z+zfldwpS49MxVtUbzZoAG+9jH1fS/F69r/+vsUV+TnjwsLF6vsT2+LOSYAbpzlXhE
         7ylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717760941; x=1718365741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aaxauWMNivX2Xh96RfVBzt0WPh7okmPnKiLgSACVt0o=;
        b=RN9GjpeYblKyUQjAAL7vc2Iw1CdYc1K+hn7VRdmOYK5c2fxBVmby9rIZgGWZ2ZgvUW
         H/TmVB092v0ofb+mUsbRiGqSLav61DF0Yktngwrp0VhcYlzpqlq8Unj/7hM6mYwVzX8q
         fB/FHxLowmHR3si5S/2CcbwPHvMvVHdDST2jO+9Lz7+qKX6MyRqDPdf+MbXo0Bj21nAD
         Q0w8i+YMMRH1zeGI3IWJLA+zKRUPCT6m3N1TqASJxraloc8Fi6JzqZTgqICAUknbuFH2
         sruJJaKebTfzMWT31rvEsEz8PfOfS/X8wOrVuPkfwN6RMWC8AZm5SX/lf5Lo2w07c+1p
         W/Vg==
X-Forwarded-Encrypted: i=1; AJvYcCXyL+IwI0zsZrQfYnJ1gsZUJcvZ5nvyk65F798spzlxAx+5e3t1xze0lWfMyFDqNl8F55Y+GedvMWTfX06SaoSCNV9OgiRgnrt0rnt+
X-Gm-Message-State: AOJu0Yxux4ZTW/i7qSQphkeMf/Ekn2933Mv83rOYXsFaeEJeBQPGRJeN
	uG/aaqK0n0Ux6Nw2oTOgR/5c/iMBoTGYqho/RjAkT8eCwwqEjicaIDMEUokr1z+fGUWE6PeKIyK
	+NOyGs2yMOHzCDI2IX75P/oJrUfqIRGQMTZEn8w==
X-Google-Smtp-Source: AGHT+IEvLOEOxMW8QOmpMJOUqm62o8XRyN7BdmXOZVOMDNpN7DmrTQqwPsmrngbZSGqsWg4DDlh5AFn7ma7MoM98/qc=
X-Received: by 2002:a25:d648:0:b0:dfa:7ac9:fad1 with SMTP id
 3f1490d57ef6-dfaf663d8a9mr2327430276.24.1717760941376; Fri, 07 Jun 2024
 04:49:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601084528.22502-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240601084528.22502-2-lvzhaoxiong@huaqin.corp-partner.google.com>
 <oo6gggt2kpufvbwg6emoblg4opj2izdfjad4hzojbe7ddp57rp@a5vf23zrk22o> <CA+6=WdTPJxtGUt6pSanmwdYKz2wqCFv73K=BPb+9oDHrQcW=Sw@mail.gmail.com>
In-Reply-To: <CA+6=WdTPJxtGUt6pSanmwdYKz2wqCFv73K=BPb+9oDHrQcW=Sw@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 7 Jun 2024 14:48:50 +0300
Message-ID: <CAA8EJpqOZ2zXQo5F01Q208Bk-KM-awfhNtuq4iM8=FEkLqfkpA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: display: panel: Add KD101NE3-40TI support
To: zhaoxiong lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jikos@kernel.org, 
	benjamin.tissoires@redhat.co, dianders@google.com, hsinyi@google.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 7 Jun 2024 at 14:38, zhaoxiong lv
<lvzhaoxiong@huaqin.corp-partner.google.com> wrote:
>
> hi Dmitry Baryshkov
>
> Because this is a separate mipi dsi driver, I did not put it in
> panel-sample-dsi.yaml.

Driver and bindings are two separate things. Bindings describe the
hardware. If there is no other reason to have a separate bindings
document, please use panel-simple-dsi.yaml.

Also please don't top-post in public mailing lists.

>
>
> On Sun, Jun 2, 2024 at 12:28=E2=80=AFAM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > On Sat, Jun 01, 2024 at 04:45:25PM +0800, Zhaoxiong Lv wrote:
> > > Create a new dt-scheam for the kd101ne3-40ti.
> > > The bias IC of this kindisplay-kd101ne3 panel is placed
> > > on the panel side, so when the panel is powered on,
> > > there is no need to control AVDD and AVEE in the driver.
> > >
> > > Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.c=
om>
> > > ---
> > >
> > > Chage since V2:
> > >
> > > -  Drop some properties that have already been defined in panel-commo=
n.
> > > -  The header file 'dt-bindings/gpio/gpio.h' is not used, delete it
> > >
> > > V1: https://lore.kernel.org/all/20240418081548.12160-2-lvzhaoxiong@hu=
aqin.corp-partner.google.com/
> > >
> > > ---
> > >  .../panel/kingdisplay,kd101ne3-40ti.yaml      | 59 +++++++++++++++++=
++
> > >  1 file changed, 59 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/display/panel/k=
ingdisplay,kd101ne3-40ti.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/panel/kingdisp=
lay,kd101ne3-40ti.yaml b/Documentation/devicetree/bindings/display/panel/ki=
ngdisplay,kd101ne3-40ti.yaml
> > > new file mode 100644
> > > index 000000000000..b0cf12bb727d
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/display/panel/kingdisplay,kd1=
01ne3-40ti.yaml
> > > @@ -0,0 +1,59 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/display/panel/kingdisplay,kd101ne=
3-40ti.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Kingdisplay KD101NE3-40TI based MIPI-DSI panels
> > > +
> > > +maintainers:
> > > +  - Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
> >
> > Any reason for using a separate bindings instead of extending
> > panel-simple-dsi.yaml ?
> >
> > > +
> > > +allOf:
> > > +  - $ref: panel-common.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - enum:
> > > +          - kingdisplay,kd101ne3-40ti
> > > +
> > > +  reg:
> > > +    description: the virtual channel number of a DSI peripheral
> > > +
> > > +  pp3300-supply:
> > > +    description: core voltage supply
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - pp3300-supply
> > > +  - enable-gpios
> > > +  - backlight
> > > +  - port
> > > +
> > > +unevaluatedProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    dsi {
> > > +        #address-cells =3D <1>;
> > > +        #size-cells =3D <0>;
> > > +        panel: panel@0 {
> > > +            compatible =3D "kingdisplay,kd101ne3-40ti";
> > > +            reg =3D <0>;
> > > +            enable-gpios =3D <&pio 98 0>;
> > > +            pinctrl-names =3D "default";
> > > +            pinctrl-0 =3D <&panel_pins_default>;
> > > +            pp3300-supply =3D <&en_pp6000_mipi_disp>;
> > > +            backlight =3D <&backlight_lcd0>;
> > > +            rotation =3D <90>;
> > > +            port {
> > > +                panel_in: endpoint {
> > > +                    remote-endpoint =3D <&dsi_out>;
> > > +                };
> > > +            };
> > > +        };
> > > +    };
> > > +
> > > +...
> > > --
> > > 2.17.1
> > >
> >
> > --
> > With best wishes
> > Dmitry



--=20
With best wishes
Dmitry

