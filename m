Return-Path: <linux-kernel+bounces-444067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7F59F0038
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 00:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF126287D2C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 23:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C581DED52;
	Thu, 12 Dec 2024 23:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R54ls08+"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A36D1DE4F0
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 23:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734046446; cv=none; b=qGKfVh6jm/B8Z3ZijLaXZGVcoE/erzOCezpDI8ZIm8a5Cqppr/8r6FDAquiV8pq6O7YZCLa3lKDS9rOKY83u3vuP9R8SVfeaNfsh59u7QIsyKsdWiRFuqWQP5QK2ht5mZrJz8RBowCAVBayTLLMnThnFDXelv6MERwZWBs08Zis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734046446; c=relaxed/simple;
	bh=Duaisv63OuGEXKabu1B70YdNEWCFhEY6uZDg/YUCXJM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I8hDjKAkJz4Dyd3nOoAIFhFd0PCd7GVT++Vxfx8zCDnG9IG4gxKWJmGGLzkg2dj874vPOe8XJqxzk5IFLiiDQ/WFtyNTOKkNCiqecYlaAMFb0XJ+f3Fj6lfmzuWI3P7MRMj5ggEAnSc07/3k9WXTMpRt3c7+rd8d6GbcULz3tYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--brianvv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R54ls08+; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--brianvv.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7ea8c2b257bso926699a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 15:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734046444; x=1734651244; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gW4H2/TOHS2zfDTwC9BxNBGpe/B9ZolBHNbHz0o02es=;
        b=R54ls08+Dwky3/b2gCh56a+rkP/2RSJPYDVXji1CnnVHD8/ry8Ls1lFjPW+CrUFcce
         rPHuujo83SpIp9oGGdNz+HPVsKXPWJozRyYe8ZgD7yRIc7VQCm3EnfAG+XOY9e4HeKys
         ZoQ0AJLomBvGduZx5PRJvkk0sdpXJPpBCcjZ94an8+gqnwn3IzlueveZPgmqdHBNNMlO
         MI066YqCdOOu/y5KtcMao16CmipUi/S/IesnGof3+pn3aHavWUTpasOJpuSv7rpljkgf
         p96SvNrAMDqJ2kejSltrn3+S/iHW+kRcyvgvySYnphkkgOPLsmjaEJyo5Vj5Fd8ypm9V
         9kmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734046444; x=1734651244;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gW4H2/TOHS2zfDTwC9BxNBGpe/B9ZolBHNbHz0o02es=;
        b=mPidynUiam+UejPiLNK5vyMYmDuxHYKG9/SM5RKNqAugwFlBgcFRsr1GNzNXXEHFEw
         yzTESjjugn9x8Mzd0THz4a65o2Jt3fuQ9ylRATekmstBqa3RsUNi6XRyOdHIXB3g886o
         F4Kq2DxLDnNi+A3xhNV5MnaayRnyoAkp3GiuoDbHgcHAd2dbC39u/LKjGPyM88c4/O0r
         J2wT22XEuVQRnEm3K9dDnxyayb1fLFDnFDOkDQ+UN991l5f02P5BF2ETgYgxSNkjByI7
         PwB7PzE4xYRB1njXK52WAZBEkhMgachrV1dDE5hjSrrx2eXT4R6SHfy16Phu27ErmY02
         vxzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj/7XKtglEeEclWbwyNLXWtWWi2Z0J/dHuDV4LYOPPbQODWCVAApEUAOA+mAggc4NbLmL2c7xN6ekSGxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUMUuPXrz7EUlY9KovKKoWoiyQuyh3HV0Pcxu155i2eSIuLnDn
	QEYIDxN68yIUQs3LDGjJyxqcYOTVVAd53FeQH/P8zC7dOSIJwoXiJQ/ri56zWJSmlzUBPD6slXb
	tJVrIiQ==
