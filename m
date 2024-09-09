Return-Path: <linux-kernel+bounces-322067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3563972387
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3E081C233B4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE161891BD;
	Mon,  9 Sep 2024 20:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="qgXw2ZwI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QpMOZWAE"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F40A18C31
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 20:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725913247; cv=none; b=uhjNuhbvRF9Mzq4IJZB7L1xc6E6hxlV6wrHsv+z1HRddOEBJCyBRM8KDgf8byoeIitescXd+wctsqsufIOqOfeyHrE7yeN7TCX+7MpCmzEJlrMNZpc5TKFPOMDYCzjKZn/AGIg3NNedjqmLLH+tl9A1x44lIo/dJKJ6vf6g0wJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725913247; c=relaxed/simple;
	bh=WAIenOSnlCMAek+qiyg/oBTUu7KlnIeZQRNU1EM7gc8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=km4RPd3MP8vZn2zXF1YKYzMJ76Xe/qHlDtZ7pB9cN/iEQD63IJCdfY3rQ0Q9dtS7uWzh9G5ohSw4iuMLgY+3ok67g/cMBOTO4m7iR4q9M8E2TA6pA6t8OKUAzbDyCPut481u1FMa5Tg1VJ1JI71uQLASdHh2v6vKh2O0ypFibWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=qgXw2ZwI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QpMOZWAE; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 058B1138028D;
	Mon,  9 Sep 2024 16:20:44 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 09 Sep 2024 16:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1725913244;
	 x=1725999644; bh=InVy7eY6xQVGN0FmV0ibHdMoYjwpPNi9D2mYIpSNzmg=; b=
	qgXw2ZwIbSsY0ieiTLsNTK+OCmFPZrhZa7ZGstAHEaWSO8AYYf1XphNADruBt+Je
	5Gt7aO4GhODehsuo7x2lSZRGCu8gf2BBmoq2s5D9I/6brzkOuhFhPhmo70rMRI6z
	sS/TVEVRiTCCqnUNbwJAzO6jm+GGZgWxP2512DvaqQI3e9KUxzOaxH0fzjdaBIeN
	rhYQUB7rH5IWE2Bj7rj9bGGFVuUGIQFjYOicOVZpR+NWS6dSND1TNFLreL/z+NsX
	3+fLY2a1LkCWcGDmYJv6RsoFAuSyTcZyL83yWeO5L6B6eu+RATWYCeIgGYj+DuuB
	qjHLuC1mImLyv9JrnBI/tQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725913244; x=
	1725999644; bh=InVy7eY6xQVGN0FmV0ibHdMoYjwpPNi9D2mYIpSNzmg=; b=Q
	pMOZWAEm15z6CQ5KtI2WRH09U4ylO2tRMtFSczHnx4JUlHZP64u/jP7adiHOmiFV
	EYStA3S6XRKvQkeIcUICT4l31ghUUu71yY5he181xdBUbk4zWU1V2rvOykdFzf6s
	+oM8n98Wsa4BRklLu0oADTD5kEldpLF5zcIR6uVssXrRTAdM9A7304DmOOqkrzTk
	2iD4s33x89FUCMyAU8elSebuInMyG6u+5T9eOtP7d/QLvVwnwAI6T8fVxHzLl52R
	D1T0OeVkeeBaY9MORnbCfGzhFoB9K5/yjYsYDW9ZnqoVswYYh31TRnrWE1Q0RauO
	nKaitehQCQ4rmSQ3nAB7A==
