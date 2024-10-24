Return-Path: <linux-kernel+bounces-379864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 748E29AE51B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67CC1C2430D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 12:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1648A1D5AB5;
	Thu, 24 Oct 2024 12:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QqvklLaH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695701714C9
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 12:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729773567; cv=none; b=JCm4WnCfUvA8Tmj3jIrVvTdj1SsMSZmLXdtPyWQeO/tD21uI+DbunHBOT4UK0VRDdU8pmYi54OyQZ9E5dTgwFn0lt/X2epaeg+HuHTpc0ne2SBYtgZByEFtK0pzU2LJA6V+g7V71Am9zJSB2ErM7y8awbekv1gxzB7vPtPGhgtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729773567; c=relaxed/simple;
	bh=5+OQwY4zc6vEVXiNONtzig1xHIyHH/SoXYN3nuyooEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kO3HQJIV2F19sP042hKeHAyvmwPSXUt9nQFCfTUv84BZek6iFEBn+lvHYFrInJjEJkEt7VrpEetd7xyhKnWIdEntCrs9RKzzCHe/rMYMF4NB7cvgt/R3my9cgc4DQkqkL+8MGJfyJemC5tXXqlryxh2iklULBA1oJ9E+PHiv/7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QqvklLaH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729773564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5+OQwY4zc6vEVXiNONtzig1xHIyHH/SoXYN3nuyooEc=;
	b=QqvklLaHUJgksniBgPIYPOn7rFm4jCWTKQiECOD8yQPnPTqci0455nOTNWVl9FPUkCxRP8
	osvurnZRdgmJbCXKvmbtX8bh1o18qLq/VzCZ1fXmIqT5jhG8XY5K/4/GEy1sUSjZxVTK1W
	nbvaAZYhVMvJmj1lyNAUQ/p91WVr22w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-8aGvjDarPICqdrW9KnTAIg-1; Thu, 24 Oct 2024 08:39:22 -0400
X-MC-Unique: 8aGvjDarPICqdrW9KnTAIg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4315dd8fe7fso8848375e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 05:39:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729773561; x=1730378361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+OQwY4zc6vEVXiNONtzig1xHIyHH/SoXYN3nuyooEc=;
        b=qs30/BmJGi5Wi4hBWSNEOTHX/nuF7fBZ89yFlm2d80FYuhCjwaLBbS6z0YX0FlmSnL
         3OPFgumTp/ag42yVDUIz8T3XwPppzO77tiMSawjtB0BMY/fIAXnIB+jmhun6T0ky4vEg
         rdVXEVvaI8Lxn5v080LAS6Rv2JCDxRxh4rT2+NTz5bVD09B16thKn44vpvMNU7xRsm9J
         dXVwo3d8uFsEhR6GNiCSMa6RQ5ZHY8Ebcc5cZU8ezXrVCqQ9W4kg5JZjWfvHWVJVN7Y9
         +L0a7OesH5hq9Bkg3ayY7koLkBAbiXqliCtA4yjUPanW6JNlpSXAS8nmIjbitww/C6fM
         sR0g==
X-Forwarded-Encrypted: i=1; AJvYcCWc9CEmqTF8Urjap8sfPFLVH7vMDN/kMtVj7jISvwKdfGyXASlTAjdIkh0nCGElo0d09e3fVvbDC8LbHiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVE0wHJc4H3hGpVcl44KeBm6oAzME+NeMZjtpjbqlKOLdDsuUs
	owM/mOLdlq7UvlNlX6wXfPW2l7pBV9ej/BTXYktrsvDec5+bRFcvPpJv/K/gfkCAmmdrnbQ7Un9
	iZm9IEp+rW3D7KGTQ4pOP8I9THjlMLS3GddVqw7I+EjICYOEoQlT9TXLH4VMqrw==
X-Received: by 2002:a05:600c:3b90:b0:431:6083:cd30 with SMTP id 5b1f17b1804b1-431841eb1f4mr58630625e9.6.1729773561429;
        Thu, 24 Oct 2024 05:39:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHP4Yt2lWKfiLXUwD5pyhyM9nEq+ovGX7LSbAtjKqBgqeoGKgURQHRk8nXBv2l3UL8PbfGW5A==
X-Received: by 2002:a05:600c:3b90:b0:431:6083:cd30 with SMTP id 5b1f17b1804b1-431841eb1f4mr58630405e9.6.1729773561037;
        Thu, 24 Oct 2024 05:39:21 -0700 (PDT)
Received: from localhost ([2a01:e0a:b25:f902::ff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b5706c3sm16232465e9.34.2024.10.24.05.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 05:39:20 -0700 (PDT)
Date: Thu, 24 Oct 2024 14:39:20 +0200
From: Maxime Ripard <mripard@redhat.com>
To: John Stultz <jstultz@google.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	"T.J. Mercier" <tjmercier@google.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-kernel@vger.kernel.org
Subject: Re: Requirements to merge new heaps in the kernel
Message-ID: <20241024-nondescript-pogona-of-chemistry-fa4ab4@houat>
References: <20241022-macaw-of-spectacular-joy-8dcefa@houat>
 <CANDhNCoLgzy=CPBWjBKLiJzRdnf=SS3AgtFJNB-CBYAo=UEQJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="ebb7ftwkuirg3orl"
Content-Disposition: inline
In-Reply-To: <CANDhNCoLgzy=CPBWjBKLiJzRdnf=SS3AgtFJNB-CBYAo=UEQJA@mail.gmail.com>


--ebb7ftwkuirg3orl
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Requirements to merge new heaps in the kernel
MIME-Version: 1.0

On Tue, Oct 22, 2024 at 09:19:05AM -0700, John Stultz wrote:
> On Tue, Oct 22, 2024 at 1:38=E2=80=AFAM Maxime Ripard <mripard@redhat.com=
> wrote:
> >
> > I wanted to follow-up on the discussion we had at Plumbers with John and
> > T.J. about (among other things) adding new heaps to the kernel.
> >
> > I'm still interested in merging a carve-out driver[1], since it seems t=
o be
> > in every vendor BSP and got asked again last week.
> >
> > I remember from our discussion that for new heap types to be merged, we
> > needed a kernel use-case. Looking back, I'm not entirely sure how one
> > can provide that given that heaps are essentially facilities for
> > user-space.
> >
> > Am I misremembering or missing something? What are the requirements for
> > you to consider adding a new heap driver?
>=20
> It's basically the same as the DRM subsystem rules.
> https://docs.kernel.org/gpu/drm-uapi.html#open-source-userspace-requireme=
nts
> ie: There has to be opensource user for it, and the user has to be
> more significant than a "toy" implementation (which can be a bit
> subjective and contentious when trying to get out of a chicken and egg
> loop).

Ok, so I'm definitely misremembering things then, I thought there was
another requirement in addition to that one. Thanks :)

Maxime

--ebb7ftwkuirg3orl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZxo/9wAKCRAnX84Zoj2+
djn1AX9LL8SXF/jq+RdIeQMizkxZVAraKRt3f6b5NqqRYhNV1s73O/AM40KqrjPO
PitAa1wBgOVgiPLyWZpw+VK+HqDje4x7HEncok93cPDEPDddu+TgaH7x4+CblDWy
zUOH8A1wEA==
=M20y
-----END PGP SIGNATURE-----

--ebb7ftwkuirg3orl--


