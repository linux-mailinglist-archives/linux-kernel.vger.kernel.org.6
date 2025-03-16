Return-Path: <linux-kernel+bounces-563169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED105A637B9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 23:36:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83FCA3A2437
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 22:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C1B1D9A41;
	Sun, 16 Mar 2025 22:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmzhmhPC"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EE2440C;
	Sun, 16 Mar 2025 22:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742164575; cv=none; b=Rx/scPjJX1IFIQfABVMUiXHUnJCOj//zpgepxB7GyL3MiehizawB799FmnA/npegvmkyJtGae1kQhpKit0X47uYxM/KOHLVKEDbhF15kV2FOKTIuFia6LvR5TR/tO5NpeulaOXCec/JyaoCS7hTcbTb5Pedr6AkAyiD3pJTBWys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742164575; c=relaxed/simple;
	bh=kt0O48FuAjP5LucVvScWVeqIBNBWf1EsAk6Ld5xIDKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TsqLo+3cK3/kfMOnoouP6x4rsbKeE27cofpxiGby/E0ZYJY2JxqBR7z1A63M5pe+QrSmkwqemutn+aLMknCw9BAqWmoS/iET6JWEx7PNuKXm8lmD4NPHnZn6ZlVnNaHBHwojrAZYnCVgROmNGv9tfUPa/s8oDBFXo0LEfbqjWZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmzhmhPC; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30bee1cb370so42794981fa.1;
        Sun, 16 Mar 2025 15:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742164572; x=1742769372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yeeodoWFWlRe/96AxarBGz8Op5jJs+YV7uun49F/ag8=;
        b=WmzhmhPC7oMiqIFkh+jTcyZI9qr2GgSYOeazmN0RzMqmiYirmCy/TX6jpfRzPWlFza
         ZQewT3FIXH+dPG0svOs90bJQjb3yhD5IlmrxjXFc6H7wI0+A2VU3b1WC/VWmyR+JqC4s
         93kUFm2D82G4O9ybT5VETv+1qvAAUk3iD7gdSDp1Dmu5n/tyyJLl4Fa3v7IaYr21M1kE
         XwT2CskTqBbvRqWSasNRJbMqqzuwuOBPWB0prkhgcdheByGbtmB1BQoDUV4hLT2NwnEh
         ja5auvTO7xdfQiD5XQgXy37Md1T9b5ObopLRmyq+s3oADpgIrRD261SktWsG4Gbwdscl
         C4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742164572; x=1742769372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yeeodoWFWlRe/96AxarBGz8Op5jJs+YV7uun49F/ag8=;
        b=FuDUeYa3Wf/IxkUwENznmu+SQHlqhivGrQ12UlOwkXonHzO+baxNudzvCMZ9mZLMcP
         +7W/qQVxl1OLerKjhuUGj8XjbNmF22qjCroAHVpJ2eHOFbdOhzKAaRQ/Sfrm+Hkwlg0J
         j/mFSb+mD7d9scL8C0Uq7wzHC2nlTbcQS2O5Xf6JYkRypFBOQ8/6tOgfx9AijMpKcOnL
         VVexzEHbH31Fu3d9c2q+IJNFKItbrrU3tKZ8H6B3G3C/mpyBpD3SYTJ+CUrWZAsTNJss
         5OMWv989qxRDCa7/XBJyO9jBrSSz3UI6NrAJ4nJTbi624hji/Zet+wPPq5JhYjVCwbeS
         soBg==
X-Forwarded-Encrypted: i=1; AJvYcCVTeegzMdcaImEK/63tpjfUuv4JpN6nXr4MSGO2X7/C8SWdyYCRuHgMMYHcgnadg1WnZMV3irVPNHmbDq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5lkS89FwRwUoNCZzshUd8MT6yy7FchD7VbImkELQ2OaksSHov
	X7L+5CpUXJ7aLeX9+JvWCzeHcDWZmKdQT5EcP3rFxsYKrxAsw2Zd4+mhc5BLIL0j4YvebxJHbfn
	/WQzfaVou+EENUPuOBo1shYVhqOE=
X-Gm-Gg: ASbGncua9yRviQTh7GHhHGDPlnH2Y2G4EARwU6kSOKUeR8g7dmv/Umy1Bcoe0IpPBdk
	tHC5AA3uyUTM5K+z9QrM9u4AkQ/KQOMahkmPsLzWvw8UFbKMpqLi6rm25R9aYGGV9OV0iCyfDC2
	4SjF0c6dUFt1mQRYVs2ZpRu/XLlWpX2NrLSJFVWN2iTvxbZGIqVyxVBBeaw/5f
X-Google-Smtp-Source: AGHT+IHmyZVE0TCKoRNYuPfm1HaBQHNAIUbtIUZNu4Irho0aT5jLUc44c3M57JucWG1ifODgBH60gyBvdDKkHnQedkw=
X-Received: by 2002:a2e:bea2:0:b0:30c:7a7:e85a with SMTP id
 38308e7fff4ca-30c4a8769f1mr51463961fa.21.1742164571445; Sun, 16 Mar 2025
 15:36:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250316-vec-set-len-v1-0-60f98a28723f@gmail.com> <20250316-vec-set-len-v1-2-60f98a28723f@gmail.com>
In-Reply-To: <20250316-vec-set-len-v1-2-60f98a28723f@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 16 Mar 2025 18:35:35 -0400
X-Gm-Features: AQ5f1JqdNpKRN9-pvLW2LrM25qBP_1VT3txg-zJ9R_Kh-IejHNNualcpyHJD5Sc
Message-ID: <CAJ-ks9=1MO0rZJ=5=-G5PCR6wPGBk8v_PWt9sy5dXNup25iqfg@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: alloc: add `Vec::dec_len`
To: Danilo Krummrich <dakr@kernel.org>, Andrew Ballance <andrewjballance@gmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 16, 2025 at 6:32=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Add `Vec::dec_len` that reduces the length of the receiver. This method
> is intended to be used from methods that remove elements from `Vec` such
> as `truncate`, `pop`, `remove`, and others. This method is intentionally
> not `pub`.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/kernel/alloc/kvec.rs | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> index d43a1d609434..5d604e04b9a5 100644
> --- a/rust/kernel/alloc/kvec.rs
> +++ b/rust/kernel/alloc/kvec.rs
> @@ -195,6 +195,21 @@ pub unsafe fn inc_len(&mut self, additional: usize) =
{
>          self.len +=3D additional;
>      }
>
> +    /// Decreases `self.len` by `count`.
> +    ///
> +    /// Returns a mutable reference to the removed elements.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `count` must be less than or equal to `self.len`.
> +    unsafe fn dec_len(&mut self, count: usize) -> &mut [T] {
> +        debug_assert!(count <=3D self.len());
> +        self.len -=3D count;
> +        // SAFETY: The memory between `self.len` and `self.len + count` =
is guaranteed to contain
> +        // `self.len` initialized elements of type `T`.

Oops, this should be

>        // SAFETY: The memory after `self.len()` is guaranteed to contain =
`count` initialized
>        // elements of type `T`.

Let me know if I should respin or if this can be changed when applied.



> +        unsafe { slice::from_raw_parts_mut(self.as_mut_ptr().add(self.le=
n), count) }
> +    }
> +
>      /// Returns a slice of the entire vector.
>      #[inline]
>      pub fn as_slice(&self) -> &[T] {
>
> --
> 2.48.1
>

