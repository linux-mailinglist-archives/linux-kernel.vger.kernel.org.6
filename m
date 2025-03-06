Return-Path: <linux-kernel+bounces-548870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA234A54A5B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DB8216A2EF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA1F20B1F1;
	Thu,  6 Mar 2025 12:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jcHG9yDC"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38CB20AF71
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 12:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741262943; cv=none; b=CO7cHt+JD1A4zPsJb/rkCcHPydHFYQ2SdJPujTj4Gc2mTrpFK7ma31DsU2Cm6gI8WOpovCBMKr0RwuwpzmWaAWhIQXr3Vspv1kWGuARIERP1yZww2F4Kw8ITyjkCblMMuo6ws0isWJgjvLBAycSg87Qgr5QGHMVj1VGlVOwJ9d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741262943; c=relaxed/simple;
	bh=8gMyGXqU/SBGZF0jBgw5T2jKjTWgikTdAvJL7Z5QQzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iAo1NiZE9AqmRcvJ/pDv8q1BJPoMNVdPYbzUpvTfii0WTEMXTP5lceGTDxwtXfEy92TG1Ofd96nn5k/mZsEK63kxBbqXRQWAU8Ieqaq+kkCidqOkHsNCbFE+dlqLhWzHBra1jLI6eDGqW4TL0ltxA7o049Hs2Xw3HpibkiLWHtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jcHG9yDC; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43bdcd0d97dso3116375e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 04:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741262940; x=1741867740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJKmQPf0uQyBP0dHMptwPuPrmOF7WEuR5rgBIZ7vJzY=;
        b=jcHG9yDCbdOqqC852432BNU+0GTsCG1ethtdVU93Ty3m7IW1CcNo+gLmoQLY9ws14m
         1p455Zsy8bUAndhX6+xtbgGlPOg92xvjzYFQxwS+U3VTeFshxRiNVUl6iaG+7MNMQrkQ
         NjUE/wpTA6sg/4mqtOHR9WPl8UkIqFicfXmo4+ikeWfzM22zD7/ZJN1GvxisxKCwdK8d
         CvwgHLeDsK3+1yO/9V87Xv7T+lLaFSPUrfE81RC//WlcK+XKfrJCZ3twWIfohCPphrYP
         LrXWnCc5fDrWTz9cdcthr4aNeo1/vAlvn+itPoIWqmqWAXnigWPr3tvH9cZHtij834B7
         SpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741262940; x=1741867740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJKmQPf0uQyBP0dHMptwPuPrmOF7WEuR5rgBIZ7vJzY=;
        b=Vl6qwVwNq+6jfMzUjQFjC9N3X5S2Dezf9AeWBmP1808fXHI3ekISyAv259AAQRYbLC
         JbbMIA3yWV35/JaJDzHGQ/mBq+lSYRd1WjgyPouMfWplsCQXCmf0KqQWeJq7jZBeP2ub
         4CyCJI7y0K0Q1wzOQsE8hWbJN/vla9UFx4D5jguxV5LMXz3wTT/bliUJdNo0gFXT0bW3
         tulEZ9joaRu5pm/I9Bja7Kt0sfRkzAu25xTQ3xl8PRWAkeGrBmqIO7Ym8FRg0s+GIE16
         kzGI44XstX7k7ZhgIU9h3S9HMmWdsyYksFpfFN8wRvmsjUnFVJvF5+eg7Rbsy64nndOl
         Pe1w==
X-Forwarded-Encrypted: i=1; AJvYcCXGYl/+nGLtz07CFVe+S4Bjtimt4rOt0dCGmUGADZYp8MdpJWNIvXqpp6DWf3k4qamdXhkH3ecK9xwmXew=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGAAc1fU8keOQOd4SvZ1IQK2JtmVqtvvmpqShk1V+QTA2oHBKG
	nsmd7ljU9OVYh7mo6gymlFzTMZBO7ZDsavPT9nPsQvfHYh5T9Mv5YKyW0uCCI+ROzfJplnfzGT3
	BtStuZt/XVV/pjRXq6NJ5Uqk1VovEJYdVRZwG
