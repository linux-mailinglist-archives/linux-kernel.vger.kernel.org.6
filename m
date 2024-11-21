Return-Path: <linux-kernel+bounces-417384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F859D5347
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 20:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2D6FB21FFB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0742B1BC9ED;
	Thu, 21 Nov 2024 19:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGrXuwiz"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF22F200A3;
	Thu, 21 Nov 2024 19:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732216251; cv=none; b=QO2hCWcka4ListmrIhkhYmP6vi5GSIBqQ3U7OYEBVPBhBw6N/kkrppszSBVN13+Jo/ax8raqsHF6Us7jCUjC6Lv1SCSd7Api60hrHKQQqqfX99IBhqWVLjoQ1dABV4xeXqww3lknH5prLENF96C3rK8rLpCimHOEOq5c1cel9ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732216251; c=relaxed/simple;
	bh=jYLvvSedHfv1S2LW/Xl6qeZajP1uONHYlSPoUiWtFis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3R/ZcBlIBbzSg2BOInZeDaCc+Qign9f7ze0M5m9n2r5PIrOb0DvpZYXZKIvdNvCUkk5BmJ5Y1fGKJy6eRtuDbfE358bYdkAIZyeTAtp82YKE6FOpPHyz/Fem6wzx4fdmKieQ6kEJHWTuxZ6FF9dYGrKlkQ5XYFd1qTt0oVeidc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGrXuwiz; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6d41eeca2d6so8933076d6.1;
        Thu, 21 Nov 2024 11:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732216248; x=1732821048; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mndBLNzJ+Ni1BuMLAuNFNji89qTPweETAMDxodRxvFs=;
        b=CGrXuwiz6McBQZAxWABwLoPV9+1HncrvSv5W7IUrG6O7f3ZuzT8rT6NBvUuWV0zr8J
         7JtrHX2IZdH8aJIgJa8GLFX8zyHWJTeNKseTlMx9qWVFxmqEcLwlyRoXuoDdBO6/r//C
         54Uy17pVlzfhEOYEEfIK8U3V+q4a4NkBmWll6u+VMzoTcUSz4daz8MQ7g2vxNeuTeJbn
         v96Wk6BMhzD2g7bQeHI0VDGsNV/WDVdJpoHeWXeEVuwkob18khnIPvi0/oVFSpGQGstW
         7cA3v/Qa5idZdUWd9yP1wnkjTdi/U1s9ZIAA9zwLVwMJ/fD+aQPCzPN64ZeqEhpqMaBA
         GStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732216248; x=1732821048;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mndBLNzJ+Ni1BuMLAuNFNji89qTPweETAMDxodRxvFs=;
        b=JRcxijojp8G388+psLUbqT6A8VXbyHgEk9r3vvXhCMoeV/UQtpQ0T2df09Ur+KSDFS
         A/kzFUt+zjBGc2rzJS6pY2m6slQarvsqXcloql00CtaOVuE6nJhhGIfnbM+mxExGET7P
         NPmOJd/YkP/iOPGQG1ui4TqBSFUV9g5T4p1sRS3cojpcya6dmbMJWUhlA6Kkn3WTmbVk
         nZPOt6eks+M6T+godQFnDRVLeXJsvGAl0aoXLQmn/Q3QFo4nbUAGdlesEsycUcZ/bJdD
         Kf74Om7s+Bjqz35UnnshPrgWCTCw4RNrsixHyR3Fg/qT66UwEDamo7TKERV7fdnBDDl5
         Bbmg==
X-Forwarded-Encrypted: i=1; AJvYcCU6LsOXup2LYfV/TT0VOFGCko0kqRF3PB8VONZ0qnhBO3HitfBtu19qzwQVHTJF6hobO0eIrrcbVV0ixmbjnGw=@vger.kernel.org, AJvYcCVCFYwjTThgG+M+lhgm8Gi8hbhFzGVS2XB2vIeOgdo3Se9Mdod9ITzFlQRh1T92DGswqi1Q5Xmi5iXFW80=@vger.kernel.org
X-Gm-Message-State: AOJu0Yweot8lt0f8HIwGr9xUG9hLSi7QD/bu28/EKVNcXVb+PAE3Z6VC
	NUKaqEbSBsUL6k7D3evqVLe6TC8dClCr0s0pb90l7Bbpt54gxqig
X-Gm-Gg: ASbGncscwhE7Arr6mmFXr1evr11/gsoe2E6xNRIG2Sz8QYLAD17zfewwEX8UXRCKt4n
	n0DmPVeN7QPOBCE6mtmVbVl65bogNTPtl0vtFReikyYIormAX6sgJti4to/gSoKsMdjDVnOEVSP
	ab+tCstE0NhbksLkw3m8Uv9ftgHDbWrSTIkSE5mx6t6FWJnkHuQTRHB4XGK9TUj8aPYDsiB8MMu
	87pd8zB8asQTy5JB2WrgvHqrOGjaQViwERl2JHFXaGK2tr5M+bIhabgPJPBsz9Et+ewz8A9sxfO
	3AKCOB9P3+/aOtAxPkTB0CBmKdjKkrlRLU2URLky
