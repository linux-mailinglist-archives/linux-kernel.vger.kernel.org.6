Return-Path: <linux-kernel+bounces-538573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68255A49A5F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 497823AB0C7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4699026B971;
	Fri, 28 Feb 2025 13:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zgLNMzOP"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073801D554
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740748637; cv=none; b=levkqNtafu1WcIoFQ+vU3ShZwo0cz7G0D1PEJKDXLjC/FwP5je/jn6uyVvmd/lb0kQdYWia/ifF+tprECPEpg0foVcnak48N5lDZ5Qo1f95n3xA2ip7+wxxaq5dPgnQdNqgBvkRtpY1vWvKaHBokp0nZztsfPaSX5Q2XQZla2A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740748637; c=relaxed/simple;
	bh=EQt/g6AXhlJBrY+vlKuQdxieohPKDQQP1es2fhl6snw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uGq6VgujfFFcO/BipJ9nehIgJjVW00KpEaLPD+3pOAsgwo3Dm8lxUIv/8RGlah10tWKPs1V0TWuoRWNKPUvTMKc5fdq12+3mUEQ/B0yVtQeuHE9uBDGgfSZiKyqbkCtMxfR4K0RhJB8Kl4xXc6nex1L+X6S0bG7DaGX2zMfsQo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zgLNMzOP; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-390f5556579so116656f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 05:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740748634; x=1741353434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z74qB8i0rvA9VyRTivjkgYMWcLCNlIOQtcyUnYqz2Kk=;
        b=zgLNMzOP6l5t94jPVJsxfHmzm0BXMnG5wiVlIfFeQY+lqsF1+U++pKCFAREhYazr9+
         ZFIYg8ZF12HnPEk+Fy2Uylo1ZXJIda14sN03U8j9u4zzoiOvoBD1Sbazouyrnd5RwbVY
         86hxvVUzPQ9hXXFiEsm2KbeRWGkadmPgG04nUrhuHaTt9KMsdCAMQR7w6ks4x9Z3hkEO
         6qNnMGW+zUhhM4mjIkA6cvHTQc5HS7lowzMl81rDxPvlBBD+0qK0MsID/n1I3uqkHCXo
         hQerMAVtokZLr+PKw0VXnuKQI6SsW+d+KlaMZkO6mYEaZfFQoA6Y39X1LcpIt1pt5JXd
         AE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740748634; x=1741353434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z74qB8i0rvA9VyRTivjkgYMWcLCNlIOQtcyUnYqz2Kk=;
        b=AacuxlXsL94EQievj3B4QmxzaSS/N+IrLmVMGgneTK/jHESCNbtS1mDTtssOVb80HF
         6mFVoiYk8LDdJHPA+wfkc6wxG7GrNagJqWBjgSly05ihfNuii0k20wWIqX2PflP0JQ16
         5P+Jmw4V17U8cpLW5oKs7QXnWtin45w8xZOtc7XcFiAu1VAZCqLR+sTc8teQmHtUFAXr
         1osg+dTLrUn2E/0gN2648ZIeuT2KvBObaU8XcYr8vCpFpc5PorPnwf7wUuQoipi7NOY8
         6K7loX7zztpA2aZbSt5uzibNnuU5Cdd0fKanSIP7Mfzzw69UOR12w/laCyayO0H/lJgw
         pWIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtsen0LtiDHoWccQVs+hY4b0Z3j2WG/900YJUNqbaRoYp0ZfB2Gt7MUC60kKYNJKtMiDW2i0yQStaKjko=@vger.kernel.org
X-Gm-Message-State: AOJu0YyThb39ZaKMWVEC2zA94yeycG6hvTehUOT8i2/NvHa7I+SrlFpT
	ovMcLv4tciedJhi2pVB127sHR6uTbBrnke929qMbSjlmuttVEomEyzdss7rgX7/AFB1pfv4am6Z
	dsgeRPM+ySp2n+5Vwsz+pVCOk9vioxeJ9wR7f
X-Gm-Gg: ASbGnctW13pXXvpzHNoUtnCEW3OpZACIwx5BnocxIihSWRjmoAy0zEUcfQa/uQdbIjE
	pKexI5iYMFikKgA0dYG/ltNubwp1dBkO/2dRxlIUjBQK11iq4XcZn5wi+KoypApFcvXPQ3JH6Je
	9Q5TYxOr1VIgdhwbP/fvfVG1Eq4LvEPZ1uUIgd1A==
X-Google-Smtp-Source: AGHT+IEWGx/WwYtfUYQZ979bVUDfjNZK1fjqNbS7i6AAh1HtcGFLDExsO/1IMIidMX2d20ad5heqFWsZlYme6TiA82o=
X-Received: by 2002:a05:6000:18a3:b0:38f:516b:5429 with SMTP id
 ffacd0b85a97d-390ec7d2722mr3114115f8f.25.1740748634158; Fri, 28 Feb 2025
 05:17:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228-export-macro-v2-0-569cc7e8926c@google.com> <CANiq72mF46p7f=G8WsnajwZfg--wTNESp7xQEsWUaiumOyfW5w@mail.gmail.com>
In-Reply-To: <CANiq72mF46p7f=G8WsnajwZfg--wTNESp7xQEsWUaiumOyfW5w@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 28 Feb 2025 14:17:02 +0100
X-Gm-Features: AQ5f1JrjOiLJdIMtVt0XIg52XCAYwVyxmrWrAy5Rs4benpI1u1UEF0yyTG-Vs2Y
Message-ID: <CAH5fLgj0CHpUW=-Os4gMqJxyoCAg8izFG9Q47DLt1cOJi9m4tQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Check Rust signatures at compile time
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 2:12=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Feb 28, 2025 at 1:40=E2=80=AFPM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> >
> > This is because cbindgen assumes a
> > cargo-based buildsystem, so it is not compatible with the kernel's buil=
d
> > system.
>
> I don't think this is true (checking is already a very good
> justification, so we don't need this to justify the series):
>
>     https://lore.kernel.org/rust-for-linux/CANiq72mHVbnmA_G1Fx3rz06RXA+=
=3DK5ERoWKjH-UDJ9cKxvKQ1g@mail.gmail.com/

Huh, I thought for sure it did.

Alice

