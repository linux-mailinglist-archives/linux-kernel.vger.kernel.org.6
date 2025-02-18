Return-Path: <linux-kernel+bounces-519846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87515A3A2D1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 348E77A583B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC78426E143;
	Tue, 18 Feb 2025 16:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="FUVqeMJB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tvubKYaC"
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF9D26B0A1
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739895730; cv=none; b=E89JFRtWxRxBXNSMlp/Hf+KhxRlIG7qKnQVncS9QmEzUAq+MqSJ0MUoGsXCeDFAqD5o75OT1e/INPiyGRdW35VGDwRHigmZiIH+wdlBwVC5+9oUUZdSez0IL68zal5z3cgUB91jxdZNm3HCfRBoK92W7zwgCSeSV5DrwfEPBF1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739895730; c=relaxed/simple;
	bh=biUlUlxZMJkGydyuLzSEg1Jwb0wB5GqYN+/bv8sFWBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KgRJc8LcJai1zCNTmEeUcL0gYeUlT5I2OqrgDSSuMw+mlDPDFOG+OUamccVn3/enriJhRtfO70rA31/5pwZ//9zRoquQZLCQJ6/VChrOF8hBfUxZow4EZMFnNejxsA9CeTahpuJubBXIxJ2TReJkgcatpqCqh6S/TH8sUOGmaGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=FUVqeMJB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tvubKYaC; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.stl.internal (Postfix) with ESMTP id D3DD7114017D;
	Tue, 18 Feb 2025 11:22:06 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-13.internal (MEProxy); Tue, 18 Feb 2025 11:22:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1739895726; x=1739982126; bh=omBAmhhC137AZmIbep4GVQID5KGL5caL
	+CaVGpd9kgI=; b=FUVqeMJB8ChlxsR+VUv9GAmH6Q/cL3bz3g0BU6L7uMYtZO9s
	ok/goazpzqbGhrvekllmd2iqOjzYve3O7zyHb6//j1anQ1Zp+/37q8aPHhhFnqBn
	1wOkN6lenbziWm2Z6A9PvR9JZvy3j7K2sJ0QnY9dsI3WE5AO8zhd4br6qsmlYqXO
	M8HKP92iDbpNpt7hirt/MxclF2qTRevBiXgY3Pj4wsgqtOpOj7KWjdwtCSNRpcsx
	T1M6MuIxIwCK7MgAWWpEbItIUZa2Ku7oZr+vBKVDn5QTpSiGVvphCqilhSP8IdBy
	1T7NeBCJViPzmp7cIena1tj519wv/tCsmdFITA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739895726; x=
	1739982126; bh=omBAmhhC137AZmIbep4GVQID5KGL5caL+CaVGpd9kgI=; b=t
	vubKYaCZvno9YYA7RZg/eW6r9GDBKJAc0dPYQqIEcgTvMkGT/XaWhwDYE5KzRc5Z
	eoMS4Fk0crFD4RXvokGxSlfq/e1QrCpijbEkDEeWV5Y8UMDbjc/6JPyMPWW9LNY8
	R0bP91c01yXaJ2Buml0GjPT8UY+tznvu5OEFAg6PA73lpNCmgN8+atKm7m3Yp62s
	WA1+OAnU5MjK95CU9DPTMa6X5lxsF803rVqccax5lZXLwyC3EKVGuy+3Jibl29iQ
	AjvQU/2XGEAujjXQoopVtrEblKrhXxcUNGjwsBwD6riom9CtwWrLerCbjSLjt7iy
	6TfZ4ilxU/taVHaqCOfeQ==
X-ME-Sender: <xms:rrO0Z0uj6d7YquOQbnm2CtIKuZSPy2j8kHVq0anzX0kAx71R4r8YMQ>
    <xme:rrO0ZxcFSq0Boj1GpMVnF5kTbqBbJvDyhERtyBmVBcOBoIe-nhH7weSuCUtDUPdj0
    4hvKxnC5gAkz7b2Kj4>
X-ME-Received: <xmr:rrO0Z_wsq-MjfWdsQe8PpJkr7jkcJanLoNvwGTmxNFGWaEyn3YBnqGlmIXNJOjBgM3jLq4qxK7gfIhLPeU_XjfxMUwN20_ivBHGZLDJM8MXoMcxHjQYQwoq-vDY5HzU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiudejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepufhvvghnucfrvghtvghruceoshhvvghnsehsvhgvnhhpvghtvghrrd
    guvghvqeenucggtffrrghtthgvrhhnpeegieehffethffhffefhfehkeevleevieetfeeg
    keehhfeifffgheehieejheeihfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvhdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghlhihsshgrsehroh
    hsvghniiifvghighdrihhopdhrtghpthhtohepshhvvghnsehsvhgvnhhpvghtvghrrdgu
    vghvpdhrtghpthhtoheprghsrghhiheslhhishhtshdrlhhinhhugidruggvvhdprhgtph
    htthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggr
    ugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehlihhnrgesrghsrghhihhlihhnrgdrnhgvth
X-ME-Proxy: <xmx:rrO0Z3P7f_9ftdfTbDKZ07pUJhU2BRRsyEvywxiR-UlOefDZjdzOjw>
    <xmx:rrO0Z08mr4m-n2fXt7xKGj_Q-x3ye6x9u61waJ0p7Ff8UtOPf06jjw>
    <xmx:rrO0Z_XluE_J3LhlePFn3hpX0DslxVD87qOP1pa0sNUwXXIDkbvGuQ>
    <xmx:rrO0Z9eYzfYKuIqaGXhlldOyXwKc1E9Xw2apNneoqfKtiCI4LeRQQQ>
    <xmx:rrO0Z0xxAjaL_sI9A8NG5J3J3LMxKNzzHQxd0xqfwCdFydFGmWTWyA-b>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 11:22:04 -0500 (EST)
From: Sven Peter <sven@svenpeter.dev>
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: Sven Peter <sven@svenpeter.dev>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Asahi Lina <lina@asahilina.net>
Subject: Re: [PATCH] soc: apple: rtkit: Check & log more failures
Date: Tue, 18 Feb 2025 17:21:55 +0100
Message-Id: <173989559064.48099.256452329848917938.b4-ty@svenpeter.dev>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250211-rtkit-more-logging-v1-1-93334e9c1c77@rosenzweig.io>
References: <20250211-rtkit-more-logging-v1-1-93334e9c1c77@rosenzweig.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 11 Feb 2025 12:59:44 -0500, Alyssa Rosenzweig wrote:
> Check and log the following failures:
> 
> * regular messages
> * management messages
> * failed buffer requests
> 
> This helps debugging.
> 
> [...]

Applied, thanks!

[1/1] soc: apple: rtkit: Check & log more failures
      commit: ca0272d8638a4c50ecc2c63719f81e022d3450f1

Best regards,
-- 
Sven Peter <sven@svenpeter.dev>

