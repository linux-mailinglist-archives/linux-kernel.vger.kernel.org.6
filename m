Return-Path: <linux-kernel+bounces-513357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C7CA34970
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1892188FF61
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31366221553;
	Thu, 13 Feb 2025 16:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="9Hy452L+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aEIBhSP1"
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D00200130
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463294; cv=none; b=b2FPYhE5Cggujvic8QrIJfK1K2tLGiE3uhlMx2tofLrJCTI/8jqqhp2RSyl2MTBoxaw9kxdBrZauQgGSAzjrC3BnNKS5TkqKn6Gk9KWnSyR0m7l6KeVkO/8Xi/lu7U3q84XaDs2SNa4NxaQZPgEPf5zDRehRrmUIUII2IsQ9vsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463294; c=relaxed/simple;
	bh=vB2tLQ8luJCtcby10TZWuCWKxWvuKnuAiaEweV/fb5c=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=JJ6VDQKyTx5pQQPmwLyj7pfL0naP0/uwPlzPZCkNIMs2oeRna2tgRCYgmIvszoWjHJdoR3pUCaQr+zktFrM2hBIeu4PnTkexmjgNr+1i4z+BAl9LSKkFgATtaCkUdXb3IAlMMZg/aAkTRIlOLUfgmutkvBOWUW9xRCyHjPkwYwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=9Hy452L+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aEIBhSP1; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 5E87F138009C;
	Thu, 13 Feb 2025 11:14:51 -0500 (EST)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-10.internal (MEProxy); Thu, 13 Feb 2025 11:14:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1739463291; x=1739549691; bh=vB2tLQ8luJCtcby10TZWuCWKxWvuKnuA
	iaEweV/fb5c=; b=9Hy452L+xFsWrycvvvMpOR9cm+RELglLGmf10ti5XFJpCPra
	aAFURThZV4MJxFN3JrXiPzcJYC7oyrXNsemLBK8G0WWPHSLU+8Uj4DYiTJE2Z15S
	NHiuo6kmBUERoogKifYuNLdDfz+zzEurt0CbIWRgKaZM7LEj+YIWLGu9UmTJZmM5
	+Tc7X5ySExZ0Ee8GRJt9AFuhr9j2TUWMwmNict5HHxJi1RHisypS5LGwXfFMVXDO
	1OcGHZDyzCOB6Rk0VYfATbMSJdmeBNAxhKATpLcGosUIFov+2IpBTvNwc0VJYgL+
	F2rKYC5+c2qORhR1reHTRbIXaeopPI7dtk/oNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739463291; x=
	1739549691; bh=vB2tLQ8luJCtcby10TZWuCWKxWvuKnuAiaEweV/fb5c=; b=a
	EIBhSP1UMOzP32rXYDdRMd9nK+mSv0CVZBScor0GRIswWzchuBi4SKCIljXYZWzD
	ZIDUGqG5UMu6qDxoWN0FfW+5SWXnI5bVr+WybgQDGHeLjrB9Np8WhLzrYp1Qge3U
	HUsYTxsiYfHZ8xoOMNul0s/qzc4WJSQ1xL6A/M0UN/WpZx3o2wkLJoCh/6xQHZzb
	Cr0lEluVENMTss/xAalNIwEnMEH6N53wizYoCjrZdxLQH0rb600v9FbXRYUVjNvd
	HcvzCFTlDU3pvnG7sKh1quEaTu4LlA1Ql/lhJiRWspSQlvm5QhZHxizW8Sl9RWRZ
	qFUZUMRjokZdk/6ynXpLA==
X-ME-Sender: <xms:eRquZ1tInnf9kRqzkJYdsJgqzfmpV6gZGjgjXJNIFJbokixtEqKbHw>
    <xme:eRquZ-esQAlMFQFvO1mBsM7OZ1UtJrb7tQAERI6MmUBx3BZf2pre8nnJFwsGb-9m8
    6GjRV5ggtbEn5v9BEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegjedvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdfuvhgvnhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvg
    hrrdguvghvqeenucggtffrrghtthgvrhhnpeelfeetueegudduueduuefhfeehgeevkeeu
    feffvdffkedtffffleevffdvvdeuffenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvhdpnhgspghr
    tghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvggrlhesgh
    homhhprgdruggvvhdprhgtphhtthhopehsrghgihesghhrihhmsggvrhhgrdhmvgdprhgt
    phhtthhopegrgigsohgvsehkvghrnhgvlhdrughkpdhrtghpthhtohepkhgsuhhstghhse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlhes
    lhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhnvh
    hmvgeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegrshgrhhhi
    sehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohephhgthheslhhsthdruggvpd
    hrtghpthhtohepmhgrrhgtrghnsehmrghrtggrnhdrshht
X-ME-Proxy: <xmx:eRquZ4yANbrFpU9QyTEousZ9LrqnpIPXkZxxa-PGG083rHBHu56Czg>
    <xmx:eRquZ8PvOIgF_dIudDTbFb3hYzN3VV57sFtxSNSpx9W30UeOKXeH-Q>
    <xmx:eRquZ18Mr4WTOqZxZktpBpbJjwc7YzYHAPIvbJRaxFJOFw4lUyP2xA>
    <xmx:eRquZ8U6IHsHWO0WvdWVOadkBlGVRqHWhGvy7Uw0Z-yEspRiaaBPbQ>
    <xmx:exquZ8WIfkMqIOhgPSSFSrjSXxYGnq_gLIRbnQGTv-MXeOuObrmogYKI>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 798FDBA0070; Thu, 13 Feb 2025 11:14:49 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 13 Feb 2025 17:14:28 +0100
From: "Sven Peter" <sven@svenpeter.dev>
To: "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
 "Hector Martin" <marcan@marcan.st>, "Keith Busch" <kbusch@kernel.org>,
 "Jens Axboe" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "Philipp Zabel" <p.zabel@pengutronix.de>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Neal Gompa" <neal@gompa.dev>
Message-Id: <dec49be0-c49c-4c37-8faf-72d9f89e4d53@app.fastmail.com>
In-Reply-To: <20250213-nvme-fixes-v2-0-a20032d13e38@rosenzweig.io>
References: <20250213-nvme-fixes-v2-0-a20032d13e38@rosenzweig.io>
Subject: Re: [PATCH v2 0/2] apple-nvme: bug fixes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Feb 13, 2025, at 17:12, Alyssa Rosenzweig wrote:
> This small series fixes two unrelated issues with the Apple NVMe driver.
>
> * fix NVMe on certain combinations of firmware + machine
> * fix a power domain leak
>
> Although these are strict bug fixes, given the early stage of mainlining
> for these SoCs, none of this needs to be backported.
>
> Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> ---

For both patches:

Reviewed-by: Sven Peter <sven@svenpeter.dev>



Best,


Sven

