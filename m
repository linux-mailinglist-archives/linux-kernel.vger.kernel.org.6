Return-Path: <linux-kernel+bounces-527615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BE9A40D51
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 08:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C6E517BFF5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 07:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD371FCCE8;
	Sun, 23 Feb 2025 07:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUGHWHm9"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA76C1DC9AF;
	Sun, 23 Feb 2025 07:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740297488; cv=none; b=aoj8rfvIag0HXnf2f/E2dENP8ebOJ19aIX0KF+xzU5scIpSlDmBNhxy/Rx9535L+nvP0/UbxXbg7wNN+5gO6Q88OZH1is7cX4xHsyFyWJXeNNCCf24ypDdX1bErfzPFUQkLABaHKKD+m9k430vlUi5cpu8WgS6bDe0CQxO6HC4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740297488; c=relaxed/simple;
	bh=JGuyvEO6R/HQ2DuPCc5PL3oBVsGn1Pv8/PP5OiaosRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ru6dWplV3pn81JnXeA86IUG8a1nJ4NH+46ifDIVbKrO1pcdprTTS+UMQ3xhbaQT10rqWQ0cfbWYbZofG6WCiuGTarUEs7UzJeR26LjvU6cJIFxEDCd+67jxmH0xqLuv+wvfh4Feno8kGJYPIpYhmSfFrcYp7qwc8Gdr28sJCBMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUGHWHm9; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6dcd4f1aaccso51486726d6.2;
        Sat, 22 Feb 2025 23:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740297486; x=1740902286; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=o0QdejD+oneh8hE0bM2yPw/7xvIvOqg1wx5CkyU7zNE=;
        b=OUGHWHm9ewTNbGMBNSgz+DP090uLi6J9WIz+zaFQIDtHYdyKysPSQodQ9IegPwk5ZF
         7gIJtiOnpjP7KivHrl/5Tz1H1WdR9bEt0mOui+YHCKuww0dUT8aUzifLCfiS20KsazDD
         dX0bcLiV8NnC7CEV31XlAXohKGrehV8yhDTXyjZsMpj6M3XrrBsVC2Ng2TKZ23s3Q9lX
         y/qifSSbJhWVcHw11F5D79xshiuKBQ889iK6w1SeHU8+nae8APTyHh7Zsf0D6JW0uhlv
         68rwTC33JWEWK+Rh3SvWaCXO5RgcWWSDwrEw+1iApOFMRcGUA3SEYZuA+1yfLO8r4W3Q
         HjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740297486; x=1740902286;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o0QdejD+oneh8hE0bM2yPw/7xvIvOqg1wx5CkyU7zNE=;
        b=rRSRFPhlJqD7BU5+z/KzYVieN9WPWBEtnlQO2NaFANX7rS8BcbPbTcGt0khQBFbM1l
         JubVT7yoL15rSLGmEgyiqMHdCpScxawqm7Zu6IFe6zAaej7LeO8ibtkJ9jQhlP7fHFpn
         khfMVX3+e9GnjAdpWIJ1U7HhDNuGJpT7d+jv0NcqCiV5GJaFEVSEAmNIaKevJM/tsyQj
         iKI1hV8MD7fh/NGRX99CotiMKd0SF1wsBKKmayEOM0taM8HVA1V7azmdiEeC3f3W0JdT
         0IllKaEBE6YeBaPGAt+B3HL3Cpb3CBMbY7F3dHtfL3NtiGN0OycBnIdrdSfqeX03dEM/
         +zqA==
X-Forwarded-Encrypted: i=1; AJvYcCU5JOl4Qb+nmPKNXZzggZqjP9EdC66BCcAoL0c7nYntvwlbUmKfqbiKBdKFs6BE2h/XKuWtnsGsvddW6to=@vger.kernel.org, AJvYcCUkfAiPE325o+rj/tiFfKE1wmyzaTJdRQshlx2hHWzubZJ72hpCqpoUjuscMYc8/MlWnNDT9ko8MKdIWKqUWYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjl9KQa4m+L8mE/woVXF54xZnDiYRIyUsOT5zJhC1lxg0VG2nX
	u8fM608VeLvnpVGCGzgUDYpo2jIc5utl75EpynB3Sy17FOGAdm39
X-Gm-Gg: ASbGncv9PBfJPwXUee6n5oJSrTtX8bhS/7p0U2TfTP2YeaiiG4cZridYHRg1pVWYcrO
	j/NLonUorlhtzFRoZtQRrCfiFJz1kRcQczM4WK4xaKWvUR5Q0jPgdplKr854PznslEk3GCNML0F
	8sFkFY+PEcUaeAK0UqInQ4zSC+mjUZgRpU2D+tP4Ef4TjRZElvsbnIQ3+FzGu/PWdu4I88+J+HF
	cTT6eRDXudk1hO/6lNFjki1QJxxoOlvQmHyPXC6hsAOS+fRZNFuMaYKxU/3O+Ll0oGrm/FZnQWZ
	p5He3aYA9Ow93jC9mCcnHOAdfLuKkO6S4wCtPr6C0wdsRoDViifdnP+HtPVlNrFKhWt1wO6cF+h
	SNDWGwBjsMjUpUikq
X-Google-Smtp-Source: AGHT+IFgHK9ZipnYDIanORhOesAWBt8jBXqFF+1gyG8ITPmKxmblMroZ+iLut9UyP385m7WkSa7rpA==
X-Received: by 2002:a05:6214:2a4d:b0:6d8:8466:d205 with SMTP id 6a1803df08f44-6e6ae7d0ed3mr103707396d6.6.1740297485731;
        Sat, 22 Feb 2025 23:58:05 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d77920csm117861056d6.15.2025.02.22.23.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 23:58:05 -0800 (PST)
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfauth.phl.internal (Postfix) with ESMTP id B94431200074;
	Sun, 23 Feb 2025 02:58:04 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-13.internal (MEProxy); Sun, 23 Feb 2025 02:58:04 -0500
