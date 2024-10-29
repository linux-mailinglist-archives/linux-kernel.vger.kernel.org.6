Return-Path: <linux-kernel+bounces-386771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3D39B47BB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEDCF284A7C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B803C20514E;
	Tue, 29 Oct 2024 10:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="xRhUiuKW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KyaxTL11"
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB828204956
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730199397; cv=none; b=OQLD8Q+yDN/d6efPf5u+zroiY94CyszG3szPDCjh1DWr4JE4is/zYJgllcweKsAN/brZp0mAgzG/Qvxn5eXKYCpPwxYiPQCalzEsXRf8KoD8uKv4O6zF0WQe+jubLyFRf06V23NbZxrgX0rg7rHYF4OiXkxO8EJmK/xTrFrHflA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730199397; c=relaxed/simple;
	bh=jq9goPgM9YTJfPaOcz+7nfIKg3dlDkxlNoSxlzNlFnU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XzGss14xQlxhyMcd7JuVOUoh7e5XRbQpEen2aA8mP9W92u6nQJhOlPddPe8BXUxVSjhzpVBl4j6bIKozqfUeN0dQLC8biIE3cjl151oyx/YA+LP7P7eKlhHv5KOE/BtCk7JIuz6pdOkEkr/vqLnEBTcuhePuTRpb7gtI++ppzpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=xRhUiuKW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KyaxTL11; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 986162540108;
	Tue, 29 Oct 2024 06:56:33 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 29 Oct 2024 06:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1730199393;
	 x=1730285793; bh=vqwYLs/IFXwwATHiSQq0x8T+kWq39FoJSfizv7BX7Rk=; b=
	xRhUiuKW/Qv4PUkvqFR+CcUACJkmQO9hf7+L4stUqYSolqIHFTgkLrx0BJB8RvKv
	T4A80dom0gSzGM+VYhe0SQL1VBD501B7tMI1LhQcpRQC9VXU0eZ+/sVwOLFtFU1L
	I3P5tL4sY48QvBoDAS9xFqCPHhLV9l9MmhcC6XcNUB0Axg2gdH1NTAbz2GNtpG6d
	7HXkL7jvVyOeUVTRaULfO7HoHej+jH2zv9A0ch8dYim2YIjngWvAneUcMiWjxriR
	GENC0gKT8AQUvb7tewzEdYg2zcXq5wZYtJTEanct9iiRs+5FM+pbtJr0cwkdZ+zd
	52KoATtJNHJGPjRAIJ/h6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1730199393; x=
	1730285793; bh=vqwYLs/IFXwwATHiSQq0x8T+kWq39FoJSfizv7BX7Rk=; b=K
	yaxTL11CT5v+gT95TeWoc4c5UqDvQyTAzBg66HaFugdXacIXx4dF9ANt/Ti6OdS0
	XHeZp3Kk2oz+XEpngDMOKxxTXYNq9BJmfgfNbULBvfC6zaTg4B7aGRLblo0n8rGI
	LSMpUY5tyycEqW7T4e7MnI8DsiGcgcuJgr8F9cp/plOZoTkeFxTfJYh/Ptyw+HfZ
	0oQZWof+voiVTGwAsi4uv19xx0AV9lFw+ZKAV2YEE7llflqGA1wWCe+MKIuLdyva
	7xEl8r+CJcRKKT8FPF46G3YqOMZ5frC8jByETXH87anMP2vIcFwWXAOU1lzWfnmb
	HSB6agJ5QQZr+EfHJ54MQ==
X-ME-Sender: <xms:Yb8gZ8oEpWOVvvCRZrJBiF8YIjfp8bcOrwozPXcCttlfOXMvqKAZIw>
    <xme:Yb8gZyqivo0udHlKJZItMEtT8yZ7F1ScHenK-_x3spBmayB2WIR8KQebKbb89K0uD
    aRnBCpAL0_6hip-DTI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdekuddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprh
    gtphhtthhopehmrghrihhordhlihhmohhntghivghllhhosegrmhgurdgtohhmpdhrtghp
    thhtohepnhgrvhgvvghnkhhrihhshhhnrgdrtghhrghtrhgrughhihesrghmugdrtghomh
    dprhgtphhtthhopehsuhhmrgdrhhgvghguvgesrghmugdrtghomhdprhgtphhtthhopeih
    rgiivghnrdhghhgrnhhnrghmsegrmhgurdgtohhmpdhrtghpthhtohepsghhvghlghgrrg
    hssehgohhoghhlvgdrtghomhdprhgtphhtthhopegrrhhnugeskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepgiekieeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigse
    hlihhnuhhtrhhonhhigidruggv
X-ME-Proxy: <xmx:Yb8gZxMg9YF7l5olI1qZRv-W5eIBORFecI24OPG39DPeEjHtoxswVA>
    <xmx:Yb8gZz4ml-CbXtlViPZrMdlUZw5iEKxbcvKtYC4gjbWLedvEuZkjVQ>
    <xmx:Yb8gZ77AIq4XGN-47pEji3LoBA3bsPuLkBdyDemYvuq89OCyvMipJw>
    <xmx:Yb8gZzhhBVJZK00k1d8Y97EnOP9XZDFcgAknn2Jm_9Sjuvsy6B9oPw>
    <xmx:Yb8gZyIPH0yODHt9bTzjYy2w8mYbfat9OHjra4cPSV1bJR7_vMcLex_z>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 121F92220071; Tue, 29 Oct 2024 06:56:32 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 29 Oct 2024 10:56:12 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Borislav Petkov" <bp@alien8.de>, "Arnd Bergmann" <arnd@kernel.org>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Mario Limonciello" <mario.limonciello@amd.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>,
 "Yazen Ghannam" <yazen.ghannam@amd.com>, "Suma Hegde" <suma.hegde@amd.com>,
 "Naveen Krishna Chatradhi" <naveenkrishna.chatradhi@amd.com>,
 linux-kernel@vger.kernel.org
Message-Id: <3a5360a4-e5c7-4c97-ab15-778d73f5b5a6@app.fastmail.com>
In-Reply-To: <20241029103316.GBZyC57KGSxyPie3Qu@fat_crate.local>
References: <20241029092329.3857004-1-arnd@kernel.org>
 <20241029103316.GBZyC57KGSxyPie3Qu@fat_crate.local>
Subject: Re: [PATCH] platform/x86/amd/hsmp: fix compile-testing without CONFiG_AMD_NB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Oct 29, 2024, at 10:33, Borislav Petkov wrote:
> On Tue, Oct 29, 2024 at 09:23:20AM +0000, Arnd Bergmann wrote:
>>  
>>  #define amd_nb_num(x)		0
>>  #define amd_nb_has_feature(x)	false
>> -#define node_to_amd_nb(x)	NULL
>> +static inline struct amd_northbridge *node_to_amd_nb(int node)
>> +{
>> +	return NULL;
>> +}
>>  #define amd_gart_present(x)	false
>
> ... so this fix should go to Linus now so that build testing doesn't break?
>

That would work, or Ilpo can pick it into the tree that
has the driver changes, possibly folding the fix into the
other changes.

     Arnd

