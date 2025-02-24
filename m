Return-Path: <linux-kernel+bounces-529926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42ECBA42C95
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07531893746
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 19:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22D01FCCE0;
	Mon, 24 Feb 2025 19:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+GNEs3a"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329B01A76AC;
	Mon, 24 Feb 2025 19:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740424741; cv=none; b=uaNr3sSrCmQPB10JuieZPiJLpg06xf+x+Uqh0ZO/kPUM4YzwdKshSWj/Qoi40S5hQMDZ9fFs1W0+BT7pPhzV51zeB/1MH1PZEyt55BoXFNiD+JBp2rTOkzf1EUBVC4NIuGfA83sEhXdzgxP69JJndPblrYHJfX2g/53kGoIP1pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740424741; c=relaxed/simple;
	bh=zGicrtl24qQPtby4+Gn1aiZ7UEI+z5oCfwEpkiJRZfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGvurz+yS/wE/lYogKwmwSgTMgvbguiyJoC1ItPrLz4oEa1xnE97cuIYSHeRY3WahuhFKWe3wCjgDvos0alNpLC8ytupGYd8zzTQbOUSR1h8ga/iwotkERd549zvdWkYJSrCSGMugfugeYncaL3ad+prb9W5Kk9p5XRwPEfw2Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+GNEs3a; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c07b65efeeso466753885a.2;
        Mon, 24 Feb 2025 11:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740424739; x=1741029539; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p3xHJbLnGcW0HZ1gLOEDktA60F4a1G/C80wkrIEDae8=;
        b=P+GNEs3aDjpVvXV2tQV01wYdyavVqajt+qWrhJuYq4gDMpMkS8gQNdL1kr8MylB41i
         HVCfKL3rPATtWbAubgfZLLpU9mzK1XLuqwEPtlNxOjpu/HvobaVoiHMmPb7ZGaOZlvdV
         iRX1fkEc/VHqyurX1MWoblxfIF6pyHBqcPl4ljq4aTnHBhOKaNbG/r8gW5ziZCG4yfuF
         T0XjCEaW+jyW8PFaer81hnsenDQv0hO8/N+HjrRSOYiqfexqFeY1sBw7dqo+GoDA1JS8
         1DvRq51rdp7zf6RYBGCaWgLhVlioLnrTfnMHeo08C6jgqsAqQO9eS0xE1qD2FNiKDXUf
         /6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740424739; x=1741029539;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p3xHJbLnGcW0HZ1gLOEDktA60F4a1G/C80wkrIEDae8=;
        b=XCP93ZmEJgiMAuFM/r2bICqQFN7+oZTxBXGyG0tVhD3QgQppvEE3linZRUrR6MRAwO
         sKmL2+mEqr0OYF1xSSAmwDYRh6fucXcUFZEiUiXHHVnZ4ckAKbLBweqe/Z7C++GouB7h
         YzHyskOujwrtL9eAa0GIuS8H+k8tUJ6x382sqiC7a3jvaBxzxk17bZCN+OCaaZtnzZlB
         IW+6vmZhXOZP5pvoMdiCefiO8/Rc/y9HDH4FtL/U4kQOhCPHJWXk9pWa+DZXQAOJ4qXv
         Y97KO0VV6kcrEtKMAr7Qf9UuYwdV9yT20VA15MA95pFqs8nZLjpqL/Oy4mC0R2zADeOR
         SJmg==
X-Forwarded-Encrypted: i=1; AJvYcCUWan8gHVJgyr28vmdwm9P293A66ei01nz/Tj5wwTGPnyC85petM4sgVkfWjja88k9Kufl22T5KWgGKyTc=@vger.kernel.org, AJvYcCVcgDOjlTwgasXeBEtO981rRQ1M6m6sdKqdg0MFBs3LNXCCQLm0jXjgZdmW6JyfSdadpWy3l/4iaGZZyWDHYoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU+xblTw+IFs5xE0Ol6EOWOydnuvlPt9I/unTd0kn+638N8uz1
	lb5rAJpW9OzvCByMcBbn0vgm2pf9HXuN9oVCoQhEKIUMGKWk6OY+
