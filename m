Return-Path: <linux-kernel+bounces-542879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 674E9A4CED9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 23:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68AE7165D65
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 22:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9542E23A566;
	Mon,  3 Mar 2025 22:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="atuko3OM"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554EA238D27
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 22:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741042510; cv=none; b=kdNXera0uVFX+kdxD+JGzaCOe9zzK9rRvMwBdo8MVBWzGaPKAiD1B4YSpxSCrp1wIEYLl+dN+OCXGbKmNHA0hv4SOsps9BZ22A/F9Tuy4TFD7b5hcJNFKjZNz1DODSEI0MGBrDbckgGF8Ps/1Ds52fd0TnGUuJismZgHtEgDy88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741042510; c=relaxed/simple;
	bh=FV0AMXP2plgQ+6X5x5sS4h/E9JkH8Jx7ZwLybj2GHcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rKcgKGfNVDoOceD8gVDBwxgFMW1qqh2s0QNRW0m8a7s03lBhNoxT2Hd6RTzibsKh3duZwu+NaiYvZpInXrX9JQOjeAhnELgRvJTLTvkpKhKE09TxktlQLLZ1FUVrp0SLnGNcblssyb1wY/9p4/WUDyamGjEmb4mv7aGTJ6xli/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=atuko3OM; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ef7c9e9592so38533077b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 14:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741042508; x=1741647308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JsORS7Y/VoLn8iE6xrSTP5GOFu3anHKEztygS4ARAzc=;
        b=atuko3OMuoBz3M8LQtPH5T/blMmnfG/pMclyA6oWZsL/vtwG+Q0vl3DoLc+AhhtddT
         ZgQTKtkenmfV9rf0t5H+Nja4KOJfROLi+nZvlIjd+K3VX47myciX4rJcrLqCoTWzb+nC
         G3s0fXm75FEizTCevZPrKSK/N6kQ/+g/sEHSEuFUbTwiFCDsLCKV3POnZI1X/8ZZPhc9
         hLCBxkKTwePc0zGerA9BhVEFCAwD91CZLUAd8iiuwSTNOEsMD8RMxFZ/9Tpj0bMJaKMW
         93Y0origjL0yPlr9s5ijGsI6eZ6frktvV3kPrp4xiFoz3lmn+MFHQ/QRo+T4eUVsIzBW
         Wz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741042508; x=1741647308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JsORS7Y/VoLn8iE6xrSTP5GOFu3anHKEztygS4ARAzc=;
        b=NkzAdxAqwvLOrDNKqQVh0tSVVoplyqrwAsFYk50IXjhDVP5XZmOmS2al4vKOR/goOz
         8/5h7+OIR2Eo0lI7BH84tfu1L2DFZ/63IPAULJLqHthT4Ktqyvwn+aOJUzggBPl7P24I
         4sML7/iBriljso9FmRNhJrggN8Omv2pyVqvFCUB9TG3q/LdO+JfnCuYhwGz4NwFqglic
         mt8Ii5la9VTkGdLXZYZ6xROGcQHbwS8chhON/5gUkOSO1m5S5AXWAWiKnzgqWUh8BnZ+
         RCLjcR4+lFamFd7+dZ4sBAc9sAjaju6App6wKrWuSPurMOw2AxjXTg7rIvUleGLpa+Iw
         G/QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUm7a/cFvOmUpW0CnYnCf91au1ZeXgHWPlOSwLn6h4k4P+XZzRibhZjuNRPBslqoA+FyLpXehf6josmsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMQwkeQfMHZd9N5SeLMszJknotIZUEbdRnjUm4sooiaP25QIz4
	/pxvs+hHrOEU+Re0bAC02EMvb0FDD54+yNwPgfZYE6fiIt994t22jQmC9IGgQy9EB8UbkSnpw0r
	ocSGWDCFr3q4k04cssp2nZtpIKrRAMME5Y6gr
X-Gm-Gg: ASbGncvK/hZe7+BaUDitkVJqCcCK2vAGwJjqZKjEmobkvze8rEf6VyOlWZEkwCtDjLQ
	eN8HCZ2OXp4G7xr9agnlQrQnG3OWg07WByM7MIoiidp9e3xpT15Jk27vHCa9elbcl04gxSxb7Jy
	EriQSX6NHR7QRYSiQDyGGg11S4gw==
