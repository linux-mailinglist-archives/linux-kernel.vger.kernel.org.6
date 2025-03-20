Return-Path: <linux-kernel+bounces-569335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E76A6A194
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 819213AEA6F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B93214226;
	Thu, 20 Mar 2025 08:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hU/AGhG4"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D0A2063DF
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742460060; cv=none; b=O+E0urb6OZgfj09cnxqOyizQF3fSdaN1n4/V7Aosm5TmtydwbrEzpxIGTkVLJgMmXR2/wARsmm/vOmZvrVknfVdjMgPuCbxkShSHUYeTr5diLV7QoRk5OMsPBiX/46x7hfEe5foR5cU35PG1yphNQ/v9ifMzIbEfkSdCKFgtXFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742460060; c=relaxed/simple;
	bh=+JphUaWBHj8e5Dy/goJmtvqb5JUUBJCl4r3rVDM3IPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gHusMJ13MYXSs0OUEVom44bBb+zbjOz+OGCT5bpCAmna26L/ZHoXJXdI9ju4nmAqsZpXmgU6G76w6Pn1MNM199F0fvfleT1vxBoSAQt50UPbuD1ARdj0j7QemPZtXjYm5DMoTiYpzp2mmtdluucmCAKOQga3EsTFsSeF4Cpgyrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hU/AGhG4; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so2351515e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 01:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742460057; x=1743064857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joq+AsBCw/cRk0tuewc3GK3q7weyXB1E25fHZd+BIYo=;
        b=hU/AGhG4T8sfg+24Pousp30rYI0FbaMiskQArGxpHf+g1TudUs/L8024Un1VEGseHw
         bJqrycXf7yb+lPA/TDFGLkn/E1SD5oK+yn4vzh717+bHJNi78VrXbFbqZLK3rtetlKaP
         UPsbFgruL6ZNQMIAx1yV4A98ckzuU56F2aUNVlO1asxz9jPqCwAQzLn54T94eGjh3sJf
         vV8m3TpHwfQsP9m2150Sv8zrD7ezOxV1/gwBnHp0L9sLG0RysSXKbpsaAfX5xrPlm6iP
         SHEqtIl9ZEzMUH2cXqmoaDXKViEEAODiYT28czcC9Hrl0vKMx1nB1leA3FKQ9FaD0TQ/
         rJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742460057; x=1743064857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=joq+AsBCw/cRk0tuewc3GK3q7weyXB1E25fHZd+BIYo=;
        b=Mq9pgHK6PYJuGNrnVqygKamyB36eVmXYX4kRrtlyNrUN080fmv0T7lV64ldkB8rddG
         BwOa1hE2HJYnp/Fn4AN8CtWj3b09i7TBZ/q1TQGHfEQZOd27mHK4WZIHgK8AA0yC8S1+
         uQV4PeToX25sB996lcFCUQRvECi/rfOjWBmcf6+ao61NaP7+X+oB0JHy1RKHiSlRNCLG
         EHeJ/ISg4oWZYy2CC0SrnTqI0Xgl/Nb45AgUlXPz3sj9+z2LTlYkZiouHHfu/8UOUQ60
         baFvQ4I7kw595yIUWTbbyChvjSPjvKq7DyFnGrhtNeBkUgp2OGk942Yp7wZAbLmhOEO2
         jOtA==
X-Forwarded-Encrypted: i=1; AJvYcCUOj1qt06VjbtoLSwTzTGQaKyWggiZbE7t6hpY7cxMavyf/aW8R+RLf8hmrolQZzljJHu3eN1Hv1McP08A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlviqXsTj4LLZzJht7sMQ+sgWJPTBoREkn4sk09I8FHApVyetl
	iKhvrOpqQFqtM7cI56i4We9v79AUylgspgkx32FOdK87PDYZiV81DWXdVtcCFI5aESXHMfdfKsL
	yJh8cZYaJbPnhBpFjgYHxdOatdt4NM3KObTsx
X-Gm-Gg: ASbGncs2cAzOWlQ8EkRObpOM5mxkuwcO+v+VBLqLI8xPVi53YZZOVgOE/UDvOcZx3Hx
	iEfnZuYAJoTsscPK9H5/WY0/9gnQDlCQ+/7ezpN0TU18PrUZdAY5uD+8CE3Ja6TZQMWFYgBAvKk
	BwUWv9YNTc4wWBhlxpbOI7vxOhLXA=
X-Google-Smtp-Source: AGHT+IGYRoX+7Vs588yGWmq8/C3g+/34z1UTJnjq4uAIISiLs6lNMbMTr8uEmsIxn9Cs0JCzmBgJuVwG12+9/NJjvT0=
X-Received: by 2002:a05:600c:3b20:b0:43c:fd1b:d6d6 with SMTP id
 5b1f17b1804b1-43d43842e8bmr48239855e9.31.1742460056723; Thu, 20 Mar 2025
 01:40:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319203112.131959-1-dakr@kernel.org> <20250319203112.131959-2-dakr@kernel.org>
 <Z9vTDUnr-G4vmUqS@google.com>
In-Reply-To: <Z9vTDUnr-G4vmUqS@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 20 Mar 2025 09:40:45 +0100
X-Gm-Features: AQ5f1JoNNdmHyOEpMkchf2aXocskZ-uhSkAZrFXKySPwesw-HUObFmlhnFttP6w
Message-ID: <CAH5fLggvFanUvysDkZiLqFz4Ay7XSP5LF3CvxBU3xgWE3PSZXQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] rust: device: implement Device::parent()
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@kernel.org, tmgross@umich.edu, linux-pci@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 9:34=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Wed, Mar 19, 2025 at 09:30:25PM +0100, Danilo Krummrich wrote:
> > Device::parent() returns a reference to the device' parent device, if
> > any.
> >
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  rust/kernel/device.rs | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> > index 21b343a1dc4d..76b341441f3f 100644
> > --- a/rust/kernel/device.rs
> > +++ b/rust/kernel/device.rs
> > @@ -65,6 +65,19 @@ pub(crate) fn as_raw(&self) -> *mut bindings::device=
 {
> >          self.0.get()
> >      }
> >
> > +    /// Returns a reference to the parent device, if any.
> > +    pub fn parent<'a>(&self) -> Option<&'a Self> {
> > +        // SAFETY: By the type invariant `self.as_raw()` is always val=
id.
> > +        let parent =3D unsafe { *self.as_raw() }.parent;
>
> This means:
> 1. Copy the entire `struct device` onto the stack.
> 2. Read the `parent` field of the copy.
>
> Please write this instead to only read the `parent` field:
> let parent =3D unsafe { *self.as_raw().parent };

Sorry I meant (*self.as_raw()).parent

