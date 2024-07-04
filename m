Return-Path: <linux-kernel+bounces-240789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AFB9272C4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2902285C2B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92E61AAE07;
	Thu,  4 Jul 2024 09:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ljnrOMw1"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9DD1822EC
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 09:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720084526; cv=none; b=nEv4JrLLNK/7HCbYSNdNC8y3dH3KYfy1G2QVeErAXR36wdv6Yhq8R7GM0i8vpV4Q5XDPGDOzeWSp2taUo5FYHSwl/xrvtWQD/rCXFh0DjgIrQDyDTKinbdyOWd3gvAe0zlmnd4WtbZADIvwkW0/wXXxbeWuIXlyYaYRM5VgGJgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720084526; c=relaxed/simple;
	bh=vLvhozs5FjGScJTUM3o90oqywyCN+6LZPhKN49utzhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fSbISUQnJvSgOMAB/DDevP+hklbvw7TQ5dft1886upRp7FArT4cCvvpVq18RhcccQJ4ZaCueA1JSid5H3hkMoLNWlhX/kogYMoBmplFVkv6dpv4p5HLHMlpKvYP+nlToRGn8R4wge0ZxOunercZJ5CRpdksvNHapzaOh2j6HZrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ljnrOMw1; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3678f36f154so232654f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 02:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720084523; x=1720689323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEcu3TbmNikaAxXTCEPk6N6lySiOq4MWvGXvQXKI8Us=;
        b=ljnrOMw1AS+gkHkkrg+sQs1HUNLksGmTCXYn/7MNJRVaPUwrbzlj76BV4/ZV9nYT7x
         AzI0LopSQyVvNZMt1S+O+JxjV4eltdtxg32rHG6NZ7gU9hY7/nGqjFAGX9y7zFQckb6G
         +GALOYtI8XgUx+0jGz93PHC0v5isJVhfme5Ya9J3e0BdGPavAm/t2XSPDV+PmRaoXOIs
         K0oxaU1ivefUG0qct8uWvNfJyzSKa/XfRAZhbCxm7ViZvARDy+jrVb0T5+/LnTQxgy8/
         p8I1bRiD9oQyNjkVMpOa5yoWj2DQIKZyMWLLPqTk+mRZEsuhqsgnd5wvAciN+CmMCknN
         jYgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720084523; x=1720689323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sEcu3TbmNikaAxXTCEPk6N6lySiOq4MWvGXvQXKI8Us=;
        b=GNBrjR72FwrAUzx1KJkD/neJkG1UfwtCpWCs8KTeda0hwdycNdgIvWzGTfuM8+g08A
         Ma9d7tAA/3t2YfWaItx0AgeiZBa+UNAde+NmX0N2AHJgdr4sE3F8i1kQj9SvLNwE3a7N
         3EIRM2bhnaOigCPpV2gXejQbmenzfc+63zTA/Kl51EKYyEgtQ5zpmmQ6V95c/tIWpR29
         TQhD7Ac78qWsSu+jfYAVurKQkFl1GlmsXpoA/rvnbbMpFp8m5KHqEoYtSbPkpt5Plsz0
         v5j4hr/C9OQJr/tQygEGzbJL54gzOYYNqsahiv/HiCw7Qqo31HxANFXN6FcRYWPeWRW3
         mGFA==
X-Forwarded-Encrypted: i=1; AJvYcCVV19GnPgfm71aNK8bMmhVK5KX4G/HpPkpoFIXTGNVIj4Z887Q6BIg0mN+GjBLJhtMqc0cNKsN3hgWFOP8UwRswmlYYXFqR0M1gw39E
X-Gm-Message-State: AOJu0Yx/jF8/5696OjXpb2tgY1Zc9sNMcjmTcvl7SC4KwqXSpL6/fHFB
	30qXUuQJTVIc+PMFQNqHs07hIq71lJy6INfG6i24I40wwkh29WLSOzJm4svMhWbt+a/g9bqobCQ
	GML6aAwxr/frxbjrVd0VnS3AkfD8cdtI1Ci+F
X-Google-Smtp-Source: AGHT+IE/247r/RY0UrlCo6aEEA7oWQssQzwGwJkUeqjFdh0tQShwvHV1WozYijQBpev7QJs4+kVGYg1txqGiSZWkMaM=
X-Received: by 2002:adf:f3cc:0:b0:367:947a:a491 with SMTP id
 ffacd0b85a97d-3679dd443a0mr835906f8f.26.1720084522530; Thu, 04 Jul 2024
 02:15:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703154309.426867-1-jfalempe@redhat.com> <2024070417-husked-edgy-f527@gregkh>
In-Reply-To: <2024070417-husked-edgy-f527@gregkh>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 4 Jul 2024 11:15:10 +0200
Message-ID: <CAH5fLgip4foLGkjzUT4vOCR1m3OgHuOq8u7=Zh+o2Zk2V45FKw@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm/panic: Add a qr_code panic screen
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jocelyn Falempe <jfalempe@redhat.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	Danilo Krummrich <dakr@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 7:03=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Wed, Jul 03, 2024 at 05:33:57PM +0200, Jocelyn Falempe wrote:
> > Jocelyn Falempe (4):
> >   drm/panic: Add integer scaling to blit()
> >   drm/rect: add drm_rect_overlap()
> >   drm/panic: simplify logo handling
> >   drm/panic: Add a qr_code panic screen
> >
> >  drivers/gpu/drm/Kconfig         |  29 +
> >  drivers/gpu/drm/Makefile        |   1 +
> >  drivers/gpu/drm/drm_drv.c       |   3 +
> >  drivers/gpu/drm/drm_panic.c     | 338 +++++++++--
> >  drivers/gpu/drm/drm_panic_qr.rs | 989 ++++++++++++++++++++++++++++++++
>
> Wait, we can put .rs files in any directory now?  I didn't think that
> worked properly yet.

Yes, but Rust code outside of rust/ cannot expose a Rust API that Rust
code elsewhere can use. Only C apis can be exposed.

Alice

