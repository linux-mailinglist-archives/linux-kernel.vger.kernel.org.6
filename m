Return-Path: <linux-kernel+bounces-184577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 963098CA90A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 09:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B96611C21450
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 07:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D73524DA;
	Tue, 21 May 2024 07:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bqc14bkZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA13850249
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 07:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716276971; cv=none; b=SzqUnS6ih5x9wg26RAzL1ZpKdRh6RTNmHVeimbHPwapjSwimUpFS2KPfN7nMhUpP2YcyvVykQBzYBS38X1uNw7pT5kcfJGvNAP+9xJax7/8Zds5aI3Po32xl4NyfOrEGM44XleH+rwngrKOMDgLnujn/tW6qgFXCOop44cGN80g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716276971; c=relaxed/simple;
	bh=XdN+2zttHQ0MjCqkV/rL3F/G1MvLNe2WB7xdOgF7Tr0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BgaAaskaz9CgE4mSKVIzjw7gy3nOVjKxCzh0oStFhTf7ekF/8qc0jqAAOU6q5uT0oxt9bFX9LqCPWNpUDDRvAuzGIc0Wjg2fBO6SVThBizZgyPywVolcYHQm9hARtX9uXfGafM6C3Q5HR3ErOZ3IPkpMIHj5k0DQtSN9s9DTz8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bqc14bkZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716276968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XdN+2zttHQ0MjCqkV/rL3F/G1MvLNe2WB7xdOgF7Tr0=;
	b=Bqc14bkZDgunCi7TUI7MIbbLRFU+SbAoZ/kHWnEbMaa2OT0/y5PWUNmMFn3rAFlfheDo4f
	uUEL4OLMtc3Tvh6fDNjey1drKx/oIIcYhGpCCRiYDcIdNEPUZtXmW/qo1IL/47TAgiVThm
	PrDMiG7HFpUQ+7yATeL5rSo838FTuoI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-Xdf6XBZKMWeYatJV_aXKcw-1; Tue, 21 May 2024 03:36:05 -0400
X-MC-Unique: Xdf6XBZKMWeYatJV_aXKcw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-572abc1bea8so824438a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 00:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716276964; x=1716881764;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XdN+2zttHQ0MjCqkV/rL3F/G1MvLNe2WB7xdOgF7Tr0=;
        b=sEDhE3oA0fjBd+/ooZ88mGDsm9K/+TPcOPyAFEkR6czlyur2loSTDCcpuQrwW26G6e
         V7oAO/XED4REnszLNxDWTEt2vleODhGgAuIeCyhBrjjkI5pLWVOjLqMJ4jAB4SKWPtiY
         j9pcC4KqFJthuzuKjBqRREllWFr8OWXgrGyFYNaw0e86dAzk+05kS5C1TReyQ3lZA5fQ
         WFwR/1WeSvc/ItfvmviaI/8O/9kxlVu6OsGyl422kuT5PNdwhhbsan6nsl7Vslw476Hq
         PXbdHCYus8osKm8rTrFAACK1/9LfZ+qBRF9X0Vq6s3fPb71428tyYoFcgFhbQ6WNiEmF
         Z+aw==
X-Forwarded-Encrypted: i=1; AJvYcCXYXdGTjdnK7daDgl3szzoIrrlPMgWqWvPDvTbKC0er+W+08RcUjs+dw1touYmh2/wKYhUgnBkUfL0KEn45Obzbo4JOy3X95PB8V4Bx
X-Gm-Message-State: AOJu0Yz1OBc82F+biPtOfaaxNUX1oD0Yju5UqD65PhLNjlAyKVzENrAl
	28KNFBIs7DdYwi4L2iEGo21U65q+epd+uJn+WxAHMgH30K+NNbF8EFiOScqgSLrRDsPW02LXsXo
	f366z//z94jgbh+wCr7aWEedH8NktZkCQRrFHI8xhe+hjEFYhLw2UDR2ZroyvAA==
X-Received: by 2002:a17:907:986:b0:a59:bce9:8454 with SMTP id a640c23a62f3a-a5a2d55347bmr2891346766b.1.1716276964254;
        Tue, 21 May 2024 00:36:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6X/1XcE2E6yjKqIiqCpzGiiQ6iBNuEwXlVNXHnfjn+aSwnJU50wIIah1qpk9DeBlBs9Y+Mg==
