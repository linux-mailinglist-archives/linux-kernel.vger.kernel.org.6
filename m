Return-Path: <linux-kernel+bounces-575509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAED0A70380
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C42711890580
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A7F259CBB;
	Tue, 25 Mar 2025 14:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1lUNK+1"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A93255E46;
	Tue, 25 Mar 2025 14:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742912267; cv=none; b=BrGNDaOKUK+Y2ePwdhu0YG22vVb4t9nZRD5KlrJHlmiP01htVKeXizFedsrNZnosavjIltkwarn6tFjmbyiDe1HTxdjZvCAIwAaEvnrNF4V5qak4vwD8bAnfaLVAH9FoBFfGX9yAmwYqwmB4yupsYOW4womHclU//qtDt6Z+fCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742912267; c=relaxed/simple;
	bh=bxnLVExzAbVNZlcwUQ+EuHdmVGqO2jOXVg8Rvy5+13Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LfBoH2LyVd8k7g+a7Xx0kY8a1GsxLgRHlap+WcmpTszIoqjPbh5WF7XIO5FLUppJClrvN6+sGTwdFCLZ3xP2x2hb7P24OkKqvqBpM6CVYphr+jf71QtPt7iozFimTbZpkPVWqaBMZYzg3otjrUkrxmZ1VuIynvTrf30DtnZ8ooo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1lUNK+1; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ff53b26af2so1565147a91.0;
        Tue, 25 Mar 2025 07:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742912265; x=1743517065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiAxxfZBeIiK5a2HBBXitFpStb7QFVYBiaYLfAZYFgg=;
        b=j1lUNK+1GAIv39/eRLqKk1q3x6EjQDOpyaCW/fC8UAuA3bgs1y8NiMqVmniO4fyH9z
         +1Ks23MJOhxRv7Avi+ue6/KX6kHf/BnxJrTK79SbGkpi3LgBPbuVfB0hHtxDvun8T+xd
         CScnachl+WqDyhN4LmPj/5V9B13chDrj1Mlhl3dTM+m2kYUaJawqS6TCjl0adY49rBBZ
         32JCc7p1zVBzsb2W/HgV8I/WM66qoBq6ZL5L9txif4fFtuBo4ixDS0qjE/6ZbBpacx/i
         ZL+firrcycUd5ylXTD7GqLiFpUlK+LXRlCHKX/3eBWSljaYjflAOAHfX4erOZxJuK7rc
         IXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742912265; x=1743517065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yiAxxfZBeIiK5a2HBBXitFpStb7QFVYBiaYLfAZYFgg=;
        b=gpHZXPqgtTgaTV9Tj5bHaJSeycRmbQH/bIyOu6RGTJ2ZsKfuvco4wCHdtAfEZEdacd
         NKYz54jTT4l2TQT/VgXsxsOgLjGA4jXp+Gza2ohd8UsKHfjVvTrqYdO3UxmxaXk99gOr
         mfGtfv2JskuWGYAXAZWePeGfRQ+5tPhOdquqUP0ewBI3DGFDBEKWJUfKBFKfo28nGPSV
         uaAKCwd/mTEcdByO3Bz0lFc9rF/QTQQG0Mv3ZeCvqYdtjFq5K6sOyq19A1jCbq9MM00S
         m2BPX5//zlU/uPtMs+hMOEtGILVit29aQtxSiSBA2Xb/aZ8QdHY3rMqmeWW0H2cL4B+L
         wZ4A==
X-Forwarded-Encrypted: i=1; AJvYcCXRWOMN8XXbBfUIOM3RcVAr9ebBzK7g6UWRWKajTuX10idxh+h6qrRXSSIX8z3d8iGVVrdLGhNjNwXaIY0=@vger.kernel.org, AJvYcCXrHPg8Wo8zmmTJaM584FzrqwcNi4odY/FsyYr8NC6DHFqvELHHBR2aorY4915kbFmYdDw3pbi9gGWs4D+nYas=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPxRpIXjtqJYiNOd9vES7LtwI2ip/aNv8GGy7AlQI8dSUMtsNk
	Wnu+09cjzmQ3rOpbkXR9ETl+/+IxB+lo1Fo1ZNo5QA6oAbEICXTeLBAlfzXN/jWUCCSgYQIHYTV
	bD71jOnsAaq5ZGtZpF1yvurqU5I6fZDNzmA0=
X-Gm-Gg: ASbGncua27sl1v+I32sGtf9AX4htKDRj+3XVYKrplOOYZROtZ30Y9gS5xO0YqqvXx7V
	mtfHF1nF2Y1hcxfjfpv3ASF/uUQM1egbfGkteRAMS4rv/mNsK2iIRhyDwCZ3HKibAqYzSOf6ovM
	6lwAiD5cPZY121X6uFjAyHyvAwqw==
X-Google-Smtp-Source: AGHT+IGwUtqDN9/gKOU8D3rc7eewlWrEw5Yldn+0hCf3frdUZFYWU0VKlZ+SzQiAqLHzncX80HoFxER+12RCQiUSp0c=
X-Received: by 2002:a17:90b:1647:b0:2ee:6563:20b5 with SMTP id
 98e67ed59e1d1-3030fb1fbc7mr9477978a91.0.1742912264922; Tue, 25 Mar 2025
 07:17:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325-feat-add-bitmask-macro-v2-1-d3beabdad90f@gmail.com> <D8PDWRH06U1X.3JGHP1311BPPY@proton.me>
In-Reply-To: <D8PDWRH06U1X.3JGHP1311BPPY@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 25 Mar 2025 15:17:32 +0100
X-Gm-Features: AQ5f1JrNG9IMxQMOkhvrXLzEDQWYrISIuIZhgF6lHcZlHfC1fPERYeufzxN3OEM
Message-ID: <CANiq72nm=Sz7s3o81FFP6o5hKCH6M=BtzmvF7eVeZx0C8aWW1g@mail.gmail.com>
Subject: Re: [PATCH v2] rust: add new macro for common bitmap operations
To: Benno Lossin <benno.lossin@proton.me>
Cc: Filipe Xavier <felipeaggger@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, daniel.almeida@collabora.com, 
	rust-for-linux@vger.kernel.org, felipe_life@live.com, 
	linux-kernel@vger.kernel.org, Lyude Paul <lyude@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 2:34=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> Please use absolute paths to refer to items, in this case
> `::core::convert::From` (note the leading `::`). More cases below.
>
> I filed an issue to add a new clippy lint to catch this:
>
>     https://github.com/rust-lang/rust-clippy/issues/14472

Linked in our list:

    https://github.com/Rust-for-Linux/linux/issues/349

Thanks!

Cheers,
Miguel

