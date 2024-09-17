Return-Path: <linux-kernel+bounces-331848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 380B397B1F6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 17:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AFFE1C236CE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Sep 2024 15:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14C31B3B13;
	Tue, 17 Sep 2024 15:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="EzJ/Iw/i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZV8OtLK+"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F32D1B1D50;
	Tue, 17 Sep 2024 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726586059; cv=none; b=Z/oqOlVPUZfDxjIDeMpYTvn4T44iwW6fFFHx/d2n35qQo+veyXlGqo3aMF/TsDKUVz8acQWNgl08QTbMYE53QCCE9uQVIgYxPX/RBujKbM9641n305Sn3XYutfonVgarcwhxJl5hUKR75X+Id09965X5/SRVbw3Ix4W5XgDXSVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726586059; c=relaxed/simple;
	bh=Vus4cKi+4RnejRUM961LKGrzngkQ4YXNljqLwXqDJ7w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=lKlHHoCHsE4P0LN3+u6Kja7fznTcHBluh+LJ8aYjV4S7wt9bjW0N7yYbIqIcDpb4NDKQJIPtUqvx01Td1dFNAuVDxZjOxTV524Aw03h5/v0yZDIp9yCIs6xpgfKLqxmx5xHADVgalEhua2UYio3fZvQ0hkDlkCmPBXo/5r2W8D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=EzJ/Iw/i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZV8OtLK+; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5F7AE1140134;
	Tue, 17 Sep 2024 11:14:16 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Tue, 17 Sep 2024 11:14:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1726586056;
	 x=1726672456; bh=beyjdL4g95K6xmn2DgR29PPiKOYO46zC790GUDP2bMI=; b=
	EzJ/Iw/iX1G2DKzYUEBcJYDiKYM6FcgGHL5hL7G1AXo+Svugkdc8nZrhDMgjCZfs
	tSNY0rMzFDOF/lI4zds1sP9oi5Ou2LlXvVhdA5PxlKxTCvP1YIMQ3B2shgWeOqRy
	Yv/s/gzoAiSetMn+WPyT6HBskw9nv9aM3TQZuKaNocF+WHKPUIvESLVelJKtIPu4
	HltkIA93qg32QHy3AgH5HESiR+eLonIsxMETTolmd2eIoMZdzDBaoqy6+xsSJiFd
	q5uUUmjbQmlkqtJvcpG4EcbuNJLdmf/X6NDOF1HJJQdG82zdfgjEqe4Vormen5pz
	6oBDxR80IirhgGr31QjLRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1726586056; x=
	1726672456; bh=beyjdL4g95K6xmn2DgR29PPiKOYO46zC790GUDP2bMI=; b=Z
	V8OtLK+rOH0o2fv2O68nrD936DoMysGf/1CuSfVrrM82scRp2zF+wqiqU9bd6HB8
	wPzecyjJLmDUw1hdtvAdu+Ui8qCh/SZ4OSDOv1n6PUQ2BXPVpFQsiMCb4ggZoSk6
	ws3+LCo20rw2V/HbAwGVg3U4ZuJIem7vaEmqI26KyJ7vHjijdp6lolQuaTIV5NmG
	16E6p6hSP2pniIEWcXcNezWtxgCe7MZA1/Da3FNcHyUOUyiAHrAFN3MUVtGHl8D8
	jHjxtyD6nfv8KciY5Ly7/lRs2eNegTxY8bNTY/61+PbVCPFm/VzkW6rKr21knRo5
	148sxRvOuB7DMrZh9o9nA==
X-ME-Sender: <xms:x5zpZpOX3CQJofqRYCbin5M6t5QfBYory8V8YdQgc-Zu0yzu7Nwylg>
    <xme:x5zpZr-3lF933heCWuHQGuaSm_Zvt99TM3A8LSzjQVljV4bsXIdZpTLPl-60EqFjA
    6OQ-AsgLxF_ksznlDk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekjedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepkedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhukhhmrgesuggvnhigrdguvgdprh
    gtphhtthhopegrlhgvgigrnhguvghrrdhsvhgvrhgulhhinhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehnihhkihhtrgdrshhhuhgsihhnsehmrghquhgvfhgvlhdrmhgvpdhrtg
    hpthhtoheplhgsuhhlfigrhhhnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehluhhk
    rghsrdgsuhhlfigrhhhnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehkvghrnhgvlh
    dqjhgrnhhithhorhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhi
    nhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephh
    hsfigvvghtvghnsehvihhsihhonhgvnhhgrhgrvhgvrhhsrdgtohhm
X-ME-Proxy: <xmx:x5zpZoQu3Ew7UG_lPSGS7ewEwUbpiiM95J--eiNXUTp2HBi_EsIR9Q>
    <xmx:x5zpZlvSHSplRVk7VpCuY2gYPAEPyjQR8ldBNGfFjn_t8R_Hy3cslA>
    <xmx:x5zpZhcX2Muk7xGWuVPJv40-BhKDEIqKXZ-rRDwGTLyqz_lW0niyOQ>
    <xmx:x5zpZh0b26ulg-Y3DYSsqwQAmRJkDMQpzPkQvjS3rMDE7gY0QW4s6Q>
    <xmx:yJzpZruvJ0PTGKs7CpCSIZuhFIPGD2o19hDO8bUaTJWhnA2czWMFKEfo>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B9CC02220073; Tue, 17 Sep 2024 11:14:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Sep 2024 15:13:14 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Nikita Shubin" <nikita.shubin@maquefel.me>,
 "Alexander Sverdlin" <alexander.sverdlin@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Lukas Bulwahn" <lukas.bulwahn@redhat.com>,
 "Lukas Bulwahn" <lbulwahn@redhat.com>, "Lukasz Majewski" <lukma@denx.de>,
 "Hartley Sweeten" <hsweeten@visionengravers.com>
Message-Id: <fb3f06ca-53c2-4ba7-aaa3-e8c1063373f8@app.fastmail.com>
In-Reply-To: <e9367879f2305fba1029aee546160537894e848c.camel@maquefel.me>
References: <20240913115021.58405-1-lukas.bulwahn@redhat.com>
 <d125b5a5-8118-48ec-8af4-243a217170df@app.fastmail.com>
 <e9367879f2305fba1029aee546160537894e848c.camel@maquefel.me>
Subject: Re: [PATCH] MAINTAINERS: move BK3 machine support to CREDITS
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Sep 17, 2024, at 12:43, Nikita Shubin wrote:
> Alexander, Arnd.
>
> Do you mind if i put myself to EP93X, right below Alexander in
> MAINTAINERS list ?

No problem, please do that.

     Arnd

