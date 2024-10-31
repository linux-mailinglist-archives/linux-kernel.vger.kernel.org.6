Return-Path: <linux-kernel+bounces-390957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 416609B8081
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE45F287889
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A621D1C1AB6;
	Thu, 31 Oct 2024 16:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QMdQCxcC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93821BD027
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 16:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730393134; cv=none; b=l41oG8Ul/zobTa+WeJVIeyjsOVCZzPNb5AQ3Bz/WPDCGvgbScJSYhFLIXZ/noCc3qf4ywebHWb9VjUwq2xUUnHFzVQIY7U4MHyQ3+VCdzOadAglTpgHMBT/ZbK4Up2jh0x0lcUt4/xdJ+Ef1qbm0pyJZuZ/0ItR8q8YPKkuzQ78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730393134; c=relaxed/simple;
	bh=182pqmxJKzOagD+mCIwZct3+5F1kCCVclBMGYB3B2rI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bZ28mUsZwt2yeYHB4so2dK1jfJlBrSiOjH5Dno/N+KMYnIKqm2roB3lbp2mju/kPS4IA4nmv+zc/0rSL/+jeQeicjddXpIz2d6vHKS+3HiB+yQGz5jMnUsZ6eLdNSwA8ObaT60PhCrPxcS1sKboFnhFLUhb/ChN0iWGlaL6VJIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QMdQCxcC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730393130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=182pqmxJKzOagD+mCIwZct3+5F1kCCVclBMGYB3B2rI=;
	b=QMdQCxcCz+li+qDqf2k3Vvp/3LQ96qN4yENUirBhJxWszhRj9S7XJ7HK6y/xqp6zZ1nVV4
	/o3MXHrouNuLBkTO3UkLsvJ7KLcXLjKZ32e9jo9tuTDJ/G2sGTUyr13LEM+fbrBD7KT0CD
	6cZulagzq2Km0kYeiA7hgbMwJnL83tQ=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-qQcL_twXOQSsjkh00XGDfg-1; Thu, 31 Oct 2024 12:45:26 -0400
X-MC-Unique: qQcL_twXOQSsjkh00XGDfg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-539ebb67c28so816729e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 09:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730393125; x=1730997925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=182pqmxJKzOagD+mCIwZct3+5F1kCCVclBMGYB3B2rI=;
        b=BdNVyJY0tYluFDnyBFDvw2nNkzCwg59QGpFuJfLpYMvYkvgUDkgsNiV5R4MmnB/xry
         bpVcgIk+i/cwiD1iUOdMVGHfdDwuCureFsh5mxxeNUo5qlYIeGJE2/tgnRO4gbgKq96G
         GpfxgQgHv6P/lGOcFHCPubdPhueJuxw+98dGChX0YS6Eydzu0pAFt9PC6lyBVipGs63g
         khbjqFtNVnaIy2WCiGSQ8oZAWGqtfZjGNSGPJLvsWh1cbMlnlwYIp8LlxWBVqyFdxGyh
         i6O6BtJ+SY072wiQ+UydAZu9OA62rwtgcS9WBf9smQeYKhSUn/K/QpcXYZNAy8zz8ejw
         4q6w==
X-Forwarded-Encrypted: i=1; AJvYcCVmfSk/ca+UJ5w4nEKmTh4J+4HS8F1ADzfylryJXurHUFyMqOy+oZJwjIVIH5KxygZbhIBvslPqbC7GkAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3I8xpvHrVOWNHsUntlDL0XlxpCydzal1Fq8mJSbUKGOZJim2f
	H77Cko9dUF6CPSRg0K95nVq3ATPJFj9yGEg8/ATD5fwW/rn7JmHMOogOU0gHKWSKU9uEqsfAL6P
	6nPCJqeWdLZZStZtsX74LG+pbaS8AW1Tb1j/0S3CtqXmVOhk77WucNOoLZYnUrw==
X-Received: by 2002:a05:6512:32c8:b0:535:82eb:21d1 with SMTP id 2adb3069b0e04-53d65e1781fmr431490e87.57.1730393125212;
        Thu, 31 Oct 2024 09:45:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHouLo3TF+7LJo+6trZy9gzmL/37JvOLD2BMFURyxuRnX3R17ZHSmy2W/qUwbYYI/LTZymFXg==
X-Received: by 2002:a05:6512:32c8:b0:535:82eb:21d1 with SMTP id 2adb3069b0e04-53d65e1781fmr431467e87.57.1730393124704;
        Thu, 31 Oct 2024 09:45:24 -0700 (PDT)
Received: from localhost ([2a01:e0a:b25:f902::ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d4342sm2618972f8f.32.2024.10.31.09.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 09:45:24 -0700 (PDT)
Date: Thu, 31 Oct 2024 17:45:23 +0100
From: Maxime Ripard <mripard@redhat.com>
To: metux <metux@gmx.de>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: Requirements to merge new heaps in the kernel
Message-ID: <20241031-bouncy-cute-shrimp-cd2530@houat>
References: <20241022-macaw-of-spectacular-joy-8dcefa@houat>
 <35deac48-4220-4889-833d-1b57b417e968@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="e7ghtd5lwxlkxgfh"
Content-Disposition: inline
In-Reply-To: <35deac48-4220-4889-833d-1b57b417e968@gmx.de>


--e7ghtd5lwxlkxgfh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Requirements to merge new heaps in the kernel
MIME-Version: 1.0

On Wed, Oct 30, 2024 at 12:16:22PM +0100, metux wrote:
> On 22.10.24 10:38, Maxime Ripard wrote:
> > I'm still interested in merging a carve-out driver[1], since it seems t=
o be
> > in every vendor BSP and got asked again last week.
> >=20
> > I remember from our discussion that for new heap types to be merged, we
> > needed a kernel use-case. Looking back, I'm not entirely sure how one
> > can provide that given that heaps are essentially facilities for
> > user-space.
>=20
> For those who didn't follow your work, could you please give a short
> intro what's that all about ?
>=20
> If I understand you correctly, you'd like the infrastructure of
> kmalloc() et al for things / memory regions that aren't the usual heap,
> right ?

No, not really. The discussion is about dma-buf heaps. They allow to
allocate buffers suitable for DMA from userspace. It might or might not
=66rom the system memory, at the heap driver discretion.

> What's the practical use case ? GPU memory ? Shared memory between
> nodes in a multi-CPU / cluster machine ?
>=20
> Is it related to NUMA ?

And since it's about DMA, it doesn't have much to do with CPUs either.

Maxime

--e7ghtd5lwxlkxgfh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZyO0HQAKCRAnX84Zoj2+
dsaIAYDSLs4vqC2W23GWmQw+nLt61ihhhwXON5VrB1bS7hVzaX7P2Gu1Vl0ygras
mpk+w40Bf2OSx3W0bmcLT2VATGEiKE8QZJt+N49J3WfSZwJOPvQjXudAGBe5XxGj
WjSuaDPXug==
=PFmP
-----END PGP SIGNATURE-----

--e7ghtd5lwxlkxgfh--


