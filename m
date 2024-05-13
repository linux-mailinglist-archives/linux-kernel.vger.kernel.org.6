Return-Path: <linux-kernel+bounces-177350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C18C58C3D5D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 10:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76937281F90
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9BE147C7F;
	Mon, 13 May 2024 08:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QDwC38E3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A658F4D9F2
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 08:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715589289; cv=none; b=cxSbt6sguUpUt9+M+Z2huVLfZUc8rtjbcRlI14w2FU9mJVKMijuRLDP18PqyApGE2+8wHW2vao5cFrP9si3vcrQL/hwIFk0NhSKiiqJK2lhlg+8s/nEwvZCrPLHBPfO3n0KuyLHumWmle6ST3j2KhifDBBsQNg+emU6oig5gF3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715589289; c=relaxed/simple;
	bh=ACGTg+jqwLvGd3uIYLEqlsb3DEYNKvz+FsT7qMFK+3A=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3vw6nrKwIqQyyrlWOBlCwZaY5bZXRemcraDF4O609tFboGDDKfWNOcrvn0xv4sQa+2Iiv1K76vhIWuHl0euO9yC94KoeeD1Cc11DtsXAmuZNaUj5B4xVDJWVJeULXvCWABt+hUQT7LGi9vdeJZAO58yhJ42LAEZ4FCe5GMgxiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QDwC38E3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715589286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ACGTg+jqwLvGd3uIYLEqlsb3DEYNKvz+FsT7qMFK+3A=;
	b=QDwC38E3DcNjIzhO+oEy09Xx73oUjHrj4J6KqfYhFKQhRqrSIDKCc1uVTSzxID+cXGfAxU
	uVxTVj5hzaWdmNveXyzG1AdBh/0vV2OuC5X+7qWRXLciaZS+Kw43mQpdKtm9FsrX0AazD5
	7b8grLB+wuMgNszif/ZlQVML8iJXqnk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-GM1ieEeQOFK2nxsM74_bcA-1; Mon, 13 May 2024 04:29:35 -0400
X-MC-Unique: GM1ieEeQOFK2nxsM74_bcA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-34deefe9142so2606062f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 01:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715588974; x=1716193774;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACGTg+jqwLvGd3uIYLEqlsb3DEYNKvz+FsT7qMFK+3A=;
        b=dwU1UIzCKQQZcs9SAv7rIcwsWuNN5uLndZ4UMFafkII7aYZGYKasON0M8S/O3nZeSY
         4DcoAdvMdN8D4tyYOJq58tK3pRupwGIWmGVxbOYd2oXm7ESWsk9zm/xQQo2wrI9yW3M1
         +YGbScrRxYlg6qubXU9lYy4gJdO6PSDbZpOycAt2CL6kl0kYkT/h9JPNhl687UPxHt7D
         T1GQG/4nYK8cT3QSoDbpwy/0f+bqfQNjDf/gp6NVrNeU7aphtCZ/hIr1j+Z/fCctFjb1
         F+iOcQS715vmlrJ1leO7zc6L+8krnf1+svi3rnXwQVz2RetYWPhUOwi7v+a6S1/TbVxV
         f9jQ==
X-Forwarded-Encrypted: i=1; AJvYcCXP+FjXM59WPnxiF0HUnsJfYO4VVfMVsA234dsygqoAwQGBlQcwd6ofN4oqCKmiJQHWSBaP4iYeka3DUrhDUqU1G5DJDe2noSkqgdw/
X-Gm-Message-State: AOJu0YySPNfSG08oZKmXCzqACtOPyFkM0g4kWcGVpK+4Sel9ivTOO6uZ
	Jil/pOseGkTAXDAQjP/PuFbU6EDDN00P1xd5NxV4JEq77vGabK3pmms8G+tuKkGYhQfcNv+VGlR
	AGETjSLxhpBBFPZnbwGdF2s+l2vdrJml5D7RqH0QChwspGemE1Kt1BFIYFnNNjw==
X-Received: by 2002:a5d:444b:0:b0:34e:4cc2:7015 with SMTP id ffacd0b85a97d-3504a73bc06mr5553399f8f.31.1715588974253;
        Mon, 13 May 2024 01:29:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvlr1r3nrAIBq+G7ChUWvWgw+OvWO5SlmWK/Uy2RAOomeNeCf7DAAnSfqycFznvhJ7OQM6xQ==
X-Received: by 2002:a5d:444b:0:b0:34e:4cc2:7015 with SMTP id ffacd0b85a97d-3504a73bc06mr5553375f8f.31.1715588973707;
        Mon, 13 May 2024 01:29:33 -0700 (PDT)
