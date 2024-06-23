Return-Path: <linux-kernel+bounces-226011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 646B191390B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 10:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E7361F21B6E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 08:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1901A286;
	Sun, 23 Jun 2024 08:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="lMx5pl+T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V1WPWUpg"
Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2DE7D3E8
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 08:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719131949; cv=none; b=D18EG6w2dpdoncjQAcSDJWwq5vKQIQ6SCq0bibUDnyjcrSip98r2dRnuIaBWEG6nrX1ZQwk7P30pCMjGOJ9sr8RgYKs1+GHG0E7WJVewCQ478fefCXxVJOUicWJ3g8GtGCLwnpnpPOFrrO4bJwft7Qe7ylAmr7dN3Ysk4ILCzuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719131949; c=relaxed/simple;
	bh=0PWnUkTFu1BbmLPvXRMNGVxrKjxM8GMqwjzK8/CkveA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C3aSG0WTIk6iz+faUwGNRV7SmgP38kul5r418WVhQbkSfSTDwTZOarAF7RyHGNVT1IR+6UVIkKqFeNKWjrk0fHhTc2DEQ/tM3nznrepN7snFOPZv1DfNqwFUkBoggqIp0JEgKYahp/RevYRaXRgsLhZaUpiqQz6rCJ4ICvOvGIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=lMx5pl+T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V1WPWUpg; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 48D67114012D;
	Sun, 23 Jun 2024 04:39:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 23 Jun 2024 04:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1719131945; x=1719218345; bh=11XHwVSKA4
	haBzqqLDZYSMi2ESbRYlY9OIyv6jSHsgw=; b=lMx5pl+TloIz6v0NsK4F+8wNm8
	nVsulufqK2SzAS9bk7Pc3tlL1mmmD2O3IUuz7z1UrvVw1Zn9bg8aOLqHZ2D4C+v8
	DE2wlFq2dGOKIzx6xxVeq0P2K4vu8f2m9er+TccJhe49ozvLteZc/qYKCa7x1+xS
	tDOCF9IAp3gCR1Hm7LZIiNY0a+/fMhuf9Qv/52QruHz6cN7fiBRGj+b0DLj/sq3o
	37pBaZfoh87DC6pYRqyezBQiC5mjroloTU+viETToOYJUUVB27G+IQo3wJ8pgcx9
	vD+nRzVjuIEEaH2Y/mzEZr3AmSlY97Z37gqvQqyZYdHB2+cEJ1YhtDjb2elw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1719131945; x=1719218345; bh=11XHwVSKA4haBzqqLDZYSMi2ESbR
	YlY9OIyv6jSHsgw=; b=V1WPWUpgMOUn8EMBLmtMqngXIiFakDYjoC4AukQnocUk
	Lm1vnM4sq862BbeCZji1HhxPUjfojPbpuDmCiYHeoCrtTTeVONBrr+GsriiOk/ll
	YNLb7gmuw2lZdg+k2NxHCM4iyYsyzHn/QyFddn8sX/30bF/bLbU3MEJ4/8L+DiYc
	CrBG8E4YoN9Enxp8ODE0rTyeTFM75p5cB4zEmIvLRjZFMk28ag7FfmeaQrR+zrfw
	tKjcXbM7nG6XFnKPVKqtk9ePTFbFw9jsP/vP0BUit1TidYlXmWYyEULnteFUTK/l
	vn0hWy9NmZEOCfrxmgJ0krEkSduy8GrNi7QJ5go4Gg==
X-ME-Sender: <xms:Kd93ZtMK_vjTzJ2lxJwTY3lt4IS2yYS7j0saHDTC0MgQ0265D3R5hw>
    <xme:Kd93Zv9JXn7dmxT8w3HaIWxzT0feq5DKib-rVxQDmd6UJUdDsLhqTqG4R4d-dRKnp
    0oM8dl-o3iAbbvshH0>
X-ME-Received: <xmr:Kd93ZsTzFNXTBzvF-u6bzu05y2zmm3q54FqacsFfSLkb4RmkLvwarHerEUJscKr2a3vdVXL9wrvwTivCV7l3nxfsu3G8CcCijpKoD_LhdfEf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefledgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeffvdeuleffve
    ekudfhteejudffgefhtedtgfeutdfgvdfgueefudehveehveekkeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrg
    hkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:Kd93ZptOgYKt1X9CeGWqwHPaeT5tEU1mTyP9XxEpoeO_iRwVSOfNhQ>
    <xmx:Kd93Zld-1dp-CSqhGjKJdLfezkTyTWzh8Ab2kYmdrR8SYYK8RAEOxQ>
    <xmx:Kd93Zl2Rg2cg56uauA4DAAMspqFvs6r91C85dPsLSIny-e88VJ7v8Q>
    <xmx:Kd93Zh8E-GFqxQb8IXUZgKfxDFyGdY71Y0v5FpxtvMiF_6QGPtCtDQ>
    <xmx:Kd93ZmpfW9dwhtayRW92VXI5b_kECOPyLtXWXuboW1pQ-RHjiy2_BE1V>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Jun 2024 04:39:04 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] firewire: core: undefine macros after use in tracepoints events
Date: Sun, 23 Jun 2024 17:39:00 +0900
Message-ID: <20240623083900.777897-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some macros are defined in tracepoints events. They should be back to
undefined state after use.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 include/trace/events/firewire.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/trace/events/firewire.h b/include/trace/events/firewire.h
index 5ccc0d91b220..132f9329224d 100644
--- a/include/trace/events/firewire.h
+++ b/include/trace/events/firewire.h
@@ -366,6 +366,14 @@ TRACE_EVENT(bus_reset_handle,
 	)
 );
 
+#undef PHY_PACKET_SELF_ID_GET_PHY_ID
+#undef PHY_PACKET_SELF_ID_GET_LINK_ACTIVE
+#undef PHY_PACKET_SELF_ID_GET_GAP_COUNT
+#undef PHY_PACKET_SELF_ID_GET_SCODE
+#undef PHY_PACKET_SELF_ID_GET_CONTENDER
+#undef PHY_PACKET_SELF_ID_GET_POWER_CLASS
+#undef PHY_PACKET_SELF_ID_GET_INITIATED_RESET
+
 #undef QUADLET_SIZE
 
 #endif // _FIREWIRE_TRACE_EVENT_H
-- 
2.43.0


