Return-Path: <linux-kernel+bounces-259772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3711B939CF9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7BCF1F22376
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8EC14BF89;
	Tue, 23 Jul 2024 08:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="fSW6PSDT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BkPNhz88"
Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BC91370
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721724659; cv=none; b=Fbp0PTGZQtHMBOWBc37tpZmKAOF3V7Z4+wTIgbM0SukTehu4sYqrIqGauMIcnaR/wK4UeGXMMoSgouR0Yp8cwYiKAwFkXybCNwZmesnfaM4aykH6s9WZWceO/IPcthRfmZ3XyZMO+m0rRQ8ICPckHJhd3qTn9YVHGR6bARad/h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721724659; c=relaxed/simple;
	bh=vVfjWaNJVC6L4VVYOr+oPqcRu5lp3pzb/A5yoHKgEgI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Lu1haWCpkmALzWiU5Duo8CShVy1WfrAs3ND3+v4LdOAPhOXy3KOpfC33z/x0anhHEfSkgRt+boJh02F9FshO8yaHclsxFE6a9yT8YRqCYCwFZ1bHNLLomuUnHQGp4ltCuxb6zQsrp57fEi8nNjQpXVfDdoLcV4Cpx/t786bqRgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=fSW6PSDT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BkPNhz88; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id C2BE013806EF;
	Tue, 23 Jul 2024 04:50:56 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Tue, 23 Jul 2024 04:50:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1721724656; x=1721811056; bh=jlsSg4sLcx
	ok5/E5Mpj5ECh+kmcnLpkuuWWCHaLS/l0=; b=fSW6PSDTcOhQXBT8oKtfQP3yl/
	Uz5gZTK0MjOmEC4p6QWsul5bAdlmXM2HUP5vZNuFv1Jd+vkW4EfwzZ/ICCYeVZRH
	FEIjxFmJN12U+/gmV0ZpUeZm89yA4NYMbjkDWuaf6KyX9UOR9PqAAfjI2A7bEUAb
	83lxMdigthm9V9l+vOB7Vf8h5VEej4SLqR9yfxmwhdApyLJ0EJG45PKZS5HzYjSW
	Imm/kRPieqKPfSsj1t1Egw4RDSzl2YFwJBmArAdPFQtWJC+nJaQIKK6ldnS5/Y15
	AvSIIKNDHOUoQMsLycRgewS8+lrm99p/GoaF9L4JQqHzfP471+NHZhrXB7ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721724656; x=1721811056; bh=jlsSg4sLcxok5/E5Mpj5ECh+kmcn
	LpkuuWWCHaLS/l0=; b=BkPNhz88m8QqYzsn7rgBxAcx4krTybDQtFUe02nHmG/i
	mvWwBLeBC3ceHpkP+ixctgmHnmSOoB4Z+CTUyD8KJfGj+cnQe6bYmb8nY6cA6ml0
	NTZjxpJH8KFmulgexgjkY0dFahOO7lNR0zkjfSz87pyQQgBEBDbgtVEXRGGHSn3F
	JPVPXfEsIpYlxLKKGnGTdZAGU/1X9jSTVpRWxa4p8J0UHtOVsmhguLvW1cK80pT4
	W8G4fvo755ScdzjJHHIcurz73qv+IJEeHIA2LaNBgSu5A5xOQ+QpmC1sqyKDvfa5
	3lHc44a6/lWRSnUSSYbbR4w8w4vg1TOTrQZ4YlaYYA==
X-ME-Sender: <xms:8G6fZqsFHgGTCBJMaRnDr5E0X4Y9H0-pjhFXouaMHQYyxmZJ1HhDsQ>
    <xme:8G6fZvcnej4UYG60RSzwFRJH0_MAL9roMsxpdY_4eXntYAKM8QgBKszZ83hReMfeG
    X4Hk7i4tkN9pdyXbJ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheelgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:8G6fZlxG_1q4XN4hy-HFTIBCkaCOb-9fyvkQLja0iu2tpwBpkLii1w>
    <xmx:8G6fZlMJmwEpb-IUX_nyrJToB72jeLmqsLNsYFJZwzLr-Ai4o9eZQw>
    <xmx:8G6fZq9OK8gfVk8fooo2_uFXrnY2BUar46H2AXNMw3XZKaTAUtr8rA>
    <xmx:8G6fZtVWXO86S4JDY7aRoOepixmlXjROId61o36zvbr-B-sXpflgoA>
    <xmx:8G6fZqwrlOHOQEeNyaNR7K9bZDGUG9C9MSqnwybXdWLOCZpR_dzuRAQk>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 96381B6008D; Tue, 23 Jul 2024 04:50:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-582-g5a02f8850-fm-20240719.002-g5a02f885
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4436aef8-3947-4923-96ee-47516e63e5bb@app.fastmail.com>
In-Reply-To: <20240722094226.21602-29-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-29-ysionneau@kalrayinc.com>
Date: Tue, 23 Jul 2024 08:50:21 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yann Sionneau" <ysionneau@kalrayinc.com>, linux-kernel@vger.kernel.org
Cc: "Jonathan Borne" <jborne@kalrayinc.com>,
 "Julian Vetter" <jvetter@kalrayinc.com>,
 "Clement Leger" <clement@clement-leger.fr>,
 "Guillaume Thouvenin" <thouveng@gmail.com>,
 "Julien Villette" <julien.villette@gmail.com>
Subject: Re: [RFC PATCH v3 28/37] kvx: Add misc common routines
Content-Type: text/plain

On Mon, Jul 22, 2024, at 09:41, ysionneau@kalrayinc.com wrote:

> +/*
> + * Copy data from IO memory space to "real" memory space.
> + */
> +void __memcpy_fromio(void *to, const volatile void __iomem *from, size_t count)
> +{
> +	while (count && !IS_ALIGNED((unsigned long)from, 8)) {
> +		*(u8 *)to = __raw_readb(from);
> +		from++;
> +		to++;
> +		count--;
> +	}
> +
> +	while (count >= 8) {
> +		*(u64 *)to = __raw_readq(from);
> +		from += 8;
> +		to += 8;
> +		count -= 8;
> +	}

I see this entire file is largely identical to the corresponding
one from arm64, loongarch and (mostly) csky. Can you instead
combine the existing ones into a copy in lib/ and use that?

This would be a good thing to send before the rest of your series.

      Arnd

