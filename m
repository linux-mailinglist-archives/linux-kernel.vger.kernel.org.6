Return-Path: <linux-kernel+bounces-546922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E42A500B6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9208D16399D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2821A248890;
	Wed,  5 Mar 2025 13:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GToDiysc"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEE338DE1;
	Wed,  5 Mar 2025 13:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741181857; cv=none; b=KvPP4ISdlA0XZf298S+c+sbw4ZNCNhEBLVgxpIsJjHKKCvVFrlOaoIhVqO2uxiqZ8VVXbSNVZYLWqmTQ5LMHdbFP3OtCJZDSAATd9Dkbtd5+hiKxMqf792lfMCiCda6bKHzXekUFIpUHDJD1bWN1yOYkqHUwNwW6f2zwn8Xq2tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741181857; c=relaxed/simple;
	bh=LYG1JGkuAtzVFKBPlr3mgP0nwL0sh6hxXYKc4HHE+Yg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NsC5JkiYxMwPhu0hjEx6qJy1w5by3atf4AnXK5Q//MPDRh241jOG6nb5RtRl+/UOmfLzFLBdgBSPt8pr798ME8RuqHpt6qRsPqBKEtsqOAOklivBGq0A8/8xIw8c2mVDKTGQB7FDB49QyfgRXN+L1lTomxT7SDEwG1WPKS4xYWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GToDiysc; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fc92215d15so1552097a91.1;
        Wed, 05 Mar 2025 05:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741181855; x=1741786655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYG1JGkuAtzVFKBPlr3mgP0nwL0sh6hxXYKc4HHE+Yg=;
        b=GToDiysc0MRdaRXBauhdZe0eqzxNvBZmWUvRcM30RB7CMQ+uhv5X4+POCVERCgKBgv
         aBm1cSNYfzAXzHWWp9npkNxN2LXfqDk8CWcQ4E5i1hna3qsz17p6XbG6sqf81h9J1HHJ
         VR67OEmk+8XvricJPOdZh7IYkbvYdY4SPXJ3pz0haBRvghcZVVPcip5BQ/RmoE3zoqAe
         vIvgaKXKn+amFVUxNM7FUhVt8xDnpJQPZtSUU6RzRFE++tDM3toxZ0/4fKFX2z+CL3zQ
         pLa3rFynOjxlQwXPOwjjWrepvlZcK7mx/0xcqQMNt4qI7319UGX6sCAC9q02OhL5p64/
         AnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741181855; x=1741786655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYG1JGkuAtzVFKBPlr3mgP0nwL0sh6hxXYKc4HHE+Yg=;
        b=Qwmv/MxRQDWmbaGYU1AnHp+fJxMUJosIBe/MBpy4eGDQClfQxsTtMXM1pnKrHhtAIF
         r/G2rePIjz08dN2Apts0PIIrOkTKL2Pndt6zjdLqzbC5bLCtuaSn0Mn2ac6q+MeYYVTT
         WGExis3b9kXcPkbaMbnuuIkTOgR/PdDKyxK5dNCPJWntSFEb/Stwhlo7YAqbMnl16bBD
         5OLm9AGRP8V1Z1kEVDYaNWDnOQwHFeIDZ4QAnGKxTCCn7G0JYohUX/hKRO9flIXX5O8M
         6ZZy1AGoDzV0eYB58YIAw9FVr3w1bx7rZFZ1MzJtq0IFsx7pLUcYM2zOPqt8S5RlHa9x
         3R6A==
X-Forwarded-Encrypted: i=1; AJvYcCUHAcFcVO8RKG70U56wZz2ihS4+967OPvX33IahyNHWOz4dk/zvD3xGzQ7I0Kloa1d3WjI3cMESCFIEqh83Jh4=@vger.kernel.org, AJvYcCUvy4rq4phDczQpYrB+I6tGU1XOQg5oF4mj1GzWaLD+EixYwUoa0nxgwD4cIcu7oyofUr4/GCzDGxAqUIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLRtqSSLnKB0CTg/5In59KLsbqLsD03vpF79AieA8TnLLLMhG9
	MX+BI7Xmz0vaUrXXynuLiihf1ifhcOti8g0uLJ4KA78biLuyIHEavsIWDJSgAaY3gDHMb3rjkuO
	I5MO0Y5UV2LBpFFgX8z4clShjrLQ=
X-Gm-Gg: ASbGncts7KKarsqkWCSPDkw4R+C+2GH9G45Jd/S/na3DpZZA7jFGUtY5C0uI1dBZ70p
	UbflBzbWK5liGkB14EHPbFk9XBgszOc9q38MIwuwk+T+rB6al3n4G1X9UV6u41Six+WxjBAuNGr
	FiysjSmQXJucZXUQ8yOOkLzcsYUw==
X-Google-Smtp-Source: AGHT+IFaie7Z9ucIcaqvsebKQWBNYmbZVU4XAV6YfqbiQsa+DaOln9IARtqKnMBI66O6OlDQ6O/c+nxN1WbeExXS/6E=
X-Received: by 2002:a17:90b:5202:b0:2ff:4b7a:f0a4 with SMTP id
 98e67ed59e1d1-2ff4b7af1dbmr1599313a91.3.1741181855243; Wed, 05 Mar 2025
 05:37:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304225245.2033120-1-benno.lossin@proton.me>
 <5Q1xnRAO-CFSBw_RfcJwj_wKB2rd2Qcc2qFiWmrWjueSmkBd3T-BuqlHSyrMrGIu2loBNIJUTRmvwBk2hfoneA==@protonmail.internalid>
 <20250304225245.2033120-21-benno.lossin@proton.me> <87y0xjaat7.fsf@kernel.org>
In-Reply-To: <87y0xjaat7.fsf@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 5 Mar 2025 14:37:23 +0100
X-Gm-Features: AQ5f1JrqJW-k8vJfThAziF6-rsSIdiz-rZL_iC5ARy1XsvDpnWvvyru6bOQbYss
Message-ID: <CANiq72=RjmVqvpd-n2uF44UNVvkdkvrKqUJDAbZq8MYjNvXkAQ@mail.gmail.com>
Subject: Re: [PATCH 20/22] rust: pin-init: add miscellaneous files from the
 user-space version
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 2:08=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel.=
org> wrote:
>
> But really, if you are already going to sync changes with automated
> tools, it should be simple enough to have a list of file that are
> excluded from user space to kernel syncs.

As far as I understand, Benno already excludes some files -- so extra
files could also be excluded easily.

Not sure about these though, e.g. they could help someone realize they
need to contribute/develop it elsewhere. On the other hand, we could
have a custom one in the kernel instead, explaining just that.

Up to Benno!

Cheers,
Miguel

