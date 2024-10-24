Return-Path: <linux-kernel+bounces-379867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EC99AE544
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36F38B21841
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410E01D5AD7;
	Thu, 24 Oct 2024 12:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fcX8ocp5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2971D2207
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 12:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729773843; cv=none; b=T00aF1Ece7hxXDoIu5D+ENUETdzeOcQowvbrrJV/HOg7igWPXwdU3IoM4OukuJw5nPtMUF1I0sWY4kZErqPDmf+38L8sPQHZD8aMmYK8TaB0gCZfl5w+HFKh9g5Q3rljPYbCeybtFiunno7KkFnx8hqLS+xtIrC5jQeAh/2hUH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729773843; c=relaxed/simple;
	bh=soTVn8jOTtJo/F47kpcNgbF25y0oIJ4WelERMykKhFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CeBDD/AzG1VG/fTMEtGgVLBujw7iZTwVFhjRk+eZ95oDK/NADDj0QGjVH/3rXr+xMVB2uiybfzFM79EMTug6cPbmVMYev6KiHD24Ki3XGHGHQqhyAKwcjDnUU32kehM0gQCfQBKr4EATjgBvzWUDjkzlWA5kZZH7vrOL0dCM+wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fcX8ocp5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729773839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=soTVn8jOTtJo/F47kpcNgbF25y0oIJ4WelERMykKhFc=;
	b=fcX8ocp5AZuWsTyy7Jb3ssfxtlp5OQHk9F9qmUJ9chAZtyPSlWqsDeKEw4XO+yxZWR3SeF
	gomLwvzVOoAutoxAeiuUYG2fSR7TUz5008SYs8UUZLXn4xVwi0V+QDoDF8KE0JNgPYwHYh
	mOuSUZZbIrvzYakxoGJrQp/65tHmQCE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-ZeefnHbtMMihpRp2bvv7IA-1; Thu, 24 Oct 2024 08:43:57 -0400
X-MC-Unique: ZeefnHbtMMihpRp2bvv7IA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d4854fa0eso476435f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 05:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729773836; x=1730378636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soTVn8jOTtJo/F47kpcNgbF25y0oIJ4WelERMykKhFc=;
        b=NY5ukjqNQld3j71OG4DJzoSk1xgbQxFX142tBQ6B06+mOT9wIQ4/LfJEmikfySNKop
         XvXNHzzKJ6ApU4WTcUJmT5FGkKHiwI4D457lMb15dX7XpH3KRGaE9AlxQJXbaxCehQ6/
         sosxDRCCWny1hwUBWhZhPd8G4kaLmCFdTd4n3wMGHpFR/UT3g+TxuFvoEkKSZL5bpnbq
         AOspA8ip3Xdx7wWdS315Ts4LwILzhmA6Vqt9AwQrqbYS1qfe3QzEJO4chlgh5Cum9KAq
         trk+MSXGkLRNfODhToIIVB0L/vBBJetcuByKxrY3hrwriAyE9cY2sdBEIg9iSYHGDGzm
         or8w==
X-Forwarded-Encrypted: i=1; AJvYcCVwvnQ64fTC+Zwekv8fLkEKSMiFyxNcGZXjM7bkYwB6t3BKAtENgAFAaHGlhhk4hQ7kIifsUJFeH4Jxkh0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7ttdqWod+3mD6+v+PCOOxC3Z1b22nVgYCTIcfJsa54q1Vr2Go
	xZq1dH+GQP35e89zDgUPVtm/SGPnwqhZTUh9LJewSeUcI5082P8sNqNTQ9T3pGWv7J6IG8hRnYK
	xaxSZDNHn9sQVzFWbtMdJ0kwmZnHev+zp6BXmQB27wn91Iy86naICn33jsK/GgA==
X-Received: by 2002:a5d:4142:0:b0:37d:45c3:3459 with SMTP id ffacd0b85a97d-38045868631mr1406153f8f.21.1729773836516;
        Thu, 24 Oct 2024 05:43:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVbvOG1PHT58hTHz0WF2cadGoIHw+bWT3MYYe4Dm2aD5pRMmMvuOzcSo+7YMei1rplLxREbQ==
X-Received: by 2002:a5d:4142:0:b0:37d:45c3:3459 with SMTP id ffacd0b85a97d-38045868631mr1406134f8f.21.1729773836026;
        Thu, 24 Oct 2024 05:43:56 -0700 (PDT)
