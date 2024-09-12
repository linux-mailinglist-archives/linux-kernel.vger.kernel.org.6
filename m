Return-Path: <linux-kernel+bounces-325849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F44975EF7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 04:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23A371C220C3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 02:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC6641C89;
	Thu, 12 Sep 2024 02:37:48 +0000 (UTC)
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF32250EC
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 02:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726108668; cv=none; b=U1WzirCwWTs+v0ohKfL4hKJlVGysBEp5pB+I8froK2ct+HTF5lD/jx+9YUf4kbUMUvP8P/2t/FP1dhZU0QLosN1LsGWgUNeC7Lf376F7ykHgdmw25tckAIlyos+ceAB7+u1xMqYdyPY18ietKnpncLCXoHatay/p7i1bkfskPS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726108668; c=relaxed/simple;
	bh=+ptdzpifG3s/EVqlN1yvgkhX8LXvZiKhDKNDZ9kgIJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A9vMXIgh+iDPRP3A0HQqoT0gHuYR2z7v4+1XhR+X/xlze1vegfDUGcmgIArhn8elLlEYhRsnTGro/sJ8fOA3nYX+IbPELdwE0W+1aPIY3MHt+kNyj++gFK6CflOb18pV3/efpzAdXEyDc8I0t0m1mjg2Z62h5uFmBTwxWdhrxHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee666e253f4c76-f2538;
	Thu, 12 Sep 2024 10:37:41 +0800 (CST)
X-RM-TRANSID:2ee666e253f4c76-f2538
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee966e253f5c6d-fb26f;
	Thu, 12 Sep 2024 10:37:41 +0800 (CST)
X-RM-TRANSID:2ee966e253f5c6d-fb26f
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: liucong2@kylinos.cn
Cc: linux-kernel@vger.kernel.org,
	brho@google.com,
	tj@kernel.org,
	akpm@linux-foundation.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] tools/Makefile: Add kvm_stat_clean target.
Date: Thu, 12 Sep 2024 10:37:39 +0800
Message-Id: <20240912023739.13726-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

Run make kvm_stat can create kvm_stat.1 file.
Add kvm_stat_clean for rm it.

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 tools/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/Makefile b/tools/Makefile
index 278d24723b74..97de2514f967 100644
--- a/tools/Makefile
+++ b/tools/Makefile
@@ -215,12 +215,15 @@ freefall_clean:
 build_clean:
 	$(call descend,build,clean)
 
+kvm_stat_clean:
+	$(call descend,kvm/kvm_stat,clean)
+
 clean: acpi_clean counter_clean cpupower_clean hv_clean firewire_clean \
 		perf_clean selftests_clean turbostat_clean bootconfig_clean spi_clean usb_clean virtio_clean \
 		mm_clean bpf_clean iio_clean x86_energy_perf_policy_clean tmon_clean \
 		freefall_clean build_clean libbpf_clean libsubcmd_clean \
 		gpio_clean objtool_clean leds_clean wmi_clean pci_clean firmware_clean debugging_clean \
 		intel-speed-select_clean tracing_clean thermal_clean thermometer_clean thermal-engine_clean \
-		sched_ext_clean
+		sched_ext_clean kvm_stat_clean
 
 .PHONY: FORCE
-- 
2.33.0




