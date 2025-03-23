Return-Path: <linux-kernel+bounces-572956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6F6A6D0BF
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 20:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30A3B3B29D2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 19:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B481A01B0;
	Sun, 23 Mar 2025 19:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFze4F12"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4639EF510;
	Sun, 23 Mar 2025 19:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742757848; cv=none; b=UDhKbd2djcwij5vLiEkokXxQa0n3/ycarKhlab6WKbjmJEhR07AXITBg3+izudtrq9GaA6m5ZouKp3fVK2oQPYh8+JMWKoCVrxsYC154R4w4uPb4INiiLra1LsA0JxLjFxLlgHn6Qk/GD8z95rsBU8PvOZc9uDuiPt7A5Xrrr6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742757848; c=relaxed/simple;
	bh=Dy0hpGo8yWQ5rtG4Jhlvejlc9fuQ+WBwppGj/BD+sf0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MWOxwfh/VOoupRYzEJoxrP1YKdPqqs1xKaz0Pq+RXSNdZpaHWSXzZzpXBTXqeX2xMbsnG9CovHVtbew5FRsAt+eerdu5Hm+bpO2uD8zYv2WUIElznrr0tJmrAsgXBX40O7KsEECIJ9Oq1gQfRy/q0xvpYRZIoOeB9BFf6n9/Nys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lFze4F12; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-224104a9230so7805935ad.1;
        Sun, 23 Mar 2025 12:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742757846; x=1743362646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dy0hpGo8yWQ5rtG4Jhlvejlc9fuQ+WBwppGj/BD+sf0=;
        b=lFze4F12QL60Q52lWhYnGR8tdi8uZ7hB+wSYRKf3XanTzOxZNV9XQ2wB1qITcdl8fj
         4GNSrakX3Xoi74AFkEhu6OPvotntGGlYqXouijul2HhoYnF63sZUKnQ0oJyIa8NdTQOF
         BDT19ltEBNYxRcLx1lfcXrPQmNXBXSyHTEj//UzLU7crPY6RHpI4H68OriXNC3ZD4Oi2
         IerasWLOOdHDSMQwr2LIF0PZUGKIzxU7gZsUwM3TYBUtrHAaBI/i6NPFN5ljmnkKtCAV
         rAokHh8UuL02aT3qXnZVz3ihlfW8Q2VKs8oSlSXqC0Hp66wWoWbxEOBYzgBHX5GCDH3H
         G3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742757846; x=1743362646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dy0hpGo8yWQ5rtG4Jhlvejlc9fuQ+WBwppGj/BD+sf0=;
        b=N7cVVT59mqnCzanB1BTTJ0aUWQO6adXRvY099i05MjCH0BpGjWmE0Mv+PL/Bz3hXOx
         A7STSzDn04vuanm0ddxFrRzzdRM0xVF0RKG2biLAUvO2XCsz3c8tX++NzqE8Z8UkSl9D
         Yb++VIV/+fRrbSy/K6YwoiGl52Qkp5RhZGFs4OBFVQTqMffmSHfD6FER3d29CeTxTKDK
         VBU3f8RQun2VtruPq5e5isz+3usYQPKEaQa7HYiErY1ybhBj0tMcKumKoNJf0S41Z4Xi
         uCj1b8Gr9olyOAcFvlrNZpMitzo9FvQkxsahb8YEq3eMu2qhOSyUoraMbu9cbkhp3pRx
         T7Zg==
X-Forwarded-Encrypted: i=1; AJvYcCV9OHsKRSdV3301tbc+NGbabhOXfGcBGbGXnFntZm1SeMJeM9+pk/qCtQ38Lfo+lBcVOtS7BqKJlvOKYAYzJto=@vger.kernel.org, AJvYcCXTnOjZM2acMkmSgZyD7FDTzbCZhEHs2JVzY3P52U7DSNCgugFSRYv2iONRlJvJuM1T7LMDlUEdp/Um+Aw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw5E2DM5ZxPOf5RyqlEwLX8Hw0BsQPS1q/jkkKfbbbD/H1LtHk
	ykAIgXa2C8vwcpBUSyIV5J0Q6etdQW3GDpLqCGWFCDP+/LCtxTRerKgSzBmz+Nk2RcuRxe3G/Mc
	rauwG+PDCVuGe/ljZ/fcjykB402w=
X-Gm-Gg: ASbGncuRVcLoNCXC7FDNxcjv4E6ydk+/5o5G39aslqZvq+WZJ60kiMz76gQTGdCH6ns
	456eVVhBrYmRE+u/5dyR1UptSne3AKsG82dXLpZGWRPZVS9CmJR8LOsZUGXiQFtAxO4eyz9/LdS
	6UCZAFzX8ADJ+BxAnS3lCcirwZwQ==
X-Google-Smtp-Source: AGHT+IHC8QLKOnPKCgOf+JWajmyOwdyDtRcfdh4lYiTz+ecifAojfb8ts4i5aO/iCHz9pkPn+34QNCDocIBAGwQugdw=
X-Received: by 2002:a17:902:ea07:b0:224:1579:b347 with SMTP id
 d9443c01a7336-22780d82835mr55110405ad.7.1742757846436; Sun, 23 Mar 2025
 12:24:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320020740.1631171-1-contact@antoniohickey.com> <20250320020740.1631171-5-contact@antoniohickey.com>
In-Reply-To: <20250320020740.1631171-5-contact@antoniohickey.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 23 Mar 2025 20:23:52 +0100
X-Gm-Features: AQ5f1JoXHHwahhVe3ZkJprXZ8Y39wGvnwQDCHA7qtcnvzRh2eol_yxMAY0pLvRY
Message-ID: <CANiq72mZrLWQ+cCdGZ5aWA_upDFEq00CG9kMLxu_-8g2QSHe-g@mail.gmail.com>
Subject: Re: [PATCH v5 04/17] rust: task: remove use of `addr_of!` macro
To: Antonio Hickey <contact@antoniohickey.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 3:08=E2=80=AFAM Antonio Hickey
<contact@antoniohickey.com> wrote:
>
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://github.com/Rust-for-Linux/linux/issues/1148

I think I would drop these two lines -- Benno definitely suggested
what triggered this series, but I think the Link does not apply to
this particular patch, and Boqun suggested this particular change in a
review anyway.

Cheers,
Miguel

