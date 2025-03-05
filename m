Return-Path: <linux-kernel+bounces-547894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E678FA50EF2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 442687A4BEF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD762066C7;
	Wed,  5 Mar 2025 22:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="D585Cd74";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4ulPzn2Y"
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE61D1FECC8
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 22:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741214738; cv=none; b=ScLvGteFSd8/5Kja1n3wH5bWSRM03/6U47dK5D52hu15zLAmPHkR/gSGPIDD6yYSfTxLoAONQ1tYVDwLMZFVbyWpINmK6FMzhlcFIWDj+DqbFdPmV1UOcYqHBgPL3yQCwIsorQ8gwcaqCCilBVG08nv1s4zfEIh1TEoniAmFPvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741214738; c=relaxed/simple;
	bh=S2mN0Du9NxB3pZ4Bz9u7D8C4osIfzedKP2xCz0roxS0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=jaIdfvLYkIKemroERntvXczA+2CMnTd3woZaHUuXVTWkNq6YIQDIweZZiRgTP2t838bBvdfa7T69Kx9Q2ukNwXB30WxaQ6fY/J992buyP4PpNqolmSYvkHHljbCcroO6AG7AIVEaJNW3GElDYcZORSW1E5WZUs1kAueaQGn//Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=D585Cd74; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4ulPzn2Y; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 844A511401E2;
	Wed,  5 Mar 2025 17:45:33 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-09.internal (MEProxy); Wed, 05 Mar 2025 17:45:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741214733;
	 x=1741301133; bh=7no6oD8eDEq6oEV5ur9hLid6tyJWjib7jvtignAXt6I=; b=
	D585Cd74YK2rBSvvNtiFASGJSHGV2LNb/GoIluxluymXabYraueVA4aWe3//NYgX
	XA5bvtReIzq+SOcT4c5mgpsrzSmaBT2JsfLG7okS2jVJ4/wYSHx6UnBMDPvMXbzJ
	2Mff/wFLv+o91AqMqeuWes3nHPBxf+ycLrlD3BpAE8rZVgGdg7veupLscQxEKbUh
	k30UqP3g5J+9nbOqB4MIr0pWFHoFTrD1+ue7tsbgMXxABCCd5Ddqts+Lca2USlK7
	S/J3uY4tvujwr/ulvsApJbPI2SvwkMnKBhA8fsz/olG3p3fsyAGgDBaM2O+L+62C
	s1xqGcHHrIt9JzsQ65r+ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741214733; x=
	1741301133; bh=7no6oD8eDEq6oEV5ur9hLid6tyJWjib7jvtignAXt6I=; b=4
	ulPzn2YUOxzK3ibl4zUeOUxlvVBRFmhIbyJzwAdTXcQeXn+uEQXtjWIt+SGOevh6
	hAeIeR8AwGDQHlydQ+PjjMFk6O5xS8dknP24H3OkEU529S7oAYRH4UmJ108A6hdG
	KFaA/QJPgDyUk32qUTUdv8cUpr4jrt/ADgESj8d9JQvqmkt26pHYW9e/TStRFuD4
	Ygmc/SXx0KGn4+jBb0/dz3CPJFl0X+YMBvfALmOz2o1T9Ll/g4FmgMN8sd9bjHX2
	YrlynsKUYqruaMh8Exi+T7nhFuSLjxiJw9dkENQsRbIcBHfr9VkAeA/t4288AGJS
	qmoJx8P1Aq1HwnBYZJoJQ==
