Return-Path: <linux-kernel+bounces-573015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAEEA6D17A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 23:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2938C16AB77
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 22:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4423D1C5490;
	Sun, 23 Mar 2025 22:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayKGuSYU"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5529FBA53;
	Sun, 23 Mar 2025 22:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742769525; cv=none; b=ujgFDHX7zyGpcVVcfN4PsF2xhXmGoMpHvw732ggEqnWro4mNIg1DHOD4CA7BuMwPS9czRxkEKzZJTOE17OQJnlxtklCGQNROHZhmVCe1flJbOjhb4VY231gnuRYIbHbjxnFiIk//FgWX4rhG26Cb3GQNtKff6qcuaI3DAvGXczE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742769525; c=relaxed/simple;
	bh=8uR5ohFKmJASGtTtM8oHUKbD8u/x1XDPXbv76fmM6P0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQt0GdwaGccZqkcjEgSv7A1db1cYxCrLCvqXLmwmgbm5SvRlOQiNbOC/6Umum5/jT9hbLy7/4pRb9hzp+Nr+yuFsOHKGsYFTVUHXFgeA1und4owdMwyuU+NfJVDRNYWl+1bHYtxu89x2I8aphKof6dolMEJj+rqKU77AdRy4Bo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayKGuSYU; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ff6b9a7f91so1158675a91.3;
        Sun, 23 Mar 2025 15:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742769523; x=1743374323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdHrVSYx7MMsayXUAqSR1G/E1xOz51QHeLdrGhdbPXo=;
        b=ayKGuSYU8ir4uDn5eu/l7lF9ErUYQ3GDFzyYUebLAVhBwi1nC257U+IwRMD+1UnriP
         kjD20q9kRPdWYijfkYsvkAxjoRMl1eNV2mlgV72GloRzAL2J/bMZtoOhsQYEvTxremq1
         5hpo8DfrdI1DfffWZGvE7L1WTFJTrH0CrVvLOwOuWqLKPkQVPFcV9LC5YdSiivl4ESHu
         8HU9uRGjnaonHJ6/Xf5TG3mHpeqo/mCPn2tLQR2JqSq9hY0hubHMChyCzDCSNBMwod8G
         yR8mAhFldQfnOuOaeb5ugcUbXHaD8nscuo1hxld7jwJVrc+3bDvp55UP6tRzurz41mZ4
         HbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742769523; x=1743374323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HdHrVSYx7MMsayXUAqSR1G/E1xOz51QHeLdrGhdbPXo=;
        b=MM/Vyct8kp6GWcGUUofAKCOlKXYLj0fBmYJUEdLmE0R+PRcWfCjfcDk03gF+lml0GO
         JbX8srw+kFMkSVyJmpk6FIykhfijCGHZx50D8Kq+uYwsBt394tXRDhPQbLEerFatvcCq
         +y5aoDVbdHZ1rbgF7BP1ip6+x+FhzYFgWzadSvPe8D0zk999MdqYcXILUkirI2gtV6VX
         i5FYzqhHCrAaIRyvQofqvx4o5OIvqCvXvDOYwKiBGTrmobOV66ZpjTsCrJgMRaKDp44r
         h7ssmrwZqJgvBK+YvutplPKASDLYucQQoltUtuVNpUztV7+/zSpLg3y+rVAcRqDvaFsb
         FKNw==
X-Forwarded-Encrypted: i=1; AJvYcCV4KF3cdKGI0uXGGz/3McznDcGtwZnyVxDsKomxuUnXkjSREFMGuQ+LAjsE6c/P29s/CQKkte7F7W7MV3k=@vger.kernel.org, AJvYcCW/MgYChRRRVS/Aa+P/+dayJnQvNBBNQcYZeVTD3w/7O/CP+QZXbsWMYxcka4ajVg0ZXe94L4kycVZIm+BAWnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIBkn+MNBV+yAYP5RdP3JQ42XvTdpdR950cQ9m4bSfn6+9K7LZ
	NyD35exGMisuJIhk7587Fk7XlbB+j5HE9VuaC3v3ihNn56R1EF5+Fjic14tnYUoqOSLlujDyi6z
	TIELw8rGXDiwTC8KpxljD1YK4N6Q=
X-Gm-Gg: ASbGnctTXP9ufJF8Jz4J5f/Mu8nJcoi4qeXodWPB6jXE7tTL1UEnAKkONzTZoAj1o+l
	TaYVUzrlTDEVR8QoA9yBSsvY3Vl+6ilhqNEwcF58LbF0+578f8mSJ5i1HiAvCZd6PoJO4cHdMC2
	AS1tILq25IUNp3u0sybnyJkJfl3g==
X-Google-Smtp-Source: AGHT+IFwMhhCMPddLf9J8gorwWlQJJZgCCW34Xu9TSuYX2lZ0/HMOAcPNKpgCbj6eONjBKgbJjtbRHZfPw/9Dmcpe+Y=
X-Received: by 2002:a17:90b:3ec5:b0:2ff:4be6:c5bd with SMTP id
 98e67ed59e1d1-3031f50ebf3mr4540168a91.8.1742769523614; Sun, 23 Mar 2025
 15:38:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210-macros-section-v2-1-3bb9ff44b969@gmail.com>
In-Reply-To: <20250210-macros-section-v2-1-3bb9ff44b969@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 23 Mar 2025 23:38:31 +0100
X-Gm-Features: AQ5f1Jobq-bERZURvflG4ZCAS4wB2yrr2zPa2L7KTdhTikTcaRvK2NeGYkSi2W0
Message-ID: <CANiq72nTiKkL-QC245Te3D-RRQmzVwbFRsc1aacUJXX91REFJg@mail.gmail.com>
Subject: Re: [PATCH v2] rust: macros: fix `make rusttest` build on macOS
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 3:51=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Do not emit `#[link_section =3D ".modinfo"]` on macOS (i.e. when building
> userspace tests); .modinfo is not a legal section specifier in mach-o.
>
> Before this change tests failed to compile:
>
>   ---- ../rust/macros/lib.rs - module (line 66) stdout ----
>   rustc-LLVM ERROR: Global variable '_ZN8rust_out13__module_init13__modul=
e_init27__MY_DEVICE_DRIVER_MODULE_017h141f80536770e0d4E' has an invalid sec=
tion specifier '.modinfo': mach-o section specifier requires a segment and =
section separated by a comma.
>   Couldn't compile the test.
>   ---- ../rust/macros/lib.rs - module (line 33) stdout ----
>   rustc-LLVM ERROR: Global variable '_ZN8rust_out13__module_init13__modul=
e_init20__MY_KERNEL_MODULE_017h5d79189564b41e07E' has an invalid section sp=
ecifier '.modinfo': mach-o section specifier requires a segment and section=
 separated by a comma.
>   Couldn't compile the test.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Applied to `rust-next` -- thanks!

Given the `cfg_attr`, I think this should not change/break anything
non-macOS we have, so I think it should be safe to apply.

Cheers,
Miguel

