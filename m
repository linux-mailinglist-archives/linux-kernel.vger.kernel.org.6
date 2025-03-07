Return-Path: <linux-kernel+bounces-550700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3901A56317
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 135D67A736A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E043919E971;
	Fri,  7 Mar 2025 08:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tQ7yE1Eg"
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA321A5B9E
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 08:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741337926; cv=none; b=Xcv1xQCVa/PEXI8QBiqsihz0Zk+b9oTIoFDjmpS6IFsH7q8FVQwNW5ZNxrp0m4NbSlm7cFclwGNRskd26MUPRYPTwjqTSYcg56cFPaklo3+VD19FaSfXaL+oFJixuduodv3UQepCfht9NfQH6bfb833Q7uqhpltWb+KurP7Wplk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741337926; c=relaxed/simple;
	bh=ZjIQfWG83oRMyHUQO4OLqSgSMHEWjUJSojUPoWkoC0c=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dh4QIZDaDonKJANvDXPH1NrhOY/DqTXu8fJ/lyCWVT+5fK2CDU23M+Jmdy6gsu83e22pPAxFq+IXsDDWGvmFpMkXRB1303+97Y+MAAk38ScRL+GQRSX2nw7zU9vALFzun9RRYzgz/8KZ8yptfLXqRZw+EktJzGITqVX5JpitHFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tQ7yE1Eg; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C62CB11401BE;
	Fri,  7 Mar 2025 03:58:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 07 Mar 2025 03:58:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741337922; x=1741424322; bh=QPeVGTBd43rKn7LkcJDA/FXYNYp2iIcX4WE
	UvEUfYNM=; b=tQ7yE1EgJ60/UNnooVX4mQmvkVu0xuEswZPUEIJNovrTsWDaOeV
	+pxZQlK85pyoGpROjrehmBJPfQN80xCqPyan4mGrhB/0ELwTVei5pVUhIQGnN8Z/
	n8ZA6Bl72ujJt7nM+GAAcPWGaPFst0Uoc0fjskdktQyEnkyDydJklOF8vljQI5DH
	HTCqstREL9Nd3jLw7iNhFzsCJH8a5mzO8a2N3VMJLrijeFc5sBnDleWM7cpZ5kTE
	A0rsTUZhZnLfqBIV673rUZF2ErQsf8o4Vk8eiFrFS2OQUTgo8WJys66QRlX8VYEb
	YGzHlpTPymXoMMR4dTILW+UV8gFPsbVuTlA==
X-ME-Sender: <xms:QrXKZ_bL6_1JjNNoqg07-tNIduz_4sz4BhuJdZ6x5CRYd3w2QmU_ug>
    <xme:QrXKZ-b3YpkWD31NY68_lYhQv_OxuBoQWYIInuMJ2nEbRcwLbjkLBgmS2eb41DUh-
    AqOkdQdQmrYGvVhCEw>
X-ME-Received: <xmr:QrXKZx-JRC0zqwfGDZbBRL1QMmY2FZ75W_Au-IZDXf4yTzkoapA76XTBtdIKDtVm3mAURAy4fY9n8AYG_VklA7NamLcMZTOqiKE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddtvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddv
    necuhfhrohhmpefhihhnnhcuvfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheike
    hkrdhorhhgqeenucggtffrrghtthgvrhhnpeelueehleehkefgueevtdevteejkefhffek
    feffffdtgfejveekgeefvdeuheeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgpdhn
    sggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgvggvrh
    htsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehthhhorhhsthgvnhdrsghl
    uhhmsehlihhnuhigrdguvghvpdhrtghpthhtohepjhgvrghnmhhitghhvghlrdhhrghuth
    gsohhisheshihoshgvlhhirdhorhhgpdhrtghpthhtoheplhhinhhugidqmheikehksehl
    ihhsthhsrdhlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvg
    hrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvggvsheskhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:QrXKZ1qo12hFO_G5ANML-5eSLqQZ_-jAS_CAgdLxIiNJ2pT1dN-uWg>
    <xmx:QrXKZ6pOT-BJZUIgzVRiTJoBOzUDbY-tzlso8su4Arks7Yp-sX2twQ>
    <xmx:QrXKZ7TWDzRKX1eKCJ7SHp2hpKvpA76HycKw0VtLMBx_d53G6g6eAQ>
    <xmx:QrXKZyq0Md45kuKrjVGXSpyl-ONSB_VO1xrjgrYHl704P_7gy50MeA>
    <xmx:QrXKZ3DKV8ffoweirEjSVDm1TLFWHjSeF5CNp-ecBzUmAvu1TW14NZLE>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 03:58:40 -0500 (EST)
