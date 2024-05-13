Return-Path: <linux-kernel+bounces-177658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EFE8C428F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CD071F222FF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 13:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9E0153581;
	Mon, 13 May 2024 13:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W1LcqVFD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6A91E497
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715608342; cv=none; b=GO2fzAeFY3s9jGvSPSr2NUby7iCIo3cgn90rdK9F8pqHXE1Q860MYoHs82tMrZHvbtn2AxJyru+BVPTNXJrYvJhDFXYwyvM3cup8W6sbpbvjG2da5wSebUcTg8mS+pPJ+1llFclnbqjOQwxMNA7Rc6qQzsuDKYu+7wcaXKDvhKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715608342; c=relaxed/simple;
	bh=6xbXeK6RMkAiWLJ1gsVT9jtjs/k/mcsJH+bQu2pNTS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqtm8EIc1uf4A0tmJDMMB7rJzFnPTq45I/WocTTWk8e0s6okHPlhLkZ5PinbdHhjw79DIjgsvQSx2LHpncmrOFPyXhaHUtwn3kNkSfY4I9Tep6yjOajzkJ5/hLPeBN8+3Dp2HgsqwdhaUNrKkMEBQaIEc5KFXZbsLcfCvY7g5e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W1LcqVFD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715608340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6xbXeK6RMkAiWLJ1gsVT9jtjs/k/mcsJH+bQu2pNTS4=;
	b=W1LcqVFDKazPVnrTtVp9eMI4tlZjtMGVrnb/00Grkx7rJL5MGogwaRI1Bkn20dwEtntB/K
	jm9+fU2rPXC91x4DxquE1mpykDx0S2GhwnzjlRmt3pwYRzxrYs1k2n8419MkAZ7bMwhN5y
	xh5sJ6mag6cO2PfXQ+HyXeFPoR7dgKc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-H6NV8-XBNbSyepU5OmLFSQ-1; Mon, 13 May 2024 09:51:42 -0400
X-MC-Unique: H6NV8-XBNbSyepU5OmLFSQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-41dc9c831acso25558085e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 06:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715608301; x=1716213101;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xbXeK6RMkAiWLJ1gsVT9jtjs/k/mcsJH+bQu2pNTS4=;
        b=FUZEQBrRfH3v30p+eUrqvydB2RX94EQCUiux2WEhjYTDk5mm3rvodY3KwFOmRJ7q8e
         i/hWL6JDsGnPd6Nse7ruIVHUEOyeYkr3Mx7c2KhxHULT4KwG4WJls9idoBN1vyjQB9yP
         a0JTim3oaAkIZIjy4ZynIUHJQux5YQ78E9zVzOFGi21GVSCGiomqv/Uaf9vsuHx9R7nS
         lFrBX48ZnhtpkkmeUwpVu32Uw3O/h2/nAB36JMMR9MAMyNjGyHaghZWooykfWBT319BZ
         yC5shKDQ8ewYY0FGzBupyZV1wv/EAOajpVrkXd1OS7pO4MOLHAM2VghRmGjv3GYJbKTs
         RmbQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3UeZqw0jkfj5L7/LG7XZlRX79B22wyNda5MlUj5QcPNZU1avJuZSJbpFFO3VHjzuQnrcRji1lSUm5pfhrhmMjVHe+UKw3o+rTY0eI
X-Gm-Message-State: AOJu0Yx6b2H+32K7MHK7d3ipRsEovS1AlOT2Nd6cmEGBrgNXFgX40oSg
	AcJ9Oir9QMfjibmHpGDpQ3UxaGuWNe3X0GtALxdqXcdaNazNFwjikUe8gT+oj5s2cPeNsnvNaKa
	92H7O+dzAboqKDkpbNRh1iWBuhpoOaLjGXNL/3fiBTR63stoh93/Oo2LqSxk31g==
X-Received: by 2002:a05:600c:4503:b0:41c:66:18c2 with SMTP id 5b1f17b1804b1-41fbc91f1admr118093525e9.4.1715608301605;
        Mon, 13 May 2024 06:51:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3xt0Nsv8kn1RExic6bD1rD9MWPXMCfQ+2DAexnAADlqxarPZXZC/0v7zIJ1i6X5T3B+TnhA==
X-Received: by 2002:a05:600c:4503:b0:41c:66:18c2 with SMTP id 5b1f17b1804b1-41fbc91f1admr118093145e9.4.1715608301052;
        Mon, 13 May 2024 06:51:41 -0700 (PDT)
