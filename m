Return-Path: <linux-kernel+bounces-214802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63709908A30
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 12:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938A528C8DF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057B21946B9;
	Fri, 14 Jun 2024 10:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pa5/W4yY"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546BB146582
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 10:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718361511; cv=none; b=sKxKc5Kxb5/4j9fYx6LL873+BKvm4qGuTgo+QgiBsCYhOIbVRMCyEPuQD3yOl3sIPZ2/DSz6jiNNp9DvEjP1dQlxOTeI9q3SQWYdXjuntCLs1tWobeElTa1Fw5/2u4d4GkaURKnrLFS4saYlfkDEPztaRIMu7fh9g+RnsNC4zhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718361511; c=relaxed/simple;
	bh=2j9w101auUmiKXhAcno40D23v2revVO9TZYw2w4t+U4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bZfB6uE8aHLqcJbE3EsZ0612T3PpyeYiuqd0HKCmVkgOGyXZohEQnMArPZbKoAAT3rXAaN3S1+E5Ex70bZfOAkxTrZix8nxYRPABt1mPUJdP6TyY5JiCJ0KuH88AR5wM7Mkwo2i9lltdU98okEPE8Ln5qr8ZMkcMTdih7JTQG48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pa5/W4yY; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57a4d7ba501so2396210a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 03:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1718361508; x=1718966308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lEx+5wwN9fBLZNltFTgu34oXR2RNqSzay2NOoaIOLs=;
        b=pa5/W4yYF2Cx4Bg5RBkbeal6ZMba/dUxK/3c4d1YmiRsiVcYLGcRqGI2puZNslG/fV
         fgSLEtwjoFUZVVVqMy1QaqmcgQTXP0okX28uAZqKZaHsevLkpZ6uXQpExiy598SonQTU
         xicMD9kCsK6OvvkqwYAuEPiluWIlcvbb2FyFIPfCrKr1V/DV2uwptOxxb3S5F80B1KD5
         fF4MqsKlOd/FXS5xN9t41MHdlhrLHlGOaFnBYTCkJ3lqxbqEwv5KCZbV70VzRqf4luXb
         foRRM3sRNYqpNlk51a7FdSiBHfrvSFlVX4wrRIaX9/r5C4e3hLtEvl9kVvLZZGXb2Qa/
         8GeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718361508; x=1718966308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9lEx+5wwN9fBLZNltFTgu34oXR2RNqSzay2NOoaIOLs=;
        b=tgcjsDFIQPOiFfXfWqleJBqCL2/evBRrMtugyYE7d6Azh0BMvQRgP51g95fw9J9oSn
         +LEJB+gTXcfMN/AO2g7TDKS+pTCOVba4Q4NzEZvzAwr1SavwfnTZeAI5JddKGNqZ16qe
         hKZ/A33Ik2d69UO6AlaDiw8em9TA7d5j6iv7WSwlY9TJARjesyyCwvdlW1IbhUeSe82F
         OTBFyJuPJ4c8ziPN3bJq6Edo72e3ZPMhnQYJwRSL45fuJxqZZaslZYxI2PXKoT0yvSPl
         WsvLZRyhJgy/r1diz9obgg8wpjfbo7uHiAdrAZCNXLWLUGe4m4XS6ohqBK05acCw5Msb
         KBLg==
X-Forwarded-Encrypted: i=1; AJvYcCUFExX1tlbFzVVH5hog4ZsWTquA59Ia/QWEZnOHwwx7D0kK44UhMZIDNVcpu4UQQ6n7hCnUAAmCL8QTWG78LBIONgiQM0r223or6+fN
X-Gm-Message-State: AOJu0YyDrIOXk6Wm0S/TPVTWHr5QnFmKSngJuhrA8nvzVRrW89lVqEjl
	ST2DwbFHygdczk0aIfuywgMBZXtmn4UbMsD9cIHkl7WI5LtR5xT3KVzBWXS26qViPUlqSg037OP
	HEq3L4R1W99aVcnrQevvxRS7B11O++3TaHgOnDg==
X-Google-Smtp-Source: AGHT+IG6jcyBZObUWctTNk2L0XtXOwkk2+zrzjA/HUVBoU8DzbjLvKPo6VWfCt3UnQlMuaZ2eeI5BtTF1vwgfTlOAfE=
X-Received: by 2002:a17:906:2709:b0:a6f:4ebd:31a3 with SMTP id
 a640c23a62f3a-a6f60cefe94mr178307866b.14.1718361507464; Fri, 14 Jun 2024
 03:38:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110141443.364655-1-jstephan@baylibre.com>
 <20240110141443.364655-4-jstephan@baylibre.com> <3c2bee40-3792-409c-b42f-f8b013ff641c@collabora.com>
 <CAEHHSvaT_U+HNzWQUoK9EuqGuqEd11+Lu0CLz_rL7uQf0Q5isw@mail.gmail.com> <53838e76-bfa4-41f5-a015-a37472e98991@collabora.com>
