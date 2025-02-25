Return-Path: <linux-kernel+bounces-531978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC187A4473E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 675F5172008
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19D8192590;
	Tue, 25 Feb 2025 17:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nHsr4JI7"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2CC2943F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740502960; cv=none; b=unyxTqlIiDgdjtc6DNutoUteaa1evTGG6AMBH6HtxBcL4WqABn1vOJAEAkFAY6ZJW7BVx3G3UBad6PflQY/uxgdPPjxq1w/tDQa+fAKN1tZHGs80IQN5aw5FXS+K+Lcg9yNrBA3a8kQkgXvTtzy/6JpA9ORk5el+Ug7QOqBO1Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740502960; c=relaxed/simple;
	bh=inxYI7a0SFVXalZa+rRuAYm01VsT7jhCgH6Sa5CcZ34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yk/H0DB0J4acwOuHdK5i3a1aun+GHAYmVESxMBFIywRcPrzyX30I0v8t3ca7ZgDHaBzJP2E5JuGha2xGnXapu9F2KyzP8ObNmWT95/D0g2RMHaLBOMNHhZu4FbalkSqdJSb/hIlYB8x7tPqcNox31Fmc8Q2cO4x+pi6RXZfMArA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nHsr4JI7; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e04064af07so9121880a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740502957; x=1741107757; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=inxYI7a0SFVXalZa+rRuAYm01VsT7jhCgH6Sa5CcZ34=;
        b=nHsr4JI7tM2bcbdQYjBNo6OE0j7gMJLJvSXHVJceN7jref5wUf8hOfWs5rARDdHaE1
         E/KurbQl3OKuieRyy7MzBpmUO8FxlV5DUyUbXZF/RAtOC8Vyhkhv6/zfsmEM78GpsSYJ
         VHoKOGzkuzNt0Q4dj7kjfwpXEe7FU7f+F9GqILFSilEAGbZKivsA9FWfxe6QhfMi12r4
         T3pjEE9KWRuldP8eGSdwCY0wjR95poWszHNi3rolnoI2QrNLGsxAOswDdjRHxiQy8uQ3
         wOHLTPh+ecV0DRYs78fR9QwQ6QdPDYu7iRd+HJTPGI9th95MY3RgFsQVfRqQKIbHlVqj
         SSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740502957; x=1741107757;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=inxYI7a0SFVXalZa+rRuAYm01VsT7jhCgH6Sa5CcZ34=;
        b=nKY41mgyDiHsmlG+sNmRj0vLHqYxTOPnXH4NQecJ0fmKzcjBnygP9eGwqfSzioYVKn
         GzauBAUFlZlmu4rp+Dw6QXyaMvUG7qK3TtF8W3LXMMUQFGeYZaBr6pVSa391t8YU1UMW
         Uo/aTOj/HFAK1OmS1uyOu5QXij5vPwT/F6BVDvAnrXBTkb/3axscP/Ww0JS/ZOwwBS/V
         lb/Fxr5CUuVfnPxMMg0RWrM/5emgBpMwGXQDTSnznXJktZobg0Jm6zLIUMamH95qIrWA
         zv6+19WQLjXcVror6NyPe6DXd5PuYE8tvSUqv0U6ThGoqGCeQAcj18ICAQJvKZDtITCD
         qqsA==
X-Forwarded-Encrypted: i=1; AJvYcCUYWtS+3Px37XodEHOnlaJyj5oMPleF1J5IS9Hzu7iyCImytgIolmuS6NUVrFlEJwxoEEaLB6tai+LIDis=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiDNwGIA1uBmlyHT9G0ZfTUgcKSMwra70r/j8HbPhtjGcR7OLk
	HOvUrYe6v7Nom2aey7aM/Ur4T7mkVO9MvIVBrOTXhAFmpCpIZOA0jtwARy0Mdtn99ef9O0UNQOL
	nWQ+m9TSISW63qi1TY3fv1GjeSU8l7+Lz3iIStQ==
X-Gm-Gg: ASbGnctyJo4j+RgkLINhSBsmWymhNA/oy9C4Nbi66ExaeTZaxsOTt1eTu3Q2qo8pEAm
	B/Z0WCeMEVCXIBfhYyIDI3f/szPb9R/XX4NuuRXapjLU3HBJs5KlXX9inJzTaPnlJXC+3gJ61Ok
	cZlbvVDGI=
X-Google-Smtp-Source: AGHT+IHG7KWqmrrEfmkHl16lnyEnUFqzJos/oKExNnyPDEP4u1yoAp+TQVlLKnzCiELY1vOHL9S07T288ex08DhPTV4=
X-Received: by 2002:a05:6402:520d:b0:5dc:7fbe:7310 with SMTP id
 4fb4d7f45d1cf-5e44448119amr4294661a12.6.1740502956713; Tue, 25 Feb 2025
 09:02:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740475625.git.viresh.kumar@linaro.org> <68ac0f0ee3c0ebd3d3cc078a6270752778a1b732.1740475625.git.viresh.kumar@linaro.org>
 <CAH5fLgg7o7hs5B4mMzPd6RzYm+RcX8gw1Aw8voJqnmfnA_aM4Q@mail.gmail.com>
 <20250225114830.64p56bndn4hkkkgq@vireshk-i7> <CAH5fLghUDz8tpkTuvWZgwT2_VKgxuS+iZKnoT4prKwS9tbp8wA@mail.gmail.com>
In-Reply-To: <CAH5fLghUDz8tpkTuvWZgwT2_VKgxuS+iZKnoT4prKwS9tbp8wA@mail.gmail.com>
From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Tue, 25 Feb 2025 22:32:28 +0530
X-Gm-Features: AQ5f1JryIXlM3NUmzUgSEkX5tUke-JsoANytTchV55hGvhuch6fz7U_D9kJhvX0
Message-ID: <CAKohpo=uiCS6nyissb3ugiyniwnZYu5kCf4+bp32dDzRhgGfCQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: Add initial cpumask abstractions
To: Alice Ryhl <aliceryhl@google.com>
Cc: Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	Danilo Krummrich <dakr@redhat.com>, rust-for-linux@vger.kernel.org, 
	Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Feb 2025 at 17:23, Alice Ryhl <aliceryhl@google.com> wrote:

> Is it a problem if a value of type struct cpumask is moved? It looks
> like it is just an array of longs?

With the current code, if I replace the Box with an on-stack variable,
the kernel crashes.

In my usecase, the pointer to the cpumask array is sent to the OPP
core, which may update the content, though it doesn't save the pointer.

But for another usecase, the C code may end up saving the pointer.

--
Viresh

