Return-Path: <linux-kernel+bounces-181354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB1D8C7AE5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1277EB21F0B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A8E1552E2;
	Thu, 16 May 2024 17:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora-corp-partner-google-com.20230601.gappssmtp.com header.i=@collabora-corp-partner-google-com.20230601.gappssmtp.com header.b="fB+Wg10b"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEBD1552E4
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715879538; cv=none; b=HPBBvo+hQh4KFjeHvRu27n32ETPXGRFde8RU7xGVvWZt+/bQFXy7n4Le1AvaLeOlYcKWPBA5Azjq39yg19uAHBPaIkeNfVQ1RdvVdSBMGF/ZzdHHM7yroHbK6wOSpi4/QSLZ6QTzKTeDz+1BfkjxLknRaFeYbsjPfBaTj4xYQmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715879538; c=relaxed/simple;
	bh=HUdyav5OviAMQ2zMn4+YOoE1HFcCofu+H6cerMuIeXw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UtTHI+nyb20mwhVjJD7+raao+B83AnPNPdR7DhNjJitJSwbKw009wPhW2XDImg3q18Gv+X+i84zNNv/7tuIZgUTDQ7qYp6ebVKFDCcdeKFOr6MVJaLbEyAl/5ic7CS5Z/iH3wNC04UNuNJPU62bmf3jut1QskqDxWGvqfV549mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=collabora.corp-partner.google.com; spf=pass smtp.mailfrom=collabora.corp-partner.google.com; dkim=pass (2048-bit key) header.d=collabora-corp-partner-google-com.20230601.gappssmtp.com header.i=@collabora-corp-partner-google-com.20230601.gappssmtp.com header.b=fB+Wg10b; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=collabora.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.corp-partner.google.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6f0ed8bbfadso272570a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=collabora-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1715879535; x=1716484335; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u0/17t6X++w0QQtZwByQd3jr8SxZORqEY89sVsKz7mM=;
        b=fB+Wg10bLvkpHjpmDtVikka23LdzG9NrkeXIowVsdifEHTzvDV6iBAlEHM775ZEZZ9
         tgBz8UEFhaRLyZqXVIimxcvQSsgNX2JqeJ6jLS19KJBIZV1KhLYPwDnv3GjdoBP4Q85M
         m2tTzn0zcnBsyGsVHEFo+4nSgYcX6n1x0MpphHhslgQRB6eGWkahIuRwVNicthJ7UFsx
         Iy7EF6g9C1FI11OzU53z2ow32mAhm7Qoqp/dhoJ3ZFFMNVRoeK+rPaUDBUc/Rdt/PCd3
         lKaOEwtYMTvl4J7VrCm4haErcAtOGbBR0UfcwVyyivoEjQVvtkO/SboX8NjQSQAthp4g
         itbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715879535; x=1716484335;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u0/17t6X++w0QQtZwByQd3jr8SxZORqEY89sVsKz7mM=;
        b=lpgNlabQ/lPBPmVRjqQVLsuvEinDXtM5YSL41PdjMMk8QwU55HUHl+RI0Wx2FaeudN
         3+LaDhl9UVCGOu0chtPEkEBvNht49ffLEp1i35oISs0y/nQVzKg4ecGNsZnoR0Efnlo3
         m+kpJEYBIKbaaJrjcP6C+fIQUeQHSpNAm0xUQkU/DXQioT1iIaePuNqr/dvR7nvpO8QG
         6/taK+cIKEh3uLABX8iMuGPe6kSBmN4PbKboS7EWBjDSCYTVRNfFW9G1JFLRVTML2v/h
         CATblGNbAmizsu0jklG7gKVM5+MRpc4zbxV6HkU9Ybh0rj8tI45ecAa3W/AHGa6bCb6p
         7V2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFApzJEjpIfCkoDPoY1iShq7P27C0dyvhJHtXXHTOtke5j+KNVHt/y271+yTaLKSKP1dnQIRLKrDg9T8fYX6wnfQOq2b1a0zimhK/Z
X-Gm-Message-State: AOJu0YyHlESOIQ70VTUdWf0HqqNZF8BSHl2VT5o5+r/AFyUVXeEQ9gap
	yzX+s/0zF7LZ7brl3vNhwFoY2qRMgOcy1JF22LqnHejhXzPmn0Xpw/tLnENk3g7pEcYHlJrvbHz
	7bxI=
X-Google-Smtp-Source: AGHT+IFGjNt7vUmAZ1Mmz/lw0I88EJ6f5Y9sGe9Wk+60l3/QM4OyhE9pBL3S1dbNkZo8w+6coX8nXA==
X-Received: by 2002:a05:622a:5c8b:b0:43a:4b3c:3a2e with SMTP id d75a77b69052e-43dfdb63e98mr232125181cf.37.1715879513869;
        Thu, 16 May 2024 10:11:53 -0700 (PDT)
