Return-Path: <linux-kernel+bounces-418036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 229CE9D5C1B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 10:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C8C21F2209A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF7A1D9A5F;
	Fri, 22 Nov 2024 09:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DCfR1GKm"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572FC15ADA6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 09:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732268707; cv=none; b=tolUMlOyjxBwtVg3XzqPkA0u14yah2vsMHMZmbja8E5nFTh4SFl1RsV1uUzm91kplcAPc6ZfmfCywD+FAiOFGn+pP8h0vRcdmr8LDB3Ky/2VM2mG4fZYfPlTPIsEXJeSxdkC5KWyMFB220NMnvhtcdOTlATPaHsErmCJuhEtKGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732268707; c=relaxed/simple;
	bh=rh5y7iuvpjJm0tGzNzHX8c4j5Nqms78d7FpKWJ66heA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l1qiQhdZaBan5Wy7UmHXUtHi35oiDyylnX6FMtAGTinKxy8iFO2zTztQBhtXNkIOcldE5oh8SDpbnadgkn9uKQxFurLvUS4SA+RSerGGOLwRKJqiRJeTu4OjwK6lU9jjZ3THfzUqrUZGMjvyl6SkSebX+w648ci0XTYnoQFIqFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DCfR1GKm; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso329398466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 01:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732268704; x=1732873504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hd6q8zDhHex0K31D5UPVNO7yeK6NJNFYGAAxQqzFbc=;
        b=DCfR1GKm9KUwDH+/OKxcQEqu/lvPLJx2ynpZponoo/Gduq8NzgBNVJ0lAn+GU67uAF
         pZ462mbx/VrXSj+1DudZjdYwKYgA3JYp0SLcQMPgroRXJbdEblvG2CNFaPfCF2ghHSEq
         WTFHNHnvn1ZItVSpA8UYTtC82ZVTBZDWw3YgXbvKrFbeKuMa9YbH6gNolSMcQQ+lRySc
         oHPL/zxvWjBrg4K+UF9WuyGdT8WBjzatDV5V0OWkSu5qZ2EzOgydDJiS9OPqSvjutVco
         5AtXX/te4xokLFMcGlLdYfWd+DkMA7zPg+W8qAk8m5vmZMAy0uUpjeIFIqMNvWtL1EQr
         +WQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732268704; x=1732873504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hd6q8zDhHex0K31D5UPVNO7yeK6NJNFYGAAxQqzFbc=;
        b=uYbwhjF9T3L3Gfi0EbxsTyE/B/aXFINNd1lFmnhtetbs4O8C+u3uEBbYLrQk5hmilW
         P0rRENxYefwCDh2Y7TrpGh4CtWqdkylpb65zzviHnyqUsXQg8XwAqeEcoqqZ3QQQLOLL
         jA9+2ws+13hyQoGzRkhVToCZ/KOZN9AxHRRGasErmT9BdWvwHKzZuNCIihsvoHnuKUyC
         KUjUI1lo4Zk6JlD69kgGGeVp1QwldEISzj/MO039kanogqXvu42jpOfwQgMO2umSRpPG
         wAwu5aFxVVb6FyijLVJB+dTlv6TJ7W4puIO7z7o0N8fr2DNOZxOJj8qBWFwlUZVxYZUA
         aZWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUudXhzKaQ90r9lLWn0mb1bo02uVtiKTcIrDDIjJqtH5Jz/LsCgnVGMf5/hdhJFG8Ppg6DhY7sBhBHF/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKg9eJDC4lf7YVK6h2qOKsEBzSr5B1f02MvvHgd/VvMcTp6ElD
	MHLGvIHBFFhicdFEbP75DnesXwdEdXVl1sL3wYEeI7yhCmBhsc/Dxxn0Ix9uozGK7RQPxh0+L/T
	qxnkp5ttmBjNmCsxgmkUnwiJJnJjtfw/4jgOMqA==
X-Gm-Gg: ASbGncv34WTWcOMeCx9K4FeltnftoBIV8cs1k/LW8B+I0Qio/PplsJme8wXn/Nvz/aF
	Txd+00t4yDXm4RD2xcw3PM+TRcVk10w==
X-Google-Smtp-Source: AGHT+IF2siysXCL8AuQk/Zj9BKQZImmKFwTANKrD+H57DhSj6YZ4aXozWUBRbTyiMmt32yK0vwfP+uNoBA8OHC90tE4=
X-Received: by 2002:a17:906:310b:b0:aa5:2237:67af with SMTP id
 a640c23a62f3a-aa522376878mr15619866b.9.1732268703393; Fri, 22 Nov 2024
 01:45:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121-add-mtk-isp-3-0-support-v7-0-b04dc9610619@baylibre.com>
 <20241121-add-mtk-isp-3-0-support-v7-4-b04dc9610619@baylibre.com> <b0af0ec1545b33fed81f34a866bc7b7222c78ad7.camel@mediatek.com>
In-Reply-To: <b0af0ec1545b33fed81f34a866bc7b7222c78ad7.camel@mediatek.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 22 Nov 2024 10:44:52 +0100
Message-ID: <CAEHHSvbFw+MC0R3w7isgrF15JAAfBWQmSkh1PoiU7y+P4O2psw@mail.gmail.com>
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

Le ven. 22 nov. 2024 =C3=A0 10:19, CK Hu (=E8=83=A1=E4=BF=8A=E5=85=89) <ck.=
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
> > +static void mtk_cam_vb2_buf_queue(struct vb2_buffer *vb)
> > +{
> > +       struct mtk_cam_dev *cam =3D vb2_get_drv_priv(vb->vb2_queue);
> > +       struct mtk_cam_dev_buffer *buf =3D to_mtk_cam_dev_buffer(vb);
> > +       unsigned long flags;
> > +
> > +       /* Add the buffer into the tracking list */
> > +       spin_lock_irqsave(&cam->buf_list_lock, flags);
> > +       if (list_empty(&cam->buf_list))
> > +               (*cam->hw_functions->mtk_cam_update_buffers_add)(cam, b=
uf);
> > +
> > +       list_add_tail(&buf->list, &cam->buf_list);
> > +       (*cam->hw_functions->mtk_cam_fbc_inc)(cam);
>
> I think fbc_inc should together with update_buffers_add.
> After update_buffers_add then fbc_inc.
> So squash fbc_inc into update_buffers_add and drop fbc_inc function.
>

No, this is not true.
mtk_cam_update_buffers_add is used to indicate which buffer should be
used for dma write. This is the first entry in the buf list.
mtk_cam_fbc_inc is used to increase the number of available user space buff=
ers.

If the buffer list is not empty and user space calls buf_queue again,
we need to call mtk_cam_fbc_inc to increase the number of available
user buffers, but we don't want to change the buffer for DMA write.

mtk_camsv30_update_buffers_add is called on irq to update the address
to the next buffer (if available).

Maybe the name mtk_camsv30_update_buffers_add is confusing then?
What do you think about:
- mtk_camsv30_update_buffers_add -> mtk_camsv30_update_buffers_address
- mtk_cam_fbc_inc -> mtk_camsv30_buffer_add

Cheers
Julien

 > Regards,
> CK
>
> > +       spin_unlock_irqrestore(&cam->buf_list_lock, flags);
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

