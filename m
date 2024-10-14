Return-Path: <linux-kernel+bounces-364266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6AE99CF89
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C0911F20B59
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 14:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6558E1B86CC;
	Mon, 14 Oct 2024 14:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="IrSgdyf1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pVTOtiNm"
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AEA1B85E3
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917571; cv=none; b=FzQ9+UhXVcxOzAuZgO/unINIRVbk+Ki6jeZeLIv2oPl9yUjMU0RBHhj5/LK3zAU5jwPeKkWqGcrJFL/nzQr3daBHr+g+blfK4nI1jhpuWH0VP4Hdt3RO8NhB54VjM+i99rsnmGJT+XWBnc3TFguvpYUNN33B5O/T7u7WUDPtqFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917571; c=relaxed/simple;
	bh=3tCkJtH0zR8hg0h1qmVQUbMllW6WzIa5Ny4hr98tpbQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=n9sqcah+gy6iU4Hzbt9XQVAM2ZO7INVt648WNs35uhbLsYXzCdp/+is15aBVsMu7DJ0//rNVeNeeWwthcmrWMj210vRb7lX61DfRoJM7AVo+08kCI4YObdqE/h2eN4oiWKG10ATfN5bUjbeE3lzkBrfWEazuqx5fWbuyOHXhx1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=IrSgdyf1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pVTOtiNm; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4E3E611400B0;
	Mon, 14 Oct 2024 10:52:47 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 14 Oct 2024 10:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728917567;
	 x=1729003967; bh=3tCkJtH0zR8hg0h1qmVQUbMllW6WzIa5Ny4hr98tpbQ=; b=
	IrSgdyf18iwOX2OXQFmsHz8OGA8isx28tGDOkZ9LK+L4j3an//V+EUTbfPyZrILu
	0K0R4XtNCSyVuenwJRZS4Q5+kgzG3Of8prk6UuAfv/7JaLKghAIS6f7Ex27P7BAa
	48gIWSs2UOU1iTpo7j5KR43w0hAflXi38jKcCgft8/kncGsuLuLRpnWBMl9ptKIJ
	U0Hcwh2GmLha4sfZfZxFnbvd9ycLfFuPWk95fvYVUt8xf34XyHAmiPsFHMySsuJu
	SIo5ScnQUPC5LrGcWhiG8VNSVz3NA+4X90H42pf4K70GoBJ22pGYbVwaYrLgiPNa
	RxR78RfN3e7NDxGCZc2lRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728917567; x=
	1729003967; bh=3tCkJtH0zR8hg0h1qmVQUbMllW6WzIa5Ny4hr98tpbQ=; b=p
	VTOtiNmVIbtFVO/RWS5IFJBazA4Bp+mVWuACxQeKLt3aXm84dRpUKNhcnI45nCoF
	C/t2BoM/8Vz9Pae+Tqq9be3THKQX2U1Kag6nsZd4p1NoqwMOz1yX4IyyWz2ZeGw4
	qiCKShmhqHdCdHGs5eFsRIVKh+ViDh+esByJgzyxaAtXXnke/zg01itIvDBF0WK7
	+FB/ZUf3KyCo0XKLIohftIvZp91Th/TcOFf6SzaHGM0D8Kol3OQMAx++jVAz6SNO
	+zwzoXUrqmIZbqid+7aSikA0B/l1dHWnafWcdRErkcPi3khiGJZAgO7pnwy22N9P
	LHltC9Z9u+G65HxMHN8LQ==
X-ME-Sender: <xms:PzANZ5dnAa-yF3_XFwVSzSHOaH2N69vzwni3sS9F5MFxPycyPeNI4w>
    <xme:PzANZ3Ph1H9qOB9Jd2ZsfgW41njrIickl-dQcj5NwB3CARkYq7yLVeKRcJ12uBQQb
    bf2-Ef4kSM5JohobCI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepkedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrhhthihnrdifvghltghhsegtoh
    hllhgrsghorhgrrdgtohhmpdhrtghpthhtohepjhgrshhsihhsihhnghhhsghrrghrsehg
    mhgrihhlrdgtohhmpdhrtghpthhtoheprghnuggvrhhsshhonheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepmhgrthhhihgvuhdrphhoihhrihgvrheslhhinhgrrhhordhorhhg
    pdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrh
    gruggvrggurdhorhhgpdhrtghpthhtoheprghfugesthhirdgtohhmpdhrtghpthhtohep
    hhhnrghgrghllhgrsehtihdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:PzANZyiolTcmaLSdKlnLF_2NV09Gmu_LhRw04JczFbzAArIAesZKmA>
    <xmx:PzANZy_1jxkRzHZ3MY_wtsAej-C7hrbLel_SfLMY8-jtBUTdTqaLWA>
    <xmx:PzANZ1tjKz6VULZrA-scBpCDsWhTFs0uRmWShJWv9VHppA79gpw3Mw>
    <xmx:PzANZxGsh3YWS3B-9FREtvZHh2K1OUoFJx72CmlaXwtdrv_ABuBAsw>
    <xmx:PzANZ2-uVVnTKa6ahS4u0Ay_9zAa-NJ28CjdC0gV7AzJe8ei3gCCZ3Hd>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id F10462220071; Mon, 14 Oct 2024 10:52:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 14 Oct 2024 14:52:25 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andrew Davis" <afd@ti.com>, "Jassi Brar" <jassisinghbrar@gmail.com>,
 "Bjorn Andersson" <andersson@kernel.org>,
 "Mathieu Poirier" <mathieu.poirier@linaro.org>,
 "Martyn Welch" <martyn.welch@collabora.com>, "Hari Nagalla" <hnagalla@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-Id: <d7f71016-4211-4d59-9d8b-53c47ec47096@app.fastmail.com>
In-Reply-To: <20241014144821.15094-2-afd@ti.com>
References: <20241014144821.15094-1-afd@ti.com>
 <20241014144821.15094-2-afd@ti.com>
Subject: Re: [PATCH 1/2] mailbox: ti-msgmgr: Remove use of of_match_ptr() helper
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Oct 14, 2024, at 14:48, Andrew Davis wrote:
> When OF support is disabled the of_device_id struct match table can be
> conditionally compiled out, this helper allows the assignment to also be
> turned into a NULL conditionally. When the of_device_id struct is not
> conditionally defined based on OF then the table will be unused causing a
> warning. The two options are to either set the table as _maybe_unused, or
> to just remove this helper since the table will always be defined.
> Do the latter here.
>
> Signed-off-by: Andrew Davis <afd@ti.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

