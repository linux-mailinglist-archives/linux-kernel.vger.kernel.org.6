Return-Path: <linux-kernel+bounces-423488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E92A9DA845
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA89165D6D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038A91FC11A;
	Wed, 27 Nov 2024 13:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kms9ftvq"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86981FA27E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 13:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732713081; cv=none; b=eEkB4c+6ibmgeRgYHYtjLYmG2/ypZ66xBJWHQxpNmtmfbhzGvXo6rkjrqc1nboRqo6bnOV3mtJhflh3kdm7yH/mdsc3PunJw0e/4CPuUZ/v2ODXLVPvQOjNTRlcCOtfnetrac2FeShJEk4KsY2K9iPQqjPhVmQqXFFzbjrBJguM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732713081; c=relaxed/simple;
	bh=cDpVWiiGl6etsITAHNV9gpxqYjho8V5OYTkLU7VMxc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dChv8xeL25L0+4zRMXTTvD5+syHTFzhGnxbKu0tm13ANy7ybOJ+tBuVeq5jjheFz2TqYA0L5AA3YNGFWPXMXwNzEZw7zNGCyPR3V+jgszSPpnWf/kpP7gWfet+fxnNUx6VIXFBA+LL4LxHdaHjsEWfmDtIWyHTeGMLI/JJuZSQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Kms9ftvq; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e396cff6d36so42133276.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 05:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732713079; x=1733317879; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pJ4f5/AA0Na3QRUimWC4sZ6Mc3cd4bD928BKUzVBg8=;
        b=Kms9ftvqy9bHW8+XcZ5ytkIYj7Sj6MMIKVNpaXHrZI1UqzafvcWgMvSTnvazV4lmNI
         +D4cIVysoH5/PBylJCeCbR97ff8NY+sbH0NlJNQVuqRwl+XdxhZQ1Eu+3okPjo/qnPer
         ZaML1auj6fFoHnfZnDYCf+O3VKW9GUfx9ldq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732713079; x=1733317879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0pJ4f5/AA0Na3QRUimWC4sZ6Mc3cd4bD928BKUzVBg8=;
        b=JyD9IFwqGnh9kxf/INZW13qq25EVDBupVxR3iXHGyBSZElPKQY/51Dh4qc+GaTTlRV
         BqfKgUtQb+Z2XGXCGFwpKu3qKVXhIpazUOXhdlI2ujxRRivTB/R7zth5NieH9Nsu5gmr
         bGgQS4xny2++132D8X064t/vPGxpSIzmxuwy92N7IKs1Y4qTCMSrYAuqBpXoD4CIKB4W
         enfadqK6TUZTJIx45MDioG/d7Li5rjHl+7wd7vn8fdq5zGxUOIXHRhfo8npttNebQKCm
         DsGEg68aXKwh5bA178bTvZMFaELF+HoXDrU4lCw0U33CGeVlZPUzkJe/JEyppGcV1PVs
         8fwA==
X-Forwarded-Encrypted: i=1; AJvYcCU0XWw/tmdbakKapqXQ+049nIZRz5RMYEsSgoli71qoTUoQIzUUx7c5abmUhMH5wBEE2QPyDSUInLGdheA=@vger.kernel.org
X-Gm-Message-State: AOJu0YylNapsAPnlIkX29sl07gYA3nMWk0BZODWlu4aTqZzVf28sFsOE
	zy9nfEY5+MzuSeDz3VBMUVnPqsH7k79L5ZAnao+PgiUXTIfop+xmZ4Q08E+1KoYny1tWqYwOU5k
	Pl/QYlJIEAIYG7I5G9W5iK1xOh+nhfpMOASPa
X-Gm-Gg: ASbGnctlS7XgahTNl7GZjMAHDC8EemZY0TmpJYmhOCBb5heBaHgXLTcYxEFF6qEcXXu
	1Xy0/MS3XZ2NwBNiXEMuQb7ohPp7zsjvB
X-Google-Smtp-Source: AGHT+IGHme/L5ioql1/e+CfRbka6xoxAYc90GtctpaIvtM30KbIeIU6v/mBHT7nNurKZ5GDi7Le2AMYnuUIp2KUuv5k=
X-Received: by 2002:a05:6902:cc5:b0:e2b:d3da:46c8 with SMTP id
 3f1490d57ef6-e395b93642dmr2466586276.37.1732713078836; Wed, 27 Nov 2024
 05:11:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126103632.419469-1-wmacek@chromium.org> <20241126103632.419469-3-wmacek@chromium.org>
 <473283aa-fc84-4b3f-93bc-653c9d83c837@collabora.com>
In-Reply-To: <473283aa-fc84-4b3f-93bc-653c9d83c837@collabora.com>
From: Wojciech Macek <wmacek@chromium.org>
Date: Wed, 27 Nov 2024 14:11:06 +0100
Message-ID: <CAJrw_jmqfPaOsoT1pneoFuUg9ws1CsDgy3YdqWPE5SoK7Lrv+g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: mediatek: mt8186: Add Starmie device
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Chen-Yu Tsai <wenst@chromium.org>, Rafal Milecki <rafal@milecki.pl>, 
	Hsin-Yi Wang <hsinyi@chromium.org>, Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 12:35=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 26/11/24 11:36, Wojciech Macek ha scritto:
> > Add support for Starmie Chromebooks.
> >
> > Signed-off-by: Wojciech Macek <wmacek@chromium.org>
> > ---
> > Changelog v3-v2:
> >   - Cleaned up DTS
> >     - Re-using dsi_out node
> >     - Removed unnecessary delete-nodes
> >     - Moved touchpads to per-board dts
> >     - Modified 3.3/6V power regulator node
> > Changelog v2-v1:
> >   - No changes
> >   arch/arm64/boot/dts/mediatek/Makefile         |   2 +
> >   .../mediatek/mt8186-corsola-starmie-sku0.dts  |  31 ++
> >   .../mediatek/mt8186-corsola-starmie-sku1.dts  |  31 ++
> >   .../dts/mediatek/mt8186-corsola-starmie.dtsi  | 465 +++++++++++++++++=
+
> >   4 files changed, 529 insertions(+)
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-starmi=
e-sku0.dts
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-starmi=
e-sku1.dts
> >   create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-starmi=
e.dtsi
> >
>
> ..snip..
> > +/*
> > + * Battery on Starmie is using a different address than default.
> > + */
> > +&battery {
>
> I didn't ask you to do it this way, and that was for a good reason.
>
> Besides, you haven't run dtbs_check before sending this.
> Give it a go and you'll see why.
>
> Regards,
> Angelo

I'll update patches tomorrow once I get my Starmie back.
Meanwhile, to limit unnecessary turnarounds, I think I'd like to leave
the /delete-node/ for battery. In case status=3Ddisabled is used we
still would end up with the "battery" alias pointing to the old node.
That might be very misleading if someone ever tries to access battery
node using &battery link. Something like below.

 /*
  * Battery on Starmie is using a different address than default.
  * Remove old node to avoid "battery" alias pointing to disabled
  * node.
  */
/delete-node/ &battery;
&i2c_tunnel {
        battery: sbs-battery@f {
                compatible =3D "sbs,sbs-battery";
                reg =3D <0xf>;
                sbs,i2c-retry-count =3D <2>;
                sbs,poll-retry-count =3D <1>;
        };
};

Please let me know if you're OK with that.

Thanks,
Wojtek

>
> > +     reg =3D <0xf>;
> > +};
>

