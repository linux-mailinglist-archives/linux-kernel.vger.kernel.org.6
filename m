Return-Path: <linux-kernel+bounces-348614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1805A98E9AF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 08:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E2E1C210EC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 06:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE50178281;
	Thu,  3 Oct 2024 06:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IQZudeoM"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8A42564
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 06:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727936318; cv=none; b=Zu6LnP4zjAre/WYV1EtAPX3PBceDcjRWpAx6mLLY9ovQFr+79tpbr4fhjYmGUn1NUKvnc2olS8zfxQ7wUNp4ximuJAtZbPKN80fSQcBjDJHYfB5TmZ7TDlDADmMLAbrED1/J1BMK3ZsFqXijiX561v9W7l9QIMD0LYGGoiX5qtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727936318; c=relaxed/simple;
	bh=sBl0fCFHom5Hc09gdCxZI8m3P85FrpOdRPZ8njZoZjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AxwoYW07mrnI8PzXpo1Q6/x9Ux4dRa003kXG+24GXiGs5/94gxrMT0XB81YILjU4FXVl9IVsv9R3vbYFtjzbN3eKIK+yiWYDYn6AoPjjA8YFXaZXMVLIgUwGFqw63tGkN87NCs59MCS0BgxUjpoOCGMJfvG0C+L82DoL5BfUqkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IQZudeoM; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-50ac0c8cd48so180909e0c.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 23:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727936315; x=1728541115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjCn7wNLVdT3ReTaN+Qz+I/dQF+bFHwwiGL3poiE5os=;
        b=IQZudeoMsYvkZfRbHHOn2IeQDmERVY6SIvhGzRBzUuQaL+NAFvJlUngScY9o9++KTG
         1/PqKECUyOTozPnOdiypiQZENpQ81wsWFK4Y8L3Db0OeN09TyBRnULZIlhPQGkACGmzi
         Rk2FNRzFcwdwyTb6ygOcbGJynZH++pXaix4yM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727936315; x=1728541115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XjCn7wNLVdT3ReTaN+Qz+I/dQF+bFHwwiGL3poiE5os=;
        b=gEu5RFh2c6d7pGZnTKFyAVeOn4N35bnRefhSXAj3kveJRMqLzFgq7BQY4MvOvD/rQy
         ke+pkiQCGkwg7gwKJqD+sT0PdSLuBmDTrsAjX2Zrxt1ViMFKvrszhqIcR3DYxroTBt0/
         hCVLhLqSgCPlxMYcRbzF6cN0n0XZ7DTEdxBTlx/RuA1SRfgAlyGM7cfdySXmwjiF/LhC
         64LKoZJIwXa2BYoAu7PQQ+ihSTEcyRwNMXdZIML4SI4FZtPZy+Ii7qyzAUI4gSLTolFC
         NWXI81xIkpZoG37R2a04Zj0NFsQBuN2Sdh0caCBQZX19EFfCxeVwGSJiIVKV7r5q64D4
         Bxjw==
X-Forwarded-Encrypted: i=1; AJvYcCUYlrQ6PQWJP8jV9BkmbZQFnNgDipiksZo2U96dNXX3bD+HB/Bv1qk18tZVFvNu3Id91sFRL3GeCUyascQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAwgMQBRL1dtIOyO0EPx0+hqpJLI4JT1pU0YCLqTwJvCe+axzy
	4K+74wYhLuCkF//4u08Wo7sTC5uwQMpgcKrJ2ARi3ywob79uiC/8C7yHChVL5MIgiBbjwKOUBBJ
	iyw==
X-Google-Smtp-Source: AGHT+IETRC2QWyRNdAbzQkW9E8SuFtDQy0g2sfLs1qjYRF/aVTNwI4GPnJDLB73cbDh0JqjzXhJtPQ==
X-Received: by 2002:a05:6122:3091:b0:50a:cc6f:2a32 with SMTP id 71dfb90a1353d-50c5814bc4bmr4722456e0c.3.1727936315309;
        Wed, 02 Oct 2024 23:18:35 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-50c72c03adfsm84985e0c.35.2024.10.02.23.18.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 23:18:35 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-4a3ace86b5cso237367137.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 23:18:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVeKvjkSTJTWZfhEHXy0n3BY+f8J4GR1ftVzsT24JsLAcl66MYLH/OVGt43AMICPlov+8wqOwagEkCZFIM=@vger.kernel.org
X-Received: by 2002:a05:6102:3584:b0:4a3:a7a0:889a with SMTP id
 ada2fe7eead31-4a3e6924383mr4417458137.19.1727936314349; Wed, 02 Oct 2024
 23:18:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002114614.847553-1-fshao@chromium.org> <20241002114614.847553-3-fshao@chromium.org>
 <7faeac1b-0b7a-a820-16a5-330b82d12e01@mediatek.com>
