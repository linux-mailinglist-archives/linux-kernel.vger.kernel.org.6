Return-Path: <linux-kernel+bounces-245549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B87C092B437
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 11:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F09E9B22765
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0558155C8E;
	Tue,  9 Jul 2024 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wO+81jDc"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4951553A7
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 09:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720518105; cv=none; b=YrBrKhtTrzKKy/DQBI/YH41eew6MxjDknbnOjj4YeXGzvDh7oAfJ3QDB6dwmgVglZ5bZcioa/Q7shaV8mQcJt2VWglAyII4O8W78K0riBdrkOeu2GQ7uNiC9rk58S8/yK3Ugv47uNVX4/9407ZPXLWSLt3A0Ob6SMe5juYtU59k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720518105; c=relaxed/simple;
	bh=OVic1D3bXJjoJN/kiWr29pgPclMVMHNBoDKkoGJHFJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aKlSbVoSGtdD7A6qZXpld5rwFfZI544+cZZc/SzzJbMUNCZk2x7h6NhuxFu6U2r7ArksDqjOCweYtDzaj4TkO5Qbba9fDPA4sEbdOS0BZQUVkt8YQKYroeCQPs0Hz5QMi20NEE6mmuO79pDIM8iMiXKO6mhNg7s4nHBw0Ua822U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wO+81jDc; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-36796aee597so3261869f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 02:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720518102; x=1721122902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAZt8GtzurYosVReDcWXFfiP8YdX7GkjA3wsNUYSUA0=;
        b=wO+81jDc9w7jaUVRsGwUO9/7JXRG7ElA29JVWKj2Y5GYKLxRdUJNR1hpngLVv1/OQh
         uxHJda2hlv0bHweM7RygxPTToM+LJnt+itmErAY7yosrm3piTOG9istwV2eImlzO3zeL
         VAkFZDVwOBk+io9/VlgZH98v/Ui8AV0cRHQ6F7C+FnCdWacpp1VG3vj9p6rPR7aNGW6J
         uUwkCPH/tWTK1ligS5PjBCbns/DCD9LdKNvlXPJSqxSqcTlgQiG/QtUj2y0O7AGRXEmK
         HBGJqOnhGt5FEXkjSxe1VbfjFR+V8DolgYfHdX+tfwTveTaSqQZVjmrqi4r4Rz6+yiaj
         TxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720518102; x=1721122902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAZt8GtzurYosVReDcWXFfiP8YdX7GkjA3wsNUYSUA0=;
        b=N7+d/hq/1rsAjlhQlXZsRJVcfMbzFKSVWsvsJIAdgb0ptNOaqbV7DJ/oMHx+EIhxi/
         lQsBg59Bwi/MFl16wk5S9kQ9ognfdtjUWMqBVKStoWp32JRJQwsvyk9rFKvHkI9y0DQr
         IUteVpl8JBsFUiBbg2aAQK+VgkY1ra5MTg+SoFH2WbZS8NkF8+vWAvo9EnO3v/OxivAs
         3yaMc/Yv5i/1pdRP3mRyhk1d8rA/1TVbV3rAj/cFGPPIhs8n176FfV21FIoFWa2rJyBZ
         crJKdLsnqB1LXOv7G0TrUKGpz2x//hRgdjrNoDvJpKZx/Ga4fDvnZVbSVFNBXQIvzPgp
         e4KQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1HCcZ1RNJqFaE/Hd7n+vJv5ixGpNIK/BJgTwUa2l6J2gaQ2IXtCdWaJB7Kv9A3KbOtDoIur4AhNIPEg+soey7LvL9Q6oPEPY+DJHh
X-Gm-Message-State: AOJu0YzTqgsZ8KIiDmOOnmnqr8W/AjKbFNTGMA69WoHJMMpQmHWSlMfF
	rCxUqDvG6wwCZRtO01snChapTTqPgl+NFO/nTVCMWsurOaNU7FEQfXg+TsQHh8mZy7BvQ/ICqvc
	D0aWJCNa1kBYogFsN0/2g16mtzlAiuQENS/KW
X-Google-Smtp-Source: AGHT+IGR9yHQ5VjkQb02n11rV5m/nD2z1+GzQbrI8bQfIRwcFNZ5ZAorDCFB5Yu93sLbwZrEWDDYx07QGU+HUmU2sGI=
X-Received: by 2002:adf:fecc:0:b0:362:40cd:1bc with SMTP id
 ffacd0b85a97d-367cea73537mr1228764f8f.24.1720518102260; Tue, 09 Jul 2024
 02:41:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709084458.158659-1-jfalempe@redhat.com> <20240709084458.158659-5-jfalempe@redhat.com>
In-Reply-To: <20240709084458.158659-5-jfalempe@redhat.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 9 Jul 2024 11:41:29 +0200
Message-ID: <CAH5fLgh5fb_NYUNPPXYepJg=pbmHAb+-+sOrCxc0n=fiNjTFTw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/panic: Add a qr_code panic screen
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

