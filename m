Return-Path: <linux-kernel+bounces-437428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D77EF9E9318
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF2C72870E5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E73321CFEC;
	Mon,  9 Dec 2024 12:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y4sSrLil"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32DC221DB7
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 12:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745620; cv=none; b=tzrWD1sUrB1HJe40gb2tq8yGqHUrROzhVta26Q7Zlt/3QzFSZqH4e+o7QMvEoOjMg/ilCvK9QfyKyTVO9sA7NwRajuR16KeewzBLnhhKNft/jYLfs0e11Mt1ExBKkeci7DxvHgxIHNLoiB3lyC31fs6YDmfv1cMNuR09UHf1ZAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745620; c=relaxed/simple;
	bh=irb7NoHLwRF7FkV7QUwN51uAjTTO32qfYx+9arRf/dI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UCvRkC/RR9kcUNuOvKTbNFxiNbs/KR8ukMhEd3RGg/TV8vcUGAUvGXgYzsa671ApQysEVMDWGQ8FW7gNuzLhH4I0wMUoqflv0eBcnFLiiT1D6vFxTiOGbIF+5MebM676OLdQW/tHVLY5pW1HzOSrN/9SplmITW5vR/PiCcioCWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y4sSrLil; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so1634577f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 04:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733745617; x=1734350417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRWnjbIcEaUT/uOdlIBI8ZLkCYOjr+OO7040U3iCZOQ=;
        b=y4sSrLilzKYaGVM1H0T1wIzWSKPpp2XK79O8WMOnbKbAbWMPdMvizOdpDb/pJADcCX
         /4ZuocqKL/VU63c2GTaYyPhX3Tl4zBC1jSYWBU0CQOCe4QHM62hWWQQN/KlCYoM0G6EY
         sAN1wD+4k+slOXS7z0wIkbXbmCzLoez3W3AyaKdRlF5SaJ6Rd9QozQMpeHPJfxNvjDuw
         wvcu47cS8IPEx5NtJVqs7qL+BaWKE65GCeQ7JCv+diNd/RC2Op00m+jzkyEQpQXThDRX
         gHA2iQCESK5/RiUvw2buvE2/Cc0DvQvSFRZzLBQPO4xuUNv9Ejrinis7JQ5wnNL93CEi
         Bm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733745617; x=1734350417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRWnjbIcEaUT/uOdlIBI8ZLkCYOjr+OO7040U3iCZOQ=;
        b=OLqHfCBirluqUwkujI8aoKb9AIhF9xdWu/VotOJ37487760mBwIVObAoUVkLm3cTCK
         Me07MksnB+9f9ty0dUNXCe15UTeSKyiF4HYCqjDGo0Xpj4cecaIq3lbwQllSazAdYR8G
         HONnB+BJwjdh0mduNAzo0jD94vp2olPGqwvZ+/v4PzYZ6T0qXEcZLm1jqFJTefYa21FZ
         x8ica+gEY1O4SKcXhyXh6DExJjfm9cGqhd/VQ9+27abi6uQFm569YOgqbMoz7/X5b94g
         QxnihkVTUUU4I43cN5IFvtg32toy7P9ktT40ZhIfwG5ZgLlIiLD12xq/m+YKRW97FBzh
         Rl4w==
X-Forwarded-Encrypted: i=1; AJvYcCWoHhLEX3LPKcNFPOXVQ7SJt/Hq3FCeNZzb2/79UsRXHiXLhUI1EFXs+DJ7YXZvN/JKDG40DHGZEQPEoi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoLs/9c9AkZ4T+smHHck/sUbf1Md3ZDI1BGLfDrXNz2H2QCJiV
	nhda2Y4MbMa2VNFH/TN4iMIhW4mw15L4khw6bT8U9QJsP+ljB6aJCeM/IKwDzFm+IJtWvVFI4WT
	guV6MCrTKcLGPOozChyIJ4lvT/0l/1L0bc1To
X-Gm-Gg: ASbGnculzuAGsUetrJhVN+P1jk9DA9PbXm9JdZZwJ+5KkN9aUt+coRRy/j5AgesmqZN
	nVAnS3ZvmPuMjZcw2k+896mQbmL0H3kXBckhAMtZou4boxWHftFpFI8Z7FAel