X-Gm-Gg: ASbGncvEe4uItr3wT3OY09ws1GFvmCg/h7XvchD2t0taglZBQKdTxArO8cVS2UUg6Km
	sVB6u3jAk/yYO3jLjlD+Bkm7GNcOdrB1UW/Mhkw4MyaXcitK3Uqkb8d7UZ/ilBBZdLUMl/VOlo0
	1/pEElc2FCN6AOZzVivFE+6O8nxEDxua74uOyQXqu8fZ3IKU3DzRz9b245
X-Google-Smtp-Source: AGHT+IH+/3M/U14wpw955BJKhrim9WmmzCgc6th+mDwUTIqQ602Kvkk7v7WDijJkGkstjzFRh3Jy8fCVs9BU8fAj/mE=
X-Received: by 2002:a05:600c:4f87:b0:43b:c3af:3304 with SMTP id
 5b1f17b1804b1-43bd29c93e3mr48707005e9.28.1741262940126; Thu, 06 Mar 2025
 04:09:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z8hUIPtE_9P60fAf@google.com> <CAH5fLgjFBknTmhxQBPUdB-iNMjEkcyuLiu22-Nj-DGB1Gb7NkA@mail.gmail.com>
 <87ldtj8p2m.fsf@kernel.org> <JPqvzrz3Zy0HgwNoHh2psup7imFItiN_j_VmmjVPBfwJzf040DTvZAwUDjNv1FQiLXFiSAANIxc2IegeKGCJvA==@protonmail.internalid>
 <CAH5fLgirYTV6K2QoH9LLwhHxJzz=h1R0jB4G2kpKQ_pBtBgePg@mail.gmail.com>
 <875xkn8k5z.fsf@kernel.org> <Z8lsetLbHvn-6cai@google.com> <Z8l1Zt3ibanzBhnX@mango>
 <Z8mHgyNxb6rv6Vhm@google.com> <Z8mPBvL--zUxBpYN@mango>
In-Reply-To: <Z8mPBvL--zUxBpYN@mango>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 6 Mar 2025 13:08:47 +0100
X-Gm-Features: AQ5f1JoLaP5Ondt1o6hqOpFvvtrsNPIO2ONwLOTDvGS8y43jDq6e77zIeSzkMCw
Message-ID: <CAH5fLghbb8zMsJ7y+it3U3pE0xdXfOxGX3kfLQf0kJp=4xZWgA@mail.gmail.com>
Subject: Re: [PATCH v4] rust: adding UniqueRefCounted and UniqueRef types
To: Oliver Mangold <oliver.mangold@pm.me>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 1:03=E2=80=AFPM Oliver Mangold <oliver.mangold@pm.me=
> wrote:
>
> On 250306 1131, Alice Ryhl wrote:
> >
> > How about this:
> >
> > * Rename AlwaysRefCounted to RefCounted.
> > * Introduce a new AlwaysRefCounted trait with no methods and gate
> >   `From<&T>` on it. It has RefCounted as a sub-trait.
> > * Introduce an Ownable trait with an Owned type like in [1].
> > * Given an Owned<T> where T:RefCounted you can convert from Owned<T> to
> >   ARef<T>.
> >
> > And there needs to be a safety requirement on Ownable or
> > AlwaysRefCounted which requires that a type cannot implement both
> > traits. Alternatively, if a type implements both, it needs to be safe t=
o
> > have both Owned<T> and ARef<T> references at the same time, which could
> > make sense for a type that has one "special" reference and many normal
> > references.
> >
> > If you want conversions ARef<T> to Owned<T>, you should add a new trait
> > TryIntoOwned that's a super-trait of both RefCounted and Owned and has
> > the `try` method for the conversion.
> >
> > Thoughts?
> >
> Yes. Sounds good to me. Basically what I had in mind. Only the naming
> is different.
>
> I will build an implementation like this and post it as v5.
> I won't change the names of UniqueRef and UniqueRefCounted for now,
> but more out of laziness than because of having strong feelings about it.
> I like UniqueRef a bit better as our focus is on pointing out that
> it is unique. But if you or other prefers Owned I can change it.

Advantage of the Owned naming is that it also makes sense for types
that *only* support Owned pointers. The UniqueRef name kind of assumes
that it's refcounted, but the design I proposed does not have that
limitation.

Alice

