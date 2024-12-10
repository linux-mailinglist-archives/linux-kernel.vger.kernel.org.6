Return-Path: <linux-kernel+bounces-439540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF139EB0B7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2071A284743
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC191A9B20;
	Tue, 10 Dec 2024 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sfs8oyCm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEA51A2846
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 12:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733833460; cv=none; b=uzVnG8IxBDTJq7CM1MIBbjBxdowZ99QxmoVrdsizhDUA6AbdnPsXVsYqSQbYmZoNyCiwiB0z7vZk2i36ETiHaKeQYpFNLNGRE5+JuE2x8sfmB28EBLOCPiGiGM1Fm1rHb77BpaUkP8LV6afT5j5Op3rvcdlOZqTBaJFJmf5DRBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733833460; c=relaxed/simple;
	bh=YwG3Q0LwST/Krkoga8Nxp9uoO7p3NLysRaEVDcRad3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nx+xKG2akAc78/3mNn0XxfWJUGU4vE4518VxnWZ98+6HdZwSZVWrImNuOBNpGyvy8H8h2ga6C7wZQHBQbwLzgIqZNiuSR7o+0WCr13QJ6DpqSKlpa14zD+abRMbTZZJ4yDc9niUPD2Ig5cY7re61emyaGFiDm9H6EYVtkKjCRb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sfs8oyCm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733833457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aSecLXEIEH9VAnhyNAFzRJvrLm7yztvw8Khy2pOpSMo=;
	b=Sfs8oyCmrW7yhWNaM/d8H2372G6wYY4J4OKdM722WbQ3msHbrdGFilVmiOHSQeeCsX+foV
	3q/GT5/S56yvVb5JlFxJiF/F5psO7uXdOS6Uic5+JG6YxBSN9biQgzlrsxX9NJ6iQTDjmE
	+WqKjhhD+khcd9EyoTygDk+b0ei54Kg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-fZ3p4dkeMGO2O-3TzgQhFg-1; Tue, 10 Dec 2024 07:24:16 -0500
X-MC-Unique: fZ3p4dkeMGO2O-3TzgQhFg-1
X-Mimecast-MFC-AGG-ID: fZ3p4dkeMGO2O-3TzgQhFg
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aa65d975c40so83166066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 04:24:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733833455; x=1734438255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aSecLXEIEH9VAnhyNAFzRJvrLm7yztvw8Khy2pOpSMo=;
        b=pGzreAU+7ZDVRWZv8kkUhjZSYz+RIB4h0FCByN0JhdohbOpk8YQPOw9EZiRBZMgAYT
         JXx6+VVn53ySNcwMuGKdc8Nib4a4La7kdHLMDIhgDftxHuCQpw3tYxkr7jB2UeKajS6C
         sEtrSKj/kJwlC7Ac3fPkWH4fIfBaMcmhexMIAOWOqGGsGw8dp3p+TYEQy1hvC5VXPdU+
         8A9jGR64q3HAIFq26govntDR8bodEDU6nDFkp4FwhMKAei3guo1ng8M7pd3l3xak4Pkh
         S1ArO1jb6Q4l5c/qI+xU+sZyg0JN0D4NnWb1YHsNfKZIPQim47jDIRVk8GPEa3917qbH
         5ylQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP1FYMo3enkXiFVGk+AeMGfrP4NCE3Ee0Jgm5YN0TykerVSaJhI24AY0bclkG34cig/upFnnhG3eLkX+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNGT541hjtN79tqAiC8QNVdsweshAIUg+Jkf+ArfxiEF1fWTFE
	1yYzNpxj6fntvKbxIm5TzweUKUKyrhiUpkGFyvCMf8O5uwnO31IOrIO1PI9idL2C5Okg7Dljoyd
	IPwb8e3COjifyhFTxYRBXr4CJEyk+2sscOsSODl/RHGX+4qQq9pdGpASgN3ba3LDHEwhC0ekYvC
	NmCljv8nQZqOL5KN/9x8cdMhRbaza50BPvGrzm
