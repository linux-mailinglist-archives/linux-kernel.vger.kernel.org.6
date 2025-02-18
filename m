Return-Path: <linux-kernel+bounces-519466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A8EA39D2A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A58A3A1603
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4BE14B08E;
	Tue, 18 Feb 2025 13:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwsetgF2"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B2F265CDB;
	Tue, 18 Feb 2025 13:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739884303; cv=none; b=I8JRid+D9fyIS/f9/mdYgldWQ0PcyrulzkPYJr+tcuD77tsTbRBRV6pF8popTJ10xiO7IECzXHxGcRiBxz0119vbtIfcxvg+ix8eJZUVXI/sH4PQrCd2AYD4TXEhpYE2mgDmmdJ+A0/Jx2wWTp0W8ymfVcKbeCwB8dPpIybHtLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739884303; c=relaxed/simple;
	bh=8Gxz57Ja5je6U2ZTaisSqkmyjkSmHJX/va3lMls+skk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AarU4TSoSpDxbe1TkP6CmgNaefCG5FEBxUOrik8HFGbDVX3O9smPFbMSu356Kg1CWlvn5+wDexZ7xzIYbYCDguF5S1wNbEZBwXnK9ulhAgF+oPJh6CDksutX7Z3TOVhAa+BjzB7MqGsJwJiiLFxUHLi+/IxEzeBfFLLvBU/ch84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QwsetgF2; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-439946a49e1so4460915e9.0;
        Tue, 18 Feb 2025 05:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739884299; x=1740489099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Gxz57Ja5je6U2ZTaisSqkmyjkSmHJX/va3lMls+skk=;
        b=QwsetgF2BxTXKISDrXJkCinKue0Nd7CVelxCB/WLZwDcaHJc0MKWAiXjyj/6IbVBgK
         qSX93gMF8Ih3/o1hM60C0stzICMUmNaNvdTaUbOcEPoyPrT/d9rmPZ+I1VBxCQcwuS4P
         x2zJ3IGmW81hnAqJcWBXo33yHAlIeWPMVIpPtydDv7OIOc8ARnVUMFe9obdrBbWSlu+R
         Ymm8Z7OCnN2zHwKr0lmnX7rEbqUs9MBPCQBk3qVymNjv+jkyJjrkdyU0/545/j8NiJzX
         PsLsUWWnAFjpUtVhb4rCCfBwGA2sR3dsUqO6kIZ8OcHM8zBExA5BIKf71qOFM4U2Xvg+
         AQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739884299; x=1740489099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Gxz57Ja5je6U2ZTaisSqkmyjkSmHJX/va3lMls+skk=;
        b=JXOK6SpdiKiABbe6eogJ8gHoxUYa7h0a9xg1UCK6CBaIKllCtjLwIBmeTrGgJExqBo
         fxdZJl7w73FI0d8mrzzSY+i6VZA0AkMatuRs/xvfdY13wU3Yt4o15/JVrFbzvOIYTeLo
         TPptpFS+zqb0O8xaSkOKXZBEsqi20bX6uRmhS0Ro0HCL8SgYGPfZg4tALOzwNX77bzD4
         Y7iM2rVKKLUSouOYe4WEzn1PtxqVT/PpUL0heu5PfPykUdnPk5ok0QdOLGPKtRVhGo4b
         tJ2ApcvW3Pd1S3HHNTa9f/pYO3Ac0G0WItWd7gzBsV9HTZiZZEE8zBLSXMarSiU/RrNO
         aBrA==
X-Forwarded-Encrypted: i=1; AJvYcCU+sVD7otSZjL7edJ7vkmWxInOlQkUMUVrpNW0OY95TP1XIsMOBmja+t6doU2kbP/sIQFL9mkLxVnO8xaAj@vger.kernel.org, AJvYcCX4kUFheyS8sn3+Y2vmyQ6k0H5p1cZw6V9CUCTCv7TLzV0pkN2CDRq2aulqyz8l/IC9qP3GNfmV0+Fl@vger.kernel.org
X-Gm-Message-State: AOJu0YwFJvzcLTkk5pODUv9k/JKpELVxUfny75e+SFrw35kFnPegKWe6
	YawdTTXyJGBgnOZO+icpRc8bDFhvhkPx0ly2tR3Ms8xizTNYEnzPr+0IcZ0i24vg7ilJa6BDLcu
	Y94cG+OSqLXmcXNBT54HiL8ByN48=
X-Gm-Gg: ASbGncuSyPWdHz8ldKEr6OP1z8bZKwlapUqjZc0fnhG3zTYCgO2V8n0FKsYhARRa4ns
	sRu6eb83sIG9jmxUjO4VXOnJ0vsT59ke5mkmkdQT9Yx5Y/GiTJQe1joiK7w8eWQvsgJWJ6csVaA
	==
X-Google-Smtp-Source: AGHT+IGTuZJNQwMJ21Zt/iwu+Lwt8FGFWYP/uZLJHHppf6TYhsiA73LzqKrd96Z1UlFBGMruWLJon5RgYuny/0jUXqk=
X-Received: by 2002:a5d:64e6:0:b0:38d:e15e:17e9 with SMTP id
 ffacd0b85a97d-38f33f5344bmr15197897f8f.35.1739884299381; Tue, 18 Feb 2025
 05:11:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217140910.108175-1-clamor95@gmail.com> <c19bd9b3-86c4-4f1a-beb9-b6aed32b3ef5@suse.de>
 <CAPVz0n0WG1Q51SONb4fmkzi4q7Q0sZ_aKSLrLnGboNNya6nO+Q@mail.gmail.com> <871pvvqu0i.fsf@minerva.mail-host-address-is-not-set>
In-Reply-To: <871pvvqu0i.fsf@minerva.mail-host-address-is-not-set>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 18 Feb 2025 15:11:27 +0200
X-Gm-Features: AWEUYZmfbcsOHj-xZvsCFi1MGPu06qG3yvCK-zcho_dMe2UGKIBGPZimeQMuN30
Message-ID: <CAPVz0n1MdCccD5gHK0Z-mMHJ4Erf59_pBSU3+Jenmfr92Fky9g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] drm: bridge: add ssd2825 RGB/DSI bridge support
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 18 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 15:09 Javi=
er Martinez Canillas <javierm@redhat.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Svyatoslav Ryhel <clamor95@gmail.com> writes:
>
> > =D0=B2=D1=82, 18 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 14:36 =
Thomas Zimmermann <tzimmermann@suse.de> =D0=BF=D0=B8=D1=88=D0=B5:
> >>
> >> (cc'ing Javier)
> >>
> >> Hi
> >>
> >> Am 17.02.25 um 15:09 schrieb Svyatoslav Ryhel:
> >> > Solomon SSD2825 is a RGB to MIPI DSI bridge used in LG Optimus 4D P8=
80
> >> > and LG Optimus Vu P895
> >>
> >> There's a driver for Solomon 13xx displays in drm/solomon. Did you che=
ck
> >> that this new driver isn't just an extension of the existing code?
> >>
> >
> > Definitely no, ssd2825 is a RGB to DSI bridge in a pure form. While
> > 13xx as you have said are display controllers family.
> >
>
> Exactly. Both chips are from the same vendor (Solomon Systech [0]) and my
> guess is that the SSD prefix means "Solomon Systech Device" or something
> like that.
>
> [0]: https://www.solomon-systech.com
>

You are correct, vendor is the same, I have not denied that, but the
this device is not related to product drivers which already exist in
the Linux Kernel.

> --
> Best regards,
>
> Javier Martinez Canillas
> Core Platforms
> Red Hat
>

