Return-Path: <linux-kernel+bounces-263297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 495F093D3F2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 15:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82C81F24603
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 13:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0183717BB08;
	Fri, 26 Jul 2024 13:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ghjrTmDd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EF47Fbnm"
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FA526AC1
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721999727; cv=none; b=lxxAoEffQSHnebQzcaW4gm82q+KauWpj1kGihS/Jow7mHGNPGGFRtcRkAwtRkROfG2saSlLNXqRhKWhrY+6aoOvug6CWclIRAhoHFoXIN5bSLXB1CCIpSkxZ57dcJbGc8uP1mI0+3KHtv6EeJ4VZAwexrXJVlFwxS9iz6R4WdVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721999727; c=relaxed/simple;
	bh=KBkSItQ5W9vXjTLB0wNp3OSgw/qYTIPXnusMwnKylWU=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=arsIJubQgOLMvj2sDEMRR7YQ/8C9dbctniu2zxyWCXryRh/wJ2KLoFsnlTi5htZ3A+ycmMlIId09uPtPI/+7IuvO+WQ70JbgPBeVGvwINWnh++x0nV1cNECex9dGtCgIwr8dmvW7ah/ucAvjt6ucpBoeyza9oGdWKEwrETIWzqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ghjrTmDd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EF47Fbnm; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 50449114011D;
	Fri, 26 Jul 2024 09:15:23 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Fri, 26 Jul 2024 09:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1721999723; x=1722086123; bh=vmerSIvbbd
	JwhSoqOIXC2+RNPWABTiKzG+1CMpROaZc=; b=ghjrTmDdPDJjPGtsBL3GmDFdm2
	ZSBHeCrIQTA8d5RP5V/BWeM0BoUG41sbDKwyY7tmNlEx+73N936TJ9LuA+S/bR3m
	zrdmQFpRDJVVGosH+az8iD6LVLyRPAzkzQPBflA2nbFs1cQ57CMMAhWDK+tPz9d3
	H6bs+8aRAkn++KkCLIdVHEbgf/BXflmJ9lh6a9AL4g12NAODKMIXyA+za0cZmHsx
	JHQhlvTtF8wOk8SKaB6oo3bPPPI+L+HEh91YxjwonpY+6iC9uBsrpoB9AQcT9/yv
	o8JkiMpYSZIwrdjgc5stCOFVf9qH8PazJzkATwTdV6OuDcq8qYL7M6abBf5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721999723; x=1722086123; bh=vmerSIvbbdJwhSoqOIXC2+RNPWAB
	TiKzG+1CMpROaZc=; b=EF47FbnmLU+CJUubr/cPrjx4zEz1IOVRC4/g1UvlMAmq
	ZMd2zO3DP4DrRxlX35r4KyLsNy9iKiwVBRAHXB978/jGdMGgUeMWqc/xL1b8rulH
	Xn1W1B3IzOyf1g7fotJLffVtgt7Z64QvMH/8mpgWrn57aWAe0D1fCgBjNP74RoX2
	fyuGgeek9KBwPq6lS7r7eYIXE2UWIk4NJQnvFBWVHPUe+WrKuHA5EmnfNqkWd9VA
	nhjeLdwTFQUTRErtjhX9VjyrWV2831Qafhfv1qtiWw7Svw01sPYENmnozNx4Z2de
	UPA4EkbhuqDkch2HS6moVtxi4i1vPMyDMsBjnjroCQ==
X-ME-Sender: <xms:aqGjZncmek0d6DlX5rmfDs2Hcc7wlLiF6sd-quL8SMEpCzGM5GXXMA>
    <xme:aqGjZtNmO6ulIS3ch5Fvozb5Oq717545zCUQKC3Nu8_K28teDcgief867jgrfaJCf
    ZjdyQyiNMosqCejiDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieehgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:a6GjZgiykAIw5yRnIFqQsaa_mngBGf75_Xm0KqCEWbw5sZnXN4--UA>
    <xmx:a6GjZo9p0mtK0c5J0yrdyvtgk5e7n1iW6mzNkfbTbUnNBC6xEyX3_A>
    <xmx:a6GjZjswhYF-bomv4LRH6KedP5n9FyT3TSFva15cojTBjlSW6H6yrw>
    <xmx:a6GjZnEnVfADJzgstmkdjBLpRwGGk-eQJ82n-kLFgbylj2GerKMNcQ>
    <xmx:a6GjZtICG5hmWnk3HExbAcf9xtu_I0y6rsYQsTfl-dm5M_gBXD6P---B>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D829FB6008D; Fri, 26 Jul 2024 09:15:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-582-g5a02f8850-fm-20240719.002-g5a02f885
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <60581044-df82-40ad-b94c-56468007a93e@app.fastmail.com>
In-Reply-To: <20240726123322.1165562-1-mpe@ellerman.id.au>
References: <20240726123322.1165562-1-mpe@ellerman.id.au>
Date: Fri, 26 Jul 2024 15:15:02 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Michael Ellerman" <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: "Geoff Levand" <geoff@infradead.org>, "Jeremy Kerr" <jk@ozlabs.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] MAINTAINERS: Mark powerpc Cell as orphaned
Content-Type: text/plain

On Fri, Jul 26, 2024, at 14:33, Michael Ellerman wrote:
> Arnd is no longer actively maintaining Cell, mark it as orphan.
>
> Also drop the dead developerworks link.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Acked-by: Arnd Bergmann <arnd@arndb.de>

The platform contains two separate bits, so we need to
decide what to do with each one of them in the long run:

CONFIG_PPC_IBM_CELL_BLADE is clearly dead, they were sold
from 2006 to 2012 and never that popular aside from a
handful of supercomputers that were all dismantled a
long time ago. Unless there is a user that wants to
keep maintaining these, we can probably remove all this
code soon, e.g. after the next LTS kernel.

CONFIG_SPU_FS is shared with the PS3 platform, which is
still used and maintained. The bit I don't know is how
common it is to actually still use spufs on the PS3.
Support for spu programs was removed in gcc-9.1 and
gdb-8.3, so none of the major distros even ship old
enough toolchains any more, but existing applications
and older toolchains should still work for people
that have them and want to run new kernels.

Geoff, are you using spufs on ps3, and if so, should
we move arch/powerpc/platforms/cell/spu* to the PS3
entry in the MAINTAINERS file? I don't think there
is any advantage in actually moving the files to
platforms/ps3 if we delete the cell blade support.

     Arnd

