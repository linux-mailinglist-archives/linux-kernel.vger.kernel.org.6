Return-Path: <linux-kernel+bounces-537171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B77A488D2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1123A168B89
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 19:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9292A26F472;
	Thu, 27 Feb 2025 19:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VJamGVRo"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7135126E646
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 19:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740683778; cv=none; b=TmalinVIER5tUGh+xacKY4aX6eXZ2CRLYwQf52e9aet2P/zQ0U4gV747qMT5R/FeQnjiSIj/cqIquSe2vTRTd5ikq6X3LQB7NKteiqdPc9PYya1kjmBQu1EmxkAkKPNZntpoUVo5PYLL9CYwkI6pAz+YJ9pNYKezCHG3/MBBi20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740683778; c=relaxed/simple;
	bh=mwTHVN620TX5ESULnZIeej/5etZx+q0PaqdGdgEQqhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kFMoYzpX0S308kaN3XMrvZakEuumTxqHdFjgnssZ3gz4SRfaHzd54qZJvQb+5959hdwIjixN0Nsh0LqJhTWyidE/8P40n38CvyIO2F3nV93HCRfmXblDVy68fPPkZ424mlqBgdJJ5I5kTwvzB9z5oBEYwG/UfhF8XyxJd3bzaik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VJamGVRo; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abb7520028bso170521166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 11:16:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740683774; x=1741288574; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hvB+JZlfkgHPFuQYjc4Ck/8suSwxp4Qhz+OIGbF3Mns=;
        b=VJamGVRofapKArKnfwK4pZuQQHyrahXtO0AWjhgiEF8S7k1jmZ5TrRB/n489/mEnQD
         KI2fPr2VDiZP75FUxSC8pwsSu5biseqBjKw/ByNNXBoePX6xV5T7xxOAf8l74WMK2XOZ
         vZI/hk28gLlgQ34YFsOovVDOdwOYthq/RBQno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740683774; x=1741288574;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hvB+JZlfkgHPFuQYjc4Ck/8suSwxp4Qhz+OIGbF3Mns=;
        b=GGdd4gOcjW2LUdUifBvZ/x5komDGi3auhshqRlAiD/n4IpuqFOqVJ7rY9GwdZs+JNx
         64XwTYaD4AyM0F0oe6c1/g4dKtuly0Db9XNebQOXPB25PiwZ6SsimzXf6am5wMOfJW/i
         nQdBiujdSUXScCc98T1NAdkqSp9nEaTg6PMSXHn4EtuADJyIQx9NI+QL9Ykb2yRSHwND
         62pVG+xspVE1PEJHS1D6lwrYwSmfjwz9i4yzcG6OkMTcM99DuUJcJ0oS1OcdU7sYanG1
         HX+BtgVVef++46NohHaVmjA0RfzLI+9o5QgWWN1Te01wf0hyAnmr8TiBOFCjngYE7aUK
         UCDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj5J0WWejhemkjqczdQ5nBGWbBa2DvV6AWwLCZrm/Mb1OG/xMTo03AhW+tqJWtHGQnaGKIQFOQmO+FjW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGe88r6ghqdEy5L3Ysg0eXqBkdsZ/Y0mIaO1QkTqT8trC3XM1s
	OzE1m35y88X+pqPq1J2x8fw44/AJm0Q9h6b/o+Nae6AKvIbLj4Xx1497tsnZguPregC4zn/+Bh0
	BLdlNAw==
X-Gm-Gg: ASbGnctV2qAAkWjoE+ZvOWCTGLpKiPaIiqv94uAeoow5uHKHdFfr7/G27CXLBe9CbM7
	SNO75W7uYq//AQymLvGsetA8oZrM6gO2g3UvgIH9WXnzMiX6QLWqoZmKazc3rQTwMaXRfA727Kj
	vOiFmZQTJZnDgB0Mb6l+mJZtUwua9Ekk0CHFpA4dYp7+4WysyDz6BCKpcS1tdokzYKimho8rajj
	848HN6jLYfPevuH4fkLD2dROqVNMLjijRh3Z/Oog81/QVNTGkShYqF2OI50oUspuVG6P7udI3EM
	7PfLCBCB3oun0IAwv7gGfPTSmOBku3D+8ZinjvtxfT+jc7oiSUJS5LLUiO5+L5GBUhHTo/Y5p/u
	D
X-Google-Smtp-Source: AGHT+IGmTbnwm4TYkALS57lLj+kmD0jlHKdeeyWnwCQhOmE05oYTfoHsXD8qyiCgslCjOGSdYits7A==
X-Received: by 2002:a17:907:7e93:b0:abe:f84d:3fa with SMTP id a640c23a62f3a-abf265a2aeemr64374466b.38.1740683774452;
        Thu, 27 Feb 2025 11:16:14 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b6ce0csm1515168a12.24.2025.02.27.11.16.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 11:16:11 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e4ad1d67bdso1842183a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 11:16:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXXIWUdi62W89CkScy+voaeZWWZyDn5yJ7uzSzNvaZIcAzqtVFdDd63OHRCVSo0vWARuD7dhsBYpIOGMhg=@vger.kernel.org
X-Received: by 2002:a17:907:86ac:b0:ab6:df79:f577 with SMTP id
 a640c23a62f3a-abf25d945c1mr67115866b.9.1740683771357; Thu, 27 Feb 2025
 11:16:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
 <5d7363b0-785c-4101-8047-27cb7afb0364@ralfj.de> <CAHk-=wh=8sqvB-_TkwRnvL7jVA_xKbzsy9VH-GR93brSxTp60w@mail.gmail.com>
 <ed7ef66dbde453035117c3f2acb1daefa5bd19eb.camel@tugraz.at>
 <CAHk-=whLSWX=-5-z4Q8x1f_NLrHd0e3afbEwYPkkVSXj=xT-JQ@mail.gmail.com>
 <m4cbniqfsr5xpb2m7k53e7plc6he5ioyl2efiiftdmzod56usd@htwdppje6re5>
 <CAHk-=whEkEsGHWBMZ17v5=sq1uRe6g-BRHy5xNZK-2JBKRs=_A@mail.gmail.com> <0f3bc0e8-5111-4e2f-83b5-36b3aec0cbbd@ralfj.de>
In-Reply-To: <0f3bc0e8-5111-4e2f-83b5-36b3aec0cbbd@ralfj.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 27 Feb 2025 11:15:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj37zT4Fy+mBFVRKPy=NMKcB6xBzqOuFrW0jOTv8LKozg@mail.gmail.com>
X-Gm-Features: AQ5f1Jptz1SWwyUusZnRoigWvZHElhRRDe0KZ_mwrHUSOFHPo4sqdKCJh4Qdo6A
Message-ID: <CAHk-=wj37zT4Fy+mBFVRKPy=NMKcB6xBzqOuFrW0jOTv8LKozg@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Ralf Jung <post@ralfj.de>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Martin Uecker <uecker@tugraz.at>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Ventura Jack <venturajack85@gmail.com>, Gary Guo <gary@garyguo.net>, airlied@gmail.com, 
	boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, 
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Feb 2025 at 10:33, Ralf Jung <post@ralfj.de> wrote:
>
> The way you do global flags in Rust is like this:

Note that I was really talking mainly about the unsafe cases, an din
particular when interfacing with C code.

Also, honestly:

> FLAG.store(true, Ordering::SeqCst); // or release/acquire/relaxed

I suspect in reality it would be hidden as accessor functions, or
people just continue to write things in C.

Yes, I know all about the C++ memory ordering. It's not only a
standards mess, it's all very illegible code too.

             Linus

