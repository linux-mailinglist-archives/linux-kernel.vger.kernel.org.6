Return-Path: <linux-kernel+bounces-364267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46ACF99CF95
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E11A41F21163
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8D71C302C;
	Mon, 14 Oct 2024 14:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="VfZa4+ww";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MDkxkrjl"
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805BE1C2DC8
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 14:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917599; cv=none; b=bqvMQ3tWhs+5wm8fcp8nwZSNBwn7tBth+SLvhZfVmeX6qgQYNc+Ajlbe1R8O+Ozd/qNCSk0QAd6hwvMnu47tiFB2MwSWG/qZ1i64zR5QBxK036PqxauKqHIcd5BVVGIcALmSdksHKSOyJbFZzLMtyprkIAV5+hRWTVY7453v+7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917599; c=relaxed/simple;
	bh=jGA0WMHaso6T+Vi8W16GcyyK+jEPdMwx5wLOnpCwjPU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=bX0vfAM9+7CcLjz664JkWpLBdr20Q5Fq1C1e+IaGchin8Z7d9bLqdn5pVZUchYm40m27VqaRAtK3GUgL/pYlgXlFwS9Y5G30FJ43KjEVuX6nLCnzfX5oaDTLRAUVjjLn9I3MBrtZBOGHO95w+2PTs1PZdTlsYNEM4bwAhRGVZfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=VfZa4+ww; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MDkxkrjl; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 962021140117;
	Mon, 14 Oct 2024 10:53:16 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 14 Oct 2024 10:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728917596;
	 x=1729003996; bh=jGA0WMHaso6T+Vi8W16GcyyK+jEPdMwx5wLOnpCwjPU=; b=
	VfZa4+ww7rsBFLcfaiXGqwa6gsukIo2/5lMuSR5BvEWBYZ7moCqVKwHjaS5Z7sMP
	1tlI9tybeQ2fJquw/u+W/qkzsudmjibsof+ln7jXibPAtdQVJgOHeCP71Z9HFicM
	34jt7Kk1BZlLaqRb7XkPps4dTX4HRTTZY/QG/WBlALZZJYZMchD19CAvLdekwDYA
	qeqHP/Dppl+DQM/h1v94GbCe/bWMIPAteT984r3exXIjqW6GzyFh8zYqN4zrfGlZ
	feCwEdojzYybcUoHFPCyU90j/CWXZJCGno6hiX2iJC+MDXdBrzDk7o3csckt7awL
	lM1alKXGB248dy858TsCTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728917596; x=
	1729003996; bh=jGA0WMHaso6T+Vi8W16GcyyK+jEPdMwx5wLOnpCwjPU=; b=M
	DkxkrjltfuT+Nr/6oVu4TSz9JetYkkzEmAHQe23lL0r1W/CVxH97wRZBz+DDfGwN
	faeVF9S61DuerxvlgQnu9ewdzFEA8e+GH9b0y6yKfugFOg8bVBbSv9iHdJbtarjS
	V19CYracMqS2xpVhZ8OFj7Z89RQWgEjNRZP/GZJDvSaWznehQ4YILoLe+n2MmlYn
	SNx/i/6bV2ZLGTUUCtmBaGsb9OeqQOWOBsM43sZ+J7aIcNlvDdBSv10cC0ZeABJK
	UJetOuqXPLSt4D6hCWS0wur5o30TmX4oHWwxaejY4Ufc2MBuLMXFe5HLVKijksP8
	ezwnYgTsP/5zRNgDPGL6g==
X-ME-Sender: <xms:XDANZ-L_LabBgFi96z_HWzHQSWyoyuc7b-HFoVlL2nGKVNWC7s_RXw>
    <xme:XDANZ2IbyT1G5WI8nIh7iscVjPS4fwe6XpRRaMAfo87A2vWIfPjrzFF8b7FLY-Qge
    Z0pry6eZVLmvyj6T4E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepkedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhhthihnrdifvghltghhsegtoh
    hllhgrsghorhgrrdgtohhmpdhrtghpthhtohepjhgrshhsihhsihhnghhhsghrrghrsehg
    mhgrihhlrdgtohhmpdhrtghpthhtoheprghnuggvrhhsshhonheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepmhgrthhhihgvuhdrphhoihhrihgvrheslhhinhgrrhhordhorhhg
    pdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrh
    gruggvrggurdhorhhgpdhrtghpthhtoheprghfugesthhirdgtohhmpdhrtghpthhtohep
    hhhnrghgrghllhgrsehtihdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:XDANZ-sM8y6aBzEKKq4iIIu1cxumVuBTongaLQr75bdBsOyjsbNPEg>
    <xmx:XDANZzYOn1KY4VaVGo3i0h5-n1TQtdjQ-xPCUwaCrxTrSzVqePV94A>
    <xmx:XDANZ1ZViT6fPyXPqYsUQFiwM9N5Rjq0nZN4AkbeV-NeoNkHVBSsiA>
    <xmx:XDANZ_A1U8NJFNUJT9VHS_9GlopNed5o5S_cDz22V3APQDFw0EiEPQ>
    <xmx:XDANZx5CGF27OpRkgnT70oI-Qh7lw5512YFrgd1OOtb1BkPwByY5rrQe>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 642E82220071; Mon, 14 Oct 2024 10:53:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 14 Oct 2024 14:52:56 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andrew Davis" <afd@ti.com>, "Jassi Brar" <jassisinghbrar@gmail.com>,
 "Bjorn Andersson" <andersson@kernel.org>,
 "Mathieu Poirier" <mathieu.poirier@linaro.org>,
 "Martyn Welch" <martyn.welch@collabora.com>, "Hari Nagalla" <hnagalla@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-Id: <20cd2e17-e118-4421-870c-363fb46e8a5b@app.fastmail.com>
In-Reply-To: <20241014144821.15094-3-afd@ti.com>
References: <20241014144821.15094-1-afd@ti.com>
 <20241014144821.15094-3-afd@ti.com>
Subject: Re: [PATCH 2/2] mailbox: ti-msgmgr: Allow building under COMPILE_TEST
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Oct 14, 2024, at 14:48, Andrew Davis wrote:
> The TI message manager driver can be compiled without ARCH_KEYSTONE
> nor ARCH_K3 enabled. Allow it to be built under COMPILE_TEST.
>
> Signed-off-by: Andrew Davis <afd@ti.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