X-Google-Smtp-Source: AGHT+IEST2AzLVlKwo7Dqo7wunMdpR9iGwOqw+aS1pcSbGH9kIOAPm02t0oed0g3ICmLZDCLUOfC+EkbLg9zmoj5ZMk=
X-Received: by 2002:a5d:5f4c:0:b0:385:faf5:ebb8 with SMTP id
 ffacd0b85a97d-3862a893fadmr7467282f8f.7.1733745617120; Mon, 09 Dec 2024
 04:00:17 -0800 (PST)
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
 <2024120908-anemic-previous-3db9@gregkh>
In-Reply-To: <2024120908-anemic-previous-3db9@gregkh>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 9 Dec 2024 13:00:05 +0100
Message-ID: <CAH5fLgjO50OsNb7sYd8fY4VNoHOzX40w3oH-24uqkuL3Ga4iVQ@mail.gmail.com>
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

On Mon, Dec 9, 2024 at 12:53=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Dec 09, 2024 at 12:38:32PM +0100, Alice Ryhl wrote:
> > On Mon, Dec 9, 2024 at 12:10=E2=80=AFPM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Dec 09, 2024 at 11:50:57AM +0100, Alice Ryhl wrote:
> > > > On Mon, Dec 9, 2024 at 9:48=E2=80=AFAM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Mon, Dec 09, 2024 at 07:27:47AM +0000, Alice Ryhl wrote:
> > > > > > Providing access to the underlying `struct miscdevice` is usefu=
l for
> > > > > > various reasons. For example, this allows you access the miscde=
vice's
> > > > > > internal `struct device` for use with the `dev_*` printing macr=
os.
> > > > > >
> > > > > > Note that since the underlying `struct miscdevice` could get fr=
eed at
> > > > > > any point after the fops->open() call, only the open call is gi=
ven
> > > > > > access to it. To print from other calls, they should take a ref=
count on
> > > > > > the device to keep it alive.
> > > > >
> > > > > The lifespan of the miscdevice is at least from open until close,=
 so
> > > > > it's safe for at least then (i.e. read/write/ioctl/etc.)
> > > >
> > > > How is that enforced? What happens if I call misc_deregister while
> > > > there are open fds?
> > >
> > > You shouldn't be able to do that as the code that would be calling
> > > misc_deregister() (i.e. in a module unload path) would not work becau=
se
> > > the module reference count is incremented at this point in time due t=
o
> > > the file operation module reference.
> >
> > Oh .. so misc_deregister must only be called when the module is being u=
nloaded?
>
> Traditionally yes, that's when it is called.  Do you see it happening in
> any other place in the kernel today?

I had not looked, but I know that Binder allows dynamically creating
and removing its devices at runtime. It happens to be the case that
this is only supported when binderfs is used, which is when it doesn't
use miscdevice, so technically Binder does not call misc_deregister()
outside of module unload, but following its example it's not hard to
imagine that such removals could happen.

> > > Yeah, it's a horrid hack, and one day we will put "real" revoke logic=
 in
> > > here to detach the misc device from the file operations if this were =
to
> > > happen.  It's a very very common anti-pattern that many subsystems ha=
ve
> > > that is a bug that we all have been talking about for a very very lon=
g
> > > time.  Wolfram even has a plan for how to fix it all up (see his Japa=
n
> > > LinuxCon talk from 2 years ago), but I don't think anyone is doing th=
e
> > > work on it :(
> > >
> > > The media and drm layers have internal hacks/work-arounds to try to
> > > handle this issue, but luckily for us, the odds of a misc device bein=
g
> > > dynamically removed from the system is pretty low.
> > >
> > > Once / if ever, we get the revoke type logic implemented, then we can
> > > apply that to the misc device code and follow it through to the rust
> > > side if needed.
> >
> > If dynamically deregistering is not safe, then we need to change the
> > Rust abstractions to prevent it.
>
> Dynamically deregistering is not unsafe, it's just that I don't think
> you will physically ever have the misc_deregister() path called if a
> file handle is open.  Same should be the case for rust code, it should
> "just work" without any extra code to do so.

Well, if I give files access to the struct miscdevice in all fops
hooks, then deregistering does become unsafe since accessing it in an
ioctl after deregistering would be a UAF. I'd like to prevent the user
from doing that.

Alice

