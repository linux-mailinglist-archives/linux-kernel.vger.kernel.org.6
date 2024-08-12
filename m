Return-Path: <linux-kernel+bounces-283924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5434594FA73
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 01:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09FDE1F21FEF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 23:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98C219ADAD;
	Mon, 12 Aug 2024 23:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="wGsIIMOH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YlPHK8RL"
Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1659319A2A8
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 23:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723506739; cv=none; b=GlOfu49CFgrutnAFWtYkwDF51DUXoBKzNv39432UiKsOTUtjX4DTPRComeBeXvOmnp34KcJAFbKrI13EYiq8BMmuJRos0srACZ6dgyWQnms3jhWearuCPjfXtNzQshAVWB13s3EIOqrAhwdQNxetUe7mCeAruSQiwRS9hEl/Wzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723506739; c=relaxed/simple;
	bh=SpFGBLIbLQB/bD48Q4t0kgiqOP6/LXv8rODlIjG1qM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIBbx1s1TdOxDV8LmfdeJP6tEgcaNSmz5hh0CnSWtb4ctX/2ucZGrZ/BYAn/WSI4NPdQ8rOJK6SDuoUffXBjpa+RNzUY9sCs+Ftc2h5l7FDQo9QEeb8XfiwJQw4KdonX6UeHDfmevgTY3wWtYEwhsQAE8le3c50YAwOynsb636g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=wGsIIMOH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YlPHK8RL; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5FB721151AD8;
	Mon, 12 Aug 2024 19:52:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 12 Aug 2024 19:52:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1723506737; x=
	1723593137; bh=Kh9i0JPlzid5BWuq583j3AOPTE1mAiuU5Or9KJgOb3o=; b=w
	GsIIMOHF5FK5H2GlsoUKvFaD0nhKCODOrnGNWNx4flm3lkyBrvZwGXRwiLmQH63h
	bynUJQqGOP6edJx8tO6MmNwe7sM76HufChB/tlZp9kiuVTn4c689TxwfMXhHjTW4
	93liREkkbdrzvGFleZi4E0FE7ymHH2TFrcNXHXvKkL50W/u7XBiT9TVugBp+/N8W
	ETOvJSGB8Ws0jWyJsvKkaTVUCe2/XKM+PwDJ3xZwunRKRXGQaSv9owypONWVbtCj
	nnU5FoTKz46j2D7faTb70W4JAaGda94QmtCWtDqPf+evxMOwrt+JEH6YnQXIx1dt
	dj905UxNwsilESG2kgPJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1723506737; x=
	1723593137; bh=Kh9i0JPlzid5BWuq583j3AOPTE1mAiuU5Or9KJgOb3o=; b=Y
	lPHK8RLjsxRbrJp5YRv6Opse/RaZM5VaJuNuUfKd6jZPOgABdqq6CUjy674Zo3rm
	irfE4l51TX9LI4o/L6lily8A+9owyIruAEWmqpOy4IUb7wAvjKrAz0Ryb2lg/AAw
	vCO7GsPio5caJaxb2JUuLnCecG9L0hNR7rhiuOOZa10FgrA5exoigizAdR0hkAY+
	Ilvhqxcp39xzEuQSO1FbeYNSU/158qqtq2TMqnzbfOFA5QONSpYI7FAhZtZpaAZe
	B/P0Pf5oe/N8m2eWATuASgAhMFoLGsRioNVa7Pnb+RUhK784t6zfWJzW21KTTr1d
	LoWiy7cWMuQjy9JAcSLZQ==
X-ME-Sender: <xms:MaC6ZuRwX8JkF5zn0a2A_3HrRZI_80LxSYnZVRbDQt6TbsSxKrhJ-Q>
    <xme:MaC6ZjwFNpTMJV7V5CCLT8jmHguR1EunNOiMqw_Zz_ooO9XvhleU1_ovWFQjHnphU
    ZKxuKmvCbzlVV3Gew8>
X-ME-Received: <xmr:MaC6Zr16ZHaXKdmMvltKGTAZm8Qcw5nMg_WpyC1pshB3NckmRg6H9RMmNAookbV6sAu2oP26Qb3ZcuKYM6X8tUijiffVUpH_1jjNen9ELvOQxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtuddgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghm
    ohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrg
    htthgvrhhnpedvjefgjeeuvdfguddukeelveetgfdtvefhtdfffeeigfevueetffeivdff
    kedvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggprhgtphhtthhopedv
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigudefleegqdguvghvvg
    hlsehlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:MaC6ZqB8LQCp0vjSDv3jXV_Go9Jw4wBrwzlpgHxqs3Dv-blLv4n_2A>
    <xmx:MaC6ZniUGdGLEw4GbGMG7NhC5J0LzURmIiYW6zd-7uGg6l5P5jzLAA>
    <xmx:MaC6ZmqjznKiOde1QmuvEWrAcOOcZddUbA4lH-YpKxFgToKfRXsFnA>
    <xmx:MaC6ZqhhIo0oxQQfEwmONjIZ9muHqgfenUNV5JIHATApPTqlS2NAPQ>
    <xmx:MaC6Zqu4pZFo9IOEAuKxqYETjJe4cvPWQtoRYz8VEMEfJrvfbf9ykAr1>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Aug 2024 19:52:16 -0400 (EDT)
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] firewire: core: add helper function to detect data of iso resource structure
Date: Tue, 13 Aug 2024 08:52:08 +0900
Message-ID: <20240812235210.28458-4-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240812235210.28458-1-o-takashi@sakamocchi.jp>
References: <20240812235210.28458-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It depends on the function assigned to release member to identify
resource structure.

This commit adds a helper function to identify iso_resource structure.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/core-cdev.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
index e72f91cc3711..6fe2a2ea9869 100644
--- a/drivers/firewire/core-cdev.c
+++ b/drivers/firewire/core-cdev.c
@@ -161,6 +161,11 @@ static struct iso_resource *to_iso_resource(struct client_resource *resource)
 
 static void release_iso_resource(struct client *, struct client_resource *);
 
+static int is_iso_resource(const struct client_resource *resource)
+{
+	return resource->release == release_iso_resource;
+}
+
 static void schedule_iso_resource(struct iso_resource *r, unsigned long delay)
 {
 	client_get(r->client);
@@ -170,7 +175,7 @@ static void schedule_iso_resource(struct iso_resource *r, unsigned long delay)
 
 static void schedule_if_iso_resource(struct client_resource *resource)
 {
-	if (resource->release == release_iso_resource)
+	if (is_iso_resource(resource))
 		schedule_iso_resource(to_iso_resource(resource), 0);
 }
 
-- 
2.43.0


