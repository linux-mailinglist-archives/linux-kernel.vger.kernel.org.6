Return-Path: <linux-kernel+bounces-363506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F24799C346
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4EC3B23B3B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D9F15DBD5;
	Mon, 14 Oct 2024 08:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VzxziGyy"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82883156C5F
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728894486; cv=none; b=GXC0NzVSrZ/T8tKinwi/QT6SZsOh1n5z/D8SbhW3ruDO7lmdouEJiPS9KwW2C16OdJapNE/7cD7SGENO/Dwz+OxcINVTcAb8hbPzAcf9B3kYPzfOvDspgMizyX2uLfn/JItFTZw3UZOWi0HoNLMnbEXgoK3lOyzilzUSVrENh+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728894486; c=relaxed/simple;
	bh=4fZ/6m33GTNrbpNkrlKeyN/Jq7/li7hFF7obcIo4I7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WUdju9pNaOhRY8o7EyR7kjNnlgmpmCpQcexjOqOv5DN366FjiXvJ/yEX84hZ31RI3hzOCj/3ZO47SF4m0ZuZ6OQtGeJOQJZzGblLFlxURaNhMxrvx4nf2rbjmj+meEqUWDKXfGSLHS5KdUGARzhDRg0H5+zGyrpLbCf4Uz3+2AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VzxziGyy; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d51055097so2276428f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728894483; x=1729499283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M24dNzd553xNHb5Y8IIcUeoG1f4DjGolZJ5waiH250E=;
        b=VzxziGyyjk7Kj6XZhJhr0Y0Ldyumoq+Re2p8sxwEG2LSXrebpiLXofwQxoqjiHp59M
         qdRaFTBHWpW/5XlcuFcnfscjUyIkcUDcJqgzu7dqvcA3m5esNmrPkI+ikp4iIGnZFnQh
         LFWciCIIF5t/bI6uFvQhL9js/UOjlMg2cZRXxD+0PI5SgsHp/xApHbVCUrN4TmS12Wvs
         XF78wT5yb4vWowI51GBMjVh+qw/gmkJKeuGj9NU1t1CAA1epxjOycnM+jMcFQFcQQESl
         zQmL0RRIGZXAWMyfclN0ENEKEphIWP1bnr5cTD+PNndSdIPoxifFYZhTXBX9dtv9SJvG
         o6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728894483; x=1729499283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M24dNzd553xNHb5Y8IIcUeoG1f4DjGolZJ5waiH250E=;
        b=H89PmW5nuLkmWiLGhq3ZVQquM5w5lEgulTNAAyWsO9N+StiHX29B50j0Vn2nlmLgN3
         tPR+VUFGiC096ITZ5Rdecq4ccG+jpRKijkyl7nbRCtETBccEV2vqVbyizy+9bHntN6iL
         fcFLUu/WLonUkKyF5V26zADkoXSTYTFVgXfXtIUTPPwd/G0ZG+f42h+swLYIhDxmsKQe
         0tSBf34Nh2NZUfJgEdtLrwmcZSVaDyBrkN65l5gN4NUhB/8KsxHoQoMqTej7WPxtJ5Fb
         WiZbxQQ+qLNPYUOmBQg1QnFfqSePM1hta6yncrVej3GESwIBsZaHGJU3PT1Vnfbud6Ku
         t5ow==
X-Forwarded-Encrypted: i=1; AJvYcCUZXM1DhR24RMv5BK4bqTsqSad+KaLcv5eh6DwFbKZn1lTxqhTBD57HIfPVa6GnURAjEFS+GgSMhx91hB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6WAMhwpXUKYHHYbj++wmRyV7DTbHQ430IC7aM1b6+Uvlb9CKG
	9aarV7sJxifYAPx2YwXeVXrZxkPpeRLcnpR6FYj6wzYl8k+KYBVLW6bdawTmRCx+m2E8om+LWpU
	MmI4CAQtuecTTZlzXcq4ClAvRb/Ae0sMyV9aN
X-Google-Smtp-Source: AGHT+IFB8FFfnlqFKW+nSLnk8WRApZWwjOS9gnyongi0gtF4ICZpB2dBUY9HOCSQhExNJfIuKbhQl4ZLD9UDKKJLEjY=
X-Received: by 2002:adf:a1d7:0:b0:37d:4833:38fa with SMTP id
 ffacd0b85a97d-37d5ff2c01cmr4561294f8f.21.1728894482691; Mon, 14 Oct 2024
 01:28:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012075312.16342-1-witcher@wiredspace.de> <20241012075312.16342-6-witcher@wiredspace.de>
In-Reply-To: <20241012075312.16342-6-witcher@wiredspace.de>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 14 Oct 2024 10:27:49 +0200
Message-ID: <CAH5fLgjU3bvDrOsvyxBcCuGOsmbuekrh0Ccy+La_MgHrMEncvQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] drm/panic: allow verbose boolean for clarity
To: =?UTF-8?Q?Thomas_B=C3=B6hler?= <witcher@wiredspace.de>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Jocelyn Falempe <jfalempe@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 9:53=E2=80=AFAM Thomas B=C3=B6hler <witcher@wiredsp=
ace.de> wrote:
>
> Clippy complains about a non-minimal boolean expression with
> `nonminimal_bool`:
>
>     error: this boolean expression can be simplified
>        --> drivers/gpu/drm/drm_panic_qr.rs:722:9
>         |
>     722 |         (x < 8 && y < 8) || (x < 8 && y >=3D end) || (x >=3D en=
d && y < 8)
>         |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>         |
>         =3D help: for further information visit https://rust-lang.github.=
io/rust-clippy/master/index.html#nonminimal_bool
>         =3D note: `-D clippy::nonminimal-bool` implied by `-D warnings`
>         =3D help: to override `-D warnings` add `#[allow(clippy::nonminim=
al_bool)]`
>     help: try
>         |
>     722 |         !(x >=3D 8 || y >=3D 8 && y < end) || (x >=3D end && y =
< 8)
>         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     722 |         (y >=3D end || y < 8) && x < 8 || (x >=3D end && y < 8)
>         |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> While this can be useful in a lot of cases, it isn't here because the
> line expresses clearly what the intention is. Simplifying the expression
> means losing clarity, so opt-out of this lint for the offending line.
>
> Reported-by: Miguel Ojeda <ojeda@kernel.org>
> Closes: https://github.com/Rust-for-Linux/linux/issues/1123
> Signed-off-by: Thomas B=C3=B6hler <witcher@wiredspace.de>
> ---
>  drivers/gpu/drm/drm_panic_qr.rs | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_panic_qr.rs b/drivers/gpu/drm/drm_panic_=
qr.rs
> index 58c46f366f76..226107c02679 100644
> --- a/drivers/gpu/drm/drm_panic_qr.rs
> +++ b/drivers/gpu/drm/drm_panic_qr.rs
> @@ -719,7 +719,8 @@ fn draw_finders(&mut self) {
>
>      fn is_finder(&self, x: u8, y: u8) -> bool {
>          let end =3D self.width - 8;
> -        (x < 8 && y < 8) || (x < 8 && y >=3D end) || (x >=3D end && y < =
8)
> +        #[allow(clippy::nonminimal_bool)]
> +        return (x < 8 && y < 8) || (x < 8 && y >=3D end) || (x >=3D end =
&& y < 8);

Surely introducing a return statement causes another clippy error?

You can do this:

#[allow(clippy::nonminimal_bool)]
{
    (x < 8 && y < 8) || (x < 8 && y >=3D end) || (x >=3D end && y < 8)
}

or just put the allow on the function.

Alice