X-ME-Sender: <xms:DNW6ZyvAKShTzGgHplndXb2p6cry_5u3HLT6rtMnd9F9FkTDEhb1iA>
    <xme:DNW6Z3eQB1aJWZxn1GyJqlCou4Twtcoeia77kT0Bqx0Ce3xU2Coe4gJ1UHUhBnPVj
    v3TZDf3C13IKpSXOQ>
X-ME-Received: <xmr:DNW6Z9zEF8SeaZIYjrDqeEGm0L_AhxQ-aLdSlI6o1ze7JgI_ZOldLZSw8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejhedvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    udenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpedtgeehleevffdujeffgedvlefghffhleek
    ieeifeegveetjedvgeevueffieehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudejpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegurghnihgvlhdrrghlmhgvihgurgestg
    holhhlrggsohhrrgdrtghomhdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehlghhirhgufihoohgusehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgvsggr
    shhtihgrnhdrrhgvihgthhgvlhestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhope
    hsjhhovghrugdrshhimhhonhhssegtohhllhgrsghorhgrrdgtohdruhhkpdhrtghpthht
    ohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnh
    horhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdrnhgv
    th
X-ME-Proxy: <xmx:DNW6Z9Plr2CEaPV4xLxKC9K44V09fZPURodALh78UQ3Dh7N0O9-Q1Q>
    <xmx:DNW6Zy8xKEi-a-i38SvrzyX8iATHP2KAof0mFV_SlE5s5RKZTgDhmg>
    <xmx:DNW6Z1XHh29hlmrf__cri6dyBjif0uT5SjkU6T9lYWLpLiGJUinruA>
    <xmx:DNW6Z7fO32T0fQoZpuA8iKyioehaBFtIias66SD_fCiZKDDWDQ7K-w>
    <xmx:DNW6Z8c6aFLbnacMmBbqMVcflASz7oKBUEM8YRmyRJARK9UCJjZN457J>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Feb 2025 02:58:04 -0500 (EST)
Date: Sat, 22 Feb 2025 23:58:03 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Alice Ryhl <aliceryhl@google.com>, lgirdwood@gmail.com,
	broonie@kernel.org, sebastian.reichel@collabora.com,
	sjoerd.simons@collabora.co.uk, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	a.hindborg@kernel.org, benno.lossin@proton.me, tmgross@umich.edu,
	dakr@kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: regulator: add a bare minimum regulator abstraction
Message-ID: <Z7rVC-V-4QxGwMAy@Mac.home>
References: <20250219162517.278362-1-daniel.almeida@collabora.com>
 <CAH5fLgiErvnziU-hSCV6djNq7Q56ZfX9gZudmX7+r06hWoX0Tw@mail.gmail.com>
 <E24A1EA3-DC87-4A33-AD93-1E3B307942E8@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E24A1EA3-DC87-4A33-AD93-1E3B307942E8@collabora.com>

On Wed, Feb 19, 2025 at 02:10:24PM -0300, Daniel Almeida wrote:
> Hi Alice,
> 
> > On 19 Feb 2025, at 13:28, Alice Ryhl <aliceryhl@google.com> wrote:
> > 
> > I wonder if enabled vs disabled should be two different types?
> > 
> > Alice
> 
> I thought about having two types too, but I think it complicates the design.
> 
> 
> ```
> let foo: Regulator = Regulator::get(/*...*/)?;
> let foo_enabled: EnabledRegulator = foo.enable()?:
> ```
> 
> Let´s first agree that `Regulator::drop` is the right place to have `regulator_put`, since
> `Regulator::get()` acquired the reference in the first place.
> 
> This means that now, `EnabledRegulator` has to depend on `Regulator` somehow to ensure
> a proper drop order. Otherwise you might have an enabled regulator for which you don´t own
> the refcount. Furthermore, if Regulator drops while EnabledRegulator is alive, you get a splat.
> 
> In a driver, you now have to store both Regulator - for the refcount - and EnabledRegulator
> - as a way to tell the system you need that regulator to be active.
> 
> If EnabledRegulator is a guard type, this doesn´t work, as it creates a self-reference - on top
> of being extremely clunky.
> 
> You can then have EnabledRegulator consume Regulator, but this assumes that the regulator
> will be on all the time, which is not true. A simple pattern of
> 
> ```
> regulator_enable()
> do_fancy_stuff()
> regulator_disable()
> ```
> 
> Becomes a pain when one type consumes the other:
> 
> ```
> self.my_regulator.enable() // error, moves out of `&self`
> ``` 

You can introduce an enum:

	pub enum WaitForAGoodName {
		Regulator(Regulator),
		Enabled(EnableRegulator),
	}

for this case, and `my_regulator` is this type (or you can use
`kernel::types::Either`). The eventual code generation will probably use
a byte flag somewhere, but it only needs the byte flag for such a case.
In other cases, for example, the driver knows the regulator is always
enabled, you save the byte flag and the complexity of impl Regulator.

Regards,
Boqun

> 
> I am sure we can find ways around that, but a simple `bool` here seems to fix this problem.
> 
> Now you only have to store `Regulator`. If you need another part of your code to also keep
> the regulator enabled, you store a `Regulator` there and enable that as well. All calls to
> enable and disable will be automatically balanced for all instances of `Regulator` by
> virtue of the `enabled` bool as well.
> 
> - Daniel
> 

