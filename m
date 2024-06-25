Return-Path: <linux-kernel+bounces-228249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E066915D46
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 05:18:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3CD1F21ACA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 03:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E4849653;
	Tue, 25 Jun 2024 03:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="GATYDxwh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JnhrGf2W"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6178C3611A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 03:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719285495; cv=none; b=foPMqbg0i61u1taOP6jz2TtIS7kgtNEITasK9IdJ+prA7SXUuf4QSM6weelkhF5Yq6EalcoUNbbvPOGXpfoFOe/5iMmtiGXAizV1DqR934ZBCi4Jfy/Sftcof0+wHyfqkaAXPu1mEhoAmqrM1Akx3DQVMITC8X2JBQiEyNkfuLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719285495; c=relaxed/simple;
	bh=J61cJ8XUrbqstavwbyi35pOU6lObE3n99TW2csmszFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cdu6YXUuKPIgDNCq8in0HJPaLpAO4QUq+EKCJDsv+AeMGMu+awdfuGe8l2i2s30yjXe4rFCqfsuXF8oBh/ZHQkMawoxVQBr0SSqmFYCHzNQY9p16mXJXsTJIiXpaUcsJaktwnwurISl2WkSGw8NCAzW2RjPPglbKdSrXllIysho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=GATYDxwh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JnhrGf2W; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 65129138010C;
	Mon, 24 Jun 2024 23:18:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 24 Jun 2024 23:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1719285492; x=
	1719371892; bh=qyMxsdeLKsqCGO0IclrxiE5v5YNdkTFLsy/E7mJ/uUg=; b=G
	ATYDxwhaC5NqW6UoBKFb3sE2bJTcKr/XOjZMHEN3vunVgg16/MmzUmNR3+qpDsHU
	Ralpauz1yURTIYBUUzJaEvg47s5oCfy6G2u1FUT/e+APm69MpA8V2RsqI3pp2mnF
	fX8hBf2QrVckwEQBSd0pRfK+ueVfa9KnyUHOLfyCStwaCTk5M0clwBkTSzv44ZYv
	A7wXPQecCXA7mcz/yFnblj0sxyhcNOmWpS4n9mYd/BvOm/A7Bz8FqZPYr8OSwNO5
	an334WTdWW82/5/dVo9WT3DB0du4Xz3EvvELlAeGQmOCBE015gXVaU1CGClKqMs/
	xX8IA1mpEPnd55/RZDWng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1719285492; x=
	1719371892; bh=qyMxsdeLKsqCGO0IclrxiE5v5YNdkTFLsy/E7mJ/uUg=; b=J
	nhrGf2WJ/m0L+duIjxZyGDf8ToJ0y6Y94INd2My6VKG15cOi3x3/66TXSKVGUd/l
	6Ft2nI7mFI3UHfUoHjQQqorl5liK6caQNgwmbMcEFgvQLD5wJ4rXH1QXG8edJdqY
	eZoN8f7W6Y59G4zKk9AMLzJE55x6fL5wv+3mKDkVr8+AQ9ekdtcrXKp7LtQsm2cy
	CTMaYAxh9/1UQA5IKRfqqof3AjC90bCD0FCp6NlFl3soMb421PzdrBmaODFGHiZP
	X3LrcLXqzl/wQaFGKDOJuIltYhLO6NFRNeb7DxJfT2Uz/GTfZ2O+BZE3rAskYkWJ
	dmmzHX0cY/WSa5Jn6qvHA==
X-ME-Sender: <xms:9DZ6ZrJ--UUFpMQXZ4DooUjAX9VnvNHsDWXR9-_M0HVVEY1yI02Xxw>
    <xme:9DZ6ZvL5HGNaLQ_tyNcJmc28FdBavMjmDAalZAppaTxGFcTpki8N6L0ArEt602Vnv
    TgRcVqInhep-aaWsOs>
X-ME-Received: <xmr:9DZ6ZjswXnpnWeQpCGz4mZSF5kkY9iA_UPBqGugDuaq68MkFwc-X9sw00W3DGFRF3VerrKOKVK3ACf2S2Jig0gaPRSAlnglT74XDh3EaC6q48w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeegvddgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghk
    rghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedvjefgje
    euvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdffkedvtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhise
    hsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:9DZ6Zkb3tp57OMrWt7sTBqYvewaJr0aoEBejBVLkSHKoz2GmqXsdaQ>
    <xmx:9DZ6Zibx29qz6R2HmeFOxbMhTcxtxGNzF9B9NDVURBAyvX_B0QDb2A>
    <xmx:9DZ6ZoBtPI7ydY9aCO1X0VyiyGhfzCY3GD3zFNwmHHUv5S_D0jKhag>
    <xmx:9DZ6ZgYxuT63roNZOjTKQbEbPnf1eAY4vUOMrkKdzp2q6H91jHN4VA>
    <xmx:9DZ6Zhm9aQJlLhdjfHO8N-eoNwcTfXivAjSx5nqqKKg9BXag9VsQjbLM>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Jun 2024 23:18:11 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] firewire: ohci: add support for Linux kernel tracepoints
Date: Tue, 25 Jun 2024 12:18:05 +0900
Message-ID: <20240625031806.956650-2-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240625031806.956650-1-o-takashi@sakamocchi.jp>
References: <20240625031806.956650-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Linux Kernel Tracepoints framework is enough useful to trace the
interaction between 1394 OHCI hardware and its driver.

This commit adds firewire_ohci subsystem to use the framework. It is
defined as the different subsystem from the existing firewire subsystem.
The definition file for the existing subsystem is slightly changed so that
both subsystems are available in 1394 OHCI driver.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/ohci.c              |  3 +++
 include/trace/events/firewire.h      |  1 +
 include/trace/events/firewire_ohci.h | 16 ++++++++++++++++
 3 files changed, 20 insertions(+)
 create mode 100644 include/trace/events/firewire_ohci.h

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index bdb206157118..07adb4ddd444 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -45,6 +45,9 @@
 
 #include <trace/events/firewire.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/firewire_ohci.h>
+
 #define ohci_info(ohci, f, args...)	dev_info(ohci->card.device, f, ##args)
 #define ohci_notice(ohci, f, args...)	dev_notice(ohci->card.device, f, ##args)
 #define ohci_err(ohci, f, args...)	dev_err(ohci->card.device, f, ##args)
diff --git a/include/trace/events/firewire.h b/include/trace/events/firewire.h
index d9158a134beb..aa00c9f33551 100644
--- a/include/trace/events/firewire.h
+++ b/include/trace/events/firewire.h
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 // Copyright (c) 2024 Takashi Sakamoto
 
+#undef TRACE_SYSTEM
 #define TRACE_SYSTEM	firewire
 
 #if !defined(_FIREWIRE_TRACE_EVENT_H) || defined(TRACE_HEADER_MULTI_READ)
diff --git a/include/trace/events/firewire_ohci.h b/include/trace/events/firewire_ohci.h
new file mode 100644
index 000000000000..67fa3c1c8f6d
--- /dev/null
+++ b/include/trace/events/firewire_ohci.h
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright (c) 2024 Takashi Sakamoto
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM	firewire_ohci
+
+#if !defined(_FIREWIRE_OHCI_TRACE_EVENT_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _FIREWIRE_OHCI_TRACE_EVENT_H
+
+#include <linux/tracepoint.h>
+
+// Placeholder for future use.
+
+#endif // _FIREWIRE_OHCI_TRACE_EVENT_H
+
+#include <trace/define_trace.h>
-- 
2.43.0


