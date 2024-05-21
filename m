Return-Path: <linux-kernel+bounces-184609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC8B8CA98E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 10:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B362B229D1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 08:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A505478B;
	Tue, 21 May 2024 08:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mvj+mzg7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACAF4CE04
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 08:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716278594; cv=none; b=VnB2zz67h9lsZcIZI0yal1HRlPFTci/hlF0jLbyY07jba3YqwRKenm4NmS+sxFP0ewtDcsu80Z35BHYbsEnLusPTSC6URUjftg/HFIy1mNZjgTnOZUIvbzDPrJvIqblF7ryohv5ihuf8MV7bvVZlGOBBKXS7k06cEOAQPbB03Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716278594; c=relaxed/simple;
	bh=P8i8lpZFDK9qhijLTo40alsf+/38zDsCsS5gsVu0+68=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PiOicvV7aqw6mn9cCwaZ3Lep1Pzft1JRNh4SnG9BJyorVEdc+UDOrMf5ouFyirnybxb+d/F9LfXFo/VBOlKpFlZe5LQDev81pwXhXKHZMHM+AbYAoRZVfsegMKyC/LgwshyW/HLpHeQbwc4toKibjmkyKI9ZF6MPeSqueULvJn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mvj+mzg7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716278592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P8i8lpZFDK9qhijLTo40alsf+/38zDsCsS5gsVu0+68=;
	b=Mvj+mzg7YL3hKy7lak4bQJHkIZaDvvByuUOv2iKMeQtHkexe0GGeQ+aorZKfNYEFmvyMZZ
	2t6LKl+PBGDc0fSyY62IEG0v6y8BYXnHwEv0X+E6FrZ/andTwdcmyvgDtp6mrTZknmNF24
	y4+1+Ge8AfSnjFykjP5mxsY39sZ+UPs=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-XloFh_U5MiyXuqln0N7REw-1; Tue, 21 May 2024 04:03:10 -0400
X-MC-Unique: XloFh_U5MiyXuqln0N7REw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-572b374a4c8so814704a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 01:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716278589; x=1716883389;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P8i8lpZFDK9qhijLTo40alsf+/38zDsCsS5gsVu0+68=;
        b=Ep392BZ30FJZ6IEbNov9fSJfswAsVQuYQOn8cqLGOjLeEUzxzB12G+bLoZtuEtMs2V
         XPGuGJ7fqP8tfIYEb4EiRLH8Q2o/Og2NhhN09h9WgaPwvXXlilDbW8bGbLWk+CA9PXrA
         rslmGUIdBbfHiTPPJtYwlMr+9pAU9tVgiFL5uwm0fAFfJyL+dEgigzv96XMV/GNPSBC6
         ilmD2fXJPdlXQSBBaaoHlZxxNtF9SisyK29Ou1YXYYqvOvSpSQ+g0ehJosfOP3fxp7Z6
         7dNa9jVOoj57qXgb0F9AWSL65SWwodaF7NT/Tx1+BA3kEtJ2ng+r1A9Mr8fXFmWubb2W
         v6fg==
X-Forwarded-Encrypted: i=1; AJvYcCU4eJgTIiK7Vp8qOKPo4dcVEzPtTaQ6gTJQsADP6T74Q1a/bigARuMhwdl0lsf2NXDRA6evPTddUVL35Biq+32ImgUMsuErQYYOS+oy
X-Gm-Message-State: AOJu0YzxVKmQmhP19FlkUrGEGjPktUtmo1NAbkJnmIfkGTD8/+B9pLtw
	JlRfDe2HvGgwwBrQmZDvuh0BLouRhSm1nioE6b9HLhxHi9ZINb6+qs5HPXhjUJgM640neKGw3ZA
	aSWdRTc8+pmpS3e+3Ht08ZF/0iGfJ9hewIQEk7mf2JidUVtyl2pl1YEeEGpl06w==
