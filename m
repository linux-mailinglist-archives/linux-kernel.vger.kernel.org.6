Return-Path: <linux-kernel+bounces-554279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EC3A595A4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 280F3188A31B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E56A229B00;
	Mon, 10 Mar 2025 13:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="FYzK+YX/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="7jixCHNs"
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB67A178395
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741612261; cv=none; b=C/8H2YImRjNoNWOilO7YtPxmbaIhJNNDul2ZPDujLsq68/8WTQxNAwvdAkTo7V6tlLyxS2sAZ8r1r69fkcmvW/GKC9pGkL2GvX7pAOlKe8GodK8QJiiws3EH+RQWdOE7PCKO7ET/GfgWD8wpkBMU28NxemkC+PMvr/+nj0ueahE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741612261; c=relaxed/simple;
	bh=/YBgUHgorEByh1qRn8grRlvMisGp1g3JEl01KzlpUz0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=HZUEsNBYeasPExuM73sJs6S8JfiZwAtvooyrU0Yavd61izJPZdkmhV74rpNETmU0gnxmoaY73TKZ+Ju+k81Bm1yxKPUbtH4t0MJ3USyi6NXID+AivMhB7vVvHkAa9ZqhB4l6NvcU4W84AWdSq9+cbhAvrtvQISL7GZn+ZNbM+N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=FYzK+YX/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=7jixCHNs; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 67DEE2540201;
	Mon, 10 Mar 2025 09:10:58 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Mon, 10 Mar 2025 09:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741612258;
	 x=1741698658; bh=OQntpLoo3ph3muLoF4Ou7wx76i2vcnUwLXFqRX2k83k=; b=
	FYzK+YX/uP5dIuMqJ0YhLDWSZnV5Ba5Z3Vi/O27+agWlrwyHY6qjecekLwlpEkD5
	iE8MnK2xUfNihxQF3kJMChtvmtA9dnVB8t09kxnq7ZPJKgiLW5S94azNadZYK0iu
	plmu4oCDa18vZZVAasQ8bFiP9YNmc0cHXiFyDNiydvWJ7NebY2hpLRpmqYeAWA50
	KZVt9t662FCtm2wp75InaMlbFhUFxU4D37v3vIBpn8OFgHhX9o1tE7MXFwMFJgdB
	IYHIuI7Zcowj1lR2uX46QoexT6tR5KFUIBv2tmwhGOA5TgUUC0vXzqWq0Bgn/Oi5
	VOpgNPHnyWrbSn3qFC2VQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741612258; x=
	1741698658; bh=OQntpLoo3ph3muLoF4Ou7wx76i2vcnUwLXFqRX2k83k=; b=7
	jixCHNsndMpFkg/bxWotZ9jihuZgVPSMy9RSh8tBTI2hxtrsdw51A7ENUKwdvk1Y
	c0zg8575ey0P0ERTBiBOEFV1dTsdB9TV8K33O1oYR9YZSFkxlkEoLDRTdjPPQAnE
	e7IErZM4bHX2MPMPzMDffvtbYRn090pcYGtJaUktTtMqQAJgVD4sGdCGMYpYfFkA
	WpmWsNWMcYHV4sEp7mjuhAwRCAberEvdXqe1UDb9yhrlynUt4vHURcuuABd2VDQ4
	IbidcZgiQgA9A8fVkeoQ4ugZTYj0jZv4pAXY4XcGimd1CX5jWNWweHjn7i/LHDvU
	QwVzRiguN+czE6YomNf7Q==
