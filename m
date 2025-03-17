Return-Path: <linux-kernel+bounces-564473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA9EA655DE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44CFF1899901
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EFE24886F;
	Mon, 17 Mar 2025 15:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsU6IhzZ"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1082376ED;
	Mon, 17 Mar 2025 15:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742225884; cv=none; b=PWr38LfLKXvuo/7Fbmon499F1nQ14NK3Pe5xwt9Vfct1Fhc7trI8j2AzaI/Ay6e48jiTguAtx6jdCnXfyM3PoiziDPzrqfTZXvo5arwE7763rsq/Sxf8APQGkZE/J9YtM2c5d516Uvr3BntUZYbK4EUs/WeHpH3g3MS5z0bkgls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742225884; c=relaxed/simple;
	bh=ZZWzmUWTimLJAcdPXG8JY1eISTp/yQNRuJsjDNuSk6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hB+zQlfvaO0osJIlUowMxJbMri7CUzGabxn0TKt/40OhW7o0f4gWtVMEWTdtKNrKyLlHF0JZCaUND/3htqXBLEV4JZbxLYASA0eqwtsOsl9LRuoiEatC7oY2RmJH8tzPTsSjzIcVa7aTfy/TlTlI5SZP5o+XOzWoIqEd2Pp2nBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsU6IhzZ; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30761be8fa8so7925321fa.2;
        Mon, 17 Mar 2025 08:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742225881; x=1742830681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUIrj43rm3bDSnVFHsMBGJ+fSVgHIGogbTLMRzpu2A4=;
        b=nsU6IhzZ8AETp9r2rSgc0OpCAbWsU6qp0waT4Um4/jpgL7zGr1wPTBkaHWvoe7mKqd
         rDdUSKXusINJAzGe6VazyUv6+/Jm5smsmK/yCBE5NKR3RF827EIV0yISRSvAgC4H8Rp0
         ogeAZW+TKuhW/6tAIaS5tYJJKOA4uGeVboJkgd90qeDANrvRQ9RmZsygPE67ZIIhMWtE
         h3AmC8anTPjzX9P3TZthHmdk2Wnd1s+1v/i3Fppxau1jMOu1QtqBn1yw2tH26dfYR9EF
         LOkYkTNHUZ6pkqYAVInx+kHMKxKxI0KtZUcbXpcrc7ivPmXFAN5ormDZaF55tYm0d48N
         9hNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742225881; x=1742830681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eUIrj43rm3bDSnVFHsMBGJ+fSVgHIGogbTLMRzpu2A4=;
        b=In9SGLb5lPvv1JJHY/qnWhDtcQcjclZm8qvBoADElPamV34h/hyjgdxmQE0JQmH881
         Za/CkErUD5iUUja94y65R/9sYB0TIZW7nHKJ9Mt2AAOfM6diPhiohK/5NIGKUIOL+2yF
         ffwwrHvbk1x5E3Ufdh191KHd2TmlU9ZQf8c1F6B3fmQ1yXT40TlusoFBII3d3gbDEQdm
         vAbtrhIXFkqvlDKYg2BDGIQVkRn2sW4s20Ku8CXbb5MSTN1QzlsB2lqPIUotV5n4B+Tn
         9Aq8VXM5+xaeE1CQhWBvXfHyKUMS1UMcLW410Ar4oxncVhS373NJoI5sifbBNvArRJJT
         becw==
X-Forwarded-Encrypted: i=1; AJvYcCUj62CIJQjzjtgLG3rNRMapyfTsUn1uQTytH24ajbxScbWSECc4fyrq2lc8FL+ILrBX0kjChuLfGu/KYqS1Xkg=@vger.kernel.org, AJvYcCXRi0cFSQvstWWLs7u+LS1x8TfHcqQgk3JJlHiv5iSambNSMqviIpX3Psc1aXApH0UJlDsT0z4c6PXGxLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKIkA39myhW2I0+pgG5LG1bSFYG0t4ywC18cb7u66xAWvXa3OJ
	QT9/VAXdMloQJGErtAN+/kGnsbBwokUvgc1lcLvnhVbJlYbGRPj4igUL04gLEkqxoP+u2lwbx0I
	HgK78gJLFoexU/CA1kyZU9h0faQk=
