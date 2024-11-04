Return-Path: <linux-kernel+bounces-395605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F429BC070
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 22:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5799282C44
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C741FDF80;
	Mon,  4 Nov 2024 21:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="hqrlQdJV"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E651FDFAD
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 21:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730757412; cv=none; b=bWuJlqReJ9JH+9ft5tT26AxgfXZ3t6wjRB1/NPZHXLv+nfFEzrQN2OWY45/xAmkrc5Z4ym2vkKlti2OPkDpyMurLCLBCV77zkXhF7gt87AvCE+uomGvSIEzR59xCarI1hppIDCnFxQpyugBYbAPD7sQir8nqw2aeBZwf9JWUhaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730757412; c=relaxed/simple;
	bh=OodwMsu6GphoAslfKl1LgS8kToCLyqz2m3IDnGDSc7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oqBr30Jvfbrlstj97VGKCLnUDbz3YL/rbLAOfI3Tt1FAMlAPDK1ByzZAe5mQvo5OxLm8UfKPGEKJ1iCsFVSR8QBoimSQvTVbyw2k6fHHi2C3r7argrdZazL/IZqHPo+NeofXwvntLa1mGtHmXDGacKYVeP+rWXb930lHEZNN1fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=hqrlQdJV; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-720c2db824eso4377892b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 13:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730757410; x=1731362210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHTcnyI8OB/3G3DumGaoUFWEu1m3gZBmE22QPK1+GKg=;
        b=hqrlQdJV6trD6ujHD6ghldu3Q6uC7Ck2VP2rEAuizhaifU4FHhii9z1C3+9VvovZSe
         nSb/1EHSEJxPAN/a9JB+LtfHerPF3m4ZkLBk4YM6LsxA9ooTqs3x/IQg846s+X2i99Oz
         UmeGe1bv4Y/bPt+bbeAHHRKPvAE2n6edVxg3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730757410; x=1731362210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHTcnyI8OB/3G3DumGaoUFWEu1m3gZBmE22QPK1+GKg=;
        b=Zk0IzZyqOUE/teCHp7t5F+NDX/siDClQaegUzFJ0Cw5ycavCCRdfQ0xQxUO+W0OuKx
         u8R5AWORXulm7sATSwZkUYX+LlINffsnZlIP8y6i6F+E8XHlYKFLnqBwHNC6HV/73lF2
         JDtaI4oPZV1uL2e6TefxXxB2QgDs11wCOEMTMC1uV/rUM4KxM0iRL42+K0CLMEbzpg2r
         XUJblXINUwoF7yrTin4tYjrmEn+kr6FAAiwt6Y1scNLpMdh3BMpYhyyuBrbUcSTTsOCK
         CMmPx6kntEabUx5NZ0/TMdqz4YE+gNHPzda/bRHy5bSiNyKvANbcL0ETcN4DAGOXRnxI
         eftQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnf1xt1uWgedUvV7p40ZZE1Qe9h01c0nC1WFNa/LmRPuyVPPqxVApFS9YW2jGDY/PVhoCwOZ1mLKFC3RQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDhbWUxTn1E2rgSP8L932DYl0yRoa4NdD6EfM76lAY6ybGftDc
	98Vcrg0oeqJ2sE6zbqNmOuaxgfyjygVYhPuc0K4jfH0uOVS5crY+jr9D9GASXfU=
X-Google-Smtp-Source: AGHT+IHzwf6vbF478BWj4+FrE88DtdyBD7kSBvF5CWlyGuwguVJXVL9Rzcja4x7spau6sxINfeFGlQ==
X-Received: by 2002:a17:902:ea03:b0:210:f6ba:a8c9 with SMTP id d9443c01a7336-210f6bab1d9mr277568575ad.17.1730757410095;
        Mon, 04 Nov 2024 13:56:50 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057062b8sm65860255ad.63.2024.11.04.13.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:56:49 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: corbet@lwn.net,
	hdanton@sina.com,
	bagasdotme@gmail.com,
	pabeni@redhat.com,
	namangulati@google.com,
	edumazet@google.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	sdf@fomichev.me,
	peter@typeblog.net,
	m2shafiei@uwaterloo.ca,
	bjorn@rivosinc.com,
	hch@infradead.org,
	willy@infradead.org,
	willemdebruijn.kernel@gmail.com,
	skhawaja@google.com,
	kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v6 2/7] net: Suspend softirq when prefer_busy_poll is set
Date: Mon,  4 Nov 2024 21:55:26 +0000
Message-Id: <20241104215542.215919-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241104215542.215919-1-jdamato@fastly.com>
References: <20241104215542.215919-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Karsten <mkarsten@uwaterloo.ca>

When NAPI_F_PREFER_BUSY_POLL is set during busy_poll_stop and the
irq_suspend_timeout is nonzero, this timeout is used to defer softirq
scheduling, potentially longer than gro_flush_timeout. This can be used
to effectively suspend softirq processing during the time it takes for
an application to process data and return to the next busy-poll.

The call to napi->poll in busy_poll_stop might lead to an invocation of
napi_complete_done, but the prefer-busy flag is still set at that time,
so the same logic is used to defer softirq scheduling for
irq_suspend_timeout.

Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
Co-developed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 v3:
   - Removed reference to non-existent sysfs parameter from commit
     message. No functional/code changes.

 net/core/dev.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 4d910872963f..51d88f758e2e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6239,7 +6239,12 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 			timeout = napi_get_gro_flush_timeout(n);
 		n->defer_hard_irqs_count = napi_get_defer_hard_irqs(n);
 	}
-	if (n->defer_hard_irqs_count > 0) {
+	if (napi_prefer_busy_poll(n)) {
+		timeout = napi_get_irq_suspend_timeout(n);
+		if (timeout)
+			ret = false;
+	}
+	if (ret && n->defer_hard_irqs_count > 0) {
 		n->defer_hard_irqs_count--;
 		timeout = napi_get_gro_flush_timeout(n);
 		if (timeout)
@@ -6375,9 +6380,13 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
 	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 
 	if (flags & NAPI_F_PREFER_BUSY_POLL) {
-		napi->defer_hard_irqs_count = napi_get_defer_hard_irqs(napi);
-		timeout = napi_get_gro_flush_timeout(napi);
-		if (napi->defer_hard_irqs_count && timeout) {
+		timeout = napi_get_irq_suspend_timeout(napi);
+		if (!timeout) {
+			napi->defer_hard_irqs_count = napi_get_defer_hard_irqs(napi);
+			if (napi->defer_hard_irqs_count)
+				timeout = napi_get_gro_flush_timeout(napi);
+		}
+		if (timeout) {
 			hrtimer_start(&napi->timer, ns_to_ktime(timeout), HRTIMER_MODE_REL_PINNED);
 			skip_schedule = true;
 		}
-- 
2.25.1


