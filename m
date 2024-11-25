Return-Path: <linux-kernel+bounces-421225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4429D883B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 15:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C78D289D67
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF571B0F29;
	Mon, 25 Nov 2024 14:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WYPZNpiO"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4501B0F22
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 14:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732545634; cv=none; b=pC+x1T+h19bnmwYfCfTJy3Y2koIfpNrYxTWudncUX+fyH7qHCV5DBMSqtnDiyw8RY0/gD2LVEGfJQysqi9Zq/y9UIkqL2Ye0BL/f6iH36zdW6MzAWATWX9GyWv9Mm9EX1rmp5VT5nKLlvy6/jfXPuh2q3roSufwYkFAgJ0lEgDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732545634; c=relaxed/simple;
	bh=QuFr33PxWwiOkN1ep41/1P8oQdyw21yNSIU94tRsxqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YpTMUOkqrKuMCkyxDS1U296F1bcXWc9RoqF6TEGuYQBhub8mmBLckV+zJgO2lG0Ddx4Mu1m8unjvzWHRlXX8GLA+RF7a0Fp3WsckfwZHA0h42+0rDCeDz7yQotPgPoMj9tH2n/eGZpcvuOj4y/mXBT5Lw6kcj7Jt2ow+hUEAc4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WYPZNpiO; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ffc1009a06so15473931fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 06:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732545630; x=1733150430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wkpi3C3Erb5LcuJAqMaLXJb2wxyVOmfXm6CfHhPKV4Y=;
        b=WYPZNpiOhpKZysKRFs2kaAnvnxiecQhipbKPwliqXu5LnV/UPbeW6V81X4j5xP7BqQ
         BAjFMO6EVE0JuxkkYdpakLONI+8No4YWGbhl0y9yoeSXqspvO57u+lutwJa0XHxK5wS4
         a9vCEYUIQFaMwWbOoD0X8fpG1HibedNIYTQImfIOMdiE6btVMzBAYqJ4FmELG11nw734
         7adxlQu5uLkiotruDX+nAVwmNaNW1spA9LHECceHN7Su4SQrs1FIFdc/ruIH1M8jEvXo
         iw3DOU/5Os/GUjGXSQX5Uo5nnS2GTqsRQvoxQB/4JYCa35eGwliwfWPnHxvBUuIkS5XO
         PTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732545630; x=1733150430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wkpi3C3Erb5LcuJAqMaLXJb2wxyVOmfXm6CfHhPKV4Y=;
        b=T8JAf4plpW9CXEe9zGnN5Gs1kikFNfGqD3yDZXZyB7Rz2tWp6Xw6k/Oakzxu88r5xf
         TdS6Gnlv1splDCkijuD3G3hdf2MQgg50JqluSaE7ZpwD2mOjlKRIBA7zFyUCvOZLVGMQ
         APf5K1Qjl/l9FfOEvitVYto7R3D0inwzIdbtb8LL1VuG51pJupkF6dENW10Xn2e1KQBB
         mXF63dkJm1cxZ8f4VKwbJrD+eNqeKJP7wRZemyrttQ2qV8vDGHc1UdyeoTGKwOx57DM1
         b3WBQJFiBiVBNrhh5J7jgvpFxtWQe1OEGhaTzyTN23vf3+aLKAfPCDXo+DZR5pPabGmk
         h1NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXiX1G7Tyj7tSER2QQaBqMfvc2ryIDM/LCxo3YZv8dvhGkYuDoFZKHrz+3Qz7RlEPcCAZk6ZQ1zCA//cI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6YzDkjfsvHt0vMUk9dBctQGJCvbg7qgdwF3aC++vgOTuWP59K
	AnE7Rp/KSWyRhvML4NWy1Tt7nMvp1hUSrma/DfqvBFjJEIHyWvsjvmvvEeYfgbNIWFx4LkokrGs
	Zn7GosKkpf1gyJ/5oV3Su2EjgBMX8V5rr30BZuQ==
X-Gm-Gg: ASbGnctcwBn5QVSZfyv9MebH3tEvKlcElZVctovHoXvlIRvKt9g5ROm+vuUwhbxhfub
	9cXLzVjPrJq0eQgq+A7Q5ZwZldzmofA==
X-Google-Smtp-Source: AGHT+IGylk1WBc/171m1MnIZm+s014KvRI8FCTVhJrxpcS9ekQI1Zx3waN0H0Og4c/z7YunW3cfM693tp/5+vZLQ61k=
X-Received: by 2002:a2e:87d0:0:b0:2ff:bc48:a0d0 with SMTP id
 38308e7fff4ca-2ffbc48a360mr28445671fa.6.1732545629740; Mon, 25 Nov 2024
 06:40:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121-add-mtk-isp-3-0-support-v7-0-b04dc9610619@baylibre.com>
 <20241121-add-mtk-isp-3-0-support-v7-4-b04dc9610619@baylibre.com> <d17dfb29f60bfa1889aa554ef16c9ddec272520d.camel@mediatek.com>