X-ME-Sender: <xms:m1jfZvUn9GT-Bne_apuK7SHZhlHjM8_0NHwj4esNn9EKkesfrCdl2Q>
    <xme:m1jfZnk9retkPIAXGvOcxklns8-vDS85Cqt_wiFMaSu1iq5hnJS4utH3Fq1bOG309
    CBYXePBRz9YWwUH9ag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeijedgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusg
    druggvqeenucggtffrrghtthgvrhhnpefhtdfhvddtfeehudekteeggffghfejgeegteef
    gffgvedugeduveelvdekhfdvieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgtphhtthhopeek
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepuggrvhhiughgohifsehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehkuhhnihhtqdguvghvsehgohhoghhlvghgrhhouhhpshdrtghomhdprhgtph
    htthhopegrnhguvghrshdrrhhogigvlhhlsehlihhnrghrohdrohhrghdprhgtphhtthho
    pehnrghrvghshhdrkhgrmhgsohhjuheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprg
    hnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidrihhnthgvlhdrtghomhdprhgt
    phhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvg
    grugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:m1jfZrY66o7alM44528l96TViDTy9aPmebX5pHIsP5wPNsmztZ8G1g>
    <xmx:m1jfZqXvJYPvcwMMJMYjNXT_hjD92pIX8Cyy0D3aPbomaUvzUi_bHw>
    <xmx:m1jfZpkL1SoBVtw35YHMKwBf3UqUZ2fTtjlj2XWIT-yQqmYhO6JHJg>
    <xmx:m1jfZncCFIW9yt27-yvx4nKPp18HykraoADkvfBxUFRiv3BFfTp-Hw>
    <xmx:m1jfZvUXtV6NsItB0-zReqsxwCB6VCGEI7_Nv6pQjxQZ0CkqnrtGZkm0>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5B025222006F; Mon,  9 Sep 2024 16:20:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 09 Sep 2024 20:20:23 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Naresh Kamboju" <naresh.kamboju@linaro.org>, kunit-dev@googlegroups.com,
 "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
 "open list" <linux-kernel@vger.kernel.org>
Cc: "Anders Roxell" <anders.roxell@linaro.org>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
 "Bjorn Helgaas" <bhelgaas@google.com>, "David Gow" <davidgow@google.com>
Message-Id: <aaee4ddb-68a8-42ae-bb68-11ef991ada1c@app.fastmail.com>
In-Reply-To: 
 <CA+G9fYtNY+S0Ls2f3atJS_Y9Nh3V01EKO5jbPtVYbgch0TYsFA@mail.gmail.com>
References: 
 <CA+G9fYtNY+S0Ls2f3atJS_Y9Nh3V01EKO5jbPtVYbgch0TYsFA@mail.gmail.com>
Subject: Re: Kunit: kernel/resource.c: In function 'gfr_start':
 include/linux/mm.h:101:35: error: 'MAX_PHYSMEM_BITS' undeclared (first use in
 this function)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Sep 9, 2024, at 20:00, Naresh Kamboju wrote:
> The arm kunit builds failed on the Linux next-20240909 due to following
> build warnings / errors with gcc-13 and clang-19 with extra Kconfigs
>
>   CONFIG_OF_KUNIT_TEST=y
>   CONFIG_KASAN=y
>   CONFIG_KUNIT=y
>   CONFIG_KUNIT_ALL_TESTS=y
>
> First seen on next-20240909
>   Good: next-20240906
>   BAD:  next-20240909
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>

This patch below addresses the build regression, not sure if that
is what we want.

        Arnd

From 39601b1274354c710368f5cf40fe9e32540f7591 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 9 Sep 2024 13:10:21 +0000
Subject: [PATCH] resource, kunit: add sparsemem dependency

The testcase now selects CONFIG_GET_FREE_REGION, but that
is only available for sparsemem configurations:

WARNING: unmet direct dependencies detected for GET_FREE_REGION
  Depends on [n]: SPARSEMEM [=n]
  Selected by [m]:
  - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=y]
In file included from include/linux/ioport.h:15,
                 from kernel/resource.c:15:
kernel/resource.c: In function 'gfr_start':
include/linux/mm.h:101:35: error: 'MAX_PHYSMEM_BITS' undeclared (first use in this function)
  101 | # define PHYSMEM_END    ((1ULL << MAX_PHYSMEM_BITS) - 1)
kernel/resource.c:1874:57: note: in expansion of macro 'PHYSMEM_END'
 1874 |                 end = min_t(resource_size_t, base->end, PHYSMEM_END);
      |                                                         ^~~~~~~~~~~

It may be better to extend this to non-sparsemem, but a Kconfig
dependency is the easiest way to address the build failure at the
moment.

Fixes: e2941fe697c8 ("resource, kunit: add test case for region_intersects()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index b986050fc7e0..4c081a28fe96 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2632,6 +2632,7 @@ config HASH_KUNIT_TEST
 config RESOURCE_KUNIT_TEST
 	tristate "KUnit test for resource API" if !KUNIT_ALL_TESTS
 	depends on KUNIT
+	depends on SPARSEMEM
 	default KUNIT_ALL_TESTS
 	select GET_FREE_REGION
 	help

