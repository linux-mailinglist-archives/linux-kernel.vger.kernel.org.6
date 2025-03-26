Return-Path: <linux-kernel+bounces-577661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F075CA71FFB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 21:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB3233B8854
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BB319DF9A;
	Wed, 26 Mar 2025 20:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbR3F7j2"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECDC217F36;
	Wed, 26 Mar 2025 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743020345; cv=none; b=GGZxwzkTcu4tFTY4EXTvtGfS2GNlB/e5c1CwT4fPbUTJOuy81rIhQd11Rw/+bg2NwRI2NqvXkLvGc6/oJqiOw0yyF/95cl1tUbblBlZX4NqpaJseqRq6WMII7+5AWm8RgEgA2gvqg5LsXB1R8EEoBK6oRfcHmbGHLGNMjqyxIPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743020345; c=relaxed/simple;
	bh=S185myDo2AMGn9S4RJqk3PaBowolTa8UZ4RJKBp7e/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X/6+j0dnvp8zDNrE0JPcjUlL87Y+Q2YWaxF8n8uwDUv2NJgxbJu3xurhYV5xPqn3eFK34vMX6TdbAGX1RvzmNCOB3BN6KMEOxlN/23JGhQN3kp07Ik62THByzdzxAwWe+x6j5u4/KvdSXGOrVttO6FsULCyjzsGr5B2mwFRRGdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbR3F7j2; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ff5544af03so59071a91.1;
        Wed, 26 Mar 2025 13:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743020343; x=1743625143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S185myDo2AMGn9S4RJqk3PaBowolTa8UZ4RJKBp7e/w=;
        b=jbR3F7j2goKvXvTsCZ5exRal73N05eDnjfy4iZ7zqo+81nwast9UPItCPMQR6dY8p/
         RASI7hz8DxmgMWXn35Q1Ut85OMI78bvQMOPgchRRrpfhUz9BnL/vlOwosv8wnkWPfxUR
         iar0KIfVaJlMr11+qSYhIsHx9ELZiIYMCPkR8EeOk5rJWBVtKxfxApC8jCLWjPpu9oKz
         5vAwpltQulb8eKp0ZLSzfjssjHFpq8fxSZpABZGbEddnoQjrSRdA6zUZqORfMSAVlz1Y
         n8iaQSTApmZon2YMUgy3ZSR5x7Jm4qsrj+FXuPuKXcxtOF8ms5kuriJp/aHIihbMwQ2N
         w/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743020343; x=1743625143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S185myDo2AMGn9S4RJqk3PaBowolTa8UZ4RJKBp7e/w=;
        b=MKwtLbrb5ayhWtMffjA0CAyoKpS/U+rGCibDBWvnY7pPpmO+U5jIEJTwakLlf16M94
         iJQNOTz5gvThFz9nbyhLWisM9vtv/NriY8hZxaaffjvCjrTVHHK3pVj8yKTPrgGtZrGv
         B/HTKkuN5q/LaEY4Jp7CoOr0X5CEtNGehWrascQuhGCUMsVCWOI8X8ljbAIR0+DuMDjp
         OzyGU0KFus7Kk3I0HSLM+i7yRQqnV1tgOG+SxJLkgrxyRXWG+B/x/t7/gcS7dUo6ijHn
         EUmSjiU5g40eBal81Qd4ZO6JxoFB1q5H0faNbbiQNoQfLCTae5Mzlz8XqzGuV6tjz3ZK
         3eJg==
X-Forwarded-Encrypted: i=1; AJvYcCVy/7nmCtS6DwKFQSrNtnE3mMFwmqUjWrG074+H8Teh1UAE7DAWyYhddjBeJB/uAv4+5tKPAqJNh3Ax34E=@vger.kernel.org, AJvYcCWpCgPYaK4UpC8AF3BU+VsnDzi1yrEMr4r0dSP4/VvSBiRCBz9rhD6GVpCs9e3GDwbE8nTdOCZySO1P2f8iyjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy54YWohSHIa+BsN59uci5NkEimbvhx0+AbxkWGG3dGW8R5O86H
	MownN6wA0cey4GLL2MFTnS6hal7IsqxbFBlZZtbGt1KPzLKQTiE2boGsmqKrqYhIh0xFMoRVZlE
	/TltoQXmvjOhhyzg/JY/9I/4teAE=
X-Gm-Gg: ASbGncvnn2UTY71oPejMxc+wRHZm1TvNAwHK3ydan4ikX5H4+g2UKoQK8mfWOM7JYWw
	d5RFU/xcJbUeIr98A7lwavdBsZBbL3Hp2nWxIes2UvUOEDAsBWOGm/GTbpaRSPtlpr+ThLZWd1h
	bZiIb9xUPDRw+dGsGXE51OIV3Q
X-Google-Smtp-Source: AGHT+IHooNIynvJ/u943r00EGtqP4V2TwxeklN98jKqPYPqS7Za6Xmz46LG4M8HzNRlfKabY+1aCpifJDwM5TkiPtdY=
X-Received: by 2002:a17:90b:3849:b0:2ff:6bcf:5411 with SMTP id
 98e67ed59e1d1-303b2111d26mr123943a91.1.1743020343400; Wed, 26 Mar 2025
 13:19:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326201230.3193329-1-abdiel.janulgue@gmail.com>
In-Reply-To: <20250326201230.3193329-1-abdiel.janulgue@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 26 Mar 2025 21:18:49 +0100
X-Gm-Features: AQ5f1Jr0Cr_g3Pyv5XL8DJRNCZ-jSVUqzmD7hSO9jXMUy3NigbrO3BofcVRIj6g
Message-ID: <CANiq72n6X5gV2rGB=TEw0jPdiw7mT79bdEOXHP30j=mRk92_NQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Additional fixes for dma coherent allocator
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: a.hindborg@kernel.org, ojeda@kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Robin Murphy <robin.murphy@arm.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, 
	"open list:DMA MAPPING HELPERS DEVICE DRIVER API [RUST]" <rust-for-linux@vger.kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, 
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 9:13=E2=80=AFPM Abdiel Janulgue
<abdiel.janulgue@gmail.com> wrote:
>
> Additional fixups to improve the documentation and make the read/write
> macros return Result as suggested by Andreas Hindborg as well as support
> for reading and writing large blocks of data.

As far as I can tell, these seem improvements more than fixes -- so
can they go through the normal process for the next cycle?

Thanks!

Cheers,
Miguel

