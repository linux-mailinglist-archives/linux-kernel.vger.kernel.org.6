Return-Path: <linux-kernel+bounces-322749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 393FB972D40
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2E2B284EC9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C8C189F52;
	Tue, 10 Sep 2024 09:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="a1j62AdA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l+J5gSQ/"
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A4F188002;
	Tue, 10 Sep 2024 09:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725959765; cv=none; b=MIumscLIfTmCvfu58ek9HCI2wLXOflMhF+SlrJdeju/BGLAPwin/vX1qdAOKeQfpEm5Ga7P10vMEeYBq1k8mJSZaypRw/I7zKlQuP41EmbK0SdKJXgFgfNX9QwSWTzuLHtnUz3hoAdvqkHCF1rjIy4d9RCTm/F7UHlgKBR5bOdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725959765; c=relaxed/simple;
	bh=FBMJWJqB79yGDbUvlWAy35uxPHrp8h6XY0yZZg4VB4w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=YSwt7lJrbIHsaIkpIEtI/D9L/odgwXgtOhT1gvcdYduOeHAuVx12STZxNkrJ1Y0IKsLRenRJRN2j5iHMoI/GaF0JFRSIIafP7BhdGhelKU6L9jGurF41bhwmLMSY/ZLhteSA5JXfOnmBZVAbWrGMGEXys0jPl83VuQdJfd2tPcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=a1j62AdA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l+J5gSQ/; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2196111402FF;
	Tue, 10 Sep 2024 05:16:03 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 10 Sep 2024 05:16:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1725959763;
	 x=1726046163; bh=MBfqYJPMZJv6Y590XG1x2GpGDpSRx867w+Y9UYCRbw8=; b=
	a1j62AdAnQhf0HLyjSZe8JZWKYzSnjAvjaaddrKACiX0WQDkHUFIgKBXcODTv7qw
	o1/nXcSntC1fW3ImMyZD8xhgHO0fr611gdnbAHFuF5z4DUMs9TQubhDDyJjzfIS9
	NWO3ciAvN4cQfAluv8ggEgfXX60wCjEQMGmlM0R8+dS25X9HDB8B2lxkH8Dorp2u
	bjTGq6VlZSpKU3u2f+9LyUbsPQvq78e1HtLg2/p6Zz/G9lnxw3br+6/YMNHY2Njm
	6wFeHugpyLPXcvl6l1+4GEqdUKNs07zzC/Q+sGNqhAII5aRFQpL4D1fmym7HhhuU
	aXrGw70YdK2qbYpLdsm3tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725959763; x=
	1726046163; bh=MBfqYJPMZJv6Y590XG1x2GpGDpSRx867w+Y9UYCRbw8=; b=l
	+J5gSQ/KGDhLUDLnXehAjvmnaoBep82FwwBq3dm1GhJQ7LGWzxlqxVIGSvtAC93F
	/2uvVGb4dFIDjCrvGBYjUO+QYVxL5vFgk9NiRtUxwjbdWPz8B/RpCls3ZmAByPeP
	WQ07CvO/OQePvsYc4AJ5M2wGSQdRO4lGSkySRoOT5iHNBxddUEup1ktRCyvROKrL
	swFUjiL1PBP/Pfl55OTWP8IkjDyH72iHI1dy6z+CNe9V4cBv+/TUJlXzwmJyTWvG
	hhsTAeJfqgMNQQ1vKEmM71VcB91UWQS0BXToJhOtYK0lMrMHC/kxvY20995KylsI
	JoqiXacJ6Gb6OIpEvnjCQ==
X-ME-Sender: <xms:Ug7gZjojGXn6UCqfUmTT12seRnAENgWdJ7W8kdqF22TzXXX55R0e0g>
    <xme:Ug7gZto3yDJxstGEgORYARNSrMttFE7f1Db_Y9-9qnoXukE6oCcEhBnPs6BmMcw9b
    njjWYtDa-nKCfOVEd0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeiledgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtrghtrghlihhnrdhmrghrihhnrg
    hssegrrhhmrdgtohhmpdhrtghpthhtoheplhhkphesihhnthgvlhdrtghomhdprhgtphht
    thhopehjvhgvthhtvghrsehkrghlrhgrhihinhgtrdgtohhmpdhrtghpthhtohephihsih
    honhhnvggruheskhgrlhhrrgihihhntgdrtghomhdprhgtphhtthhopegthhgvnhhhuhgr
    tggriheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhuohhrvghnsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    lhhinhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuh
    igqdhfohhunhgurghtihhonhdrohhrgh
X-ME-Proxy: <xmx:Ug7gZgP8xQEG18G7xPFL4QGmK2mXkM-t716YUekMYUG_PwYZTZ7x3Q>
    <xmx:Ug7gZm5rXtNcuwvnJMGqh3g-bZpf_v76S_FVbRRxDhb9oxBMuVNKYQ>
    <xmx:Ug7gZi5WZH3YWgrEsaCy5grLKqoGpwgdTQeMr0fH7tVKyiej_2g4lA>
    <xmx:Ug7gZuihdGDVMGl1i-UIbLgjJBq7YSAOJitHj9GhJeCT4mnTSPQE-g>
    <xmx:Uw7gZhT3YmmvpnNfQ7pxMrIcJew_JCbe3z_lqcSOto6EG6CQMtdD7pwU>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C1566222006F; Tue, 10 Sep 2024 05:16:02 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Sep 2024 09:15:42 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "kernel test robot" <lkp@intel.com>,
 "Julian Vetter" <jvetter@kalrayinc.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 guoren <guoren@kernel.org>, "Huacai Chen" <chenhuacai@kernel.org>,
 "WANG Xuerui" <kernel@xen0n.name>,
 "Andrew Morton" <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
 "Linux Memory Management List" <linux-mm@kvack.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 loongarch@lists.linux.dev, "Yann Sionneau" <ysionneau@kalrayinc.com>
Message-Id: <c78987ba-6b54-4433-b5dc-3b3b9f98354a@app.fastmail.com>
In-Reply-To: <202409101549.CyV0mJ2S-lkp@intel.com>
References: <20240909133159.2024688-4-jvetter@kalrayinc.com>
 <202409101549.CyV0mJ2S-lkp@intel.com>
Subject: Re: [PATCH v2 3/4] Use generic io memcpy functions on the csky architecture
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Sep 10, 2024, at 07:27, kernel test robot wrote:

> 6a9bfa83709a84e Julian Vetter 2024-09-09  55  	while (count >= 
> NATIVE_STORE_SIZE) {
> 6a9bfa83709a84e Julian Vetter 2024-09-09  56  		if 
> (IS_ENABLED(CONFIG_64BIT))
> 6a9bfa83709a84e Julian Vetter 2024-09-09 @57  
> 			__raw_writeq(get_unaligned((uintptr_t *)from), to);
> 6a9bfa83709a84e Julian Vetter 2024-09-09  58  		else

Right, this one actually has to be a preprocessor conditional
because __raw_writeq is not defined.

     Arnd