In-Reply-To: <7faeac1b-0b7a-a820-16a5-330b82d12e01@mediatek.com>
From: Fei Shao <fshao@chromium.org>
Date: Thu, 3 Oct 2024 14:17:57 +0800
X-Gmail-Original-Message-ID: <CAC=S1niQQi_m+GB_CoZr-PTgyxVNCa_uwgZw+vGqgE-E5FBnCw@mail.gmail.com>
Message-ID: <CAC=S1niQQi_m+GB_CoZr-PTgyxVNCa_uwgZw+vGqgE-E5FBnCw@mail.gmail.com>
Subject: Re: [PATCH 2/9] arm64: dts: mediatek: mt8188: Add PCIe nodes
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, jianguo.zhang@mediatek.com, 
	jian.yang@mediatek.com, jieyy.yang@mediatek.com, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, Bear Wang <bear.wang@mediatek.com>, 
	Pablo Sun <pablo.sun@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 8:42=E2=80=AFPM Macpaul Lin <macpaul.lin@mediatek.co=
m> wrote:
>
>
>
> On 10/2/24 19:41, Fei Shao wrote:
> >
> >
> > External email : Please do not click links or open attachments until yo=
u
> > have verified the sender or the content.
> >
> >
> > Add PCIe node and the associated PHY node.
> > Individual board device tree should enable the nodes as needed.
> >
> > Signed-off-by: Fei Shao <fshao@chromium.org>
> > ---
> >
> >   arch/arm64/boot/dts/mediatek/mt8188.dtsi | 62 +++++++++++++++++++++++=
+
> >   1 file changed, 62 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8188.dtsi b/arch/arm64/boot=
/dts/mediatek/mt8188.dtsi
> > index 10195a4e4e9d..9431f3c5c228 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8188.dtsi
> > @@ -1763,6 +1763,53 @@ xhci0: usb@112b0000 {
> >                       status =3D "disabled";
> >               };
> >
> > +             pcie: pcie@112f0000 {
> > +                     compatible =3D "mediatek,mt8188-pcie", "mediatek,=
mt8192-pcie";
> > +                     reg =3D <0 0x112f0000 0 0x2000>;
> > +                     reg-names =3D "pcie-mac";
>
> It seems the property 'linux,pci-domain =3D <0>;' is missing?

I'll add that. I guess the fallback will assign a dynamic ID to it
(likely also 0), but explicitly having a static domain ID is never a
bad thing.

>
> [snip]
>
> > +                     };
> > +             };
> > +
> >               nor_flash: spi@1132c000 {
> >                       compatible =3D "mediatek,mt8188-nor", "mediatek,m=
t8186-nor";
> >                       reg =3D <0 0x1132c000 0 0x1000>;
> > @@ -1775,6 +1822,21 @@ nor_flash: spi@1132c000 {
> >                       status =3D "disabled";
> >               };
> >
> > +             pciephy: t-phy@11c20700 {
> > +                     compatible =3D "mediatek,mt8188-tphy", "mediatek,=
generic-tphy-v3";
> > +                     ranges =3D <0 0 0x11c20700 0x700>;
> > +                     #address-cells =3D <1>;
> > +                     #size-cells =3D <1>;
> > +                     status =3D "disabled";
> > +
>
> The power-domains property is missing.
> It should be 'power-domains =3D <&spm MT8188_POWER_DOMAIN_PEXTP_PHY_TOP>;=
'

I dropped this as the binding check was against it, and I thought it
was a mistake because other tphy nodes don't seem to have a power
domain either.
And now I noticed your tphy binding patch in [1] so that explains,
except that I still can't tell whether there should be a power domain
for a given tphy node...

Anyway, I'll fix this one. Thanks!

[1]: https://lore.kernel.org/all/20240926101804.22471-1-macpaul.lin@mediate=
k.com/

Regards,
Fei


>
> > +                     pcieport: pcie-phy@0 {
> > +                             reg =3D <0 0x700>;
> > +                             clocks =3D <&topckgen CLK_TOP_CFGREG_F_PC=
IE_PHY_REF>;
> > +                             clock-names =3D "ref";
> > +                             #phy-cells =3D <1>;
> > +                     };
> > +             };
> > +
> >               i2c1: i2c@11e00000 {
> >                       compatible =3D "mediatek,mt8188-i2c";
> >                       reg =3D <0 0x11e00000 0 0x1000>,
>
> Thanks!
> Best regards,
> Macpaul Lin

