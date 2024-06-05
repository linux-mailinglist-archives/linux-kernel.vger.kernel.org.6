Return-Path: <linux-kernel+bounces-203431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D2F8FDAF9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 01:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5551F2840F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE55617C7B6;
	Wed,  5 Jun 2024 23:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Tn6ON1w/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a+Hznjbh"
Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7315A175563
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 23:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717631543; cv=none; b=IyyvFGm62n5R6z711meqmhQ9sbIu7m0Yoy9fsQ01sX5FEkrzfIqXBkrwRElTcHJPjfoHQOOv60bIGbPLtPDOxQHbO9vgCQtHMg04tRH93S/RtzXGZNg+DSvz7ZmlqHAjLG2COqDBGq066HdOlVr8MvWb5ZnpzmK0lK6rWHR3QhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717631543; c=relaxed/simple;
	bh=3iuK0NrtiFinpip/uVNKKVi8nhUphaZFCh8RR+1TZOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T1okuMx57cX6l7Fb1XDBAH/LVi+n200ISQ9zc829We5WUHHWL4BlMf7X3jrxz3KsGjgl1jQwQEK9c1/aMJTqw7hWN3Ls9eBsLpQngZ5w6tWOCbk9Hlc6PaNO+mh33Eb02xAav0u8sTFywzLhB/xT9KSXz+cx6TVKOGEbaS5qrA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=Tn6ON1w/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a+Hznjbh; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id A0F5A1C0012D;
	Wed,  5 Jun 2024 19:52:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 05 Jun 2024 19:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1717631541; x=
	1717717941; bh=YhYZ47zvMT0a++wOZL0Bg5VQ35AEPyrocZUAtMVjskY=; b=T
	n6ON1w/AwhxRzf+DZ/QDpnuw3B0iIIohQ+0qh077GAnHcDCrVdhgK9PHv6QWVZ+r
	pCNDZI0KKG6EWKO1zG/ZaYoR6xsJZR2MRaHlx26kxs6CFzL6BaTBC59GD21DX5OB
	HqioJREy9QvtypYftr/HhmPeyTUb/X6TBt9MYRzvL3s7RFkCK6TMr92nvAtonRzk
	HxFdeeGYJ1KJW8pWLsdhVLE0Q0ijjmlABAQhh1q43zyxTsh61FBc3qc6kNHMARoo
	av6FkINNMNd77iaAFVMFczD8JptWJleMPNSLor/luMCrKu7GTZeCjakgtNLeKz0N
	dTzvZMEByirtfAJHVnvHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717631541; x=
	1717717941; bh=YhYZ47zvMT0a++wOZL0Bg5VQ35AEPyrocZUAtMVjskY=; b=a
	+HznjbhNUem4NAKdtGW9Z32SAXA2FvtxaWb4kBPp2FX5fItTpE0j9wdSfzbzCJ4z
	7LSxqvB9pjqq2DuPuJb2rhsetANCOwB5HIxknYJ84TDyqRhQAcSZtiQrismixaLI
	dCGGiT/1g9AKhHjKSYA5I58HaCtzRQGBcd5u171fTG9EopQL4XjWClZM38VgAnmz
	udKmz9GmsGOuGB6RhUEtGnrIkmeMqCpRU2VwA1zwDJ8yCULeC5GHkPIP1NIOfanC
	xCuxAU1h3I6jcKzqFfK5++GsLaGQ3xMe+c9SR98W5EbeAUe0CpY3vyMff9FVObB5
	Pl0KnFNXTyfc1FQ31mZjQ==
X-ME-Sender: <xms:NfpgZm9J_Byplo9Ngx7q_N6xKm05DeNYrikzYTrka5HA4HSAIM1Mvg>
    <xme:NfpgZmsarz2Te0JrY82K-Hes5BCr1XzxuW_N_edS8M1N6CmYtX2I0KZgRePEJXkSU
    YVXwNk9ImnvPHeGxA4>
