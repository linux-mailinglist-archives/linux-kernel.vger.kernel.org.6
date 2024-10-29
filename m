Return-Path: <linux-kernel+bounces-387735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F169B557D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 23:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54F2E2844A3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 22:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E09F20A5E9;
	Tue, 29 Oct 2024 22:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMFyeXJZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FAE19258A;
	Tue, 29 Oct 2024 22:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730239519; cv=none; b=QTEiJF1PpINbLT+wKhnPFpDYxwFcl/IvGIMe0ZyTmKN1MM6OA5epoYmntafxee+lttp9yDKdV3ShPRz59Ul1Nx3elqvSfwku6LigW28O+pFVAOhb1iJF0gDQP6Wv5DzfJrReAnzyvrucDxHemZrW61vi+BxIKgJHhdDFMwOWYmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730239519; c=relaxed/simple;
	bh=b+Of7JcGeC3skIrmLLK4p7ozqvNbmgH2dzZduBMvINM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dRdR8HVdnkWCkWlysaoY4WIbJsPJ3kebvt2Yk+hIUHgPgUEClovIOCDedrWUv+mZgm0aZyugrfz9R6XiRZHjDHGud4Hv8iksdKzZyvQ4Bg576rE1eJaGc0hpe2fjAkY6+5CDJbgXyBYQTJ9P/VmIxCjmTUeDsDTFn7ZPeyZVF0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMFyeXJZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D83C4CEEA;
	Tue, 29 Oct 2024 22:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730239519;
	bh=b+Of7JcGeC3skIrmLLK4p7ozqvNbmgH2dzZduBMvINM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=kMFyeXJZBo3amamZ1Ir9fiXWCZ6eiytuHw9eS0J1Ff8swXXPo9oq/SA37wq86Y577
	 kElOEt+OXfGUQ2wD8GCjE5hR51xjjbsX0IJ8liu0nRq/5E2haWMI5pze2AI8slzoST
	 C10KKFtuysCriVVaQWT5z415AXZn4OY9T79y0ya96p17f99kbyIDCENEEIVyWlMrca
	 +WQzWad0DvSh5bLmXwpH08Foe+oG0BtIed/j+cvomAyEDhaByj6uPXcLZtiz50Eppp
	 OMFpHIu/8H7cGHe0wW5ELsUS81eE4zASTClH0I71IUhSXvQO+h4UJcHXS/fhVBr8y8
	 o/YXrSET1lpfw==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53a097aa3daso5352832e87.1;
        Tue, 29 Oct 2024 15:05:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUTTNAZ/Xl1guO535yQlFAzGo/zY2aCsAM1g2kK42lLsZaVDPz2Ltmq+osXYLTeZQX4r62GdoEcnmkkthzh@vger.kernel.org, AJvYcCUlGuLQxVmS17DdeZRANHqIZvo/AP8zTdhzJYodtM4BYEXI6j0+kgASu0Btk9e4m+a7PQ7wDHxlGsUcneU3tDE=@vger.kernel.org, AJvYcCWw4fVqe07cCG3BHERhUn/v6FuXAsh/bYn/IrgI3rj7eCL4+gLnQglVb7hM1YglchI+lA+ZfYywdsiK@vger.kernel.org
X-Gm-Message-State: AOJu0YzL9xxvaOTSvjPJg1BmzIVhlbHSp5DWFdc832AifMTllKPM+FUy
	AGc4eH+ockKK3HnlHy5adxw1J5YommxvQWA/cVO4xsf2jcaji73azL5P5ruPDT4yeZsKGkITiTY
	+wkZDkbboX8SqfOM+9RgQMXId5w==
X-Google-Smtp-Source: AGHT+IEQ02iTfp8ULaZCkBneArzinJgz8DScDxSpVSAKopsUNjt1QaWeoc/57kRNcOtrMdgR9Hco7zAUx977s8cVsCE=
X-Received: by 2002:a05:6512:3b1f:b0:52e:987f:cfc6 with SMTP id
 2adb3069b0e04-53b34a321bcmr6887718e87.51.1730239517338; Tue, 29 Oct 2024
 15:05:17 -0700 (PDT)
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
 <CANiq72kaidDJ=81+kibMNr9jNxg467HjOm9C_4G7WRvaiddGvg@mail.gmail.com> <CAL_Jsq+T6T_3p2C62U3v4aSjm_oc-Ycjxi_ckF0ufh=JJDz=rg@mail.gmail.com>
In-Reply-To: <CAL_Jsq+T6T_3p2C62U3v4aSjm_oc-Ycjxi_ckF0ufh=JJDz=rg@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 29 Oct 2024 17:05:04 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+PYtRR2T2ShPyC0Ae3P0FnzKKPr1uK=QG0hVmPUV=PVg@mail.gmail.com>
Message-ID: <CAL_Jsq+PYtRR2T2ShPyC0Ae3P0FnzKKPr1uK=QG0hVmPUV=PVg@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] rust: Add bindings for device properties
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Saravana Kannan <saravanak@google.com>, 
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

On Tue, Oct 29, 2024 at 2:35=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Tue, Oct 29, 2024 at 1:57=E2=80=AFPM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > On Tue, Oct 29, 2024 at 7:48=E2=80=AFPM Alice Ryhl <aliceryhl@google.co=
m> wrote:
> > >
> > > One option is to define a trait for integers:
>
> Yeah, but that doesn't feel like something I should do here. I imagine
> other things might need the same thing. Perhaps the bindings for
> readb/readw/readl for example. And essentially the crate:num already
> has the trait I need. Shouldn't the kernel mirror that? I recall
> seeing some topic of including crates in the kernel?

Looking a bit closer at FromBytes, that's almost what I need. I'm not
worried if it also includes usize and isize. However, since the trait
also is provided for arrays/slices, the following happens to work:

let prop: [i16; 4] =3D dev.property_read(c_str!("test,i16-array"))?;

Which is a typo meant to be:

let prop: [i16; 4] =3D dev.property_read_array(c_str!("test,i16-array"))?;

And it doesn't really work. It reads all the data, but reads it as a
u64 (DT data is BE), so the order is wrong.

And now my dreams of "if it compiles, it works" are shattered. ;)

Rob

