Return-Path: <linux-kernel+bounces-413165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BFF9D14AD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41E63B266B6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9130C196C7C;
	Mon, 18 Nov 2024 15:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLstS+Xq"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67B41863F;
	Mon, 18 Nov 2024 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731943592; cv=none; b=a/aheXUodOAk8EWx+WbarrdYS8KBavUmXQfyl5ZvmvWTFkcp7eQ4FyvOjxP5XusWtOkBgB6LVENjZufiF8lwEiKuNqYtRW3awrfTyDlMqw/oW9z0DKkTFHjeGXDeVWpLpPvp0leAEaztfuNGwZw399CGnqQvQ6kTYkpmuBkskqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731943592; c=relaxed/simple;
	bh=mEqBzDik5b80IK5VbC+h4r2kXN/x63z5e8pMZHOi2bw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QgK+JTvhn3z+zvkZEcxdhT4az2FuvdUflLzB1WTP+E1lPxLSx2CKK0sSUx7LwY8IRXbyFT+KXr5y8dtjGo2DtMs0eeSSaI8BgtY6kW89sDYcYIVd0vwdXGTwO/UqXUgY4wLUTwomVSzloMvIbLYBljCvNwyT6pw5DdfA5cKBTjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLstS+Xq; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ea93311724so82773a91.2;
        Mon, 18 Nov 2024 07:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731943590; x=1732548390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxLNPkkdLQbSGAjECvY64z6azuuyEaYCFq24xqUSCNA=;
        b=jLstS+XqTAxV/I/Xi+cv6We3g5CDQqlaUecCEd0y/3n95mtY/lwUkof2i/TxTr6lGn
         7KgRu6DVCzm8mV/GzMchcDxas/2t5KfynWg5v4RuhGUEbc734YUQ/dW/NszlNDFLFDXs
         iVZsGlyFDS2h+vBfsASluv0L7L/ZKmBOHAYV9ri1CAmLCZMosrM/sC1dvBW7M1isb9QC
         OCKjm2qaJgd4Uwq1E9Aic9XF2Vnh//eeS9fQ0n/4HEa2U9458x3UqeRulQKA3NxfOnaz
         FcjmE/mmRp5JZg/Nkp6NicgR+AL1hMW+2SSxaqqCNKxodb/UGjYUeAKcF/5qEaincKDB
         wg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731943590; x=1732548390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxLNPkkdLQbSGAjECvY64z6azuuyEaYCFq24xqUSCNA=;
        b=GbkjqeaT+Rycf2h1YK8J23Rv/q0LFtAlMD3CSBTRZ5GLiul71M9MWimWJ4MbSJIIBn
         NAUwCBZmB2A2C3RGVRWmGFqRrLCBAe+t4iCZ6KbKmxbKGJOvJCOvIvYPMJyT7mCdhQ0d
         a9PmKC/rA28a8S9VqcSwEIR5BcCzT2SX/vXCypfjVJDdLeNSgtsz9gpn1XXt25tLa5PM
         /2duWALstbhaU/8qQ8xYWaMRUGfg6t2irDcqBus/Y/qDzUvo5G+DqhjhwB7sdMkt4Bel
         MV/lYXai+KHfLwYyWTVKVL3zB4SK+hwOhhLFW08DejYqo0hdi02e7otdhAqwGqZefo3A
         KKDw==
X-Forwarded-Encrypted: i=1; AJvYcCUOKIvzQmLzlH+fEH68ulcN5igs4DalUTudJPOIsefdTz1gPeaZ0nq0+r+NOKngGYocjd21hOCnwf5r0sxB5bg=@vger.kernel.org, AJvYcCUfwbef9bkdvr2h3l7mK/Hmv3j+oi4uheS67LCxwU6pqZd+oSKprLru28uMkLpV3gQKsEgSOUTyXHPcLyhW@vger.kernel.org
X-Gm-Message-State: AOJu0YzFJDNJIFPN9j5iU9edLhii6+NgjTm1k/liEf0q6bC319t3VBrp
	GUR8L79IsYvV3htVT8bUYqxy+UeLP/sRr7StszOANtCiTM528REEi9q/wTpsomKJen/VMS627sX
	o8aWvbhJGbHDu8CdMmycpIB6MwnM=
X-Google-Smtp-Source: AGHT+IHk+nsIvISW+3hBwejGBc/PZwCBrs22kLEHGbh9RYjj0wMdgfHvqHkteLWeoPI3OUMObMfh4V2KUB4Wd4l6Ndo=
X-Received: by 2002:a17:90b:5187:b0:2ea:3ab5:cb83 with SMTP id
 98e67ed59e1d1-2ea3ab5cee6mr4404015a91.9.1731943589858; Mon, 18 Nov 2024
 07:26:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <039846c0278276e7c652395730f36051216fd4c3.1731691556.git.christophe.jaillet@wanadoo.fr>
 <acd637f7-a1ce-443b-8d05-d285c28cea7d@amd.com>
In-Reply-To: <acd637f7-a1ce-443b-8d05-d285c28cea7d@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Nov 2024 10:26:18 -0500
Message-ID: <CADnq5_NLObja=ctv60w3uhx1yf-bZTUhR2VvtT=aUkaG4SXOUg@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Constify struct pci_device_id
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, linux@weissschuh.net, broonie@kernel.org, 
	lee@kernel.org, Alex Deucher <alexander.deucher@amd.com>, Xinhui Pan <Xinhui.Pan@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

Alex

On Mon, Nov 18, 2024 at 6:25=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 15.11.24 um 18:26 schrieb Christophe JAILLET:
> > 'struct pci_device_id' is not modified in this driver.
> >
> > Constifying this structure moves some data to a read-only section, so
> > increase overall security.
> >
> > On a x86_64, with allmodconfig:
> > Before:
> > =3D=3D=3D=3D=3D=3D
> >     text         data     bss     dec     hex filename
> >    11984        28672      44   40700    9efc drivers/gpu/drm/radeon/ra=
deon_drv.o
> >
> > After:
> > =3D=3D=3D=3D=3D
> >     text         data     bss     dec     hex filename
> >    40000          664      44   40708    9f04 drivers/gpu/drm/radeon/ra=
deon_drv.o
>
> Mhm that's a bit more than "some data" :)
>
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> > Compile tested-only.
> > ---
> >   drivers/gpu/drm/radeon/radeon_drv.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/rade=
on/radeon_drv.c
> > index 23d6d1a2586d..5e958cc223f4 100644
> > --- a/drivers/gpu/drm/radeon/radeon_drv.c
> > +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> > @@ -248,10 +248,9 @@ int radeon_cik_support =3D 1;
> >   MODULE_PARM_DESC(cik_support, "CIK support (1 =3D enabled (default), =
0 =3D disabled)");
> >   module_param_named(cik_support, radeon_cik_support, int, 0444);
> >
> > -static struct pci_device_id pciidlist[] =3D {
> > +static const struct pci_device_id pciidlist[] =3D {
> >       radeon_PCI_IDS
> >   };
> > -
> >   MODULE_DEVICE_TABLE(pci, pciidlist);
> >
> >   static const struct drm_driver kms_driver;
>

