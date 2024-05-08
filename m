Return-Path: <linux-kernel+bounces-173089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2618BFB57
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 12:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB4181F23182
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E928004D;
	Wed,  8 May 2024 10:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="GJT7++4c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UCf3mFh5"
Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C837EF1E
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 10:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715165639; cv=none; b=BncJVdlk59EPWFrhf0Ib6XjphsIU7A+g74ayCpck58bw/pOcMRKe9UX1BGHA84M4xviC5lVIzZG1UkTU+xnMXHaTMe0r2BouwZrGDT5oYSrWmRXpqwtDQOc/GVBUUxMb7IvfgKzazWjYyZY15Vlyi/vGMIEH30OZVf2o79yOPXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715165639; c=relaxed/simple;
	bh=QdV3IjbGgBO0WVKry0TdUEGi4jGJHuA7JWkmiKOGEuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qk2eATCVIhw6Y0LIqjF6m1YuOn7YzjGB/kH515Keu2IFaQYhFwc1nihLEO3nHKOW2Q0x2o56B7g1Ap58Hyx9rREeXnUCnDg4IXrJDWoyl+KOwLtpbcdZN8RREBMvEPijwwnGSsZtGMK3AxHwUj3IxzO3NPwkm7VWyij8HvNzj2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=GJT7++4c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UCf3mFh5; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8D80C114022C;
	Wed,  8 May 2024 06:53:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 08 May 2024 06:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1715165636; x=1715252036; bh=a0fVWCNAeC
	MRWZmQr1IdFElN2UvdC3kfZOmfXavatBA=; b=GJT7++4cguQLEh5f6Lv1LRxE5o
	052OK5bew6Z3Fc4esTYE3aRGI68+xobUHL1PbZxp+iQp0yJU7KciV14P9GArcNg3
	vy/ZD7CBNKBF6c7lKzeey0Ax7KqhXsbaxJZaMke4unThnHaFaYr1/yvemxeIKx3T
	2IQdEPNXThMMr5mT36LOi4NdSylz53K9WmmyqrJBs5eiCgLOs0xljQvhs9n4wjKM
	kpVaPfJr2NEGh5iWp69BTUMzZPWZCypLk9m3hg2u6xoSIjO6NiBm9gXnIOxDK+IC
	ap8JAenZMCOgJqLJlkiTayfqugK9JTlMuhyCJKCRieyeYTBrOFQc3bpnZ8rQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715165636; x=1715252036; bh=a0fVWCNAeCMRWZmQr1IdFElN2Uvd
	C3kfZOmfXavatBA=; b=UCf3mFh579BeYi7sIKB0gJv4qYNLyVoXAdTKhEepwcHF
	P5ct3dSNUeZlzRR0wval38raDWA2uH7so9jlvlzawBlta+tUcePL9HdxrdCA9Hyq
	MrppLBE1l/2h/ILlo9hVtdmb/ytD4/9RosH3BvROn+9XmV27LhYg/gD4IDJs7y6X
	3kq0jPJlz2qnyoQKgvVmYdwr6tl8QqGBuoO+r9nYEeVstii28LNfeIKxHrluJbTN
	rRSObxpLwNBP8e2JWrY5vCLniYXKJSCLULkyQfM5qE0cEh87f13m/i3kqMx4C8KD
	8AU/nK2BcH0F0RMbGAZkXvooghGpL9Fsc/w23UXlCA==
X-ME-Sender: <xms:xFk7ZsfjNba-SWcGXmXu1JN7u0UCcETnXovOKR46qW6CEh0KiY4pjA>
    <xme:xFk7ZuPhANVOxMWSHGm-6EYXb95E4BdLOsMb9ZEoJDUVMRUHtTWVzLGMAFPck7r_p
    GEXmiPN7-LRC7uzEsQ>
X-ME-Received: <xmr:xFk7Zth39orj5eFV7jj3_I9syqNhZX15q9VkmSptbAKGTqmdOStCj51GQ2OPYpNY_Vrt1PhKZs9pKtYa7LxqarmiREngQMiw1KTm4_kFumQYMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeftddgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeffvdeuleffve
    ekudfhteejudffgefhtedtgfeutdfgvdfgueefudehveehveekkeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrg
    hkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:xFk7Zh-DoKo9K5SNWrw42e9tJszulcgeSmnVNyiKlNOxvRrH9xV5fQ>
    <xmx:xFk7Zoty_dp35Yu6yL1me9BmCD0V2DrvOcRELfSdseZQsn-8G5wW6w>
    <xmx:xFk7ZoFD3ZWK770tabiv7cGALPtksUxKdQCUOggglK_68KvvZ_AAgQ>
    <xmx:xFk7ZnM1ZSVRokpB3XqYvOWTdY1gNQGLqYl2vUBP7MI9pljPE04azw>
    <xmx:xFk7Zh4mskRZt1wz95iQcPNAWj_qHcXpJ-HB6-Af_EJatV0jUkpo6Y8p>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 May 2024 06:53:55 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] firewire: obsolete usage of *-objs in Makefile for KUnit test
Date: Wed,  8 May 2024 19:53:51 +0900
Message-ID: <20240508105351.532693-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nowadays *-objs list is just for user space programs.

This commit obsolete the usage, and simplify Makefile for firewire KUnit
tests since the tests are not composite objects.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/Makefile | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/firewire/Makefile b/drivers/firewire/Makefile
index 013e1f2641bd..75c47d046925 100644
--- a/drivers/firewire/Makefile
+++ b/drivers/firewire/Makefile
@@ -16,8 +16,5 @@ obj-$(CONFIG_FIREWIRE_NET)  += firewire-net.o
 obj-$(CONFIG_FIREWIRE_NOSY) += nosy.o
 obj-$(CONFIG_PROVIDE_OHCI1394_DMA_INIT) += init_ohci1394_dma.o
 
-firewire-uapi-test-objs += uapi-test.o
-firewire-packet-serdes-test-objs += packet-serdes-test.o
-
-obj-$(CONFIG_FIREWIRE_KUNIT_UAPI_TEST) += firewire-uapi-test.o
-obj-$(CONFIG_FIREWIRE_KUNIT_PACKET_SERDES_TEST) += firewire-packet-serdes-test.o
+obj-$(CONFIG_FIREWIRE_KUNIT_UAPI_TEST) += uapi-test.o
+obj-$(CONFIG_FIREWIRE_KUNIT_PACKET_SERDES_TEST) += packet-serdes-test.o
-- 
2.43.0


