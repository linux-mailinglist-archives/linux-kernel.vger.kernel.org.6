Return-Path: <linux-kernel+bounces-234323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4518491C531
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E55521F24D86
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BE61CCCB9;
	Fri, 28 Jun 2024 17:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S3iqH3LN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63723225CE
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 17:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719596956; cv=none; b=R9Me8IN930MNpUq5gn1ES5aCIZsc7FFMbhZesgKJpEoUN8J2cusUcCpxrgobsrr9c+ooVThQewyaldMd1yH+BDoAAwXFJE3co3zkCT+drgjT5kWtUdy2w3iGZ0sfHIKTaOzNyNuRBnGDHuVeTOhqRTJw6s1J/13UXv6e6y1WyBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719596956; c=relaxed/simple;
	bh=TAd485aghXUIWa3RvWf2lTA7jc9MG6PA9b0qtG0r2DY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rt9+E5DgehpQQf/RcZdu5HtM0+fSKJLQXhXIV2asCDd+aIuiutrU8aZT0QTyTVctJFM6qwUh32iFZEQH5spjqa607HEIrs+Xt1oXB34J1Uo6NPDm4WVSm7nxk1UK6C5oiQoXjJVrVTK/hseAtpnmcJhIhfbIJnmU7cZuvxHUsUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S3iqH3LN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719596954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TAd485aghXUIWa3RvWf2lTA7jc9MG6PA9b0qtG0r2DY=;
	b=S3iqH3LNAvUoNUWHov2Wptrhks49cUWK8R52LSCa6n1Pc1II1Ns/+zOUNngEfoxtEs8/xz
	yKZKfqCYJw5ne/wpAiw74zMZd6uBrvgoeEWeCbmCR694IwAJFhOULeQtUEbUOp7d8imF59
	EEkH2z7c0yyueC1UlfMlX681dX7djho=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-lkI0jnnYMPChTK4ly7CwkA-1; Fri, 28 Jun 2024 13:49:13 -0400
X-MC-Unique: lkI0jnnYMPChTK4ly7CwkA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6b5912466dcso10759536d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 10:49:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719596952; x=1720201752;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TAd485aghXUIWa3RvWf2lTA7jc9MG6PA9b0qtG0r2DY=;
        b=qDEy90Ywg0grI546a7Wlv/1/IsM6k+pYFZBfX1wZKi+I9snphkA1y/kF5dbHDFcV0T
         f9jNmW9PuTYQH43tkZ/m4+9Eo0qA3+1sABYXGWE0ZVhLdhln75K4BNS+Ad/g8NhbzVC1
         z4zRByqGN0CHWYaAj5txL1GyTeLtZps5Heu74gPpTbLdefXiDpP8FWH2bCNCgJEDn0oH
         zh+BCoilNVchEuZQww5i/Q53cbq/SuO6SZtR3kWZ6TuiwSDR/RvhtvZoFJ+0W0LaH2Bi
         92KZIOdzC0C8jOokq/Re/yTHYS+tBVDzpTXjM6gDg28CGYDldugGsYVhlQ4YCCfoFgHT
         mI+A==
X-Forwarded-Encrypted: i=1; AJvYcCURJCqshO1DjZqPXSgR6DoNJ6/6TttNgPDb7DF83UEvLuXLbeN1t1L3SckWtt7XwSxS9fDotQ4V1cZw9nXlOP6IVi2ARQl+dtzvdcwm
X-Gm-Message-State: AOJu0YwSY4ocLhqgMwTyfxnOu7ZyNPKIMEb4DIc07AV5BKxzKrXuUizO
	IjAo27Mv6s6USZHMJiiDz0VwmQrvnEUQ7D6WYe7z8LOd9MDITCysC3+R0oHLmeLGOmS/0qQMhIg
	eHw8N7Pd7fvDXbaGw1vlP6mONlOoEGRGzEGhZuzBkMU4k8OQxqa8lCvGzOu0Dm/6Q6N07Ow==
