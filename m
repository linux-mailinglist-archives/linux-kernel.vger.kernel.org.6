Return-Path: <linux-kernel+bounces-566877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FB5A67DD9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 21:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 036AD1899A21
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 20:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490E3212B3E;
	Tue, 18 Mar 2025 20:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XEO519EC"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74F6211A20;
	Tue, 18 Mar 2025 20:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742328814; cv=none; b=XxG1B7BtMCs/BjIxWT/nnYUr99HXORQDQbpJPS9EaMaKdCOMSHAuFqkJaLNTVYkzByNeP1xEADpoieJdXycMuXBjGmKEm3q9ig3bNe/HUplNTxcCfnDYH9st3WC2UsfT966ziNpFr8STCke5Nkom28fwU3YadWIyoAtn/yR0WWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742328814; c=relaxed/simple;
	bh=4Usj3tdB8BDICov6mR5o0KIXlCATwRV1+kMj1koCmOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1+D66uDv+U7DV8n8HoSSlLLszfZpweg/N3KvKDByJqfyPLWcWKEqlb081vKZvQcXTU2dQPZqNc/rqlx3xkqxIe5UF2TxT95gnfJ+ylobMThBNYyX9PGfQavWVkuIhN1xNIeUuPZqkJn9Pd2Uuy8RxiYXkYdmIR0MtUQ39F/Mk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XEO519EC; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30bfd4d4c63so59749101fa.2;
        Tue, 18 Mar 2025 13:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742328810; x=1742933610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7EYuK/t2IJSGOT76QGj0LoVWETpAfuQmAmJNAdEEvyY=;
        b=XEO519EC3Sv0T9DZOZLgyy9W1CCl5NaClGEh3zFE6nOKJb5nMH+GihCTedl2X8RwcI
         TZnpGmHNvzvw1+ZTpBp3iZo3uewF8UESPV9mBgs5prytH8DTsnU1Gy8ACs363bIo7Bh/
         dMcxuxGTSj1fqlOK59LerxAA+JaZxvf2jx9b4wRG/0OjUbSTsazBvVTrT3iAtZ5eEqG/
         BNR0+zkjzb0ZQKiM7nJRgMSS0ETRD2ULswlv/MSpYnpwrVpD8Y1rXn0Vby+HjGlrELyZ
         9XVmXeZQ9wLdHv6hJYpfHKQ3Wz4bW3y5U6I1dZ8/63Y6gM5TtA0xpExftgL8dZtRzBKB
         W3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742328810; x=1742933610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7EYuK/t2IJSGOT76QGj0LoVWETpAfuQmAmJNAdEEvyY=;
        b=akNmC4dW2oA4RSARsU5kUjRhIUFXmkMsMrXhdnSCdZFc4EernMLxCa+lt4+6zy0SpW
         +2kIvgCCjK5parIVnhcqWCiu911bCR6hdR6xWFLIXEpa4n7EuLp0VnTcVSBGm1kVSVO3
         nKgJN2rah8G0WsDS3gTGZYEphGZ5PefXNwVUD2cJCR4k2su3NhSSnywkgIwOGqIw5GEj
         AI/xxoybJh+mKKJ9Z4DlGt+GU/y3m7xm1RvUKyJnQLBLhLI1aoA7meY/2zIVQ2ThpwUM
         XxRdHOo4muCHj/Z5tIlcj/fv9jACnib5wlawlt4KbpcTPqHpfVJBStqHODGtTRFe6pXt
         uRwg==
X-Forwarded-Encrypted: i=1; AJvYcCWi29wVXR2247HyDoZml4vB9xfacWw/+SPw39BQGi20faIh/CDRC1JZAtc5lnpoveEYt6FmDQuiwEQ=@vger.kernel.org, AJvYcCWp/YFNIhyP6dqWwpus0u8isZQ3b48kF6M7Mz6pnV34XuhPqJmDc6yYGYANU6f9WF7gNK5n9xiz1E9h0RNe7nc=@vger.kernel.org, AJvYcCXtgEE/IOZq1euFd3q6ibYEHpK3LdOkOBl5qIqilh+WoU62iOV6FaYkjJAS9FtSQPb9kd7qOox0isov0w64@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1fXGabI5XVus1PiqlIaJm1m42IsJov94EPqGFRu7UMkOub9eF
	k/nxJPYSfaXCp0ShO7upkoLsG++4ut/TE+5gpXJIndtMsA84ZzsxsBqtKcidL9Z9KJrks+0dSkH
	7RDC2TlCMfWWdx+A/aAYLsmV2PC0=
