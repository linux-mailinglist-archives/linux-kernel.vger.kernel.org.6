Return-Path: <linux-kernel+bounces-378074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA959ACB07
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 15:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 242511F2108A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F59A1ADFE8;
	Wed, 23 Oct 2024 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R2Iw+19t"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41391159583
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 13:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729689585; cv=none; b=VUzhyNMtQTECRwbwdfkPkGjBqGLcolfrlepgjELITVg8OrYDeJp7qlvpqTvv3ekiMV2DnAd6hxKwj3rUFnUK5Qq6RJGrUidEFxNAGeZw3HYq8LIMLYDhM2p0x676a1oSyHh+n7QpxO+f9yBpdiZ3jE01JnhDXdga0tHqAIb5+uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729689585; c=relaxed/simple;
	bh=wXUDUNzNvkTJI34sajXKXT26RKhKxiVNUKYpKGuk4GM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=US0JI4lhX0fWOfKGhtLn0+gIE+ysViNf76Orur3DNtrb+Wp1Tnpnwr6Mx2Eg2TEHiZnsYxECO9Y/Oe0T3tkdcD1ErJDR5u6FD6wz1MMoCOe4sGmIvowKmmAJYthCgnBISdMC5WYPm/BoLeJ1blLTCQxr0SFb90tms/tyMwjS5k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R2Iw+19t; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43169902057so44220425e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 06:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729689582; x=1730294382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wXUDUNzNvkTJI34sajXKXT26RKhKxiVNUKYpKGuk4GM=;
        b=R2Iw+19toJTrGoPkwQojkroteInNl89qZ+gLPvXjcOC8jHeXR4HMnoEuwYXhbTlmoS
         ikRhgtgCscdMJjoqo8iikyqW2LNwAEwo8cs+1EJTkZajeCvaNXXM07E0rYF7TYf15x3E
         JmpAnIwcvzwGlGF9TEHlVRryjMs7gG5bPUKNDZtlvGsCqY1nFz62g6K3ugSX9ZWgzi2q
         ZiUsw2FsJ/p/gmEzbXVYA1lfFUII2npoPet65HprhzijKlVVw/5Lr8vYn6xsjpCt4Khh
         lpdPrYryVouOeZYVdcxeAdY4pLJJ8IWKERqEyNRD35y70p+Q/1PGyxGH/V6poxMIwV1g
         75+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729689582; x=1730294382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXUDUNzNvkTJI34sajXKXT26RKhKxiVNUKYpKGuk4GM=;
        b=FBCUkp3dBK7KuVNa/movZtemqsFf03OQlOzOEG7mShMd47seoE+wA7fk/aluHL37kj
         X3O9JaUfw7KhDjLaW2CC6jky5PcDEjXBaX8Vtm5YqgsxRf1N3azZ50zIRhzDlwQ5jCE2
         QZdPeBezkf6FW/juRQdgwk4hjqxp5Tw2uv5HsB+XoV5x/KOyroPXE2JA3ZLSdz+kbp5b
         m6+f1lGzlrOsP2zqP0N44lE+sd/V8V6OmPbLcNTHeZZLXMbaDvGrbrdXbqJYjJfBCVeC
         0/Rvt0XtxHl4CO6F19xtZitd+2KZo0UPPnmmlJ5vGVw7PPggHKqeo+g/07UECycLex/A
         lMUg==
X-Forwarded-Encrypted: i=1; AJvYcCU3zeS7MqQFRAf1/VxT9fGt61auKnYyr3DOmob1fDb23hp5Eq/OwT9wl8s6S2IitfhOakKBBBMLbaUDDTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb4Z6tGSZxysW+HvGh6hiCGWe+F4+Lp/Nb11r5lzZXL7dRSVRZ
	E45G9S/SBL0mh+Z5kLNPQhHu3Gd9WjilOoqxTOI9iM5JOzYTts4uyar4620AR0vIvzyUeaMWTDw
	QvebBHaO4B9NqiW2Ck52ZLcxpsFqeS82DiIrf
X-Google-Smtp-Source: AGHT+IFiSo4NpUShHCtVNSYjKiEjh+Skjkb5U44tfEKsej3HfYBcRstnJhorp+qPDS6f1VVoCDrw0KKymmoqY5uXL9g=
X-Received: by 2002:a05:600c:5490:b0:42c:a905:9384 with SMTP id
 5b1f17b1804b1-4318415c8bcmr17998235e9.20.1729689582529; Wed, 23 Oct 2024
 06:19:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023-static-mutex-v5-1-f96b1a425c40@google.com>
In-Reply-To: <20241023-static-mutex-v5-1-f96b1a425c40@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 23 Oct 2024 15:19:30 +0200
Message-ID: <CAH5fLgjMo6_BJFqYfqHav6UqEwiQVm5+BPGYCZFQwEWDb4sdOg@mail.gmail.com>
Subject: Re: [PATCH v5] rust: add global lock support
To: Miguel Ojeda <ojeda@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Boqun Feng <boqun.feng@gmail.com>
Cc: Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 3:17=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> Add support for creating global variables that are wrapped in a mutex or
> spinlock.
>
> The implementation here is intended to replace the global mutex
> workaround found in the Rust Binder RFC [1]. In both cases, the global
> lock must be initialized before first use. The macro is unsafe to use
> for the same reason.
>
> The separate initialization step is required because it is tricky to
> access the value of __ARCH_SPIN_LOCK_UNLOCKED from Rust. Doing so will
> require changes to the C side. That change will happen as a follow-up to
> this patch.
>
> Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-2-08=
ba9197f637@google.com/#Z31drivers:android:context.rs [1]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Something has gone terribly wrong with the versioning. This should be
v6. Resending ...

Sorry!

Alice

