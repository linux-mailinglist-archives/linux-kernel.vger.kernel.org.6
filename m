Return-Path: <linux-kernel+bounces-231636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F95919B0F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 01:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD05281792
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 23:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE4A1940B7;
	Wed, 26 Jun 2024 23:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTTxTeai"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3238017F500;
	Wed, 26 Jun 2024 23:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719443539; cv=none; b=dBqLukwmq/UwCdd6RplMSPAq6P3D42YF40ibJCqdzmi0rYSP2DLBZ8UewbtcnCLDLhYvwE9s/clcGqyTiEZdzmqrQ6toncC27t5y8cXD3L1yLKkPjvJp1JCnYdqR8zqi188rC97GALLyeuHeNOF5GyR6bvvV2eErnwFiPJtwiDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719443539; c=relaxed/simple;
	bh=4GKyJRbriZDSWmmAfGWWFVLD/7Izpes5/cuHDtbY+3w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=C7e35iGbQAAUn2pbxBP/qSJ9hihOO0dVVjviJ22td/eBOMKQ/sS1P7YcQ8SfUrsIS8lN4frJrxWv+Gn//IzNYh+jkkhKjRYqju4ZFf+f6yUn/CNLl7ioeG7mxDwFSvQrm9GU8FZeORuJhdrulJRtcrSNtFke/MQe8k/OwpXLsqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTTxTeai; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7ebdb5d9915so289777839f.1;
        Wed, 26 Jun 2024 16:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719443537; x=1720048337; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+dLKqOUQIO15v2wedZv+PanS34v5Ba1rpcC4Ppl39k=;
        b=mTTxTeaifhRVEAadSqyzZdoyRVlWJ3Y2PfSTTw8TSXHI/l1nsYiJww/Deua1l4sYiw
         sRc8q7MlCCax08N50RTAVyj+by7ji8A3pW0i1XMtG/JDbRhPQxVGGSi+9lJ4zkd5KP3b
         uQAgZqIsl7Ej2jTIO3Wx9b9vHs15PnoIHx9LFp5w7csfNpgSZmuTCMfiPI8ylXfSdIS1
         YsHTh06ItRhZCm00Mnxse9ZHhbaeexk22eGWFwpMv1vgndkqbC+OwevsY6jWiqzhS6DZ
         m3eN9xtRApAjIx8gZ1FZohkTaGw+bMO8/brCA6Y0CucNtv08LAz1+aScOpNm/kXVMS3X
         7sig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719443537; x=1720048337;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H+dLKqOUQIO15v2wedZv+PanS34v5Ba1rpcC4Ppl39k=;
        b=mDXmzUh3SSp2VQMXYU9OynFE//JmqDr62tLldGsrENXtPPofYphEgfDf0bVjPNac+U
         om5ybnhjYe/6XRXNeSA5zRXnhCRtPZh3nO6VZByfS0/W2LTVjHpBb1GoStDa1aiagrRw
         vcATHDi8RCpmskzgvjxfKediXWYqjfQuHtKUJZDFjkknIkCERvOzYIeEbuYOEsP1GgT8
         ZzplyptD5RW0jdaORXKSC7uAU4JW9yYFehQnkSW6BLnZhyJ5/Zn2QSWeDQVfNT2FQOm+
         Z5MIFvdlBs9uLjqTDhgarYScMwSVcGYLDXcSTnRFFrzhdoE7Nx5aJ7otW9n+PJGjzCbR
         rvxw==
X-Forwarded-Encrypted: i=1; AJvYcCUMV+FkWoQ5+AI8nIZjOyLKC+vT17ddNKPd8o7JCP5/pYT7RgObHJMLmPbdz2PlKhe2++pt0JasklhUobjBoz6RG0wkfBT7fQHlaPjZeE8s51AJzeOLj/kNi0qw5uoLB+JOPYHnNgIDBTP1F9M=
X-Gm-Message-State: AOJu0YzR8bvDX7+KZww3StgPFp3OgSpEBOoVE/8trJH4wN6btDCMxYOu
	9+MFLc0CAkujRPn/O+jia2xtlVc1EIFIDjL6SF3HJqGcDeHCECu1
X-Google-Smtp-Source: AGHT+IEBHSJGz6boj0CWevE1gGRJYHtizY0rFRoXz6Dk7/aSElmAQBf/FTVSoyQQlm29XBPvbPE4Rg==
X-Received: by 2002:a05:6602:6d84:b0:7f3:9bde:f44 with SMTP id ca18e2360f4ac-7f3a7539bebmr1553552839f.14.1719443537127;
        Wed, 26 Jun 2024 16:12:17 -0700 (PDT)
Received: from localhost (h135-131-130-199.ashwwi.broadband.dynamic.tds.net. [135.131.130.199])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-7f45441ef4bsm2899839f.14.2024.06.26.16.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 16:12:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Jun 2024 18:12:13 -0500
Message-Id: <D2ABV2QS6XKA.JBN6A5LT4339@gmail.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Wedson Almeida Filho" <wedsonaf@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <benno.lossin@proton.me>, "Andreas Hindborg" <a.hindborg@samsung.com>,
 "Martin Rodriguez Reboredo" <yakoyoku@gmail.com>, "Trevor Gross"
 <tmgross@umich.edu>, "Aswin Unnikrishnan" <aswinunni01@gmail.com>, "open
 list:RUST" <rust-for-linux@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] rust: macros: Enable the rest of the tests
From: "Ethan D. Twardy" <ethan.twardy@gmail.com>
To: "Alice Ryhl" <aliceryhl@google.com>
X-Mailer: aerc 9999
References: <20240624030327.90301-1-ethan.twardy@gmail.com>
 <20240624030327.90301-5-ethan.twardy@gmail.com>
 <CAH5fLgjgMxZ5S-wLqu6pOz=HzrV6qJGe5N=2rrYNvo3uVPbVbA@mail.gmail.com>
In-Reply-To: <CAH5fLgjgMxZ5S-wLqu6pOz=HzrV6qJGe5N=2rrYNvo3uVPbVbA@mail.gmail.com>

On Mon Jun 24, 2024 at 3:47 AM CDT, Alice Ryhl wrote:
> On Mon, Jun 24, 2024 at 5:04=E2=80=AFAM Ethan D. Twardy <ethan.twardy@gma=
il.com> wrote:
> >
> > Now that the rusttest target for the macros crate is compiled with the
> > kernel crate as a dependency, the rest of the rustdoc tests can be
> > enabled.
> >
> > Signed-off-by: Ethan D. Twardy <ethan.twardy@gmail.com>
> >
> > diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> > index 8afed8facb21..6d764099563b 100644
> > --- a/rust/macros/lib.rs
> > +++ b/rust/macros/lib.rs
> > @@ -102,7 +102,9 @@ pub fn module(ts: TokenStream) -> TokenStream {
> >  ///
> >  /// # Examples
> >  ///
> > -/// ```ignore
> > +/// ```rust
> > +/// # #[macro_use] extern crate macros;
> > +/// # #[macro_use] extern crate kernel;
>
> You also added these lines in patch 2, but you did not make them hidden t=
here.
>

I made these hidden in patch 2, since I would not expect them to be
necessary in normal kernel code. Please let me know if that's not the
case!

> The empty line above this import should probably be removed to improve
> how this is rendered.

And

> I'm pretty sure `#[pin_data]` is in our prelude and doesn't need an
> import in normal code. If it needs an import in the test, then please
> add a hidden import rather than using the full path.

Will also land in v2. Thank you very much for your time in reviewing
this patch series! Did you intend to offer your Reviewed-by signoff for
this patch (4/4) as well?

Ethan

