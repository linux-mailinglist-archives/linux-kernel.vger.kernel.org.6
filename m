Return-Path: <linux-kernel+bounces-388300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 912109B5D62
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 09:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ED8F1F21EB8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 08:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C9C1990B3;
	Wed, 30 Oct 2024 08:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q/EMnEqP"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF1C1E0DCE
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 08:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730275776; cv=none; b=PBc55UXfn3RGI3P/Yoskg4uL9JOaiBcfYfnulOHA/tml7btRS2imHahjpGx/DRFGzPjLzCK2KQ12d04YSbS/qEbT/gnIZWikL8J7uuLdOm5/L0WNMYSJVSDUP5bRit6eUwqbUtXiMzDIfB1dvYkrGFxJWGDpcZgEGXLqptwnP9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730275776; c=relaxed/simple;
	bh=+kVSzx9rf4BIG7BfgSll1dC+VOkG6fik/owXU9ICoG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3gqBuEeGOoem0w9Sjie1kvBnLusAiRyoywGEVE5ITwa9u7J3A4h4pcl1odhBYbGUK/h4U1iEnPQr3JPJnlsiN4N9Wj5x2BPB7YY3kz4qJ71qWVQZY0kBRHndYK4rJPXiAM06hQq6P1Zlq/nYm0pLedWjnKfiY9bHu4LyIcsj+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q/EMnEqP; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43161e7bb25so59025105e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 01:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730275773; x=1730880573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+kVSzx9rf4BIG7BfgSll1dC+VOkG6fik/owXU9ICoG4=;
        b=q/EMnEqPFZUZV/gEDBmi998tbHUDIBDjB29VJ5eQeCB1i4+TxHBJmsUom0zgPXkHeu
         039vVD+15aUVSPij3pKtNhn3r9XK6y3cCO1DhRxUFTj5fVquBo08ixr9cUpe2/oAQ1Ee
         mBHTkf2CN86fsz+sO4C8Z6LhJk6DM9i4Yfkmk5ZBFrish8WCWkrmIEc+QTQUKrSScBD/
         ug7kTq2KAZZPxU+35LrS/AVDlqW8f4qIZvqy5eEVJMmT4VgpRtoHLniqg0cTcK/TU9WX
         U6O60ygRLcLy7EChrMAFggTQ+qXUyGAb9LO2ZtDlRQjj2NU3Wwehg49LzfrufBHGUiXn
         Ri+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730275773; x=1730880573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+kVSzx9rf4BIG7BfgSll1dC+VOkG6fik/owXU9ICoG4=;
        b=cEk6I4vD7Y/PI7yCIzDaVuqsahjAQFRBT72yNx4o+qwGyQoirNIjaPHgMtnR/pJm5t
         SkB+GnYXWKauBARKLuJyVyOrlOxCRuPvcBJOWl9gVGUCCKqhFvo7AKv8f2BFzw5/CQey
         Z+QreMXTp900HuP9LnrSJUvloCnSfSzhI3qhWhc6yqTb5N76LSiBNhaDyVBTOiQGDlqx
         SXoNiOhCJcNM74BXwxA/mgwpoyAOjYzxSXwXLB1b77OpQvxhoTuRCIYGrp1clrflUb2u
         XfPtM7H/J1sSRuAL8fNb+gRwETtzNUzMR9VCR3qTQpYzvnBOZdzSRUq34838eDGhNUSd
         +E1Q==
X-Forwarded-Encrypted: i=1; AJvYcCW39Es3XyV8oxoE3YdEFQ/RC8WX6eYMqDezG80McxCpaQYNWh2fC55xgL+IubDvfIAdsBqPMlgG6hWtNNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCcv+5MOsuq6VCVVp3Nc0TaY3s9cD7SHsAJtf29h1Y5ojPUqe5
	eML7M9X6F2TN3PdZN4dVcT9Nd0/ynR2pJYu/xERscNcO4QxMO6dvDIBzp1rPzWBz1AH0zBI4XCL
	Ps85pwxBHiLaVXT7YPOs7gyvR8w8XDLV06qA6
