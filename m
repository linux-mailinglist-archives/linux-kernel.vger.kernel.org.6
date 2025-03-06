Return-Path: <linux-kernel+bounces-549780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A91F1A55733
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 20:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 015CB7A320E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6DC2702CF;
	Thu,  6 Mar 2025 19:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="ouj9JeLT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NxX0pN5H"
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37711FC0F9;
	Thu,  6 Mar 2025 19:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741291001; cv=none; b=KMGYbfR4R/LVHgKWQbtf0feDF+B8D7cxzE+3W9uzRhsBZlLfKt+vr632rp7hIfi5RSWcbQLcADf06FBZAEODmLEdtelCRxAOwCoBIn8Ca4B8QV61rRm46ItC2vQIgzpfnP7J/2Cdv3Ky8KmSQNuPMlq2sBRpmqZe3b8YmkBDsXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741291001; c=relaxed/simple;
	bh=kP/2X4/iyO9gLoyY2JfFsbQHz4Mgh65Z3H3cmmaf8Bw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lzYkZZ1/swCT0xug19gI/uA/J/fXb4zDl0x18p1Z6AX6s7YAwXL2LqyUYzSrXeQZ8dIQjqT4exTDI5/KdXRKx/ertJMa/Y5ZXgiwitdsdq7FK7CgcHVhE1WT0PBauDBtT3G+eDtHhsYrrYl5QnseKn1Wwk7zU+RY9kluRb+qm9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=ouj9JeLT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NxX0pN5H; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E3F2E114018C;
	Thu,  6 Mar 2025 14:56:38 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 06 Mar 2025 14:56:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1741290998; x=1741377398; bh=vtNbkKW92oiyf/MEWed49iOf2vBzLZ2d
	wi5nMQkMZIc=; b=ouj9JeLTgrXCx8BuncX57zY1qS606ouLDBYXMspDJxMXAsBu
	DTd4CaabpmKucH4R1TrWq7V9s2nb4u2yIMNAkVEvE0BNBv0HRt91tkmkl98nwr+G
	aEG13IPuK0QnOWCv4qdsc3ijIetAip87ac9VdPoSyKjpThkc6D1SswQ7+HLTqNzH
	fDnokTMxpin6dtQZvIl5NFJeQ9kdJcK+PvhT+qv0fyMcNQZNuRSNFG4/1wqhvEll
	Rou9mdzh2eo/txOI9sw4SNPwqNUHbwi5HbTnl8SbQjVeZGU6nHc/KVqtntmUoRgF
	3TUkM4TxNa8Ivg4ud6imy6BCPTwefyFD5Nlu+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741290998; x=
	1741377398; bh=vtNbkKW92oiyf/MEWed49iOf2vBzLZ2dwi5nMQkMZIc=; b=N
	xX0pN5HeT34HZqxVu98+U7wiz6BYZ90rGbPc80C4MHpde5rPS43wGMX6OSHbjlcT
	miGKGxE7J2Cd51IfqMK2CrLYtrM5KcKSqj8RNbUJjUtG8CaJeETx9f6fL5JCFDTR
	MpjTQ0NB0m6EG7uyoFIZnLxK7bVZCCtuy1xxl4CjDzcKMbpMv159gUp1V8llAm9L
	MOZzlbDTO0dympwy617AOzYQLHqjJE/LdfG+I+odMG6KR5l8KELKotktrsOv3oL1
	US4fmSY2bIgvswal9++vjq/HZQnSdmrVFr17KMgXp0ekwo2uLyvD6fjicwZvaFQS
	1SLlZIzZu0OurTWmJeOhA==
X-ME-Sender: <xms:9v3JZ7lvEmwPT69snFH8eVv6Y42cnFRNAxH62XeI8RhyBgkXw4DjoA>
    <xme:9v3JZ-3ju0g6eTH2TOwJsO3v17HEOipiVN8BXvhaS8tGRYGUrkKUt87pPm-f1Pkvq
    jSsJgIDtOq9xrhxJRM>
X-ME-Received: <xmr:9v3JZxpSo2LAYSTDuCr3JYdLG4prV5_rPIGsYXUOUuJfwCkbQzVv29RVIaTWJS2C3LDWniEda3hg8WA3cJJzyMidwBh7g9j2I4A4_sP5HC7MoMNNqWk0R0zx2fjz6zQETA5dnl3bCWd0xbH2cgnC46ydLeW9t9jV_QTMVOWW5fR4_OVJ8Qt7dxHqPq99Yoycpa0W>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdekieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvegjfhfukfffgggtgffosehtjeertder
    tdejnecuhfhrohhmpefuvhgvnhcurfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrh
    druggvvheqnecuggftrfgrthhtvghrnhepfeefjeeiueejteffjeetueekjedtgfehiedt
    uefgtdeuvdfgfefhledufeevgffgnecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhes
    shhvvghnphgvthgvrhdruggvvhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehtohifihhntghhvghnmhhisehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepjhesjhgrnhhnrghurdhnvghtpdhrtghpthhtohepkhhriihkodgutheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehl
    ihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheprghlhihsshgrsehroh
    hsvghniiifvghighdrihhopdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegrshgrhhhisehlihhsthhsrdhlihhnuhigrdguvghv
X-ME-Proxy: <xmx:9v3JZzm9KDznGdcZs_dVEDUiTzahiftdf77uyXeSGDPY694uzATSiA>
    <xmx:9v3JZ52LKVIos3GMrngwOoYyiEe77xOfpbtd12UjzPoy1qOkqay0vg>
    <xmx:9v3JZyscwqqR5mEQZdaIw3O15X4JmrOyqfGKgtudAPOd3xkwcjMRsA>
    <xmx:9v3JZ9UxNs7g636yz5cb4TwjvoH995PVjcj-iPpW_YhyXlB6r-EDVQ>
    <xmx:9v3JZys_LuNuW9qp-z_RihXTje-4G52tbfTkXAq3RrKBRAwdWzSDRrH1>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 14:56:36 -0500 (EST)
From: Sven Peter <sven@svenpeter.dev>
To: Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nick Chan <towinchenmi@gmail.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250228-dwi-dt-v2-0-69e450bc4bfb@gmail.com>
References: <20250228-dwi-dt-v2-0-69e450bc4bfb@gmail.com>
Subject: Re: [PATCH RESEND v2 0/5] arm64: dts: apple: Add DWI backlight dt
 nodes
Message-Id: <174129099660.23709.379545131530961336.b4-ty@svenpeter.dev>
Date: Thu, 06 Mar 2025 20:56:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Fri, 28 Feb 2025 12:32:11 +0800, Nick Chan wrote:
> Add device tree nodes for DWI backlight found on some Apple iPhones, iPads
> and iPod touches. Not all devices have this feature, as some devices
> instead have their backlights directly connected to the WLED output of a
> PMU or use self-emissive panels.
> 
> Resned because a network error occured and some patches failed to send.
> 
> [...]

Applied to git@github.com:AsahiLinux/linux.git (asahi-soc/dt), thanks!

[1/5] arm64: dts: apple: s5l8960x: Add backlight nodes
      https://github.com/AsahiLinux/linux/commit/0f8f64b2329f
[2/5] arm64: dts: apple: t7000: Add backlight nodes
      https://github.com/AsahiLinux/linux/commit/897359ae3c50
[3/5] arm64: dts: apple: s800-0-3: Add backlight nodes
      https://github.com/AsahiLinux/linux/commit/4384b6c781bc
[4/5] arm64: dts: apple: t8010: Add backlight nodes
      https://github.com/AsahiLinux/linux/commit/074db7d6f51b
[5/5] arm64: dts: apple: t8015: Add backlight nodes
      https://github.com/AsahiLinux/linux/commit/e1bc21d8f8fd

Best regards,
-- 
Sven Peter <sven@svenpeter.dev>



