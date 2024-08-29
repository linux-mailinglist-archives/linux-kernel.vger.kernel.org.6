Return-Path: <linux-kernel+bounces-307273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07112964B30
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 18:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5AB22862A6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731661B5335;
	Thu, 29 Aug 2024 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0Zzpt1a"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469CD1B4C3C
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 16:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724948001; cv=none; b=O1D0jbifI9+xpdLJAZ7Vos0ChxPu2BTHBp5LsFMKKcN1qthDO5zNouF18B7CklCDaIwaayki50PSyJkq6EHj4VaTHvzV6nyOrTOkAtbgXb0lcJ85l6QxLJYxr3XXWGil/xtG3fPMJJbUsbTuc75mGcQZAFM66CMdFpuAW7u4JFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724948001; c=relaxed/simple;
	bh=dHkC8BQ/oCFG+KGsaHIHKPgYPFJGnB+AcptiQKVOpA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ffw2jOwirtX4W8ND/4eDKMQrTz3GCBPOtD8p6b4Xktx3kwq+wsGFXFhMVg7IcWZPt2yOVnhdW9RLGkZh8toviGFVThBwxuDDbQUlITUgpvK+pp4akjA/X1Y3ZdKhqkCt5V+xl+L92bGPCONZAkdrfwiryI12WCOJs49uLvjueTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U0Zzpt1a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724947999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gjf9lEYKxo79UOeU1ud431sTBQCGkwHKYo7rx3w8B+0=;
	b=U0Zzpt1a/ckGr3cxQIgvHlz70H0WsVpN5yONsCbEuKaEGXvY2l6Lylz5xAq00x2jNBMcx4
	x5iWoZQf8FTdQ7HrU0C9M6okNUP3MWi1d7WnFsUzVKKazrNNtNhKQFxbNVHw/2FIT+8yRS
	QSzlSwaIDoPPUzQjpFyzmwbVCzxDhNs=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-dNYuBDXVPnGnGdP2lhed4Q-1; Thu, 29 Aug 2024 12:13:16 -0400
X-MC-Unique: dNYuBDXVPnGnGdP2lhed4Q-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3dee94f0dcdso888785b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 09:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724947996; x=1725552796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gjf9lEYKxo79UOeU1ud431sTBQCGkwHKYo7rx3w8B+0=;
        b=Hkr1nJS/Ue99bZbRdhhRj1BJH2SQOEY4waE3mTPsuvI7NzrisyrmpU4IT4riImu9cv
         leBUE0dRaY2EJ1TaEpHC/BvqOibgd753/4npEqQWqpmZvZwppEC19+Ga1mzizqvsp5H6
         dQ0CmWwIjndMiH/sh7fShNEXDDZYxUcSURYQR0FXdvXgX/rzzhD9yBJ+tP+TEmt+dU2X
         OXJD2AMnCEOC/16AwMabryoZrMP6VllVpwpESTrBfSFgqx958Fgz57bwoJzXeNBAYtn6
         G39YxvmS8XHf+RMXrwu0H+k2N90vFf2o8OksxvRXC/JWZwY7Zn6+ZwjUGh8VHDNdGjHh
         R6Ig==
X-Forwarded-Encrypted: i=1; AJvYcCU6q48WJL9M+kQdcpENPo8UUA34rjKS0rcng6CtJc16VuXYElHSmsm1BKxW4qIH18y3xMjM7mPykMmtCrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YykTGEiDXVSUx+eu3Zh8XQarl4AxHqI8sEnFgGK+Wm/03+/3RKD
	XpG9Yk9vg0i2ANeUy3r9KQ9kRL2WYCdIPwCTagaeu/v3BzDWP5ZL6SqqAtiYB41xyO/vjt6sEZn
	TD+y+hU9mJDdpajsTrhgZ7I8UaU3gM0munVMGvY318QprcqS4gK07mD/HDw003A3K8IOjiUffD9
	TouuYDsJiFOA7Bkl1G5sibpJD30Ke6WLrODWDc
X-Received: by 2002:a05:6808:158c:b0:3d9:b33e:d3c7 with SMTP id 5614622812f47-3df05c46699mr3393136b6e.5.1724947995777;
        Thu, 29 Aug 2024 09:13:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEp2WvBJh6ce6etsdNcPyEsUAS6R8viWHcvInnOKhT3fldRVCreceAGksb536DXzOLO4wV5wrO3yDa/aIrEbnw=
X-Received: by 2002:a05:6808:158c:b0:3d9:b33e:d3c7 with SMTP id
 5614622812f47-3df05c46699mr3393107b6e.5.1724947995414; Thu, 29 Aug 2024
 09:13:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240829012005.382715-1-bmasney@redhat.com> <20240829012005.382715-3-bmasney@redhat.com>
 <20240829155829.GA6489@eaf>
In-Reply-To: <20240829155829.GA6489@eaf>
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 29 Aug 2024 12:13:03 -0400
Message-ID: <CABx5tqKJ9Swc3dF3wG46BUL9-zDpVNyqXLeuA92kOZCbNU_wCA@mail.gmail.com>
Subject: Re: [PATCH 2/2] crypto: qcom-rng: fix support for ACPI-based systems
To: =?UTF-8?Q?Ernesto_A=2E_Fern=C3=A1ndez?= <ernesto.mnd.fernandez@gmail.com>
Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>, herbert@gondor.apana.org.au, 
	davem@davemloft.net, quic_omprsing@quicinc.com, neil.armstrong@linaro.org, 
	quic_bjorande@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 11:58=E2=80=AFAM Ernesto A. Fern=C3=A1ndez
<ernesto.mnd.fernandez@gmail.com> wrote:
> thanks for the patch. I have one doubt:
>
> On Wed, Aug 28, 2024 at 09:20:05PM -0400, Brian Masney wrote:
> > The qcom-rng driver supports both ACPI and device tree based systems.
> > ACPI support was broken when the hw_random interface support was added.
> > Let's go ahead and fix this by checking has_acpi_companion().
> >
> > This fix was boot tested on a Qualcomm Amberwing server.
> >
> > Fixes: f29cd5bb64c2 ("crypto: qcom-rng - Add hw_random interface suppor=
t")
> > Signed-off-by: Brian Masney <bmasney@redhat.com>
> > ---
> >  drivers/crypto/qcom-rng.c | 36 ++++++++++++++++++++----------------
> >  1 file changed, 20 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/crypto/qcom-rng.c b/drivers/crypto/qcom-rng.c
> > index 4ed545001b77..470062cb258c 100644
> > --- a/drivers/crypto/qcom-rng.c
> > +++ b/drivers/crypto/qcom-rng.c
> > @@ -176,6 +176,21 @@ static struct rng_alg qcom_rng_alg =3D {
> >       }
> >  };
> >
> > +static struct qcom_rng_match_data qcom_prng_match_data =3D {
> > +     .skip_init =3D false,
>
> So with acpi, skip_init will be set to false now, right? But before
> f29cd5bb64c2 broke it, skip_init used to be set to true. Was that wrong
> before, or now?

Good catch! I didn't check the _DSD and assumed it was always false.
I'll verify on the server we have in the lab and post a v2.

Brian


