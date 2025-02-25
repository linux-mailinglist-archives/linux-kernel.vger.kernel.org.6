Return-Path: <linux-kernel+bounces-531300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3E7A43ECD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 13:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFD8D425F33
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA48267F68;
	Tue, 25 Feb 2025 12:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqTu4tCY"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3B829CF0;
	Tue, 25 Feb 2025 12:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484940; cv=none; b=Qc3DPi+YwLWDvL8D1859IwHZMdjQbPP5VjUZhD6fWWShrlj2IxCPMtVgqb1iXGkebCGKw0H8Lg1LLe2Eq3oPyXHFns9pxYEJjOyYLLBc7yUsBNi2Chsj7IzqTcpBOGtrdkS6qNU4GfzIGYPpmM8NFQf7c75SnAvx0Lw7qwc6okI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484940; c=relaxed/simple;
	bh=Kl+qJRggA+1kKloQ/cuS+SjssOJK2i0412pDJnUb7oE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qlrMRRo2tvnvMcNELw33z2Fx76JVNrWWXe/H+37Qm7/tOU5fei0ykH5hNnFDoc8nE26rmh7c6OnzdAaJTSuLchCdBXLK4bWQico6JcnXxA78oOI8E6hIVDgfiu23PCzF3fc2NeH37UP17Hq0ePekrOKIUzP7lEiUkllGkNi+/0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqTu4tCY; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38f29a1a93bso4346078f8f.1;
        Tue, 25 Feb 2025 04:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740484936; x=1741089736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9CPivFaP7s8yYZJY+7sb+ThsoYL7A75p/3P2VihSgE=;
        b=OqTu4tCYDuCUTgJZOVSSUhSwp4etuWlFVIfjMrx+e44g/LXYwFNgkNEowt36R6567n
         zs6bCQLh3k/c42hIe8CWsFKtMS0niNcIC73Ppe/f4+Nq80F+OG96t5Ou4NXXIoTgCZyE
         u8OjbtF1QchCLawgVm1T7GWj4PlBGGlbrxnOUM5/36kj0hOapdCRbx+eKPkRxikbwBlt
         kFcKnHU3/JWu5gQ3R8ZBNqaVs65unpd+iD561dKF9kcho2iJ7uZvb5sUL4Ek1QOKHp1C
         JmQDyA6Gg+zYuNSmQaw3EjfIbHrvPsAENCQ5LP5VB7WNs24uBL7ADyMObCxCOuUfbt9Q
         XBew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740484936; x=1741089736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9CPivFaP7s8yYZJY+7sb+ThsoYL7A75p/3P2VihSgE=;
        b=Bb1vxKjD+NTMS8CnlSZfyLR7lEiavmrmsv3jr/txlm3b5uQUjQQwCDlCNfqftfBNyt
         NzoNYYDfZViNV6oZ43u6eQh0VxtbLcMlzmT3yOxJpIJVVSMF+cGm9rizMVf1/tnJjTU8
         basnHHu7altYCJpLL97lH2K8yCU2FLR4PMxywHjih44M1oFI7fb7XFJqRDxJs+jYl6zr
         LC7VHS8xFSdYCfIM555HtYIwjAvhI9i81qBF7YhcDfTXUC81WQu5mmgeRsn8jC7U76ME
         VK8GpNFNBKty7VWdQj9v8yCDfe2CZczmH4rJHetWUT+KeXvtoFfF3XOXFhiI/TcM9nCy
         tmAw==
X-Forwarded-Encrypted: i=1; AJvYcCW1tlY+JGhQlGsn79aUwp+hNBO3tTgc4FzrGRyzTzBUGTntOnfm/qdaXyJkI/5PKKc9I3qVAE0czx9ITEmO@vger.kernel.org, AJvYcCWV4c8upSdZwrkDYyxCqzIpfkQ4Vjf32bwZNWOYp35YT7l4wu1lRx6b+zym49H3TTBre9cqAnjVaz0V@vger.kernel.org
X-Gm-Message-State: AOJu0YwNjZzx2I7fmBWJ+uT+XSLfkX7KqLwDbzmKa1D9UrNT75BpYdiF
	sIsvQF16cH4zBVcvCUkxpFK05tNZhtb0XbZpw4Xc3jrEXeEnZXX5bWR56dCDpUW9pI4aoWA5s6B
	rMj7NTorhg8vx2779Zm78hEMcHzg=
