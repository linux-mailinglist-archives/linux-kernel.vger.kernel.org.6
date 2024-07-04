Return-Path: <linux-kernel+bounces-240791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C579272CD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 530111C23E2B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72FF1AAE0C;
	Thu,  4 Jul 2024 09:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I+OrfHHE"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0F3224D7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 09:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720084710; cv=none; b=dva/titCPFZVv21vN8haR9j/HiesYEDOIg0CeXU4eBM5nxzMMqXm0NbnRX4sbMcvVLfNuSwtSbPkUBNH8x5JisoPp/v4GtC42BiSof63fx7hmS+WyfoiTew5t9jSm/sIHusaaeENoZgpX1cyyPQm4ui2azFfLkxxzKwNyYe8AK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720084710; c=relaxed/simple;
	bh=iEeLIELZmxZYQGTpKGiZW5OYyupUG2iO+QO0tj8NSEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oR0Z+w0ta9pyZgRxcakEiayeRFRjg6Ap/iJ1SLrzUgYh94528xXMS18K7cl0xnieGQmaiq6eYYR3fgcUbLYpqjRFDNwYQtP49rim2VOdRl+7N9dRTaMXR0OWUv15+y/WQVXm7pwgu3NbjVSumcFA9AwQk0QeXxvkXgN8VKgnKDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I+OrfHHE; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-367990aaef3so297278f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 02:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720084707; x=1720689507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p1siA8LLoevKDKKIOxF172G452ajSvMRpJAHFo7rSfQ=;
        b=I+OrfHHE2S+qcwoZZ/N9FD4xSkAJEGRUpf2RkoVC1GSid3CEDQ1OgWw31QxVZzYlIw
         F8FCwucaRBl0BCWlkLJBNExbJEyWdNJJttpbdp/gmokvt6aYiYb004TpYwEZ749Yd0eq
         qbwrOqbuGeD+5TcMo/iy2DkgC6zk0tnZAruA8Q7SYhhQdDvHlL+TFHPc+UPZ7F4ta0WO
         qOpZzfRAS5Hu36+NosOsXdoBb1h2MUzWGkeo8kfi1hb9GhZlCGD9Ay9s4p2nLV75X5oa
         q0FSv84EFNYxU2vOZHA1erw/3zMmCvp9i42mTnTntWgPjQNMpwhdSum/hC62BwRN3z5J
         PixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720084707; x=1720689507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1siA8LLoevKDKKIOxF172G452ajSvMRpJAHFo7rSfQ=;
        b=vJpkWvNUgaYbG9fPFzUf0gYIfPct5frAChaMUs15jIeBT0m3Uo0UYVRl/PKFjfi10L
         qDNy42j1EsC4GSBGw6yFsCVqtQO8AQvoWAicuTUDc59QjyE1mmq3fuSYgs1DFqeLNkSu
         Gck0XUOm5txOGViU9QTooAtIYFEOmQWzVb+T3DgiCd1h8DHD6HWQDuKmeZhtGTaIK7cQ
         XqsqhJVf8gCt1hlCU6pfzlJO5NfzuCVxC264s0I+zlChZ3PXuhcxWgTDna7vhpxXz7vZ
         2pf7/iMnrbw76vrShXJ/RGyZZucyCDg2h94aaZtlz2lWYxArOWu7vYXUc24Fhb9oPbV1
         jZrw==
X-Forwarded-Encrypted: i=1; AJvYcCWaZSJJcl0rKDzJZjz1vIZjSC7VKDJO8Td02wvWl1nm5Y7eDU/8mypAJTkaoC3qjwOmwLGQ92IrFkya3BgluPhO05wEbm9RWGKMBiwR
X-Gm-Message-State: AOJu0YyM4WgpoQthgRrIW1T9FH3LRONdl7FwNByzH4XHmInHS26othkM
	ABqp7Jtfj1o5DsJn3cutjeU6iG2f2lDiQ0pF6+zO3vAOhOo7uZLT4ksMJldlywLGUkd1+I4wY98
	6jDx5iM/aL6GM5Mw3OB4dGbj3ELlz3kx4nz7U
X-Google-Smtp-Source: AGHT+IFDgMZlhl3+7CRvoFM3LiPflhjLDBkW54oSybDEdceJuKcTIyZ3CTjKPpH4LrPW254W2NPoHOZL4/rZiAuJOxY=
X-Received: by 2002:adf:f888:0:b0:362:2111:4816 with SMTP id
 ffacd0b85a97d-3679dd67eb8mr836362f8f.55.1720084706628; Thu, 04 Jul 2024
 02:18:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703154309.426867-1-jfalempe@redhat.com>
In-Reply-To: <20240703154309.426867-1-jfalempe@redhat.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 4 Jul 2024 11:18:14 +0200
Message-ID: <CAH5fLgiMJZYhSiBVc7r3HP0VTCNVG=FuD68v-ni4=54t5vVPwQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm/panic: Add a qr_code panic screen
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	Danilo Krummrich <dakr@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 5:44=E2=80=AFPM Jocelyn Falempe <jfalempe@redhat.com=
> wrote:
>
> This series adds a new panic screen, with the kmsg data embedded in a QR-=
code.
>
> The main advantage of QR-code, is that you can copy/paste the debug data =
to a bug report.
>
> The QR-code encoder is written in rust, and is very specific to drm_panic=
.
> The reason is that it is called in a panic handler, and thus can't alloca=
te memory, or use locking.
> The rust code uses a few rust core API, and provides only two C entry poi=
nts.
> There is no particular reason to do it in rust, I just wanted to learn ru=
st, and see if it can work in the kernel.
>
> If you want to see what it looks like, I've put a few screenshots here:
> https://github.com/kdj0c/panic_report/issues/1
>
> --
>
> Jocelyn
>
>
> Jocelyn Falempe (4):
>   drm/panic: Add integer scaling to blit()
>   drm/rect: add drm_rect_overlap()
>   drm/panic: simplify logo handling
>   drm/panic: Add a qr_code panic screen
>
>  drivers/gpu/drm/Kconfig         |  29 +
>  drivers/gpu/drm/Makefile        |   1 +
>  drivers/gpu/drm/drm_drv.c       |   3 +
>  drivers/gpu/drm/drm_panic.c     | 338 +++++++++--
>  drivers/gpu/drm/drm_panic_qr.rs | 989 ++++++++++++++++++++++++++++++++
>  include/drm/drm_panic.h         |   4 +
>  include/drm/drm_rect.h          |  15 +
>  7 files changed, 1340 insertions(+), 39 deletions(-)
>  create mode 100644 drivers/gpu/drm/drm_panic_qr.rs
>
>
> base-commit: 3f5ea7ed705e8effe9cfabf912e769ccb6b7d389

I tried to apply this patch, but I can't find this commit, nor could I
find any tag that it applies on.

Alice

