Return-Path: <linux-kernel+bounces-571519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C956FA6BE43
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B94A16B7F6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C0D1DE4E5;
	Fri, 21 Mar 2025 15:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsKdcGF/"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B9664A8F;
	Fri, 21 Mar 2025 15:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742570580; cv=none; b=tA/W9pLVoWVdnXwTZ+LYKrFVLwIVvKye2iQ1lhd4W1GPn1H71aTnu12eNH4nrshmlZxQf2ezhULdTAdzjKIplZ7g5uM8EDz/Vt3om7I9xrxgvpHfQR5CCSSXGRkCkUDZ5gRkMAVYBccuMjav9003ZfeSL2vdewLXv7mR1R+j2V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742570580; c=relaxed/simple;
	bh=NP5yRsiuzlqMxHRcHuBhZYOrMEcgFy7u5CFgBe8v/G8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=guL/Zavm0UY0J9CySBsrdDxX5P7dbJkFExyqMdPt+Xlb0d9XpTFwXSIjnR8i3NSdDPQ0wQER0UlWRpxj2DSHUZFYoz76vZ9ETDB7Qs2qDOrMrX/V825tH4OGvlCM6W5DUH6R2wk9fJvZ8FsgEXAngvsELj/Fuhx2ehJVKLBlo5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsKdcGF/; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30bfe0d2b6dso22597541fa.3;
        Fri, 21 Mar 2025 08:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742570577; x=1743175377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfrErcag9Q092oLaTM67M17Xruxr3+6yAHhWH9MGFgc=;
        b=RsKdcGF/6OfrdfLjWmbajxHE+f9aoyTl+NBsI/PgoRnCNa7d5Z1WfSlSjMQMklI0Rd
         AiPZ+KfJ/JmBEpD3EBmEzPoG2tGTkxr1cHeHMDxLjZ5QYX5XvfnrV/uGzqgtTZ0UMDEH
         RtOTfmCo147CGy5Gd+CrWyI1FB0ejn7/oOUhOwpE1TQ203HC3CQyEe1Yyho7gHucVfyz
         Y37tn11HtpX6qFnoAyMF6gNbteFpZTQeVKOAIqBr6W/DFHEFZ1Pjcw2qhpj5FlSiDG6T
         IH+9YUip8cxUmz+Y+POkIw3vlmKt+OS7oh5bKcASaWVmQbG3Rog3+Fb15HYHzkYQkb9v
         3m3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742570577; x=1743175377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qfrErcag9Q092oLaTM67M17Xruxr3+6yAHhWH9MGFgc=;
        b=cDxIzaygy3SOoW5pADXyiycYV/02h2L3+ur4CwWr4erj7nRPVYY5J+VNlhTDJnNZco
         Y4+4CR1fP7tcy9+iGZe2kPEjHaS1B2TyiCCfBw65O4U0Z80zxRajCEeGDxrCh+h+72tH
         20xjQXsKhKTnzSujTyvLlDRxcBu6r6Jw5UodUVYr/xSHNG+ujlYJmsy5Fh43Dxhx5HV0
         Eey3y42aaXCayPg7yke9vZBH9DjeclnQLCcnButyCNmnEZf/r7dlItIYFtEgCV5NwCFK
         v2qcuNyew5NxNvW7/CnhJXlwFChEl3N8qhlhwBzSnkC6PCrSLo3ZrU9LEJYaMytaPBNF
         n6SA==
X-Forwarded-Encrypted: i=1; AJvYcCWG1Sjg1OvK+5ZhuhhrPJqWsFb8OY3I3rOxoDJOtRyaLkFKEPSVcYTdEkMDjjuTnz8wNx7vi9BZq56SD2eXN70=@vger.kernel.org, AJvYcCWImCsDlyw+kaAhiaAPGkkRNr6SUGoQLdrFPagu9RDMM9dvqxUENAZeVpa+8LZXzFnLfZOoS0dtETHYx1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtBvPfjg7G8bGBEgNgSiH2ook59mLowESC3FYVo16OwjS2CLGW
	R1g8oxbpYQa/hp7HUCkz4F6w+3smb69V85IpNYPSobvmYB5Ara9TYeNRo1g4rAs2wpfENrVQZol
	MJ+s1dih2nHex5xpDsr5DDOllLj9qC+QZOyaByIOS
