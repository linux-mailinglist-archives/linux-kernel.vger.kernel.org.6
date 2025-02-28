Return-Path: <linux-kernel+bounces-538565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CE8A49A4A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D63133B314E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B671C26B979;
	Fri, 28 Feb 2025 13:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sbz+Cpkq"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD9B25E471;
	Fri, 28 Feb 2025 13:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740748365; cv=none; b=qpcjkLw9r3/x3PimjU7bzVr0iTL7D49bE637OqZQmpbKNRF9jWJKQ2E9h6fCReiW2IvjXWfC5RHwhz6cB25G1RGZonOvrKaAF59+cyClq2/SLu9ZIEmOlZp3kYze+Xz4E5g/PoduqQcU43Lj9QQpW7mVZ/8lBYKgNvg9xJ42syw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740748365; c=relaxed/simple;
	bh=nXmtv+J4S7bQAMBAoPK1RMVxgJfj8doXZXp0teFL1AA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e+ske4DNAZZB1aCve+sp+5UAtW+ap+fB5REWzsBFKeuM1DWj7guZHTUVu1gwZzmmRiDpYCxdEfO/ttdcBK5wzYDcKUdNY0oxHSahTd7I6werMi3lNaD9lccoZktKNa9PEy5AbfTI6F1BdSYSGQZrhw5GUNeo/K1Vti5mBCzXipU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sbz+Cpkq; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fe8f6a4bfaso545094a91.0;
        Fri, 28 Feb 2025 05:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740748363; x=1741353163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lEhshDUI6cMzkH2vuUVTw0jZ5RYXsJu3sUaobJASwM=;
        b=Sbz+Cpkq5p/7VqQ9V6vx9Vk81BA7ZiMV1q+VdYxtFk/1PB4aDyxwvaouI1crRRLn45
         LvAO1axu67gjNuDUcLi3jiUVaCJjcp4tiXiKCvtc6OAMGXeuBkKdbnvdif4BO6x+9PmS
         Tx1ISisO/JaUj6Ulcz62QNBY4M7VFXMOfa4NewTuJo7LZtBOEd4ep2tkGrSmeVERYCIJ
         +wSEXMceL0DrFDoIum89VLtpEKaEDageliEezPQcP7fxVn0inATCrhkuDkvBxlbZ0Yvx
         L32m2VjASvQYbjYcg6Gs8/51hy1Q2UICn4Zk6lC+97wmgWAHjGQKYOMwxj/aEuJWGsxd
         ducg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740748363; x=1741353163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+lEhshDUI6cMzkH2vuUVTw0jZ5RYXsJu3sUaobJASwM=;
        b=YG1GzgqUhQ90axpu0R9wSRWqTEV5am9LEspEc03602YbjwbZcTYRmaKQYdRKf0gOPx
         0qZ6N/WSFO5GWAPCVKUxAlGnhWOUTR2Kv4kRhURyOgDyQaeSS6nAqE60E/o0NQo6IfkY
         TnW4J8JwDEtdooS4kWtH2Q9kAWQ1it4fI6VlNfQuHRFfIwf06dzNAgUWj+1qZfaC5eaS
         lkrnSvhTo+3rcb8kOJ0PRlKN0Ta6/69GXdVKar8eOQkEqTScIKljSaASVnXNjwgLpKpF
         YXjaehDbaOB19n4JnFig7mwvQAY+Xd81I8r6B/mWo7boIDPvwvOCAEhH0yh3s2OF4G4m
         QvVg==
X-Forwarded-Encrypted: i=1; AJvYcCW4M5qbb+vjBQpcAk6q7D1yWxh2X/P2qkXevekgH8yfcMG3cXqumJLCjlBWiKF+9FMRYVu4KMa7JVxOQDQ=@vger.kernel.org, AJvYcCXyg5kf/Mk5T5UW9OHwSncfP/REUdL51vF/MhE61rVRRF9VMW6GWc9f8SCTdfgd0pC9wHU0TrsVx6RqgSsZYAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl43d/bv1mqmT8nI0hP15QzAMCqBAOzWrpdpX1XIPxUPVNQ/aH
	EYemodBgMCukBmKEb+5TNBXWRuH7WRKEw7JEIhA1GJqn6wHfJbtLMFqGTnXsHAP6VES0d3BT0BV
	qb16Pspgk75y/oVPNieBU1Y7c4Rk=
X-Gm-Gg: ASbGncsa6Km1+Ch88IsWS/C/gK1G835817m3A6qX0j6nhFW5Cdo8Z9FwkIb5bsdm2P0
	+YW/59KGQzs/cBPcrDD5JWOuwysyyIA/+mQTy2d2F6Z163/w/OubdlD9aJXOAMOk/qwvAbC1fwO
	r+TaQwJdY=
X-Google-Smtp-Source: AGHT+IEhS4xLYJxs0tfqZh7dD8ek8r0CNJu2W2YtU4k5T4cl+cb59zgxrobehVGCWco+FGq9vu4kk8irqhSm2Az83bo=
X-Received: by 2002:a17:90b:4b52:b0:2fe:b77a:2eba with SMTP id
 98e67ed59e1d1-2febab1b41emr2144826a91.1.1740748363008; Fri, 28 Feb 2025
 05:12:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228-export-macro-v2-0-569cc7e8926c@google.com>
In-Reply-To: <20250228-export-macro-v2-0-569cc7e8926c@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 28 Feb 2025 14:12:30 +0100
X-Gm-Features: AQ5f1Jofrhmkb20pE5YuI-Rw9tp0sSCSTCQfns7NlNn-tLweA7S6JcR9oIKl8uQ
Message-ID: <CANiq72mF46p7f=G8WsnajwZfg--wTNESp7xQEsWUaiumOyfW5w@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Check Rust signatures at compile time
To: Alice Ryhl <aliceryhl@google.com>
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

On Fri, Feb 28, 2025 at 1:40=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> This is because cbindgen assumes a
> cargo-based buildsystem, so it is not compatible with the kernel's build
> system.

I don't think this is true (checking is already a very good
justification, so we don't need this to justify the series):

    https://lore.kernel.org/rust-for-linux/CANiq72mHVbnmA_G1Fx3rz06RXA+=3DK=
5ERoWKjH-UDJ9cKxvKQ1g@mail.gmail.com/

Cheers,
Miguel