Received: from localhost ([2a01:e0a:b25:f902::ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a47caesm11160337f8f.28.2024.10.24.05.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 05:43:55 -0700 (PDT)
Date: Thu, 24 Oct 2024 14:43:54 +0200
From: Maxime Ripard <mripard@redhat.com>
To: Nicolas Dufresne <nicolas@ndufresne.ca>
Cc: John Stultz <jstultz@google.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
	Brian Starkey <Brian.Starkey@arm.com>, "T.J. Mercier" <tjmercier@google.com>, 
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: Requirements to merge new heaps in the kernel
Message-ID: <20241024-giraffe-of-pastoral-hail-3141a9@houat>
References: <20241022-macaw-of-spectacular-joy-8dcefa@houat>
 <CANDhNCoLgzy=CPBWjBKLiJzRdnf=SS3AgtFJNB-CBYAo=UEQJA@mail.gmail.com>
 <f8831b4e658b19a1df4cc02449bb74d730908de6.camel@ndufresne.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="v3j6hycuvpl6yppp"
Content-Disposition: inline
In-Reply-To: <f8831b4e658b19a1df4cc02449bb74d730908de6.camel@ndufresne.ca>


--v3j6hycuvpl6yppp
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Requirements to merge new heaps in the kernel
MIME-Version: 1.0

On Tue, Oct 22, 2024 at 01:58:47PM -0400, Nicolas Dufresne wrote:
> Hi,
>=20
> Le mardi 22 octobre 2024 =C3=A0 09:19 -0700, John Stultz a =C3=A9crit=C2=
=A0:
> > On Tue, Oct 22, 2024 at 1:38=E2=80=AFAM Maxime Ripard <mripard@redhat.c=
om> wrote:
> > >=20
> > > I wanted to follow-up on the discussion we had at Plumbers with John =
and
> > > T.J. about (among other things) adding new heaps to the kernel.
> > >=20
> > > I'm still interested in merging a carve-out driver[1], since it seems=
 to be
> > > in every vendor BSP and got asked again last week.
> > >=20
> > > I remember from our discussion that for new heap types to be merged, =
we
> > > needed a kernel use-case. Looking back, I'm not entirely sure how one
> > > can provide that given that heaps are essentially facilities for
> > > user-space.
> > >=20
> > > Am I misremembering or missing something? What are the requirements f=
or
> > > you to consider adding a new heap driver?
> >=20
> > It's basically the same as the DRM subsystem rules.
> > https://docs.kernel.org/gpu/drm-uapi.html#open-source-userspace-require=
ments
> > ie: There has to be opensource user for it, and the user has to be
> > more significant than a "toy" implementation (which can be a bit
> > subjective and contentious when trying to get out of a chicken and egg
> > loop).
>=20
> If there is a generic logic to decide to use a carve-out when using some
> specific device on specific platform, it would not be a problem to make
> userspace for it. I'm happy to take DMABuf patches in GStreamer notably (=
which
> could greatly help ensuring zero-copy path).

Yeah, that's one of the things we discussed at Plumbers too. My
point-of-view was that userspace also had no way to tell which kind of
buffers it would get. We settled down on the heap name providing those
semantics, and it resulted in:

https://lore.kernel.org/r/20240930144057.453751-1-mripard@kernel.org

> But so far, all the proposals was just a base allocator, no way to know w=
hen to
> use it and for which device. The actual mapping of heaps and device was l=
eft to
> userspace, which to be honest would only work with a userspace Linux Allo=
cator
> library, with userspace drivers, or inside mesa if the devices are GPUs/N=
PUs.
> This is a project Laurent Pinchard have hosted a workshop about during XD=
C.

Yeah, that's another issue that needs to be tackled at some point indeed.

> p.s. libcamera have device specific knowledge, and could of course be a s=
horter
> term user. Note that major distro are not happy that there is no memory
> accounting for dmabuf, bypassing sandboxes and limits.

Meh. The same argument could be said for v4l2 or DRM/KMS, and it never
bothered anyone.

Fortunately, we're tackling that issue as well:
https://lore.kernel.org/dri-devel/20241023075302.27194-1-maarten.lankhorst@=
linux.intel.com/

Maxime

--v3j6hycuvpl6yppp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZxpBCgAKCRAnX84Zoj2+
dgHXAX0SfWtyKH8RpB7e4T3vbSYwKEoZUIpBDgIWE798YzT0YS6TlcfW1VbbXaFb
5TMwUn4Bfi40qfBijP19+Y4SSRBZfhLYDP3AtTs1/Ek/rVRaXeHPDj6OYn8LAGq3
DBUHkmX4vQ==
=b82R
-----END PGP SIGNATURE-----

--v3j6hycuvpl6yppp--