X-Gm-Gg: ASbGnct5fCJPCJu8PPKNZ71FxwjBndDKKbELGUI5YZIA42KHTp2YkCiVrA91EVqQc1i
	iDls1rIVSYqwYKDDdreVK0QUJDld8V3P+lLEY1J/gVwTGgfLpWuwiciWJZP1qW7DjAium2awkWU
	0mWt7kFdu40Vjw1Hwdq7t2fj3xFgfYJSLBLjjhlFmtN0qKE9GQZNt5itUQbOgg
X-Google-Smtp-Source: AGHT+IH5ohCk5uuMKetMbjr8G6G2cxZCP8S9CkJlvAvgc+Fk0dQ8gE41Sls+pmLoPm5tocBiLzRNUGBJihVNUQ/f394=
X-Received: by 2002:a2e:9bc6:0:b0:30c:b2c:edb6 with SMTP id
 38308e7fff4ca-30c4a876caamr74059371fa.18.1742225880670; Mon, 17 Mar 2025
 08:38:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250316-vec-set-len-v1-0-60f98a28723f@gmail.com>
 <20250316-vec-set-len-v1-2-60f98a28723f@gmail.com> <D8IGFTJXS2A1.9JBD1UKGN4PX@proton.me>
 <CAJ-ks9=oq+c_pMg41QgGWsj=phWYfntXQgpSrFmz16Vifofn3g@mail.gmail.com> <D8IMA0GUIPTD.34ZEZ3W8QSKTA@proton.me>
In-Reply-To: <D8IMA0GUIPTD.34ZEZ3W8QSKTA@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Mar 2025 11:37:24 -0400
X-Gm-Features: AQ5f1JrgHQYe1BFwoE76k6wYz6LF0WzHEWpp_g8GemEC4LULIpXbGBcJs3pFmq0
Message-ID: <CAJ-ks9kXZDO-5utmQb2HLkxmxmQ-bg8jZ4FdvDatTj_79W2dMA@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: alloc: add `Vec::dec_len`
To: Benno Lossin <benno.lossin@proton.me>
Cc: Danilo Krummrich <dakr@kernel.org>, Andrew Ballance <andrewjballance@gmail.com>, 
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 10:39=E2=80=AFAM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> On Mon Mar 17, 2025 at 12:34 PM CET, Tamir Duberstein wrote:
> > On Mon, Mar 17, 2025 at 6:04=E2=80=AFAM Benno Lossin <benno.lossin@prot=
on.me> wrote:
> >>
> >> On Sun Mar 16, 2025 at 11:32 PM CET, Tamir Duberstein wrote:
> >> > Add `Vec::dec_len` that reduces the length of the receiver. This met=
hod
> >> > is intended to be used from methods that remove elements from `Vec` =
such
> >> > as `truncate`, `pop`, `remove`, and others. This method is intention=
ally
> >> > not `pub`.
> >>
> >> I think it should be `pub`. Otherwise we're loosing functionality
> >> compared to now. If one decides to give the raw pointer to some C API
> >> that takes ownership of the pointer, then I want them to be able to ca=
ll
> >> `dec_len` manually.
> >
> > This is premature. It is trivial to make this function pub when the nee=
d arises.
>
> And it's trivial to do it now. If it's private now, someone will have to
> change this in some random patch and it's annoying.

It is my understanding that the kernel's policy is in general not to
add API surface that doesn't have users. Rust-for-Linux of course
often doesn't honor this by necessity, since many abstractions are
needed before users (drivers) can be upstream. But in this case we
can't even mention a specific use case - so as I mentioned on the
previous reply, I am not comfortable putting my name on such an API.

> >> > +    ///
> >> > +    /// # Safety
> >> > +    ///
> >> > +    /// - `count` must be less than or equal to `self.len`.
> >>
> >> I also think that we should use saturating_sub instead and then not ha=
ve
> >> to worry about this. (It should still be documented in the function
> >> though). That way this can also be a safe function.
> >
> > This doesn't seem better to me. I'd prefer to have more rather than
> > fewer guardrails on such low-level operations.
>
> Your second sentence seems like an argument for making it safe? I think
> it's a lot better as a safe function.

The guardrail I was referring to is the requirement that the caller
write a safety comment.

