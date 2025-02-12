Return-Path: <linux-kernel+bounces-511906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B50CA33145
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 22:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D88B188B0CD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 21:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F04E202C51;
	Wed, 12 Feb 2025 21:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLwLiaks"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D0E202C4F
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 21:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739394444; cv=none; b=blhjNsFRdCB4pcF8UfNS7vomaoi5GuoF1wHXsYr2a5y3esCFuUOIpFLy0Dtlg6cwlcNbH+dxiEQfrTO9+9hbv7bBJuDVjZdRh70fBYw+wYiBq0k0sEeTbzmgc6WuFcGxJExbuJKDDDkKu+0Yiy8QWWzwxm6W4IIf2ToSW5p5LU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739394444; c=relaxed/simple;
	bh=kRaMIVwqGc8Xd49sSQZRLuGh6bNy3XlVKUPtAyzoRVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNHDd89bQYl8LVdGjr5926IkOtRY8jhjJS/Nazl22WepKRusR/SD8EVct08wnHCcgctfKUe7wOs71nqCucDhDLa8TXLOIe4qMgHRmsfwNgNKz7P96dKMc4ew1xD6cNbF44gR5RKTM3F4xz9TtVLkneeuYFuLtDTN/TXtsaYJG20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLwLiaks; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3cfc79a8a95so407515ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 13:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739394442; x=1739999242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7m2BC0PlpLZ3PvBNk1lJNnbfheS8gB4DKKdxAHYzcP4=;
        b=eLwLiakslBrdjeumddGlIRnwZvzfbBG1ZKjRpUQ3+6/nDbD8hc0kx71TQGFt1aVgui
         8Fc8mx6v22mloJy1SLDEQlBLs8KamqlFwo+tOYCxJv7NJR9qjbCDMUZDMbyhf+JWyQGb
         2oDHIkXA6VLOpGtmyZK/PDHI67D/WOkL4fe5l9iRMnG660XeUfxsTGNR58SXHkWzHjwl
         u1hwJJ9gtzNimWR9AjlK85bBoIqWbKZRDVEX0l41b3jiHIst7fVUcpxzOkkAWib3a6sc
         vhX69g8Twmr9dxztcv3BjjgfOvKTD/XZ8FkEoQT8QsN89c8G6H5YvmdPTCtyC2sLsi0+
         vLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739394442; x=1739999242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7m2BC0PlpLZ3PvBNk1lJNnbfheS8gB4DKKdxAHYzcP4=;
        b=j8yDMhfZERZcP1DOiXbpQ/ckflED/Z57BpYpWpwfDFI3/GL7enb/ArfThuxIrEVlEh
         Ln+UNi0vOhYVgiRcuw8YB6IxnvUSWx4ZsGIlDhpKxMJCVBkUSoHAxC3FPMX0XcONsvvL
         2DhqU8CW5giTWV4Lnt0kF29zqZ+yEFV1VTYYtAcJKkeLN53uFz85R9Nc1/1rmXKb/7sW
         LshdnoUYKLyvSpaYqtZR9EGCuma/szrXtN2mq/+fufujwcmsiXvkgfZGIYnV/T71ycJZ
         PKNanAoMTbVcJaqY0xFZ14ZGLt1kiHEuSpFzj3+NTSKZyaZgvOAa5kiRKErZGgh+QPji
         R+mw==
X-Forwarded-Encrypted: i=1; AJvYcCXl6kHTJvMBGeyY/rIXXnTBzUo8iWZEVFoX4TWpDZdW8CLd7XceRhoh7vEwJf2RRv5H7lJbife/athIf9g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6MSrm1wFqXPSdlPwnevuA7egLmVSGsYc4eqVEtBQ0Dka3pGRs
	3iS1gkaN7er/M7ewY9Z1uOAuepIJSndqqegU8iyCCPBoKx7FJsxsiOLs8eRnZuOvvb/zu15Lp1W
	CCuyBoaUpC0qbSGZwNrCe2QkUefQ=
X-Gm-Gg: ASbGnctpAkThVYra1fpBTVONnnlHhZA/ufjggaTuxNYnGVwCZwNn4Jc2CJgj1ZqDRSz
	dH/17tlHzb4Q8YmOCQtjdgohzJVlvQwQMiqZqOKafDdjg/2bQRZ+r5t0AVRJfoQ2dqESnAAkoMu
	xc3CBxdt3kNCw87JHfKw4CxGmrTos=
X-Google-Smtp-Source: AGHT+IEto3QwYzrpOOb39TT9wusT7oiYBviqDLiw7Xnxk0Go+s385w1whVmNsbgrd9myoMThLMp+uZwQjNnH/c18b1A=
X-Received: by 2002:a05:6e02:338a:b0:3d0:4a82:3f40 with SMTP id
 e9e14a558f8ab-3d17be2216fmr45576995ab.7.1739394441825; Wed, 12 Feb 2025
 13:07:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124-virtgpu-mixed-page-size-v1-1-480403790bac@gmail.com> <a55eecdc-76cc-432e-a4b3-90e8753088ac@collabora.com>
