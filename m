Return-Path: <linux-kernel+bounces-311088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5A19684B9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0A5C1C22288
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 10:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E011714BD;
	Mon,  2 Sep 2024 10:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="mMXZT6T/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GP6v8hhI"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B0C13D529
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 10:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725273189; cv=none; b=QLltPTIF2hLcQHMcErzc4xGXTlP7HJCAMHR6nwTbJFeuUuJMmXZlwwNydii51Iw13hEZitg+9wxIF1Pj2EBbkErXJ6YzPi1AnZNN6SrYR26PMuN+oOpuBZyZL7dU06J/fKVbNff64stUCDLClF6kUITseAiQqgrMew9PUxSNcLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725273189; c=relaxed/simple;
	bh=yx0WfKYqBGZXFb/2NEIWJJ/2Fhebw25avFX4HBVE4aA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RilUEhkPsdu4CGbfHnvPHlwIxROB+5GTvUnYE9LcqijE4H9nauilywL7/KM3YB/QP9tImVvCnthFUeAR0G4wV+ZfTVH1hC/fGSQZ4kqG7fo/GlhGW6Q8TlT/qWAYajvV3gJBQt2FrE9qjiMRR4O+CP9WVwYkB+digsLxvr40q2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=mMXZT6T/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GP6v8hhI; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 01F5B114029A;
	Mon,  2 Sep 2024 06:33:07 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-04.internal (MEProxy); Mon, 02 Sep 2024 06:33:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1725273186;
	 x=1725359586; bh=OqT37OedLI3Z2c96Ch0l2l12KgQUgz60j93lq0NEoRo=; b=
	mMXZT6T/wA7nK5OLywlghbvXILyDjwFD8rKY+8hqcTT3pfAu88QVbu+gU2eAmfgb
	78/vDKleV7vKEZ1Ikz8Bxkv0zz4JEGHOza2AQMo2UK6xjD/tm5q50l2tEK47GV0a
	xl/yy/gUmX9fpoEL0MiKiDJNtOISxA2B1BMigUO1ulDFWIcHH0DirjEoBQOMZrBQ
	VGZSVC2EaQGTanLVsL67kHqFTRn9wTe4qiyig0OiLBBmAaLoy3wQhURyXMg+/0Ve
	lIbHY6o4IOOC1pMacCL/HjuF+Je6EBnY3pwAdayy7rzEJcEeZU+5fdhlURh3QKsu
	KXwku7X55sQtJ3xBCHnwWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725273186; x=
	1725359586; bh=OqT37OedLI3Z2c96Ch0l2l12KgQUgz60j93lq0NEoRo=; b=G
	P6v8hhIFD5MaOTxW+yluJunlND6+Te4LlaBd/wEiQOFKxhrn38r8jMHZwjU3DUNg
	KtMKXM2O6l/94WI1GKvHuClYnEbPaH0n2L2S2b8ANseVXuPBnhLoFw2jUZT0b0wj
	EElpc0zDkBO9QX3LF1kyls5WGOppsV4PHm3XR0qLoRF7L5aEj22j9sindXab/hJa
	bcAICmZj1Lcp4w0DMAp9OH2dJ0ecnS4S+KZSZIBFnyDRY1fYhNq7jZlP1AmDZn8U
	pNsn/gghGNxd2fEoA1yuuStkG0C84xBlMedbF8O4ebYNrBj2RK3jIsfArUDaAfPR
	5JIn+TAcv/00s/hWGPhKA==
X-ME-Sender: <xms:YpTVZju_Gts-J4YPlrltXfmkuV93XQhyIfFlD8ed07YAQ2UZBePcRw>
    <xme:YpTVZkeKjA6jQtAQo8khUXiPEiBjUdQ-3iky6yxPN2R56jaWlWFRMf-uV8SoyZjEu
    IfQ88bvuab6XE770Uo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehfedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepiedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhkphesihhnthgvlhdrtghomhdprh
    gtphhtthhopehjvghnshdrfihikhhlrghnuggvrheslhhinhgrrhhordhorhhgpdhrtghp
    thhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtoh
    epuhhlfhdrhhgrnhhsshhonheslhhinhgrrhhordhorhhgpdhrtghpthhtohepghhrvghg
    khhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugi
    dqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:YpTVZmwC53iX0FZ_OlZYBKIL2VE8NLIBJcwMDksZxCzcO3ib4M_Pww>
    <xmx:YpTVZiN8_C5XIkC0Ma0D0PgvbtG-h0p7Pd90ygqJ4_xaTR1NuCkXpw>
    <xmx:YpTVZj8RkN-Joko6Ug0LQlZMIbDHW9Z8JZOjMy57RpfP7lS8T-Wz7A>
    <xmx:YpTVZiWO0KjhdIq2c72nYX7LGDa9Xv3MG7CPvhfUurE33z_i6N9lwQ>
    <xmx:YpTVZumjb-xcuMvscrsYtdayVzrTHM1xbn5Hgn-9_20PXXRDfigKDFu3>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C19872220083; Mon,  2 Sep 2024 06:33:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 02 Sep 2024 10:32:39 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jens Wiklander" <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, "Ulf Hansson" <ulf.hansson@linaro.org>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "kernel test robot" <lkp@intel.com>
Message-Id: <cc808e76-4c2d-4a52-996c-2ff6d955e0a1@app.fastmail.com>
In-Reply-To: 
 <CAHUa44GgySmc=byL9_0vUuP2BKifpMHqMgvMHJpEukgFGRvVmg@mail.gmail.com>
References: <20240902080727.2665235-1-jens.wiklander@linaro.org>
 <b1787919-77d3-41da-9ebb-cecc65d2d310@app.fastmail.com>
 <CAHUa44GgySmc=byL9_0vUuP2BKifpMHqMgvMHJpEukgFGRvVmg@mail.gmail.com>
Subject: Re: [PATCH] rpmb: use IS_REACHABLE instead of IS_ENABLED
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Sep 2, 2024, at 09:54, Jens Wiklander wrote:
>
> Thanks for the suggestion.
>
> I tried adding the dependency above for MMC_BLOCK and OPTEE.
>
> Setting CONFIG_RPMB to "y" works as expected CONFIG_MMC_BLOCK and
> CONFIG_OPTEE can be configured as both "y" or "m".
>
> Setting CONFIG_RPMB to "m" will make CONFIG_MMC_BLOCK and CONFIG_OPTEE
> "m" too, even if they are set as "y" in the defconfig. So the module
> status seems to spread to the options with the dependency. For
> tristate options, it guarantees that the expected features are
> available even if it changes from built-in to a loadable module.

Correct.

> It will do nothing for bool options, but that's a hypothetical case
> for now.  Wouldn't spreading the built-in status to CONFIG_RPMB be
> better? So CONFIG_RPMB turns into "y" if an option configured as
> built-in depends on it. I don't know how to do that though, so that
> could be saved for when it's needed.

That would require using 'select' instead of 'depends on', but that has
other problems.

If a symbol that uses RPMB is 'bool', you need to do one of two things:

- if this is a driver that is always built-in, it would instead need
  'depends on RPMB!=m' or 'depends on RPMB=y || !RPMB', both have
  the same effect.

- If there is a bool symbol that turns on an optional feature in
  a modular driver, it would have to be something like this:

config MMC_USE_RPMB
     bool "Build MMC support for RPMB"
     depends on MMC && RPMB
     depends on RPMB=y || RPMB=MMC

> I'll send out patches for MMC_BLOCK and OPTEE options shortly if we're
> happy with the "depends on RPMB || !RPMB" approach.

Sounds good, thanks.

      Arnd

