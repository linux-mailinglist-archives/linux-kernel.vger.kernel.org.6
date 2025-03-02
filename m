Return-Path: <linux-kernel+bounces-540760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D54FCA4B493
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 20:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B376716763A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 19:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FECD1EF084;
	Sun,  2 Mar 2025 19:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHpDxpMp"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9057F1EDA09;
	Sun,  2 Mar 2025 19:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740945153; cv=none; b=iL0Jjt39yDtojI74jofJo0Uxy6wxbwS1+BTQPxrP3H+prgz7UQZRQVnEsD961Cw7AxpeJn7v0dPy3bDfz5Df9S/YQ7+GECRbIWxT6v3wbxbli0/uJKquXxQMjDjBJwqhuVKNP7C0CLZ6kw6HyXEtrWJnmMCNYKDDZgAk3gUav7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740945153; c=relaxed/simple;
	bh=hHXySMyyjeDeeoBzepTdnF20WqV9PuveI92RW7vhLSc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wn5x0uXblO6GriAlYFJXqsZrqvgNtJ8kHlRT4petU4tdhCqMRZl2sGUdNyt5pX34yHNOOo94mFC5038Ff3BczDbhKHPDcZ8Zn7UIIdOgmoK5NGkcKm0OVT/Pt+4/63rSj1surt4e7fee7nK++6rUViJA7Yw0MR78G9KJEkjoj7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHpDxpMp; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2f2f5e91393so1130378a91.0;
        Sun, 02 Mar 2025 11:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740945151; x=1741549951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHXySMyyjeDeeoBzepTdnF20WqV9PuveI92RW7vhLSc=;
        b=BHpDxpMp0gGB5crUDbXfVKax+yMH+uNgP8csWLicWVjloQMn8Cmd+vUoMfOi5BvX9a
         iI3rNmiK6jswq/K50KK4g6u/rAVF5Sh8v/EORb6c70lvDloipXRskOJKtQgdSNJ4GLDS
         V7iEWo72lyDqRgCj9PdvSN4+uqZA+0XAAOL28AmAxg8AIYySaQwwKLOzreYYS7Lf71Xh
         duGptpxbg6masM6aSANJdj2U8RbMDBmvkP/IDQQoJfJc4BzD6i+mrhn3oSLd+/Q2oy97
         WgjGzDF9XdO2awnYB/q1cySu8J+02O7nAuO1GzvS9wH0CFh9nJZ38u5Mm/3CaYlbdkm5
         4M9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740945151; x=1741549951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHXySMyyjeDeeoBzepTdnF20WqV9PuveI92RW7vhLSc=;
        b=DX3RfXi4OoEqTmNOH/Si7yqbEp+GJ8l97ZzRcdtQhreQ5SKF68dQSELh6yvXrT6jvn
         2bXmlLfVXa7RX9t22iEej8Jis17kD6TWtCJeoHVA/aecWyeGZDAnACBoDplQMqNMXoZW
         +i5OfMlOwXKqs82N0PDFx97VYUeMCNSmlmK6zfORRpFaKTiyaEhd7XhSb5NRk7KgbEMp
         rE9cly7fzhZtPawAg92uNNE6MHDdVmp8Xq8T3fBdfvDWm6wK/U8v4TYvngzogSjPPodo
         uWHdkfhwcOoaqJH0J7F99xW9Q6cbOK0i3qfteZXNa3/CYe8AkQ1zzziYBDbv1kW1SS+Y
         q3NQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4iZbwisozIT2MQ+yO9tfcIiYkwJuQcXyJkAhBMGRZLnYg1hsIJcMJNOTZnKDkvTkqSC1URSasctJHRY8=@vger.kernel.org, AJvYcCXmLShW2yuNrOcr/gSBSARnzGB/rjJ4tsUx364OG2U+/LAVLShQgJunnzcbVnym33dtYdaUBPWabZbeoBI+Q3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YydY+StxUo86lFcojhrt/MVTDl9K+qfIsKAfjwKx/zgYeRLX0P4
	x9UYZ1VQmG7/znKjU2hqa9qtOqg1O9Gx6WTwqSWU28KCa8QZY1pQE070HermtBB9ZkvxxPcbALl
	c43mkMZVATgA6H6R4V2+S0c1+pkc=
X-Gm-Gg: ASbGnctx0yWcneB4ajzvZkp30YJz2QoXR/ZDadHu41M9Wbit5JVMVB0U8KpLln7cVkm
	IfqebGcvjdR5z2UYbs6qHdVedDVVu15p6KiHhw+fCMNuAwpJ03V+xy63zHCm+ciG9pOU95VDeD0
	Q9fJfOezPZd6mQGNXZtw2iWM7tZA==
X-Google-Smtp-Source: AGHT+IHnXTvUBTPtGobIrGFeedrO+dD850F4DUxvbbOgGEBNLvBYSu46PwNNNejdcvKsptIh1mncfr4QWRX4VhZrMPM=
X-Received: by 2002:a17:90b:4b87:b0:2fe:b54a:78 with SMTP id
 98e67ed59e1d1-2febabdc238mr6445294a91.4.1740945150875; Sun, 02 Mar 2025
 11:52:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250301231602.917580-1-ojeda@kernel.org> <20250301231602.917580-2-ojeda@kernel.org>
 <CANiq72=69XAOapYBurbwsQOEaw2uamZ6ta=DT6cC-om9XK3dvA@mail.gmail.com>
 <Z8SMTiWzTDjIwGfO@kernel.org> <CANiq72nQNFSa0quEwLYMUVw-2CH3FwrV695k-rWfoQn5r0Mo0Q@mail.gmail.com>
 <Z8SkCA5HD2WxR_W0@kernel.org>
In-Reply-To: <Z8SkCA5HD2WxR_W0@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 2 Mar 2025 20:52:18 +0100
X-Gm-Features: AQ5f1JqoqH71Y7MXZ8zAgXFrFSAcx9pl4ZbmzXyaWyiug3l2Kok7TN_oewmQwdg
Message-ID: <CANiq72kPF5sS7tDrtp5vRnucWLkqvzDj6EY2UbyA+X+L72xszA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/panic: fix overindented list items in documentation
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Jocelyn Falempe <jfalempe@redhat.com>, 
	=?UTF-8?Q?Thomas_B=C3=B6hler?= <witcher@wiredspace.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alex Gaynor <alex.gaynor@gmail.com>, dri-devel@lists.freedesktop.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 2, 2025 at 7:31=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org> =
wrote:
>
> Ah, ok, I guessed that you might have some backing idea on what you put
> :-) Thanks for the explanation.

You're welcome!

Cheers,
Miguel

