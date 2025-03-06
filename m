Return-Path: <linux-kernel+bounces-550060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 724E6A55AE2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 00:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49051177701
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 23:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A902927C868;
	Thu,  6 Mar 2025 23:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="6A2bATzE"
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A087027C850
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 23:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741303469; cv=none; b=u3LE6LS8e9GJoyuBqyJb0Gjb3i9dAMfnZvd5HTBgfmVIUrWcrYN117rEaOk+ZG8r+imma/TYaxrmU1qaW3mzMFupcYx1Vkn/zalZBepqIHwvFx48SK+pQq7XnkeqRh5l5pZfzws6OwPWh4MpMPUet/RkZs5rV2KKERyQnhOTlLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741303469; c=relaxed/simple;
	bh=s4wXsJyCt3WEpZdDnf0LYOrj5A0I/v+C9Z/YioEK024=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WkaDPJQZARZ0VVfDQfSL8+ASVamh7ooPlGQVNkHOtHX/i/1H8iJqToqCyGH9aw9/b+rU5/cHDJJHW8o3k1lPKzL7u/l5zQOrNfKDLNwpPZB8l+cTHefWX2+O06QlBQnL3eV3d7etpwDl59/pzbcOdy4/6cyBuBlzCZJpuV+KsMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=6A2bATzE; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 91F761380F05;
	Thu,  6 Mar 2025 18:24:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 06 Mar 2025 18:24:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741303465; x=1741389865; bh=KhDwqtCpAd7VH12gvzsh/kOm4+lf9ccAyj5
	jKcTiiHs=; b=6A2bATzEeCGfau9XjfdAcYFUA4bk2R5d7lvE9P3BUNjZM63sQDx
	CANjspaTlSWtPwDKaItzg9GQRxmsLLbTZoqgTvaPLRY2SB73KgbYFZx4nyMMtmlo
	9MZpAvqNuUqS8hK/bpxDH1kfgn4VnHezlYuaRSdK5E0T5i/XFHUF+TxKpoJhU/6I
	T28Ae+MswW7zgMIjQgxRZd6ak4OkqVguVRANxZ150IESGlwMupCp1I0pswJ+JMpx
	1P6i5vtrHBfT5Uwvk5a7/ciSfAVpQQBI82CHrT5vAyQ4e5vaS3PFmO/KRliHjm2q
	e2qmHKUaVBQAHd/CXf/MYP8vEykDmxIt8lg==
X-ME-Sender: <xms:qC7KZ5LYIB8sQvnQEnt0PgSX3WBW0pvlP6Yasih_ezQ-ccnas9x4Ng>
    <xme:qC7KZ1J-HU79hC_xhEgJgHcYjY44T_dDmL38l60rDI-In-X9jI3Vy94MHykGCr70j
    kTEAcWEM171dnl7mc8>
X-ME-Received: <xmr:qC7KZxvNBEnOxps_mT4QzxoXBuIRJ4KV4xhRGoZWG3OGzUNtTgVkyg_Xwb754e2ZNO6amTIL6Rg4QhrgZA-rwf7jmGGvCX7aO9U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdeltdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddv
    necuhfhrohhmpefhihhnnhcuvfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheike
    hkrdhorhhgqeenucggtffrrghtthgvrhhnpeelueehleehkefgueevtdevteejkefhffek
    feffffdtgfejveekgeefvdeuheeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgpdhn
    sggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgvggvrh
    htsehlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehthhhorhhsthgvnhdrsghl
    uhhmsehlihhnuhigrdguvghvpdhrtghpthhtohepjhgvrghnmhhitghhvghlrdhhrghuth
    gsohhisheshihoshgvlhhirdhorhhgpdhrtghpthhtoheplhhinhhugidqmheikehksehl
    ihhsthhsrdhlihhnuhigqdhmieekkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvg
    hrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:qC7KZ6YCGSugpACtRqyvnxxqOkGh-Xxukp4T4v4w6ORA58OsQQDOMw>
    <xmx:qC7KZwYJU3MEc0rm_uTa8eSBizjpxfcM5rlq33WW3B9ApGx3Ab1HcQ>
    <xmx:qC7KZ-DX5LqMlgLcZbsKAst6xzAo270csrxzmcBbbJAzrS9o_ksY2w>
    <xmx:qC7KZ-a7gOJmf8xeAHDcItLgX3UpMUJnhU6FzIkUMoSv_nQeFOtWLQ>
    <xmx:qS7KZ3Whe36ZD67poxIJUrmoks7_-G0trfP3RejCFJ_7TYANH6WpFOsX>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 18:24:21 -0500 (EST)
Date: Fri, 7 Mar 2025 10:24:22 +1100 (AEDT)
From: Finn Thain <fthain@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Thorsten Blum <thorsten.blum@linux.dev>, 
    Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>, 
    linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m68k: mm: Remove size argument when calling strscpy()
In-Reply-To: <CAMuHMdUonC54g-XSt-EkNbEGxhkOWMxBc87Qtw0MyeXoPqDD4A@mail.gmail.com>
Message-ID: <e5e10808-5cca-243b-304f-4aa8db1d30b6@linux-m68k.org>
References: <20250302230532.245884-2-thorsten.blum@linux.dev> <CAMuHMdUonC54g-XSt-EkNbEGxhkOWMxBc87Qtw0MyeXoPqDD4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Thu, 6 Mar 2025, Geert Uytterhoeven wrote:

> On Mon, 3 Mar 2025 at 00:07, Thorsten Blum <thorsten.blum@linux.dev> wrote:
> > The size parameter of strscpy() is optional and specifying the size of
> > the destination buffer is unnecessary. Remove it to simplify the code.
> >
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> i.e. will queue in the m68k tree for v6.15.
> 

The commit message says "simplify the code" which is only true if you 
never scratch the surface (i.e. it's simple code if the reader is simple 
too...)

Commit 30035e45753b ("string: provide strscpy()") was a good idea. It was 
easily auditable. But that's not what we have now.

Patches like this one (which appear across the whole tree) need reviewers 
(lots of them) that know what kind of a bounds check you end up with when 
you ask an arbitary compiler to evaluate this:

sizeof(dst) + __must_be_array(dst) + __must_be_cstr(dst) + __must_be_cstr(src)

Frankly, I can't be sure. But it's a serious question, and not what I'd 
call a "simple" one.