X-Received: by 2002:a17:907:986:b0:a59:bce9:8454 with SMTP id a640c23a62f3a-a5a2d55347bmr2891343466b.1.1716276963771;
        Tue, 21 May 2024 00:36:03 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a3c65d06fsm1409594266b.52.2024.05.21.00.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 00:36:03 -0700 (PDT)
Message-ID: <cf89c02d45545b67272aba933fbc8a8a0df83358.camel@redhat.com>
Subject: Re: [RFC PATCH 10/11] rust: add basic abstractions for iomem
 operations
From: Philipp Stanner <pstanner@redhat.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Danilo Krummrich
	 <dakr@redhat.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
 ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
 boqun.feng@gmail.com,  gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me,  a.hindborg@samsung.com, aliceryhl@google.com,
 airlied@gmail.com,  fujita.tomonori@gmail.com, lina@asahilina.net,
 ajanulgu@redhat.com,  lyude@redhat.com, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-pci@vger.kernel.org
Date: Tue, 21 May 2024 09:36:02 +0200
In-Reply-To: <CANiq72kHrgOVrdw7rB9KpHvOMy244TgmEzAcL=v5O9rchs8T1g@mail.gmail.com>
References: <20240520172554.182094-1-dakr@redhat.com>
	 <20240520172554.182094-11-dakr@redhat.com>
	 <CANiq72kHrgOVrdw7rB9KpHvOMy244TgmEzAcL=v5O9rchs8T1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-21 at 00:32 +0200, Miguel Ojeda wrote:
> On Mon, May 20, 2024 at 7:27=E2=80=AFPM Danilo Krummrich <dakr@redhat.com=
>
> wrote:
> >=20
> > through its Drop() implementation.
>=20
> Nit: `Drop`, `Deref` and so on are traits -- what do the `()` mean
> here? I guess you may be referring to their method, but those are
> lowercase.

ACK

>=20
> > +/// IO-mapped memory, starting at the base pointer @ioptr and
> > spanning @malxen bytes.
>=20
> Please use Markdown code spans instead (and intra-doc links where
> possible) -- we don't use the `@` notation. There is a typo on the
> variable name too.
>=20
> > +pub struct IoMem {
> > +=C2=A0=C2=A0=C2=A0 pub ioptr: usize,
>=20
> This field is public, which raises some questions...

Justified questions =E2=80=93 it is public because the Drop implementation =
for
pci::Bar requires the ioptr to pass it to pci_iounmap().

The alternative would be to give pci::Bar a copy of ioptr (it's just an
integer after all), but that would also not be exactly beautiful.

The subsystem (as PCI does here) shall not make an instance of IoMem
mutable, so the driver programmer couldn't modify ioptr.

I'm very open for ideas for alternatives, though. See also the other
mail where Danilo brainstorms about making IoMem a trait.

>=20
> > +=C2=A0=C2=A0=C2=A0 pub fn readb(&self, offset: usize) -> Result<u8> {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let ioptr: usize =3D self.g=
et_io_addr(offset, 1)?;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ok(unsafe { bindings::readb=
(ioptr as _) })
> > +=C2=A0=C2=A0=C2=A0 }
>=20
> These methods are unsound, since `ioptr` may end up being anything
> here, given `self.ioptr` it is controlled by the caller.=C2=A0

Only if IoMem is mutable, correct?

The commit message states (btw this file would get more extensive
comments soonish) that with this design its the subsystem that is
responsible for creating IoMem validly, because the subsystem is the
one who knows about the memory regions and lengths and stuff.

The driver should only ever take an IoMem through a subsystem, so that
would be safe.

> One could
> also trigger an overflow in `get_io_addr`.

Yes, if the addition violates the capacity of a usize. But that would
then be a bug we really want to notice, wouldn't we?

Only alternative I can think of would be to do a wrapping_add(), but
that would be even worse UB.

Ideas?

>=20
> Wedson wrote a similar abstraction in the past
> (`rust/kernel/io_mem.rs` in the old `rust` branch), with a
> compile-time `SIZE` -- it is probably worth taking a look.

Yes, we're aware of that one. We also did some experiments with it.
Will discuss it in the other thread where Dave and Wedson mention it.

>=20
> Also, there are missing `// SAFETY:` comments here. Documentation and
> examples would also be nice to have.

Oh yes, ACK, will do


Thx for the review!


>=20
> Thanks!
>=20
> Cheers,
> Miguel
>=20


