Return-Path: <linux-kernel+bounces-529629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AFCA4290E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 990813BEE4D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5997266EE7;
	Mon, 24 Feb 2025 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/HjYPvj"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE6B2641D4;
	Mon, 24 Feb 2025 17:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416510; cv=none; b=tjTGqSpRQ+iVtAC+XjH/uj0+6nAe+tezq/IRqvnZ0ssfoGUGVCCFVqfkKh6UJzWi/IJRmDOr3WOOS+joq4rxYmk1iM/SvgS33XvXKhlyfpiofvPe9ogcQY8bLzXa/KLyarx05tWWDg/s9Yu+z3Bl8DxBWS1zh0YvEs5kEdWhtM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416510; c=relaxed/simple;
	bh=21Fx0YdOPOhmq0ZvDOd6fNkcas2nl9DSL3oBegOTdvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgf8Gq5MTq5mGmDWe5Nzb6x171QE+TmIZwpVyWjXQw+5HCJpIPhWqceFzYrnCpisHrqJ18hgJXIIDDAkUM08ItuFBy7jIVxQ/IPMzIdfhhUJ0K439fxmYmvcjNACfoYxNEF9kZYLyy90x+7bEXO8SDI8kwdpiyShV8gZ0uROYyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/HjYPvj; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-46fa7678ef3so44640241cf.1;
        Mon, 24 Feb 2025 09:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740416507; x=1741021307; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EcvdHU1j5+XOAtX/UODZiTGaxETgaZmb3P60ivZS9HQ=;
        b=k/HjYPvjtdrlg6H4GnE2nX0agwBEcf8pIl3H/7NGGClnCtAUay9ObjOy/He8ELmIGy
         kwy4uc6vRKSZ1IHQRWQZdYU7/LCll9ihkjDr+xs+gLizBqQdTpYiAJ0ucL8SoPE0gmFP
         D7XPSVKS5qjBRR5Q4MycqyTY/FzLeoNCDAnza0aUkI3bQ3lLcs1IQQRr8riz8ftXlW6j
         luzRsccgeSfFIUjpmNINyhZ198hWAHEN9O4KyQy0pmiMT63bjpocJiWTi+0k7hGi1V29
         dX565eZ3Sxumxt3jw1T2ZCBkcZrY8bV7eTChrGZQu9JCx+0FQQmAF2y8cJYInbJEWyJ8
         7nUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740416507; x=1741021307;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EcvdHU1j5+XOAtX/UODZiTGaxETgaZmb3P60ivZS9HQ=;
        b=GGoYQhrfLJMHlxfhAuk807PUbhA5UADP8d4FDXi5sqIEb5d7woyw2B9JNlDj4wvgE1
         EP41msmBuFH3LYpEnFO7qf07nDgQmD9DZ9WD0sgWA4b4DnpQYITm4awHO+VHpx0k6RCv
         YAKh6MwZ3J2rdOsgcvALrHDEhJw7GuAcAVqJY2RzjTlg7/uMDWHPI9GE7CLuMBaSfKXn
         Z1mW8iZLlRkh8qCQcVmqJqBqjOrNfKLB3wdE0welRYxDRKzw+Vl2EzHoK11oVEnUQdj7
         jmCodwYlCfwQvNcMSUEGx75O4GVH/HFp+97jkqqfeULEfY7rTqlM61esFYmvf8M1pL+E
         KT9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXTwvXsvCty9Y8ZVxz0Nwl2Ma1wBPipp6iFUexa6yu5Y/lzOcQK5Ni3R62IUzv10/O41kfzlHa4lM1Q2IHQL6Q=@vger.kernel.org, AJvYcCXZyGNthP9Ze+G5cXjvD5OcyKC8+AebaoHPHE/WaknC4Bc6g98CJNWYhrYqAiJWSNUIHiEnp/JdG0Ifqak=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ6kg+cwFi2Wu7HbG4Kh/lILLihaAxo6MWGA9xm5LY18ms3MIW
	AlCn67xAoiLn62RnanFH2UovgaaQJz8ihcZrbAfydckHD+8j9jSQuIuDcA==
X-Gm-Gg: ASbGnctQ3bnvoZ0mVa4AS1Q2Hq5cDX2/Sb/9WnL7YlCUBoMpzKLpvdiJF1zINjgYHhx
	VmhPan0A7fa9fTJBsxVPxg55Lompp8aBlAvPWxA5IsxP6x+PvtEMH5/iE4Cqzu94lFKsP0YryXW
	vGAdZGareCtKKrpa4kmyFXTjKWr0nPqpOrMNMwnuI4NpRwUyj/34yJ9YIRchfs6FpdbvOS6PRzp
	LHMZmLnAGJs5o1BCOe4n3YW3V0fveIhHwtVx9GcW7+/Xbxg5EuvnbcuzdzYkoltkfD7IMSAoMtg
	rk5fFoc5kbI1c14xMnvHdDbhdbDr6hOoHg1GKr/zjf6abDw3KqOMidDs6QFNFfeTJ4miGPsxja3
	HFhdoMLmSkYIm8RAG
