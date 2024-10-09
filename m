Return-Path: <linux-kernel+bounces-357844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B28D19976E9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 22:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E35711C23496
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735A41E1305;
	Wed,  9 Oct 2024 20:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=everestkc.com.np header.i=@everestkc.com.np header.b="dHgUG1cC"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F8817BB0C
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 20:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728507010; cv=none; b=Qj1B/MSaydJpTO/AUh2Z4L+U7DZar6Cf0jzgEvICzVPMamUa51AVoKCBT+rWabVydNzV2vvMdaxCTX53SdKvAA/ctznomm4C6fdjPeJkbwxcWX/eL/z0jPIwjFATnX0r8yxnOEVujoaSnHp+OidrwRtRVO1Yj5NgF/xuw1mUwWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728507010; c=relaxed/simple;
	bh=2lp3Ln00mpRryNRxq60rNEzUatPpphR1j8+PG29glH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pVJLUX3FCWeotrMlrrvHIbdsTCI3cTnlg3EdIB4TVgf2l5ityJaxpEKvf5wNJHItDRh7uWbLd053LfBazLqBqJPLU2a3RQCGN7nZqedPtYDtYai7A1LKmGw/WOXv+XLhu/ofAKaMggEbEgqsRI+vYtTedpsvTUcCu9dkTfy47PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=fail (2048-bit key) header.d=everestkc.com.np header.i=@everestkc.com.np header.b=dHgUG1cC reason="signature verification failed"; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c8784e3bc8so193453a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 13:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc.com.np; s=everest; t=1728507007; x=1729111807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6AlyAiK8jIW99PS/mbC0CEBkjDKR+IRpZZi78iD0gY=;
        b=dHgUG1cCtxyhl5WPezwYmpRgMJoch+nVlDK7dP+u6OZkUyYq4tgwlrcai408TKkIQw
         xy8n1xd/DodlskwdqkNPipWLM2TUhMQXhg8IwHIGeFoU02s4fFbFYKg1UiJVjNWUNRZ7
         rLT8zqiKZiDSyLPWTnvMV5BNnECBi45RLKF7fboNL143ztCq57MO48HR1J5LBt1Fu2q8
         +JdIl02Dbt/Yes36LINdvBosPbWkWnxb1Onnlrh0OzkitNBzRS6kdb6ujUAY2TM8KAdG
         ntt6nUAe0l9D1juRubF/yJIWBA06zumBbGWKFbRC4p3YzoRlMEZ0gHHG19VDoRIQGnfZ
         X4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728507007; x=1729111807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U6AlyAiK8jIW99PS/mbC0CEBkjDKR+IRpZZi78iD0gY=;
        b=wnSo9jdDPsxv14iZUkmdRmL19C3j+OucDGXMoocZRn++AncLYzGyfajd8jF9v9g29v
         GRz2rR2/vpJFCU1zKRNV4dlJukAW8Jd/eceK/eFZ/r73vgyRKpDNpvLcs1drdYPno+Xm
         1TrBaodI9tV9Jc8P+GEQn0+ZoK+dHrGPSArJ2uySdZyJuFhyUi86/MReLc/AyLYsKFTK
         rXCrrDUiGFGQALbYOD8nhIxnIXZGZDsyEM5sj1MT3VNUAx9I+OkZ0Xe9EntSiqGrfY/x
         4W8JRhuHY+i/bJKzZNT9Ml22d3hXSrQYkbJWfIE+RyOc8+PkI1V6ECDu66Pebh0TqXY6
         D3lg==
X-Forwarded-Encrypted: i=1; AJvYcCUb3bzvstpf8MPf7uglOxBI3tAuxQ6GMLsjKGtHSlR9FXGSjEYWfJRM8F3msnl5YzWd9WiiU3ikCPMvWCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyDvfZxXFo/KgNpnGymFZF631k+Y8D3Bh65BKLgG4xBkUF7eUj
	KDkhNv6X5+a4TZoqfPzupysWrII0g2gi/NSbMypFzuFUpExtsgjDpZjFGUNIbNv9wlXH7H8fIrY
	0F/nY7kW9gUVa9ecaTx7Ug1Qik1tmIDBUWZUtxQ==
X-Google-Smtp-Source: AGHT+IHZQ//C/LT9bz4MtZcmxJW5GzbBzoSV9zKUThFSFKoiavT+2C93cS1UjaGvXK3AnSkDwkQ7q5RXVs+r0/IWRVo=
X-Received: by 2002:a17:907:7ba9:b0:a99:442e:34ac with SMTP id
 a640c23a62f3a-a999e8c9f03mr127272866b.40.1728507007259; Wed, 09 Oct 2024
 13:50:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009184951.4991-1-everestkc@everestkc.com.np> <07d9eb6e-87d3-4428-aaa4-8721a6844404@stanley.mountain>
In-Reply-To: <07d9eb6e-87d3-4428-aaa4-8721a6844404@stanley.mountain>
From: "Everest K.C." <everestkc@everestkc.com.np>
Date: Wed, 9 Oct 2024 14:49:55 -0600
Message-ID: <CAEO-vhEGtBX1sb3MYm18+MBGEgrFfNpzatBT46kcN9_Wh=NFMQ@mail.gmail.com>
Subject: Re: [PATCH][next] drm/xe/guc: Fix dereference before Null check
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: lucas.demarchi@intel.com, thomas.hellstrom@linux.intel.com, 
	rodrigo.vivi@intel.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	skhan@linuxfoundation.org, intel-xe@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 2:35=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro.=
org> wrote:
>
> On Wed, Oct 09, 2024 at 12:49:49PM -0600, Everest K.C. wrote:
> > The pointer list->list was derefrenced before the Null check
> > resulting in possibility of Null pointer derefrencing.
> > This patch moves the Null check outside the for loop, so that
> > the check is performed before the derefrencing.
> >
> > This issue was reported by Coverity Scan.
> >
> > Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
>
> You need to add a Fixes tag.
Will add it and send a V2.
> > ---
> >  drivers/gpu/drm/xe/xe_guc_capture.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/xe/xe_guc_capture.c b/drivers/gpu/drm/xe/x=
e_guc_capture.c
> > index 41262bda20ed..de63c622747d 100644
> > --- a/drivers/gpu/drm/xe/xe_guc_capture.c
> > +++ b/drivers/gpu/drm/xe/xe_guc_capture.c
> > @@ -1537,13 +1537,13 @@ read_reg_to_node(struct xe_hw_engine *hwe, cons=
t struct __guc_mmio_reg_descr_gro
> >       if (!regs)
> >               return;
> >
> > +     if (!list->list)
> > +             return;
>
> Could you merge this with the other sanity checks at the start of the fun=
ction.
>
> -       if (!list || list->num_regs =3D=3D 0)
> +       if (!list || !list->list || list->num_regs =3D=3D 0)
That looks better. Will do that in V2 and send it.
> The list->list pointer can't actually be NULL.  It comes from
> guc_capture_get_one_list(), so if the reglists[i].list pointer is NULL it
> returns NULL.  However, obviously checking for NULL after a dereference i=
s not
> the correct so it's worth fixing and probably deserves a Fixes tag.  Alth=
ough it
> doesn't affect runtime, adding a Fixes tag helps backporters know they ca=
n
> automatically ignore this one because the commit it's fixing is very rece=
nt.
>
> regards,
> dan carpenter
>

