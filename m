Return-Path: <linux-kernel+bounces-407665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE889C7194
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31849B2DBF6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199601EF95B;
	Wed, 13 Nov 2024 13:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k8TxbwJu"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D1A1EE018
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 13:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731504859; cv=none; b=AlCa3o3iXuX0C2obPqjPTVrUEy7WYdaDB448vOfAmW8DPxJITSOgu2iworVOUEis1RdEytcsnNsnkeLjbaslJKT6twSdEW6RsXWmCCT2lxfEVGvdtEbf0wYUYraDWkSPLX0vq+Au/QKK+2tc3IBTZotU3vpWBVSv5gkxvKT7e6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731504859; c=relaxed/simple;
	bh=KZ1cVqAR4M3IuF9kRDgut1hnAjGKGAjMfbKFCXnZxlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jL0LKpJ/GhCWxKQXgnJJyaHyCSksE14/W/1a/S3zbWJtjzvc5zWpGrPY8voCTQcApMEsD4vMeNKjJfuQNpnTb28l3idNENSAExtFjl+udPrp7RxTP+CKR7KRsJkgURkmXdvLJRCJFekda8/s02QIxkRNtswMJ1O03ZI5BrpkCWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k8TxbwJu; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d462c91a9so4380478f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 05:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731504856; x=1732109656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+L+l6iciWCr4lKpFcEtaZCqtWfcPHk/ITTH5PaehCo=;
        b=k8TxbwJu8xwSRuT223tF/kk487w1ZdniCrRC7EhmkXOcW24PamwXJn3TLlhZhFSQIh
         5a098Z5w12BVEGl9XC2kNYEJhzO60s/U+SywdW8ZtRRERZict81Usk0Mb6kNkTeuwcru
         /S+67QgKl5moSBAXCJhL224YsjI5Au+l5ByI9QxzM+7fND6yZrEr60K5zIgEKOmC9YLk
         yI7JqqRN5U5Rs2ZU/TvuLdK5tZjnJ0LKCyQ0KjRDtOD5wLhTOnyj4PLo7A6gRW9bMwl0
         NNYy0rwIgCwNoQPAC0T5XmTb0Mx10pcvojC5UDv4uyXRemBHcqSkRQGEFbdN87I05c7/
         +6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731504856; x=1732109656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r+L+l6iciWCr4lKpFcEtaZCqtWfcPHk/ITTH5PaehCo=;
        b=MmpBaan4wcBJvww70/nQNZ91uGlHSD3Xkq/FhnnrWizYk0ytn+oXkgVRDx2cUmmrdE
         8ibaO2QMUunjR70GVECFMtaPYqT/EHnhN9BsgN19TTif6c3q8twzZPfACIzRw1ZLYMx+
         wrgz4abyEPRGS1Z06KwgH/3rXew2qxisaoDyE4V0W3stc5Ynu3V3b/2oREB4WKZnMEvu
         TGthsk0F/lb0urEloJrZ0RviyukUxzlkQy9IZD7h3eL6iWTypRa51OB9OlUFvrpgOpqa
         unikSMY1RhdxtOUp6rPH6y+eJtPBhbEL2DKwp7J73B2iy18XAGazPQmIMtGn2Q0c0c0I
         Ij3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWxivjYlb2F+1In4/E3zcUTWKzgoZX6NoqzJUukD1ixyBFxq2CkuY+I2G42/V8qqh/tCruszr52aoIWAHI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOG7VD5F68nwWRKyZHJc1LpU0N2kv29D8Y1Ey46ap1bd8BEzbt
	Dj9PXfDGPvmCmBPdgl93P3RgcDT3+DmqwIGh2uNr0rCxcf45P45ASXvCrv8yaSGC3JNNPFCPGw9
	ju2jv3dk6yk24/opISo+67Ejy6pNR3uSC7dEV
X-Google-Smtp-Source: AGHT+IEXrXCRg6Pm6Erkl8kn4myTQuZfk+jsms0GRM+sUn39EGENQJna6yyxHKVvww5XL3XcEMAW4LSvyPWbOYGFIGA=
X-Received: by 2002:a05:6000:1a89:b0:37d:45ab:422b with SMTP id
 ffacd0b85a97d-38208124c87mr5152314f8f.31.1731504855525; Wed, 13 Nov 2024
 05:34:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112184455.855133-1-ojeda@kernel.org>
In-Reply-To: <20241112184455.855133-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 13 Nov 2024 14:34:03 +0100
Message-ID: <CAH5fLghFZTG2X_mYE2yGJwPM31NrJdkA-cpZTCYsdghR8YdY8Q@mail.gmail.com>
Subject: Re: [PATCH v3] kbuild: rust: add PROCMACROLDFLAGS
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, HONG Yifan <elsk@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2024 at 7:45=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> From: HONG Yifan <elsk@google.com>
>
> These are flags to be passed when linking proc macros for the Rust
> toolchain. If unset, it defaults to $(KBUILD_HOSTLDFLAGS).
>
> This is needed because the list of flags to link hostprogs is not
> necessarily the same as the list of flags used to link libmacros.so.
> When we build proc macros, we need the latter, not the former (e.g. when
> using a Rust compiler binary linked to a different C library than host
> programs).
>
> To distinguish between the two, introduce this new variable to stand
> out from KBUILD_HOSTLDFLAGS used to link other host progs.
>
> Signed-off-by: HONG Yifan <elsk@google.com>
> Link: https://lore.kernel.org/r/20241017210430.2401398-2-elsk@google.com
> [ v3:
>
>   - `export`ed the variable. Otherwise it would not be visible in
>     `rust/Makefile`.

Despite the missing export, the previous version worked for us too.
I'm not sure why that is.

>   - Removed "additional" from the documentation and commit message,
>     since this actually replaces the other flags, unlike other cases.
>
>   - Added example of use case to documentation and commit message.
>     Thanks Alice for the details on what Google needs!
>
>   - Instead of `HOSTLDFLAGS`, used `KBUILD_HOSTLDFLAGS` as the fallback
>     to preserve the previous behavior as much as possible, as discussed
>     with Alice/Yifan. Thus moved the variable down too (currently we
>     do not modify `KBUILD_HOSTLDFLAGS` elsewhere) and avoided
>     mentioning `HOSTLDFLAGS` directly in the documentation.
>
>   - Fixed documentation header formatting.
>
>   - Reworded slightly.
>
>          - Miguel ]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Tested-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

