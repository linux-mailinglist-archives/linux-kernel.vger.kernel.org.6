Return-Path: <linux-kernel+bounces-299237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5021595D1E0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83C341C2287D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 15:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9338818F2F2;
	Fri, 23 Aug 2024 15:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="laETiYD7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p8s61STj"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1AB18B48C
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724427715; cv=none; b=U3U9K9bRka9VGGsNk8LjOnNyE/lb+3/hElws796fpTgR9X8mGGDzYWrlb39JZ2O3WICx2KVhqzSKL9reSJwqjF5a6pqF+Tfm7gLJkMga7r//IuPh4z60QA1Jbj1V9lr7W417pFcl7/R9yFJSdZpTqbY/MuFbaltKe1/IuWHvGa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724427715; c=relaxed/simple;
	bh=ShCzxAPvv69IrJzbrsojR6h/jXZL1X/sxX9qdaSRkEU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=IJ2CJHCwV2aQGIpPtqsKqXtTL2zzsIbbRTc3PTXWMa13qpQTwir7myZX1IYaE/CjG7YZTvlszqHGfweTEXNN+lP7CbY4qFn4wYkFysgUHhpJF11hXqTNnCqx7RzTz+3fQvVFAFnnOBnbK1VMy2yE/nHiUEDBJvuE8AYT8Px96sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=laETiYD7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p8s61STj; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 764161388210;
	Fri, 23 Aug 2024 11:41:51 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-04.internal (MEProxy); Fri, 23 Aug 2024 11:41:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1724427711;
	 x=1724514111; bh=VqdQTKL42lz/bdHyCEoI0rDCux3HqzKaMK4cmOZsM4A=; b=
	laETiYD72QUBUTGBj+R/8eRtK80/TjeR2u+XZVuDN/tOr+76Y2WsLETfgp4RKpgF
	Ppzp0fBj3/mhZmnGDBk/Jpx8wOCiyggQA6n0foEd8IrCYZbQdwxY5TlmVMKikrQ6
	teWCLg71Gdtcu8nXxZVctvMVgH5dnVLDAGhbu7EGwKjONsApChg8khEqueEulHNA
	50Q6qwhgRDq35vrHesTkkdksyB6G5Y7F6SGA9Jn5RXLIFnia69Nh27tY33ChPR3Y
	1gIcEVwKOXN342FX+4qd4YqwhFcepHnHWMSSHlkDc6lswmFZCfpuhw1aZNEIEN/j
	g6KXIQ8rmbbpE0aG/ryWcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724427711; x=
	1724514111; bh=VqdQTKL42lz/bdHyCEoI0rDCux3HqzKaMK4cmOZsM4A=; b=p
	8s61STjV45dVWnIZjParhTj96scqch4hGM8IinJruSabn99B5kbwCJ8uL5tM5+se
	DEyzXFdOiVRrpP+zP0t3ypNmon+QRXRbShwHTFlcwg1Rbt1Aq96xc5MhPVwSuCJT
	y9Y3aik7Oj8gajgt3E6/3hlJPc4GARgjQcP5eZJYjkMnpoGH0pBi/I6fxdT6AIzi
	QSOnGaYpdJh9S9v9ndSyb9svspwk/RrXUDwK1x8z4bZZwk1+ftm2sQ7pKvr2fljK
	BXl3VNQ2Tpyv9M6fRBaYbqgeNy2qtIJ5fQUVCTcgjK7Mp+ANBXphlpx5i4FomdzG
	xRkoKUljyfrSlXCaFQA+Q==
X-ME-Sender: <xms:v63IZpdFto-WplIfOHKej4NvmTXXX_kklL_4HF330pyUFB9W5a0S7w>
    <xme:v63IZnNnS1RUl54y2Rks_rQKSPXVLzc-Dh8vH1dHCytolmiZbkLnPGmxpUaPle9_W
    j9VFHpRHANWmGMMUCc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvvddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegstghmqdhkvghrnhgvlhdqfhgvvg
    gusggrtghkqdhlihhsthessghrohgruggtohhmrdgtohhmpdhrtghpthhtohepfhhlohhr
    ihgrnhdrfhgrihhnvghllhhisegsrhhorggutghomhdrtghomhdprhgtphhtthhopeifrg
    hhrhgvnhhsthesghhmgidrnhgvthdprhgtphhtthhopehkihgvrhgrnhdrsghinhhghhgr
    mhesihguvggrshhonhgsohgrrhgurdgtohhmpdhrtghpthhtoheplhgruhhrvghnthdrph
    hinhgthhgrrhhtsehiuggvrghsohhnsghorghrugdrtghomhdprhgtphhtthhopehumhgr
    nhhgrdhjrghinhesihguvggrshhonhgsohgrrhgurdgtohhmpdhrtghpthhtohepuggrnh
    drtggrrhhpvghnthgvrheslhhinhgrrhhordhorhhgpdhrtghpthhtohepghhrvghgkhhh
    sehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqrg
    hrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhg
X-ME-Proxy: <xmx:v63IZii2cLLuOPhNIoVSTiUgnlHnCUZni1znD49hQg5kHhZumwRQ3Q>
    <xmx:v63IZi_raB_cr_81JekS9bxLCol_H3QpqjrFlgPxjlUdJz1-tEJEzQ>
    <xmx:v63IZlshkHD7nr0R6kTWAuAs7ipuB-IFGEz0rzJW37ziDcjnqTdCeQ>
    <xmx:v63IZhGSIJZaV5lsayvYC8F8RRVk0RrLxRDHwLxBIC3guSJBg-dUgA>
    <xmx:v63IZmNU6efGpIhTHTAzqTr9zECDtfmQoREsPlEAqZzAocxAQs2XzZSJ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 26F09222006F; Fri, 23 Aug 2024 11:41:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 23 Aug 2024 15:41:00 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Umang Jain" <umang.jain@ideasonboard.com>,
 "Florian Fainelli" <florian.fainelli@broadcom.com>,
 "Broadcom internal kernel review list" <bcm-kernel-feedback-list@broadcom.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, "Dan Carpenter" <dan.carpenter@linaro.org>,
 "laurent.pinchart" <laurent.pinchart@ideasonboard.com>,
 "Kieran Bingham" <kieran.bingham@ideasonboard.com>,
 "Stefan Wahren" <wahrenst@gmx.net>,
 "Dave Stevenson" <dave.stevenson@raspberrypi.com>,
 "Phil Elwell" <phil@raspberrypi.com>
Message-Id: <08aa277d-a966-4785-921e-6a63a2e5922b@app.fastmail.com>
In-Reply-To: <20240823-to_sent2-v1-4-8bc182a0adaf@ideasonboard.com>
References: <20240823-to_sent2-v1-0-8bc182a0adaf@ideasonboard.com>
 <20240823-to_sent2-v1-4-8bc182a0adaf@ideasonboard.com>
Subject: Re: [PATCH 4/7] staging: vchiq_core: Factor out bulk transfer for
 (no/)callback mode
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Aug 23, 2024, at 15:14, Umang Jain wrote:

> 
> +int
> +bulk_xfer_callback_interruptible(struct vchiq_instance *instance, 
> unsigned int handle,
> +				 void *offset, void __user *uoffset, int size,
> +				 enum vchiq_bulk_mode mode, void *userdata,
> +				 enum vchiq_bulk_dir dir)

It seems you can also tighten the argument types here a bit more:

- uoffset is always NULL and can be left out
- userdata is either NULL or a struct mmal_msg_context, so you can use
  that type directly.

     Arnd

