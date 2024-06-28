Return-Path: <linux-kernel+bounces-234326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F6191C53B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0F12B23EB1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 17:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163471CB33D;
	Fri, 28 Jun 2024 17:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VCDZSyvN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D619615253B
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719597297; cv=none; b=t3vm4uPUvBZQxzXGOXH209pEJUuWNnePBL6jetuOEbD1MgbM6rcdQJRuQGAvKf+CqnHqX7sb8TQ7hOm1NDt55cHFSH3mZj3SM976+rfvo1hbNZ4ZRPOe2m1zu0X+NxNyXv06omyjCR+T/l4Y33+csyI3aJnqceKdWC3mVoO1ves=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719597297; c=relaxed/simple;
	bh=LS6myUf6u19q1cqPvIL4lLcsNWvd6H16mjwaDkr4S80=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r5IezrH3usvcnWptsvf9I5WOAVU70MXqEELBnVuIjA+GG9MaXAqX+3IlxQNIIld99d+/RsW2BO16S9+RyoWHXivG43cGrWeSbULTRoryHiiy1BP+6AlvbaqhGqnsQahA2jrTH7nfma5ogkgrX+b2aJVyTmg9xdLHK1y1hR3DkLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VCDZSyvN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719597294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TB1YvVhQLn/H70Rr+uFCjpzP9CQR7nQAEPIty/GMlrU=;
	b=VCDZSyvNI26H3yZB0FLraE8wGLh410EbEAG8huTSq2nsjfbJnzPm/xa4Ue8LeijmWbnsmi
	NuUBROuMiZZkGOfsrQ7aXclLOf0pn25TFu2a9h4PQOgexozBAnu4F8EKntgQFZp5+PXXT4
	ZJdEBTTTD+JRFLwYphCRxVrZIbV4hlk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-3R_UgxsqPf6_0D6_0KgqkA-1; Fri, 28 Jun 2024 13:54:53 -0400
X-MC-Unique: 3R_UgxsqPf6_0D6_0KgqkA-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-44502b8579cso14679401cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 10:54:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719597293; x=1720202093;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TB1YvVhQLn/H70Rr+uFCjpzP9CQR7nQAEPIty/GMlrU=;
        b=VhvztdKgGs+/EKn7MtOIa1x3/ELCOTBBcPr5JCd9y24KPAo5Es0gEs1T8n9Ce7n6DB
         wF50B4mMwI8rN1EgM9xIxU5uxNEqpatEzN4LGfsSKaqGVojjZ4v7RUtFoXtS2j3akERe
         MUGWrL1f8ynrW3LYfQxI5aDc0sdvjQESDnKocqoxNhqndywIuJAw//DMeQjyKMBrm9bM
         exAORiRvRF6SDFN1+frVAIHbkQ3pxt+EEH4xj5nYtcCRNqOLTZJkU5uxkJJNtkxYxEva
         xDYqLfYwRsyiSrR0KhbMYciKPYK1OfN25XPvNP1FBHLl8rRLDmcxoTJZ+aZ0mr78Fs6Q
         Q9uQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvoJOaDJ7h7xHpKNkkkn22nOD9xWyAC/YAHSCVy/JZpnNU3PPCEyLEUFnPnbs6GKdPCw5hbWgqcWA1/y6B3pPS4oV9EEEI0TG/sArr
X-Gm-Message-State: AOJu0YzV1z5k/bTEvKfm1lJRg7LjpSXOrI4hmYXhQJ8Kg/k/ETmQq9De
	fgQ18fRJg0YKc4QK3Tartyyvn723u84JcIWnJOjmnC5iyoBAGBn5cQ4e+ge+T0kh2AP7w11vvcx
	NFuZdhqP/Si4upjV2c5Sk+0rVFWUJkV5gW49ka+2y36f0qLG8TFpfmUACpFdMHg==
X-Received: by 2002:ac8:5a15:0:b0:43d:e4c8:8059 with SMTP id d75a77b69052e-444d92335aamr216984571cf.38.1719597292936;
        Fri, 28 Jun 2024 10:54:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHliaKczNq59esZ7bbqWZZwIg7BK0Qk7e2Vg6tc6pE8nfO36/kFIUgUN4o6+qKPkamp6yxIxA==
X-Received: by 2002:ac8:5a15:0:b0:43d:e4c8:8059 with SMTP id d75a77b69052e-444d92335aamr216984461cf.38.1719597292583;
        Fri, 28 Jun 2024 10:54:52 -0700 (PDT)
Received: from chopper.lyude.net ([2600:4040:5c4c:a000::789])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44651428177sm9074601cf.40.2024.06.28.10.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 10:54:52 -0700 (PDT)
Message-ID: <c7f963fa69a8bff65c54dbacad4c890ce26f57a4.camel@redhat.com>
Subject: Re: [PATCH v2] drm/nouveau: fix null pointer dereference in
 nouveau_connector_get_modes
From: Lyude Paul <lyude@redhat.com>
To: Ma Ke <make24@iscas.ac.cn>, kherbst@redhat.com, dakr@redhat.com, 
	airlied@gmail.com, daniel@ffwll.ch, airlied@redhat.com, bskeggs@redhat.com
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 28 Jun 2024 13:54:51 -0400
In-Reply-To: <20240627022732.2978601-1-make24@iscas.ac.cn>
References: <20240627022732.2978601-1-make24@iscas.ac.cn>
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

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push this upstream in just a moment, thanks!

On Thu, 2024-06-27 at 10:27 +0800, Ma Ke wrote:
> In nouveau_connector_get_modes(), the return value of
> drm_mode_duplicate()
> is assigned to mode, which will lead to a possible NULL pointer
> dereference on failure of drm_mode_duplicate(). Add a check to avoid
> npd.
>=20
> Fixes: 6ee738610f41 ("drm/nouveau: Add DRM driver for NVIDIA GPUs")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v2:
> - modified the patch according to suggestions.
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_connector.c | 3 +++
> =C2=A01 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c
> b/drivers/gpu/drm/nouveau/nouveau_connector.c
> index 856b3ef5edb8..0c71d761d378 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> @@ -1001,6 +1001,9 @@ nouveau_connector_get_modes(struct
> drm_connector *connector)
> =C2=A0		struct drm_display_mode *mode;
> =C2=A0
> =C2=A0		mode =3D drm_mode_duplicate(dev, nv_connector-
> >native_mode);
> +		if (!mode)
> +			return 0;
> +
> =C2=A0		drm_mode_probed_add(connector, mode);
> =C2=A0		ret =3D 1;
> =C2=A0	}

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat


