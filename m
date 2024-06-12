Return-Path: <linux-kernel+bounces-211164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF7B904DF4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 10:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87862B244A7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 08:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1FE16C87F;
	Wed, 12 Jun 2024 08:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="cLtineVW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ep5NWYR1"
Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8049516C852;
	Wed, 12 Jun 2024 08:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718180358; cv=none; b=pE8dQzKKWOS3iwhfat7BCAAnHxBoprNFi31trvwXC6XkXcJBRoM+lDUSOS++wTo3YwQR/MYD1fvs/l6mhyE7Ea/fnBGr7EeXx3kMTP59TYHilKk9s9wG3AXZURmRGK1mrBQ9q2DoZrDFiF7tS9UTAjAOksJTX7Vi9udmVnErmyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718180358; c=relaxed/simple;
	bh=y//vbwfgBmVOrV/PuTjRTGtOTJ16+anauhBJjxDnZS0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=k9veehGSD4nLbnhZNvvSGkthC24uf+bHc9x8fOaLhs04YWSmoftP+05hFYrcF2Ss5qs+95mhN7lp0hyR4ngcjBZRx41g5cYQCH3qDCNFq0ozgrLw2D+ldDS9VYRolcWgITpsROPQcvdcIvCWRdlH75CqLF2XgYbz3WfOJ8Xce3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=cLtineVW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ep5NWYR1; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8EFBB1380193;
	Wed, 12 Jun 2024 04:19:14 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 12 Jun 2024 04:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718180354; x=1718266754; bh=d8ymq7h+Su
	pUPB1TveszzEzISILgzgA3jwE5Eb5tOo8=; b=cLtineVW9mr/pV8qARMG2jgqOS
	+5XYZXEOoVSCYDVQdas5V5ZBdf2YV8Ae2k+/bfx5LJBmWNSlh+OD/PB6uaXZqZ1s
	HqM7g8ErabNRspnQ5XaLsJJIMTk4qDzcn1fxXZc1rLMmGOzrBwv9sERSPA9oZVJd
	dJYIq+G18nb+nZ6cb0+gVXzUAYWyTaM9q7r+mi093YKkcCSHyARHElKBGoAh6oG1
	ARAWdmKtLhgi2qPFun7jQJSKdRWfISSeSFnk/dMQ5hBxkvnglD7Wk7lHbkllfccz
	jm1CId6N41DKpfjjNLvyf64Bfh5zByI+lyffSQYm+vUAx3+SKp3MKRedsIdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718180354; x=1718266754; bh=d8ymq7h+SupUPB1TveszzEzISILg
	zgA3jwE5Eb5tOo8=; b=Ep5NWYR1umrudPmeDMu5zJ40VHbQhuNrWLLvsC+AvDGa
	Ck9he2H8ZwTc6/uvUGegKIv2tFoXhYR9e+TnP1ke5YFTfMJroMsqXBBpzqRlrBia
	iFM/8hmBILSkGNuM1NI1x0TWb0MeZnagFm0w9+XzKck4c+V+Bik0oCNkDsiMQG2Z
	N0h5j+Bqy0j1p2EC0pT5OP2MRr7dOh84/TvhpDyaM6zrote36lO4UFZIAbJiJa8M
	1zPvdIf5yCKhMiuobjI/RW4mb45QndV2UKaFmeYbKcIR/c7O2dA1eyvdY3QCxbMo
	cRGITwOdyhbL6XgPr77iZ6MU9r9zzezjADrlvQ4oTg==
X-ME-Sender: <xms:AlppZgyhzFuOFYwRPkvpuRiZVMiS-XWloRkTwKptMs84lMwYsWPx2w>
    <xme:AlppZkR21xV8qOeULUtzpTHFseQBiudMO_FFYipXMIq_UButUWe2g6weD_C0MR7d4
    PCrFDq_UpeaehILs9s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedugedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:AlppZiXLDtfOBZktVAvgWTF0ksGBBajqeywK6hU7pK4KVR_NpZtQzw>
    <xmx:AlppZugoz3yNYqwEzCEGHKewNaDkoVoQ5PDYt7-4D4MYXPI3Mi2pEA>
    <xmx:AlppZiCfGGV2Q67Gjfk5v1vObUSV_TRM2ODFvniUt5bHjHGuoH3_mQ>
    <xmx:AlppZvIc2Rx6ZYp0hZvwZI9EhosZMfB1rLtQ6dyuTqbMl2X4fCH39w>
    <xmx:AlppZq6qYlLxPN7FqNnVAsjF9zzvF184QZ0j8p5vaNoOR26uVR5RX2Xe>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 00598B6008D; Wed, 12 Jun 2024 04:19:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-515-g87b2bad5a-fm-20240604.001-g87b2bad5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cfad60ae-3dee-4c03-84c0-734f1fa59ff2@app.fastmail.com>
In-Reply-To: <ea604d75-e571-4d63-a7e2-aa1393588c75@collabora.com>
References: <20240611-md-drivers-soc-v1-1-8f0fc9fff234@quicinc.com>
 <a314c676-3dbd-46f8-826a-2e59367d30ce@linaro.org>
 <ea604d75-e571-4d63-a7e2-aa1393588c75@collabora.com>
Date: Wed, 12 Jun 2024 10:18:53 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Jeff Johnson" <quic_jjohnson@quicinc.com>,
 "Kevin Hilman" <khilman@baylibre.com>,
 "Jerome Brunet" <jbrunet@baylibre.com>,
 "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
 "Shawn Guo" <shawnguo@kernel.org>, "Sascha Hauer" <s.hauer@pengutronix.de>,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>,
 "Fabio Estevam" <festevam@gmail.com>, "Linus Walleij" <linusw@kernel.org>,
 "Imre Kaloz" <kaloz@openwrt.org>, "Matthias Brugger" <matthias.bgg@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] soc: add missing MODULE_DESCRIPTION() macros
Content-Type: text/plain

On Wed, Jun 12, 2024, at 10:12, AngeloGioacchino Del Regno wrote:

> MediaTek:
> Reviewed-by: AngeloGioacchino Del Regno 
> <angelogioacchino.delregno@collabora.com>
>
> ...but I'm not sure how we should apply this? :-)
>
> Either Arnd takes it directly, or you split it per-soc... and I don't have any
> preference anyway.
>
> (P.S.: Added Arnd to the loop)

I think in this case it makes sense to keep it as a single
patch, no need to clutter up the git log with identical
one-line changes.

Jeff, can you send this to soc@kernel.org (cc:lakml)
once you feel you have enough Acks? That will put it
into my patchwork queue.

      Arnd

