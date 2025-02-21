Return-Path: <linux-kernel+bounces-526364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2E1A3FDC4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 18:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7550E701BE8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E907250C04;
	Fri, 21 Feb 2025 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b="aFrg1IZC"
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17762250BE5
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 17:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740159879; cv=none; b=W47PXPcrCJBh1KSyVoNZ1X410plGysV3HqqG5amHB5MOhnKbmfYi/3weTnAKT4V2Fo6Vm9imYPsqPgFVTukFvMjxQfFHW1TVDe+4li5IaFSwy6s+mXoqIF9e+wciu+OJrtpGr7ySOARJb9/ziaqTXO/HMYm1d+1ZU+sf8Ti4REU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740159879; c=relaxed/simple;
	bh=/CjSY5t2hAmWsRakO82xJ2VQmD+iQWuE+ehvrsRELRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8ywymtUOu07kfsScGvOWYeKsLXYvB+tuCnLAU//gKcf1yEH/EySbFWmJK0ay/tSllBv+qQjx4Eo6lNXYbe4vqLEMf39TovCTxyWKiUJUIYj1kjJTb79X5YdvWcgSNKd2YWgvqKF9Mh8CrFzsStLMJJU2q6XSk4K7H6GFR27C8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=jan.kiszka@siemens.com header.b=aFrg1IZC; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202502211744288fbe94cebb592f0155
        for <linux-kernel@vger.kernel.org>;
        Fri, 21 Feb 2025 18:44:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=27cs8I+6qCV9+Ed2Jt7ukHjW8TQgn0i2uzLEi23vu54=;
 b=aFrg1IZCqzKUB7DntC0sREi0HzJWzR+p93h9v8jWeKdad2g7ZXksPLmdiFZeyjNNpztdwg
 nAnwZRJUTtslQw6bmYmKkodEBIeYlC0RNbeYrAHXKRE89gsWfHsofpGkaKGuUYh19U0MC+hV
 /p20MW24NYFirBoEsOr2KNZUXoiRcXOlBL8mXpceUwMeqcw3/hoFO4rGwr1h1pXCBcMC4yWq
 soQEEXJbqLU2vGaSsnkTMvMS3F0X6VznGXLSbfv8Q0AEwgw56p5+a9vSfyO6MKhaDocp/SxC
 C9Qjx3LHNkmn1MmDd0cmw6Oh83AHNktax/nixRkLf4THjNIWrtp/8D/g==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: "Luis Claudio R . Goncalves" <lgoncalv@redhat.com>,
	stable-rt@vger.kernel.org,
	Pavel Machek <pavel@denx.de>
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Joseph Salisbury <joseph.salisbury@oracle.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Felix Moessbauer <felix.moessbauer@siemens.com>,
	Andreas Ziegler <ziegler.andreas@siemens.com>
Subject: [5.10-rt][PATCH 1/2] u64_stats: Introduce u64_stats_set()
Date: Fri, 21 Feb 2025 18:44:25 +0100
Message-ID: <a9bacf04c1b0b77a95ffed4e6fe0b2f6e72cb14b.1740159866.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1740159866.git.jan.kiszka@siemens.com>
References: <cover.1740159866.git.jan.kiszka@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer

From: Ahmed S. Darwish <a.darwish@linutronix.de>

[ Upstream commit f2efdb17928924c9c935c136dea764a081032006 ]

Allow to directly set a u64_stats_t value which is used to provide an init
function which sets it directly to zero intead of memset() the value.

Add u64_stats_set() to the u64_stats API.

[bigeasy: commit message. ]

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 include/linux/u64_stats_sync.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/u64_stats_sync.h b/include/linux/u64_stats_sync.h
index f23192d555285..af6fc08d2fcac 100644
--- a/include/linux/u64_stats_sync.h
+++ b/include/linux/u64_stats_sync.h
@@ -83,6 +83,11 @@ static inline u64 u64_stats_read(const u64_stats_t *p)
 	return local64_read(&p->v);
 }
 
+static inline void u64_stats_set(u64_stats_t *p, u64 val)
+{
+	local64_set(&p->v, val);
+}
+
 static inline void u64_stats_add(u64_stats_t *p, unsigned long val)
 {
 	local64_add(val, &p->v);
@@ -104,6 +109,11 @@ static inline u64 u64_stats_read(const u64_stats_t *p)
 	return p->v;
 }
 
+static inline void u64_stats_set(u64_stats_t *p, u64 val)
+{
+	p->v = val;
+}
+
 static inline void u64_stats_add(u64_stats_t *p, unsigned long val)
 {
 	p->v += val;
-- 
2.43.0


