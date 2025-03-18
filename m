Return-Path: <linux-kernel+bounces-566330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8832CA67680
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50BF188CFA9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 14:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A891220D51C;
	Tue, 18 Mar 2025 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="V0N38Kgx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b6DtvfQd"
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D41189902
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308353; cv=none; b=J4sS2Q7knDsfakBYIM8po5btUgdlRNypEvPOA+lMyVl4gkyvnlckmryF//2u63k+vCqqKMRqtmjs08uiqi5cj8Wc426fVSbCIbeL7r0ElGs96bmsruQa7lCSsj3miTdhE8B2s+7fnpaTuf/xkYq1qp+pV5GkqE41N9IRldpmZcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308353; c=relaxed/simple;
	bh=1+pEQYP97ctcHXhRwHImWFPGQmPjOG/yHCrVfYdL1fw=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=f7kk67QDcGbx7Hgc2Jn1BfOwIAfi6AS6JHsdzRDC7QtF/GpQVZIqC25j5yCmxYQesV8HViJL1RPUG0XEkXtpUnV0voG3/MDcnw8VkuduNBPmZzQmQnqBxAs/j/eibKmz6w3/sc5vj3j6R0BbrPS1D7SrAgoBzsQO3DsEPyhDKuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=V0N38Kgx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b6DtvfQd; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E0F7E11400FC;
	Tue, 18 Mar 2025 10:32:29 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Tue, 18 Mar 2025 10:32:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742308349;
	 x=1742394749; bh=3zH0zIzfMPX0IzLv/ep/R2+X8F/IWB5VDiuwY9CZdp4=; b=
	V0N38Kgx6nEGmzd4ZMp+1yQvwSTQi/T33VxDdfcnKapCZ0ToBWMjpoGp3BJdAJSx
	VSF6wggTPpY3suVD0Yqn/PjhpwwPVlJ6kowBxjQBfXgZFEva7VrjQ16cSZ2Avi3h
	OY18VPd+foa+WZBO18dswpv0REP7U/r3dmKKqauP1l4XSvopZB+kkoM2sf3ngIeE
	ajLrX2VS45VjnfuheDxnqTCGc5e7tWH6IO0jYvsSxUTzgKT/sJJXv+9jUiwUkDwh
	zHHTwlJNYPt7cQbNDOdMTAO2IzYJ/XeSA96S9EjzdMG84dLiFqsOF4Yw+1JUkFW2
	ioaqlueoKepW06yNDkyZfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742308349; x=
	1742394749; bh=3zH0zIzfMPX0IzLv/ep/R2+X8F/IWB5VDiuwY9CZdp4=; b=b
	6DtvfQd7+bbD3NnKcOyCSNCKlbHAYiXEapIFLKoAsTFJnDUmEoTRshJezRSjYliG
	vIQP2A0XQwiUXONPbjH+l9AtWtvbKospWxgQusXAErIvcLpBff6goAq4aed/0DNg
	KuYcS+RPvs2Lcxoph/hJbH6cfCxOgpM9X7CB7e3Wou+bOC/ck5XW4kBb+Cs2Gx88
	45t1FD5kQVPioY7fDfzUiz7mIbXV8Mg3Y60HdncKwOUhmoZa3nRVEkNCxV+zp111
	AaAokmDaw3t3OgfEzFO8tGNeK/BoyX8mPovo6xozWNxZ7c0SpkwN078P+uIWiPk7
	dnFrgHmjcnqC7Hkk7XgzA==
X-ME-Sender: <xms:_YPZZ9MvwaGfvpuNBXY8lMBPHHD2Twvbb3inkGMeZzfoBMx9fHdZHw>
    <xme:_YPZZ_8Ks8igkmOzMWQC_bvcjr1nDA2VSnS8alWuC-ohjwZhoWrM1ouiIel2a-O-f
    EXvvV_w4cE1p2oKzq8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedvieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertder
    tdejnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhepvdfhvdekueduveffffetgfdvveefvdelhedv
    vdegjedvfeehtdeggeevheefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtohhphhgvrdhlvg
    hrohihsegtshhgrhhouhhprdgvuhdprhgtphhtthhopehsthhuhihouggvrhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonh
    drohhrghdprhgtphhtthhopehlihhnuhigphhptgdquggvvheslhhishhtshdrohiilhgr
    sghsrdhorhhgpdhrtghpthhtohepihhorghnrgdrtghiohhrnhgvihesnhigphdrtghomh
    dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:_YPZZ8QgkYzueg74dpDz6gXxtf5SuLTW93kUM-8tBS-BwnCfxlQbjw>
    <xmx:_YPZZ5t3zq5oY-M-hWPcXo7MU4ZoBSTFe5BJOSFnycCRJng8dhnX9A>
    <xmx:_YPZZ1fzhdYUfDTFSbWWyiT06fOIirsEqhDsTPEZSm96DP2X9n1MsA>
    <xmx:_YPZZ11iw_bqsKUu4q0uX11j5BS3adXQGToOL-0Vi1aJMelhegSodg>
    <xmx:_YPZZ-FFMkLtJ0HFhO1ojikVsSkN3u7l3RlmwVAydIqm2Vtpwt6Q5czw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 683C82220072; Tue, 18 Mar 2025 10:32:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T9cc54f082f285df0
Date: Tue, 18 Mar 2025 15:31:51 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Ioana Ciornei" <ioana.ciornei@nxp.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Stuart Yoder" <stuyoder@gmail.com>
Cc: linux-kernel@vger.kernel.org,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Message-Id: <62924bca-3495-4cb8-83cf-b0b9812ce45c@app.fastmail.com>
In-Reply-To: <1d822960-85a7-42b3-88cf-9d3dbc75a831@csgroup.eu>
References: <2xzljdzktgpsyag5jhfwbxc2sroaacljecsq36hlxefu6jnz6g@zlorxu7niqnq>
 <1d822960-85a7-42b3-88cf-9d3dbc75a831@csgroup.eu>
Subject: Re: Maintenance path for the fsl-mc bus
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025, at 14:46, Christophe Leroy wrote:
> Le 18/03/2025 =C3=A0 11:40, Ioana Ciornei a =C3=A9crit=C2=A0:
>>
>> Christophe, would you be open to pick up patches for this bus driver
>> through your tree?
>
> Yes its fine for me to take it via my soc fsl subtree unless Arnd tell=
s=20
> different. But be aware that it will be purely administrative. I will=20
> have no mean to check whether any changes are actually working properl=
y.
>
> In that case please add the following entry in MAINTAINERS:
>
> L:	linuxppc-dev@lists.ozlabs.org

Sounds good, thank you for helping out!

     Arnd

