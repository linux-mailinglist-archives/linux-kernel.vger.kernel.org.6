Return-Path: <linux-kernel+bounces-422109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F344F9D94AA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 10:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E93282938
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 09:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562661CACE2;
	Tue, 26 Nov 2024 09:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WPe9DJ4g"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144D61C5799
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 09:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732613849; cv=none; b=TwbKiCe4o5Ey6V7tc0OakypU/fV2L1niisTV7p3jQgCaHoYitaG927gzUNYPFF6QTci+frPZ0VwHtqg40vVvsCsVXsaZbdCgz0dSaOr8BsedZmTldOM8TtPs306JcvI/smPoSyb32WSVxpPrfa4o2epOJgOY2JUrvR9RfOYXMEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732613849; c=relaxed/simple;
	bh=Zz1N+l6E70WWiNX/9XD8+LoKg4IlcjQah9g89ADPBs8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tSz+m0lpRHrVs2n5OX7FKjzr2abKPpXo1xfyOVtcyNdyvE3Cn3vynJekMJuuA2P8C6wQVhKPZKafL9oWODBhTGZOm5VY0vHIHrnzQeQ7VVOR19cxlRLEk4XbErwEW555mSE3xOfTI8OZr6hzkwMP6r/WKhUldqgrSElv7qfh2lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WPe9DJ4g; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38248b810ffso4113813f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 01:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732613845; x=1733218645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2p/ybNbBpC5vQLx8bPdGGCOJ0xWaPNm6a3S5LA53V8=;
        b=WPe9DJ4gF2Tp7nX8/+z3fC/IjGA+fkw0rL1w/2+aB08f/B9Si7yR66lQiF+qorf9EQ
         Cy+Mp31096/ixsVAf8T1K7HGZlQDWzRQRu5aWVa7ZXDocL9atgJZEweMqded76IHmFTc
         RlUnkRpMo+LOLjH4DSsHZp54gfEFmpac24+hgg3LbiTfW4fittIGfz4qkY+PH+Y7b4Oa
         /n/FsGotSvJx1lKdMIjCsCZgC4raTOccEJQd9UNsaQYhWagoEsTjRI2QRCfvB+PTKpRD
         CX+LqrJndQdSLFJndGc4sNfGj/yYeDuttTrTOeZNSwtv6HG8BXnnqQ6B3vMt+Q3yeA90
         fg1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732613845; x=1733218645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2p/ybNbBpC5vQLx8bPdGGCOJ0xWaPNm6a3S5LA53V8=;
        b=UJ8/C13wy3zCDQu0mNlhpNbIZfuUxy+XhMn0uVYzaXQFKWpGsJJfIyPFzKGYBjsY0T
         byjuVdjAqaRrrDX1J+l0eGwA4939p6nu7JET2lT7gwkaV+OxhFi9zil4DjNhrHZOdYTe
         R19l9XNL1tMjcDePVSBuMZIqcmjlXAKd5lvuDs5Fi7DUPMd9c4Cu9V2A/MjgFHKapaqX
         wPZJHkYa1YfoACvnKRVcs2k00Rwhqvd3MyJCXi0yPEiHrk1rCUa6xjG1AadGoMes7rCa
         /P7Xmq9ltzddeUWXekI1Oob0gyfKxXMH7ARkMQhQRhtKFIygEjrANeXxxTOPSbfWrRzx
         dXyg==
X-Forwarded-Encrypted: i=1; AJvYcCW2Yie4TrCrtRbMj9zmrYOE0bzd9PEY4nhDevUXePR2C0HI7In9++zw9FNriiNHdIbFpF1hl4Y2XNrpBSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWCjJCmn6Jwn0qZkOSIY/APDLNEiDwAKXi+gr9We7hkWVfhT1N
	Pdgoti1ddqNPzh2cdjUtqJAmnyayrGn4er5sWcr0LwO65RtT90LxvqL4cgmEdTOir7RHSFoUaks
	Pnov07UMpLLVWe8/cW3YXhBQ4fGHrfyrMeQiu
X-Gm-Gg: ASbGncu+ODSb/Ywz0g3q4E4vurJeXAYavXKD/ejQsva14BXt7gSHh9STan9okEhad09
	wW6OfW7jdinwqiraz2PPptYTS0x/Fb0+HEpGNG8kxdyxEPFO6CvkjzW6hLuxJuQ==
X-Google-Smtp-Source: AGHT+IH8A0G5C+cZTzzzIP3ak0uqe9oHKIgIRpU4gmY54XBEkS7vQyL1q7QM0+P76QmbcWawrl24eZatP6rR2eV9ysc=
X-Received: by 2002:a05:6000:2d01:b0:382:346b:3675 with SMTP id
 ffacd0b85a97d-38260bcbc58mr12390804f8f.46.1732613845454; Tue, 26 Nov 2024
 01:37:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801-kcfi-v2-0-c93caed3d121@google.com> <20241126091934.GP39245@noisy.programming.kicks-ass.net>
In-Reply-To: <20241126091934.GP39245@noisy.programming.kicks-ass.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 26 Nov 2024 10:37:13 +0100
Message-ID: <CAH5fLghmqO8jAuZm5NUOP8Sf1Nzqdk6PXknozSF0oCE00z2pgw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Rust KCFI support
To: Peter Zijlstra <peterz@infradead.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Sami Tolvanen <samitolvanen@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Kees Cook <kees@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Matthew Maurer <mmaurer@google.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	scott.d.constable@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 10:19=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Thu, Aug 01, 2024 at 01:35:16PM +0000, Alice Ryhl wrote:
> > The control flow integrity (kCFI) sanitizer is an important sanitizer
> > that is often used in production. This patch series makes it possible t=
o
> > use kCFI and Rust together.
>
> So about this -- there's a proposal for a modification to kCFI here:
>
>   https://github.com/llvm/llvm-project/pull/117121
>
> And Sami notes that this would break this Rust thing. Assuming all the
> relevant crabs are present on this thread, could you please comment?

Thanks for sharing this link. I'll leave a comment.

Alice