On Tue, Jul 9, 2024 at 10:45=E2=80=AFAM Jocelyn Falempe <jfalempe@redhat.co=
m> wrote:
>
> This patch adds a new panic screen, with a QR code and the kmsg data
> embedded.
> If DRM_PANIC_SCREEN_QR_CODE_URL is set, then the kmsg data will be
> compressed with zlib and encoded as a numerical segment, and appended
> to the url as a url parameter. This allows to save space, and put
> about ~7500 bytes of kmsg data, in a V40 QR code.
> Linux distributions can customize the url, and put a web frontend to
> directly open a bug report with the kmsg data.
>
> Otherwise the kmsg data will be encoded as binary segment (ie raw
> ascii) and only a maximum of 2953 bytes of kmsg data will be
> available in the QR code.
>
> You can also limit the QR code size with DRM_PANIC_SCREEN_QR_VERSION.
>
> v2:
>  * Rewrite the rust comments with Markdown (Alice Ryhl)
>  * Mark drm_panic_qr_generate() as unsafe (Alice Ryhl)
>  * Use CStr directly, and remove the call to as_str_unchecked()
>    (Alice Ryhl)
>  * Add a check for data_len <=3D data_size (Greg KH)
>
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>

[...]

> +/// drm_panic_qr_generate()
> +///
> +/// C entry point for the rust QR Code generator.
> +///
> +/// Write the QR code image in the data buffer, and return the qrcode si=
ze, or 0
> +/// if the data doesn't fit in a QR code.
> +///
> +/// * `url` The base url of the QR code. It will be encoded as Binary se=
gment.
> +/// * `data` A pointer to the binary data, to be encoded. if url is NULL=
, it
> +///    will be encoded as binary segment, otherwise it will be encoded
> +///    efficiently as a numeric segment, and appended to the url.
> +/// * `data_len` Length of the data, that needs to be encoded.
> +/// * `data_size` Size of data buffer, it should be at least 4071 bytes =
to hold
> +///    a V40 QR-code. It will then be overwritten with the QR-code image=
.
> +/// * `tmp` A temporary buffer that the QR-code encoder will use, to wri=
te the
> +///    segments and ECC.
> +/// * `tmp_size` Size of the temporary buffer, it must be at least 3706 =
bytes
> +///    long for V40.
> +///
> +/// # Safety
> +///
> +/// * `url` must be null or point at a nul-terminated string.
> +/// * `data` must be valid for reading and writing for `data_size` bytes=
.
> +/// * `data_len` must be less than `data_size`.
> +/// * `tmp` must be valid for reading and writing for `tmp_size` bytes.

You don't allow data_len =3D=3D data_size?

> +#[no_mangle]
> +pub unsafe extern "C" fn drm_panic_qr_generate(
> +    url: *const i8,
> +    data: *mut u8,
> +    data_len: usize,
> +    data_size: usize,
> +    tmp: *mut u8,
> +    tmp_size: usize,
> +) -> u8 {
> +    if data_size <=3D 4071 || tmp_size <=3D 3706 || data_len > data_size=
 {
> +        return 0;
> +    }

Since you explicitly check the data_len, it does not *need* to be a
safety requirement (but it can be). Even if it's wrong, violating the
requirement does not lead to memory safety.

> +    // Safety: data must be a valid pointer for reading and writing data=
_size bytes.
> +    let data_slice: &mut [u8] =3D unsafe { core::slice::from_raw_parts_m=
ut(data, data_size) };
> +    // Safety: tmp must be a valid pointer for reading and writing tmp_s=
ize bytes.
> +    let tmp_slice: &mut [u8] =3D unsafe { core::slice::from_raw_parts_mu=
t(tmp, tmp_size) };

These safety comments explain why these calls are dangerous, but
that's not what safety comments should do. They should explain why
this particular call is okay. In this case, it's because the caller of
drm_panic_qr_generate must follow the documented safety requirements
of the current function. The wording could look like this:

// SAFETY: Due to the safety requirements on this function, the caller
ensures that tmp is a valid pointer for reading and writing tmp_size
bytes.

The wording is not much different, but it's an important distinction.

(Also, safety comments are written SAFETY: not Safety:)

> +    if url.is_null() {
> +        match EncodedMsg::new(&[&Segment::Binary(&data_slice[0..data_len=
])], tmp_slice) {
> +            None =3D> 0,
> +            Some(em) =3D> {
> +                let qr_image =3D QrImage::new(&em, data_slice);
> +                qr_image.width
> +            }
> +        }
> +    } else {
> +        // Safety: url must be a valid pointer to a nul-terminated strin=
g.
> +        let url_cstr: &CStr =3D unsafe { CStr::from_char_ptr(url) };

// SAFETY: The caller ensures that url is a valid pointer to a
nul-terminated string.

> +        let segments =3D &[
> +            &Segment::Binary(url_cstr.as_bytes()),
> +            &Segment::Numeric(&data_slice[0..data_len]),
> +        ];
> +        match EncodedMsg::new(segments, tmp_slice) {
> +            None =3D> 0,
> +            Some(em) =3D> {
> +                let qr_image =3D QrImage::new(&em, data_slice);
> +                qr_image.width
> +            }
> +        }
> +    }
> +}

Alice

