Return-Path: <linux-kernel+bounces-410829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1CA9CED0D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A7C1B2CB0B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEAA1CF5CE;
	Fri, 15 Nov 2024 14:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZclWJpIe"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6CF1CEE88
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 14:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731681672; cv=none; b=rIIsMwyipcWJc3dKEt6zwuiOvIPhbqayUewLVhytM8xseWBXxNSn++LyNycYC3GSeDQAMO2HRhhR0kbcl5KVajcUY1Iu52frGYEHFuqp6LL5dhlZjSCtxKJQSQttCACbn+iOT3/2rGlZ3tKW7zhLIhBhQYGBpcI5HlDmRqHtygA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731681672; c=relaxed/simple;
	bh=CRQn+tGQa6XbNRj3SOvuXE3AM/Uz3e4FZykxRrdWx1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TGQvJpMKvgmCc3WOhSdmMzkexw+aRKTj2MgTH2rsv1PjX8SS1Al9Ghs0pKS/162J9+m7YLm9rgqoaRvgqxDa2vYTvIk4+JbPucWSflSCkfDYI00PIBSvOg8IMyy3kurQ8wnkHzh9l9EovGSaJqTv4IJzCM9vuOHK8XR06VE1ub0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZclWJpIe; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-432d9b8558aso11845425e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 06:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731681669; x=1732286469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buXxOe83u3FgQFJ8o6x9jmB8gLX8VUgcHKKTNzyTu84=;
        b=ZclWJpIeqSMkeWiKhulBK+yeFG7YSobwnIBDlNNQ/3aoJqs6akNJcWCuvJiyHwcvXl
         85prXCFHC40tlT9oT2l3dQYuT/PW6BA5fNwPbu9Ij4PlVCF8ZUAJJJEZOvnf4TXDIZ+j
         ry3JRb8ShyQqVYfQVr78rA3ZqBkCAK+DqTaIfeJfuXWfEvviQ59Ra9fladQdoAjx7kJl
         z/1cYuPqFp/cnWSaEZ4xbkjm6fC5mEz/hw/hBW7Fn+kubDi72iDcCwTXMdURyzPq1tgo
         TlvdxPZx2qzQj7U/K9nIUVrmcDvOWlu0mlIhEQeM9ftoeLYxbtkaweYEry3z2foJ10uE
         rjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731681669; x=1732286469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=buXxOe83u3FgQFJ8o6x9jmB8gLX8VUgcHKKTNzyTu84=;
        b=Aplo3rKdWnGcGGoWq3MQ0CA64Aht2v4uzdVLz51DZqvRXIrnf4cudDhoN9sKA3IHEB
         dVtfNfjbYbCXUWJ2GkF4yjgtlpo1UBIP15wII2dztY2b1EsXXfwaQg9uzZZ2jKmPf2aE
         as1EoBuz4+LoXlWTsui8Zr/Pd9NFgvyzOUYLlTbTXnAJ+auihzXSqAthy/ra3GjiNX4U
         50lrl4vpeyJmGoGbdbsBwdpoE3ik0SM7EoR0SCLS4QmfAoMNw5u9OEg5eNH/RR0uyiZc
         segko6ndr7tNcZqa/EYlhOKiJIqe+pexhgZJavKu2K4jTt9M4Z+gI/d4LqeyAqig5/lN
         Wlwg==
X-Forwarded-Encrypted: i=1; AJvYcCUb23fjnrr4/dKWpflxmHhJsWzrQobJdkAds4vDtXE9EFpEDguN0K33GvOC38/GGbIbfY1Jb7L8u+3JPIs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqvVlfWAQ1v+D8gR9NGYKc6IzWNRnfg1eBXmo8NHzxbmeudfDK
	G4aSyJwVTUCPIpwCzK4BhiZBQx8TMy0+DHXv4h0H5pBaU1Kxt0kR2Lm+gJFnBNQO0d0qMpdPy5Q
	nUDiVhKzkkQUR8uFYDinccQz1O8ZoeJnozWXT
X-Google-Smtp-Source: AGHT+IE/0bNrpbw7OSn/X/f0vVquy7N3e9FpffUmeO+beNbCkBmxfrwSIlCUfcKFprzsVggnB0+Ec6ks+E8W2GbiM6w=
X-Received: by 2002:a5d:6d09:0:b0:381:d133:d541 with SMTP id
 ffacd0b85a97d-38213fff9fcmr7260515f8f.11.1731681669357; Fri, 15 Nov 2024
 06:41:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113-topic-panthor-rs-platform_io_support-v2-1-0dea1edc3a49@collabora.com>
 <1C6A62A2-B723-4066-9466-C3F0F9FB4B3F@collabora.com>
In-Reply-To: <1C6A62A2-B723-4066-9466-C3F0F9FB4B3F@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 15 Nov 2024 15:40:56 +0100
Message-ID: <CAH5fLgiCgoUQLgZcd-w_PGjtFHYdFxsBFezoaFeyZXnBxY3O=A@mail.gmail.com>
Subject: Re: [PATCH v2] rust: platform: add Io support
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Boris Brezillon <boris.brezillon@collabora.com>, 
	Rob Herring <robh@kernel.org>, Daniel Stone <daniels@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2024 at 8:43=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> Hi all, hopefully I did not butcher anything using b4 this time.
>
> See one question from me below.
>
> > On 13 Nov 2024, at 16:30, Daniel Almeida <daniel.almeida@collabora.com>=
 wrote:
> > +    pub(crate) fn resource(&self, resource: u32) -> Result<*mut bindin=
gs::resource> {
> > +        // SAFETY: By the type invariants, we know that `self.ptr` is =
non-null and valid.
> > +        let resource =3D unsafe {
> > +            bindings::platform_get_resource(self.as_raw(), bindings::I=
ORESOURCE_MEM, resource)
> > +        };
> > +        if !resource.is_null() {
> > +            Ok(resource)
> > +        } else {
> > +            Err(EINVAL)
> > +        }
> > +    }
> > }
>
> Should this return an immutable reference instead of a pointer?
>
> Once the pointer is known not to be null, I think it should. So far, this
> is the only place in the kernel crate calling `platform_get_resource`, so
> there would be no risk of breaking the reference rules and it would make
> the API more ergonomic to use.

You should never create references to bare C structs. If you want a
reference, you'll need to create a wrapper Rust type that uses Opaque
so that Rust's assumptions about references are not applied to the C
struct.

Since you're just passing it on to a C api that expects a raw pointer,
I would say keep the raw pointer. I wouldn't go for the wrapper struct
unless you expect this to be part of the API used by drivers.

Alice