X-Gm-Gg: ASbGnct4+7zPDLRhmR+SfDcZX12TgLQwAzmZGk/jChJ314JnumqDqHGDTzo+Q9vjcfJ
	B+6YlWtPx6RAt2U6aHhYVGYQlXbvNkf6tKg93YmDNKYKnKNloSt6j71LX8eQ/fMGyBxZZBK4UoG
	fcgEugOGqs
X-Google-Smtp-Source: AGHT+IHovLsSDlGsjXOzdOi3XJgV2ZoGBF7JDLcQsA7MCDsWNsbn+uTtfMOLk9ExL8/K8w4JtH77uyCbj5LQKa5LKkg=
X-Received: by 2002:a05:6000:1a8a:b0:38d:d5af:29af with SMTP id
 ffacd0b85a97d-38f6f0d1ddfmr11857129f8f.49.1740484936293; Tue, 25 Feb 2025
 04:02:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225083344.13195-1-clamor95@gmail.com> <20250225083344.13195-4-clamor95@gmail.com>
 <lkfxsq3daspjxdw43dofch3nulprpmg4soxsgflsypu3kem4ok@utt6rfdtbg7j>
In-Reply-To: <lkfxsq3daspjxdw43dofch3nulprpmg4soxsgflsypu3kem4ok@utt6rfdtbg7j>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 25 Feb 2025 14:02:04 +0200
X-Gm-Features: AQ5f1Jom4uPLrGTDkdpnTwd36vkgtR0yhjPU5X9ii3Faj6MxYp_0WM0zWEbVF9c
Message-ID: <CAPVz0n3Jc5GE5szjPGJXJNjKVfynvqmzSuZLba5XbLPtcycjwQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/bridge: simple-bridge: Add support for MStar TSUMU88ADT3-LF-1
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Maxim Schwalm <maxim.schwalm@gmail.com>, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 25 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 13:57 Dmit=
ry Baryshkov <dmitry.baryshkov@linaro.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, Feb 25, 2025 at 10:33:44AM +0200, Svyatoslav Ryhel wrote:
> > From: Maxim Schwalm <maxim.schwalm@gmail.com>
> >
> > A simple HDMI bridge used in ASUS Transformer AiO P1801-T.
> >
> > Signed-off-by: Maxim Schwalm <maxim.schwalm@gmail.com>
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > Reviewed-by: Robert Foss <rfoss@kernel.org>
> > ---
> >  drivers/gpu/drm/bridge/simple-bridge.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/b=
ridge/simple-bridge.c
> > index ab0b0e36e97a..c0f1f7baaa37 100644
> > --- a/drivers/gpu/drm/bridge/simple-bridge.c
> > +++ b/drivers/gpu/drm/bridge/simple-bridge.c
> > @@ -277,6 +277,11 @@ static const struct of_device_id simple_bridge_mat=
ch[] =3D {
> >                       .timings =3D &ti_ths8134_bridge_timings,
> >                       .connector_type =3D DRM_MODE_CONNECTOR_VGA,
> >               },
> > +     }, {
> > +             .compatible =3D "mstar,tsumu88adt3-lf-1",
> > +             .data =3D &(const struct simple_bridge_info) {
> > +                     .connector_type =3D DRM_MODE_CONNECTOR_HDMIA,
> > +             },
>
> This entry should also come between adi,adv7123 and ti,opa362.
>

Original list in the driver is not sorted alphabetically.

> >       },
> >       {},
> >  };
> > --
> > 2.43.0
> >
>
> --
> With best wishes
> Dmitry

