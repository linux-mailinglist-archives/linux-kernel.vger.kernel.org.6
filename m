Return-Path: <linux-kernel+bounces-320011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EEC970504
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 06:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D6FA28307F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 04:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D834D112;
	Sun,  8 Sep 2024 04:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="cQKJtZXJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BI6uAxry"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A783629D19;
	Sun,  8 Sep 2024 04:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725768359; cv=none; b=A8zQv331AeIgVTjwBN0FcbbNCuTFxSbajALfiB9foici+/6YC0dUCE9DPQS7aIZXuZ+QqTKfO33xoFtCfBZ1Sqi6afel/R8r3VyweA28UKGao96kZAYE1RJHhWtbqwb0UE3lpG/yHJ7FIf4bUh7dXoX4OevE77Y2HD7x26GsX+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725768359; c=relaxed/simple;
	bh=ZX3+HkeTf3IDOyCdWnmGLRu2Y1CXaszCrkxBkeSgqyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QpjZa7cUFxWeDw3ar6g/Rcvu7G9TI4AaB1P7gkmIZXRNRi4395XPBTuMmWe9+Pene05moaFMqZ488e0VFuK078M6EwhnUAvdhmYR9whZLZpBLrBDWBzFg4OQXvUcQfvoU0NA/2cLFZmLkfSj7+sBCrs9UDvLdT34GeMgKbR8Ae4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=cQKJtZXJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BI6uAxry; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id D3A8D13802A2;
	Sun,  8 Sep 2024 00:05:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Sun, 08 Sep 2024 00:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1725768356; x=
	1725854756; bh=g3rVD5AMlaA9gk9eYXsId57UmfOtU4hWVY6wnZR27GA=; b=c
	QKJtZXJVfBhH88DEnrt3ibxpI4iMC/52cmJ/tYqis6dXH9WrNWomXW/yaMKjZMZ4
	3xBj4dS8Szyd6OIiD4phP4T5H+holYErWY1EXyTc69cDvIUsld8ka/CzuvO8ehM3
	JFlBugPverI0lOazy+RoOlMaCTUKOijk9cJQo83GrMQFBVS51Y0YeHMZAvyMKPU6
	K6+Lk6Um3anOqiuZJBDEsCNWvwQwWGhi2ka13001ZrcbaMTaVhEARbS0UkmIyXgq
	JF2nwokCRJghCK0mZNBrrs11RIoEpGskrQQbYIpPJdjz0j4LySjD/l7zGx7JMJ+G
	OtwTLkHM11JDwGNVJ8y+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725768356; x=
	1725854756; bh=g3rVD5AMlaA9gk9eYXsId57UmfOtU4hWVY6wnZR27GA=; b=B
	I6uAxrygoNzOunL6IUC00vJAsU2GItBvlfqpOEkLB+EgbvlwUDDmKWd9byYaP9na
	XplNlhuT3hpfaTgknTrABiEqIS58e6qxKLZ8Kzxx6UavaVquOGG3ZA3L1tEYGFXi
	SdgtxmJbC3kijUxzrf8Ox7f5YY4pXekdqpMod7pxzluIy9lL0vHB26Xjqlysd/7E
	6yNm+VaVm5VZbD+/NcHT0N1GgJOSU+FqAYnpWn2tCmSxbqmRI8D3OtCOWSWBiEg1
	cv81Hu7V53MWlRR7nQBH4qazuqrjK67ycF1b5/o6863Dl86QOqeRjZhFJHXI2roW
	5ZAJIeDlm/PSAzO2N3rGg==
X-ME-Sender: <xms:pCLdZmXsoB3KIgzKOK9E45cycsjYdHkITIZOvgPJgbgtqK7TFuikrQ>
    <xme:pCLdZimB-fzz5EMdz5lDssOsMvmTWa4FvncuztpTJ6pSXZVDoWrbK4-HOV7OnqKQe
    drCbfLMBZgS68n1YYE>
X-ME-Received: <xmr:pCLdZqYsc3cPk55IIr0UPlfoBq4JSzLfHsPKBt__Tgb9kRmbc4oClZfO1WB0JdGpmpGh8_RguvUchsWZQ2y6woUAhRkldGTC6AtfvZX8h8aDeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeigedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghm
    ohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrg
    htthgvrhhnpedvjefgjeeuvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdff
    kedvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgtphhtthhopeef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigudefleegqdguvghvvg
    hlsehlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqshhouhhnugesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:pCLdZtWSErjzNIk48F6WO2J5fAtNMTSfDzxUnSxN57TOr9okgJH6zg>
    <xmx:pCLdZgmnc14IyNC8AJiVjfxrkTjHKkREh5tgoZ-9rAZSZZU5Z6_-Dg>
    <xmx:pCLdZifRgmqCb1F9s6yNAgu-GnOdCggqQaYnEmdGK78MthuOGnf0RQ>
    <xmx:pCLdZiGpLfbV7T2YKWA1vk19pYfT1hAOUWnL_IRluy7mWqsjUxrx_w>
    <xmx:pCLdZqiUD1QgWteANhR-et8TbkBLPTPw9ftHE8uEmoXoeeXkLQZVfQXZ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Sep 2024 00:05:55 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH 2/2] firewire: core: fulfill documentation of fw_iso_context_flush_completions()
Date: Sun,  8 Sep 2024 13:05:49 +0900
Message-ID: <20240908040549.75304-3-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240908040549.75304-1-o-takashi@sakamocchi.jp>
References: <20240908040549.75304-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fw_iso_context_flush_completions() is the counterpart of
fw_iso_context_schedule_work() to process isochronous context in current
process context.

This commit fulfills its documentation.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-iso.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
index a249974a0f87..f2394f3ed194 100644
--- a/drivers/firewire/core-iso.c
+++ b/drivers/firewire/core-iso.c
@@ -209,6 +209,17 @@ void fw_iso_context_queue_flush(struct fw_iso_context *ctx)
 }
 EXPORT_SYMBOL(fw_iso_context_queue_flush);
 
+/**
+ * fw_iso_context_flush_completions() - process isochronous context in current process context.
+ * @ctx: the isochronous context
+ *
+ * Process the isochronous context in the current process context. The registered callback function
+ * is called if some packets have been already transferred since the last time. If it is required
+ * to process the context asynchronously, fw_iso_context_schedule_flush_completions() is available
+ * instead.
+ *
+ * Context: Process context. May sleep due to disable_work_sync().
+ */
 int fw_iso_context_flush_completions(struct fw_iso_context *ctx)
 {
 	int err;
-- 
2.43.0


