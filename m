Return-Path: <linux-kernel+bounces-530010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E03AA42DA1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B18E416815C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC31241678;
	Mon, 24 Feb 2025 20:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzjsCZtj"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522243B2A0;
	Mon, 24 Feb 2025 20:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740428606; cv=none; b=O9Uc/c7R8ah/4e2cRA1MCdloOZmZxLtlu8pT6AUMOmvU86gsOqn5VpeHD2nZv4ksuG9V1/lGzviVU2wPfjwXsJRA1M6H+KqW3upZRvfcUlTvOIysauL3FsCbYfm1iKPUMhs9aM4EYgy4Dndd5CKDKSLMVdrDCuQDBT1jJEkgxik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740428606; c=relaxed/simple;
	bh=eDAMB1a9HteWrzWS3YVk/G6mZ1EHXdtCK2QfeYq6BiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUIJeJJU5vHXdkNqT2maHrfcl2jlB4K2Z33f96zNiyeifJ8YVCDYIiahRgL7emVse1ZkPpWfGYrNEvjMAu4F7WELZe8YZ9y6KhqOfivO4hI+Dh24buylJdvQRjxoZ09P4xL8rciIXVhacJTZO+f7d3yByb9SynmKRUYQt8nLmFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzjsCZtj; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e17d3e92d9so38536606d6.1;
        Mon, 24 Feb 2025 12:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740428603; x=1741033403; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zRZueQGAuyNHX0V+MUT1BY/FrLcRwAdtXZvuxb2xKNM=;
        b=fzjsCZtjXzwF6Wv47SVhJLpjxGGwydhY3VGKgLa0+eHlSciFncbhGw3ylPlvHPkTEf
         KlJF/5u1aOuE/ZPVacnLpBJhtPag7R73WapBt6DYMLJiG2Z+jfcXzWisRst39uily72g
         b+JgI++J1ZCHuyHZ+/1oI65VIKFgIkohFgIIucEtcToM6VmC/CwjFzcuIPiKNv1WvrKY
         75ZTnqOEnny2egc3FhRi/LG1JicK7rJ5KjGs+92xFcGkwqEt+UYMgndguBPPvFRV0yFn
         JfYyVuDGsVul/nBvAB5HFoFEBLkOlvMfo/3Qbt7YyXANicEDaBJo1HEfria3KQM6zPur
         9xVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740428603; x=1741033403;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zRZueQGAuyNHX0V+MUT1BY/FrLcRwAdtXZvuxb2xKNM=;
        b=fFlWorS+EZZf9Z0PfCshA6ZV6U7GTKNam8rXssnXGQkzEJEgztGz1dEcqTabUxnfkf
         3XqStBSFr0Vy+z6BYWgCJVFjzzekZGCK4bbAXHhqBk/LnbdOaZdLgxGMuAjy0FcG9+wJ
         /RGwAzeK4eX+HAioFM+SHiLuHMcrHQWUXLiuiGfcwGMTZZw3Ymo4mWiSCZ6ddykvJG+L
         A71wzAdiXGZ0XrDHzK6qcwOCuqnymRQhRb643Zn77vIs5g2mqVBYR7KGVDselvhOXjGN
         nzZZYP6IaSvfCSPJS/l9bzw6lkJCwWjpFpAVVu5HZI6ebC93JByxqsJn1tLOJEtL4IeA
         u+kA==
X-Forwarded-Encrypted: i=1; AJvYcCVUxEgSejaLHrlzZBbSrraM3AKJpD6crvZ8vf5/XBGI/yqk3e+IjqdLHA9AD+XVbOy8Q/WU9m+sxHR8bZU=@vger.kernel.org, AJvYcCWxCab+9+iYlWRLXGEA63wDDErJ5VAyALRrYAv0W+w4KVifB1XV0wfgSs/DcHpWhAsQ6nd4MArKgfD5xj5L8zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHNJtbD6K5y3WpUqt6vn9iE+hPDgnhCVM3QxdPWcareHFj7ZZ2
	hhIsqyYBuP112gTn56eAE4RMwZ7kHrj2j6kV+YMTWP/k56gNXKQB
X-Gm-Gg: ASbGncsKAwExfU/70dVVzJKTRy7vHHOUYMzQoZvIBNEpeIfpBauGmRRPHwAvSEykWPU
	hOOW8njr4lDpglsD+8JNs40bX0DMXLxc5nQ+zOWCiUN4WNctvL54Jypy47KTINIwmWdyc32IhvZ
	Z0ZMAmzL23L8Z8drBdxsp2jZLLWzvtiMwVIe1oMDiI5hJhxInQfhfOyLFQjDt00y3bFvub/guly
	Sw1qhFfQtAYYu43An5iMGoPENIXVDbmLMtrufgAS40HV6dJ+ZXCSTD2PrK7/78Qzy6ZFYCjckGS
	claeeQ+n6/16NvMvvQy+zyrF9AJJySXKbxVb3w3CAk39TkihU0YcQeu2w+ovgXJ7IY3S+bHdBjz
	6IBQ6zJDLh00565kS
