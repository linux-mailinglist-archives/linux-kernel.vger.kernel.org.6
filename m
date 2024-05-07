Return-Path: <linux-kernel+bounces-172172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 620288BEE68
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 22:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCE8D1F23A13
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 20:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A6558AB8;
	Tue,  7 May 2024 20:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="q/C3Dsnb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ArRExtQ5"
Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B696479CF;
	Tue,  7 May 2024 20:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715115203; cv=none; b=PjjB0BnRROyDq6AlQxcBPKM4OxePB4MtZKnugJSqubSewba67nEMGJxtYDZnyVdxGmz/No20b1AGnU3+D4zGFe5D9rxVknl/4ZKS4v+2mJWBEVqk+wse7ti8BIhUy4YiJyKOw/8DFsKkdpv9LfSsGWNR2vcgoDohj2Y1FLvuLaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715115203; c=relaxed/simple;
	bh=QT6rlQem4K0cBiuJlPrc72yqzW+2FdpcJ3xEIfA5RXs=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=j4Vs5TWQj0IUzD/cX3Y0oEyCuZRL7nRx2TOdrx+Y1zaRncu14iV+M22fSydE4pPQ6BFTHuTH22bZxvSCOCtiHC/gOGDi0o2dAh1k3HJMbKW+kh1tJjuxIkfla7F+pwsuT9JeAlIwAMv+IheGQyNgULlTOjth/z+x80LFczbAQKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=q/C3Dsnb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ArRExtQ5; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 4323F1C000B9;
	Tue,  7 May 2024 16:53:20 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 07 May 2024 16:53:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1715115199; x=1715201599; bh=UafRVQ7xw7
	cygAYylCOVgFjlvkwiscSglHTE53mJ0OY=; b=q/C3Dsnbm7E/JV3fCuw1PDrQcw
	HA/oh6aI9toEOwAS5YLndn32HSnDVixRsdx2/U6oMWwz9+S7t/rodklKRuD+Je5u
	+9YP+TAtK3xoLzlbZ6hVclJ8oip2y40E3Nafl512UNTy7OYce65GvlypbFqz4nr8
	XfBWjwWO6TnljXAyzjt3OHmElJ4IcisYhqORrUTpkkk2imf56fOQCy1QVfeYvV4Y
	PrevypsEV7t5vVN4gC6NyezZ/nLu3Hsq8okP1D9PDy5eyHnnrFmFsK88hei/Hm5U
	4yaB90LszHpjQ8nfF9DrbbF88lGNVmSm5WkLvLNarHrW7nsWn+wagHgQaOLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715115199; x=1715201599; bh=UafRVQ7xw7cygAYylCOVgFjlvkwi
	scSglHTE53mJ0OY=; b=ArRExtQ5IUH0Na9nEjjm9KMcHmunuDg1wJgDqTHBT58f
	uTSftQvEmscGM6EHwwW6Uf3lWg5xKKkBoa4YCC5RyHGqTOT/imBDOxSUnmyDZxdV
	6Q7mM8bR9mx359oHLnYcool851ghHeKHZ3MjU1A+mMmFyAI0Q3VEyCr+Yghliy01
	/IsJ4yr9/8IlxIAVndlqYz87+P+YaTMHs/qnRJ0+fS5eDjoeK6+ijgCf8YWyHk/X
	Tn5t+FDQ+xoRXmhcmv8lz8G4V7IpTlPfYRQOKBFW2vVBekwsGLSZ9HElWCbSAXvC
	FQeOJbD+Qvj3C+v7uov9nKkmMsKbMlKsGDy1MDw9DA==
X-ME-Sender: <xms:v5Q6ZvQuIHHZeRVLOyhAbccudcN7GL-BZkPcJjPOSr2fw55HHJUV7A>
    <xme:v5Q6ZgxSyT2jYsEuKOLXp4xq1fbpt30omce9fnwBB_9ZPYIRQ-23ZnlyeAgPh5pCk
    -nb_y9W9BOpH3G9m94>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvkedgudehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeu
    feehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:v5Q6Zk0P3zDwcfFRIGzr4MV8HmP5w9_JSLCS5Zl5OkSLY9R-ye-eMg>
    <xmx:v5Q6ZvAdmFzCR3FzLIpvSDHfmg9aVNGNDK_Z5IgGeizvY1hG8MghAQ>
    <xmx:v5Q6ZogjLg2qcOW_sBXLWBxHrRyPQf1vs9ewkg3BJSFGhBH6c3daVQ>
    <xmx:v5Q6Zjrt10LNhArBp5fx_ioekBocovlhyS6QiiGH9TWOwthYHxk73Q>
    <xmx:v5Q6ZtanBF80sYCSsSOxxByV_twdAh5IAUoLjpH_Ajti8xkUVV9yrifj>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 63A4CB6008D; Tue,  7 May 2024 16:53:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-443-g0dc955c2a-fm-20240507.001-g0dc955c2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e93acd4c-20f7-4b46-bb9c-84fac451c894@app.fastmail.com>
In-Reply-To: <820ddc2ec70780ae1ecd3af864dc8bd6.sboyd@kernel.org>
References: 
 <CA+G9fYuZd_ur56H8fwDSvUywopvn_b7ogprGkjEatQ7EPTLwYQ@mail.gmail.com>
 <11be44d3-0f32-49c6-b4ae-ba97a9f97763@app.fastmail.com>
 <820ddc2ec70780ae1ecd3af864dc8bd6.sboyd@kernel.org>
Date: Tue, 07 May 2024 22:52:59 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Stephen Boyd" <sboyd@kernel.org>,
 "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
 "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 linux-clk <linux-clk@vger.kernel.org>, lkft-triage@lists.linaro.org,
 "open list" <linux-kernel@vger.kernel.org>
Cc: "Russell King" <linux@armlinux.org.uk>,
 "Anders Roxell" <anders.roxell@linaro.org>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Michael Turquette" <mturquette@baylibre.com>,
 "Marek Szyprowski" <m.szyprowski@samsung.com>
Subject: Re: clkdev: report over-sized strings when creating clkdev entries
Content-Type: text/plain

On Tue, May 7, 2024, at 22:26, Stephen Boyd wrote:
> Quoting Arnd Bergmann (2024-05-07 00:44:15)
>> On Tue, May 7, 2024, at 09:20, Naresh Kamboju wrote:
>> > The WinLink E850-96 board boot failed with Linux next-20240506 but there
>> > is no kernel crash log on the serial [1].
>> >
>> > Anders bisection results pointing to this commit,
>> > # first bad commit:
>> >   [4d11c62ca8d77cb1f79054844b598e0f4e92dabe]
>> >   clkdev: report over-sized strings when creating clkdev entrie
>> >
>> > After reverting the above patch the boot test passed [2].
>> >
>> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>> >
>
> There are two fixes on the list: [1] and [2]. Perhaps one of those
> resolves this?
>
> [1] https://lore.kernel.org/r/20240507065317.3214186-1-m.szyprowski@samsung.com
> [2] https://lore.kernel.org/r/20240507064434.3213933-1-m.szyprowski@samsung.com

My guess is that either one avoids the crash, but we actually
want both of them since the problem is a combination of the two
issues.

I think we also need this one on top, to have a va_end() for
each return() statement:

--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -193,6 +193,7 @@ vclkdev_alloc(struct clk_hw *hw, const char *con_id, const char *dev_fmt,
                cla->cl.dev_id = cla->dev_id;
        }
 
+       va_end(ap_copy);
        return &cla->cl;
 
 fail:


      Arnd

