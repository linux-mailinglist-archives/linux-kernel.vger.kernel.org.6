Return-Path: <linux-kernel+bounces-516911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3EBA37998
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 03:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2547016A7D2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 02:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4C084D0E;
	Mon, 17 Feb 2025 02:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjLf4DJn"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BCD3D68;
	Mon, 17 Feb 2025 02:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739757879; cv=none; b=kqmmJI4oiRhC4zYZH8Q0T/kXoHQcCCQfw348nsLJBLsSsHnTQlk5IHCmw9kTxK8kHvW7q1umIDAl0dL5s+ihKVzql6SyJmT+42xcgIXP8914DeXfudssrZRKchJPvECvn20Uoblv360q9HR2/fDM1KivJ9h9P4iQ5ariOTO9dEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739757879; c=relaxed/simple;
	bh=ojgsT8JkH8rz7cGjwGcHosWltNoAZ+Flvfuso8sSegY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0XKiOzREUFK9mN4KKSfvujdkOMif9Ss+C47UDZMjUa1l9T3CrWGRswWEm8SARjyk2u1ew6ROMBeEMbI6x7y6HVid3jGhaxIiuI51ZfYD3xK3UKgsVXC7E6dUvSpXGqREJUlmbEAomSerLUpcHlc5kjMzOV3X6u+QyqJGxmGelg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjLf4DJn; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30918c29da2so29315851fa.0;
        Sun, 16 Feb 2025 18:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739757876; x=1740362676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojgsT8JkH8rz7cGjwGcHosWltNoAZ+Flvfuso8sSegY=;
        b=YjLf4DJnknEOZmTeHbTVFcgcmprr5IN5l4bNP1q3iBxaty37+McYkk5Fa7lonDMD3O
         jaqazaLDnn+h9l1lgIjiEP+OVhvQJg+LPhVVXJ846fOFUmfkx/XJlN7uOmmylL8fFvu+
         hsxG+41J64FGbGEbBhiM6zL6GFO0NsAtEKTNyLbzlfzlRiFBI/3HgDyj495pXqZLN8HU
         ORiSJIcLZ+hevLlxn1HIAmPRM8L2eurPg+KdN9k5uDu49m+60TRLCAMv+attUqRC4JVf
         PkB1IIggnYTZbAIWV+kcUu6DY4ni8ZtsleLZEgFabo40xvqmLl2DpUlywocM4MOOKVyv
         1mhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739757876; x=1740362676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojgsT8JkH8rz7cGjwGcHosWltNoAZ+Flvfuso8sSegY=;
        b=r6kJbkdZ/DJena+sW/QFAe6EL+fF/cNZ7fOeB2Ik1yIa0UVbF1Wh1TjIRn+yewJDqg
         gUXE8pjqhvzTU9i1w49CBV4k5cNNwBH3ovURq3v8eJaF9mBv2rWU9u3NJPY8bNxh+9PO
         gHZnqqxzsgwoaeCfZoQjvHU+rBZUtUvtBYNxzLImimptIdk4AJ7DGfGqhzfr4LIEnmw6
         38+r5iNG/8Jbj/rzFHAbnmw8TgnFLtnZ3o99o21Yyzn2hRG5TAnnR38DNpk+Uo47az8F
         HpqQAHaqJWcrqU5rbPJTk04ug8323nQfIDi/5y4TmgZQRzETRcDTIiebqj9pyCP0G1gm
         QZhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEFk5s/VB2pOhnkakF1IvvvmMpMJ1+2MRGTxjdmIPmnYtKJMOWnobHSUHZ5TW2b44Rc1ix4jrvjCH3mIY=@vger.kernel.org, AJvYcCX8ODRT5zOCPx8I//Cjg31VYKCyIdXq5nIm2DaOFR7/jyYdwSqQ0jg+lNo4XYs0kK3PiOX3tlT1RMh7t1i0U+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwApCW/E7S2egkl8fUYcBp45euNY1LrNcTWuAka+HsI8L4o1h/R
	AJZx+2MwtiewD5wwpxgzGn3NmEi9Y0eRaHM0Dm1O/9wCD0m2DhoWg1LDFgq0IOpvVP3KN332h6V
	Am2wiqmmHSm541fQK6oEnDQCwRkk=
X-Gm-Gg: ASbGncsYFp3XSqigESFHr76UiZCnh2SUji6ap2avW9N1FlCKVUyCD+iug5Ih1eRNKuh
	Y0zap32zgXC1cxrmfZU5HjKh6kXX0hOLtiJLkkVp4LZYPyVmh6OUG+PYn3+2a/M0ZmS51dHnrlO
	pDvCs8GsJgSdfyLGz49FXAxoNyCc1Y08o=
X-Google-Smtp-Source: AGHT+IHb32khqpX3bOe/6wUiekj808KnC/1mMA6427dgb3Qdwf+yVBeuwFNtneK1bx7Prk5CzmSnVUfGSQuidHfnhc0=
X-Received: by 2002:a2e:9ac2:0:b0:308:ec9d:d9c3 with SMTP id
 38308e7fff4ca-30927afdb64mr23230771fa.26.1739757875311; Sun, 16 Feb 2025
 18:04:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207-configfs-v2-0-f7a60b24d38e@kernel.org> <20250207-configfs-v2-1-f7a60b24d38e@kernel.org>
In-Reply-To: <20250207-configfs-v2-1-f7a60b24d38e@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 16 Feb 2025 21:03:58 -0500
X-Gm-Features: AWEUYZmTbSd5nHkHvttC4Hb_eN9aW08NlyeEW35znIaYK4e1LqP7OocrHknNzd4
Message-ID: <CAJ-ks9mDNptodHEPPd+TPZGT1Cs9EtyUKa9+ciAK9c4pge9M2A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rust: sync: change `<Arc<T> as ForeignOwnable>::PointedTo`
 to `T`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Fiona Behrens <me@kloenk.dev>, 
	Charalampos Mitrodimas <charmitro@posteo.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 9:50=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel.=
org> wrote:
>
> Using `ArcInner` as `PoinedTo` in the `ForeignOwnable` implementation for
> `Arc` is a bit unfortunate. Using `T` as `PointedTo` does not remove any
> functionality, but allows `ArcInner` to be private. Further, it allows
> downstream users to write code that is generic over `Box` and `Arc`, when
> downstream users need access to `T` after calling `into_foreign`.

I stumbled upon https://github.com/Rust-for-Linux/linux/pull/1036 the
other day. Boqun, are there any plans to revive this work? It might
obviate the need for _this_ patch.

Tamir