X-Google-Smtp-Source: AGHT+IHU8mSWUn2mLx+n7J9NPzZpWnWI7NTiMfpqSFskCF7VTr1LGMNcspFpdCFJLMvJCyEp1oQx/n1+r+p4
X-Received: from pjuj8.prod.google.com ([2002:a17:90a:d008:b0:2e0:aba3:662a])
 (user=brianvv job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4ac1:b0:2ee:8430:b831
 with SMTP id 98e67ed59e1d1-2f28fa50f7fmr901600a91.2.1734046444500; Thu, 12
 Dec 2024 15:34:04 -0800 (PST)
Date: Thu, 12 Dec 2024 23:33:32 +0000
In-Reply-To: <20241212233333.3743239-1-brianvv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241212233333.3743239-1-brianvv@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241212233333.3743239-3-brianvv@google.com>
Subject: [iwl-next PATCH v3 2/3] idpf: convert workqueues to unbound
From: Brian Vazquez <brianvv@google.com>
To: Brian Vazquez <brianvv.kernel@gmail.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	intel-wired-lan@lists.osuosl.org
Cc: David Decotigny <decot@google.com>, Vivek Kumar <vivekmr@google.com>, 
	Anjali Singhai <anjali.singhai@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	emil.s.tantilov@intel.com, Marco Leogrande <leogrande@google.com>, 
	Manoj Vishwanathan <manojvishy@google.com>, Brian Vazquez <brianvv@google.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Marco Leogrande <leogrande@google.com>

When a workqueue is created with `WQ_UNBOUND`, its work items are
served by special worker-pools, whose host workers are not bound to
any specific CPU. In the default configuration (i.e. when
`queue_delayed_work` and friends do not specify which CPU to run the
work item on), `WQ_UNBOUND` allows the work item to be executed on any
CPU in the same node of the CPU it was enqueued on. While this
solution potentially sacrifices locality, it avoids contention with
other processes that might dominate the CPU time of the processor the
work item was scheduled on.

This is not just a theoretical problem: in a particular scenario
misconfigured process was hogging most of the time from CPU0, leaving
less than 0.5% of its CPU time to the kworker. The IDPF workqueues
that were using the kworker on CPU0 suffered large completion delays
as a result, causing performance degradation, timeouts and eventual
system crash.

Tested:

* I have also run a manual test to gauge the performance
  improvement. The test consists of an antagonist process
  (`./stress --cpu 2`) consuming as much of CPU 0 as possible. This
  process is run under `taskset 01` to bind it to CPU0, and its
  priority is changed with `chrt -pQ 9900 10000 ${pid}` and
  `renice -n -20 ${pid}` after start.

  Then, the IDPF driver is forced to prefer CPU0 by editing all calls
  to `queue_delayed_work`, `mod_delayed_work`, etc... to use CPU 0.

  Finally, `ktraces` for the workqueue events are collected.

  Without the current patch, the antagonist process can force
  arbitrary delays between `workqueue_queue_work` and
  `workqueue_execute_start`, that in my tests were as high as
  `30ms`. With the current patch applied, the workqueue can be
  migrated to another unloaded CPU in the same node, and, keeping
  everything else equal, the maximum delay I could see was `6us`.

Fixes: 0fe45467a104 ("idpf: add create vport and netdev configuration")
Signed-off-by: Marco Leogrande <leogrande@google.com>
Signed-off-by: Manoj Vishwanathan <manojvishy@google.com>
Signed-off-by: Brian Vazquez <brianvv@google.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_main.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
index 305958c4c230..da1e3525719f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_main.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
@@ -198,7 +198,8 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pci_set_master(pdev);
 	pci_set_drvdata(pdev, adapter);
 
-	adapter->init_wq = alloc_workqueue("%s-%s-init", 0, 0,
+	adapter->init_wq = alloc_workqueue("%s-%s-init",
+					   WQ_UNBOUND | WQ_MEM_RECLAIM, 0,
 					   dev_driver_string(dev),
 					   dev_name(dev));
 	if (!adapter->init_wq) {
@@ -207,7 +208,8 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_free;
 	}
 
-	adapter->serv_wq = alloc_workqueue("%s-%s-service", 0, 0,
+	adapter->serv_wq = alloc_workqueue("%s-%s-service",
+					   WQ_UNBOUND | WQ_MEM_RECLAIM, 0,
 					   dev_driver_string(dev),
 					   dev_name(dev));
 	if (!adapter->serv_wq) {
@@ -216,7 +218,8 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_serv_wq_alloc;
 	}
 
-	adapter->mbx_wq = alloc_workqueue("%s-%s-mbx", 0, 0,
+	adapter->mbx_wq = alloc_workqueue("%s-%s-mbx",
+					  WQ_UNBOUND | WQ_MEM_RECLAIM, 0,
 					  dev_driver_string(dev),
 					  dev_name(dev));
 	if (!adapter->mbx_wq) {
@@ -225,7 +228,8 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_mbx_wq_alloc;
 	}
 
-	adapter->stats_wq = alloc_workqueue("%s-%s-stats", 0, 0,
+	adapter->stats_wq = alloc_workqueue("%s-%s-stats",
+					    WQ_UNBOUND | WQ_MEM_RECLAIM, 0,
 					    dev_driver_string(dev),
 					    dev_name(dev));
 	if (!adapter->stats_wq) {
@@ -234,7 +238,8 @@ static int idpf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_stats_wq_alloc;
 	}
 
-	adapter->vc_event_wq = alloc_workqueue("%s-%s-vc_event", 0, 0,
+	adapter->vc_event_wq = alloc_workqueue("%s-%s-vc_event",
+					       WQ_UNBOUND | WQ_MEM_RECLAIM, 0,
 					       dev_driver_string(dev),
 					       dev_name(dev));
 	if (!adapter->vc_event_wq) {
-- 
2.47.1.613.gc27f4b7a9f-goog


