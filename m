Return-Path: <linux-kernel+bounces-312428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8246396967A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 10:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4ED81C2351A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA4620012B;
	Tue,  3 Sep 2024 08:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="CcASwc66";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iUjAj74E"
Received: from pfhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D491CE700
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 08:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725350768; cv=none; b=Bps61muqomlbrqr4Q75BHlEgBoYWZyaFs/x1nUgv2prwOBxc/ms5wcy8DaR4XJ5g97MEJi/TVt3F5JRWDkNMzs5HR5uxznrtr6ThBN6O89zqZtTP5exNmGU0a0AeEK9Wzefyx97YbC1jgE6ostGUSPODhh5ghen6kTWMQGbLyOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725350768; c=relaxed/simple;
	bh=LOI7tAqg0fmm4PwuQ5XeDS8jNJqD8exL7xaNwNbvxnM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=TQtFFZy/MCna/jEZoQvOu7P00g05hl6vUfKpCJWhzstLk/mi8XLZBSznuJtGPZbzoyBdDDEfJ9QjsuU8w6sIs5Exm2PXBhE9RskSCQGUEJXjVpsNOaO2L8AKPkNcca810y4JrhuyK8iAuKpif0KAYG+xW6nxoruM5do2ldLlGZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=CcASwc66; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iUjAj74E; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 868D811401E9;
	Tue,  3 Sep 2024 04:06:05 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-01.internal (MEProxy); Tue, 03 Sep 2024 04:06:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1725350765;
	 x=1725437165; bh=5r93MWaJJQSMO5oail0RmsFtM4vGFRa2fu0nxIJMlgg=; b=
	CcASwc66w65rrfPDWz2b3SruDBIOppw36WzPT4bwEJWBmXJ9lUjqLWeXQohgpVjN
	mhvsW130XSbCClvYXUm3dWcetDwUNNog+NTQala830a69hIGUUX5ZaJVtsZQs/8R
	q+zUU2wJWewMpdAK2r6Vr/a47NQjWZ+tPEYVRpWroLHEEXP9dx/UAWh/jYEAYBWj
	7jBFSu6N1MvdaEnO2ilDoK42pAwhjjn18ZxlJVFDB3jLOE2O4qyoTCoCPZ2uU/hZ
	otEQcqTRZGguPWu76HOmdFvhRONHxg2x0QyNkxuySrEgH/8KpC9RWCAFe2EvoJTM
	RtIxR5JM2qDiDEJ+eEk6BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725350765; x=
	1725437165; bh=5r93MWaJJQSMO5oail0RmsFtM4vGFRa2fu0nxIJMlgg=; b=i
	UjAj74EOU5tFHf7eGIe93aS8YDUNUs0oSiQcT6bciu6tkxieWOBXaAEVBFqJBsIf
	6ZHs6MjQ4qdGLYwP5f67sXj7iuCImHAM5efVtjWzSS6jFF9U0WijlLhwBCszv/l1
	spu5VJYA/kXcGTfNEbEOOGW7l2le5Cb5q7zkL2X+UQbeltj5kxmzz/2tQz+RxFPB
	q/WikrTPArQSNeVMyuLuw6OHZOSiG5inUtjkTzDlelzDB1r3G1RYdp6p0WAgrO9d
	Kvinb55pUND8G/7lwkzeSSCsRclWnK3JK6yNrUZwPpYtI/otP7K2H/koYf8V6Fs6
	77+/i7V+4SQqSd6kJmyag==
X-ME-Sender: <xms:bcPWZuVXhOzOuucmpaBTj9L9RNbsTiavjNvovY5IZ9BYELKoAAL-8w>
    <xme:bcPWZoY4jRHKEB8JE2uTnsHcfV0vEFf8iBkaS7zJCRSqC6qkMtLtYnNo4LuGttDMW
    PDqUnWijeTqPwgEcP0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehgedgudeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeek
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhvghrvhgvrdgtohguihhnrgessg
    hoohhtlhhinhdrtghomhdprhgtphhtthhopegthhhrihhsthhophhhvgdrlhgvrhhohies
    tghsghhrohhuphdrvghupdhrtghpthhtohepshhotgeskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepsggrohhluhdrlhhusehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthht
    oheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurd
    horhhgpdhrtghpthhtoheplhhinhhugihpphgtqdguvghvsehlihhsthhsrdhoiihlrggs
    shdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopeigihgrohhlvghirdifrghnghesfihinhgurhhivhgv
    rhdrtghomh
X-ME-Proxy: <xmx:bcPWZs2qslYJ2EH4QUzntUrsIdITPsIqFaMX7ZhO5I45bYUABOvHqA>
    <xmx:bcPWZig1GfkWF5gTEJ5fA2Ejcz8FAwVhP6Jze7Gygsw_Ae-uWx2MQw>
    <xmx:bcPWZoalSO7pT5yfbFhlI6lkqFfFgjhTe_JjdZMUaPcpzynxoE97Uw>
    <xmx:bcPWZqTEWaByDSNVPeMTFfSZBk0XmEt3xmboOudgPOfzB9wfhDUULQ>
    <xmx:bcPWZoDfF_ktGnKJ-0CKQia_rjw0bQeHcOaMTG8yrZZKUfHztqFDzY5G>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7C4A022202A0; Tue,  3 Sep 2024 03:04:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 03 Sep 2024 07:04:13 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Christophe Leroy" <christophe.leroy@csgroup.eu>, soc@kernel.org
Cc: "Herve Codina" <herve.codina@bootlin.com>,
 "Xiaolei Wang" <xiaolei.wang@windriver.com>,
 "Baolu Lu" <baolu.lu@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "Linux ARM" <linux-arm-kernel@lists.infradead.org>
Message-Id: <3c8bd8bb-36d0-4265-a6d9-95b4767c911d@app.fastmail.com>
In-Reply-To: <326d9a7d-7674-4c28-aa40-dd2c190244dd@csgroup.eu>
References: <326d9a7d-7674-4c28-aa40-dd2c190244dd@csgroup.eu>
Subject: Re: [GIT PULL] SOC FSL for 6.12 (retry)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Sep 3, 2024, at 06:36, Christophe Leroy wrote:
> Hi Arnd,
>
> Please pull the following Freescale Soc Drivers changes for 6.12
>
> There are no conflicts with latest linux-next tree.

Thanks, pulled now.

     Arnd