X-Gm-Gg: ASbGncsrr/VJTbvTw6su94om00kUmexB2LxqIwDrKhV0UcuTbPjjUeZbVRUKblY2GO4
	DdyzDLt3n8AjFRIg4US+LNcWCF9ChEBkH2kC56WiCrxFugNsIfsGlDDL8THEs3AoOLnVkea+4bj
	JZdvIVrqKYBdE9n9FD/ouG+SePQkGVPVvFrFExnEoYRjWgi9vPA2nQQu333kpW0vls4G8on7u/f
	fcUbxnqUWYz/2C/Mu0dzsO2adZS/5Z0ShhVKYVw4ssjHKhJfblB1nA6iIur6AwrFovHOB6uLjgi
	J/a7HW9KqqolVuvwdwXHZW9ZDQ4Io9OgKDiaambgAAfvE1oOUM/su4eW6f6/D9YvYm+4HWLfJWP
	L0YSYcWLiibnzENmZ
X-Google-Smtp-Source: AGHT+IEASQDgwK1ZCpXCe9rbQcK/QKGxUv8rOGOYKhCC4qMl70AwVXsBR3xHrdxYO4d9XP89MwfjBA==
X-Received: by 2002:a05:620a:40c7:b0:7c0:c332:1cdb with SMTP id af79cd13be357-7c0cef46051mr1632523585a.38.1740424738790;
        Mon, 24 Feb 2025 11:18:58 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c23c299f02sm9535185a.6.2025.02.24.11.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 11:18:58 -0800 (PST)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id AE66D1200068;
	Mon, 24 Feb 2025 14:18:57 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 24 Feb 2025 14:18:57 -0500
X-ME-Sender: <xms:Ica8Z17AasKq5NcTbY4uHB-bIUFjZCQ85NJQdJXbEgOEXOq57te1xQ>
    <xme:Ica8Zy545tLxKcyjyliQwTWzlfRdbRpc12OuVNZJJeFXc-pU7_HH8sVGRa4pUlr8k
    UxRAvsWB6_r-zlzNg>
X-ME-Received: <xmr:Ica8Z8fX4oEF2nD-eFIeGPFM0aQUCyo-lVQBxWihWjUbzaMymGKcelNuxEc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejleeitdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:Ica8Z-IVyt0oJN-CU9v1TyTArH_JuzKQ33Xmo0cCNG5n7zxQ41W4bg>
    <xmx:Ica8Z5IhUGOgQ6dH-OHjdnoTsnVbFXFo9qBttix5LrQ3J6n8wuBgaQ>
    <xmx:Ica8Z3wTxlaT9qZ1XIl-qfZODs0m7CLanlJK0YnCs-KHtUojkI32Bw>
    <xmx:Ica8Z1JFxdjrQ1JS5VLPO6d7G278_DgP35qYCv0Ci7fDFZTgSPnXmg>
    <xmx:Ica8Z8b8jpR-oWFXD4AvbQ22S1G2pCAT26XQMqLALmV3MY1AWqZojlAB>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 14:18:57 -0500 (EST)
Date: Mon, 24 Feb 2025 11:18:08 -0800
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
Message-ID: <Z7zF8KF9qTCr_n4l@boqun-archlinux>
References: <Fg4QliwzbHj3m-Fr3ZeUiU11d6Bu-I7w_9xzSsnDlzQtqCkjgqxJpI6_YxuXnB8m0MqESq6V7vK7FhPnEcvGwg==@protonmail.internalid>
 <20250224-hrtimer-v3-v6-12-rc2-v9-1-5bd3bf0ce6cc@kernel.org>
 <874j0j1nv2.fsf@kernel.org>
 <Z7yUTNEg6gMW0G7b@Mac.home>
 <CANiq72kx31exTFohb3+9_=PGUq_JtqpCvG8=oQUc_gZB+De5og@mail.gmail.com>
 <Z7ye0MsACNWe7Mbr@Mac.home>
 <CANiq72=qayfPk+W4BRiXe9xBGcgP2zPf-Q3K6GXTg8MKy-Kg=Q@mail.gmail.com>
 <WlwmQ3r8VXTu77m77jclUgLjPh65ztwxUu_mXaElarFHBBiG2kWi0ZLYWNxKAUF9LK2QYrOWhtlFYhwaaNjYRA==@protonmail.internalid>
 <Z7yl-LsSkVIDAfMF@Mac.home>
 <87msebyxtv.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87msebyxtv.fsf@kernel.org>