In-Reply-To: <53838e76-bfa4-41f5-a015-a37472e98991@collabora.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 14 Jun 2024 12:38:15 +0200
Message-ID: <CAEHHSvaRqZM9c8oD05WKkhOHdjKLBkR6tXp2Q1b8OMiDxDsDhQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] media: platform: mediatek: isp_30: add mediatek
 ISP3.0 sensor interface
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Louis Kuo <louis.kuo@mediatek.com>, Phi-bang Nguyen <pnguyen@baylibre.com>, 
	Florian Sylvestre <fsylvestre@baylibre.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Andy Hsieh <andy.hsieh@mediatek.com>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-media@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Paul Elder <paul.elder@ideasonboard.com>, 
	Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 12 juin 2024 =C3=A0 10:06, AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> a =C3=A9crit :
>
> Il 10/06/24 16:39, Julien Stephan ha scritto:
[...]
> >>
> >>> +     writel(0x10001, input->base + SENINF_TG1_SEN_CK);
> >>
> >> Unroll this one... this is the TG1 sensor clock divider.
> >>
> >> CLKFL GENMASK(5, 0)
> >> CLKRS GENMASK(13, 8)
> >> CLKCNT GENMASK(21,16)
> >>
> >> Like this, I don't get what you're trying to set, because you're using=
 a fixed
> >> sensor clock rate, meaning that only a handful of camera sensors will =
be usable.
> >>
> >> Is this 8Mhz? 16? 24? what? :-)
> >>
> >> Two hints:
> >>    - sensor_clk =3D clk_get_rate(isp_clk) / (tg1_sen_ck_clkcnt + 1);
> >>    - int mtk_seninf_set_sensor_clk(u8 rate_mhz);
> >>
> >> Please :-)
> >
> > Hi Angelo,
> >
> > I think I get your point about not hardcoding the sensor rate, but I
> > am not sure how to use
> > a mtk_seninf_set_sensor_clk(u8 rate_mhz); function.
> >
> > Where would it be called? How is it exposed to the user?
> >
>
> As for where: setup, streaming start, resolution change (which may be cov=
ered
> by streaming start anyway, as a change should be calling stop->start anyw=
ay).
>
> And for the how is it exposed to the user - well, depends what you mean f=
or user,
> but it's all standard V4L2 API :-)
>
> Last but not least, I can give you another hint....
>
> struct media_entity *entity =3D (something_here);
> struct media_pad *mpad;
> struct v4l2_subdev *cam_subdev;
> struct v4l2_ctrl *ctl;
> s64 link_frequency, pixel_clock;
>
> if (entity->pads[0].flags & MEDIA_PAD_FL_SINK)
>     return -E_NOT_A_CAMERA_SENSOR_WE_IGNORE_THIS_ONE;
>
> pad =3D media_pad_remote_pad_first(&entity->pads[0]);
> if (!pad)
>    return -ENOENT;
>
> if (!is_media_entity_v4l2_subdev(pad->entity))
>    return -ENOENT;
>
> if (pad->entity->function !=3D MEDIA_ENT_F_CAM_SENSOR)
>    return -ENOENT;
>

Hi Angelo,

Thank you for the detailed explanation :)
However, I can't make it work because in my case, seninf is connected
to an external ISP
so pad->entity->function =3D=3D MEDIA_ENT_F_PROC_VIDEO_ISP.

How can I get the pad corresponding to the sensor?


> cam_subdev =3D media_entity_to_v4l2_subdev(pad->entity);
> ctl =3D v4l2_ctrl_find(subdev->ctrl_handler, V4L2_CID_PIXEL_RATE);
>

Is this mandatory to implement V4L2_CID_PIXEL_RATE ?
Should I return an error if not found?

> /* multiplier is usually bits per pixel, divider is usually num of lanes =
*/
> link_frequency =3D v4l2_get_link_freq(cam_subdev->ctrl_handler, multiplie=
r, divider);
> pixel_clock =3D v4l2_ctrl_g_ctrl_int64(ctl);
>

How to know the sensor clock given link_frequency and pixel_clock?
Can you point me to drivers doing something similar?

Cheers,
Julien
>
> ....now you know what the sensor wants, set the seninf sensor clock accor=
dingly.
>
> Cheers
> Angelo
>
[...]

Cheers
Julien

