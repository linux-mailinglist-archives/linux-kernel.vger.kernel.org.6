Return-Path: <linux-kernel+bounces-573951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31450A6DE9D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 647C516EE38
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A69825F980;
	Mon, 24 Mar 2025 15:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="caidp4SU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l6+oLaNG"
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605141CD1E4;
	Mon, 24 Mar 2025 15:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742830070; cv=none; b=s6wAsKUZCMACvVWhA0A1iI/MfQWj8NWcdBDukq2km8uehOrjSTemmOYyr67hRYwqam+68ReS8H0+C13NfxMPq4r2PJO+J13hJdJRqNblApkZ9LdBOfQj2SXtR8RaHk6PRpdylGacR4RdHFDlK5UPpnU11aPifj63PWL5Ko/zM+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742830070; c=relaxed/simple;
	bh=jMK51qpqp2ziCZmYizfEEJEUTX2M9Hw3x+1Sg9tbZbY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=V/ZreuS13sFJpB1w6YqkDRi+Q8HxSl0+RZ0VVVbAHWZ1dNRt7etREz07h9CO8g6FOgiFiiNPtUPY9AMhn3IeNA4CXOs5e0PkxCviDaQDHiaB0eMFz/lJip8nDhPuiNbjMx3rIgpc2W3gOf1IXDjFYFNFXje7hJUkg6AkSJCy3/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=caidp4SU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=l6+oLaNG; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5268E1140198;
	Mon, 24 Mar 2025 11:27:47 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Mon, 24 Mar 2025 11:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742830067;
	 x=1742916467; bh=niaWtuJR+RDMZS1SxQP8TZHcP0Y57WpvpM/jrkXeYis=; b=
	caidp4SUY2DKMEFzU143PBGw/xsFXzCpVo1V5m82OHSptxTG8bPRqcLWzB5+r9As
	6NRSvb0WBOxt7lbfr/DxpopyzmwFQfZWt6jJHyfOCk5gFQO75Bl5h+Wjbteek2cR
	H02327yrz3fyjS4PduOSY01S50j9b4VDZtdJ/E5SrYAJF5cnDm3DxLXNpIt+jq9b
	C1v6E5PqygvJM+9e5jRf1PPmiNQFOsgA6rsLtuMfOMtybpRNUMCMeRP5SAViJgEs
	Ds670IOMjyQa2o9rHLaLg8P2HC0rCLHAoRTKCqZC4U0ihFPEvvxRZ//vq1UwNPAy
	UKN7cO73zdEth+lLtYsn7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742830067; x=
	1742916467; bh=niaWtuJR+RDMZS1SxQP8TZHcP0Y57WpvpM/jrkXeYis=; b=l
	6+oLaNGYeSvWoyBv/HCelbuChe3G6NwCghvbGBLpMJ9C3pMY82iUsVYVCMjIlbRZ
	Ca8RT9+sIm7nR2LhYQHSDw+J/+ntq7DR3K/zCbl5kJEGyNfWvK3zJ4e71Aa2k938
	hDKPkyvV89AssEXvmKC8sZtTbe3oYd7Lvw6wpTL8PHTS05Jw5Ge1j+PsmcGD8AU/
	ZfxKAsCi5mvUHtsLkntwFYlLV89joTwJra6ooiSFJ6+AdQgqb6XtR9mZlFiBv/5o
	tSDGCxmCh6Q0w+qQF94GQ/in/sBB/c5EnmMZ0IlxZpNhJWFy8wmFKLGvxbuCcX6S
	1OPJndcbU6QjFyCLgFOLQ==
X-ME-Sender: <xms:83nhZ7y1ge7GXexBZtjGC5Uk9dYN9U7GvZr3hHiJciX1Uq2qu-pvsA>
    <xme:83nhZzRlx-_1rEhcDeG9FXXAOymEqBBh23ztWNU7c9OVp8Mt479AEeieHshJDM4gR
    ihTZLwSIruEdpfvO7s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedtudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeet
    fefggfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
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
X-ME-Proxy: <xmx:83nhZ1UnI5gl297tHfzM0dN64H-xtSRbA7getDwXeH4jpYSJerSh5Q>
    <xmx:83nhZ1iJjZkJqdmowTEIa4N5iwev55ZqfGKq9BHtfTTZR_5EFOcUvg>
    <xmx:83nhZ9BODLSxzouc_NTFduUQ62ENB6Dy2mJRNJVyyPo7lb7DCHGufA>
    <xmx:83nhZ-IKs0DaZZ0sb82xJvo-esppLHEDWiV3ecsXJAGjq8cpWIOABA>
    <xmx:83nhZxuw93Ds37NR2bVvdRHvYkPEnHqpLZhcDTV_CsRtsWUrwyUqKpBI>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id ED1DB2220072; Mon, 24 Mar 2025 11:27:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tdf915bd5cef52fc2
Date: Mon, 24 Mar 2025 16:26:40 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Akshay Gupta" <akshay.gupta@amd.com>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: "Guenter Roeck" <linux@roeck-us.net>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, shyam-sundar.s-k@amd.com,
 gautham.shenoy@amd.com, "Mario Limonciello" <mario.limonciello@amd.com>,
 naveenkrishna.chatradhi@amd.com, anand.umarji@amd.com
Message-Id: <d05242e6-4706-4abd-973f-230d143137e8@app.fastmail.com>
In-Reply-To: <20250324145815.1026314-8-akshay.gupta@amd.com>
References: <20250324145815.1026314-1-akshay.gupta@amd.com>
 <20250324145815.1026314-8-akshay.gupta@amd.com>
Subject: Re: [PATCH v6 07/11] misc: amd-sbi: Add support for mailbox error codes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Mar 24, 2025, at 15:58, Akshay Gupta wrote:
> APML mailbox protocol returns additional error codes written by
> SMU firmware in the out-bound register 0x37. These errors include,
> invalid core, message not supported over platform and
> others. This additional error codes can be used to provide more
> details to user space.
>
> Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
> Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>

This is an incompatible change to the uapi definition, which you
should never do. Just merge it into the previous patch that
adds the api in the first place.

      Arnd