X-Gm-Gg: ASbGncuqkuqdWJ3AR8kQUhhPQaOXZgS9alI08L/pCzyXNGIwammsUEcHT275zzU7VGv
	V4x+Yuuo09YG9s5ULtscPmZUvjbW7EaZdi/XwgTw8X1RaT554Lv6RRQl2NfPtk80aE3nJEzHU68
	7+ZXm6iUdi7HQ4TqWUahR8L3KgBzxp3ZXAfnNZcCzyfg==
X-Google-Smtp-Source: AGHT+IE03XdTIPJlrlbTe4XTC7CjLxzzw2MmqZ7G1kRhG67FU/kpFzEBbds8p2MpkhI2rqH08hJOoadGnI+7Ukp7gec=
X-Received: by 2002:a05:651c:a0b:b0:30b:f52d:148f with SMTP id
 38308e7fff4ca-30d6a3e2be0mr420101fa.18.1742328809683; Tue, 18 Mar 2025
 13:13:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250316111644.154602-1-andrewjballance@gmail.com> <20250316111644.154602-3-andrewjballance@gmail.com>
In-Reply-To: <20250316111644.154602-3-andrewjballance@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 18 Mar 2025 16:12:53 -0400
X-Gm-Features: AQ5f1JqGHb-xKycRwPr6BJPWKgZnlSyF596guWZP_moUzsbI0d82WEiS8RZpmM4
Message-ID: <CAJ-ks9kAROOfyPtxMe6LE4-UPsvXca2sQ2VDjhRchZp3HLddGg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] rust: alloc: add Vec::resize method
To: Andrew Ballance <andrewjballance@gmail.com>
Cc: dakr@kernel.org, airlied@gmail.com, simona@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	corbet@lwn.net, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	acourbot@nvidia.com, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 16, 2025 at 7:17=E2=80=AFAM Andrew Ballance
<andrewjballance@gmail.com> wrote:
>
> implement the equivalent of the rust std's Vec::resize
> on the kernel's Vec type.
>
> Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
> ---
>  rust/kernel/alloc/kvec.rs | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> index 18bcc59f0b38..eb6d40a1bf8b 100644
> --- a/rust/kernel/alloc/kvec.rs
> +++ b/rust/kernel/alloc/kvec.rs
> @@ -554,6 +554,32 @@ pub fn from_elem(value: T, n: usize, flags: Flags) -=
> Result<Self, AllocError> {
>
>          Ok(v)
>      }
> +
> +    /// Resizes the [`Vec`] so that `len` is equal to `new_len`.
> +    ///
> +    /// If `new_len` is smaller than `len`, the `Vec` is [`Vec::truncate=
`]d.
> +    /// If `new_len` is larger, each new slot is filled with clones of `=
value`.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let mut v =3D kernel::kvec![1, 2, 3]?;
> +    /// v.resize(1, 42, GFP_KERNEL)?;
> +    /// assert_eq!(&v, &[1]);
> +    ///
> +    /// v.resize(3, 42, GFP_KERNEL)?;
> +    /// assert_eq!(&v, &[1, 42, 42]);
> +    ///
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    pub fn resize(&mut self, new_len: usize, value: T, flags: Flags) -> =
Result<(), AllocError> {
> +        if new_len > self.len() {
> +            self.extend_with(new_len - self.len(), value, flags)
> +        } else {
> +            self.truncate(new_len);
> +            Ok(())
> +        }
> +    }

You can avoid underflow checking in debug builds by using `checked_sub`:

        match new_len.checked_sub(self.len()) {
            Some(n) =3D> self.extend_with(n, value, flags),
            None =3D> {
                self.truncate(new_len);
                Ok(())
            }
        }

>  }
>
>  impl<T, A> Drop for Vec<T, A>
> --
> 2.48.1
>
>

Either way:

Reviewed-by: Tamir Duberstein <tamird@gmail.com>