X-Google-Smtp-Source: AGHT+IFJW1E0n+Ql+maql2hXwKRz+zBCJeKLEhSum8UGBDkukPnP2DcvcXhhU/gNDHG8rCyexx20fw==
X-Received: by 2002:a05:622a:1211:b0:472:2bc:874e with SMTP id d75a77b69052e-472228be93dmr177934221cf.15.1740416507207;
        Mon, 24 Feb 2025 09:01:47 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4720bc52905sm67711211cf.26.2025.02.24.09.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 09:01:46 -0800 (PST)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3B96F1200068;
	Mon, 24 Feb 2025 12:01:46 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 24 Feb 2025 12:01:46 -0500
X-ME-Sender: <xms:-qW8Z35MxQt3XkFY2y3Ci0E9RrjEYP1_VOJswRl3FSMoFhREn3x0rw>
    <xme:-qW8Z87h2FX64HmElJ40y7O2blx4DUYUUniEDtIrUeBMb6cbwRrezwVNBFzqEC-uR
    Kb0Nc26dl3WGOdUDw>
X-ME-Received: <xmr:-qW8Z-eQfy3rCBLboVhtb6DdGqeYOXPguUEyVnfP2gTpvUw4GxWrkfJRxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejleeffecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:-qW8Z4KoVyeiluHvS8w33etm3N1C-W9eEVChdWOVwRJZa1F1-8rgPA>
    <xmx:-qW8Z7JP09EjloEAjdbh7AOLI0vF52pG_j81D8WRzjrKNP4KfFOpvQ>
    <xmx:-qW8Zxx3kYU53_h_rWB0ai8lgjtif4_2KCRRXb0d9GAjC_I7_Ldypw>
    <xmx:-qW8Z3JwYBi8YHsLF1-qEcQhyxLS7V93s2Ew7s_fKAQkb7I2rg7svQ>
    <xmx:-qW8Z2YZ35POedQZ39Pw1Mbl7rP6o7wu2IoDcOIm0oaS4wKjn49SifAc>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Feb 2025 12:01:45 -0500 (EST)
Date: Mon, 24 Feb 2025 09:01:44 -0800
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
Message-ID: <Z7yl-LsSkVIDAfMF@Mac.home>
References: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
 <Fg4QliwzbHj3m-Fr3ZeUiU11d6Bu-I7w_9xzSsnDlzQtqCkjgqxJpI6_YxuXnB8m0MqESq6V7vK7FhPnEcvGwg==@protonmail.internalid>
 <20250224-hrtimer-v3-v6-12-rc2-v9-1-5bd3bf0ce6cc@kernel.org>
 <874j0j1nv2.fsf@kernel.org>
 <Z7yUTNEg6gMW0G7b@Mac.home>
 <CANiq72kx31exTFohb3+9_=PGUq_JtqpCvG8=oQUc_gZB+De5og@mail.gmail.com>
 <Z7ye0MsACNWe7Mbr@Mac.home>
 <CANiq72=qayfPk+W4BRiXe9xBGcgP2zPf-Q3K6GXTg8MKy-Kg=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=qayfPk+W4BRiXe9xBGcgP2zPf-Q3K6GXTg8MKy-Kg=Q@mail.gmail.com>

On Mon, Feb 24, 2025 at 05:45:03PM +0100, Miguel Ojeda wrote:
> On Mon, Feb 24, 2025 at 5:31 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Mon, Feb 24, 2025 at 05:23:59PM +0100, Miguel Ojeda wrote:
> > >
> > > side -- Andreas and I discussed it the other day. The description of
> > > the issue has some lines, but perhaps the commit message could
> >
> > Do you have a link to the issue?
> 
> Sorry, I meant "description of the symbol", i.e. the description field
> in the patch.
> 

Oh, I see. Yes, the patch description should provide more information
about what the kconfig means for hrtimer maintainers' development.

> > I asked because hrtimer API is always available regardless of the
> > configuration, and it's such a core API, so it should always be there
> > (Rust or C).
> 
> It may not make sense for something that is always built on the C
> side, yeah. I think the intention here may be that one can easily
> disable it while "developing" a change on the C side. I am not sure
> what "developing" means here, though, and we need to be careful --
> after all, Kconfig options are visible to users and they do not care
> about that.
> 

Personally, I don't think CONFIG_RUST_HRTIMER is necessarily because as
you mentioned below, people can disable Rust entirely during
"developing".

And if I understand the intention correctly, the CONFIG_RUST_HRTIMER
config provides hrtimer maintainers a way that they could disable Rust
hrtimer abstraction (while enabling other Rust component) when they're
developing a change on the C side, right? If so, it's hrtimer
maintainers' call, and this patch should provide more information on
this.

Back to my personal opinion, I don't think this is necessary ;-)
Particularly because I can fix if something breaks Rust side, and I'm
confident and happy to do so for hrtimer ;-)

Regards,
Boqun

> If it is just for local development, then I would expect the
> maintainers to simply disable Rust entirely. I guess that may be
> harder in the medium/long-term future, but currently, I don't see a
> big issue not enabling Rust while developing the C side, no?
> 
> Cheers,
> Miguel

