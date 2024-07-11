Return-Path: <linux-kernel+bounces-248831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC7292E27D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38CE21F215E5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FFC15ADB6;
	Thu, 11 Jul 2024 08:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gn2nuoPc"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A6615AAD9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686801; cv=none; b=nY9q6K0WzBmWX+/I+B4nPcCvxgnbawVJnSsvn408ToOgW2fm6wwCxvjHW1+ritYTzdWZSO7XVJBUO7wc0djvaWdaLF3jQh6vT0LO8dl5gkII6M2XJlkB0in58GiDjSl+LLidvhli7k/a9xh+cwlbpY8av8z1yDQqTrYu5CJC4WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686801; c=relaxed/simple;
	bh=bi9MADgbkJVRRxAO//LTHOzkofDKoVl/DPisCjpaYBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ifBIKQVEauPijqloNnm/CL5Dh9NP/1nL2I2ekLn6Vv5nB2P47rPNVOrRVUPsVlpJ88MRhGHGP2e6bPSBbnt6a0SLm0jvwc1kiZS99MS2foB06g6Vny/JuYmDa11ztycrUUSlIBkn9lJcNUpnE6FVI/YpXWi1ogWRlIhsdT3D9ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gn2nuoPc; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fa55dbf2e7so3573825ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 01:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720686799; x=1721291599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ykf6J3ZBviVn4CTmkU3CZJmImASCyvUuhcoe9tkolI=;
        b=gn2nuoPctsVNXrcPZylvxfYHdyr8U0ypbBoHtMYuS+zufvnrP+0RuPonULMFzyuBYK
         gpRIk9AlVigb4XBvfdsULMTVcqcE6hItzAH2VrbACRQ4efJTKuxvCi2ejTO6UOfcCqtz
         JVcrBP1mgDljrRILlm83TpsMS0z7eGrsdVObVvsSZ8aonKLzf3b8NDX/cwu/DMvT/4xS
         3k1iOfHs0PhyVgZsVH7Xi9GbHqUaPJG0jCWmmUUckx/xJdYqTsb6TlxR+zkBRWCBs6q6
         vjsACLf9Mfjom1y3BVIV/wL6KfR4XlcCQ3lt70gONGxZq+A4mSGuDUSZrUZIWrLhaV9e
         niTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720686799; x=1721291599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ykf6J3ZBviVn4CTmkU3CZJmImASCyvUuhcoe9tkolI=;
        b=wtuMcityjnTcnyjO9+9WQu6heL6BfX67qPGsX5r3NXncTQyBNFEVg4wQ0lw+5H7eT9
         tRXwbXuiBcxej5ELMjxOAffh4vxaAy8lx0dGieH7Vvwnr2z7K5Gr37w6Nn5UnlLlhVN+
         +gItfooU1FGUYgYJ8p91SxEOx+gVA/dbdouvGjwB72KsKMcHLdBLi8wd1j58kVq58I4+
         GJuCGxIZ0RVB8AiAkbSyEHi/JG6Q/OxrBJvpAxkMEY5YCZv/HWgAdp7p2G1H2n8erwKO
         Y9TusT32oJJCNaW29xBEkdhhvZEtiHF3Lr4lqowRNJOA9C07o8X4R5Tc3ecYQyJ0BKki
         ux0w==
X-Gm-Message-State: AOJu0YwowVW1qfa6hoYieYNQQPvIE5fJaqytgHttLaQ9i/WXMWhIK5Y0
	iQSW08QzJo5m+bqZiTN+qNolwoJPcqQpCjD4h2N/QkYywU/qRywnrxVY2Q==
X-Google-Smtp-Source: AGHT+IHzWdd6Rce2GYPczC1+47lqb61tOHD3BRb7uzO/IZL2eQZT7twBKQ23VaGWonU/TalJj2dpNQ==
X-Received: by 2002:a17:902:dacb:b0:1fb:284b:b39a with SMTP id d9443c01a7336-1fbb6d044a5mr72528715ad.21.1720686798654;
        Thu, 11 Jul 2024 01:33:18 -0700 (PDT)
Received: from localhost ([47.89.225.180])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a2a2d2sm45553405ad.91.2024.07.11.01.33.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2024 01:33:18 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 6/7] workqueue: Remove the arguments @hotplug_cpu and @online from wq_update_pod()
Date: Thu, 11 Jul 2024 16:35:46 +0800
Message-Id: <20240711083547.3981-7-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240711083547.3981-1-jiangshanlai@gmail.com>
References: <20240711083547.3981-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

The arguments @hotplug_cpu and @online are not used in wq_update_pod()
since the functions called by wq_update_pod() don't need them.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 97ddccf8cd0e..21e1c5787ba4 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5354,8 +5354,6 @@ int apply_workqueue_attrs(struct workqueue_struct *wq,
  * wq_update_pod - update pod affinity of a wq for CPU hot[un]plug
  * @wq: the target workqueue
  * @cpu: the CPU to update pool association for
- * @hotplug_cpu: the CPU coming up or going down
- * @online: whether @cpu is coming up or going down
  *
  * This function is to be called from %CPU_DOWN_PREPARE, %CPU_ONLINE and
  * %CPU_DOWN_FAILED.  @cpu is being hot[un]plugged, update pod affinity of
@@ -5372,8 +5370,7 @@ int apply_workqueue_attrs(struct workqueue_struct *wq,
  * CPU_DOWN. If a workqueue user wants strict affinity, it's the user's
  * responsibility to flush the work item from CPU_DOWN_PREPARE.
  */
-static void wq_update_pod(struct workqueue_struct *wq, int cpu,
-			  int hotplug_cpu, bool online)
+static void wq_update_pod(struct workqueue_struct *wq, int cpu)
 {
 	struct pool_workqueue *old_pwq = NULL, *pwq;
 	struct workqueue_attrs *target_attrs;
@@ -6593,7 +6590,7 @@ int workqueue_online_cpu(unsigned int cpu)
 			int tcpu;
 
 			for_each_cpu(tcpu, pt->pod_cpus[pt->cpu_pod[cpu]])
-				wq_update_pod(wq, tcpu, cpu, true);
+				wq_update_pod(wq, tcpu);
 
 			mutex_lock(&wq->mutex);
 			wq_update_node_max_active(wq, -1);
@@ -6628,7 +6625,7 @@ int workqueue_offline_cpu(unsigned int cpu)
 			int tcpu;
 
 			for_each_cpu(tcpu, pt->pod_cpus[pt->cpu_pod[cpu]])
-				wq_update_pod(wq, tcpu, cpu, false);
+				wq_update_pod(wq, tcpu);
 
 			mutex_lock(&wq->mutex);
 			wq_update_node_max_active(wq, cpu);
@@ -6917,7 +6914,7 @@ static int wq_affn_dfl_set(const char *val, const struct kernel_param *kp)
 
 	list_for_each_entry(wq, &workqueues, list) {
 		for_each_online_cpu(cpu) {
-			wq_update_pod(wq, cpu, cpu, true);
+			wq_update_pod(wq, cpu);
 		}
 	}
 
@@ -7928,7 +7925,7 @@ void __init workqueue_init_topology(void)
 	 */
 	list_for_each_entry(wq, &workqueues, list) {
 		for_each_online_cpu(cpu)
-			wq_update_pod(wq, cpu, cpu, true);
+			wq_update_pod(wq, cpu);
 		if (wq->flags & WQ_UNBOUND) {
 			mutex_lock(&wq->mutex);
 			wq_update_node_max_active(wq, -1);
-- 
2.19.1.6.gb485710b