Received: from localhost ([193.32.126.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a789asm10513081f8f.51.2024.05.13.01.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 01:29:33 -0700 (PDT)
Date: Mon, 13 May 2024 10:29:22 +0200
From: Maxime Ripard <mripard@redhat.com>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Hans de Goede <hdegoede@redhat.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
	Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
	"T.J. Mercier" <tjmercier@google.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Lennart Poettering <mzxreary@0pointer.de>, Robert Mader <robert.mader@collabora.com>, 
	Sebastien Bacher <sebastien.bacher@canonical.com>, Linux Media Mailing List <linux-media@vger.kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, linaro-mm-sig@lists.linaro.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Milan Zamazal <mzamazal@redhat.com>, 
	Andrey Konovalov <andrey.konovalov.ynk@gmail.com>
Subject: Re: Safety of opening up /dev/dma_heap/* to physically present users
 (udev uaccess tag) ?
Message-ID: <20240513-heretic-didactic-newt-1d6daf@penduick>
References: <bb372250-e8b8-4458-bc99-dd8365b06991@redhat.com>
 <ojduxo54lpcbfg2wfuhqhy7k3phncamtklh65z7gvttcwztmhk@zkifewcy4ovi>
 <3c0c7e7e-1530-411b-b7a4-9f13e0ff1f9e@redhat.com>
 <e7ilwp3vc32xze3iu2ejgqlgz44codsktnvyiufjhuf2zxcnnf@tnwzgzoxvbg2>
 <d2a512b2-e6b1-4675-b406-478074bbbe95@linaro.org>
 <Zjpmu_Xj6BPdkDPa@phenom.ffwll.local>
 <20240507183613.GB20390@pendragon.ideasonboard.com>
 <4f59a9d78662831123cc7e560218fa422e1c5eca.camel@collabora.com>
 <Zjs5eM-rRoh6WYYu@phenom.ffwll.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="uitctc2p333ggqzy"
Content-Disposition: inline
In-Reply-To: <Zjs5eM-rRoh6WYYu@phenom.ffwll.local>


--uitctc2p333ggqzy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2024 at 10:36:08AM +0200, Daniel Vetter wrote:
> On Tue, May 07, 2024 at 04:07:39PM -0400, Nicolas Dufresne wrote:
> > Hi,
> >=20
> > Le mardi 07 mai 2024 =E0 21:36 +0300, Laurent Pinchart a =E9crit=A0:
> > > Shorter term, we have a problem to solve, and the best option we have
> > > found so far is to rely on dma-buf heaps as a backend for the frame
> > > buffer allocatro helper in libcamera for the use case described above.
> > > This won't work in 100% of the cases, clearly. It's a stop-gap measure
> > > until we can do better.
> >=20
> > Considering the security concerned raised on this thread with dmabuf he=
ap
> > allocation not be restricted by quotas, you'd get what you want quickly=
 with
> > memfd + udmabuf instead (which is accounted already).
> >=20
> > It was raised that distro don't enable udmabuf, but as stated there by =
Hans, in
> > any cases distro needs to take action to make the softISP works. This
> > alternative is easy and does not interfere in anyway with your future p=
lan or
> > the libcamera API. You could even have both dmabuf heap (for Raspbian) =
and the
> > safer memfd+udmabuf for the distro with security concerns.
> >=20
> > And for the long term plan, we can certainly get closer by fixing that =
issue
> > with accounting. This issue also applied to v4l2 io-ops, so it would be=
 nice to
> > find common set of helpers to fix these exporters.
>=20
> Yeah if this is just for softisp, then memfd + udmabuf is also what I was
> about to suggest. Not just as a stopgap, but as the real official thing.
>=20
> udmabuf does kinda allow you to pin memory, but we can easily fix that by
> adding the right accounting and then either let mlock rlimits or cgroups
> kernel memory limits enforce good behavior.

I think the main drawback with memfd is that it'll be broken for devices
without an IOMMU, and while you said that it's uncommon for GPUs, it's
definitely not for codecs and display engines.

Maxime

--uitctc2p333ggqzy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZkHPWQAKCRAnX84Zoj2+
duxcAX0X7gUdYVGGk8sIw/t/75URUn2L5jsx1bztYmSAMrIPZpJ7dy/qcltWYmgI
q0DvusYBf1GwSIDpuk/d4mHAtHlq5OHKP4OPgGrWsyOdD3IsotlmEl1GTuBDF6Eq
cHFRahQOCA==
=o8us
-----END PGP SIGNATURE-----

--uitctc2p333ggqzy--