X-Google-Smtp-Source: AGHT+IFF/nt4KqGKEazj9d82/SIzFir8ZJLtqSHJf3e6/Vx/5KuEpvKEVA+dz2gT7EfeYM40+sbvbw==
X-Received: by 2002:ad4:5f8b:0:b0:6e6:64e8:28e7 with SMTP id 6a1803df08f44-6e6ae7f7d4cmr187370936d6.15.1740428603088;
        Mon, 24 Feb 2025 12:23:23 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b06dc41sm1083246d6.20.2025.02.24.12.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 12:23:22 -0800 (PST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 159D01200043;
	Mon, 24 Feb 2025 15:23:22 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 24 Feb 2025 15:23:22 -0500
X-ME-Sender: <xms:OdW8Z2eSb38yOCPMpsgHdlftieMNSwa9yjoPv-3Hb-15livprNJcMg>
    <xme:OdW8ZwP88xBe0FTvB2z5aXwKbjGoeBbgMzW6lkvaZWl53hwjBerZ9720MkuD99xC-
    0L1FThTVxcrxL_-Xw>
X-ME-Received: <xmr:OdW8Z3hXcVDCcFaDpkF0rBxEX_rXSrvBA-_4r1HWVKbN0d64_h-_rZoN3o8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejleejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeevgffhueevkedutefgveduuedujeefledt
    hffgheegkeekiefgudekhffggeelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvddupdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopegrrdhhihhnuggsohhrgheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepmhhighhuvghlrdhojhgvuggrrdhsrghnughonhhishes
    ghhmrghilhdrtghomhdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprghnnhgrqdhmrghrihgrsehlihhnuhhtrhhonhhigidruggvpdhr
    tghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepuggrkh
    hrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpth
    htohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:OdW8Zz96WwxM3isbc_vbPo0404XP695WanPpsC24TuRMYPiUBhKKVQ>
    <xmx:OtW8ZytrHwOmRfhKh0TGaGozuLlDW7kYkDhdyK1yknvWmpartbo2-w>
    <xmx:OtW8Z6HfMyVdYEJ7OvD_AZp3ygs3GRxQooNS29YN4C_CpasRZMR6KA>
    <xmx:OtW8ZxNvCqv8cHA6BL91uUPko4A5_jzfN5RZrPqd1sNY6tXCqwJi6g>
    <xmx:OtW8Z_MpcRvkU9nZO2NYjzMSArZwLNjd-y4gHHphFKvCfAvDeUmur_aJ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 15:23:21 -0500 (EST)
Date: Mon, 24 Feb 2025 12:22:43 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Danilo Krummrich <dakr@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>,
	Dirk Behme <dirk.behme@gmail.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH v9 01/13] rust: hrtimer: introduce hrtimer support
Message-ID: <Z7zVE_CvmIVukkXB@boqun-archlinux>
References: <Z7yUTNEg6gMW0G7b@Mac.home>
 <CANiq72kx31exTFohb3+9_=PGUq_JtqpCvG8=oQUc_gZB+De5og@mail.gmail.com>
 <Z7ye0MsACNWe7Mbr@Mac.home>
 <CANiq72=qayfPk+W4BRiXe9xBGcgP2zPf-Q3K6GXTg8MKy-Kg=Q@mail.gmail.com>
 <WlwmQ3r8VXTu77m77jclUgLjPh65ztwxUu_mXaElarFHBBiG2kWi0ZLYWNxKAUF9LK2QYrOWhtlFYhwaaNjYRA==@protonmail.internalid>
 <Z7yl-LsSkVIDAfMF@Mac.home>
 <87msebyxtv.fsf@kernel.org>
 <4UoaifxB7JgBVKsNQyFR_T8yc3Vtn5TLAEdxdXrojNmOzJSEncopauEyjDpnbqzr8Z74ZWjd_N-bB-BwBS-7aQ==@protonmail.internalid>
 <Z7zF8KF9qTCr_n4l@boqun-archlinux>
 <87bjuryvb0.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bjuryvb0.fsf@kernel.org>

