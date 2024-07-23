Return-Path: <linux-kernel+bounces-259768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0892F939CE5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 10:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3990E1C21C2F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC1914C5A4;
	Tue, 23 Jul 2024 08:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="c+ZIz+PQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HTk7UIHC"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EA78F70
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 08:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721724266; cv=none; b=Lq6LanI+F0qYwPM3VrwsiZloGWTR+gBzZsNOk2gnMGXseryUdGRLmyF+/xxlhifR8ulhtcBvSvGD4BX3HGkc1GREbs3DQo9vAFniKXeyzCZHaSKphhrjTilUATUpuW1HI2SlL059Igv3/jpHQOudJKKA1BWK/Wn9fy3z7kV/JzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721724266; c=relaxed/simple;
	bh=sUA8E+xJ+MWW9j5Yo7JlAb/J6h3bkZJCwU1kpECLfkc=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=DRuqVTYG8mPpcw1otY7UWNiLk+oyav0FtAFKIXQmJbJKR3o7fpmzlw5tM3W5npI0EglYPlHX+0Dt7l9w0ziFpXFEemAgPtJZ2I2fn0PCjpM9ZMyNX9lKe2t3j2fiQU+oNDFFl85s0U3jkBYqGHIBTxkZauK7UZfniXHCff5JVDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=c+ZIz+PQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HTk7UIHC; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B72DC11403B3;
	Tue, 23 Jul 2024 04:44:22 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Tue, 23 Jul 2024 04:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1721724262; x=1721810662; bh=+RuUdqwp/y
	oXa+9uW80tO28QkhAsQarmEdteh+z+7Pc=; b=c+ZIz+PQ9n02XHUYAuhQg/kw0S
	sX8IZ+cZDynDDI3tsXe2PSll7Wc1Zd7XJo4x27EoDOc2s7AuXQOwewWT+jQjsfwV
	pBmKw6hT5AZk4cBSk9SPJ6AllfnFE1KOez8+42v62bqQdlJjWoR2ckrXsgJ/KgS9
	bBUmGqd4guvg4TL/uGloMBs/wEqJW1FYU/DTxnqIT4YIvBgBq8OumrMDFrcpThQo
	1ofEk5fVvI/uzii+3l3RDEvKEanHrfQqReJxJN84uHkcxaiK1bGKjd6wTu/qqb+2
	hHwlGcQuvFHIu6FQL967fG0fXm7XP6etF0GsJPhrgEuHvKblOkZ+HaAXa/8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721724262; x=1721810662; bh=+RuUdqwp/yoXa+9uW80tO28QkhAs
	QarmEdteh+z+7Pc=; b=HTk7UIHCrzzTbspJSZ+ha+/FS1ZxTZLvMyyKznkWQfuq
	+amMcOkhFugwie4NXld6eYozVs11yPp2Gg7HpTO91zTFjJskA+COlV806LpR2C/P
	oo/Ypdfqpg8oB5MHAuzuxfMEzrXcPRyUEumlzIikEk2zmZE7aU8+tO/rnA7IIKPm
	mGjTnaxWJOFq/CvrO5oZut68Y3MayZGelLjveM2x37dSgPIPuKx1ADmnaD+VOu9A
	39PBSx3kzFCG8Lj+O3S1LxbLXlBijhXu2hBnP0Kixo1+ItZg5qNsdVKxMR7YY7Bl
	pV4/nGkg2MYPsaCUUzh3y9RMAVbv2NIG/oMyxFyiwA==
