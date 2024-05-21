Return-Path: <linux-kernel+bounces-184404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF418CA68F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 05:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44840282B12
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 03:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A3E1BF24;
	Tue, 21 May 2024 02:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPlw2bKd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15971BF47
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 02:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716260367; cv=none; b=ZeDe0R9T+U72WeAYcKwt7OLvPHhD7V6X3/dblDxcMtB1vY/39/mCy5Q6rvLr/zt5qkL8hPf3MrZFW36sRZ3sl751lnT9pFtCV7RbSVv/QP6mdvDxWqurOadYzm+p/dESSMnblY/cgtR6l+r3jQ/B7wQpMgkSS213pjEq+2WjnYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716260367; c=relaxed/simple;
	bh=lS164zVhatoCQzOGw9xfoipYlofiS/EZUfAZNpoXX9I=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=XAVyUS2Cv3C6ktH9voW5qn3ItePZFJ46SBT/LzP8L8IIhWoTyMXZMms6Wq0Mrnmh6WUkTRSN5ckgxXqGN/etwjac2luEI1r4J1nsg4MhAYjEidNjrrTwJKnJUQNr49ncSfMUTlol0tR6pTg9i5HBf94PzFWxraEzAZwasVN6MYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EPlw2bKd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716260363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gpHxUzO7krNIPiV9mgzFqkbtUMxrneNQVP8XN/mttLU=;
	b=EPlw2bKdGoS7GzDOOckHvcksnRis9QcH+uidQl81jx7xFF+ulQvd7rKIH7YRFsi/ZZfL7t
	XyajJzJAKZnUqYz7d3dy8509zsgHCZdcm93hNgqvjTfjOkUX2/W+emBCFk4CcRCp02QY2K
	1gn3RPtN2qk0wIcFT4mRxlD6LBA7ngs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-4MZlwiFWMtmWIsiljaUWCw-1; Mon, 20 May 2024 22:59:21 -0400
X-MC-Unique: 4MZlwiFWMtmWIsiljaUWCw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-420061cf0fbso49358735e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 19:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716260360; x=1716865160;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpHxUzO7krNIPiV9mgzFqkbtUMxrneNQVP8XN/mttLU=;
        b=K8+osU0nRNijSacyEQ7NZFHELqwEUXrRLbUwUrKZ2suMPcxHdiElxrwi72feQDzlhG
         xTpSD+WFder8YFjUThYPjrleNlas/s4EMZ6RHmAjdopbzpIyCithH9g9XS6YOQD0KiFm
         YMvkj8dlreel43LPFGkr67nAtbbMtF445iyvMO7VVUD7sM29xzG5//OgL8iLnKXmiRak
         Xox70GI9FmTHJtPOceHbo+/rYqyb821BNcOWVl6et0EgSGeszQOzJhKpGkCWXkfjEFmF
         5pwJ+WlGSnvlDlteCa40g8sLzRTqn7e04wWIqdqgOgq1yvN5Y7MjUHC88qyPCew0+G4C
         fiIA==
X-Forwarded-Encrypted: i=1; AJvYcCWmnFXyCBB9U++TeyXaXn8/yQO5UIYzzGQDPdKZ9GV3J+tqQoBd/2rlOLDGD1XBVwXS2WpZG73mdwsQ2hwg3dnzWTH+m2pzxsOKvZ0m
X-Gm-Message-State: AOJu0Yx8zz5I+CKgQnovO809a6UYgdaxsOlq4+Jr91iX0QXReiDx9XkQ
	cM0h2kS5Z8nAarr5hKf7LVsLlSPELUVDFXitw6DiJGLylFc6WbxC2a0s0J4UXW4vF8VTJbsuzAu
	pUT34nkS1tkRtra4hS8s33uliCGJwzwbcisKg4l1kAGW1/ggpJ+E6lcIHXKMItA==
X-Received: by 2002:a05:600c:35d3:b0:420:14fb:de1f with SMTP id 5b1f17b1804b1-42014fbe1admr189797015e9.14.1716260360791;
        Mon, 20 May 2024 19:59:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGN6LF6zOUxd0TtcyOUp7U9AawDsKqXA8eie9bsey3aMIwKmzga3L4ta6139bGXkj0jSRbreg==
X-Received: by 2002:a05:600c:35d3:b0:420:14fb:de1f with SMTP id 5b1f17b1804b1-42014fbe1admr189796825e9.14.1716260360431;
        Mon, 20 May 2024 19:59:20 -0700 (PDT)
Received: from smtpclient.apple ([2a02:810d:4b3f:ee94:9976:d2a9:2161:854f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccbe8fa6sm445082275e9.2.2024.05.20.19.59.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 May 2024 19:59:19 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Danilo Krummrich <dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH 10/11] rust: add basic abstractions for iomem operations
Date: Tue, 21 May 2024 04:59:08 +0200
Message-Id: <CE78A4CB-F499-4BD8-8E29-28F561B320C1@redhat.com>
References: <CANiq72kHrgOVrdw7rB9KpHvOMy244TgmEzAcL=v5O9rchs8T1g@mail.gmail.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
 ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com,
 airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net,
 pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
In-Reply-To: <CANiq72kHrgOVrdw7rB9KpHvOMy244TgmEzAcL=v5O9rchs8T1g@mail.gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
X-Mailer: iPhone Mail (21E236)

(quick reply from my phone)

> On 21. May 2024, at 00:32, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> w=
rote:
>=20
> =EF=BB=BFOn Mon, May 20, 2024 at 7:27=E2=80=AFPM Danilo Krummrich <dakr@re=
dhat.com> wrote:
>>=20
>> through its Drop() implementation.
>=20
> Nit: `Drop`, `Deref` and so on are traits -- what do the `()` mean
> here? I guess you may be referring to their method, but those are
> lowercase.
>=20
>> +/// IO-mapped memory, starting at the base pointer @ioptr and spanning @=
malxen bytes.
>=20
> Please use Markdown code spans instead (and intra-doc links where
> possible) -- we don't use the `@` notation. There is a typo on the
> variable name too.
>=20
>> +pub struct IoMem {
>> +    pub ioptr: usize,
>=20
> This field is public, which raises some questions...
>=20
>> +    pub fn readb(&self, offset: usize) -> Result<u8> {
>> +        let ioptr: usize =3D self.get_io_addr(offset, 1)?;
>> +
>> +        Ok(unsafe { bindings::readb(ioptr as _) })
>> +    }
>=20
> These methods are unsound, since `ioptr` may end up being anything
> here, given `self.ioptr` it is controlled by the caller. One could
> also trigger an overflow in `get_io_addr`.
>=20

I think the only thing we really want from IoMem is a generic implementation=
 of the read*() and write*() functions.

Everything else should be up the the resource itself, see e.g. pci::Bar. Hen=
ce I think we should just make IoMem a trait instead and just let the resour=
ce implement a getter for the MMIO pointer, etc.

> Wedson wrote a similar abstraction in the past
> (`rust/kernel/io_mem.rs` in the old `rust` branch), with a
> compile-time `SIZE` -- it is probably worth taking a look.
>=20
> Also, there are missing `// SAFETY:` comments here. Documentation and
> examples would also be nice to have.
>=20
> Thanks!
>=20
> Cheers,
> Miguel
>=20