X-ME-Sender: <xms:4eTOZyZdYXnbrpO3hUKJpiuEzpSIExEowRfgS91FOXjOTEsXsAo3Fg>
    <xme:4eTOZ1bpIkP-tKHQqmgYYpQbpC8GOdIXs6u_o0dKtNlZjYDdQK6pm3DVJpS7kzZ4Y
    T6LLEdqgJ0CxEEoCOY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudelgeefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:4eTOZ8_1KJo9jpuy3vJKXKF2sAN2Jhn3OSPmZUOD5jm3AvFFwr7aPA>
    <xmx:4eTOZ0oPANJHtNWC4p4lzlZHBTPD2j8WqnwkXRYgDjvCS4gqHJJd9w>
    <xmx:4eTOZ9rCPvhGjiNefgfXysx0Kfcdkvzgtxvf--9RTGNwqgtN-_vNPg>
    <xmx:4eTOZyRvp0Of_I2Yl0_PKa7siRf14jYWhm59Uba1F048eEWe3WVEqg>
    <xmx:4uTOZ-4HqUswNRoNQWpeWe2wK97LG9Lgf2G0hi5V-VD25wfBSTlUfMWy>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AA1AB2220073; Mon, 10 Mar 2025 09:10:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 10 Mar 2025 14:10:23 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Borislav Petkov" <bp@alien8.de>
Cc: "Ingo Molnar" <mingo@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>,
 "Rick Edgecombe" <rick.p.edgecombe@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Tom Lendacky" <thomas.lendacky@amd.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org
Message-Id: <7012583a-90be-4156-a151-2fc56fa18d51@app.fastmail.com>
In-Reply-To: <20250305225057.GBZ8jVUXJmIJBZwdgT@fat_crate.local>
References: <20250304143340.928503-1-arnd@kernel.org>
 <Z8grEnsAcMrm9sCc@gmail.com>
 <20250305221700.GPZ8jNXPCFR1w1NyEQ@fat_crate.local>
 <20250305222052.GAZ8jORCVmKQhEkrw6@fat_crate.local>
 <a6145d2a-e1a9-41b4-8017-5bbf37ec2d65@app.fastmail.com>
 <20250305225057.GBZ8jVUXJmIJBZwdgT@fat_crate.local>
Subject: Re: [PATCH] x86: coco: mark cc_mask as __maybe_unused
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Mar 5, 2025, at 23:50, Borislav Petkov wrote:
> On Wed, Mar 05, 2025 at 11:45:11PM +0100, Arnd Bergmann wrote:
>> There is a twist here: clang by default warns about unused const
>> variables in .c files but not in headers, while gcc doesn't
>
> What is the point of this warning, do you know?
>
> Someone defines a const, forgets to use it and? Oh big deal. This should be
> a -Wunused anyway, no?
>
> I must be missing something here...

We turned on -Wunused a while ago for default builds after all the
-Wunused-variable warnings got addressed, but instead turned off
-Wunused-const-variable and -Wunused-but-set-variable
unless W=1 is set while there are still existing warnings.

In my opinion, there is little difference between unused const and
non-const variables, the reason that gcc treats them differently
seems to be from common c++ coding style advocating for them to be
used in place of macros. This is the case here, but most of the
warnings it actually shows are for mistakes where some variable
is in the wrong #ifdef block or the only user got removed.

>> In this case, the only user is a macro:
>> #define _PAGE_CC               (_AT(pteval_t, cc_mask))
>> 
>> so maybe '#define cc_mask 0' would be appropriate.
>
> Sounds a lot better to me.

Too bad that did not work. This version is also a bit ugly:

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index c90e9c51edb7..f31c1a31742d 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -179,7 +179,11 @@ enum page_cache_mode {
 };
 #endif
 
+#ifdef CONFIG_ARCH_HAS_CC_PLATFORM
 #define _PAGE_CC               (_AT(pteval_t, cc_mask))
+#else
+#define _PAGE_CC               (_AT(pteval_t, 0))
+#endif
 #define _PAGE_ENC              (_AT(pteval_t, sme_me_mask))
 
 #define _PAGE_CACHE_MASK       (_PAGE_PWT | _PAGE_PCD | _PAGE_PAT)

so I'll just follow Ingo's earlier suggestion for the v2 patch.

       Arnd