X-Received: by 2002:ad4:4082:0:b0:6b0:76f1:8639 with SMTP id 6a1803df08f44-6b540aaa739mr160298516d6.42.1719596952150;
        Fri, 28 Jun 2024 10:49:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFD6uWQmG4g/igtbloLZSfV+o6cXp2Ckk4uZLpiMQfw5WzwRbofwx6QnvQrMRlxIyNBmHOHyQ==
X-Received: by 2002:ad4:4082:0:b0:6b0:76f1:8639 with SMTP id 6a1803df08f44-6b540aaa739mr160298396d6.42.1719596951873;
        Fri, 28 Jun 2024 10:49:11 -0700 (PDT)
Received: from chopper.lyude.net ([2600:4040:5c4c:a000::789])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e627242sm9625366d6.130.2024.06.28.10.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 10:49:11 -0700 (PDT)
Message-ID: <790dbe8aee621b58ec0ef8d029106cb1c1830a31.camel@redhat.com>
Subject: Re: [PATCH v3] drm/nouveau: fix null pointer dereference in
 nouveau_connector_get_modes
From: Lyude Paul <lyude@redhat.com>
To: Markus Elfring <Markus.Elfring@web.de>, Ma Ke <make24@iscas.ac.cn>, 
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Ben Skeggs
	 <bskeggs@redhat.com>, Daniel Vetter <daniel@ffwll.ch>, Danilo Krummrich
	 <dakr@redhat.com>, Dave Airlie <airlied@redhat.com>, Karol Herbst
	 <kherbst@redhat.com>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, David
 Airlie <airlied@gmail.com>
Date: Fri, 28 Jun 2024 13:49:10 -0400
In-Reply-To: <d0bef439-5e1d-4ce0-9a24-da74ddc29755@web.de>
References: <20240627074204.3023776-1-make24@iscas.ac.cn>
	 <d0bef439-5e1d-4ce0-9a24-da74ddc29755@web.de>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Ma Ke - I assume you already know but you can just ignore this message
from Markus as it is just spam. Sorry about the trouble!

Markus, you've already been asked by Greg so I will ask a bit more
sternly in case there is actually a person on the other end: you've
already been asked to stop by Greg and are being ignored by multiple
kernel maintainers. If I keep seeing messages like this from you I will
assume you are a bot and I will block your email from both DRI related
mailing lists (nouveau and dri-devel) accordingly. You've done this 3
times now.

(...I doubt I'll get a response from Markus, but I certainly want to
make sure they are a bot and not an actual person before removing them
:)

On Thu, 2024-06-27 at 11:02 +0200, Markus Elfring wrote:
> > In nouveau_connector_get_modes(), the return value of
> > drm_mode_duplicate()
> > is assigned to mode, which will lead to a possible NULL pointer
> > dereference on failure of drm_mode_duplicate(). Add a check to
> > avoid npd.
>=20
> A) Can a wording approach (like the following) be a better change
> description?
>=20
> =C2=A0=C2=A0 A null pointer is stored in the local variable =E2=80=9Cmode=
=E2=80=9D after a call
> =C2=A0=C2=A0 of the function =E2=80=9Cdrm_mode_duplicate=E2=80=9D failed.=
 This pointer was
> passed to
> =C2=A0=C2=A0 a subsequent call of the function =E2=80=9Cdrm_mode_probed_a=
dd=E2=80=9D where an
> undesirable
> =C2=A0=C2=A0 dereference will be performed then.
> =C2=A0=C2=A0 Thus add a corresponding return value check.
>=20
>=20
> B) How do you think about to append parentheses to the function name
> =C2=A0=C2=A0 in the summary phrase?
>=20
>=20
> C) How do you think about to put similar results from static source
> code
> =C2=A0=C2=A0 analyses into corresponding patch series?
>=20
>=20
> Regards,
> Markus
>=20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat


