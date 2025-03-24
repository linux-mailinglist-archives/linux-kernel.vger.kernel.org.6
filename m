Return-Path: <linux-kernel+bounces-573953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 906C5A6DEA8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAB3816A7DE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E0725FA04;
	Mon, 24 Mar 2025 15:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ffLrU+BN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Com4cb3U"
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD441CD1E4;
	Mon, 24 Mar 2025 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742830183; cv=none; b=WRbhPEfWbo1BEUmNaH9hd4S27lcf1clAWFPKyfoXF0kQeSlFGqIsYFhn1kNf/lp+4GTyhpDgaoHGugnvRB8qZQ36O2+v1pwLX7LxDFNOwKryEHuNS6lK7GH1dkMNyrVj0vvjMyPIbBERtUWD1pQjKwl61Qt/l3syOS8ze++DvoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742830183; c=relaxed/simple;
	bh=m7ubwnP1UV4Z1iX99eO+HYzRGPRx/EX3E+nvos6h7Y0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=E4W3AaJNE0HfH4Ho9wRmZorpG2ZPLZ+wo9IuDuysLomU8xgkTLaEk18j8joJyWgTjqS0ArV5BdjDBMZ3GtIQF84bB4fbgR4gJogzz2AWyebE7tfaLFia1qIymK52aN43EOwPUH7v2PTrUFO6B60QY9a8GU8XJh8/vjdRbBbTqEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ffLrU+BN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Com4cb3U; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 2DD251383DE3;
	Mon, 24 Mar 2025 11:29:41 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Mon, 24 Mar 2025 11:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742830181;
	 x=1742916581; bh=juOVH8qsGuDRgM3esIYt4jWBd8gP6RsMPF2nauED83s=; b=
	ffLrU+BNUaCv0i4QcDtKNrwnqugYM3fRlHIkut1aCL91EXFql4d0iS6ZvRJapgPa
	lBTpLI9lf1VSoToI95TJ6UMNOXS86s9J8Ve7ROPNFge9M0o6EZIVAvyA4cxhs2Gj
	Hmby+AjlhtdqlrFmVNnztCxC4aZFZ2DSwpc6vOKZWtxopuTsX2c2eyWteGQ5CdIT
	TLOVuGuPgqU5F0opLtTV3Zphy0RyztxjBiXySLmfYKy5Ls5hCEQWPwrwdMEX4BG1
	nqRmf/hBiQ5HR7Bvbk4XvGk5YDWTV8JOXv7xcyBC9sG7J/hA7m//NxOdiYffYK9Z
	ZfNzBngQv+D6b5L2P/JlfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742830181; x=
	1742916581; bh=juOVH8qsGuDRgM3esIYt4jWBd8gP6RsMPF2nauED83s=; b=C
	om4cb3U9IMUCuA+vQWlvMDSrJJcYSEwAg4P6y1Khiry31XK8YUpHIcuFkqUEFtj9
	vcKous4K8PhbRtUMwd+Zq4+pBpvXpbjoFdH3acuAvJRVyBlDR5LDL80b8TEsQWW7
	A8OOXFUAUeeSAuEmdQNRMlyyK03mfyLgCaNrXDKbYnjj29K02PvcTOpBYQKO/pf+
	OYjpymEkQgAoS4YkXQL+1avpBzJi9FLk7FEg6DneJkSs36ZHnXqC4I9VHWfH3aKj
	zIZ7iPQbkE6boiwjZ3+HX2qAePPmQIddEUpKwGWjR2IVPc3OWn41im4VXVR2aH0F
	1bS0+ZE6JprfPYABlWh2g==
X-ME-Sender: <xms:ZHrhZztB4bnJeBZs7sj90JJrqWVk9VadPlwHSVEh0ROXOp5tYzFmnQ>
    <xme:ZHrhZ0fk3RlFTkxEigxfs6ahJrB5E2PRExnONnUeYLo1LsEp8C5iZXRoxv_NE1vJJ
    5jayND57NgEJUTsBVk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedtudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgepudenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    uddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrkhhshhgrhidrghhuphhtrg
    esrghmugdrtghomhdprhgtphhtthhopegrnhgrnhgurdhumhgrrhhjihesrghmugdrtgho
    mhdprhgtphhtthhopehgrghuthhhrghmrdhshhgvnhhohiesrghmugdrtghomhdprhgtph
    htthhopehmrghrihhordhlihhmohhntghivghllhhosegrmhgurdgtohhmpdhrtghpthht
    ohepnhgrvhgvvghnkhhrihhshhhnrgdrtghhrghtrhgrughhihesrghmugdrtghomhdprh
    gtphhtthhopehshhihrghmqdhsuhhnuggrrhdrshdqkhesrghmugdrtghomhdprhgtphht
    thhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtth
    hopehlihhnuhigsehrohgvtghkqdhushdrnhgvthdprhgtphhtthhopehlihhnuhigqdhh
    fihmohhnsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ZHrhZ2xUZlldXZfMCiF1HxfddFQhsc9NXvTvmCt7FBmIFPPay5TEGg>
    <xmx:ZHrhZyNm3sB72TB1qK4ZYJwR0_jaW9z3AxREoVed8WehNXb-Q9RH2w>
    <xmx:ZHrhZz-z_Kxo2abwQWJuzTJx362bLHjCFyh04NvM0XNzEUPdjWoMGQ>
    <xmx:ZHrhZyWInREfHzMvTSvU7acmQwEv-T2pustXSHC74TCSA3MJ4jZ5Rw>
    <xmx:ZXrhZ6ZVNTpgMOphAVbOBM7rT37_nUaK0EaElJ8jlAmL7f2iVOfGhL4Z>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C46B22220072; Mon, 24 Mar 2025 11:29:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tee0478150e682e72
Date: Mon, 24 Mar 2025 16:29:20 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Akshay Gupta" <akshay.gupta@amd.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: "Guenter Roeck" <linux@roeck-us.net>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, shyam-sundar.s-k@amd.com,
 gautham.shenoy@amd.com, "Mario Limonciello" <mario.limonciello@amd.com>,
 naveenkrishna.chatradhi@amd.com, anand.umarji@amd.com
Message-Id: <3ab1116b-7021-4d83-847d-fdec53af9bee@app.fastmail.com>
In-Reply-To: <20250324145815.1026314-9-akshay.gupta@amd.com>
References: <20250324145815.1026314-1-akshay.gupta@amd.com>
 <20250324145815.1026314-9-akshay.gupta@amd.com>
Subject: Re: [PATCH v6 08/11] misc: amd-sbi: Add support for CPUID protocol
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Mar 24, 2025, at 15:58, Akshay Gupta wrote:

>  struct apml_message {
>  	/*
>  	 * [0]...[3] mailbox 32bit input
> +	 *	     cpuid,
> +	 * [4][5] cpuid: thread
> +	 * [6] cpuid: ext function & read eax/ebx or ecx/edx
> +	 *	[7:0] -> bits [7:4] -> ext function &
> +	 *	bit [0] read eax/ebx or ecx/edx
>  	 * [7] read/write functionality
>  	 */
>  	union {
> +		__u64 cpu_msr_in;
>  		__u32 mb_in[2];
>  		__u8 reg_in[8];
>  	} data_in;

This changes the alignment of the structure and makes
it incompatible between 32-bit and 64-bit userspace
when there is an odd number of 32-bit words in it.

      Arnd

