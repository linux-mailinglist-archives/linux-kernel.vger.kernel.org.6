Return-Path: <linux-kernel+bounces-551475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B0AA56CDD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96CC87A704A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4367B221DA4;
	Fri,  7 Mar 2025 15:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iBoonrFf"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10903221D87
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363118; cv=none; b=IW/Kxy8fLTC8wfuxbvSxubdtQmoDmwxNNWYgZpbbt7kRyqjnrqYZMQTrGqGkojaiq8OU8aqidJKsLN+W0zkra1MGBHVXzkyIjjyOJFC+AfHHsnYKaEW1dlF2Cagadc8kRBtRlIHe2jQl7b8h4tWR0a58p5j7Kwh+c2RzPwTJ+QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363118; c=relaxed/simple;
	bh=dE0BQ5eQ2gG61bm4nmvokkvXWu5x37dPf7bjFaVcIFI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KcFwk0TKz5dPxmFppQl25xqWQTbotjASyapc8pDMbTYe5Y0QNIo5WzAPCUFOPDN/xJwyE8BvZjvyVIfXC6/bYFt2vGHSBJQqJZSmHjg48P5cloHy4HEocD81hZd7h8DFwnNlux1zTOiJRawKxZss06jVPGT7mCvUlB2IfrhuFPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iBoonrFf; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43935e09897so13687765e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 07:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741363115; x=1741967915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dE0BQ5eQ2gG61bm4nmvokkvXWu5x37dPf7bjFaVcIFI=;
        b=iBoonrFfR2FStgDEszZUjpgzWAITJCNkfF5R9KvG9vlNTTdgdlQHRO3Y2b+1lZEG6D
         3zLAtyFFC3SMfMbesbQ6CNV9uHzL93oDFdW4mhmYzJ7NV8FIDpIhZYt/8BF1w+TqijlC
         0u7Zk+fvCaymxjt/NyZGmlsZExK90MCfcg7yACJvTNu+YXcdcXzoG5cDfolhakkwQEhr
         LUFCoGC21jMCFRrra7bA9IAO4iTsIgCd5TPIlWCgoZBOpo5D66Uq0jgSOp4rCbTTxhQj
         n91N9g1nk4NMRirmpiXgSlZKj+X/xNTqpy6NEdqU+Li2dbwsM68xcGrWZtGl+OrVLwtY
         HasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741363115; x=1741967915;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dE0BQ5eQ2gG61bm4nmvokkvXWu5x37dPf7bjFaVcIFI=;
        b=NjoqoV4dMTWFeXMYEKOjds+b3j20eINk6F/tI2kRbbNvzmKpNqM5G1/aj8UkbDAxTN
         vzoZ9Vfu4K9lh3AII91ouFYbxWzYr3KVnkLY89Qno08u59qR8jpqxBI/wdOxY73zvOwU
         X5v8rE0fZJIB3I/gNqN4kO6CZKGVnmrUWp4Q9dMweGE4wU8xd5J2sA9OdZFvxpB1Yap6
         +8wRxHbA+96kzPJz2e4591RWW7s1vqNDX+dZAtnBzEBoTAV+OIC9ejqBFTCp64oIJujS
         nELDLZKxQPyYH6aw4cNVPHAmLW+XGwrPPN8CnIDbm8hYkxgHLBLoaAa8WiLB7C8D7acc
         MQTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHG3VHy7Q9vOvL/LxOD5QNA7TM4Epp6jCt1sJnsXKjzwdR5aRisg7mj1LVkMOWSr6pUAp+H9tKXYjpU+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YweEKNM5hhTwTDX0nMxwRToC/yOdx3uX1fnVZ3F32kPinB+4fQm
	jEDLMMN5z1CqLKXg8Vkm4+HKCweWB1Z5m/4FuqNH2GAaSP3fxgAs38DfTouDWbcQC2tiZp7kQU5
	gASp/7DtcRNNwmw==
X-Google-Smtp-Source: AGHT+IHeTjfMptm9ASbuvmJo3K0E3Bs7Zv50W5LtSVFpbOJTKkaivp+rDcz3x/KoNgbzGuD96Xv7PbhMCeRp7DY=
X-Received: from wmbay42.prod.google.com ([2002:a05:600c:1e2a:b0:43c:9429:5ec4])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3ba0:b0:439:8c6d:7ad9 with SMTP id 5b1f17b1804b1-43c601cab94mr31396625e9.31.1741363115397;
 Fri, 07 Mar 2025 07:58:35 -0800 (PST)
Date: Fri, 7 Mar 2025 15:58:33 +0000
In-Reply-To: <CANiq72ktwWOEBFB=y7xun-CDurwsSRe2_PE6RqGS4OhEyPGFkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250307-unique-ref-v5-0-bffeb633277e@pm.me> <20250307-unique-ref-v5-4-bffeb633277e@pm.me>
 <CANiq72mYfhuRWkjomb1vOMMPOaxvdS6qjfVLAwxUw6ecdqyh2A@mail.gmail.com>
 <Z8r0lVu1iwc9GG2t@google.com> <CANiq72ktwWOEBFB=y7xun-CDurwsSRe2_PE6RqGS4OhEyPGFkQ@mail.gmail.com>
Message-ID: <Z8sXqXgfhHbNpG6B@google.com>
Subject: Re: [PATCH v5 4/4] rust: adding OwnableRefCounted and SimpleOwnableRefCounted
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Oliver Mangold <oliver.mangold@pm.me>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 07, 2025 at 02:53:30PM +0100, Miguel Ojeda wrote:
> On Fri, Mar 7, 2025 at 2:28=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> =
wrote:
> >
> > It's only a warning on older compilers. We could just add this in
> > lib.rs:
> >
> > #![allow(unknown_or_malformed_diagnostic_attributes)]
>=20
> That is OK too, though we would lose the check for typos until we
> upgrade the minimum.
>=20
> Hmm... Since we have nowadays the way to create those conditions
> easily, I think it is fine to do it conditionally.

Another possibility is to make the allow conditional.

Alice

