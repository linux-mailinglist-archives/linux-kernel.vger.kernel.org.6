Return-Path: <linux-kernel+bounces-353455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFA7992E0A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D39EB238E7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 13:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6A01D5AA1;
	Mon,  7 Oct 2024 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HN4vAl2g"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F136018BB98
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 13:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728309563; cv=none; b=ltP7S8BLO8x1sHLiS/X3xrfBqxTgm3eNGBqdGZtF721Oref9vOy2MrE8nMPf1OA0QlbbzMZD/Y7cdCcbgUcNtpmowcbAhgd+4TZB2FYnRPaiiczEnIlodIv/Acsw1eqm/K0V1THIZltmOgyzDUuGYGiVm2mhCBhruJTRrTxNeNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728309563; c=relaxed/simple;
	bh=xc/x30uf9iyb5xezbKYekNH++PSzPkxlm8mpT+Naf5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMdPrBlXnzSmRiJZ1R2IgUkau3r11SKqPqd2J3vNoTHqxWsHyt4OTFcJ9hrmD/EabkPRngfYyDxV6tPtLbARXwSF5SE8YMEmqsFQDMz30fRiomb/J73udawcnouTy8CMDk7rqKsry2CVsI4tjaPejOUacsvigP22DkHdobstPow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HN4vAl2g; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37ccdc0d7f6so2906310f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 06:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728309560; x=1728914360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xc/x30uf9iyb5xezbKYekNH++PSzPkxlm8mpT+Naf5M=;
        b=HN4vAl2g+LwuAJFMU+IXfMWdo5Im20EHErQ2uFXinS4Z/EJxbZyYkTU+ojlXXztFDi
         LpXMkFdZXwRLpbQv1hTCCWOodCmk+ASEEasAG7D0IKIov9efxR3ZChlsG9eSz150OjjX
         Lf12nL8wXDLKhKnpczBVdmA1a2uAA6PL9mLoAk7WKyxvYtVJ1lbJds95sgYYjxHgTVFW
         /Y48FRknMfpfhQtfDTeHax2SvumuKW8UvPD5r6S/YKCzhml40tbv/dUBCIpBMAGBAiMa
         VmSgToCfuIaQ8IWDGCCoVRjtSKG4TIWbb1KvrJ6vCYwNKnkv7sW4qi6vD4/pYhDrpI2o
         KSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728309560; x=1728914360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xc/x30uf9iyb5xezbKYekNH++PSzPkxlm8mpT+Naf5M=;
        b=oSFCC9SzBQ0GhgGRLqQJSuujRooHgbRXADV3yjRyZ1Xxx+aycnHGVJKK1yfcBTcsHG
         ejxNkkPXie8OdzeNJEoXhi8PLzxOyn9wXzpJQgeodfN1q8KDvOmoSEX6tiC1mLn9ppn+
         ot3c8KAXrnAJQTYH+Ia91OiJHnbn4ZZGgGkZRYC9PvrVWTul0H5+EWWTjC22Ywzyubxi
         Z9d7/qTgRtWsYFZyNjhD180wsxVtJpVq9VJnVrdTGNc9RygWc4d62ncF+pWmWlOIrdSU
         gD3b4eyGNL7z6ZDg6F52fToGeFrC0mlgfsQr9Mea7H9b2vKf1kShdUdzcukhyO1qvXlO
         QjMA==
X-Forwarded-Encrypted: i=1; AJvYcCVJGlNX3nZ1GyUQQikSwW7HkizL8+HkPxvFAlVXY7zEXVdOiapWxWSohMk/k0sWl2k7jw1LRoEZJ1+IJko=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr4ulO65/eGXozPeNGk2OXG/iK5WGJKWgkJvw+WWk0psVM071Y
	IKSgtTobBydLWdxL359c9A7RQYYAsEI4w3hBjRdHb1wrGu02L3HOuRihc72ztxMg8LKNvo21vCY
	vW08P5gonTU/QpU5sjb+JAbRqPOsVddBU5Cbd
X-Google-Smtp-Source: AGHT+IEt/ppds1p51xP37UM+hKVF1KH288oFeowg/BwHOg7VYcXokM6av1Qx8ie/tkzTdafDoXlV9Nm6Gj+c3Vp38l4=
X-Received: by 2002:a5d:5e04:0:b0:37c:c5c4:627 with SMTP id
 ffacd0b85a97d-37d1902b4a7mr4418321f8f.5.1728309560112; Mon, 07 Oct 2024
 06:59:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
 <20241005122531.20298-2-fujita.tomonori@gmail.com> <3D24A2BA-E6CC-4B82-95EF-DE341C7C665B@kloenk.dev>
 <20241007.143707.787219256158321665.fujita.tomonori@gmail.com>
 <CAH5fLgirPLNMXnqJBuGhpuoj+s32FAS=e3MGgpoeSbkfxxjjLQ@mail.gmail.com> <f31d6f3e-e53c-4ced-920a-976ac44235e9@lunn.ch>
In-Reply-To: <f31d6f3e-e53c-4ced-920a-976ac44235e9@lunn.ch>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 7 Oct 2024 15:59:07 +0200
Message-ID: <CAH5fLghaLTMFS18cdjY6ntQ8BE85APjG71F1MvEEhxG667HU4A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/6] rust: time: Implement PartialEq and
 PartialOrd for Ktime
To: Andrew Lunn <andrew@lunn.ch>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, finn@kloenk.dev, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, hkallweit1@gmail.com, tmgross@umich.edu, 
	ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de, 
	arnd@arndb.de, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 3:16=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Oct 07, 2024 at 10:41:23AM +0200, Alice Ryhl wrote:
> > On Mon, Oct 7, 2024 at 7:37=E2=80=AFAM FUJITA Tomonori
> > <fujita.tomonori@gmail.com> wrote:
> > >
> > > On Sun, 06 Oct 2024 12:28:59 +0200
> > > Fiona Behrens <finn@kloenk.dev> wrote:
> > >
> > > >> Implement PartialEq and PartialOrd trait for Ktime by using C's
> > > >> ktime_compare function so two Ktime instances can be compared to
> > > >> determine whether a timeout is met or not.
> > > >
> > > > Why is this only PartialEq/PartialOrd? Could we either document why=
 or implement Eq/Ord as well?
> > >
> > > Because what we need to do is comparing two Ktime instances so we
> > > don't need them?
> >
> > When you implement PartialEq without Eq, you are telling the reader
> > that this is a weird type such as floats where there exists values
> > that are not equal to themselves. That's not the case here, so don't
> > confuse the reader by leaving out `Eq`.
>
> This might be one of those areas where there needs to be a difference
> between C and Rust in terms of kernel rules. For C, there would need
> to be a user. Here you seem to be saying the type system needs it, for
> the type to be meaningful, even if there is no user?
>
> Without Eq, would the compiler complain on an =3D=3D operation, saying it
> is not a valid operation? Is there a clear difference between nobody
> has implemented this yet, vs such an operation is impossible, such as
> your float example?

Think of it this way: I wrote an implementation of something that
works in situations A and B, but I only use it in situation A. Must I
write my program in a way to make it impossible to use it in situation
B? That's how I see this case. Implementing Eq does not involve adding
any new functions.

Alice