Received: from localhost ([193.32.126.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f882086f0sm194441255e9.42.2024.05.13.06.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 06:51:40 -0700 (PDT)
Date: Mon, 13 May 2024 15:51:39 +0200
From: Maxime Ripard <mripard@redhat.com>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Hans de Goede <hdegoede@redhat.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, Lennart Poettering <mzxreary@0pointer.de>, 
	Robert Mader <robert.mader@collabora.com>, Sebastien Bacher <sebastien.bacher@canonical.com>, 
	Linux Media Mailing List <linux-media@vger.kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, linaro-mm-sig@lists.linaro.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Milan Zamazal <mzamazal@redhat.com>, 
	Andrey Konovalov <andrey.konovalov.ynk@gmail.com>
Subject: Re: Safety of opening up /dev/dma_heap/* to physically present users
 (udev uaccess tag) ?
Message-ID: <20240513-auspicious-toucanet-from-heaven-f313af@penduick>
References: <ojduxo54lpcbfg2wfuhqhy7k3phncamtklh65z7gvttcwztmhk@zkifewcy4ovi>
 <3c0c7e7e-1530-411b-b7a4-9f13e0ff1f9e@redhat.com>
 <e7ilwp3vc32xze3iu2ejgqlgz44codsktnvyiufjhuf2zxcnnf@tnwzgzoxvbg2>
 <d2a512b2-e6b1-4675-b406-478074bbbe95@linaro.org>
 <Zjpmu_Xj6BPdkDPa@phenom.ffwll.local>
 <20240507183613.GB20390@pendragon.ideasonboard.com>
 <4f59a9d78662831123cc7e560218fa422e1c5eca.camel@collabora.com>
 <Zjs5eM-rRoh6WYYu@phenom.ffwll.local>
 <20240513-heretic-didactic-newt-1d6daf@penduick>
 <dacacb862275cd7a588c5fcc56fd6c1d85538d12.camel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="gfnnlgwuvedaduhe"
Content-Disposition: inline
In-Reply-To: <dacacb862275cd7a588c5fcc56fd6c1d85538d12.camel@collabora.com>


--gfnnlgwuvedaduhe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 13, 2024 at 09:42:00AM -0400, Nicolas Dufresne wrote:
> Le lundi 13 mai 2024 =E0 10:29 +0200, Maxime Ripard a =E9crit=A0:
> > On Wed, May 08, 2024 at 10:36:08AM +0200, Daniel Vetter wrote:
> > > On Tue, May 07, 2024 at 04:07:39PM -0400, Nicolas Dufresne wrote:
> > > > Hi,
> > > >=20
> > > > Le mardi 07 mai 2024 =E0 21:36 +0300, Laurent Pinchart a =E9crit=A0:
> > > > > Shorter term, we have a problem to solve, and the best option we =
have
> > > > > found so far is to rely on dma-buf heaps as a backend for the fra=
me
> > > > > buffer allocatro helper in libcamera for the use case described a=
bove.
> > > > > This won't work in 100% of the cases, clearly. It's a stop-gap me=
asure
> > > > > until we can do better.
> > > >=20
> > > > Considering the security concerned raised on this thread with dmabu=
f heap
> > > > allocation not be restricted by quotas, you'd get what you want qui=
ckly with
> > > > memfd + udmabuf instead (which is accounted already).
> > > >=20
> > > > It was raised that distro don't enable udmabuf, but as stated there=
 by Hans, in
> > > > any cases distro needs to take action to make the softISP works. Th=
is
> > > > alternative is easy and does not interfere in anyway with your futu=
re plan or
> > > > the libcamera API. You could even have both dmabuf heap (for Raspbi=
an) and the
> > > > safer memfd+udmabuf for the distro with security concerns.
> > > >=20
> > > > And for the long term plan, we can certainly get closer by fixing t=
hat issue
> > > > with accounting. This issue also applied to v4l2 io-ops, so it woul=
d be nice to
> > > > find common set of helpers to fix these exporters.
> > >=20
> > > Yeah if this is just for softisp, then memfd + udmabuf is also what I=
 was
> > > about to suggest. Not just as a stopgap, but as the real official thi=
ng.
> > >=20
> > > udmabuf does kinda allow you to pin memory, but we can easily fix tha=
t by
> > > adding the right accounting and then either let mlock rlimits or cgro=
ups
> > > kernel memory limits enforce good behavior.
> >=20
> > I think the main drawback with memfd is that it'll be broken for devices
> > without an IOMMU, and while you said that it's uncommon for GPUs, it's
> > definitely not for codecs and display engines.
>=20
> In the context of libcamera, the allocation and the alignment done to the=
 video
> frame is done completely blindly. In that context, there is a lot more th=
en just
> the allocation type that can go wrong and will lead to a memory copy. The=
 upside
> of memfd, is that the read cache will help speeding up the copies if they=
 are
> needed.

dma-heaps provide cacheable buffers too...

> Another important point is that this is only used if the application have=
n't
> provided frames. If your embedded application is non-generic, and you have
> permissions to access the right heap, the application can solve your spec=
ific
> issue. But in the generic Linux space, Linux kernel API are just insuffic=
ient
> for the "just work" scenario.

=2E.. but they also provide semantics around the memory buffers that no
other allocation API do. There's at least the mediatek secure playback
series and another one that I've started to work on to allocate ECC
protected or unprotected buffers that are just the right use case for
the heaps, and the target frameworks aren't.

Maxime

--gfnnlgwuvedaduhe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZkIa5gAKCRAnX84Zoj2+
dlyqAYCoIdBhaiIupDGiDmVKfDEt9/cV9y3QuHwExzzz+odc08XxanpDLhC/4cIf
FcJLcccBfRYAupswMulv42u8OROCchpyREa3PpDTjkFm96zW5Xc+YaZZSPXMbb1J
KrUsUpNdZg==
=LHgA
-----END PGP SIGNATURE-----

--gfnnlgwuvedaduhe--


