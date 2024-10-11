Return-Path: <linux-kernel+bounces-361256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D3B99A5BB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 16:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC8F61C2157A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EA221733B;
	Fri, 11 Oct 2024 14:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="UI9p06EO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YTyAmV/u"
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4962141BB
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728655526; cv=none; b=JsPnk81ixhWrsqlqqbRtfmEbaLe7tHxdsR58mH9I69yZJbOHZdsKbnh0YYz5VHdWk2QcRsDe60l3LwrvxLM64dtXlpiYdaiQMuaK1eyKKUHTVAOzo4OGY285BOF4ytyUD36XXP9AP6ZULuOvswsaSJm1hnNJgjM77P0ofNd6Kdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728655526; c=relaxed/simple;
	bh=u6yT/Um4hvNM2ge9kKQ1JH8WLlPTlxc/21gqNhi91jQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FcqDwDeTUCsgim+h2iwYzyUDfjjq0Ix4nEfoDZkCkTa2BvNOpySBo2HIIfe9i+/F9L7cXIMiARhhXyjfieVA4vZPdG1MhPqMFkqAVmQ92ZCSs5ZIj9D7EzdSIGpcuQXv/NrNWCjJxKsM+uVb1YYUrmuQUTyff480OCP9SfPKGeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=UI9p06EO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YTyAmV/u; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3D10011400E7;
	Fri, 11 Oct 2024 10:05:23 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Fri, 11 Oct 2024 10:05:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728655523;
	 x=1728741923; bh=hSrJ7sThlVYb9UYhob4RXeFtpQGrFvUF+x++504Pu/Q=; b=
	UI9p06EOODd0Ziey6j6Zyi6ivd8Z1a3Cw9Wj1IDPJfKhJaUrAb2hli0bQxn8vgiY
	wDufsTGw83vHhYYVTSIZaO4ToxP5+7sdedC8+TqdaTyhm9IWy6cuspMMd0kEGD80
	0vaaMgzFSueV0khU2Z/LSkkkQsFaplgXEfYvdozI7kIDzU4AsqpP3RIlhRNt9RjK
	u9/cJ3eBpEfACw+vxSw7Pejh0wghjaacloVZRttPlLaeTfJg3DMXChnPRWc1/uMI
	CjZVDv4Eixa9b6hB8rVgBsIQqgU92IjN/T9Fi2kYxTdAxG5N2vhFGtqefVDopwAx
	0PN955KQOhLVCHjhhspFaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728655523; x=
	1728741923; bh=hSrJ7sThlVYb9UYhob4RXeFtpQGrFvUF+x++504Pu/Q=; b=Y
	TyAmV/u/xqr0O1WCXpk8mIHXdY+Wmri7KUWDUHBf9SS9J9Kwpug7hdFVPFMyiBv5
	d1IxSBgBDByAzayLT6iEYU3dH7YX5n/7P2ujlnC0+/PbtCzXGar2WCiz+DzOU9Vc
	sOFmO/4pEj4StsVQWYbu1FdrDu6Qae+n0DNKr6XRCcyDiLjPuxEGm0rkLVx+5KcQ
	AsBQGipJ/sljpHjwqLquzmv4kLQBP/KmrOowcnl/0wjhvRdTrhsSuIyEtGWXNps5
	1I7xAsR1lojJkovj8CbIwBZxaeQLOXKym5+CbC/JBRE9icPU0p7k1xa5ORAEGMs4
	U9AVD4bBmAtRo0jvoZJ8w==
X-ME-Sender: <xms:ojAJZ1uqqdIYV2WGwCGfvX9xvRRg9fAwuWeEC_8cTSHn50r-zvFMPg>
    <xme:ojAJZ-dmJV_1wpBxKYuaHEhaUsBc3G3gXgDOksaifZ9EB-jd-fKRpm02IF4JzKgMm
    _8oKnLvB9HKhG430wk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefkedgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhrghnnhgvshestghmphigtghhgh
    drohhrghdprhgtphhtthhopehvvhhvvhhvvhesghhoohhglhgvrdgtohhmpdhrtghpthht
    ohepfihilhhlhiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehnrghthhgrnh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhmsehkvhgrtghkrdho
    rhhgpdhrtghpthhtoheprghnnhgrqdhmrghrihgrsehlihhnuhhtrhhonhhigidruggvpd
    hrtghpthhtohepshhhihhvrghmuhhrthhhhidrshhhrghsthhriheslhhinhhuthhrohhn
    ihigrdguvgdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtph
    htthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhg
