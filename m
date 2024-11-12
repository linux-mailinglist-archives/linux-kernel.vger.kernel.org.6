Return-Path: <linux-kernel+bounces-405371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F699C507C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 09:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7272EB25974
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 08:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E8120B804;
	Tue, 12 Nov 2024 08:21:30 +0000 (UTC)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F4920B21C;
	Tue, 12 Nov 2024 08:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731399690; cv=none; b=U04NJq5W1PmYduRfEG3gRp+mFdrgiP1JpfSU3pdZ9i/RD60HuGfelF890kI4KS+na9jfkWnKNt+/2E3/z5cjqUY4mLkwqhDddYfvS7Ow7sXc02zo8A8ig9Y6YJv3dt18PGKDBIowztutPlfWpXZy019nIeEO+4tbmRo0IIrHcyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731399690; c=relaxed/simple;
	bh=sjZAdvAtgbZ+vGzUS/YSH0JiAoVDAoGc378b/PsBnik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VliThmqWLZu2+obCW2ZjSls5VLWGkwmMA8QE2Urd3q+fXOiq7Nj6edYy2LMLUMIBTn85gB3EqwGa1gd4s6IkaB8Hxrv9XONJy/ehPlaIw9NIq5n8HhwMPvBCBv4VOKKcKbALj4En3uKiLbBIvaYenToLYKeWxA2W0KsCmCP1mX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e2903a48ef7so4957314276.2;
        Tue, 12 Nov 2024 00:21:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731399686; x=1732004486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nDwP6y4apLuPSJNyta68tT9HUAyd8428Aaq7TNs9y8M=;
        b=VJt3Wl62ovxXDc93NS26qVCvfWICSl9+k6ymdsDvrCvX0kjcAhfLd9eTCN1hkiyvWa
         I5S3Kp7DJUAO6kaSBx5KlJpntxVBHCAQTaaofJXLHWSi4I2cB0igmlYLPg8to+eU564M
         iJQkKRTwFM1FbGl1vbMH+xs//bR7xJtVxVKp1WprCaiHLkNb5MmjCPUKKQCUDqggRePu
         knoSCxtq63NIDFMcTnnChq6n66MckFYziJPfckdrIAGA2trBhH33ir5OZkmxuzuuvdes
         ShqS4BsuqADoVz2b24qh2E3id211JvbJQRu2/kk2EwqMHaaBbp/WnusqY30ZaBmAJpb6
         r6ag==
X-Forwarded-Encrypted: i=1; AJvYcCUXqbuFnMnS4b+j/AmMxH2gdIdhRhqHDGYlS6aLR2ymqhFeWFbxSBHoTDnlb+hSkyH6zrGck98VIWPe@vger.kernel.org, AJvYcCXiJSSmciBxQ9hy1OwgHEBH3/YrtQqnvzjpEYQZSm++AT3BgjIEOf8C9k4hbpYGCcuGiZR5JmY6K9WqpI/o@vger.kernel.org
X-Gm-Message-State: AOJu0Yx78OvivgaiBY5zHh9JQn2JMOE4Tos8xrFilcsiML8/9+/LDJYE
	gFHpglqHKctIWQQwC/UPHBJyWFVojLO36WGU/kWYEp8d33xtOJHQMaFsP4uR
X-Google-Smtp-Source: AGHT+IE8Owwk3fquhxdrmDKgbH/7Q50OWrL+rXvopOM9fZ3chlPzWe+d4aC7q79VETG6Cgj1OXc05w==
X-Received: by 2002:a05:6902:10c7:b0:e28:7a13:747b with SMTP id 3f1490d57ef6-e337f882320mr14932905276.27.1731399686343;
        Tue, 12 Nov 2024 00:21:26 -0800 (PST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e336ef46e90sm2666252276.30.2024.11.12.00.21.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 00:21:25 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6ea85f7f445so52819717b3.0;
        Tue, 12 Nov 2024 00:21:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUU/g/Lr+ijifCYmx9GfnHLQnzqkoyXD3SqsTb5aZ5KhROztqeyNjKY/DuvFRe023Rkd+AKywsv4dC3@vger.kernel.org, AJvYcCX6EuDc0oUzv3i6l7BMzWuYr9HX2RynisZYddQlaHJvqhybjo3BBbZXesvWD319Xqqk0E9gebwTMi1Rkh6P@vger.kernel.org
X-Received: by 2002:a05:690c:670b:b0:6e7:f940:fe81 with SMTP id
 00721157ae682-6eaddd75bdamr148538287b3.6.1731399685525; Tue, 12 Nov 2024
 00:21:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241101-am64-hb-fix-overlay-v1-1-080b98b057b6@solid-run.com> <32c1f44c-6bc7-4722-9f73-743ea15cdcbd@solid-run.com>
In-Reply-To: <32c1f44c-6bc7-4722-9f73-743ea15cdcbd@solid-run.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 12 Nov 2024 09:21:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVZB1iiM5K1VWch5HrohRz+HYu2z1KBXDh2e01TTPgOWQ@mail.gmail.com>
Message-ID: <CAMuHMdVZB1iiM5K1VWch5HrohRz+HYu2z1KBXDh2e01TTPgOWQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am642-hummingboard-t: convert overlay
 to board dts
To: Josua Mayer <josua@solid-run.com>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vignesh Raghavendra <vigneshr@ti.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Josua,

On Tue, Nov 12, 2024 at 6:05=E2=80=AFAM Josua Mayer <josua@solid-run.com> w=
rote:
> Am 01.11.24 um 15:16 schrieb Josua Mayer:
> > SolidRun HummingBoard-T has two options for M.2 connector, supporting
> > either PCI-E or USB-3.1 Gen 1 - depending on configuration of a mux
> > on the serdes lane.
> > The required configurations in device-tree were modeled as overlays.
> >
> > The USB-3.1 overlay uses /delete-property/ to unset a boolean property
> > on the usb controller limiting it to USB-2.0 by default.
> > Overlays can not delete a property from the base dtb, therefore this
> > overlay is at this time useless.
> >
> > Convert both overlays into full dts by including the base board dts.
> > While the pcie overlay was functional, both are converted for a
> > consistent user experience when selecting between the two mutually
> > exclusive configurations.
> >
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Closes: https://lore.kernel.org/linux-devicetree/CAMuHMdXTgpTnJ9U7egC2X=
jFXXNZ5uiY1O+WxNd6LPJW5Rs5KTw@mail.gmail.com
> > Fixes: bbef42084cc1 ("arm64: dts: ti: hummingboard-t: add overlays for =
m.2 pci-e and usb-3")
> > Signed-off-by: Josua Mayer <josua@solid-run.com>
> > ---
> >   arch/arm64/boot/dts/ti/Makefile                            |  4 ----
> >   ...gboard-t-pcie.dtso =3D> k3-am642-hummingboard-t-pcie.dts} | 14 +++=
+++++------
> >   ...gboard-t-usb3.dtso =3D> k3-am642-hummingboard-t-usb3.dts} | 13 +++=
+++++-----
> >   3 files changed, 16 insertions(+), 15 deletions(-)
> >
> Please hold off on this patch for the moment,
> Thanks to some comments from Geert I wish to submit an alternative
> solution via separate patch-set, for further discussion.

As you state in the other patch set  "I do not consider it ready for
current merge window",  it may be worthwhile to not hold off?
It can always be reverted whenif the alternative solution is accepted.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