X-Received: by 2002:a17:906:5a4a:b0:a59:bbd6:bb38 with SMTP id a640c23a62f3a-a5a2d6d1b90mr1909491366b.7.1716278589482;
        Tue, 21 May 2024 01:03:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+r903jJsCsfgUxdSOggtSi2Aisrx2uTa8+qStRPyE+96/oWSWqcZCONUYZVQp3fx1iO7+SA==
X-Received: by 2002:a17:906:5a4a:b0:a59:bbd6:bb38 with SMTP id a640c23a62f3a-a5a2d6d1b90mr1909489066b.7.1716278589063;
        Tue, 21 May 2024 01:03:09 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781e97bsm1560827766b.32.2024.05.21.01.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 01:03:08 -0700 (PDT)
Message-ID: <1c8bb8044bc1943ad8d19cd6fc84a2d886004163.camel@redhat.com>
Subject: Re: [RFC PATCH 10/11] rust: add basic abstractions for iomem
 operations
From: Philipp Stanner <pstanner@redhat.com>
To: Wedson Almeida Filho <wedsonaf@gmail.com>, Dave Airlie
 <airlied@gmail.com>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Danilo Krummrich
 <dakr@redhat.com>, gregkh@linuxfoundation.org, rafael@kernel.org, 
 bhelgaas@google.com, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com,  gary@garyguo.net, bjorn3_gh@protonmail.com,
 benno.lossin@proton.me,  a.hindborg@samsung.com, aliceryhl@google.com,
 fujita.tomonori@gmail.com,  lina@asahilina.net, ajanulgu@redhat.com,
 lyude@redhat.com,  rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-pci@vger.kernel.org
Date: Tue, 21 May 2024 10:03:07 +0200
In-Reply-To: <CANeycqpNeHFUu-RwSc6Ewa3r5TMhYYFDC6bO+sj3OZ398JfJ1A@mail.gmail.com>
References: <20240520172554.182094-1-dakr@redhat.com>
	 <20240520172554.182094-11-dakr@redhat.com>
	 <CANiq72kHrgOVrdw7rB9KpHvOMy244TgmEzAcL=v5O9rchs8T1g@mail.gmail.com>
	 <CAPM=9txb5STBo05xiTy9+wF7=mMO=X2==BP4JVORPFAtX=nS0g@mail.gmail.com>
	 <CANeycqpNeHFUu-RwSc6Ewa3r5TMhYYFDC6bO+sj3OZ398JfJ1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-05-21 at 00:01 -0300, Wedson Almeida Filho wrote:
> On Mon, 20 May 2024 at 23:07, Dave Airlie <airlied@gmail.com> wrote:
> >=20
> > >=20
> > > Wedson wrote a similar abstraction in the past
> > > (`rust/kernel/io_mem.rs` in the old `rust` branch), with a
> > > compile-time `SIZE` -- it is probably worth taking a look.
> > >=20
> >=20
> > Just on this point, we can't know in advance what size the IO BARs
> > are
> > at compile time.
> >=20
> > The old method just isn't useful for real devices with runtime IO
> > BAR sizes.
>=20
> The compile-time `SIZE` in my implementation is a minimum size.
>=20
> Attempts to read/write with constants within that size (offset +
> size)
> were checked at compile time, that is, they would have zero
> additional
> runtime cost when compared to C. Reads/writes beyond the minimum
> would
> have to be checked at runtime.
>=20

We looked at this implementation

Its disadvantage is that it moves the responsibility for setting that
minimum size to the driver programmer. Andreas Hindborg is using that
currently for rnvme [1].

I believe that the driver programmer in Rust should not be responsible
for controlling such sensitive parameters (one could far more easily
provide invalid values), but the subsystem (e.g. PCI) should do it,
because it knows about the exact resource lengths.

The only way to set the actual, real value is through subsystem code.
But when we (i.e., currently, the driver programmer) have to use that
anyways, we can just use it from the very beginning and have the exact
valid parameters.

So driver programmers would always have correct IoMem and would have a
harder time breaking stuff, and wouldn't have to think about minimum
lengths and things like that.


P.

[1] https://github.com/metaspace/linux/blob/rnvme/drivers/block/rnvme.rs#L5=
80


