Return-Path: <linux-kernel+bounces-529572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12097A427EE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6744118900F2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 16:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4332638AC;
	Mon, 24 Feb 2025 16:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYXTOJZH"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6051632D3;
	Mon, 24 Feb 2025 16:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740414678; cv=none; b=JFzuUi2THa83IvlMryRRQ4r2tT2SiV6BR5bJM7ylQrhNGul/iIBUtIs416VugLLoamzmdVqNa3lxhIDLeMPmj9wzaP8F6Qx32UO88dvEJjZHSFjbvWfEDg1NYonKquW0H6JEqJcx1Eiao6aRaNWU+hQPkfO7QaAzET3yx7v4aPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740414678; c=relaxed/simple;
	bh=lowu1n5lxZz/zL08DtA2x1p3lSy5nYjoWEU0I0vl5Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L43IARQoOyNcdhECqWfzc/BfthHLUFzGILlGKcBcr78gmAzHAqjtxl4rh/M5wjvyB7h0PiFh/LdwkT9ZiZuYaWnwMod90XInOoBqWISpVhRRWbfeoEHCPdA/lAGfxx/ivszejpqc2AEh9tTqK7tYzOo3yHpjEJFYxjg3OOxWDQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYXTOJZH; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c0ba9825e9so288795185a.0;
        Mon, 24 Feb 2025 08:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740414675; x=1741019475; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ozYi0xs0EEfYCCc0QFiM9aJmlVbV3alLU1PlJZNLsCM=;
        b=iYXTOJZHUszwWDGInkcD6JqWl8Ji/moYBXUcF0pvrQGqO8VJQRV7MEFjGu+fcvc357
         oHToLbAERt6osixlN+qXf3Sme0Tl5AFPeWvBTUbdN8wCuw3jORa975S5207i6s2FKG4q
         XoYZjrm97HwWbiD2iwYYYtYf/hIeItkH7osL1OdPlocWhw6pJRZ8t5vjQv4lt3JqjIAW
         HfXJXSNnc/jeHNhSYJWoUR/nsCfv61l2zuwUFQrv/Udsd94doMXaZ+rzNrUdxuZSjhJ1
         S9YFmtrWG3EhSYqAmcEMb7x5D57Tnhda5Jb188PTjghunb7SjvXF4bO44nr3nRQUmocD
         q5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740414675; x=1741019475;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ozYi0xs0EEfYCCc0QFiM9aJmlVbV3alLU1PlJZNLsCM=;
        b=swfQBdJp4QcJPjAk0rR+AvRfYS69ir/PLjp7/AwcaBqtloce8oW19nU7rw1adx7hYW
         xGi/N4CXAHbqPk0n48KfPjv67Zc+2pdxFpYQVDuS6Yrj9X1O0vdSEwCq3eLTnrcNlYaM
         PyOi+5iJMkKrlARq27B26sY73BTL2f0n8JsD4xTe1H7+2nvPJ/lpau+OHBQQW2Hwq9N4
         cWD980kqUgAImC/1Udml8v7DIIOJhbkkqjZjf2bXeyOQFgPC7j3Q8MSPzxZrvmVV4MHY
         AhS6QXzsGh6YDrVN5WAOi1+BvVRVoJEBwKk5ZmFymakAdXv3ZnutNRYoaVBqjK8ExnAD
         2inA==
X-Forwarded-Encrypted: i=1; AJvYcCUxw9eAoEZKnzrPRGcWHd6q/3fD15Wa50d7KI1nyJ0dz4WeHzmdbRjL/P/2xY9X5wepc6DbMfa16wEM3DM=@vger.kernel.org, AJvYcCVc5MyTKu0C3cAIzoSQZCoW+ddzavswZLw+DBn3bY5hGMQMZq0U2rZ0mNaDYNs2CnrzW61HPT53/c5o6PJxPUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ZHuNrLmtlpSSbLfgltvUdVm0/pwTB8xac2hpgbBOliwCwOrA
	3foublEI9wkuW6mxpNUspA2RgRBP6vxvZEwuOE7LIdczKs0uyQJt
X-Gm-Gg: ASbGncudSNi7vMJvriMRPUvBNuWksKK3jKjow78IpcjVPa5Z19WhVywx+ydcqYFO3Fs
	RDgZNa62H2xTVwbMb2QPCrHWeUWyRiAH6lI98GqXCapmsIaEsuyoKECcGaKRYQMuugnRVhXX5MV
	6Fu1MvjWdcLCX3FJf/4TyOxert0kkuYQX8kgdOKMKhxJB2sizlNQgLdxuokrA2/2qkMifrsbXRt
	kgCMRo/YdxLIbPDeuYoyhzIqUg8O7XQykYW6xNO/rqeMCfW4XHhXScq1s2jMjRGpXT7NbAU974V
	DDCKK6w6sK0r5pVN6vz2q0BdUJTayVS8m1ffrdEFPgcfoJZisMw2QsGkTDxEN17v6fCUEQk1FN6
	9iMGkt1LQzrf/xMkK