Received: from nicolas-tpx395.lan ([2606:6d00:17:5985::580])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43e1fdefc89sm49532381cf.61.2024.05.16.10.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:11:53 -0700 (PDT)
Message-ID: <08b882dd036367c4d78a5b33f5d11cdb347823bb.camel@collabora.corp-partner.google.com>
Subject: Re: Safety of opening up /dev/dma_heap/* to physically present
 users (udev uaccess tag) ?
From: nicolas.dufresne@collabora.corp-partner.google.com
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Maxime Ripard <mripard@redhat.com>, Bryan O'Donoghue
 <bryan.odonoghue@linaro.org>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>,  Hans de Goede <hdegoede@redhat.com>, Sumit
 Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard
 <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
 John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>,
 Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Lennart
 Poettering <mzxreary@0pointer.de>,  Robert Mader
 <robert.mader@collabora.com>, Sebastien Bacher
 <sebastien.bacher@canonical.com>, Linux Media Mailing List
 <linux-media@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>,  linaro-mm-sig@lists.linaro.org, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Milan Zamazal
 <mzamazal@redhat.com>, Andrey Konovalov <andrey.konovalov.ynk@gmail.com>
Date: Thu, 16 May 2024 13:11:51 -0400
In-Reply-To: <20240516112720.GA12714@pendragon.ideasonboard.com>
References: <d2a512b2-e6b1-4675-b406-478074bbbe95@linaro.org>
	 <Zjpmu_Xj6BPdkDPa@phenom.ffwll.local>
	 <20240507183613.GB20390@pendragon.ideasonboard.com>
	 <4f59a9d78662831123cc7e560218fa422e1c5eca.camel@collabora.com>
	 <Zjs5eM-rRoh6WYYu@phenom.ffwll.local>
	 <20240513-heretic-didactic-newt-1d6daf@penduick>
	 <20240513083417.GA18630@pendragon.ideasonboard.com>
	 <c4db22ad94696ed22282bf8dad15088d94ade5d6.camel@collabora.com>
	 <20240514204223.GN32013@pendragon.ideasonboard.com>
	 <a3428b0c352c24d43a2d458d41819fbf4b6cce0f.camel@collabora.corp-partner.google.com>
	 <20240516112720.GA12714@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le jeudi 16 mai 2024 =C3=A0 14:27 +0300, Laurent Pinchart a =C3=A9crit=C2=
=A0:
> Hi Nicolas,
>=20
> On Wed, May 15, 2024 at 01:43:58PM -0400, nicolas.dufresne@collabora.corp=
-partner.google.com wrote:
> > Le mardi 14 mai 2024 =C3=A0 23:42 +0300, Laurent Pinchart a =C3=A9crit=
=C2=A0:
> > > > You'll hit the same limitation as we hit in GStreamer, which is tha=
t KMS driver
> > > > only offer allocation for render buffers and most of them are missi=
ng allocators
> > > > for YUV buffers, even though they can import in these formats. (kms=
 allocators,
> > > > except dumb, which has other issues, are format aware).
> > >=20
> > > My experience on Arm platforms is that the KMS drivers offer allocati=
on
> > > for scanout buffers, not render buffers, and mostly using the dumb
> > > allocator API. If the KMS device can scan out YUV natively, YUV buffe=
r
> > > allocation should be supported. Am I missing something here ?
> >=20
> > There is two APIs, Dumb is the legacy allocation API, only used by disp=
lay
>=20
> Is it legacy only ? I understand the dumb buffers API to be officially
> supported, to allocate scanout buffers suitable for software rendering.
>=20
> > drivers indeed, and the API does not include a pixel format or a modifi=
er. The
> > allocation of YUV buffer has been made through a small hack,=20
> >=20
> >   bpp =3D number of bits per component (of luma plane if multiple plane=
s)
> >   width =3D width
> >   height =3D height * X
> >=20
> > Where X will vary, "3 / 2" is used for 420 subsampling, "2" for 422 and=
 "3" for
> > 444. It is far from idea, requires deep knowledge of each formats in th=
e
> > application
>=20
> I'm not sure I see that as an issue, but our experiences and uses cases
> may vary :-)

Its extra burden, and does not scale to all available pixel formats. My rep=
ly
was for readers education as I feel like a lot of linux-media dev don't hav=
e a
clue of what is going on at the rendering side. This ensure a minimum knowl=
edge
to everyone commenting.

And yes, within the GFX community, Dumb allocation is to be killed and
replacement completely in the future, it simply does not have a complete
replacement yet.

>=20
> > and cannot allocate each planes seperatly.
>=20
> For semi-planar or planar formats, unless I'm mistaken, you can either
> allocate a single buffer and use it with appropriate offsets when
> constructing your framebuffer (with DRM_IOCTL_MODE_ADDFB2), or allocate
> one buffer per plane.

We have use cases were single allocation is undesirable, but I don't really=
 feel
like this is important enough for me to type this explanation. Ping me if y=
ou
care.
>=20
> > The second is to use the driver specific allocation API. This is then a=
bstracted
> > by GBM. This allows allocating render buffers with notably modifiers an=
d/or use
> > cases. But no support for YUV formats or multi-planar formats.
>=20
> GBM is the way to go for render buffers indeed. It has been designed
> with only graphics buffer management use cases in mind, so it's
> unfortunately not an option as a generic allocator, at least in its
> current form.
>=20

What I perhaps should have highlighted that is that all these allocators in=
 the
GFX (called DRM, but meh) subsystem abstract away some deep knowledge of th=
e HW
requirements. Heaps are lower level APIs that assume that userspace have th=
is
knowledge. The Android and ChromeOS solution is to take the implementation =
from
the kernel and move it into userspace, see minigbm from chromeos, or grallo=
c
from Android. As these two projects are device centric, they are not usable=
 on
generic Linux. Heaps might have some future, but not without other piece of=
 the
puzzle.

To come back to you wanting heaps in libcamera, because it makes them bette=
r for
rendered or display. Well today this is a lie you make to yourself, because=
 this
is just a tiny bit of the puzzle, it is pure luck if you allocate dmabuf is
usable but a foreign device. At the end of the day, this is just a fallback=
 to
satisfy that application are not forced to allocate that memory in libcamer=
a.

Thus, I strongly recommend the udmabuf in the short term. Finally, moving t=
o
heaps when the reported issue is resolved, as then it gives more options an=
d
reduce the number of layers.

Nicolas