In-Reply-To: <a55eecdc-76cc-432e-a4b3-90e8753088ac@collabora.com>
From: Rob Clark <robdclark@gmail.com>
Date: Wed, 12 Feb 2025 13:07:10 -0800
X-Gm-Features: AWEUYZlK-LtIBTV8i2bVwjobA09sMmKqOYCs2aSwHvvwvdiGzeqpfq-QqFvpdEU
Message-ID: <CAF6AEGuGWNj7dcC4DouWckaP9fOKgLyqw8iPBwKxrnr9GYXpPg@mail.gmail.com>
Subject: Re: [PATCH RESEND] drm/virtio: Align host mapping request to maximum
 platform page size
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: fnkl.kernel@gmail.com, David Airlie <airlied@redhat.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, Gurchetan Singh <gurchetansingh@chromium.org>, 
	Chia-I Wu <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Simona Vetter <simona@ffwll.ch>, Sergio Lopez <slp@redhat.com>, dri-devel@lists.freedesktop.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	asahi@lists.linux.dev, Rob Clark <robdclark@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 2:52=E2=80=AFPM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 1/25/25 01:01, Sasha Finkelstein via B4 Relay wrote:
> > From: Sasha Finkelstein <fnkl.kernel@gmail.com>
> >
> > This allows running different page sizes between host and guest on
> > platforms that support mixed page sizes.
> >
> > Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> > ---
> >  drivers/gpu/drm/virtio/virtgpu_vram.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/virtio/virtgpu_vram.c b/drivers/gpu/drm/vi=
rtio/virtgpu_vram.c
> > index 25df81c027837c248a746e41856b5aa7e216b8d5..8a0577c2170ec9c12cad12b=
e57f9a41c14f04660 100644
> > --- a/drivers/gpu/drm/virtio/virtgpu_vram.c
> > +++ b/drivers/gpu/drm/virtio/virtgpu_vram.c
> > @@ -138,6 +138,12 @@ bool virtio_gpu_is_vram(struct virtio_gpu_object *=
bo)
> >       return bo->base.base.funcs =3D=3D &virtio_gpu_vram_funcs;
> >  }
> >
> > +#if defined(__powerpc64__) || defined(__aarch64__) || defined(__mips__=
) || defined(__loongarch__)
> > +#define MAX_PAGE_SIZE 65536
>
> #define MAX_PAGE_SIZE SZ_64K
>
> for improved readability
>
> > +#else
> > +#define MAX_PAGE_SIZE PAGE_SIZE
> > +#endif
> > +
> >  static int virtio_gpu_vram_map(struct virtio_gpu_object *bo)
> >  {
> >       int ret;
> > @@ -150,8 +156,8 @@ static int virtio_gpu_vram_map(struct virtio_gpu_ob=
ject *bo)
> >               return -EINVAL;
> >
> >       spin_lock(&vgdev->host_visible_lock);
> > -     ret =3D drm_mm_insert_node(&vgdev->host_visible_mm, &vram->vram_n=
ode,
> > -                              bo->base.base.size);
> > +     ret =3D drm_mm_insert_node_generic(&vgdev->host_visible_mm, &vram=
->vram_node,
> > +                                      bo->base.base.size, MAX_PAGE_SIZ=
E, 0, 0);
>
> This change only reserves extra space in the memory allocator, but
> doesn't change actual size of allocated BO. Instead, you likely need to
> replace all ALIGN(size, PAGE_SIZE) occurrences in the driver code with
> ALIGN(args->size, MAX_PAGE_SIZE)
>
> >       spin_unlock(&vgdev->host_visible_lock);
> >
> >       if (ret)
>
> Note, previously a new virtio-gpu parameter was proposed to expose
> host's page size to guest [1], if you haven't seen it.
>
> [1] https://lore.kernel.org/dri-devel/20240723114914.53677-1-slp@redhat.c=
om/
>
> Aligning GEM's size to 64K indeed could be a good enough immediate
> solution. Don't see any obvious problems with that, other than the
> potential size overhead for a small BOs.
>
> We have been running into cases where a DXVK game allocates enormous
> amounts of small BOs to the point that amount reaches max number of
> mappings on QEMU with amdgpu native context. On the other hand, it
> showed that adding internal sub-allocator to RADV might be a worthwhile
> effort. We won't change alignment on x86 with this patch and on non-x86
> likely the increased size won't be noticeable, hence the proposed change
> might be acceptable.
>
> Curious what Rob Clark thinks about it. Rob, WDYT?

I think userspace needs to know the minimum "gpu" page size (ie. the
host page size) for other reasons, such as sparse binding.  As Sergio
proposes, we should add this to the virtgpu protocol

BR,
-R


>
> --
> Best regards,
> Dmitry
>

