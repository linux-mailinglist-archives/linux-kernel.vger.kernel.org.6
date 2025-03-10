Return-Path: <linux-kernel+bounces-554356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E64C8A596B7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4790F3A7750
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83A122A801;
	Mon, 10 Mar 2025 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="dOMvzgZF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eeJyEJHO"
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CE922A80A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741614643; cv=none; b=Cs7AuoRktt4bKpkdIyxz9gh0g/M42Dmjs+2clgxIVsDZgkiw0awM3WNfVNzrbW/TeuZBWPd7HfAV2IPj6p0ISnEG+iZRTuD1aBIDzMGVJ5PSyUcDJ7x2tjjXAHdKTZ3U5b+awvFIAOZPdXsMnGpTJubrimokh399RhECSyEiqlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741614643; c=relaxed/simple;
	bh=FwJycksQseJX+8a3pgRHZbK9HHMlVPRLJtM8Oc9ly+Q=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=sLIlGg1kpsPJ28X+8C4cbGm6Uq947wTPNp5TmEVjL0DExHKDEKIV9E6oGbPNYrFm3FBldataeQpjYk2d+e269Phwjr0xo3q1jP95ISW3EQAdGceQzU9RjvSsjexgS8gJXCFEEb79aiIgayjYvBpFFiITaSIlmJQRqs1ixtp0hCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=dOMvzgZF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eeJyEJHO; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id B6F11114013D;
	Mon, 10 Mar 2025 09:50:40 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Mon, 10 Mar 2025 09:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1741614640;
	 x=1741701040; bh=0I24wLbTzE/cY+sNJVvgN6FHUo0XplR4URQVYRRbEpg=; b=
	dOMvzgZFMQpadxR6WxipJPzwAD0PgjMSrUN9BToGwAWslN763L0Sh+fOMWk9IR8y
	uSoiDzEcoosW/KyRl7RuaO9bMsbdL5+LyYop8E1+7kWBJnbBhuWP5YSVQ3KmfzNy
	tM7DjbfNviLafviGjEekYbEo/hXJFRw7EbVamy/jCkPRYbEiAwtcSCby+TLGoCiQ
	hdtqdujLT9RLRRPUOrZcB+criV4810a4WR05Wx4GQ9hRuoZgn2kczAa0BXuIdMpD
	3VSgHBkDhd+h8pvZ4qoWvL2lKl77L9iStX8YKtLrltCBK8pE11wRWQvog+oqg1uZ
	+6r5jYM95VRFX/UxEdGWFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741614640; x=
	1741701040; bh=0I24wLbTzE/cY+sNJVvgN6FHUo0XplR4URQVYRRbEpg=; b=e
	eJyEJHOuoj5FWpqspktBn+kTPQTTCh9OJY8VGW96Jjj04DkkuIVIBa2LZpc6h5XG
	dBGImwUC42zXTL3km6a+1IJvCtyFRPemo48KXvnWzU32C7rhDwO5tQ7ZAqvFHBho
	CkNq/kh4PfkorgqBE1d/uj/L4l5x7fib8q5U9z7QUx1hqcfXDPmQatuowV3shT/N
	8PuqOo2QetcTQ1uke7ckhIZTw9yGQk9dXe4a1wJe4IHcqfSnNWks7hn7PoX1xKSw
	rNJh8gfWbzJcy6zWudLdWiQCPOv2K511qY+9IP4c8/N3nWJwwlUTEuG9x14Rffl6
	qzxyFQZCT/ZvtHze/So2A==
X-ME-Sender: <xms:MO7OZwWRIygZL0i-yLfwRAHriWuRq95L1dHphFLZ4x5Iix2sCGaRDQ>
    <xme:MO7OZ0lZAVoY98MzHnZCzW1WuLnJQuZ9XsM13lx_trNc03W7FcWmAtzImrKFqGm0T
    XigdbtibNByGtU63ts>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudelheduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:MO7OZ0bydh2ImUlmhodi38l5FXEGOEzYNURMQ2uzA8hpW_MjiAGsng>
    <xmx:MO7OZ_V3u7rXHRkz09xDAU5k9f-feYf3C1aL3hI6WDH-WevrFBq1bw>
    <xmx:MO7OZ6n1tzd8WrrvpbNYJEB5taTs1BPDrl5KleGvYrC5v2SUaRM5MA>
    <xmx:MO7OZ0cLvIbWStaIoPalLsze-OSl-0EW5CChYWncuHjkqiEO2fcrIw>
    <xmx:MO7OZwk9vTXWtXB8rnSkQVEh162EMVUibuYoRF0b1FuqZnfSz5bnsIUW>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2DE552220073; Mon, 10 Mar 2025 09:50:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 10 Mar 2025 14:50:18 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ingo Molnar" <mingo@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>,
 "Rick Edgecombe" <rick.p.edgecombe@intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Tom Lendacky" <thomas.lendacky@amd.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>, linux-kernel@vger.kernel.org
Message-Id: <f034fd64-41e9-45fd-a58f-41dae347307c@app.fastmail.com>
In-Reply-To: <Z8grEnsAcMrm9sCc@gmail.com>
References: <20250304143340.928503-1-arnd@kernel.org>
 <Z8grEnsAcMrm9sCc@gmail.com>
Subject: Re: [PATCH] x86: coco: mark cc_mask as __maybe_unused
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Mar 5, 2025, at 11:44, Ingo Molnar wrote:
> * Arnd Bergmann <arnd@kernel.org> wrote:
>
>> @@ -25,7 +25,7 @@ u64 cc_mkdec(u64 val);
>>  void cc_random_init(void);
>>  #else
>>  #define cc_vendor (CC_VENDOR_NONE)
>> -static const u64 cc_mask = 0;
>> +static const __maybe_unused u64 cc_mask = 0;
>
> So I detest __maybe_unused with a vengeance: the 'maybe' unnecessarily 
> inserts uncertainty & probability language into the text, while there's 
> nothing uncertain about this interface or the code. Why cannot the 
> compiler figure it out?

Right, I'm also trying to remove a lot of the __maybe_unused
annotations in places like power management and device_id tables
where we now have better solutions in place.

> Anyway, I'd suggest we change direct usage of cc_mask to a 
> get_cc_mask() inline function instead, this will resolve the warning, 
> plus it avoids some messy looking variable shadowing in tdx.c AFAICS:
>
>   arch/x86/coco/tdx/tdx.c:static void tdx_setup(u64 *cc_mask)

I've sent a v2 now.

      Arnd