X-Google-Smtp-Source: AGHT+IE6rf8uW5Ake0yIOw7LcxxwfLNQ7aN2DZQJSmlz7GVUFfcRLmQdGJcdT3Qfu+CP0SMft2VWYj9dKOHeWHzxgUA=
X-Received: by 2002:a05:690c:3686:b0:6fb:b4e7:1471 with SMTP id
 00721157ae682-6fd49f9f825mr204154037b3.7.1741042508271; Mon, 03 Mar 2025
 14:55:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303-inline-securityctx-v1-1-fb7b9b641fdf@google.com>
In-Reply-To: <20250303-inline-securityctx-v1-1-fb7b9b641fdf@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 3 Mar 2025 17:54:57 -0500
X-Gm-Features: AQ5f1Jr5IfzltzAXVNhmGo-A7qd4NzIh3iaT1pjM1-RaMmUpgWxt70koGP_h_PA
Message-ID: <CAHC9VhSo3aGsJVd=a3MTeakgU66oTN86oh5sZE8P4ghSk8Rx2g@mail.gmail.com>
Subject: Re: [PATCH] lsm: rust: mark SecurityCtx methods inline
To: Alice Ryhl <aliceryhl@google.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 10:30=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> I'm seeing Binder generating calls to methods on SecurityCtx such as
> from_secid and drop without inlining. Since these methods are really
> simple wrappers around C functions, mark the methods to inline to avoid
> generating these useless small functions.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/security.rs | 5 +++++
>  1 file changed, 5 insertions(+)

While this isn't specific to your patch, Casey's comment about "free"
vs "release" is something to keep in mind when working on the LSM
bindings; what happens inside the individual LSMs for a given LSM hook
can vary quite a bit.

I also saw a similar Rust patch where a commenter suggested using
"impersonal facts" in the commit description and I believe that is a
good idea here as well.

Beyond those nitpicks, this looks okay to me based on my *extremely*
limited Rust knowledge.  With the minor requested changes in place,
would you prefer me to take this via the LSM tree, or would you prefer
it to go up to Linus via a more Rust-y tree?

> diff --git a/rust/kernel/security.rs b/rust/kernel/security.rs
> index 25d2b1ac3833..243211050526 100644
> --- a/rust/kernel/security.rs
> +++ b/rust/kernel/security.rs
> @@ -23,6 +23,7 @@ pub struct SecurityCtx {
>
>  impl SecurityCtx {
>      /// Get the security context given its id.
> +    #[inline]
>      pub fn from_secid(secid: u32) -> Result<Self> {
>          // SAFETY: `struct lsm_context` can be initialized to all zeros.
>          let mut ctx: bindings::lsm_context =3D unsafe { core::mem::zeroe=
d() };
> @@ -35,16 +36,19 @@ pub fn from_secid(secid: u32) -> Result<Self> {
>      }
>
>      /// Returns whether the security context is empty.
> +    #[inline]
>      pub fn is_empty(&self) -> bool {
>          self.ctx.len =3D=3D 0
>      }
>
>      /// Returns the length of this security context.
> +    #[inline]
>      pub fn len(&self) -> usize {
>          self.ctx.len as usize
>      }
>
>      /// Returns the bytes for this security context.
> +    #[inline]
>      pub fn as_bytes(&self) -> &[u8] {
>          let ptr =3D self.ctx.context;
>          if ptr.is_null() {
> @@ -61,6 +65,7 @@ pub fn as_bytes(&self) -> &[u8] {
>  }
>
>  impl Drop for SecurityCtx {
> +    #[inline]
>      fn drop(&mut self) {
>          // SAFETY: By the invariant of `Self`, this frees a context that=
 came from a successful
>          // call to `security_secid_to_secctx` and has not yet been destr=
oyed by
>
> ---
> base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
> change-id: 20250303-inline-securityctx-6fc1ca669156
>
> Best regards,
> --
> Alice Ryhl <aliceryhl@google.com>

--=20
paul-moore.com

