Return-Path: <linux-kernel+bounces-434612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3F59E68F3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E2361886E32
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D851E22FA;
	Fri,  6 Dec 2024 08:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d1aZ7D6N"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A49C13DDDF
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 08:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733473905; cv=none; b=KkNszHM26K2Ippn7A1UUJkIx45rOmyIJthMzGPwkr9YLzhrRrpLQJjApYdlNs+uqV8uAbpt3V2yIGx/DPE2jY9oksgT37Vblw1MCIC7fz6O4G9F/Jlb8YazxteiUl9QLyybxmNJJRSl+7wPpFG9ZeVUmH10hudtA6FWPFQMbJ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733473905; c=relaxed/simple;
	bh=G/NWr+cFHKo5I/8lV3/xQbIcisFUGORAhy2vxW/qyMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tHHFAv//I+Lhw3snBa6l/ZM18T+tQ907KQAGhHNmR/jhzaqJ3TPAgCeFsSmOMcZJa3MBjPEhHm2rB9qkTPb3nnV4HOdL53EEKnQS1L0RGy3ho/QmhVFbX99k8S1pVmiVgiy24HhsqBOJ1biP5IkbuXfKH/Ju3zASc8hOMUOpH/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d1aZ7D6N; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-385f07cd1a4so1316483f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 00:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733473901; x=1734078701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MndMYY4GPIQ8HTWtED6XEkvHTM70jq0Eh04UxVuFw2o=;
        b=d1aZ7D6Nt8ILsx6RFqi8QW7445Eue/ZjN+BsLIy2x5inimawsd10PLW+im1uvd9D1l
         Y1zb0exPbH7yVOK7h84Rcf20EgktENM+FmuUM8J2L75j++hfKnPm4TiOl5aFikaSlfxN
         if21uPHfQzFKtBlZCsk7d6YjswDZhOhBe2YXJ6VTSf0Np23aC/0Li3NaouiU365r+EEy
         v9semLhnErQWXjeI8Wx9OghV93APROSHbpr4X758hnsf769PY23c7RR200p2CmU317kx
         oln/u2B+m1bjSLgv2A77KrlcKVkwS1PhG+2h/dZuPKFK2/RqKMncYgoguY4tYUneuRnm
         iGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733473901; x=1734078701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MndMYY4GPIQ8HTWtED6XEkvHTM70jq0Eh04UxVuFw2o=;
        b=ugEI/vqA5Ad+O/w3YrWyO9ClYQKHgZ4hqEcLUwJZKNl0/sJBJ3o7SwnZrvWP4vMNVl
         dld5eXaBPndRSQt5TpVDjtQfZ5Yx3t/W5ctfMEEwg2J66vFOLNGrmmaGZonk/xlBmnsx
         pjqWxMszVxY50SeFo2FJC///tYBNhY1RkIMK61aveM9TkWC7oAROBf2v2m1HfK9F8hTq
         sQtyI41a+ZxJmCsrn8dZyCMtJ8jU6RVtYyQo67D1qRjzfuhqnl+FHRpz9Wad+WHDzXDH
         iSN9yS4RWDSisxzdaJp1PHcGDAslipoDmgdEjpoXZAO9C/ejy8uADP142svuzFEreGqY
         RTyw==
X-Forwarded-Encrypted: i=1; AJvYcCVf1/IycdH4QTx6qPmDtz9zwCpYAqMyClwY8ZaTQSt+gJ+hIX9Y0P7JY1eJPm41WqqBilxa7s37MSKgBcs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy133AEMX4OQL8GMNeEMtn36QQWzY2qYYFzJ5VOX/Z+C6Eluhts
	hoFI/SWYuefNY+Q1h4nTmZZzpZfQTlR19hDFFqwN/HygCdpx0oz/J5xEUEGxRAf1QZ+HRfYjhXk
	nkhq8AG87txyVl3gFh8JJtdaDj7I5Pn2gYhiW
X-Gm-Gg: ASbGncsEK0YCrSyQqactrXJdu1uja+5CTeqBR0la78UIHOcbuabGJi+ez19YYvcFWFU
	M4u0S9FTMvPkcS6bmJMVK9mBhP44ZxbUc
X-Google-Smtp-Source: AGHT+IHTpVhNbdQ5mRt21s4Gec32i/tVvuXdlp9phX7cA24emalaIIqZWOzUp/cCiiZ1ZpZANHDBZHrFKALrak5xbNw=
X-Received: by 2002:a05:6000:a14:b0:385:f0c9:4b66 with SMTP id
 ffacd0b85a97d-3862b39b9b4mr1763642f8f.33.1733473901426; Fri, 06 Dec 2024
 00:31:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205162531.1883859-1-lee@kernel.org> <2024120632-hardwired-hardhead-1906@gregkh>
 <20241206074443.GJ8882@google.com> <2024120622-unvalued-wriggle-7942@gregkh>
In-Reply-To: <2024120622-unvalued-wriggle-7942@gregkh>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 6 Dec 2024 09:31:28 +0100
Message-ID: <CAH5fLgj6rqVbGHrU4008fvO60fJdRWoE2SvW7nc9njPUFuzJ_A@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] rust: miscdevice: Provide sample driver using the
 new MiscDevice bindings
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org, arnd@arndb.de, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@kernel.org, tmgross@umich.edu, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 9:11=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Fri, Dec 06, 2024 at 07:44:43AM +0000, Lee Jones wrote:
> > On Fri, 06 Dec 2024, Greg KH wrote:
> >
> > > On Thu, Dec 05, 2024 at 04:25:17PM +0000, Lee Jones wrote:
> > > > It has been suggested that the driver should use dev_info() instead=
 of
> > > > pr_info() however there is currently no scaffolding to successfully=
 pull
> > > > a 'struct device' out from driver data post register().  This is be=
ing
> > > > worked on and we will convert this over in due course.
> > >
> > > But the miscdevice.rs change provides this to you, right?  Or if not,
> > > why not?
> >
> > This does allow us to pull the 'struct device *` out from `struct
> > miscdevice`; however, since this resides in MiscDeviceRegistration,
> > which we lose access to after .init, we have no means to call it.
> >
> > Alice is going to work on a way to use ThisModule to get the
> > MiscDeviceRegistration reference back from anywhere in the module. Unti=
l
> > that piece lands, we can't call MiscDeviceRegistration::device() outsid=
e
> > of RustMiscDeviceModule.
>
> That seems crazy, as ThisModule shouldn't be dealing with a static misc
> device, what happens for dynamically created ones like all
> normal/sane/non-example drivers do?  This should "just" be a dynamic
> object that is NOT tied to the module object, or worst case, a "static"
> structure that is tied to the module I guess?
>
> Anyway, I'll let you all work it out, good luck!

If you store it somewhere else, you're probably okay. The current
place is just hard to access.

The problem is that the Rust module abstractions generate a global
variable that holds an RustMiscDeviceModule which is initialized in
init_module() and destroyed in cleanup_module(). To have safe access
to this global, we need to ensure that you access it only between
init_module() and cleanup_module(). For loadable modules, the
try_module_get() logic seems perfect, so in Miscdevice::open we have a
file pointer, which implies that the fs infrastructure took a refcount
on fops->owner, which it can only do once init_module() is done.

Unfortunately, this doesn't translate to built-in modules since the
owner pointer is just null, and try_module_get performs no checks at
all.

Also, I'm realizing now that try_module_get() succeeds even if `state
=3D=3D MODULE_STATE_COMING`. :(

So in conclusion, I don't know of any way to provide safe access to
the global RustMiscDeviceModule value.

Alice

