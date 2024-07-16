Return-Path: <linux-kernel+bounces-253865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C65932811
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 16:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C48C51C22CBB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8161419B58C;
	Tue, 16 Jul 2024 14:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="JDRBCUG/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BjD+pOLu"
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BECA19B3D1
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 14:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139313; cv=none; b=OQfPrvsSz3booegPQyinuDDBU1MPshcCngHteD0VD26UP8NejdnX1dHGG7m+FHic2DbiLKNyCrEOoVQbeuADO7nzX4uuLSXn/qqSwegm4I3aG8FVWMUjN2imwbk4l8irmsoy7ioG2lMVnOzmLdRSueIPggjMQFAloubYFGM+L5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139313; c=relaxed/simple;
	bh=ipsmsZYbAnzZ2nLzzwwb1hP9L5BCCXst27sn5MQXPoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lGGGt+imnPIwTDR01YCNSgTquUuYsP5MZds7adZBpnkxaJODqtIMJkkoneFo6GgKaOGUPYikkUjNiwWIO6oR34vzvSVyXIfVTJUpHUC8//fBVcr19UMb5vJuHO78K3+X+LxceBtW3YvMVo9eozrKvPLy4hfLDDRB9xXenI5spS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com; spf=pass smtp.mailfrom=flygoat.com; dkim=pass (2048-bit key) header.d=flygoat.com header.i=@flygoat.com header.b=JDRBCUG/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BjD+pOLu; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flygoat.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 36F001388CB4;
	Tue, 16 Jul 2024 10:15:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 16 Jul 2024 10:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1721139311;
	 x=1721225711; bh=80MXqoF8BPSn2t5IK17fPjbSuREk2f3XfiBkJXSaTeQ=; b=
	JDRBCUG/08sl74aGjVXKuI2/bqW41XFIdbIoiJWSOGK7cUaIOrbwIkD04B8fY6k/
	VeJEBuICTREXHFSzaa5EavaBFiHlP6OdYtd6OmDiK6f9xJQCq/xqBj/2PUdvw/Bn
	b9owId7L71qbOAkYdiNMKL7OP0V8sB4jAD41p3tJHp6qH88KpthYSBxL6F1QLX1y
	aAha+WU91lM9pSXTO1rjUtr4rW+7mvI0onvuzjBOozsUljHFRLjMojRUAe4L5m6v
	p1NRwBl9LEBl98sO9RQEkHbbKKDg13iCYX4vCvwHqhH5eDhjz4BZJCdKqm0aDOPL
	9v/8e96spVBaV8DPX++4VA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1721139311; x=
	1721225711; bh=80MXqoF8BPSn2t5IK17fPjbSuREk2f3XfiBkJXSaTeQ=; b=B
	jD+pOLuXbREnMvcpxwI1RKMnG7ViFyR9zCcPuxi6z2l9DDqAnpaNbxW7M/oHQ9Lq
	KypNRD41piK9u+8jriNC/br1xzD1jQceoI+wrivp6iFXmRGDJ4TXahTd2gLiM5oD
	glP0Wh3jdUv6VILmczVUFLS1JB0d1hySPBfRb5RqfCpH2nYYC1KCT4P2IoWq9GhM
	jxerG+ac33XNCAJRnD6b1/O27cYhMxOTccmmyLQZjvSHag6FMy/bzoHZ0V75qfiD
	d4orjeCMwEGUE6C3XFTJnnxEQa4D/T4gezDHCc8our3z/dAkFyWM+keIlcDrI/4/
	uTFK3Xtn7Tj6CFo4Xxs2A==
X-ME-Sender: <xms:boCWZlHKovwMLupW-mn-nWkuqFSW_1b9Z_CiAgh-mdraKTlL6dU2BQ>
    <xme:boCWZqUGt9ujCTf6tfETlOl0gbZHO8OM7wYQ2qZjLLLJXa_bUp0dYg1yi5sfbZh1J
    TRuaph1wLzIyvlEopA>
X-ME-Received: <xmr:boCWZnJqYirdcurxW8dev4tIYQEp0eixUiLK0tg9ByTZZCuAAAQpiB_naTQszyem3BU9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeggdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheplfhirgig
    uhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpedvkeeihfefveekueevteefleffkeegudeghfdtuddugefhueev
    geffgedukeejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:boCWZrEqhbnEtsCxOjX5atBndgPHqLHdv9k0DLY12C1NpfU981jqFg>
    <xmx:b4CWZrX3fbeUZNpn4uYcJT3HJit60abLhGMFNxp9nNm-_bF4DjKpwg>
    <xmx:b4CWZmOy8R4qXfEdqZjSso9d-K1EdDGOzMLcMiWlMhLcPZKHJVkpIQ>
    <xmx:b4CWZq13DxMf6hU7NBOOroL39D8YsacGwSTwNoLb02ByS6W2C6x6iA>
    <xmx:b4CWZiGEswwwlCSdH0y2qyBiolvGSTiYUwaNaUIoc_aOBhbllGrE8Soy>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jul 2024 10:15:08 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Tue, 16 Jul 2024 22:14:58 +0800
Subject: [PATCH v3 1/3] cpu/hotplug: Make HOTPLUG_PARALLEL independent of
 HOTPLUG_SMT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-loongarch-hotplug-v3-1-af59b3bb35c8@flygoat.com>
References: <20240716-loongarch-hotplug-v3-0-af59b3bb35c8@flygoat.com>
In-Reply-To: <20240716-loongarch-hotplug-v3-0-af59b3bb35c8@flygoat.com>
To: Thomas Gleixner <tglx@linutronix.de>, 
 Peter Zijlstra <peterz@infradead.org>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>
Cc: linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1139;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=ipsmsZYbAnzZ2nLzzwwb1hP9L5BCCXst27sn5MQXPoE=;
 b=owGbwMvMwCXmXMhTe71c8zDjabUkhrRpDenPv5gq+2X9T4xZtGGpdNW3iEuSD1UeHLlR9GSRV
 XJPYsiqjlIWBjEuBlkxRZYQAaW+DY0XF1x/kPUHZg4rE8gQBi5OAZiIRR7DP7srZrbfGDadSAnQ
 nF+5YtlVjqOnqr40XfedpZpjNNP9lAXDfzfVF9elJuc8FuY1+j/n3MfPex65RljunV04//zyg/O
 WfOQEAA==
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67

Provide stub function for SMT related parallel bring up functions
so that HOTPLUG_PARALLEL can work without HOTPLUG_SMT.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
v2: Use stub function (tglx)
v3: Improve commit message (tglx)
---
 kernel/cpu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 1209ddaec026..c89e0e91379a 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1808,6 +1808,7 @@ static int __init parallel_bringup_parse_param(char *arg)
 }
 early_param("cpuhp.parallel", parallel_bringup_parse_param);
 
+#ifdef CONFIG_HOTPLUG_SMT
 static inline bool cpuhp_smt_aware(void)
 {
 	return cpu_smt_max_threads > 1;
@@ -1817,6 +1818,16 @@ static inline const struct cpumask *cpuhp_get_primary_thread_mask(void)
 {
 	return cpu_primary_thread_mask;
 }
+#else
+static inline bool cpuhp_smt_aware(void)
+{
+	return false;
+}
+static inline const struct cpumask *cpuhp_get_primary_thread_mask(void)
+{
+	return cpu_none_mask;
+}
+#endif
 
 /*
  * On architectures which have enabled parallel bringup this invokes all BP

-- 
2.45.2