X-Gm-Gg: ASbGncvhr93hCYJn3GSl5IsUdFTX48mJpxRMUXZfoa/eQCvKB30Q+0iiMcZEvzanpSR
	ixBqWzMNjPQFAVrVeDcN7Bunw6BT9kRsu/ZETe5lqjD4FGj6L5o3bQbk9PtJ84VBPqLI=
X-Received: by 2002:a17:906:18a9:b0:aa6:8a1b:8b7c with SMTP id a640c23a62f3a-aa68a1b8e98mr630992166b.2.1733833455441;
        Tue, 10 Dec 2024 04:24:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcgyA52HfEjey88Kb6EsuqPIgVlks8Qpk8hL6qKkV1dFhRyyCd5ELr+Iz6VA2G2PWuz4gd34tfvQzS/RzCBTs=
X-Received: by 2002:a17:906:18a9:b0:aa6:8a1b:8b7c with SMTP id
 a640c23a62f3a-aa68a1b8e98mr630989266b.2.1733833455085; Tue, 10 Dec 2024
 04:24:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129122408.4167150-1-ryasuoka@redhat.com> <be01d2f7-8423-4e10-b65b-a84a7bc7c99e@collabora.com>
In-Reply-To: <be01d2f7-8423-4e10-b65b-a84a7bc7c99e@collabora.com>
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
Date: Tue, 10 Dec 2024 21:24:03 +0900
Message-ID: <CAHpthZrZ6DjsCQ4baQ80b2vOTdkR=vHDx=10W7DTS4ohxb6=pg@mail.gmail.com>
Subject: Re: [PATCH v5] drm/virtio: Add drm_panic support
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: airlied@redhat.com, kraxel@redhat.com, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, daniel@ffwll.ch, jfalempe@redhat.com, 
	christophe.jaillet@wanadoo.fr, virtualization@lists.linux.dev, 
	spice-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 11:30=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 11/29/24 15:24, Ryosuke Yasuoka wrote:
> ....
> > +     } else {
> > +             iosys_map_set_vaddr(&sb->map[0], bo->base.vaddr);
> > +     }
> > +
> > +     sb->format =3D plane->state->fb->format;
> > +     sb->height =3D plane->state->fb->height;
> > +     sb->width =3D plane->state->fb->width;
> > +     sb->pitch[0] =3D plane->state->fb->pitches[0];
> > +     return 0;
> > +}
> ...
> > +static void virtio_panic_flush(struct drm_plane *plane)
> > +{
> > +     struct virtio_gpu_object *bo;
> > +     struct drm_device *dev =3D plane->dev;
> > +     struct virtio_gpu_device *vgdev =3D dev->dev_private;
> > +     struct drm_rect rect;
> > +     void *p_vbuf =3D vgdev->panic_vbuf;
> > +     struct virtio_gpu_vbuffer *vbuf_dumb_bo =3D p_vbuf;
> > +     struct virtio_gpu_vbuffer *vbuf_resource_flush =3D p_vbuf + VBUFF=
ER_SIZE;
>
> This p_vbuf + VBUFFER_SIZE looks suspicious. The VBUFFER_SIZE macro
> isn't guarded with parentheses (), hence this vbuf_resource_flush is
> pointing at the CMD part of the vbuf_dumb_bo?

No. I intend vbuf_resource_flush to point to a different vbuf than
vbuf_dumb_bo. I allocate 2 vbufs in virtio_gpu_plane_init() so that
vbuf_dumb_bo points to the first vbuf and vbuf_resource_flush points
to the second one.

> Won't be using kmem_cache_zalloc(vgdev->vbufs, GFP_ATOMIC) to
> dynamically allocate both buffers make everything cleaner?
>
> ...
> > -#define MAX_INLINE_CMD_SIZE   96
> > -#define MAX_INLINE_RESP_SIZE  24
> > -#define VBUFFER_SIZE          (sizeof(struct virtio_gpu_vbuffer) \
> > -                            + MAX_INLINE_CMD_SIZE             \
> > -                            + MAX_INLINE_RESP_SIZE)...
>

Yes, it is feasible.

Thank you for your review.
Ryosuke

> Best regards,
> Dmitry
>