On Mon, Feb 24, 2025 at 08:52:35PM +0100, Andreas Hindborg wrote:
> "Boqun Feng" <boqun.feng@gmail.com> writes:
> 
> > On Mon, Feb 24, 2025 at 07:58:04PM +0100, Andreas Hindborg wrote:
> >> > On Mon, Feb 24, 2025 at 05:45:03PM +0100, Miguel Ojeda wrote:
> >> >> On Mon, Feb 24, 2025 at 5:31 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >> >> >
> >> >> > On Mon, Feb 24, 2025 at 05:23:59PM +0100, Miguel Ojeda wrote:
> >> >> > >
> >> >> > > side -- Andreas and I discussed it the other day. The description of
> >> >> > > the issue has some lines, but perhaps the commit message could
> >> >> >
> >> >> > Do you have a link to the issue?
> >> >>
> >> >> Sorry, I meant "description of the symbol", i.e. the description field
> >> >> in the patch.
> >> >>
> >> >
> >> > Oh, I see. Yes, the patch description should provide more information
> >> > about what the kconfig means for hrtimer maintainers' development.
> >>
> >> Right, I neglected to update the commit message. I will do that if we
> >> have another version.
> >>
> >> >
> >> >> > I asked because hrtimer API is always available regardless of the
> >> >> > configuration, and it's such a core API, so it should always be there
> >> >> > (Rust or C).
> >> >>
> >> >> It may not make sense for something that is always built on the C
> >> >> side, yeah. I think the intention here may be that one can easily
> >> >> disable it while "developing" a change on the C side. I am not sure
> >> >> what "developing" means here, though, and we need to be careful --
> >> >> after all, Kconfig options are visible to users and they do not care
> >> >> about that.
> >> >>
> >> >
> >> > Personally, I don't think CONFIG_RUST_HRTIMER is necessarily because as
> >> > you mentioned below, people can disable Rust entirely during
> >> > "developing".
> >> >
> >> > And if I understand the intention correctly, the CONFIG_RUST_HRTIMER
> >> > config provides hrtimer maintainers a way that they could disable Rust
> >> > hrtimer abstraction (while enabling other Rust component) when they're
> >> > developing a change on the C side, right? If so, it's hrtimer
> >> > maintainers' call, and this patch should provide more information on
> >> > this.
> >> >
> >> > Back to my personal opinion, I don't think this is necessary ;-)
> >> > Particularly because I can fix if something breaks Rust side, and I'm
> >> > confident and happy to do so for hrtimer ;-)
> >>
> >> As Miguel said, the idea for this came up in the past week in one of the
> >> mega threads discussing rust in general. We had a lot of "what happens
> >> if I change something in my subsystem and that breaks rust" kind of
> >> discussions.
> >>
> >
> > So far we haven't heard such a question from hrtimer maintainers, I
> > would only add such a kconfig if explicitly requested.
> 
> It gives flexibility and has no negative side effects. Of course, if it

The negative side effects that I can think of:

* It doubles the work for testing, it's a Kconfig after all, so every
  reasonable test run will have to run at least one build with it and
  one build without it combined with other configs.

* It may compelicate other component. For example, if I would like
  use hrtimer in a doc test of a lock component (the component itself
  doesn't depend on hrtimer, so it exists with CONFIG_RUST_HRTIMER=n),
  because I would like to unlock something after a certain time. Now
  since CONFIG_RUST_HRTIMER can be unset, how would I write the test?
  
  #[cfg(CONFIG_RUST_HRTIMER)]
  <use the Rust timer>
  #[cfg(not(CONFIG_RUST_HRTIMER))]
  <use the C timer? with unsafe??>

A new kconfig is not something free. We will need to cope with it in
multiple places.

> is unwanted, we can just remove it. But I would like to understand the
> deeper rationale.
> 
> 
> >
> >> For subsystems where the people maintaining the C subsystem is not the
> >> same people maintaining the Rust abstractions, this switch might be
> >> valuable. It would allow making breaking changes to the C code of a
> >> subsystem without refactoring the Rust code in the same sitting. Rather
> >
> > That's why I asked Frederic to be a reviewer of Rust hrtimer API. In
> > longer-term, more and more people will get more or less Rust knowledge,
> > and I'd argue that's the direction we should head to. So my vision is a
> > significant amount of core kernel developers would be able to make C and
> > Rust changes at the same time. It's of course not mandatory, but it's
> > better collaboration.
> 
> Having this switch does not prevent longer term plans or change
> directions of anything. It's simply a convenience feature made
> available. I also expect the future you envision. But it is an
> envisioned _future_. It is not the present reality.
> 

The reality is: we haven't heard hrtimer maintainers ask for this,
right? I know you're trying to do something nice, I do appreciate your
intention, but if hrtimer maintainers haven't asked for this, maybe it
implies that they can handle or trust that wouldn't be a problem?

> >
> >> than having to disable rust entirely - or going and commenting out lines
> >> in the kernel crate - I think it is better to provide an option to just
> >> disable building these particular bindings.
> >>
> >> This has nothing to do with general policies related to breakage between
> >> Rust and C code, and how to fix such breakage in a timely manner. It is
> >> simply a useful switch for disabling part of the build so that people
> >> can move on with their business, while someone else scrambles to fix
> >> whatever needs fixing on the Rust side.
> >>
> >
> > It's of course up to hrtimer maintainers. But I personally nack this
> > kconfig, because it's not necessary, and hrtimer API has been stable for
> > a while.
> 
> Having the switch is fine for me, removing it is fine as well. It's just
> an added convenience that might come in handy. But having this kconfig
> very close to zero overhead, so I do not really understand your
> objection. I would like to better understand your reasoning.
> 

Hope my explanation above is helpful.

Regards,
Boqun

> 
> Best regards,
> Andreas Hindborg
> 
> 

