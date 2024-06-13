Return-Path: <linux-kernel+bounces-212911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E386F906818
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 914961F21DDB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 09:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3814E140391;
	Thu, 13 Jun 2024 09:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="mFkTo+oa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZZpYo5X+"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42F614036E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 09:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718269432; cv=none; b=XsAxQPwjbGYiuhPUKY2KAvXCZuTjXUUwiBjSU75ACyHKq7t9iDKBIoQhDD9OVhNwSE+KdzoehbKpOz+wXydwrB+UJd6q4PKbvbWKhOv+7GI2SWw1c3gBf/p3+ggIoFePiL7vqecq9V2FoK8qvK4x0UmDBDdPlyIHCl6JycucYcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718269432; c=relaxed/simple;
	bh=yOUzonXXL0yYyl7r/id+llT6wbNCnJmkSrYPDSPH4Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kWo+07eCLw8wTLB0hMCCSNWBFxo/Gjpl8kl3X8jOI7ZYDfqfK1wBYOVTv6lTgLvHKi+eLSIEmwnjHZbTzmhrzgE0iY2pnKwFHjYtGqxlkcGexOjTV5If+YLFu2GWuhBYcZ23e2UTJdLpZjhPuPrZjoeANo9ELsO+LLZI7/yAxKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=mFkTo+oa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZZpYo5X+; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B0069114020C;
	Thu, 13 Jun 2024 05:03:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 13 Jun 2024 05:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1718269428; x=1718355828; bh=mopuKCNsFY
	MpSlhKsvvqFov2Ij5rcVHAmkj2/47ed3Y=; b=mFkTo+oa0dTbfbI27ZZCRMCMmY
	6Cs33Hse4lLVSiyQ7CaVAVpmWR1+kjsyk6JS6041sWtzOvIhovUVv4wyLupawdX+
	BaXO2z2KpfIH4V698ACQXXqOvOvPWGeGWlNQSvZZhsE3ENbGTJGcoLSgtBR4542T
	Hi7IcKJOBPMGPT0P2AFdhjn/P6sEy7Gxs9rbb8SuunbeMslEI6Sa4ajDzCpFI0t5
	1kz1e0JpWrdxfia0ggHuLBYS1hgowgF92vbmrQloeN/uHGXcOIrnMIBoWFdkibA6
	1gcg0LEpRuVlAALk/H1esX3RA5BiwCCzVCzplpcLg9A3WZG+Uy99bJdM2s8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718269428; x=1718355828; bh=mopuKCNsFYMpSlhKsvvqFov2Ij5r
	cVHAmkj2/47ed3Y=; b=ZZpYo5X+NGVOUgYFi1ZUiogvzOSFKNVgZc91s0qppJPM
	nzxECnMa9bo2cwnKRUH/0emS2Qmp2wsFwh8Q2u9+bSTygsBhFFpqbDPZyPKkD9WP
	jS5ZQntPOAKz72m7O+fXvr+4ZW1yw51HpQPHYACpiQVA6MUB5D/9vt7cm9NOdcaj
	N2a3GS2XoWVmScwnk8fVZahNBJINhD+O4LJ3oyuqRzQDquRtvPZKO+ULzLh5fVqj
	yOdtrGRXH544WYPSdb50mvBsmprp3uG3wqRoqeTHQK4Iktd4WPJ6PWs21j9987/m
	NHq+MGXLwcuNC9fyHHAbA7Qd2+wGFsfoV7k5cyexCA==
X-ME-Sender: <xms:9LVqZpyrN2AmdFEzGJ77NpV3YxG19aReixOypg5plVblhgLacWiXvQ>
    <xme:9LVqZpRVqL_UNmAsJvKqcOUl9-zCZegfuXPAKZXVlHxqdD75QoXmzPcxOU5BOMLjv
    JeW5CPd5hC2WdMAoxU>
X-ME-Received: <xmr:9LVqZjXAXwtGEu8Ra3uNt2-CWAxhr1vs7Zy_d7wAUJI8yMWyb5aXTif33BK2RzhXws800_lXx8KhulF7Cw2ErB0AfTNkDzGb212-e4QGTPiJaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedujedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeeggfehleehje
    eileehveefkefhtdeffedtfeeghfekffetudevjeegkeevhfdvueenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:9LVqZrjgM0qsGC829wSewW5q3hUMJT2mkn6IWVMrNftgHz6Q2wJh0A>
    <xmx:9LVqZrDC3ymUa1AHAs1V1l1ULKjwuHiT7aUsYjo7m6MwdSQw6xsPhA>
    <xmx:9LVqZkKhVniFXhxjfRMiuRzmU2amZMynvmYIr2FcyBgsqIcjXWoMeg>
    <xmx:9LVqZqCGOWmtRa0XiSrICpgMlt6WhRc-Oxg6cz_lxFKsSbzozZoBEg>
    <xmx:9LVqZuN1_o9iQcgy2JYhS7bMbqiHASSRybavaijwo6RGD6sGxsevrMxp>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 05:03:47 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] firewire: fix website URL in Kconfig
Date: Thu, 13 Jun 2024 18:03:43 +0900
Message-ID: <20240613090343.416198-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The wiki in kernel.org is no longer updated. This commit replaces the
website URL with the latest one.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firewire/Kconfig b/drivers/firewire/Kconfig
index 869598b20e3a..5268b3f0a25a 100644
--- a/drivers/firewire/Kconfig
+++ b/drivers/firewire/Kconfig
@@ -11,7 +11,7 @@ config FIREWIRE
 	  This is the new-generation IEEE 1394 (FireWire) driver stack
 	  a.k.a. Juju, a new implementation designed for robustness and
 	  simplicity.
-	  See http://ieee1394.wiki.kernel.org/index.php/Juju_Migration
+	  See http://ieee1394.docs.kernel.org/en/latest/migration.html
 	  for information about migration from the older Linux 1394 stack
 	  to the new driver stack.
 
-- 
2.43.0


