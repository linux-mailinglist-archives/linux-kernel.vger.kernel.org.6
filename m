Return-Path: <linux-kernel+bounces-367590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE8D9A042D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2EB1F21CC9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1A01D1F4F;
	Wed, 16 Oct 2024 08:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ulGuSHs/"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA9518A95E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729067172; cv=none; b=haNjKNhcB5CMedNQwbZHAxBluuPXcal0OuhbsqdUjkS2FSbDxQpb83pnfMM7JhoT0HGylC5euwhJAFWN4my4QVvraW3bxbpLZPlzUyEvQI5BaFz1oarguZBaE90pySjR/V3uXpDBGs8TaErSRV91ktWeDgCsKRmzD+mjzWTxrSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729067172; c=relaxed/simple;
	bh=tygiRFqbv+djzCkWAvjrXrySmhBjmetaHW6CXjdEyUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PGIG86PhUIQrnUZ6yQs8pz0/8ncw0jsZZ/GJwp+Pk+Xz8K3vml+q54Du0Zoon59oFW94CU/CYp+LY8f3Ekuop8wdCjxe1Ebs0aUheNjbw7KSSWBSGfiu7UwhKPrOl6xHDtdWEibnOJTfW124H4S3HHHpcXTfYX+YF3JT/rI3MLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ulGuSHs/; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d5038c653so3964011f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 01:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729067169; x=1729671969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+7LwnnrTbH3RKt7BRM7LcBiqKf9Vi4DwjUCj0Z2Cpc=;
        b=ulGuSHs/Zgf6jxgwGsWmkoTkCwt/2B9NgJ87CrKY+390dJsev3nit0AVgnF+YGhFxA
         XXI4pPseYdHmZ56BQvw1y0HpUbKAmtgwewC9E8UJnmoTYkgP+F4vVjMC4B0jXlt/QdZo
         UnVmJWQDflxVlHN38kKjp+ngP3LZ+ZRLCn8vr7ntt2HzS46029vs0ZWM7R1co3s6I5uA
         GvR8lG2yeAtsmp/XgT5P5lP5b7ZsjgX6gDRfjdn5FF3PxWL8Tcob7oFSMWIVC5rfSI92
         /nUuNmzFyZFguapVJ9zzGeXJtiuzRAEw4GONVAofLwZ28xj+dBz+ouhnXmjt8qW4BD8k
         80aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729067169; x=1729671969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+7LwnnrTbH3RKt7BRM7LcBiqKf9Vi4DwjUCj0Z2Cpc=;
        b=A8T66M5VE5g6LXrlJEHqgBGJvJGpHGwYmdaGJoxzYsCPCmk65+acZpd9mkRAybgCKE
         LC/W4nVHxd+PiyHgweRI15gIwH9grI2FufCnbr/FM/9SHVqfVcgijBzZ1C0flZjhORm1
         PKeGi+dMbVLeENTdJhxjnLH4XdxYFggbmmmMAdtbESZPaKZWd4mAKuaTMOvhuIHFh4En
         u8ybXOirssB3KNxutr4ILVRBZ2bXnuKyb95lzQPnQ/tGJUzB4b0x4wIwuRyELExCfVoz
         S/DyIaxltKvp6iLC/pGxP56s7yRkQgRkywhspxtMgo5spQB4dqc2M/xXC0dWgXJ2Wxny
         Gl3g==
X-Forwarded-Encrypted: i=1; AJvYcCXMxwV2UWQBv6spy0OgDz5syAwYDnO/CUnypHj0gyH5G4kBmZzPjbrchUcDXuRgifBwxrqRj5LDMzBK4gM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiRCwCT6vbgsR4+wR2d91CYvCl31tDb4AUeRx6b1m1LXAwtH5W
	H2nJ9LwaZZ6NzatywpWg1fZT+pL7cH0D0wJep6lZmHYoE5Y1MPdmWefxXMvHg2a1AGFN0o/I1Wx
	G60I1KFCCrABo+n7EbSgqOGKWpmJPVPO4miE9
X-Google-Smtp-Source: AGHT+IG3IXPeMudvkdrtSejG9A2Vrc5kJHuxJRzENV1HoWLFGAnZtzhqRbbC+l/e1CT7Jq8syro7lAXEjkQOMCt5MBo=
X-Received: by 2002:a5d:6b83:0:b0:37d:395a:bb7 with SMTP id
 ffacd0b85a97d-37d551fc5ffmr10919996f8f.31.1729067168659; Wed, 16 Oct 2024
 01:26:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016035214.2229-1-fujita.tomonori@gmail.com> <20241016035214.2229-5-fujita.tomonori@gmail.com>
In-Reply-To: <20241016035214.2229-5-fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 16 Oct 2024 10:25:56 +0200
Message-ID: <CAH5fLgjHtRJg9E7Xjxt+Xgt_0=7zk2jFYLiuzJSeibdx2yHrWQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 4/8] rust: time: Implement addition of Ktime
 and Delta
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, anna-maria@linutronix.de, 
	frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, 
	sboyd@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 5:53=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Implement Add<Delta> for Ktime to support the operation:
>
> Ktime =3D Ktime + Delta
>
> This is typically used to calculate the future time when the timeout
> will occur.
>
> timeout Ktime =3D current Ktime (via ktime_get()) + Delta;
> // do something
> if (ktime_get() > timeout Ktime) {
>     // timed out
> }
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

>  rust/kernel/time.rs | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index 8c00854db58c..9b0537b63cf7 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -155,3 +155,14 @@ pub fn as_secs(self) -> i64 {
>          self.nanos / NSEC_PER_SEC
>      }
>  }
> +
> +impl core::ops::Add<Delta> for Ktime {
> +    type Output =3D Ktime;
> +
> +    #[inline]
> +    fn add(self, delta: Delta) -> Ktime {
> +        Ktime {
> +            inner: self.inner + delta.as_nanos(),

You don't want to do `delta.inner` here?

Alice

