Return-Path: <linux-kernel+bounces-265777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC1E93F5D4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F9BC1F24F3A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145CB154454;
	Mon, 29 Jul 2024 12:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Vl9Hj31U"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3027D14F9ED
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 12:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722257206; cv=none; b=NFmdi6UeuyRbUMf0NRaSJU9tV2u8E4T8YK0KtK2v4h8qcDIInBIVQ3ouxf00XCEX9IM/aZJNo3v9yFzQRmbzC8ZcxeK0TRuB4cw/jtkL/1vhzQAdDYm2xbUGLGmsBXpeBMTQG2s93krG7Z+72TZYDO3zoL/9CYOl/N++KZmVuZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722257206; c=relaxed/simple;
	bh=IpoG1lr/gzkzVwJgoRWnmNxi6CMwEU4ctEbjih6yxYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gdnbpxzrYCZzHWDdkn9d3OqUpkF5zU7GlpLQkUDNZTDtfkN5Yg6Tl9kPsZ3mW0efps+9HosIjvnA40ye8Ad9hj8Rd1pJRkePRWK84YBHINs2lyPS7XVFqhZG7dnPMOBhwWpauqZb2rfgzkHOwPfEqAapBsaXY6h0cgJDBgahoPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Vl9Hj31U; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a2ffc3447fso5094065a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 05:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722257202; x=1722862002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xw9owQO3ke8d+y01UUou/ic5P0UC0KrCWnrceDha0Ug=;
        b=Vl9Hj31Ukjh+0XXek70d4b3McD1qt96OPDKBaQrTpsfTO9oyL7oJw4b+nGr1pAE/SS
         MD76Sbx1JqSacRpsK5EyA68f/dZsfA5ENvNjvmdmgFGCttwFpbzSVJdAf3puhbV/4zGI
         0Wy0n2Ln2qqeSL2YJA/QgaYy2vb2kcKW1nTXXsk2cDxjILfUTlbAxbXO4UY9Blc2m2vK
         s48wIutlKm5AhKQyzTUEeBmt2RbHrXVoDMSIJtCzmZipawRnCpPHGQoF6f8GD2JLrs6e
         wqHJc0nccSfk7QI2WHFubBNWvBHEKCxKjHdhBuzCOsKifOqAPuQmz+JoREvV0llUbZnr
         c1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722257202; x=1722862002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xw9owQO3ke8d+y01UUou/ic5P0UC0KrCWnrceDha0Ug=;
        b=p3wVMg9OTrqI1lgS3nc+D4Zlp7haKeYJ8DOpbRI9gbLPKzDwBHF9ubVuwNVMwJEb6w
         H0noqEFo6xR/MEQUxA/hTTsmqtwuq3eYV4GsoK3rGTc+CFmkOqljGhNIymUOdJ1VimpK
         NfXvSRZKSxGApklXGLifZv1zewH1Iiy3PdJvdnvH+k0glzCkb/PqG9xfnjfd2rczzPRI
         ulGyaA6sDIemfqS3aHDdSeX5d+mcgwCUdqsPzL/4uIDG0gAWCCo7/DGTMKT8VR9rrxfE
         n9K+m221Kx/sxJO3CJwLJ9xKFOM5NYiy2jogf8un2w1DxeoFYqny4qBpCcKJdJX51+mM
         QPMw==
X-Forwarded-Encrypted: i=1; AJvYcCXs/u05XpENWGyM0w3J/849MQ6LYZ7nzg5XCH1hoa/tzvRxTGAYr2k44nTspf6eLCywF+Owy69QWOn1y+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRklszGAq+XmvQHVGrD3MkCfKNP1C8NYyiTq5ad9OKD9yN6BfE
	8JEqY0o9OrO1v9KjPUhp6B86MMnXDIoBhvU544cTZ/c2ID/cEN7Q0k5V6L623cSvDhaW0W9w62L
	bTv1PSvzM+Wa+XlZFm4s2Y4nFtPxOnq3HC+2+Hw==
X-Google-Smtp-Source: AGHT+IHinY1JfNv/mvpMM5Yfya33RSJgmSSwyZAu9jSx+bnpuWuKGvwHZZBD/MV0VUfT3CqvD4NAwzRkoPIdWhAyZ+w=
X-Received: by 2002:a17:907:2d86:b0:a77:b0a4:7d88 with SMTP id
 a640c23a62f3a-a7d3fdb79e8mr659217566b.10.1722257202254; Mon, 29 Jul 2024
 05:46:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704-add-mtk-isp-3-0-support-v5-0-bfccccc5ec21@baylibre.com>
 <20240704-add-mtk-isp-3-0-support-v5-3-bfccccc5ec21@baylibre.com> <647738c5c776a9ec07615e67094c4141fdf051eb.camel@mediatek.com>
