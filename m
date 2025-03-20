Return-Path: <linux-kernel+bounces-569807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12029A6A7BA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC9A917DEC1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE5F221F12;
	Thu, 20 Mar 2025 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I8jBjX0C"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74201221F26
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742479004; cv=none; b=eLfCaLytzQLrNs/Op9zBg1G/Lve7PFMTwV30IvEuNKGDfh3Do+U/qqMJv4xtU+sVPaCWxOj+VJLNJnx4qhpD4YOA9ZrJrHZw47OCDlyaZRswBgd90CbUu8YHCwrWTGlUV5p3SzuF6zfClERpPhFgtQZYUL/sgeZ7Yenmn6VpJ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742479004; c=relaxed/simple;
	bh=S9T/qBL+z4aNd6M0Hkz2pYEIkgtE38X3OTfgtg4dx7c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DpoE24VG/LQxaLWIWabi8L73xQjOVjC88nMN8BUjmkuxW0Y5LXYw95abcWDKW1v/dQAyJVxy9cA+4mFYKZhNPxuq8lSlHPURhOf4u3rm6eP6IbDOeZ1EpGgQF7OOv9BQC94RqjtXRLtpRT6hS5RCHIEpGXkrX9MlLOQXTIcA0Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I8jBjX0C; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3912539665cso956420f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 06:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742479000; x=1743083800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kWWAhmzvNwlqSFcvmaCbepdAYIL6fnNZCCrItGOwILo=;
        b=I8jBjX0CNcMzw4nly5M5euWr4s1AomnOZikZCs4AhYo35H1WlvSQkF67ZT6XMVFEuB
         WJN+LCfdxGw2g7k2UIP1uc6B2tF+xkKgwq/8YcI2t+FxfWuC1fD+YZkDjz5S2AvzLWaz
         mkvH+uS4/p5RS69qMmouGPhS7SJOmubS+eVWs3yAIs8xPeFY1Y7S0e+DD3U62vFbFW1u
         Kc3ggIzSQmdsN+cTsnOMpLikbi1iQF5PAgfSE1bLQZ0eSEjhAcZBgBaOYfCrOmLptg0w
         kHVw/h3N/siEMaZoHQmEEFttcHJcDBxCEt7kwd01oM6i04OrhAI3mRe+kxy2saFnWClM
         PsLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742479000; x=1743083800;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kWWAhmzvNwlqSFcvmaCbepdAYIL6fnNZCCrItGOwILo=;
        b=KvmnvbOZQokRKpWt9oNth8qC4nHUTP2VBGi1U8bz73GyQp1+ilE3cxq/DmPXTrcGOY
         ShkxNy34SwmaXVjKWvuyhIsx+Ca67gZ0G2DK7J8HYBFaPMOlIfFxdCtI1ITdHeedFYe4
         Nzr4Zwe9JD+7y09c5+w5W/FfVw9i6/XGCzcYPse09TL6Vg/8FdeprOC+d3+8OQmyGQ5o
         eOk6wflVMVMZ4w8SBQUoJRaHFRZYEMvjFrBb0c90u0SnMtavaNcxZeYpRErfB7a0ASdE
         m7HFz2RUPYmHPYgA2LD1lZJMBjPBXDw9wih7r2M4UBufAu4R5QD9Dk5LZFIzrDS+Hltn
         kkcA==
X-Forwarded-Encrypted: i=1; AJvYcCUZQo/WLMLYZGZvtxDs/DCVcPKKwmRQ1HU55DruDia5N8kRRVNq8ogXt6w0oW0BMe4yr0oPLlHwmUTLaLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz2HZSe80ow5KN1ocYIOs8L5JaiMF33IF/BzbX2pJsKOgxcOEw
	mZjxTYtDP08tZ9CP8N6NUsCnK5pNKRUMzxpbIDtAEhTh7lp4uM12uoiYDDAMAwBG1GkcUzCSfzq
	ufUc5+QaBi8ZkdQ==
X-Google-Smtp-Source: AGHT+IFGmucGm31xquzCIdMPfx+iY6I4pvpkEGnfiBPJy7YBlidkxn1rhz3SbgkwfrscFWZRuiT3zZv9bZSaQQs=
X-Received: from wmbfl10.prod.google.com ([2002:a05:600c:b8a:b0:43c:f122:1874])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1f88:b0:399:6d6a:90d9 with SMTP id ffacd0b85a97d-39979586b74mr3303422f8f.18.1742478999908;
 Thu, 20 Mar 2025 06:56:39 -0700 (PDT)
Date: Thu, 20 Mar 2025 13:56:38 +0000
In-Reply-To: <Z9wHv-2HXfoYZFmk@pollux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250319203112.131959-1-dakr@kernel.org> <20250319203112.131959-2-dakr@kernel.org>
 <Z9vTDUnr-G4vmUqS@google.com> <CAH5fLggvFanUvysDkZiLqFz4Ay7XSP5LF3CvxBU3xgWE3PSZXQ@mail.gmail.com>
 <Z9wHv-2HXfoYZFmk@pollux>
Message-ID: <Z9wellJ7Rsm6Wvd-@google.com>
Subject: Re: [PATCH 1/4] rust: device: implement Device::parent()
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@kernel.org, tmgross@umich.edu, linux-pci@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 01:19:11PM +0100, Danilo Krummrich wrote:
> On Thu, Mar 20, 2025 at 09:40:45AM +0100, Alice Ryhl wrote:
> > On Thu, Mar 20, 2025 at 9:34=E2=80=AFAM Alice Ryhl <aliceryhl@google.co=
m> wrote:
> > >
> > > On Wed, Mar 19, 2025 at 09:30:25PM +0100, Danilo Krummrich wrote:
> > > > Device::parent() returns a reference to the device' parent device, =
if
> > > > any.
> > > >
> > > > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > > > ---
> > > >  rust/kernel/device.rs | 13 +++++++++++++
> > > >  1 file changed, 13 insertions(+)
> > > >
> > > > diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> > > > index 21b343a1dc4d..76b341441f3f 100644
> > > > --- a/rust/kernel/device.rs
> > > > +++ b/rust/kernel/device.rs
> > > > @@ -65,6 +65,19 @@ pub(crate) fn as_raw(&self) -> *mut bindings::de=
vice {
> > > >          self.0.get()
> > > >      }
> > > >
> > > > +    /// Returns a reference to the parent device, if any.
> > > > +    pub fn parent<'a>(&self) -> Option<&'a Self> {
> > > > +        // SAFETY: By the type invariant `self.as_raw()` is always=
 valid.
> > > > +        let parent =3D unsafe { *self.as_raw() }.parent;
> > >
> > > This means:
> > > 1. Copy the entire `struct device` onto the stack.
> > > 2. Read the `parent` field of the copy.
> > >
> > > Please write this instead to only read the `parent` field:
> > > let parent =3D unsafe { *self.as_raw().parent };
> >=20
> > Sorry I meant (*self.as_raw()).parent
>=20
> Good catch, thanks!=20

With that fixed you may add
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