In-Reply-To: <d17dfb29f60bfa1889aa554ef16c9ddec272520d.camel@mediatek.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Mon, 25 Nov 2024 15:40:18 +0100
Message-ID: <CAEHHSvbScBhn=6rSOApQ=K9JEpwL6JPpJnJy929mLXHhxQ=3FQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] media: platform: mediatek: isp: add mediatek
 ISP3.0 camsv
To: =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
Cc: "mchehab@kernel.org" <mchehab@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, =?UTF-8?B?QW5keSBIc2llaCAo6Kyd5pm655qTKQ==?= <Andy.Hsieh@mediatek.com>, 
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
	"laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"paul.elder@ideasonboard.com" <paul.elder@ideasonboard.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"fsylvestre@baylibre.com" <fsylvestre@baylibre.com>, "pnguyen@baylibre.com" <pnguyen@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 25 nov. 2024 =C3=A0 09:14, CK Hu (=E8=83=A1=E4=BF=8A=E5=85=89) <ck.=
hu@mediatek.com> a =C3=A9crit :
>
> Hi, Julien:
>
> On Thu, 2024-11-21 at 09:53 +0100, Julien Stephan wrote:
> > External email : Please do not click links or open attachments until yo=
u have verified the sender or the content.
> >
> >
> > From: Phi-bang Nguyen <pnguyen@baylibre.com>
> >
> > This driver provides a path to bypass the SoC ISP so that image data
> > coming from the SENINF can go directly into memory without any image
> > processing. This allows the use of an external ISP.
> >
> > Signed-off-by: Phi-bang Nguyen <pnguyen@baylibre.com>
> > Signed-off-by: Florian Sylvestre <fsylvestre@baylibre.com>
> > [Paul Elder fix irq locking]
> > Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> > Co-developed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Co-developed-by: Julien Stephan <jstephan@baylibre.com>
> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > ---
>
> [snip]
>
> > +static void mtk_camsv30_update_buffers_add(struct mtk_cam_dev *cam_dev=
,
> > +                                          struct mtk_cam_dev_buffer *b=
uf)
> > +{
> > +       mtk_camsv30_img0_write(cam_dev, CAMSV_IMGO_SV_BASE_ADDR, buf->d=
addr);
> > +}
> > +
>
> [snip]
>
> > +static void mtk_camsv30_fbc_inc(struct mtk_cam_dev *cam_dev)
> > +{
> > +       unsigned int fbc_val;
> > +
> > +       if (pm_runtime_resume_and_get(cam_dev->dev) < 0) {
>
> I think this pm_runtime_resume_and_get() is not necessary.
> mtk_camsv30_fbc_inc() is called only in mtk_cam_vb2_buf_queue().
> But when buf_list is empty, mtk_camsv30_update_buffers_add() is called be=
fore this function.
> But mtk_camsv30_update_buffers_add() does not call pm_runtime_resume_and_=
get() and it works normally.
> So this function is not necessary to call pm_runtime_resume_and_get().

Hi CK,

This one is actually needed because .buf_queue can be called before
.start_streaming in case a user requests to prepare buffers before
streaming.
But you are right, if a user requests to alloc buffer before streaming
mtk_camsv_update_buffers_address will be called without pm. Streaming
still works because in start streaming we call
mtk_camsv_update_buffers_address again.
So maybe I should put the pm stuff in mtk_cam_vb2_buf_queue ?

Cheers
Julien


>
> In other register setting function, please also check this pm function is=
 necessary or not.
>
> Regards,
> CK
>
> > +               dev_err(cam_dev->dev, "failed to get pm_runtime\n");
> > +               return;
> > +       }
> > +
> > +       fbc_val =3D mtk_camsv30_read(cam_dev, CAMSV_IMGO_FBC);
> > +       fbc_val |=3D CAMSV_IMGO_FBC_RCNT_INC;
> > +       mtk_camsv30_write(cam_dev, CAMSV_IMGO_FBC, fbc_val);
> > +       fbc_val &=3D ~CAMSV_IMGO_FBC_RCNT_INC;
> > +       mtk_camsv30_write(cam_dev, CAMSV_IMGO_FBC, fbc_val);
> > +
> > +       pm_runtime_put_autosuspend(cam_dev->dev);
> > +}
> > +
>
> >
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