X-Google-Smtp-Source: AGHT+IFKM7cBceg79DhIJpxYNbilbjqWxqPxFbnvkwCq6F8IMzAmrdLoK45koFerLCKZMqJgFqe+f8/8Mxyt4nqaq3g=
X-Received: by 2002:a5d:4d03:0:b0:37c:d225:6d33 with SMTP id
 ffacd0b85a97d-381b710f718mr1739159f8f.55.1730275772880; Wed, 30 Oct 2024
 01:09:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025-rust-platform-dev-v1-0-0df8dcf7c20b@kernel.org>
 <20241025-rust-platform-dev-v1-2-0df8dcf7c20b@kernel.org> <CAH5fLgjhiLUYPgTt_Ks+L-zhWaQG5-Yjm-Y3tfh2b2+PzT=bLg@mail.gmail.com>
 <CAL_JsqJWPR-Q=vsxSvD7V9_v=+om5mRuW9yYNqfavVRUwH9JFw@mail.gmail.com>
 <CAH5fLgiXPZqKpWSSNdx-Ww-E9h2tOLcF3_8Y4C_JQ0eU8EMwFw@mail.gmail.com>
 <CANiq72kaidDJ=81+kibMNr9jNxg467HjOm9C_4G7WRvaiddGvg@mail.gmail.com>
 <CAL_Jsq+T6T_3p2C62U3v4aSjm_oc-Ycjxi_ckF0ufh=JJDz=rg@mail.gmail.com> <CAL_Jsq+PYtRR2T2ShPyC0Ae3P0FnzKKPr1uK=QG0hVmPUV=PVg@mail.gmail.com>
In-Reply-To: <CAL_Jsq+PYtRR2T2ShPyC0Ae3P0FnzKKPr1uK=QG0hVmPUV=PVg@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 30 Oct 2024 09:09:20 +0100
Message-ID: <CAH5fLgjyOMa_pVW1fLP8MR1E-=xF-qL2F4_NT42+y7tP9za2Xw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] rust: Add bindings for device properties
To: Rob Herring <robh@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Saravana Kannan <saravanak@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Dirk Behme <dirk.behme@gmail.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 11:05=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:
>
> On Tue, Oct 29, 2024 at 2:35=E2=80=AFPM Rob Herring <robh@kernel.org> wro=
te:
> >
> > On Tue, Oct 29, 2024 at 1:57=E2=80=AFPM Miguel Ojeda
> > <miguel.ojeda.sandonis@gmail.com> wrote:
> > >
> > > On Tue, Oct 29, 2024 at 7:48=E2=80=AFPM Alice Ryhl <aliceryhl@google.=
com> wrote:
> > > >
> > > > One option is to define a trait for integers:
> >
> > Yeah, but that doesn't feel like something I should do here. I imagine
> > other things might need the same thing. Perhaps the bindings for
> > readb/readw/readl for example. And essentially the crate:num already
> > has the trait I need. Shouldn't the kernel mirror that? I recall
> > seeing some topic of including crates in the kernel?
>
> Looking a bit closer at FromBytes, that's almost what I need. I'm not
> worried if it also includes usize and isize. However, since the trait
> also is provided for arrays/slices, the following happens to work:
>
> let prop: [i16; 4] =3D dev.property_read(c_str!("test,i16-array"))?;
>
> Which is a typo meant to be:
>
> let prop: [i16; 4] =3D dev.property_read_array(c_str!("test,i16-array"))?=
;
>
> And it doesn't really work. It reads all the data, but reads it as a
> u64 (DT data is BE), so the order is wrong.
>
> And now my dreams of "if it compiles, it works" are shattered. ;)

It sounds like FromBytes isn't the right way to go, then.

Alice

