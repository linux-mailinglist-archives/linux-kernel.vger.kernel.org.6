Return-Path: <linux-kernel+bounces-536884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B29EAA485A4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829E31748E4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E4B1B4139;
	Thu, 27 Feb 2025 16:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKBed47a"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0684EB38;
	Thu, 27 Feb 2025 16:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674217; cv=none; b=oXO4onA/LzWPXoRGDKIbjFBAdUqu07WUyT78Yl/fMG2rFhrRSfBzVdr+0QBuHyunnKINKQcsgDe82dqDbEcVRHZJkqZIbyqC2vpT/SM8g+nLOzfqOt2Ukp5NbDmzUSMWn2J9pd97W6oz0KLnFSAcb4M8KdwdmO0glkyqAgfuXvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674217; c=relaxed/simple;
	bh=j4EX5orFVvXDxUIy9150RQ/V4wL6yYy11RXPpfYvFlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=midrXU+EDcrpR/2MxTBTiiEyr8MA78kh/qCZ5kKaVrCiymTEK/TzftTOtesbe6mrjWjumJI5Owo7f87EHL20IGbj28tU1iX5zpJ1GvUN14OkriO6yYRTHwKbdBUmSbyBO2+o8VEsOproQEqywwQ+rdNcfpt5M7WUYE9jpNvVh9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKBed47a; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-307d1ab59c6so13438111fa.1;
        Thu, 27 Feb 2025 08:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740674214; x=1741279014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4EX5orFVvXDxUIy9150RQ/V4wL6yYy11RXPpfYvFlQ=;
        b=CKBed47aOE1zq83u4TKeAiEBTZDh6TcAsepIqDK072Yv8GD/BuVsdL1bT286gGi2u/
         67pVFkNlum8YkbyeMz2ldjCuQ3n7NhsabtdhpczUfgMCw+Bg7mF+ZdzzCqzuTFC0dJrf
         vWQ+PxtJjKQnjEbOseegU/XeCCi49sbz+xOLCK5KdaeF5xpThnJAhog8D0xOSZe6j5gu
         WAxN3OhM09Fre2/LjVNgfjjqMUoYY78xA2pZYh7NLtnbKB6/nMhwE4rcY6M4Zte3c9I9
         0rCJYj3TJrggrucKV1DzgJjgp8RLIpF5YVgVbWfSHhJz7usaTRU5hqPGCxYUdQfDJWou
         91yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740674214; x=1741279014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j4EX5orFVvXDxUIy9150RQ/V4wL6yYy11RXPpfYvFlQ=;
        b=ltFMPIHq02h/O0CTA0mU5Sv0PDrfNE2awe9JXCXJoQkcji0bxKRlTihhKnZ3k3WAok
         KNprk7j71novR1ANWif4yWbVpyXFhgJE8GiqxhepStBeYGw/XQS//oAl2UtLSIhfdUVx
         QfgNSTy5x4ZpQ+2KHn6WKYwlnQ/kuC147SjO14N+p17CUd7ZXC2RwPJrJBV1coRZRE6n
         AXB41XQTjDUXgO5rWBaj4UGiWUXFUtU2+CR94cT9tjspHOqw9qKGtEZs/sVgVYwcliy0
         Hzi2PVIzXh3qBxqdDenABriqSTumMtzP/aEp0bw1uexggWAO8gb/0VDx87rEUfDA80Mg
         J/uw==
X-Forwarded-Encrypted: i=1; AJvYcCWHOxUyKV5qpg7U1u8cQbJWWXM5d7FcXH6/cF+OV7m3ocHimqL0SrrqnUsnquMXdzZ8OC4nYGtqAB9mvKi/zNo=@vger.kernel.org, AJvYcCWImd5vAaeVWM7YIf2AJ1Y5QJl8gKNFeVoulzzmibwdFo2alDLfOLU4slNGh51HolDsFGZweBCUJkEE+go=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTqMHWfUNdODLObo5hhZxl8NQHny3roN5y2AreGmZ5LMKq5yLx
	E9D8Ysz6mPvU9Sjou5nzOmthV32EboZWGpLZK/VV/xBiKhfSswPbUzRJmX+ooH8FBCGSVqUkih5
	Zi0JIuyW8+4lry7Rfrja4Af4B+40=
X-Gm-Gg: ASbGncu0iaxN7wRE2WebjpQPndA1M1A3FpbCdMV44sgYJBNqlpVH6YQvVn7KjtVFP+c
	t8eO4OlILd904xP3UFGfd/wwW/mD18jz86+14efgKRZT5vYupExAvBbj1PDgFAK4h5liPXLiWck
	WUtkkm+IpFpHkqdUKBoYWdu/K4OQ60nrSNO0wjr2AV
X-Google-Smtp-Source: AGHT+IFdTa61A7fvVLcjR+Clq/dXGhhkHqEJSViPgm+JRJYu/NibS1TihziDY9i6SHQlglcc3iqnj4LKLbaLYr9CUG8=
X-Received: by 2002:a2e:be10:0:b0:30b:8dbd:b8f with SMTP id
 38308e7fff4ca-30b8dbd144bmr4969961fa.19.1740674213747; Thu, 27 Feb 2025
 08:36:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227-configfs-v5-0-c40e8dc3b9cd@kernel.org>
 <20250227-configfs-v5-1-c40e8dc3b9cd@kernel.org> <CAJ-ks9=B=ceCN0VO3JH37LJbuVbQ5Y2sqfOgFCyJ0BfFGSEmkA@mail.gmail.com>
 <CANiq72=4U0Jpo=gkHVA9vQBCzSxde8Pq8-VZ-VEt4ba_HLAKhw@mail.gmail.com>
In-Reply-To: <CANiq72=4U0Jpo=gkHVA9vQBCzSxde8Pq8-VZ-VEt4ba_HLAKhw@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 27 Feb 2025 11:36:16 -0500
X-Gm-Features: AQ5f1JqgS5WkP52EQEzOpNMdmMJJVs8NZ-iHplUCBEzyWvFHHNXDkQrgGC8u25w
Message-ID: <CAJ-ks9mcXX631WRk6P=5Z18mFPopLNt5_L96B7-oJEmOP_oTrw@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] rust: sync: change `<Arc<T> as ForeignOwnable>::PointedTo`
 to `T`
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Joel Becker <jlbec@evilplan.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Fiona Behrens <me@kloenk.dev>, 
	Charalampos Mitrodimas <charmitro@posteo.net>, Daniel Almeida <daniel.almeida@collabora.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 11:34=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Feb 27, 2025 at 2:49=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
> >
> > Isn't the unsafe bit `*this`, which is what this comment should
> > justify? In Rust 1.82+ `addr_of_mut!` isn't unsafe I believe. Also `x`
> > is likely meant to be `this`.
>
> `addr_of_mut!` could also be called safely in many cases even before
> 1.82, i.e. it depends on the expression (and that is still true in
> 1.82+). The change in that version was about referring to static muts
> and extern statics.

Thanks for explaining! Was I correct about the unsafe operation here
being the dereference?

