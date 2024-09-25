Return-Path: <linux-kernel+bounces-339496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E80849865EA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 249351C23F9E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C551D132132;
	Wed, 25 Sep 2024 17:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="I/DyKUqZ"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C2A4962B
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727286409; cv=none; b=VIPXVcHB9CEy8Pdu4N1Kp75AC5jpWLuamnq5XSg4jGAlP+7De1VDCA1aU2wznRLf6VWfPnYOl6vX0iK/7ieWIQN01DL7+ZuNeVoqdOycT2sESz81Zx7/ideNsUoIHmEkGO8HVcTRS9cIPhbt5s7C4+Q+B0fAM4zjr6nsA7zU+KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727286409; c=relaxed/simple;
	bh=M0I8Ig3rWuZiRXKwtw6xWqst8IlFBQrwd0ojV3Hws8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J9iVnbxPR1UhKXgObgbAc8Q4Z00CMlDer74wPC5mfSnA2X/5fEm/jLTwzvnIIwX4EoqCHkp2p2MMMeGnHM4AzjJkwXYnY0wCFKQa5t7Ftu8WaXH5gZFYE88jBaF1m4zV2JlwnQMX2jQfmOOyhQbb+bGznEgxBqXfFj+CO/e1/9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=I/DyKUqZ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c5cf26b95aso5769a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 10:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727286402; x=1727891202; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q7bFD0zsvjm6ZC77c3M7GAfUg/FjJi2MmJVwp+M6KhE=;
        b=I/DyKUqZq7G4SWzTih4+crIdvuLRktb+OCIDqZ6y/8nBqCF9gDCaZpwEy4ZEG9e7il
         J54KmCoAC0n/jDYDzteXMFSJ0xDwJ4A8p8gTOtu2TqKzhSFios0Rewv3Dvwo2wu9oKvz
         BFdgnwIlqfDExj/wh4KqFMA/8t3PZaGcgqQ68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727286402; x=1727891202;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7bFD0zsvjm6ZC77c3M7GAfUg/FjJi2MmJVwp+M6KhE=;
        b=a1liVg1+c+mFPE9C1pkCo/SvB4fUrqxhHJ8rZMGhkwbjMNKFCO6VHDEyQ3kQ2M2Vu5
         q2kbgLQWgzQen77GOmDkpCeODyXcV06dIRBM6nHGZUK4Trp4EfVtcYAK1CYl5AOXSP61
         Isc67ebHfuxGHEDbq7iDjUzVh840NL4TbF5Eui6Oys722eIjRDiLeNfANpEy/I7P44tC
         zO9OSpsuy+AeYlg8zZzZOUI9SpwymDY/D1fKsDyuc22Ly1lW+C+hmTNdUIy1r2WD6hl6
         7x4UUAIxsSBBRG7KZOPL3v3uhI61Hb7/CJabmv8TTVugvQY62NC3ZLFfAh1MNyK/6HdH
         3rPw==
X-Forwarded-Encrypted: i=1; AJvYcCX8XCWaguY9S87c/+zYAgTxLf/SrXXSml6WacjFfYc+JzdyAkZBNdQAFO9E3eHv9vM37DuvwwEEFc2y+jk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEUvyypZTSDgpuJIWUhaCJOq25MjbKZ3l1tcNgYRisKMAApzl1
	wNe2vA3jsmKwVy86Y3X6QNySbyglN/cPv5989ho4Ae3Coh5AVC0sgnZj6tiKH3pTpBmfE5VZuHO
	OudCLyw==
X-Google-Smtp-Source: AGHT+IFqQHQQxZhkP9CJoca3/GjnOhtQLOb9mpyZMLrvKQloFsbgECdemAoJalVDlpw986u8JGgmsg==
X-Received: by 2002:a05:6402:40c5:b0:5c4:2343:1227 with SMTP id 4fb4d7f45d1cf-5c72060887dmr2769500a12.5.1727286402296;
        Wed, 25 Sep 2024 10:46:42 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c5cf48bfddsm2193904a12.12.2024.09.25.10.46.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 10:46:41 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8d56155f51so13081266b.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 10:46:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWibLtZ0voCCH46UQUapBSjE5g5tu96i/tleKArBceONl1W6xpmLA0no66UWssoRAuVak2VNU76oBBhWp0=@vger.kernel.org
X-Received: by 2002:a17:906:f5aa:b0:a8d:2ab2:c9b1 with SMTP id
 a640c23a62f3a-a93a06b92camr365210666b.56.1727286399053; Wed, 25 Sep 2024
 10:46:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240924221023.197610-1-ojeda@kernel.org>
In-Reply-To: <20240924221023.197610-1-ojeda@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 25 Sep 2024 10:46:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjuMrUMceYX01T0SBz4E0yL4Kh2Jb_8qyKxJwwitCG6Zw@mail.gmail.com>
Message-ID: <CAHk-=wjuMrUMceYX01T0SBz4E0yL4Kh2Jb_8qyKxJwwitCG6Zw@mail.gmail.com>
Subject: Re: [GIT PULL] Rust for 6.12
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Sept 2024 at 15:11, Miguel Ojeda <ojeda@kernel.org> wrote:
>
> Rust changes for v6.12

So it looks like now the only thing holding Rust testing back for the
allmodconfig case is the MODVERSIONS support (assuming modern enough
tool chains etc).

I'm inclined to just do this:

   config MODVERSIONS
          bool "Module versioning support"
  +       depends on !COMPILE_TEST
          help
            Usually, you have to use modules compiled with your kernel.
            Saying Y here makes it sometimes possible to use modules

in order to have the basic Rust stuff be part of the usual allmodconfig build.

That gets it building for me on x86-64, at least. But at the
maintainer summit I think you said MODVERSIONS support is being worked
on too, no?

On my arm64 box, Rust support is still disabled due to
RUSTC_SUPPORTS_ARM64 not being true (which in turn seems to be due to
SHADOW_CALL_STACK support, and that needs rust 18.2 which I don't
have).

Anyway, just a heads up that I think we'll have more "unintentional"
Rust build test coverage this way.

                  Linus

