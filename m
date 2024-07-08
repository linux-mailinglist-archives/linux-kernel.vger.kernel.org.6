Return-Path: <linux-kernel+bounces-244786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B9BB92A988
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7C3BB215A5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA8514B95B;
	Mon,  8 Jul 2024 19:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="R5iI5lmW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vWj1Xje6"
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370B21CA89
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 19:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720465455; cv=none; b=EL+WlMgUyvIc+f5qHm5eoW50dWd/i1BgoZb0keH+lEnhhkrEJK5LmcYvJrDaSwg8vhftQXRqmilvndLN34c7F5DjGfWZiIC5FUr1OVo9+YkUds1lWUXJRXKW1qkiaTtzYLVtOZDCLjcw8mJoa8LROWU3QDbzJCuvHK31jfhvZMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720465455; c=relaxed/simple;
	bh=dg/y9SVgLj8+LExhR87nuzCJG7Sp000jfOi6T9jm/CU=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=FPXKMTZdBjEAXa3620p8xhPYvbex5pHgV4KyATwHQAO+LQxLcsDhaVgaNv+og3BagRhFvfdLFqa3ROIq3h7qd2egO0o2XLRAyTWWBaDb8+Oy97O9Lnq9InYJRcyrN1VmQ9OnO+KA+mhQeOaKzP0Wq3l10Z1z/JfaQhJZZ7bBxKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=R5iI5lmW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vWj1Xje6; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2E2C6138019B;
	Mon,  8 Jul 2024 15:04:12 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 08 Jul 2024 15:04:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1720465452; x=1720551852; bh=6i2dhfJybE
	BeRl1sbHfNDLBM2hRI88tH+fOvYf1kUE4=; b=R5iI5lmWyJlOoZj1phtAWvfoNI
	JHR8RzX83q+kAYMiVxUd8c68RHxV3rjWY3Rgibw6c9+OtWhjLW4Cr10RqVZjso9x
	yVRSnOOdLdScLGcseOFhxwxlmwIV5iGfEvTTFWjVhH3bVZoznZ63mQM759TUy3yh
	O9Xp9Y7JzT63RnohQ8nc2VtWD7uCss38nl3vrdRQqAvJ0g8jDZwXTa4x6RKcC3IB
	2VcAsrttH0ULPV1PSiTHGXtJjJgHmYhh8WKOsXtQgpIkQFLlS+IZshTDcpEnXe9M
	MyA7WWMpB5dET2QgUaUl8Z92IhE6RD0VcjYNZlb0YnWHxvw7W+gcHSX8vrWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720465452; x=1720551852; bh=6i2dhfJybEBeRl1sbHfNDLBM2hRI
	88tH+fOvYf1kUE4=; b=vWj1Xje6fOVjh92Yep0f6KlHfz+Trkz7eZ15mfTbYSbN
	wdygL67DrDfUlPWvTulVqZjvqJA2g/Ku38lWXQSQCINk09ubY/Fm1QyMMhYMcA6X
	BBu+X8V9w9rTFy20TrIieJJBAeMvbPEO+HuA+knO/+tD6LcoA4GqYaIzU6uMC6Ne
	RZodmZVFav3xLUrUrfvt3W8MS6rJ9PGjeETPrkSK5ELAMxrGeEe5LL47g96XBtPO
	LcZcH7IvQFy/392/x8VLwGJZif+KWjqMECAGb+Pz4ihseuiJq0sad8PTBUATRmct
	Ybo7Ngj5JslVOygnl1NLCrVwgLgTnvc1aOlXyk13ww==
X-ME-Sender: <xms:KjiMZpLkqsuzlDy-D603xKfcZ8WwTV31GxKfMh-pLetq3mYVELIsyw>
    <xme:KjiMZlKarNtP1X8omyXp5ArhYJzfBN74HT4X0_G5KoH2LvaE2mXEGaDNpzbpN_Ufp
    83uOb9AFVLGU3ci4ys>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejgddufeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:KziMZhu5G_Kj4MSpPCDiWPbwzfgSE5oC927ZKZlNdQGUDyUmeG1wWA>
    <xmx:KziMZqZ-41FHMgmsYmAXFyRaB8IyMNh6MSUvUzGjnYOKyDkOLksS-g>
    <xmx:KziMZgbV8TKB-hsPPGjSv-yYmYGZTUrRBXUinmxjw6kYnZAJTkJlcQ>
    <xmx:KziMZuCzyQwBM3-LCVUkIUt1eCLnv9q4im_4KxP3wA6P0aM_2Gd7hA>
    <xmx:LDiMZvk8JAUyRaQqNqI9Dp4PT0EjaU_Wdoa_sGXqIv9TOE5S-Kwi_DEO>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E73AFB60092; Mon,  8 Jul 2024 15:04:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0ddafa32-1fc2-45e1-b71c-beb64f8cd589@app.fastmail.com>
In-Reply-To: <87y16bbvgb.fsf@kernel.org>
References: <87y16bbvgb.fsf@kernel.org>
Date: Mon, 08 Jul 2024 21:03:22 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Kalle Valo" <kvalo@kernel.org>
Cc: linux-kernel@vger.kernel.org, ath12k@lists.infradead.org
Subject: Re: crosstool: x86 kernel compiled with GCC 14.1 fails to boot
Content-Type: text/plain

On Mon, Jul 8, 2024, at 20:16, Kalle Valo wrote:
> Hi Arnd,
>
> I installed GCC 14.1 from:
>
> https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/14.1.0/
>
> But I have a problem that a kernel compiled with that compiler fails to
> boot on my x86 NUC test box. I don't see any errors, just black screen
> and I assume after that the kernel either crashes or reboots and goes to
> back to the GRUB menu. This loop seems to continue forever. GCC 13.2 and
> older from crosstool work just fine.
>
> Do you happen to have any ideas what could cause this or how to debug
> further?

Thanks for the report. Unfortunately I have no idea what the
problem may be, and so far nobody else has reported this.

For debugging, what I'd try first is to run the same kernel in
qemu to see if that works, or attach gdb and step through the
early boot if it doesn't.

I have tried reproducing it, but with my arm64 hosted x86-64
cross-compiler, it boots a defconfig x86-64 kernel in qemu just
fine.

     Arnd

