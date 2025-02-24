Return-Path: <linux-kernel+bounces-529587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 914CDA4282E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36736176E73
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FE7262D2C;
	Mon, 24 Feb 2025 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GObUbbBD"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF312192F6;
	Mon, 24 Feb 2025 16:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740415520; cv=none; b=GtTybPhWiZdn+TQKU9W5MI5z1aHU3ywC5o3jFrakNZmKtb4ICIvq5HZDi2IHoVqpfJoT/6gXatZ441w3axsfGg4cpOQh0bpA6l4PX1wFVlfh84RppQ/AYk/AFTEr00WBM970hTp2C9EQDmkPhYPEFotUNABsHNv3q4XKNEFj8SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740415520; c=relaxed/simple;
	bh=uj5K6QrY/NZtVR4BULl0kxEtlQjRdygKs+++stgv4/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q7l0aq+HS63aN+80RyYQjHK5heqT6q8ae/VSW0e42oo58OLodnAIObkQDMH1KFcPYNTKg/buu5xyAh1Ky2nVIQ+JER8wnhP/6sDtv7iYKcsXLOh708edS8iw9NHMAT0BylHWqpZB5PO00vpQSGzyaIwilU0zzcLeDJe026BC9Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GObUbbBD; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-216513f8104so10889215ad.2;
        Mon, 24 Feb 2025 08:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740415518; x=1741020318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uj5K6QrY/NZtVR4BULl0kxEtlQjRdygKs+++stgv4/U=;
        b=GObUbbBD6KF8vGlhl/0mxpwwuE374Xtf1tv1wslOU8fZgwCUO6K6XGAnqL82pZAq4k
         Qn4BHlf4tIzds2XmD53L5F3ILTXRfaVeIzGkw5NBdv13c9zT+B6RJHPXC/2EUBG64bgY
         mZkal8jbQOf4KuKCWrVHIZRiTCytBjxzj71EsvwgjCK1VRiK4EVcaqoKE/xj/hDI8GnB
         iO2Uv8+pa69tsuH47NUcPi5ICarn5u6qGM2V9rdKHMsYhLz/l4j+LAoOKcknHXbzmnkL
         dL5fBEPdnGHWCUBkZxXcXDOChqVKibhnCU2eCBAenNRiFwZ+tXHZGXjihSN3tADFat/A
         VaPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740415518; x=1741020318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uj5K6QrY/NZtVR4BULl0kxEtlQjRdygKs+++stgv4/U=;
        b=uU7hsBsDxTXZI+Qu/QpC1ZS9lYmG1TOIIvIyIkCWnlQ/FVVf6ve/SCgu6iR5+y5785
         n0TBJr0tqLnlo3eN5JWtc8vaoVghGpZKdSTNy0VmC9GnxOW8VAiActYUwaLTAywRqkCd
         YeoLrCKXHWnqt8J2XZfXH3T0gh38Llx6yziJa3Rxkl6acMLJj4Ncywuhd567xC+WVeXs
         xPl29abghi7xPD1wHLDxEQK3HwQ5siNmmOiG6XIjbVPytddM9RiWcEwx7yTlUjOtwI9C
         HDn5zEjrqanI5LxfUzcigWVoq5knJKoX6Fbts03LUc+ORxQLNF0WAREzc8RDlpdu7p7V
         dDwg==
X-Forwarded-Encrypted: i=1; AJvYcCU2AjL6LNTBhA5hJO0rdoEVxUSmzLsLK0QMwvRxHYA9lBMcgAN3H+ZoY+Snrl82idI0aKWZosmCw8ePLOw=@vger.kernel.org, AJvYcCVmaa5ZhVjcrm99ifZOczhd0StggDz921BV+JhWRqytI3GOcDi+jPPrscR9ziLsZrddc8kTZC1nYfYB2S/aNO8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOb5n+4dlyRFeY2pdDWVFUkztSkWJBEyr07bwzOBDZwZwX6tDY
	3TPa9AF51XHDnph2HB/1+h92UX3t1UhqRq9TiISZXIJjBm2W2P2a2L8nUPc7hK1ockYAQa5Lsp8
	7O3fxUVWEIiqxy+MjSo4Z5DJv4hA=
X-Gm-Gg: ASbGncvy6I7QzefuDZpfjGPIbmldnpEOgyjJpWcIwMa3K6oqxWN4uyb56HyyffuOWvW
	fZBKAH/cASW5wPjQqCmG+WsdpZzwbD0zdpTdYah08gryf1qjCTh6GL95rkZw3ChGfz4zl1h6y9u
	ji5i3COY8=
X-Google-Smtp-Source: AGHT+IEOlynN4k43h4aq8K4hteWR/T6PJ2jMxXyu11z+9OfVY/LVbUXtZXl+876i1Nm3vT7+XOGRAJJZ3v5epJY5UMY=
X-Received: by 2002:a17:903:2a8d:b0:215:3862:603a with SMTP id
 d9443c01a7336-2219ffd66a0mr90158605ad.10.1740415517832; Mon, 24 Feb 2025
 08:45:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
 <Fg4QliwzbHj3m-Fr3ZeUiU11d6Bu-I7w_9xzSsnDlzQtqCkjgqxJpI6_YxuXnB8m0MqESq6V7vK7FhPnEcvGwg==@protonmail.internalid>
 <20250224-hrtimer-v3-v6-12-rc2-v9-1-5bd3bf0ce6cc@kernel.org>
 <874j0j1nv2.fsf@kernel.org> <Z7yUTNEg6gMW0G7b@Mac.home> <CANiq72kx31exTFohb3+9_=PGUq_JtqpCvG8=oQUc_gZB+De5og@mail.gmail.com>
 <Z7ye0MsACNWe7Mbr@Mac.home>
In-Reply-To: <Z7ye0MsACNWe7Mbr@Mac.home>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 24 Feb 2025 17:45:03 +0100
X-Gm-Features: AWEUYZnQY3I41OZvfrgEsINUVQJQEKooAljmA3gwJx1dSt9-BV46MIGN5KpkKwg
Message-ID: <CANiq72=qayfPk+W4BRiXe9xBGcgP2zPf-Q3K6GXTg8MKy-Kg=Q@mail.gmail.com>
Subject: Re: [PATCH v9 01/13] rust: hrtimer: introduce hrtimer support
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Danilo Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, 
	Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 5:31=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Mon, Feb 24, 2025 at 05:23:59PM +0100, Miguel Ojeda wrote:
> >
> > side -- Andreas and I discussed it the other day. The description of
> > the issue has some lines, but perhaps the commit message could
>
> Do you have a link to the issue?

Sorry, I meant "description of the symbol", i.e. the description field
in the patch.

> I asked because hrtimer API is always available regardless of the
> configuration, and it's such a core API, so it should always be there
> (Rust or C).

It may not make sense for something that is always built on the C
side, yeah. I think the intention here may be that one can easily
disable it while "developing" a change on the C side. I am not sure
what "developing" means here, though, and we need to be careful --
after all, Kconfig options are visible to users and they do not care
about that.

If it is just for local development, then I would expect the
maintainers to simply disable Rust entirely. I guess that may be
harder in the medium/long-term future, but currently, I don't see a
big issue not enabling Rust while developing the C side, no?

Cheers,
Miguel

