Return-Path: <linux-kernel+bounces-531836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E519A44596
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96E9418867AC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279A218B47E;
	Tue, 25 Feb 2025 16:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JQwwYa0F"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52FE18B47C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740499975; cv=none; b=OadvTOoo0xx7MWVofir30LOenSV5kbzERHMdbUMw5aTr3A2VGAkKVFFNdbfeiI+I9Ch/sopwzun9p7K+s14/HCoukJP+F9uP9yDgpLvenj9gS7wo2ZJXqAf6C+R0TisTWsQMVOttnrmXoVTz/OzX2pf6sKusnhx4QXWrA5cQLCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740499975; c=relaxed/simple;
	bh=JcbH6xbF+kVoY6mPq3WSvzHL/f+wVG6jHsP4CM8z2Xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bG49y+MHzuq0po3c99jZsBZzVKY9QARTrdIjQjaqrA3wULzNL67VFsr+m0Qv9pvgZT6YB+0zKGobz3IxZUQd6FGG2yI03kWw4mF346+1qrl9E5xaW7HdO1p/MT4NwfUqwJSR6AWyXy00qLnHJrifZaqspusPoP7KhI9l5btl5Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JQwwYa0F; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38f31f7732dso3558426f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 08:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740499972; x=1741104772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+IbGw1yOaO8wpgyinqYsYfkRN9BZ1H7KtNvprS9eFQ=;
        b=JQwwYa0FUMbQ5ZQSCI9HzN5q8vKKdzz2MlVt4MAzOiwpBnnHAzwBvP1F1aGmJ42neO
         lf6b9IjkGrsuZkyPdNEAQUaLsiNfY4X1p6WIkfGUCNenk0VL3MfzQLN3K0r1NGsEiCOs
         kwCBJSrJnVeI/DoTNFSWNE1dUznIzCwTOM0jUzsRkvZN+ITMeoSFPz/nFcabKlP+4+Tl
         cNOmu/Ig9esII3QLkif0fiXxv64SaEBQRvy4Imv/5b5qzmW/m5eOKSE61Jj/1jPi8w5s
         bJ0cJedpXPpkpZFdJ4iAznb7uAUADVL34VZ/ToXV52McaztBjeIifBHVwIr4DlahGkjY
         m7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740499972; x=1741104772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+IbGw1yOaO8wpgyinqYsYfkRN9BZ1H7KtNvprS9eFQ=;
        b=hzvPIxLKTnUxjY4wNMmnhcKV0mhXqir7L2XlPmUHipv60vYQiEoHfExQCFD+Bk7AX4
         ZgqVwaRINEm2ketNPt/EggGkZKIssaXNYliUVkYm9Am5gBxPfmnUXhhJb/E6T8q4dYZ9
         77VN+h7OVpep1GCWyWSBOjh8++7vqhImdZJDBTjRTIj7hOHmpZcfLQYlVMz6xkg/ARNs
         JjFFbdCoKTi31HDn2ynVKqF8laarjbCSVHarkx4Qt2j4fN39msrK37HstJYecC3WHrOO
         sC+wUjj9U+jx5f+nKESfyTULPju9jRmuxa6s5Ej6wnLTc+Cd7DqQLvyUMExVOr4GBO+l
         6dNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVmWphi3+eGKljft3BkROWv/IkuwT6hvFOlfoeFep5kWDC0wLSnjM9rXZlTYSUft7GmOyU+SW1iHjcmHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn4GMBm7xkpx9IXk8fnBCvIW3uzKgAqAyNQTPwT8YNHZcFjha+
	C/JHB1RZ2QHTOEIbV3IKyrKRigeGmzmvmE7xIUQPBPKklxCymR7d8SmxJuumhyukzXP8jKRnIaQ
	RiaZDjFEfBZnnI8h73J18GJ4/l6hIED7G9n/p
X-Gm-Gg: ASbGnctyD9wMcAWPUPdH6zjT5W8yOWon/vn1sET9E7Mgr2H/yBv0U0mEVu174erEaRo
	xb2n7nTFjzTXs23Pj4U1fDU/RhhqcrUS093sRgrZw1ex/rSK2PIpj60UHy2L3FHq1DnL4IKnJoq
	2vnrUjkjIF2iKB7Fgl7pgoAwAL6fBwLgTaYHEoNg==
X-Google-Smtp-Source: AGHT+IERrAzfsQ+2vuobOjf/H2nk2QFz1j28McsGB1U9oXx7WWKXyXxUSYxjItIeHzW3MoL6kdZmhf2JM57dNE5za7Q=
X-Received: by 2002:a05:6000:1563:b0:386:374b:e8bc with SMTP id
 ffacd0b85a97d-38f615bc9dfmr16670217f8f.15.1740499971902; Tue, 25 Feb 2025
 08:12:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo> <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com> <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
In-Reply-To: <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 25 Feb 2025 17:12:39 +0100
X-Gm-Features: AQ5f1JrjfQJh76BFqnmr7NKwuzVljSVd0iXKiJJ1_U95jYSuu4wa6KKMNxHfNZU
Message-ID: <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Ventura Jack <venturajack85@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Gary Guo <gary@garyguo.net>, airlied@gmail.com, 
	boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, 
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 4:30=E2=80=AFPM Ventura Jack <venturajack85@gmail.c=
om> wrote:
>
> Just to be clear and avoid confusion, I would
> like to clarify some aspects of aliasing.
> In case that you do not already know about this,
> I suspect that you may find it very valuable.
>
> I am not an expert at Rust, so for any Rust experts
> out there, please feel free to point out any errors
> or mistakes that I make in the following.
>
> The Rustonomicon is (as I gather) the semi-official
> documentation site for unsafe Rust.
>
> Aliasing in C and Rust:
>
> C "strict aliasing":
> - Is not a keyword.
> - Based on "type compatibility".
> - Is turned off by default in the kernel by using
>     a compiler flag.
>
> C "restrict":
> - Is a keyword, applied to pointers.
> - Is opt-in to a kind of aliasing.
> - Is seldom used in practice, since many find
>     it difficult to use correctly and avoid
>     undefined behavior.
>
> Rust aliasing:
> - Is not a keyword.
> - Applies to certain pointer kinds in Rust, namely
>     Rust "references".
>     Rust pointer kinds:
>     https://doc.rust-lang.org/reference/types/pointer.html
> - Aliasing in Rust is not opt-in or opt-out,
>     it is always on.
>     https://doc.rust-lang.org/nomicon/aliasing.html
> - Rust has not defined its aliasing model.
>     https://doc.rust-lang.org/nomicon/references.html
>         "Unfortunately, Rust hasn't actually
>         defined its aliasing model.
>         While we wait for the Rust devs to specify
>         the semantics of their language, let's use
>         the next section to discuss what aliasing is
>         in general, and why it matters."
>     There is active experimental research on
>     defining the aliasing model, including tree borrows
>     and stacked borrows.
> - The aliasing model not being defined makes
>     it harder to reason about and work with
>     unsafe Rust, and therefore harder to avoid
>     undefined behavior/memory safety bugs.

I think all of this worrying about Rust not having defined its
aliasing model is way overblown. Ultimately, the status quo is that
each unsafe operation that has to do with aliasing falls into one of
three categories:

* This is definitely allowed.
* This is definitely UB.
* We don't know whether we want to allow this yet.

The full aliasing model that they want would eliminate the third
category. But for practical purposes you just stay within the first
subset and you will be happy.

Alice

