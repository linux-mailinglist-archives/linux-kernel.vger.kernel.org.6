Return-Path: <linux-kernel+bounces-283335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 020D094F0FA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 16:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 853641F214C2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BD5187869;
	Mon, 12 Aug 2024 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="bkhKUbz8"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B79D187346
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 14:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474636; cv=none; b=buyVAC5V0u3G9v0bXSRB9DtULey5x/PvrbL+7sqSRcPmm2FZtV6v+28B4M0omS/ZRwULTdb0Db/lPmsQZpgjudIblL/AYR2BlgT5Q+jgFlJT1oqKvmnq4RxIXdtdFyn9RewpgTGpLJAqie2fh9yVjN8A0xf/TtXyn569TnChgr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474636; c=relaxed/simple;
	bh=td4IsMjxeMQ6Pb6ByC9aYsEdMEh9ogovdqECp/o7xSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vEYKdvivm02pX3pDPzAehNmmxDeF1OP6O9vce8BLepgKsOfkJIrnxoQfwrCjUjt1PzZebae0sjr+1se/L3RN3uyrr8jBPOiKljW2o+iij8aMSAavm3Y20GqieVfnjWo8ZO75vlegY9O+gKq6dCUvN5R44TsYGYSodqAszh2MHew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=bkhKUbz8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fc56fd4de1so29191805ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 07:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723474635; x=1724079435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrcLy1oab8U1SIQex97TmW2YjriWxSFP0Rv3hsdafno=;
        b=bkhKUbz8jQPQ4OloRxO/3M0Rhi6XHTHiI6nIEidYLwQLMHrzWQTHeQ7T8JjUfedWwv
         UgoggQl0f7uu1DWeQU20TWDc0mbo7mssOcKQAkzDvjOjwDTaOLKdnSoO7DF8AHugD7Ml
         XK0aJMM/Oo2bKPcnGM+DrjZ4vCEgtJS2dSQTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723474635; x=1724079435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrcLy1oab8U1SIQex97TmW2YjriWxSFP0Rv3hsdafno=;
        b=VZ49P6Xktu/CDi6AbCiooEdT8PYX0PP/tZZEhBsfREdjEQ9PLkF+0X3OYFi+52OcHj
         fQY8pUF46X7uYf67YPGQu0jq8MIOaA5rEY5OHWl7ao6ZAi+PIoHy7722fkh4mMV+R+We
         Isu8T0jgTZ+9X2xvB2v75k1w4qljC6xiVFsB0dMw5mTT8dZFR/CMVEv/LCjreBiR2eic
         9ZkMl0srRUfwdhA6aebSpuunV/cR3/oNBVprJoP+6YCMDYmnAAgkhjsWCXzQjEOCn7lw
         iCSPd3mRgdC4AtXK6Oat+Z+Yg23xsRxkGOSdhLibTn/sWvCHoy0ut+YLkFIjyIaWYxGV
         7Y8A==
X-Forwarded-Encrypted: i=1; AJvYcCVyGHrMaytNJUe/8Xb7JryR8A1TNG9IYujKtY6ak2hkL72gwzpzgcuqs8oEXn8tCn4AJ14ybIwNW4DncI7tex354Jlt1+tv0A0juO27
X-Gm-Message-State: AOJu0YzPR+tvXmw7aTNNEWYOdNc0fKsawWEOzdCXhlMg1Kj3/1UnEu3b
	vsm0+Q3KUKYMrCa37Pcg/pv40A+EWjTr9pRMchGUaQl7DsPsTQvTqVXg+WbbNfk=
X-Google-Smtp-Source: AGHT+IFYynzfBMLo6xho+itYUwLn3K/YaUpQ+DqK2Cu71wzV3u7gXENwfqrtXKcgSmW4HC1IOzt8TQ==
X-Received: by 2002:a17:902:d4ce:b0:1fc:4680:820d with SMTP id d9443c01a7336-201ca92cd81mr5391865ad.9.1723474635006;
        Mon, 12 Aug 2024 07:57:15 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb8fd835sm39006955ad.89.2024.08.12.07.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 07:57:14 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next 5/6] iavf: Use napi_affinity_no_change
Date: Mon, 12 Aug 2024 14:56:26 +0000
Message-Id: <20240812145633.52911-6-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240812145633.52911-1-jdamato@fastly.com>
References: <20240812145633.52911-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use napi_affinity_no_change instead of iavf's internal implementation,
simplifying and centralizing the logic. To support this, struct
iavf_q_vector has been extended to store the IRQ number, and irq_num's
type is changed to unsigned int.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/intel/iavf/iavf.h      | 1 +
 drivers/net/ethernet/intel/iavf/iavf_main.c | 4 +++-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 4 +---
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
index 23a6557fc3db..b066bac6fa7c 100644
--- a/drivers/net/ethernet/intel/iavf/iavf.h
+++ b/drivers/net/ethernet/intel/iavf/iavf.h
@@ -113,6 +113,7 @@ struct iavf_q_vector {
 	bool arm_wb_state;
 	cpumask_t affinity_mask;
 	struct irq_affinity_notify affinity_notify;
+	unsigned int irq_num;
 };
 
 /* Helper macros to switch between ints/sec and what the register uses.
diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index ff11bafb3b4f..6c7733025ce3 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -565,7 +565,8 @@ iavf_request_traffic_irqs(struct iavf_adapter *adapter, char *basename)
 {
 	unsigned int vector, q_vectors;
 	unsigned int rx_int_idx = 0, tx_int_idx = 0;
-	int irq_num, err;
+	unsigned int irq_num;
+	int err;
 	int cpu;
 
 	iavf_irq_disable(adapter);
@@ -601,6 +602,7 @@ iavf_request_traffic_irqs(struct iavf_adapter *adapter, char *basename)
 				 "Request_irq failed, error: %d\n", err);
 			goto free_queue_irqs;
 		}
+		q_vector->irq_num = irq_num;
 		/* register for affinity change notifications */
 		q_vector->affinity_notify.notify = iavf_irq_affinity_notify;
 		q_vector->affinity_notify.release =
diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index 26b424fd6718..5eb78ac1f39d 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -1408,8 +1408,6 @@ int iavf_napi_poll(struct napi_struct *napi, int budget)
 
 	/* If work not completed, return budget and polling will return */
 	if (!clean_complete) {
-		int cpu_id = smp_processor_id();
-
 		/* It is possible that the interrupt affinity has changed but,
 		 * if the cpu is pegged at 100%, polling will never exit while
 		 * traffic continues and the interrupt will be stuck on this
@@ -1417,7 +1415,7 @@ int iavf_napi_poll(struct napi_struct *napi, int budget)
 		 * continue to poll, otherwise we must stop polling so the
 		 * interrupt can move to the correct cpu.
 		 */
-		if (!cpumask_test_cpu(cpu_id, &q_vector->affinity_mask)) {
+		if (!napi_affinity_no_change(q_vector->irq_num)) {
 			/* Tell napi that we are done polling */
 			napi_complete_done(napi, work_done);
 
-- 
2.25.1


