Return-Path: <linux-kernel+bounces-437562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B579E951C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72DE61883AFB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E85233D81;
	Mon,  9 Dec 2024 12:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3FZ4li0/"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5028E233D6C
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 12:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733748840; cv=none; b=utg18odfKq8KR+n/76ULCCWYmLPwvNEmsYpDjEfXCarUz9lqyGA9EGMlKDFnHdu2QNcU9AEgHdIZztWadIt+Me6adXm+Rexq6h1+ZHhU6jUNlttlIPF1Yy8wCjrNsfo5rmpHS2iEDTkF7RAd+i3N/ZlfujQ/yNwRAVI/psYQidg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733748840; c=relaxed/simple;
	bh=obrx4jcL33/kWWozeiQoPtk4e9tIpEL93T5ZUqbYrio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r79kISx0lEfcnK9vYza/heuP3ybhnIagaS4/RryFoKW/EbAzBrFJ1fF/b0b3+NGRLTe2ue6I8ejnENQryaGD2/KbubBR44dVM2tugS89QDxNmvxgLXsq7K3o+z5PKRoG0YP3fff7BJeGZgozSiz90wmV3V9eBYbK+I+uCwHsnVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3FZ4li0/; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-434e8aa84f7so18240275e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 04:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733748837; x=1734353637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2i5SAc+98oEk5ukKLfbKKuEDIk6TYm+EWYT8/y8W4Ek=;
        b=3FZ4li0/55aH3CrZCdfucHt8WkJ6v3B8qR+cN5e5jX4/kiSNs+T9y8huMEF83yuDWw
         GtLP/lsLZyNilGuVNxJ9Wq9bP2vPzRfvpKaNQMpMKSa4KlRiq6PBNcNsNEAbEtj5v836
         fWgMaqhw00D2bQrOyN+ZSmeSLq0wY+n9JatwogOlVO3oM8y2tx2SCI7yya0A9GJ10pSR
         iHxQtpAptd2hM5zX8R7uCDKFfUUH2XRVxOc9/An75ZWzkrAJ0Q3bv3n/VaNGGDHq4QvO
         8AFac53t04t2m8g5ajPHKHrTZMs/0s4jqESFslh6HEPYDRNRj0lL6fAQ4dBYeDip7M5y
         za7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733748837; x=1734353637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2i5SAc+98oEk5ukKLfbKKuEDIk6TYm+EWYT8/y8W4Ek=;
        b=A8+48jUzDGEeFZ908w3QHAHjKFZLTqiCCNHkw0AuY/AasQl28CWuskTJYH4xohijYc
         SK/02PO9Amm8Hx7NP79e38tOw3KrW9NWFwq3dhozipaPO8GYxR7NiqiR4QNDNkS2WiAR
         Pgd5NG2wXz2bDCg2TPv4BXTqw1DQLD1STL6e49lv2R9VHb8lekUPuTBdr07TrxTx/AYy
         8Bqch0y+/ssK2H0skKCFKTCE2Rz7nDInGB2wns5Nwv+UocBQ0lfNyel4dOeyO3zr44oS
         sMnUG6HUMQYnWFvc+62VCIImPSwd/Wke44FcFdsu/TBPaN5urjBtKguUvRqFYyzc1XaF
         o3uQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjPhCWL6QbBkRcK2yHQCUK1FS95cmb5xs3+Eb7Uy4678lBQ08FEb1qUEuxFrVqlcQYsl/bNwicJ/K4Of4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMrwp19l30CVjaxRkACiW7xlJmrvA1ldOsLTWhjvKa2XigTc7l
	CHr/YC3FqWoEZsM9ehr46m3j/vu8UKk0tuE9Xg2N9THB7Y4+F7gr/Z4kyNFBB4w6nycjPXdAHkC
	KlkZfN1dRBXKjKXYPHH+0BgAn0bU0ijQX7iPJ
X-Gm-Gg: ASbGnct6rl869/N/pdc/6lU17DRJJr3fx6ghCNUIEbtJFWnUHiuWoSaGnMzejzee0A9
	/48p2r82iRqDrZvJ1gxXxAZ8fcL0gkCfIdXQ8caS9CO45l6HDX2IPNWtxgGZE9w==