X-ME-Proxy: <xmx:ojAJZ4yytEPiViAXMQ_k3_F0b_Ef-v-BOIZ0_xdfa5X7gcNal4ZWHg>
    <xmx:ojAJZ8M5TXL6BxfWvmsYIPSH0tZqkGnbwwHxs6Mr6shhm-9Nh3LeHQ>
    <xmx:ojAJZ1-OzqITbG9-QzPOeezqh-4zAomJ1IPszwfCu0EO0fbWvQuF-A>
    <xmx:ojAJZ8WUVgjZUQLvVzPkH4z6xOpHOQGqM2iv6NAP14q3bjVpHCqpmQ>
    <xmx:ozAJZ8Vi_1Lr83H3CkOKS9h1YvB0ej7WmOTIkKjJ0_SZ9yNB8d2mJAQN>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E6D622220071; Fri, 11 Oct 2024 10:05:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 11 Oct 2024 14:05:00 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Aleksei Vetrov" <vvvvvv@google.com>,
 "Nathan Chancellor" <nathan@kernel.org>
Cc: "Shivamurthy Shastri" <shivamurthy.shastri@linutronix.de>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Vlastimil Babka" <vbabka@suse.cz>, "Matthew Wilcox" <willy@infradead.org>,
 "Johannes Weiner" <hannes@cmpxchg.org>,
 "Anna-Maria Gleixner" <anna-maria@linutronix.de>,
 "Thomas Gleixner" <tglx@linutronix.de>, llvm@lists.linux.dev
Message-Id: <a2e8a76a-9fad-4e3e-bce1-bf8a9d180464@app.fastmail.com>
In-Reply-To: <ZwevGZHiXOBqoslA@google.com>
References: <20240621111604.25330-1-shivamurthy.shastri@linutronix.de>
 <ZwRA9SOcOjjLJcpi@google.com> <20241008005136.GA241099@thelio-3990X>
 <ZwevGZHiXOBqoslA@google.com>
Subject: Re: [PATCH] mm/vmstat: Fix -Wenum-enum-conversion warning in vmstat.h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Oct 10, 2024, at 10:40, Aleksei Vetrov wrote:
> On Mon, Oct 07, 2024 at 05:51:36PM -0700, Nathan Chancellor wrote:
>> For what it's worth, I never really saw Matthew's comment around what
>> value does this warning provide addressed. I was the one who originally
>> moved it into W=1 at the request of Arnd because he felt that instances
>> of this warning could be bugs and they should be audited.  However, I
>> have not seen many instances of this warning pop up in new code through
>> 0day build reports and the ones that I have seen seem to be intentional,
>> as they are using enums like integral values, such as here. If that is
>> just going to result in a bunch of patches like this adding unnecessary
>> casts, I think it would just be better to consider disabling this
>> warning altogether or at the very least, moving it to W=2 (which is for
>> warnings that are noisy but might contain bugs), since more people are
>> using W=1 as their normal build configuration nowadays.
>
> If time has proven that this warning has never found an unintended enum
> conversion, then it is worth to disable it for everyone. As you said in
> the original thread ([PATCH] kbuild: Disable two Clang specific
> enumeration warnings), W=2 is not run by any CI, so I would prefer to
> disable it completely.
>
> Alternatives considered:
>
> * Enable -Wenum-enum-conversion only for 0day build reports through
>   KCFLAGS. It will eliminate noise for regular users while keeping
>   developers informed about new instances of this warning.
> * -Wno-error=enum-enum-conversion to keep warning but don't block
>   compilation for CONFIG_WERROR users.
>
> Arnd Bergmann, what do you think? Have you found it useful after all?

I'm fairly sure I saw users mix up 'dma_data_direction' with
'dma_transfer_direction' and unrelated enum-enum mixups in
amdgpu. There were probably more.

I think what happened is that in clang-18 and earlier, the
warning option caught mistakes of passing the wrong enum 
to a function and a few others, but it did not catch arithmetic
operations between enums, so clang-19 now produces a lot more
output than older versions, and I don't think we can
control those independently.

       Arnd