X-ME-Received: <xmr:NfpgZsC5TrHtEpvPPcfNUECPtdRuUGoEO_7ZC0Q3wXswHPNAByDhOlJzxTKIjcFNWVoHs_RkK5eJZsI2WW-Ihon7LV8UJPt-wD-R24A8264NzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeljedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:NfpgZucCSztJWvLbmceybKhp_1ibNbXiXVy43yndREXSjZMYXDcO3A>
    <xmx:NfpgZrOKw96zUBnOfX2OE-K66XhnRl4pjiVRzEvIE-N5LqudOwrfIQ>
    <xmx:NfpgZol8yR_uTUZYP6bsG3u-bTQKbfPafE7FSUsIlh9BWezVdSHQjg>
    <xmx:NfpgZtutlp26jzqV15K18_T_OPiPLO5B1ME5pt5b0DBe-Fza8CDMuA>
    <xmx:NfpgZkYbBCBfJSt1An7i-D-8Or6MBEc_PUkYgnXbSLCxyBHR5ALrT7w7>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Jun 2024 19:52:20 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] firewire: core: arrangement header inclusion for tracepoints events
Date: Thu,  6 Jun 2024 08:51:54 +0900
Message-ID: <20240605235155.116468-11-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605235155.116468-1-o-takashi@sakamocchi.jp>
References: <20240605235155.116468-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is a bit inconvenient to put the relative path to local header from
tree-wide header.

This commit delegates the selection to include headers into users.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-trace.c                | 3 +++
 drivers/firewire/core-transaction.c          | 2 +-
 drivers/firewire/packet-header-definitions.h | 2 ++
 include/trace/events/firewire.h              | 2 +-
 4 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/firewire/core-trace.c b/drivers/firewire/core-trace.c
index 96cbd9d384dc..7cbf850f3719 100644
--- a/drivers/firewire/core-trace.c
+++ b/drivers/firewire/core-trace.c
@@ -1,5 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 // Copyright (c) 2024 Takashi Sakamoto
 
+#include <linux/types.h>
+#include "packet-header-definitions.h"
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/firewire.h>
diff --git a/drivers/firewire/core-transaction.c b/drivers/firewire/core-transaction.c
index 571fdff65c2b..6868ff17dc10 100644
--- a/drivers/firewire/core-transaction.c
+++ b/drivers/firewire/core-transaction.c
@@ -29,8 +29,8 @@
 #include <asm/byteorder.h>
 
 #include "core.h"
-#include <trace/events/firewire.h>
 #include "packet-header-definitions.h"
+#include <trace/events/firewire.h>
 
 #define HEADER_DESTINATION_IS_BROADCAST(header) \
 	((async_header_get_destination(header) & 0x3f) == 0x3f)
diff --git a/drivers/firewire/packet-header-definitions.h b/drivers/firewire/packet-header-definitions.h
index ab9d0fa790d4..87a5a31845c3 100644
--- a/drivers/firewire/packet-header-definitions.h
+++ b/drivers/firewire/packet-header-definitions.h
@@ -7,6 +7,8 @@
 #ifndef _FIREWIRE_PACKET_HEADER_DEFINITIONS_H
 #define _FIREWIRE_PACKET_HEADER_DEFINITIONS_H
 
+#include <linux/types.h>
+
 #define ASYNC_HEADER_QUADLET_COUNT		4
 
 #define ASYNC_HEADER_Q0_DESTINATION_SHIFT	16
diff --git a/include/trace/events/firewire.h b/include/trace/events/firewire.h
index d695a560673f..1f4ef0ed65bc 100644
--- a/include/trace/events/firewire.h
+++ b/include/trace/events/firewire.h
@@ -11,7 +11,7 @@
 
 #include <linux/firewire-constants.h>
 
-#include "../../../drivers/firewire/packet-header-definitions.h"
+// Some macros are defined in 'drivers/firewire/packet-header-definitions.h'.
 
 // The content of TP_printk field is preprocessed, then put to the module binary.
 #define ASYNC_HEADER_GET_DESTINATION(header)	\
-- 
2.43.0


