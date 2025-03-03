Return-Path: <linux-kernel+bounces-541120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D05DA4B8B0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71CFA3A7260
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 08:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0EB1EA7CE;
	Mon,  3 Mar 2025 08:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NBhz+R/q"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347031D79A3
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 08:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740989165; cv=none; b=YvfH8TS9pRnhjpxPFMMuwv4YRkAEZyc4oVJXiiT7zcTmZh8j/gSXNL6pSIaD3I2QT0JzG9248IGCfdb1DuZsCRyGjRW8zpAOoop4RrBHMI7WEtKgSliz83J/ykkG1zbNYqW/rLd+uiDnItZlLbKRo5RtEbY7WfvxPwpp2/6We18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740989165; c=relaxed/simple;
	bh=IH4Qw4OZUiaQzCHILHMnQ5Z2BcYMRjESRbrTXR7+1/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XBp3l0fVBTFNGb7cTRVBB7QQVRbnPKI8R1Anum8P3q2rOs+HEisC6sXPDsIuKnA3GNUC5/WEZ8gtxRs1TwMfhQxfXgJzfMm+dqlafrAP2g6UH+z0R7evDM5DhtegAmzPNA4izeptutC5KDBdXdYiQhQ16oKKQLqb0n6Dc99bw+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NBhz+R/q; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-390df942558so3241552f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 00:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740989162; x=1741593962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0iUVs2ZQh+M1rl5kLkJ/YPcqr6UkD+Cttj33+uPFnc=;
        b=NBhz+R/qqyjfywOFffrgJ1wP0oqlZb2rYxFPhIP/O7rUgP2s43pWZena9MhiSXJo4q
         yJ4Ow7ZdKhZz+IN1wrkCPYn1jsBNwdIts0yllsm9rg/omcslSWjV7EFxrNx31Dq2hn5Q
         PGysDfFx1VPlU1V7Ba87UCvz4GsbwneOYxxmgK0p1pBn6xgcN6Ko63B4orX0JJeCe3gj
         qxk+cDe8BrPdyX/yTLS9DxO0475a2af7aUIkdWbwvjhEt+bzv1nnhcbX35GPuaanE3Nm
         y8F5LCADAa7xpM84SzXL2uLLeqN/FaSqPzBYFbU2DJFt/MehcBNf+zASY1zuP3PktDZl
         fadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740989162; x=1741593962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0iUVs2ZQh+M1rl5kLkJ/YPcqr6UkD+Cttj33+uPFnc=;
        b=fV5xzgDs7aBycPpqj6rVAsm1ePgbseUCDDti8DZVvxboG5/2NV1xUDp+9vmjgxq/ZX
         Igt2BoCRnqWjk4jIbXp/MPSn7mwXmiHin71EdY4kNnh71OBd83PYHfGnlptax3UZWfo5
         awYO3oATC7Zl/1LnCshbkoxUGz+Rad86Dz3EoZ53+ddkssrPxuzGklVvLTD7rNQn0rE+
         Vgcpq0/NsombUsVwEWpjfU5VxtK5jehPDxxwu/7tlhaek1kekGOcpeLr/7lAvHxlEVtz
         Cr/PzzJ6cPI3wJe77nGaU1boX3+fCn038PmnymlDToA9+97+FcsuhJP75vEOhi9gelTP
         ygJw==
X-Forwarded-Encrypted: i=1; AJvYcCUn70MLOPDxP8UaqYTB13juoYItC83zVyCipWg9dj4y8aJR4F5czn6qE95KoMrsc2vqX7WZhtnxQRGukBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVPhDcZd4Bsz5PPud400lIISnpEOBQNt/ZBUl7+g4uLRj+KJOQ
	uFd1OmxD9Uqz1XuJqFkZlWFrqg0j6rjqFW72leyu+guEIpEUNQ39yUJpZd/7ruk+IswcRZj5YAe
	mguxUqjw/PlWUeDJGEsZZMVrecL9NaDmgKLyD
X-Gm-Gg: ASbGncsnL2E1Y47avo3zkFyR6d60PqHlod7dgiEgE4yKFeQHV2PaFVTTKKPEy2p3gjK
	UKfax4aqcG7MBS+4Wa5mP8zEZF91tXneT6F+BDfZ5K0vH77lwCCbG/mSLzvaBzIIENOZcspmoBy
	QaSt+zLJ1mXngUsaA05VqwVvrLCrn6r00EwNFhA1ba2znZ/+omPo8bDsSH
X-Google-Smtp-Source: AGHT+IEk6318AFfc1LcVsJJ84wt3g9PnbPRWzDdM7m2/xTI/OwzWoyIK3cmNaUT7+G0p9cZPZuhg9T+sy8bKgxhf/+k=
X-Received: by 2002:a5d:5f91:0:b0:38f:3c8a:4bf4 with SMTP id
 ffacd0b85a97d-390ec7cd27fmr9441896f8f.6.1740989162420; Mon, 03 Mar 2025
 00:06:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250301231602.917580-1-ojeda@kernel.org>
In-Reply-To: <20250301231602.917580-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 3 Mar 2025 09:05:49 +0100
X-Gm-Features: AQ5f1JrxAQw0Rq7Ilhd1yFsj2dY9VjMUraWB3QJMgYSvaEWDQVWq8PuNQusYF1c
Message-ID: <CAH5fLgjhMfk1vZCc242vKYnTN13Ss23VhVhaAjwU67Z5qhP9mA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/panic: use `div_ceil` to clean Clippy warning
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Jocelyn Falempe <jfalempe@redhat.com>, =?UTF-8?Q?Thomas_B=C3=B6hler?= <witcher@wiredspace.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alex Gaynor <alex.gaynor@gmail.com>, dri-devel@lists.freedesktop.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 2, 2025 at 12:17=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Starting with the upcoming Rust 1.86.0 (to be released 2025-04-03),
> Clippy warns:
>
>     error: manually reimplementing `div_ceil`
>        --> drivers/gpu/drm/drm_panic_qr.rs:548:26
>         |
>     548 |         let pad_offset =3D (offset + 7) / 8;
>         |                          ^^^^^^^^^^^^^^^^ help: consider using =
`.div_ceil()`: `offset.div_ceil(8)`
>         |
>         =3D help: for further information visit https://rust-lang.github.=
io/rust-clippy/master/index.html#manual_div_ceil
>
> And similarly for `stride`. Thus apply the suggestion to both.
>
> The behavior (and thus codegen) is not exactly equivalent [1][2], since
> `div_ceil()` returns the right value for the values that currently
> would overflow.
>
> Link: https://github.com/rust-lang/rust-clippy/issues/14333 [1]
> Link: https://godbolt.org/z/dPq6nGnv3 [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

