Return-Path: <linux-kernel+bounces-523653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D32A3D9AE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 13:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A09903BF5A6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3081C1F63D9;
	Thu, 20 Feb 2025 12:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ERdu8Aaz"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5BB1F473A
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740053885; cv=none; b=nW6iWpV8cctg6juwmEzGpLGu9kPWvZ4vw7oXPX2hVsHVScBr+CWzCq2pBmPlmWqCbw/pgMBFeJ83sP6W4SLK4/6qdM37JeHezYpSKfIstNwfG0uwIHriUhnNC2qda8i9eomwRtmZhYgwjPsnWrZHCkoH6nJiSIgnP5yW0DLcDNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740053885; c=relaxed/simple;
	bh=eiRKbq2vepIQ7vYQL3IVoywHrok/Z1eF+aDZknLuwYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gxYqqjEdxn4eyTuRAH12j2yTGicBVP9YQVdnHqC/N/wr6ah3KUedjwfIfVxI8Tvv0XkthhbOrXJayUD7ARhyCqUJuJwPNgsrAAurvhqL+XMGadro250l2XeFPCToU2tCOxqUOC/caIXbuEDUwclnT9l85xbmT6H2VDDjWN+8ZfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ERdu8Aaz; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22114b800f7so14227885ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 04:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740053882; x=1740658682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=juzMyLx5J28dogWl0dvZjIex3AlV6esdHMv6/KGnTD4=;
        b=ERdu8Aaz8Cs+oY/RQIlihCzvuEoYxZv9bt6iCsgTeNJDoG/NnjIYcbjLH03gqRHEMX
         qBIJUsBFTByt4t9YLAsJMZpqqGPrnYu7VoVuLArYwrpge3rLCLDbQsCXONsZa+5CxUJB
         xM87rNW3ic/bPrRhh+ijjHfDhFJxRQKZf2gVxOQsjxxu4/RS12V+HALJGsMCbs8OVev/
         ViG4KFB9W3K3GVgXOtnyFsq2wFPptIW6oA1vznISbM6u5IKq4PkGrjuBjkLYsHf5VyjC
         6RFkX8WmZk3jcwCvytULZnlv2l1JFjHyoW8ScPTKsVNxyNrADSdpjQ0OVK2g1krBoR3y
         P8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740053882; x=1740658682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=juzMyLx5J28dogWl0dvZjIex3AlV6esdHMv6/KGnTD4=;
        b=iTzNTJQbRjSeRHH+vwaQBGER77ghM2Vn7icemSkLsdlj7cdAX/9QvEgb9vNyzTIVUO
         7BoGNYci0n5KEt6+O04ryOdwxTbKAi1dHVhjlysY39AcC5GiKubxEGuCb7Aqwke9B/sI
         /IuXe3/SYV3J7YUjBUS4IfobhV5KYwMjg5yE3PgdMf01xWQDylZF+s3wxpWyw5L4qwmv
         IW4hd0Sl8Sj39fvqzcInPas1ADtZp5r6Prs5wR7cnviTw16RmXE5m3e4sRQxa4fzIQR2
         Nc5EoXS/hJAohKcmfguEvVHK/TVYyun6iQ9qXb4BNLnj2MYaAceSdzg6tQkUX41rTYqt
         mYYg==
X-Forwarded-Encrypted: i=1; AJvYcCWtl7IrWxPDWg/TTu/kvtDT3o32utxPCwdpje2mr/rHnfsuNgLOzjzPeQV+v9z3+84oQM4pg+szVey6k1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo5GVhVlnXZTPVwiukBGbQ/tTuM9dGTAw1SCnQYH+paV/MVNKa
	b07pv3KyDZV4eaZkgMhCtyNrfSEx882OqZY5vCC3QUUMAQai/oacKmDQ1J7i82WXlSEtttB2wlF
	xZB4=
X-Gm-Gg: ASbGncsqEXJoQkfNKbf/oWw/Sk/pgChqyXmJRM2whB5uSdjPXgTe4ayTRLBjTvh+9ly
	t1//0ZkXurJMPfv2jamEj2jNdMWwUoeKLP4GpsNPZ5fNHnb4n899mW5oHoIf9KdEZxPkDxg7DRi
	xc3T4nTM03GmFgctoJ4iT+FjU6LjdMLpAgessNktECI/citbsiu+hMLlKdlhqjbrDtlRhiKli2d
	v639v8ClPCQvge4KSmXdZPn4tWFbYW4Y/ub8DFNSVZ3Hg01iYnh57QwtyYoWOMgCURDOc/WfFD5
	D+zwjnhYAMcV/qte/FmqiWjx05Q9xRp+ZrfayEDQmNv5Gi8gXQ==