X-Google-Smtp-Source: AGHT+IE3EG78k8zKCjeh5hjn2+K+HjogsMTfgQ2VCCRmJRLUKsnlTob6emyf0BQC3dIB0wmhUpVEVw==
X-Received: by 2002:ad4:4eec:0:b0:6d3:f1ff:f8d6 with SMTP id 6a1803df08f44-6d451360ff4mr4235686d6.40.1732216248463;
        Thu, 21 Nov 2024 11:10:48 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d451ab53dcsm695156d6.56.2024.11.21.11.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 11:10:47 -0800 (PST)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 3D2891200043;
	Thu, 21 Nov 2024 14:10:47 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 21 Nov 2024 14:10:47 -0500
X-ME-Sender: <xms:t4U_Z1k4golFVUEC_5Tp6WZ7K24NpeWYXELnQ3z4UJemA9AOTHAshQ>
    <xme:t4U_Zw0QFPPUWXJ9W6VL1pr_l3TK9BS5I6LHZy-xR8bfHkl91nPKN7d4UJUD6LoDu
    Z2lVY7kd0II467FFQ>
X-ME-Received: <xmr:t4U_Z7rbUo9xZDelKTx56vzuflyzzrgYh_yI9Mk4i5JCp2LWDRNzmoMA75c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeigdduudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleei
    vedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudelpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrsgguihgvlhdrjhgrnhhulhhguhgvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdrohhrghdp
    rhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhope
    hruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhi
    hnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhn
    vghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpd
    hrtghpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgv
X-ME-Proxy: <xmx:t4U_Z1kWDJhkQj1vlAtpipXc7E_tfqqzYK_0O_UCnOL8onW2McqyYQ>
    <xmx:t4U_Zz0-iZ1fNMdl5kZi_Bjw1MAIldh_SL9EECbY14LArOMwEaQXag>
    <xmx:t4U_Z0vqfCjahQpqIbAAzZiUbM7b72VkfEEiSLNGd7o8jUcbnmjj4g>
    <xmx:t4U_Z3W1cPFqKTVht0M5fJ0yc6Uv5xOoZpTwulSCfoeEuykWChYeJA>
    <xmx:t4U_Z60tkdYtMeJYGk5GHCpxjk0ruru9F7bew22jtndYh9x4EsEBkZF5>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Nov 2024 14:10:46 -0500 (EST)
Date: Thu, 21 Nov 2024 11:10:45 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Alice Ryhl <aliceryhl@google.com>,
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
	airlied@redhat.com
Subject: Re: [PATCH v3 0/2] rust: page: Add support for existing struct page
 mappings
Message-ID: <Zz-FtcjNm0TVH5v9@tardis.local>
References: <20241119112408.779243-1-abdiel.janulgue@gmail.com>
 <Zz1sHZLruF5sv7JT@casper.infradead.org>
 <CAH5fLgiyHGQJxLxigvZDHPJ84s1fw_OXtdhGTd0pv_X3bCZUgA@mail.gmail.com>
 <Zz4MQO79vVFhgfJZ@tardis.local>
 <Zz4WFnyTWUDPsH4m@casper.infradead.org>
 <Zz4boXyYpdx4q35I@tardis.local>
 <98a46b27-c4bb-4540-8f75-f176c3f2fae1@gmail.com>
 <Zz59qgqKruqnouTl@tardis.local>
 <650846e4-b6a0-472d-a14e-4357d20faadb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <650846e4-b6a0-472d-a14e-4357d20faadb@gmail.com>

[Cc Kairui in case he's interested]

On Thu, Nov 21, 2024 at 11:30:13AM +0200, Abdiel Janulgue wrote:
> Hi Boqun, Matthew:
> 
> On 21/11/2024 02:24, Boqun Feng wrote:
> > > > So if I understand correctly, what Abdiel needs here is a way to convert
> > > > a virtual address to the corresponding page, would it make sense to just
> > > > use folio in this case? Abdiel, what's the operation you are going to
> > > > call on the page you get?
> > > 
> > > Yes that's basically it. The goal here is represent those existing struct
> > > page within this rust Page abstraction but at the same time to avoid taking
> > > over its ownership.
> > > 
> > > Boqun, Alice, should we reconsider Ownable and Owned trait again? :)
> > > 
> > 
> > Could you use folio in your case? If so, we can provide a simple binding
> > for folio which should be `AlwaysRefcounted`, and re-investigate how
> > page should be wrapped.
> > 
> 
> I'm not sure. Is there a way to get the struct folio from a vmalloc'd
> address, e.g vmalloc_to_folio()?
> 

I think you can use page_folio(vmalloc_to_page(..)) to get the folio,
but one thing to notice is that folio is guaranteed to be a non-tail
page, so if you want to do something later for the particular page (if
it's a tail page), you will need to know the offset of the that page in
folio. You can do something like below:

    pub fn page_slice_to_folio<'a>(page: &PageSlice) -> Result<(&'a Folio, usize)> {
        ...
	let page = vmalloc_to_page(ptr);

	let folio = page_folio(page);
	let offset = folio_page_idx(folio, page);

	Ok((folio, offset))
    }	

And you have a folio -> page function like:

    pub struct Folio(Opaque<bindings::folio>);

    impl Folio {
        pub fn nth_page(&self, n: usize) -> &Page {
	    &*(nth_page(self.0.get(), n))
	}
    }

Of course, this is me acting as I know MM ;-) but I feel this is the way
to go. And if binder can use folio as well (I don't see a reason why
not, but it's extra work, so defer to Alice), then we would only need
the `pub struct Page { inner: Opaque<bindings::page> }` part in your
patch #1, and can avoid doing `Ownable` or `AlwaysRefcounted` for
`Page`.

Thoughts?

Regards,
Boqun

> Regards,
> Abdiel

