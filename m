Return-Path: <linux-kernel+bounces-518690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BFFA39351
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 07:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9DAF171513
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 06:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1D31B393A;
	Tue, 18 Feb 2025 06:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="fimVQ4IJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TharH8Ow"
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDBC1A5BAB
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 06:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739858695; cv=none; b=rfZjV7xrMkZq5CAMWpjdq5+MpShEXETk36tmfTVgBXkz1mMacTvS9+Tjejd2P8IjBg2ORNxBunqOBeQBrmb5ONm7ehaOYLxSAE5tdpTC4gNLdCk8TMCNgCWw8/iB20/J99C3dfGrTugRCA/xXUR9yetKL7g8A2nn28QEnubBTas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739858695; c=relaxed/simple;
	bh=TQKaOIOFrollfIGV6/6jz9iGl00WlCb0IdCZQ5DyFaY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Xujktlp9HvY+zF6R85MUPFRM+Gri7LXrEsVphfKKoM4f6jzBBoaaCLlnKGY5D2rFfoM0eTyg/QVbQle94r2Vi1+SACUl2xCx54oXyfysJOO1Rv3yCejv9NuPFiSCjTJCTAG/uReOtw4cLmWBmpZfV/I/L6NYqwUrM/RJHCik+Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=fimVQ4IJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TharH8Ow; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id B75121140140;
	Tue, 18 Feb 2025 01:04:51 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-11.internal (MEProxy); Tue, 18 Feb 2025 01:04:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739858691;
	 x=1739945091; bh=AYtmHAxkcEz97IEUTxPuQKK88lMq79n0dFVotZLNv4Y=; b=
	fimVQ4IJJxpd7U7+wWrvH40+gn0RGaQlc3sGhrPzQhix/OgNm7+AymAdvtSaaxMw
	uBGwBTQ+A91vzH9ArO3+ek+zSrCrQsr+cwUKIUk0/FWj7M+ht6/tLAMymGJ4ObNy
	Gv4RAT+SSmCP1Vk7I0IopdR4OfQ/PBfiiF3IpPkhI0eayxHZm6daiZlcVVji4OQ4
	W2zbDzM9a8dBJ69qKpHsyDLyko2zRyvUJoYzugrH9/qmwqlVK8lnaOU1L6VmIOUA
	5g5qgvF2dLt8am7d5HkPEf1Q+duaP83enFWLfrLl9/O+JtrfO/WBre4MHvB0vriP
	EFILQ3RmacSyMhjn71YNoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739858691; x=
	1739945091; bh=AYtmHAxkcEz97IEUTxPuQKK88lMq79n0dFVotZLNv4Y=; b=T
	harH8OwmFFaFv4He81pLRKktbKPFO2AhhYjW6vl+RtcPHGdtob9rLsORheT+j1U/
	A6ONqYpt83nQRtyFvyZSBrkA1RDCOjA/7bOG+7sfFgOPoBIvoj4FDuzI7t25Kpso
	Mbn+ViSm3yOc3FGtfuAjx/3o5HwuSkk73YCKJeS8eanaU+aukC7Um2oWgGkXOhD5
	ceyWrydTUjHj7oBa6ZitCyvox3fuebd8X/NEkIDoCmi2/pcdr/2YOnz+ZtBfFFuT
	OF01Ec278yxWiqTYRuOcsqudArCjIguZqWOdHR6KTds6sGzootNKKRM7cim5/5zc
	sX0ZGrUslZ4gClzU0rDoQ==
X-ME-Sender: <xms:AyO0Z6BFVnBnJyGLQwd_b-PNvmzdb1gUMGvTm3vs_QoaMwAvURKyCQ>
    <xme:AyO0Z0iBv47NQs4cdMHXjSL3wwEI9ugk02B4NwSkIWm8Ve0O_EjQOGLf4mZrTFFDU
    lIqNu2qvUZPURBTFqM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeei
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeiifhhighhurhgrsegtohguvgifvg
    grvhgvrhhsrdgtohhmpdhrtghpthhtoheplhhkphesihhnthgvlhdrtghomhdprhgtphht
    thhopeholhhivhgvrhdrshgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepphhhih
    hlihhprdhlihesihhnthgvlhdrtghomhdprhgtphhtthhopehovgdqkhgsuhhilhguqdgr
    lhhlsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqkhgvrh
    hnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:AyO0Z9kTcWseGX-YWU_t62bT-sKRKfXdCt0cNmw-UhNpxrcmnAoMBw>
    <xmx:AyO0Z4zV6RVFX5ZKxqZ2vOKFnFWsjSQuoTH52iu8SotByY6ViZ7D7w>
    <xmx:AyO0Z_R4v-soE2w11QJg4odTeJwy9pOMgrWAAyMz7T2KEVIxsAEJvg>
    <xmx:AyO0ZzZUCAGEb5Av3-7JyT8ORNVvzSgCZIfiPGMkpUoO9ZXtsMawKA>
    <xmx:AyO0ZwIRe3_0ia7sLxshaYQGgSY2gfzut3RRDf8CdNuNvxRGnef4Imst>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 54F142220072; Tue, 18 Feb 2025 01:04:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 18 Feb 2025 07:04:29 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "kernel test robot" <oliver.sang@intel.com>
Cc: "Philip Li" <philip.li@intel.com>,
 "Elizabeth Figura" <zfigura@codeweavers.com>,
 "kernel test robot" <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org
Message-Id: <fb5dc931-e97f-4e4b-83c4-06488f083c1e@app.fastmail.com>
In-Reply-To: <Z7P0Di/nCSVdjifN@xsang-OptiPlex-9020>
References: <202502072019.LYoCR9bF-lkp@intel.com>
 <2421077.NG923GbCHz@camazotz> <Z68CX3HMEUW00WYi@rli9-mobl>
 <9791da8a-fb5f-46d0-a86f-66738293d155@app.fastmail.com>
 <Z7P0Di/nCSVdjifN@xsang-OptiPlex-9020>
Subject: Re: include/linux/thread_info.h:259:25: error: call to '__bad_copy_to'
 declared with attribute error: copy destination size is too small
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Feb 18, 2025, at 03:44, Oliver Sang wrote:
> On Fri, Feb 14, 2025 at 12:22:33PM +0100, Arnd Bergmann wrote:
>> On Fri, Feb 14, 2025, at 09:44, Philip Li wrote:
>> > On Mon, Feb 10, 2025 at 02:39:46PM -0600, Elizabeth Figura wrote:
>> 
>> Maybe the change below would address it? (Not sure I handled the
>> "+1" right here, but something like that should make it obvious
>> to the compiler what the check is).
>
> yes, below change fixed the build error we reported. thanks
>
> Tested-by: kernel test robot <oliver.sang@intel.com>

Thanks for testing!

Elizabeth, can you turn this into a proper patch with
"Suggested-by: Arnd Bergmann <arnd@arndb.de>"? I assume
you'll want to make some slight changes to ensure it's
both readable and correct, but apparently calculating
the size in bytes and do both the range checking and
the copy based on that is what makes gcc see the limit
correctly.

      Arnd