X-Google-Smtp-Source: AGHT+IHxsHKAq5YEbiqCM0IBQJxyrG0mw2FmfsUgVg/pZIitEee8ZaesDMyy0+m2M5T2F93KjKrMQg==
X-Received: by 2002:a05:620a:29ca:b0:7c0:a216:404f with SMTP id af79cd13be357-7c0ceeebbc3mr1824327285a.2.1740414675301;
        Mon, 24 Feb 2025 08:31:15 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0a3dcda55sm956986485a.58.2025.02.24.08.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 08:31:14 -0800 (PST)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 671D8120006B;
	Mon, 24 Feb 2025 11:31:14 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 24 Feb 2025 11:31:14 -0500
X-ME-Sender: <xms:0p68ZxwAq5lpqSWJUFyJN7ToqJe7N5V-XdiCnFoqAS8caR0a-Dx5uw>
    <xme:0p68ZxRQrrnN8HdIPaT5uPUajCVDxRZF5GTviGueFf5wXwzBIF_-KjgRkAeqlBQgD
    DZUyd02hQ42N8FRhg>
X-ME-Received: <xmr:0p68Z7Vo-szr-lbbd5G9J93Z22xT5m-IJ5cBocbawNAQOHL_I9tziilYRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejledvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeevgffhueevkedutefgveduuedujeefledt
    hffgheegkeekiefgudekhffggeelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppe
    hgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepvddupdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehmihhguhgvlhdrohhjvggurgdrshgrnh
    guohhnihhssehgmhgrihhlrdgtohhmpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtoheprghnnhgrqdhmrghrihgrsehlihhnuhhtrhhonhhigidruggvpdhr
    tghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepuggrkh
    hrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpth
    htohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:0p68ZzifcAJw8djzLlItB6DVPDP7EjMcY694wdfdlNwTv6oERzWNIQ>
    <xmx:0p68ZzDf48xqSbYzQWVW9cCNOTLWwVktnYGrFUe4yeN7TfUOMqhW8w>
    <xmx:0p68Z8LDsdi6HTX47GkPVTQHeZGdnnP_LZuZGd2w2oh7sfMCCWxhGw>
    <xmx:0p68ZyA3Bh93WBNy3j0rfeKHZem-vFoC9J8XLSamM9Zmg53KtVZTdQ>
    <xmx:0p68Z3wFXWWQNTAXXWeIaJV0uExRQ6BRLNFEb5w6TuScRnpNykQ241KQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 11:31:13 -0500 (EST)
Date: Mon, 24 Feb 2025 08:31:12 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
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
Message-ID: <Z7ye0MsACNWe7Mbr@Mac.home>
References: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
 <Fg4QliwzbHj3m-Fr3ZeUiU11d6Bu-I7w_9xzSsnDlzQtqCkjgqxJpI6_YxuXnB8m0MqESq6V7vK7FhPnEcvGwg==@protonmail.internalid>
 <20250224-hrtimer-v3-v6-12-rc2-v9-1-5bd3bf0ce6cc@kernel.org>
 <874j0j1nv2.fsf@kernel.org>
 <Z7yUTNEg6gMW0G7b@Mac.home>
 <CANiq72kx31exTFohb3+9_=PGUq_JtqpCvG8=oQUc_gZB+De5og@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kx31exTFohb3+9_=PGUq_JtqpCvG8=oQUc_gZB+De5og@mail.gmail.com>

On Mon, Feb 24, 2025 at 05:23:59PM +0100, Miguel Ojeda wrote:
> On Mon, Feb 24, 2025 at 4:46 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > Why do we need this new kconfig?
> 
> I suspect it is to provide flexibility (i.e. to avoid building
> everything if there are no users of the abstraction) and/or to limit
> the set of configs that may be affected by a breaking change on the C
> side -- Andreas and I discussed it the other day. The description of
> the issue has some lines, but perhaps the commit message could

Do you have a link to the issue?

I asked because hrtimer API is always available regardless of the
configuration, and it's such a core API, so it should always be there
(Rust or C).

Regards,
Boqun

> clarify.
> 
> We have a similar one already, i.e. a "Rust-only" config, in
> `CONFIG_RUST_FW_LOADER_ABSTRACTIONS`.
> 
> Since this one is default "y", it may still affect unrelated
> subsystems that just enable `RUST=y`, though.
> 
> (I guess we could consider `select`ing from end users. But they cannot
> be hidden symbols, because that limits the control too much (e.g.
> someone may want to just build the abstraction), and in general they
> may have dependencies, so it may not be a good idea.)
> 
> Cheers,
> Miguel

