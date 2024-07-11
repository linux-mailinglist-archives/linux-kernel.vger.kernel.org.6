Return-Path: <linux-kernel+bounces-249838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D37992F093
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 23:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF372B23031
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1644E19E811;
	Thu, 11 Jul 2024 21:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uQhgwhHm"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979041509BC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 21:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720731636; cv=none; b=iiekWw4fDgfyx83aXsWHaKdcjb96nJj842aVWSGrSSJ3KVPAabbvFrdwVkEzFDFAc/21APYvBLBnSI1R9BGOp0drPOwh76bJUhcMMUnwmTXmBFQ9CP58ZlKzRwAfRc1RQS2HgcX0ku9l81ALaX8ly84daWvWMgBPB9gb4TDc1Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720731636; c=relaxed/simple;
	bh=TUygQ/+j8rAfw6jiMmkk22s71Mv2wILJNz65EiwAVSw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z/vzXfsH0CAmuRCDEBYE+VIhn0V1kpR2njJQa+0rISk33hlUlJlaB+tLWcSHbrjcXiHwatfrwM7ai/llm/J0UZJJcI+BKTidHJ9o/jlWoVCswmpw6sH+5jP3wCH5BhsPIVBtFvsJnORjRdcqUMXYapIoPzbZoovNR20m1s8NQ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uQhgwhHm; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4266edee10cso8044135e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 14:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720731633; x=1721336433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66JmoF/QeR3DsXY/A2yKPCjdhMtDcQtWf+drZ4mBEhA=;
        b=uQhgwhHmaF1quglWeD+MeIq38bPRQ9SyUJ8/3yuB5LKr+OCTFv1XjoIgoBz99sYl4O
         P4hd5xHpOwGYQTjQtS/OY8dDnRqxYTe13kpMdoQNtqFgZ3Oh+inexAnfm9kUkBcZU+Gv
         K1eFfKGCRYUxdTqjX0TbY8YYn7nYzP5YNMVGFBhvyT0s+YVEMYEd4yvnm3ACy1HYEbkU
         DGw99+7u5G3RMGnhqK/2OtjHg1ZoZ9EKkNXyKPnrqQFkzZi1uamgKQoQFcMvJ98YSiX+
         EcCsUDYlYAn94G4Z0CDORuvK4gwFuYM7P/bahWmGn2mgbrJjN49HTXepbAgq3nBpeuV6
         eSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720731633; x=1721336433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66JmoF/QeR3DsXY/A2yKPCjdhMtDcQtWf+drZ4mBEhA=;
        b=og3uc8OzXPyRgJDQS4nGaMLEVEqYQiDgjxkymCAWiydHp4KKDE8yTLOXzYrPnOKG57
         8WsvX8wT6V0Wu3vtQ7eRQW1iApeoG6k3+57W3CVaTj4jYvCVp5eTONWC+x367EUP4RBd
         6XCMFmdwYySFsi/8sxvRZzNYvlYxFnxfoV7FK7a9Tan1B/hAQqI6+J90ATcPNEJAb79D
         dHcD6TYTONVuAHH+x8foTVvvJStRIpRV1n7U10uoWgwKisR4xdgpGZIiQP585zkQZ+vI
         Cryof2pS3veSC5J9OQ8BJxWN6i36LUsIuFnSedTE4wEpcqHSwTI3pmN0cRaKeMLxdpa/
         0KPw==
X-Forwarded-Encrypted: i=1; AJvYcCVKzzNdB6OMbXfxsiAY/o5AVy0oTLRWjMorho9Sno0HK9meMAcXQSIbkg3g/evxGihKb9t9l2gVmFLfkIG/Q5537tf4B4GCibR6HlJp
X-Gm-Message-State: AOJu0YylWRf96Sbbdu8Y8Z7OhwMV0uS4voBt/jjE56ll6kQ42uKjhtU1
	T0U9VQGjXI8kas8Z0ImHaGtMOgnkCMmJF54Z86WcfSxvJ98B433u/qsF1SWB+1jdw4G3scJ97Eu
	gLtuh9+mVxgCDEg52r/CFSbwsXio9jB/2iOGU
X-Google-Smtp-Source: AGHT+IHapAG+Jct6S7LNUUD+7jqXhZs5azzCnfIkvskET1tubguYLkqX2/UPvGInXhS7BA4uqni+7IG2uwUy4ekTEcY=
X-Received: by 2002:a5d:4e12:0:b0:366:e1a6:3386 with SMTP id
 ffacd0b85a97d-367ceacaa9fmr6076279f8f.44.1720731632563; Thu, 11 Jul 2024
 14:00:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710140057.347384-1-jfalempe@redhat.com> <20240710140057.347384-5-jfalempe@redhat.com>