X-Google-Smtp-Source: AGHT+IEuEI+4Zj+0nladgNqpgiOV2r8smTtTysfeQSoMAfpfFTFz6wYeGiz3rgawD6ECY00uZeOog1XRL6/cxhViFl4=
X-Received: by 2002:a05:600c:4f85:b0:434:a1d3:a306 with SMTP id
 5b1f17b1804b1-434fff30c48mr3250905e9.5.1733748836596; Mon, 09 Dec 2024
 04:53:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-miscdevice-file-param-v2-0-83ece27e9ff6@google.com>
 <20241209-miscdevice-file-param-v2-2-83ece27e9ff6@google.com>
 <2024120925-express-unmasked-76b4@gregkh> <CAH5fLgigt1SL0qyRwvFe77YqpzEXzKOOrCpNfpb1qLT1gW7S+g@mail.gmail.com>
 <2024120954-boring-skeptic-ad16@gregkh> <CAH5fLgh7LsuO86tbPyLTAjHWJyU5rGdj+Ycphn0mH7Qjv8urPA@mail.gmail.com>
 <2024120908-anemic-previous-3db9@gregkh> <CAH5fLgjO50OsNb7sYd8fY4VNoHOzX40w3oH-24uqkuL3Ga4iVQ@mail.gmail.com>
 <2024120939-aide-epidermal-076e@gregkh>
In-Reply-To: <2024120939-aide-epidermal-076e@gregkh>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 9 Dec 2024 13:53:42 +0100
Message-ID: <CAH5fLggWavvdOyH5MEqa56_Ga87V1x0dV9kThUXoV-c=nBiVYg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: miscdevice: access the `struct miscdevice`
 from fops->open()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Lee Jones <lee@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 1:08=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Dec 09, 2024 at 01:00:05PM +0100, Alice Ryhl wrote:
> > On Mon, Dec 9, 2024 at 12:53=E2=80=AFPM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Dec 09, 2024 at 12:38:32PM +0100, Alice Ryhl wrote:
> > > > On Mon, Dec 9, 2024 at 12:10=E2=80=AFPM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Mon, Dec 09, 2024 at 11:50:57AM +0100, Alice Ryhl wrote:
> > > > > > On Mon, Dec 9, 2024 at 9:48=E2=80=AFAM Greg Kroah-Hartman
> > > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > >
> > > > > > > On Mon, Dec 09, 2024 at 07:27:47AM +0000, Alice Ryhl wrote:
> > > > > > > > Providing access to the underlying `struct miscdevice` is u=
seful for
> > > > > > > > various reasons. For example, this allows you access the mi=
scdevice's
> > > > > > > > internal `struct device` for use with the `dev_*` printing =
macros.
> > > > > > > >
> > > > > > > > Note that since the underlying `struct miscdevice` could ge=
t freed at
> > > > > > > > any point after the fops->open() call, only the open call i=
s given
> > > > > > > > access to it. To print from other calls, they should take a=
 refcount on
> > > > > > > > the device to keep it alive.
> > > > > > >
> > > > > > > The lifespan of the miscdevice is at least from open until cl=
ose, so
> > > > > > > it's safe for at least then (i.e. read/write/ioctl/etc.)
> > > > > >
> > > > > > How is that enforced? What happens if I call misc_deregister wh=
ile
> > > > > > there are open fds?
> > > > >
> > > > > You shouldn't be able to do that as the code that would be callin=
g
> > > > > misc_deregister() (i.e. in a module unload path) would not work b=
ecause
> > > > > the module reference count is incremented at this point in time d=
ue to
> > > > > the file operation module reference.
> > > >
> > > > Oh .. so misc_deregister must only be called when the module is bei=
ng unloaded?
> > >
> > > Traditionally yes, that's when it is called.  Do you see it happening=
 in
> > > any other place in the kernel today?
> >
> > I had not looked, but I know that Binder allows dynamically creating
> > and removing its devices at runtime. It happens to be the case that
> > this is only supported when binderfs is used, which is when it doesn't
> > use miscdevice, so technically Binder does not call misc_deregister()
> > outside of module unload, but following its example it's not hard to
> > imagine that such removals could happen.
>
> That's why those are files and not misc devices :)

I grepped for misc_deregister and the first driver I looked at is
drivers/misc/bcm-vk which seems to allow dynamic deregistration if the
pci device is removed.

Another tricky path is error cleanup in its probe function.
Technically, if probe fails after registering the misc device, there's
a brief moment where you could open the miscdevice before it gets
removed in the cleanup path, which seems to me that it could lead to
UAF?

Or is there something I'm missing?


Alice