X-ME-Sender: <xms:Zm2fZoP1DvdZIA6S4wIEy2lZduZuSeH-FJ_NG1rN0U_elNbdd4VC0g>
    <xme:Zm2fZu9WrNiiz057_QaSNnPnqqnAIOpKwOGswlxhQmULWr9ccGltzDgBaBkW490IZ
    8WbnqA1JSc1DUS_vaM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheelgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:Zm2fZvQVMHWi1NVLGXLM1r4x_P5hh7vSzqy5K6iWGs9RpcbW5709tw>
    <xmx:Zm2fZgv9BTN6Ea3hNRyUbFZatMErr3hAb7JTUcV5pts8-C6GKZWP7w>
    <xmx:Zm2fZgdkTCfD68QmbHFNWtk7tz_chK3SF5bJzBKIiWaHqvLwLw1EQg>
    <xmx:Zm2fZk19vyYva9lC3iWYQE22ay0FxpvebjLEYLXin8iPAzfyihwZSQ>
    <xmx:Zm2fZv9G1Cwf_byVssXZjS4G1_bdWbbD0x7tTNmp5rokAQIOUXclJk_u>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 432FEB6008D; Tue, 23 Jul 2024 04:44:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-582-g5a02f8850-fm-20240719.002-g5a02f885
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d9e8ac6a-23b7-4f9e-b096-2212b9899c4f@app.fastmail.com>
In-Reply-To: <20240722094226.21602-18-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
 <20240722094226.21602-18-ysionneau@kalrayinc.com>
Date: Tue, 23 Jul 2024 08:44:00 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yann Sionneau" <ysionneau@kalrayinc.com>, linux-kernel@vger.kernel.org
Cc: "Jonathan Borne" <jborne@kalrayinc.com>,
 "Julian Vetter" <jvetter@kalrayinc.com>,
 "Alex Michon" <amichon@kalrayinc.com>,
 "Clement Leger" <clement@clement-leger.fr>,
 "Guillaume Missonnier" <gmissonnier@kalrayinc.com>,
 "Guillaume Thouvenin" <thouveng@gmail.com>,
 "Jules Maselbas" <jmaselbas@zdiv.net>,
 "Julien Hascoet" <jhascoet@kalrayinc.com>,
 "Julien Villette" <julien.villette@gmail.com>,
 =?UTF-8?Q?Marc_Poulhi=C3=A8s?= <dkm@kataplop.net>,
 "Luc Michel" <luc@lmichel.fr>, "Marius Gligor" <mgligor@kalrayinc.com>
Subject: Re: [RFC PATCH v3 17/37] kvx: Add boot and setup routines
Content-Type: text/plain

On Mon, Jul 22, 2024, at 09:41, ysionneau@kalrayinc.com wrote:
> From: Yann Sionneau <ysionneau@kalrayinc.com>
>
> Add basic boot, setup and reset routines for kvx.
> ---
>  arch/kvx/include/asm/setup.h |  34 ++
>  arch/kvx/kernel/common.c     |  11 +
>  arch/kvx/kernel/head.S       | 580 +++++++++++++++++++++++++++++++++++
>  arch/kvx/kernel/prom.c       |  26 ++
>  arch/kvx/kernel/reset.c      |  37 +++
>  arch/kvx/kernel/setup.c      | 181 +++++++++++
>  arch/kvx/kernel/time.c       | 242 +++++++++++++++
>  7 files changed, 1111 insertions(+)
>  create mode 100644 arch/kvx/include/asm/setup.h
>  create mode 100644 arch/kvx/kernel/common.c
>  create mode 100644 arch/kvx/kernel/head.S
>  create mode 100644 arch/kvx/kernel/prom.c
>  create mode 100644 arch/kvx/kernel/reset.c
>  create mode 100644 arch/kvx/kernel/setup.c
>  create mode 100644 arch/kvx/kernel/time.c

The time.c file feels misplaced here, as it contains a
clocksource/clockevent driver that would normally be placed
in drivers/clocksource.

It's possible that we discussed this before and there was
a reason for keeping it in arch/kvm, but I don't see anything
that prevents it from being built outside of arch/kvx (like
custom instructions that are not defined in a header anywhere).

Can you split that out and submit it as a driver to the
clocksource maintainers, keeping only the time_init()
function in setup.c?

       Arnd