In-Reply-To: <647738c5c776a9ec07615e67094c4141fdf051eb.camel@mediatek.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 29 Jul 2024 14:46:29 +0200
Message-ID: <CAEHHSvYqT5-s57FijOf+SfLYF4znjaseazxiY-07jVHs09iK6Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] media: platform: mediatek: isp_30: add mediatek
 ISP3.0 sensor interface
To: =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
Cc: "mchehab@kernel.org" <mchehab@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, =?UTF-8?B?QW5keSBIc2llaCAo6Kyd5pm655qTKQ==?= <Andy.Hsieh@mediatek.com>, 
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
	"laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	=?UTF-8?B?TG91aXMgS3VvICjpg63lvrflr6cp?= <louis.kuo@mediatek.com>, 
	"fsylvestre@baylibre.com" <fsylvestre@baylibre.com>, "pnguyen@baylibre.com" <pnguyen@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 18 juil. 2024 =C3=A0 04:44, CK Hu (=E8=83=A1=E4=BF=8A=E5=85=89) <ck=
.hu@mediatek.com> a =C3=A9crit :
>
> Hi, Julien:
>
> On Thu, 2024-07-04 at 15:36 +0200, Julien Stephan wrote:
> >
> > External email : Please do not click links or open attachments until yo=
u have verified the sender or the content.
> >  From: Louis Kuo <louis.kuo@mediatek.com>
> >
> > This will add the mediatek ISP3.0 seninf (sensor interface) driver foun=
d
> > on several Mediatek SoCs such as the mt8365.
> >
> > Then seninf module has 4 physical CSI-2 inputs. Depending on the soc th=
ey
> > may not be all connected.
> >
> > Signed-off-by: Louis Kuo <louis.kuo@mediatek.com>
> > Signed-off-by: Phi-bang Nguyen <pnguyen@baylibre.com>
> > Signed-off-by: Florian Sylvestre <fsylvestre@baylibre.com>
> > Co-developed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Co-developed-by: Julien Stephan <jstephan@baylibre.com>
> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > ---
>
> [snip]
>
> > +static const struct mtk_seninf_conf seninf_8365_conf =3D {
> > +.model =3D "mtk-camsys-3.0",
> > +.nb_inputs =3D 4,
> > +.nb_muxes =3D 6,
> > +.nb_outputs =3D 4,
> > +};
> > +
>
> I think you should directly define these value as symbols because now
> only support one SoC.
>
> #define MODEL     "mtk-camsys-3.0"
> #define INPUT_NR  4
> #define MUTEX_NR  6
> #define OUTPUT_NR 4
>
> Because we don't know which SoC would be upstream later, maybe the next
> SoC would be
>
> static const struct mtk_seninf_conf seninf_83xx_conf =3D {
>         .model =3D "mtk-camsys-3.0",
>         .nb_inputs =3D 4,
>         .nb_muxes =3D 6,
>         .nb_outputs =3D 4,
>         .support_xxx =3D true;
> };
>
> then model, nb_inputs, nb_muxes, and nb_outputs has no difference, so
> it's not necessary to define them as variable. So define them as
> constant now, and when next SoC upstream, then we know which one would
> be variable.
>

Hi CK,

Thank you for your feedback on this series.
We already discussed this in an early version of the series (see
https://lore.kernel.org/all/2dd412f0-86cb-3ae0-305d-0e8192b9128a@collabora.=
com/).
I also discussed with internal teams in Mediatek about the folder
architecture. If this is not a red flag for you, I 'll let it as is.

I will fix other comments you did and that I forgot to add in previous vers=
ions.

Cheers
Julien

> Regards,
> CK
>
>
>
> ************* MEDIATEK Confidentiality Notice ********************
> The information contained in this e-mail message (including any
> attachments) may be confidential, proprietary, privileged, or otherwise
> exempt from disclosure under applicable laws. It is intended to be
> conveyed only to the designated recipient(s). Any use, dissemination,
> distribution, printing, retaining or copying of this e-mail (including it=
s
> attachments) by unintended recipient(s) is strictly prohibited and may
> be unlawful. If you are not an intended recipient of this e-mail, or beli=
eve
> that you have received this e-mail in error, please notify the sender
> immediately (by replying to this e-mail), delete any and all copies of
> this e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank you!

