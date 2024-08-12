Return-Path: <linux-kernel+bounces-283526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 762FF94F5ED
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 19:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B1581F23DAA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D19188CB0;
	Mon, 12 Aug 2024 17:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8QaqPoL"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4FA191
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 17:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723484332; cv=none; b=LfqLRzRLa1XvH4m8uM4KksBUxBAbUHZRXL/FeYyjKCfPy3YWKqiEd2YKsZVgb+f78DYfMQZugTZEy6dFvW/eI1+DJ93TlmeeFFxZEumH4XIrbhiMjB8kd9szch/6bsZmYbKXA1j978tJZ+8guGdirKTAG9eiSpsSdlwVQj6Az1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723484332; c=relaxed/simple;
	bh=XWK4WpVW0Cuc1CBrzMjdCojonJY9yaR5KHBWBOXOfA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7rGYbS9YMVv0ic2NOHvIwfzaReo5EUcLGFl/nACdP38xmTssMr7dwx7GXOC0LBCPYYi1YCcVT84Q4Hola0xdMkSiCve3j8Ifgz47mm97G67pL2x95D+Vvcwq/MJ3g55vhCbkTUrSI2GXmsJ+DFhY1W190t6CU4Xnh+p9vuaEbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8QaqPoL; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7b0c9bbddb4so3089949a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 10:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723484330; x=1724089130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCcUv37+5u+4JJZrsFb/7pw4tBFELLMTnMEqEoQVdH4=;
        b=m8QaqPoLTv/BYzzxLQ+03LXyN227be4LTFTkwtKsfeeynFy+bOLUV9TXDLPrs6U6/a
         +lTWTm4ZihSogFmK3NIzGDTYXI+W7HgJ6PN51weuPYb2c/3zXdOpPt3Z2EgAE/i+eQNX
         xYDQGxDvDKBUYMzRthcFdu5ewjqG7elsmpewqARQTuo9SAuwq5k9w614adNY26RYBF+X
         3b7nVtfouOh3IG7s7E6ZFDtzN0SXAXQvpXWO1JGpnO6J82HViAh07vtzpakWXl+DIagJ
         qCGHTil7AZ5f7r+g5dpGcnKM01fGi9Myy+ass6R/Yh9Hu7n+HNLzjQmE1nXN7xA6r77u
         0yWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723484330; x=1724089130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UCcUv37+5u+4JJZrsFb/7pw4tBFELLMTnMEqEoQVdH4=;
        b=PCfvl26AeobstFBYY7E+BE1iflBnlIUYE7u5UdF+QGhDWYgNuxmetq6g9nQ/BP3rXU
         UaRQWV/L+NXqMqxvLTI7jz/yR4dcEHBj/1zVGoGtX7cLUrtfGP2OTCmEx6JFukg6Y1Ul
         BFr4i2JT+j7IyuNhePuOCuoD/+L3Vv+lujfkS1q5/D81i4CjUJKYHn+OXS1ZR62k2TX2
         GZ29yXn+JG7sX0j/CdHqxGf4Qu68wWjaTKeXzjZLHFMoKhP4r/CJgyB7TTmqnTubUG2r
         tLbD8SqPrGvMqBk8ezxMVkNwfekCebbsMTwGgwORrEjqfG+3ExWVooUymVVL5p7t0WUS
         uugg==
X-Forwarded-Encrypted: i=1; AJvYcCXlg1aYoYvZnF8cyB0W7fc3RgGepyCt/e9RDIuPwvQaoXiVnAPDDlNBd6UPedVsSfBapmQPI6UOpILPn2M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6ePYDjlVnyzjCGZ6yS0McSTY9GoOpIHH3Eeuqs33ASuxe0vYL
	rkAYsLQDOI4nVAgVHbTYUYUtUXXbIb4CtWT3P35+2gY+lNVn16PoalJ15EWursaEALe7Vl5wM+T
	3NZdDszXnFAiCO5RDnMtcYhv11Cc=
X-Google-Smtp-Source: AGHT+IEETFkUFMiB+Heqo+VnA9kEyVCdmT5SYzP1RMkK/lQejNf3TtG0pnwU6umMb5g1gdhmWhPw4mAGOdVf0T4Okj4=
X-Received: by 2002:a17:90a:d794:b0:2c7:ab00:f605 with SMTP id
 98e67ed59e1d1-2d39254ebe9mr1008725a91.20.1723484330316; Mon, 12 Aug 2024
 10:38:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230724211428.3831636-1-michal.winiarski@intel.com>
In-Reply-To: <20230724211428.3831636-1-michal.winiarski@intel.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 12 Aug 2024 13:38:38 -0400
Message-ID: <CADnq5_NwDn5DXPadzZtegUJ=y=LfVHykO7kG3edmiqRTTCxMNQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] drm: Use full allocated minor range for DRM
To: =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, 
	Pekka Paalanen <pekka.paalanen@collabora.com>, David Airlie <airlied@linux.ie>, 
	Oded Gabbay <ogabbay@kernel.org>, Maxime Ripard <mripard@kernel.org>, 
	Emil Velikov <emil.l.velikov@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, James Zhu <James.Zhu@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Are there any objections to this series?  We have been running into
this limit as a problem for a while now on big servers.

Alex

On Mon, Jul 24, 2023 at 5:15=E2=80=AFPM Micha=C5=82 Winiarski
<michal.winiarski@intel.com> wrote:
>
> 64 DRM device nodes is not enough for everyone.
> Upgrade it to ~512K (which definitely is more than enough).
>
> To allow testing userspace support for >64 devices, add additional DRM
> modparam (force_extended_minors) which causes DRM to skip allocating mino=
rs
> in 0-192 range.
> Additionally - convert minors to use XArray instead of IDR to simplify th=
e
> locking.
>
> v1 -> v2:
> Don't touch DRM_MINOR_CONTROL and its range (Simon Ser)
>
> v2 -> v3:
> Don't use legacy scheme for >=3D192 minor range (Dave Airlie)
> Add modparam for testing (Dave Airlie)
> Add lockdep annotation for IDR (Daniel Vetter)
>
> v3 -> v4:
> Convert from IDR to XArray (Matthew Wilcox)
>
> v4 -> v5:
> Fixup IDR to XArray conversion (Matthew Wilcox)
>
> v5 -> v6:
> Also convert Accel to XArray
> Rename skip_legacy_minors to force_extended_minors
>
> Micha=C5=82 Winiarski (4):
>   drm: Use XArray instead of IDR for minors
>   accel: Use XArray instead of IDR for minors
>   drm: Expand max DRM device number to full MINORBITS
>   drm: Introduce force_extended_minors modparam
>
>  drivers/accel/drm_accel.c      | 110 +++------------------------------
>  drivers/gpu/drm/drm_drv.c      | 105 ++++++++++++++++---------------
>  drivers/gpu/drm/drm_file.c     |   2 +-
>  drivers/gpu/drm/drm_internal.h |   4 --
>  include/drm/drm_accel.h        |  18 +-----
>  include/drm/drm_file.h         |   5 ++
>  6 files changed, 69 insertions(+), 175 deletions(-)
>
> --
> 2.41.0
>

