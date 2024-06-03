Return-Path: <linux-kernel+bounces-198573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B448D7A76
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 05:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80D231F21411
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 03:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA09DBE6F;
	Mon,  3 Jun 2024 03:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GlPyku4v"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9777AB67D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 03:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717385357; cv=none; b=euy9zaABOOJZQXNnrc7Bc98TgAjySN+W+WJBTGt0KVv6KI+UakoLVZTbL7XfW4yCpBUb/wwFo5fVVPPWmKqkUU0YH+XJUDUpH2GfSwUiE5Po4/YL3yYDXG8SgQe1+PeeqXTLyCWMDx+4A4jotLHQtveGsyNucpJKQrMXTLviwo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717385357; c=relaxed/simple;
	bh=Itozid0Uq5J7jjr3EzC4B5DvjdhT5De96tQux4vbmo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tEvzAUTvSuF+yIQmSbQ/XygLPjSf1Nye1mJQ3GH93OZQPHVvdWhEM/yu9/dyoNsD/9N3RUaIfECr03vzgO5eYPd8X06Afse89ZZZZs4w5eUQQkZpO41KPtB9l5ngoNtBv505VEqcDmFrazCYtUhvgHY+Qf5aWpBeNc4fWpLQnGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GlPyku4v; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52b9dda4906so75884e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 20:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717385354; x=1717990154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqoXXfkLNaBeFUlnpo3xHv3wq1HsyXPs641ijeJqfYU=;
        b=GlPyku4vIgAWQTU5d1BOgnsLpQ9wR/wZR3KuT9Cef3UNruXlz4dgVHvFks7E4ZN+Lp
         M5fBxc3Cjjm6qYpXP993phl0LzP0pypxkVNyf1htr5KHmz0gn0Rzs3HjH6RwgZgLH9WY
         aCzeqrG1WWaq5j7U4QBY/63PhOZ3jIAPMZhhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717385354; x=1717990154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gqoXXfkLNaBeFUlnpo3xHv3wq1HsyXPs641ijeJqfYU=;
        b=Tssgt/gqZ4QFhtSsL0yrvwcQ14Ho9YgqV4sjlPsHGaYZOrkaSYC4GpmIJ5XoWrsd61
         d1jW7BBWK5As3y0CuxU3u6rUYPIW0u+lnkKF9/MCy3oS0dsvkwP+rVfbr3H/o654unBr
         0WlN8SgI1ErS/RNOlcoyDWfYgJBXXKSUVunwSSlvX+SPva8tMSlEZyZjxM1eymhAH6Kg
         mwQKJXj5bLWuyiR9aIFp67UCAvVq8Z9taLDidGNY/GqKOGtwZO74/TRUfOqf+xtqFgBq
         MuxACcp9jp1T2bMUQvKETE1SdiYK8ReoccnNCA9Nrgo9vg6IBHN0B/KZI4hZZrdrIKsc
         JvMg==
X-Forwarded-Encrypted: i=1; AJvYcCVmDO3njo/+kIR0ThSATQi7MRTBTre5P1zlwxU+84TlP+gruzAYj94VUff/Ylzfg4AopxbqM2V2iN2t3Kv10cLd1yJEe0FIxcH7ulLp
X-Gm-Message-State: AOJu0YzXfDOj3g9nA06XzWOdPbwEVi+OcsveGmIDusz5EflyfLk5+0X1
	Y3BO3iUyYJEItbRvJdZjELq9bsW8sLrZXyLxbOlDpjIZonS9Jwj8TnyxY1HrnJUaLnlE+blXOhG
	Ws1iLl5AFSh6lncBiT9Htqzkpr4mBtQ35jzsLEiMw89ApFMA=
X-Google-Smtp-Source: AGHT+IEDtRtBaOGSJnBChD4ejorRQ3d5tt8uQF6LU8aQIF4mUQzWnXLmkerka4FGapEkwbPEkl429n/sIzWje66CjaU=
X-Received: by 2002:a05:6512:3145:b0:52b:7a3d:1e12 with SMTP id
 2adb3069b0e04-52b896d9115mr5870986e87.65.1717385353646; Sun, 02 Jun 2024
 20:29:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240530083513.4135052-1-wenst@chromium.org> <20240530083513.4135052-5-wenst@chromium.org>
 <efdacd820d13368816973f57c4a817e039ec4a2d.camel@imgtec.com>
In-Reply-To: <efdacd820d13368816973f57c4a817e039ec4a2d.camel@imgtec.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 3 Jun 2024 11:29:02 +0800
Message-ID: <CAGXv+5EMMNCbxaBqiBSQwGrQt-0KXWAtJU54K20sUU8PBh8faQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] drm/imagination: Add compatible string entry for Series6XT
To: Frank Binns <Frank.Binns@imgtec.com>
Cc: "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "tzimmermann@suse.de" <tzimmermann@suse.de>, 
	Matt Coster <Matt.Coster@imgtec.com>, "sboyd@kernel.org" <sboyd@kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>, 
	"mripard@kernel.org" <mripard@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "airlied@gmail.com" <airlied@gmail.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, "daniel@ffwll.ch" <daniel@ffwll.ch>, 
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, Boris Brezillon <boris.brezillon@collabora.com>, 
	Steven Price <steven.price@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 7:18=E2=80=AFPM Frank Binns <Frank.Binns@imgtec.com=
> wrote:
>
> On Thu, 2024-05-30 at 16:35 +0800, Chen-Yu Tsai wrote:
> > The MediaTek MT8173 comes with a PowerVR Rogue GX6250, which is part
> > of the Series6XT, another variation of the Rogue family of GPUs.
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >  drivers/gpu/drm/imagination/pvr_drv.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/im=
agination/pvr_drv.c
> > index 5c3b2d58d766..3d1a933c8303 100644
> > --- a/drivers/gpu/drm/imagination/pvr_drv.c
> > +++ b/drivers/gpu/drm/imagination/pvr_drv.c
> > @@ -1475,6 +1475,7 @@ pvr_remove(struct platform_device *plat_dev)
> >
> >  static const struct of_device_id dt_match[] =3D {
> >       { .compatible =3D "img,img-axe", .data =3D NULL },
> > +     { .compatible =3D "img,powervr-6xt", .data =3D NULL },
>
> I assume that by adding this to the list of supported devices we're essen=
tially
> freezing the existing uapi. This concerns me, as we've not yet started ru=
nning
> Vulkan conformance on any Series6XT GPUs and there's a chance we may need=
 to
> make some tweaks.
>
> I'm not really sure what the accepted approach is to hardware enablement =
/
> experimental support. I'm not sure if it's sufficient to hide support beh=
ind a
> Kconfig option and/or module parameter or whether we just have to hold th=
is
> patch back for the time being.

I guess this is more of a question for the DRM maintainers.
Added a couple Panfrost/Panthor folks for ideas.


ChenYu

> Thanks
> Frank
>
> >       {}
> >  };
> >  MODULE_DEVICE_TABLE(of, dt_match);