Date: Fri, 7 Mar 2025 19:58:39 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Thorsten Blum <thorsten.blum@linux.dev>, 
    Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>, 
    linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
    Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] m68k: mm: Remove size argument when calling strscpy()
In-Reply-To: <CAMuHMdWjOkUXy+jf0yghs2_SQM3UWY3e8or3T11=fXYYD-VJEw@mail.gmail.com>
Message-ID: <dd1425d0-6d46-86a7-b508-ff0a646d61c0@linux-m68k.org>
References: <20250302230532.245884-2-thorsten.blum@linux.dev> <CAMuHMdUonC54g-XSt-EkNbEGxhkOWMxBc87Qtw0MyeXoPqDD4A@mail.gmail.com> <e5e10808-5cca-243b-304f-4aa8db1d30b6@linux-m68k.org> <CAMuHMdWjOkUXy+jf0yghs2_SQM3UWY3e8or3T11=fXYYD-VJEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Fri, 7 Mar 2025, Geert Uytterhoeven wrote:

> On Fri, 7 Mar 2025 at 00:24, Finn Thain <fthain@linux-m68k.org> wrote:
> > On Thu, 6 Mar 2025, Geert Uytterhoeven wrote:
> > > On Mon, 3 Mar 2025 at 00:07, Thorsten Blum <thorsten.blum@linux.dev> wrote:
> > > > The size parameter of strscpy() is optional and specifying the 
> > > > size of the destination buffer is unnecessary. Remove it to 
> > > > simplify the code.
> > > >
> > > > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > >
> > > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org> i.e. will 
> > > queue in the m68k tree for v6.15.
> >
> > The commit message says "simplify the code" which is only true if you 
> > never scratch the surface (i.e. it's simple code if the reader is 
> > simple too...)
> 
> The code is simpler in the sense that the API is simpler to use, and 
> harder to abuse (i.e. to get it wrong).
> 
> > Commit 30035e45753b ("string: provide strscpy()") was a good idea. It 
> > was easily auditable. But that's not what we have now.
> >
> > Patches like this one (which appear across the whole tree) need 
> > reviewers (lots of them) that know what kind of a bounds check you end 
> > up with when you ask an arbitary compiler to evaluate this:
> >
> > sizeof(dst) + __must_be_array(dst) + __must_be_cstr(dst) + 
> > __must_be_cstr(src)
> >
> > Frankly, I can't be sure. But it's a serious question, and not what 
> > I'd call a "simple" one.
> 
> All the __must_be_*() macros evaluate to zero when true, and cause a 
> build failure when false.
> 

It seems to me that the code review problem could be solved either by not 
churning the whole tree, or if we must have the churn, by short-circuiting 
the recursive search by reviewers for macro definitions.

Can we do something like this?

sizeof(dst) * !!__must_be_array(dst) * !!__must_be_cstr(dst) * !!__must_be_cstr(src)

At first glance multiplication appears to be safe (unlike all the addition 
terms that we have) because the limit of the string copy is either 
unchanged or zeroed.

Yes, I know you said "zero when true". That looks like another design flaw 
to me. But maybe I'm missing something that's more important than 
readability and ease of review.

> BTW, Linux does not support being built by an "arbitrary compiler": only 
> gcc and clang are supported.
> 

So only gcc and clang must agree about all of the details...