X-ME-Sender: <xms:DNTIZxjyfSP9GF9Fb5qW-40WBvJHbShIK2FbugMm58y9EqbnEfQZwQ>
    <xme:DNTIZ2DAN4oZtiWUbhpVqYRKB7NF9gKGlkpIJ40wac0huKvmF2HKY89qpWHRLTgiX
    V-ZzTOE6ueIXTG4q_8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdeitdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    udegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsphesrghlihgvnhekrdguvg
    dprhgtphhtthhopehthhhomhgrshdrlhgvnhgurggtkhihsegrmhgurdgtohhmpdhrtghp
    thhtoheprhhitghkrdhprdgvughgvggtohhmsggvsehinhhtvghlrdgtohhmpdhrtghpth
    htoheprghrnhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhnghhosehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopegurghvvgdrhhgr
    nhhsvghnsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepkhhirhhilhhlrd
    hshhhuthgvmhhovheslhhinhhugidrihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:DNTIZxGBc4BgCGmdig2A78vlcHG8hx6pKrG4p3PIyDIsUs0QJGFqBQ>
    <xmx:DNTIZ2SmsnVtpH4SMn-ZuicialcbIvTuhmvpVkZPFIJUQRH6AJQKXg>
    <xmx:DNTIZ-x0Avc8gP2GR3901n_dOggPXSRuB4J5S2p0lJqEcTzx-0kfDw>
    <xmx:DNTIZ85sjlPTUhHxwmx31O9q-8i9Wj69ojySWcTLuR61wLk-uSwGnQ>
    <xmx:DdTIZyjZYBLVZS8tPW5MtfoCpGkiEb4NBKWzlIMo-MTWonuhUPDHikSt>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 828C32220075; Wed,  5 Mar 2025 17:45:32 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 05 Mar 2025 23:45:11 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Borislav Petkov" <bp@alien8.de>, "Ingo Molnar" <mingo@kernel.org>
Cc: "Arnd Bergmann" <arnd@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 "Ingo Molnar" <mingo@redhat.com>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>,
 "Rick Edgecombe" <rick.p.edgecombe@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Tom Lendacky" <thomas.lendacky@amd.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org
Message-Id: <a6145d2a-e1a9-41b4-8017-5bbf37ec2d65@app.fastmail.com>
In-Reply-To: <20250305222052.GAZ8jORCVmKQhEkrw6@fat_crate.local>
References: <20250304143340.928503-1-arnd@kernel.org>
 <Z8grEnsAcMrm9sCc@gmail.com>
 <20250305221700.GPZ8jNXPCFR1w1NyEQ@fat_crate.local>
 <20250305222052.GAZ8jORCVmKQhEkrw6@fat_crate.local>
Subject: Re: [PATCH] x86: coco: mark cc_mask as __maybe_unused
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Mar 5, 2025, at 23:20, Borislav Petkov wrote:
> On Wed, Mar 05, 2025 at 11:17:00PM +0100, Borislav Petkov wrote:
>> 
>> Touch ~17 spots:
>> 
>> $ git grep -w cc_mask arch/x86 | wc -l
>> 17
>> 
>> just because of some stupid gcc extra warning switch?

It's only one outside of CONFIG_ARCH_HAS_CC_PLATFORM, the
other ones always see the 'extern' declaration.

> This warning has been kicked out into W1 once already for too many false
> positives:
>
> c9c6837d3931 ("kbuild: move -Wunused-const-variable to W=1 warning level")

Yes, that was me. We have now come to the point where only about
a dozen instances are left and I resubmitted the remaining patches
for most of them.

There is a twist here: clang by default warns about unused const
variables in .c files but not in headers, while gcc doesn't
warn about them at all unless it's explictly enabled, and then
it warns about both of them. Newer gcc versions have a distinct
-Wunused-const-variable=1 for the clang behavior and
-Wunused-const-variable=2 that warns for both, so we could
reasonably decide to enable the =1 version by default and
leave the =2 version for W=2.

On the other hand, most of the users of 'static const' variables
in headers are rather dumb and should just be moved into the
file that uses them, or they can be replaced with a #define
or an enum.

In this case, the only user is a macro:
#define _PAGE_CC               (_AT(pteval_t, cc_mask))

so maybe '#define cc_mask 0' would be appropriate.

    Arnd