X-Gm-Gg: ASbGncvWIT069Gcf471150qEegR2nuo1nhinFNy/VDT/qjMys/JaAIj21GMG5G2nprN
	k6qEEEcPmns3gnXQ+Ci9UULrf4O6gJIbzcXx0NPpeMPJo18fJAUVclf6oThcG1XvEKdalkD47Dp
	pqLbhkOMfCNAyQZ75GjJnZ/z66p62PIpLmEEVoCi7PYw==
X-Google-Smtp-Source: AGHT+IEFmQtpfMpBZqMXt7QD3NIaKyDBBl/rhs1v/ToyN3SVhxZRO9zIGjPQ309BUsUvmDWvTMlZiIeOSnSs3rRtves=
X-Received: by 2002:a2e:95ca:0:b0:30c:1d:b147 with SMTP id 38308e7fff4ca-30d7e22a5b7mr12483731fa.19.1742570576694;
 Fri, 21 Mar 2025 08:22:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320-vec-methods-v1-0-7dff5cf25fe8@google.com> <20250320-vec-methods-v1-3-7dff5cf25fe8@google.com>
In-Reply-To: <20250320-vec-methods-v1-3-7dff5cf25fe8@google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 21 Mar 2025 11:22:20 -0400
X-Gm-Features: AQ5f1Jrng4wUdLdKFKlmT_YGTLp_gs8rZxxYAHCfCXDw4YcmhXdOgqlmy-1DkDk
Message-ID: <CAJ-ks9kFU+epCF3C4yUo5E2dVeyeBf+Fuc+rWe+2CM1OQvRDTA@mail.gmail.com>
Subject: Re: [PATCH 3/5] rust: alloc: add Vec::push_within_capacity
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 9:57=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> This introduces a new method called `push_within_capacity` for appending
> to a vector without attempting to allocate if the capacity is full. Rust
> Binder will use this in various places to safely push to a vector while
> holding a spinlock.
>
> The existing Vec::push method is reimplemented in terms of the new
> method.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/alloc/kvec.rs | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> index 9943358c70aa63f5ad7ed9782cb8879d7a80a8fb..df930ff0d0b85b8b03c9b7932=
a2b31dfb62612ed 100644
> --- a/rust/kernel/alloc/kvec.rs
> +++ b/rust/kernel/alloc/kvec.rs
> @@ -284,6 +284,31 @@ pub fn spare_capacity_mut(&mut self) -> &mut [MaybeU=
ninit<T>] {
>      /// ```
>      pub fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError>=
 {
>          self.reserve(1, flags)?;
> +        let err =3D self.push_within_capacity(v);
> +        // SAFETY: The call to `reserve` was successful, so `push_within=
_capacity` cannot fail.
> +        unsafe { err.unwrap_unchecked() };

I'd prefer an unsafe inner helper to this `unwrap_unchecked` call --
this safety comment is actually describing the semantics of a safe
function which can change without necessarily triggering scrutiny of
its callers.

> +        Ok(())
> +    }
> +
> +    /// Appends an element to the back of the [`Vec`] instance.
> +    ///
> +    /// Fails if the vector does not have capacity for the new element.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let mut v =3D KVec::with_capacity(10, GFP_KERNEL);
> +    /// for i in 0..10 {
> +    ///     v.push_within_capacity(i).unwrap();
> +    /// }
> +    ///
> +    /// assert!(v.push_within_capacity(11).is_err());
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    pub fn push_within_capacity(&mut self, v: T) -> Result<(), T> {
> +        if self.len() >=3D self.capacity() {

len() > capacity() should be impossible by the (implied until
https://lore.kernel.org/rust-for-linux/20250318-vec-set-len-v2-1-293d55f82d=
18@gmail.com/)
type invariant.

> +            return Err(v);
> +        }
>
>          // SAFETY:
>          // - `self.len` is smaller than `self.capacity` and hence, the r=
esulting pointer is
>
> --
> 2.49.0.rc1.451.g8f38331e32-goog
>
>