In-Reply-To: <20240710140057.347384-5-jfalempe@redhat.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 11 Jul 2024 23:00:20 +0200
Message-ID: <CAH5fLgiVqSYcnS3b2=deGHg+VZk0RQK4HVBbrSrhxNMWYGUQ7w@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] drm/panic: Add a QR code panic screen
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

On Wed, Jul 10, 2024 at 4:01=E2=80=AFPM Jocelyn Falempe <jfalempe@redhat.co=
m> wrote:
>
> This patch adds a new panic screen, with a QR code and the kmsg data
> embedded.
> If DRM_PANIC_SCREEN_QR_CODE_URL is set, then the kmsg data will be
> compressed with zlib and encoded as a numerical segment, and appended
> to the URL as a URL parameter. This allows to save space, and put
> about ~7500 bytes of kmsg data, in a V40 QR code.
> Linux distributions can customize the URL, and put a web frontend to
> directly open a bug report with the kmsg data.
>
> Otherwise the kmsg data will be encoded as a binary segment (ie raw
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
> v3:
>  * Fix all rust comments (typo, punctuation) (Miguel Ojeda)
>  * Change the wording of safety comments (Alice Ryhl)
>  * Add a link to the javascript decoder in the Kconfig (Greg KH)
>  * Fix data_size and tmp_size check in drm_panic_qr_generate()
>
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---

Overall, it looks reasonable to me. Some comments below.

The changelog should go below the --- or in the cover letter.

> +       if (stream.total_out > max_qr_data_size) {
> +               /* too much data for the QR code, so skip the first line =
and try again */
> +               kmsg =3D strchr(kmsg + 1, '\n');
> +               if (!kmsg)
> +                       return -EINVAL;
> +               kmsg_len =3D strlen(kmsg);
> +               goto try_again;

It seems like kmsg will start with a newline character when this retry
routine runs. Is that really what you want? Why not instead strchr and
then do the plus one afterwards?

This would also simplify the logic for why `kmsg + 1` doesn't go out
of bounds. Right now I have to check that there's no codepath where
kmsg points at the nul terminator byte.

> +const __LOG_PREFIX: &[u8] =3D b"rust_qrcode\0";

I guess this constant is because you're not using the module! macro?

> +/// C entry point for the rust QR Code generator.
> +///
> +/// Write the QR code image in the data buffer, and return the QR code w=
idth,
> +/// or 0, if the data doesn't fit in a QR code.
> +///
> +/// * `url`: The base URL of the QR code. It will be encoded as Binary s=
egment.
> +/// * `data`: A pointer to the binary data, to be encoded. if URL is NUL=
L, it
> +///    will be encoded as binary segment, otherwise it will be encoded
> +///    efficiently as a numeric segment, and appended to the URL.
> +/// * `data_len`: Length of the data, that needs to be encoded, must be =
less
> +///    than data_size.
> +/// * `data_size`: Size of data buffer, it should be at least 4071 bytes=
 to hold
> +///    a V40 QR code. It will then be overwritten with the QR code image=
.
> +/// * `tmp`: A temporary buffer that the QR code encoder will use, to wr=
ite the
> +///    segments and ECC.
> +/// * `tmp_size`: Size of the temporary buffer, it must be at least 3706=
 bytes
> +///    long for V40.
> +///
> +/// # Safety
> +///
> +/// * `url` must be null or point at a nul-terminated string.
> +/// * `data` must be valid for reading and writing for `data_size` bytes=
.
> +/// * `tmp` must be valid for reading and writing for `tmp_size` bytes.
> +///
> +/// They must remain valid for the duration of the function call.
> +
> +#[no_mangle]
> +pub unsafe extern "C" fn drm_panic_qr_generate(
> +    url: *const i8,
> +    data: *mut u8,
> +    data_len: usize,
> +    data_size: usize,
> +    tmp: *mut u8,
> +    tmp_size: usize,
> +) -> u8 {
> +    if data_size < 4071 || tmp_size < 3706 || data_len > data_size {
> +        return 0;
> +    }
> +    // SAFETY: The caller ensures that `data` is a valid pointer for rea=
ding and
> +    // writing `data_size` bytes.
> +    let data_slice: &mut [u8] =3D unsafe { core::slice::from_raw_parts_m=
ut(data, data_size) };
> +    // SAFETY: The caller ensures that `tmp` is a valid pointer for read=
ing and
> +    // writing `tmp_size` bytes.
> +    let tmp_slice: &mut [u8] =3D unsafe { core::slice::from_raw_parts_mu=
t(tmp, tmp_size) };
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
> +        // SAFETY: The caller ensures that `url` is a valid pointer to a
> +        // nul-terminated string.
> +        let url_cstr: &CStr =3D unsafe { CStr::from_char_ptr(url) };
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

This looks good to me. :)

Alice