On Mon, Feb 24, 2025 at 07:58:04PM +0100, Andreas Hindborg wrote:
> "Boqun Feng" <boqun.feng@gmail.com> writes:
> 
> > On Mon, Feb 24, 2025 at 05:45:03PM +0100, Miguel Ojeda wrote:
> >> On Mon, Feb 24, 2025 at 5:31 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >> >
> >> > On Mon, Feb 24, 2025 at 05:23:59PM +0100, Miguel Ojeda wrote:
> >> > >
> >> > > side -- Andreas and I discussed it the other day. The description of
> >> > > the issue has some lines, but perhaps the commit message could
> >> >
> >> > Do you have a link to the issue?
> >>
> >> Sorry, I meant "description of the symbol", i.e. the description field
> >> in the patch.
> >>
> >
> > Oh, I see. Yes, the patch description should provide more information
> > about what the kconfig means for hrtimer maintainers' development.
> 
> Right, I neglected to update the commit message. I will do that if we
> have another version.
> 
> >
> >> > I asked because hrtimer API is always available regardless of the
> >> > configuration, and it's such a core API, so it should always be there
> >> > (Rust or C).
> >>
> >> It may not make sense for something that is always built on the C
> >> side, yeah. I think the intention here may be that one can easily
> >> disable it while "developing" a change on the C side. I am not sure
> >> what "developing" means here, though, and we need to be careful --
> >> after all, Kconfig options are visible to users and they do not care
> >> about that.
> >>
> >
> > Personally, I don't think CONFIG_RUST_HRTIMER is necessarily because as
> > you mentioned below, people can disable Rust entirely during
> > "developing".
> >
> > And if I understand the intention correctly, the CONFIG_RUST_HRTIMER
> > config provides hrtimer maintainers a way that they could disable Rust
> > hrtimer abstraction (while enabling other Rust component) when they're
> > developing a change on the C side, right? If so, it's hrtimer
> > maintainers' call, and this patch should provide more information on
> > this.
> >
> > Back to my personal opinion, I don't think this is necessary ;-)
> > Particularly because I can fix if something breaks Rust side, and I'm
> > confident and happy to do so for hrtimer ;-)
> 
> As Miguel said, the idea for this came up in the past week in one of the
> mega threads discussing rust in general. We had a lot of "what happens
> if I change something in my subsystem and that breaks rust" kind of
> discussions.
> 

So far we haven't heard such a question from hrtimer maintainers, I
would only add such a kconfig if explicitly requested.

> For subsystems where the people maintaining the C subsystem is not the
> same people maintaining the Rust abstractions, this switch might be
> valuable. It would allow making breaking changes to the C code of a
> subsystem without refactoring the Rust code in the same sitting. Rather

That's why I asked Frederic to be a reviewer of Rust hrtimer API. In
longer-term, more and more people will get more or less Rust knowledge,
and I'd argue that's the direction we should head to. So my vision is a
significant amount of core kernel developers would be able to make C and
Rust changes at the same time. It's of course not mandatory, but it's
better collaboration.

> than having to disable rust entirely - or going and commenting out lines
> in the kernel crate - I think it is better to provide an option to just
> disable building these particular bindings.
> 
> This has nothing to do with general policies related to breakage between
> Rust and C code, and how to fix such breakage in a timely manner. It is
> simply a useful switch for disabling part of the build so that people
> can move on with their business, while someone else scrambles to fix
> whatever needs fixing on the Rust side.
> 

It's of course up to hrtimer maintainers. But I personally nack this
kconfig, because it's not necessary, and hrtimer API has been stable for
a while.

Regards,
Boqun

> I am of course also available to fix anything that would eventually
> break. In fact, I expect to be able to catch breakage most of the time
> automatically and very early by means of automatically monitoring the
> relevant trees. I do this for block, and it has worked really well since
> rust code was merged in that subsystem.
> 
> 
> Best regards,
> Andreas Hindborg
> 
> 
> 
> 
> 