X-Google-Smtp-Source: AGHT+IG9TMnvbyOkty/+IgJLUTpsHYYN+sn16XIRU1xBzk2Wl5EGIuL+mvxJhhYIG67jSv/YFg65nA==
X-Received: by 2002:a17:903:2309:b0:215:7dbf:f3de with SMTP id d9443c01a7336-22170988a8cmr130641525ad.28.1740053882339;
        Thu, 20 Feb 2025 04:18:02 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-221040434d9sm87773895ad.196.2025.02.20.04.17.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 20 Feb 2025 04:18:02 -0800 (PST)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: xueshuai@linux.alibaba.com,
	renyu.zj@linux.alibaba.com,
	will@kernel.org,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH v4 1/2] perf/dwc_pcie: fix some unreleased resources
Date: Thu, 20 Feb 2025 20:17:15 +0800
Message-Id: <20250220121716.50324-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250220121716.50324-1-cuiyunhui@bytedance.com>
References: <20250220121716.50324-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Release leaked resources, such as plat_dev and dev_info.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 drivers/perf/dwc_pcie_pmu.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
index cccecae9823f..19fa2ba8dd67 100644
--- a/drivers/perf/dwc_pcie_pmu.c
+++ b/drivers/perf/dwc_pcie_pmu.c
@@ -572,8 +572,10 @@ static int dwc_pcie_register_dev(struct pci_dev *pdev)
 		return PTR_ERR(plat_dev);
 
 	dev_info = kzalloc(sizeof(*dev_info), GFP_KERNEL);
-	if (!dev_info)
+	if (!dev_info) {
+		platform_device_unregister(plat_dev);
 		return -ENOMEM;
+	}
 
 	/* Cache platform device to handle pci device hotplug */
 	dev_info->plat_dev = plat_dev;
@@ -730,6 +732,15 @@ static struct platform_driver dwc_pcie_pmu_driver = {
 	.driver = {.name = "dwc_pcie_pmu",},
 };
 
+static void dwc_pcie_cleanup_devices(void)
+{
+	struct dwc_pcie_dev_info *dev_info, *tmp;
+
+	list_for_each_entry_safe(dev_info, tmp, &dwc_pcie_dev_info_head, dev_node) {
+		dwc_pcie_unregister_dev(dev_info);
+	}
+}
+
 static int __init dwc_pcie_pmu_init(void)
 {
 	struct pci_dev *pdev = NULL;
@@ -742,7 +753,7 @@ static int __init dwc_pcie_pmu_init(void)
 		ret = dwc_pcie_register_dev(pdev);
 		if (ret) {
 			pci_dev_put(pdev);
-			return ret;
+			goto err_cleanup;
 		}
 	}
 
@@ -751,35 +762,35 @@ static int __init dwc_pcie_pmu_init(void)
 				      dwc_pcie_pmu_online_cpu,
 				      dwc_pcie_pmu_offline_cpu);
 	if (ret < 0)
-		return ret;
+		goto err_cleanup;
 
 	dwc_pcie_pmu_hp_state = ret;
 
 	ret = platform_driver_register(&dwc_pcie_pmu_driver);
 	if (ret)
-		goto platform_driver_register_err;
+		goto err_remove_cpuhp;
 
 	ret = bus_register_notifier(&pci_bus_type, &dwc_pcie_pmu_nb);
 	if (ret)
-		goto platform_driver_register_err;
+		goto err_unregister_driver;
 	notify = true;
 
 	return 0;
 
-platform_driver_register_err:
+err_unregister_driver:
+	platform_driver_unregister(&dwc_pcie_pmu_driver);
+err_remove_cpuhp:
 	cpuhp_remove_multi_state(dwc_pcie_pmu_hp_state);
-
+err_cleanup:
+	dwc_pcie_cleanup_devices();
 	return ret;
 }
 
 static void __exit dwc_pcie_pmu_exit(void)
 {
-	struct dwc_pcie_dev_info *dev_info, *tmp;
-
 	if (notify)
 		bus_unregister_notifier(&pci_bus_type, &dwc_pcie_pmu_nb);
-	list_for_each_entry_safe(dev_info, tmp, &dwc_pcie_dev_info_head, dev_node)
-		dwc_pcie_unregister_dev(dev_info);
+	dwc_pcie_cleanup_devices();
 	platform_driver_unregister(&dwc_pcie_pmu_driver);
 	cpuhp_remove_multi_state(dwc_pcie_pmu_hp_state);
 }
-- 
2.39.2


