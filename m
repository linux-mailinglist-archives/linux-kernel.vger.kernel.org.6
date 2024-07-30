Return-Path: <linux-kernel+bounces-267198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB118940E46
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60FB61F24518
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5282319884B;
	Tue, 30 Jul 2024 09:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.es header.i=@amazon.es header.b="XL4C6pnn"
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FA3196D8E
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 09:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722333088; cv=none; b=mDpON0tjmU1nMhckwo2S+IJzJvsP1BSNjZap84jxnXq8AutrE0Za8izFtrKHNUh8ylRe4gxlnbdpd+ys8ZFNxfAgyoZk5JOoWWYskT/s5bgA5vTPg82uRNPNtDk55AC1U8r1JWu2wbo90rdb2vlrFbXXgHcWNMXK3CgYOeH66ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722333088; c=relaxed/simple;
	bh=vQuZTL83RSZvFP1Hizzh3pmSZYG//WG1NuEgkkyh7p4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eV1d804h1PFOIe/DMApL6OBkyGiPQL1uZpcGzEntXKwzKwDJ1dejeQi2btrkt4sxHA010LGaWplp6CebQMIFl8rVgCVNcG569D6htNZh5qf0ukZcjmZOr7DsmnOMrQaIDZLRcvLjMegicqaM8nyW4Zj0a7+dmD+Bl13hX+ZDiYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.es header.i=@amazon.es header.b=XL4C6pnn; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1722333087; x=1753869087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K1TvjyNXbVGMa7VAQLepXHoySp7QtY4fM3etRq1B05k=;
  b=XL4C6pnnyKo6Qj8TuD9KNsLC5droE48SMNNNgBWg4sZPerxKWFkDYz7e
   X0zRY8miCGRLn56l6pobgHD+Qmc6J7bon5NKL2xdHLq2QQLxFacF14XkF
   LZ08Igscm1rGnv4Th14meXHHKJHiApTdOhBq2zOcs8MEtYc6r2PgCdUov
   M=;
X-IronPort-AV: E=Sophos;i="6.09,248,1716249600"; 
   d="scan'208";a="423834904"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 09:51:23 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:38752]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.1:2525] with esmtp (Farcaster)
 id 1308ebad-a879-4ef8-bd1b-bde72989b424; Tue, 30 Jul 2024 09:51:22 +0000 (UTC)
X-Farcaster-Flow-ID: 1308ebad-a879-4ef8-bd1b-bde72989b424
Received: from EX19D020UWC003.ant.amazon.com (10.13.138.187) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 30 Jul 2024 09:51:22 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D020UWC003.ant.amazon.com (10.13.138.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 30 Jul 2024 09:51:22 +0000
Received: from u46b330cbefe15e.ant.amazon.com.com (10.13.247.161) by
 mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34
 via Frontend Transport; Tue, 30 Jul 2024 09:51:21 +0000
From: Babis Chalios <bchalios@amazon.es>
To: <tytso@mit.edu>, <Jason@zx2c4.com>, <linux-kernel@vger.kernel.org>
CC: <graf@amazon.de>, <mzxreary@0pointer.de>, <xmarcalx@amazon.co.uk>,
	<gregkh@linuxfoundation.org>, Babis Chalios <bchalios@amazon.es>
Subject: [PATCH 1/1] vmgenid: emit uevent with new generation ID
Date: Tue, 30 Jul 2024 11:48:31 +0200
Message-ID: <20240730094831.882166-2-bchalios@amazon.es>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730094831.882166-1-bchalios@amazon.es>
References: <20240730094831.882166-1-bchalios@amazon.es>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

There are many system services that need to be notified when the VM they
are running in is resumed from a snapshot. One example are network
managers which need to renew DHCP leases and/or re-create MAC addresses
for virtual interfaces. Other example are daemons that manage system
clocks which need reset upon snapshot resume.

Send a uevent notification to user space from the VMGenID driver when
we receive the ACPI notification about a new generation ID. This way, we
notify user space software about the VM cloning event and give it a
chance to adapt to the new environment.

Signed-off-by: Babis Chalios <bchalios@amazon.es>
---
 drivers/virt/vmgenid.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
index 66135eac3abff..5410620a017f5 100644
--- a/drivers/virt/vmgenid.c
+++ b/drivers/virt/vmgenid.c
@@ -26,6 +26,7 @@ struct vmgenid_state {
 static void vmgenid_notify(struct device *device)
 {
 	struct vmgenid_state *state = device->driver_data;
+	char *envp[] = { "NEW_VMGENID=1", NULL };
 	u8 old_id[VMGENID_SIZE];
 
 	memcpy(old_id, state->this_id, sizeof(old_id));
@@ -33,6 +34,7 @@ static void vmgenid_notify(struct device *device)
 	if (!memcmp(old_id, state->this_id, sizeof(old_id)))
 		return;
 	add_vmfork_randomness(state->this_id, sizeof(state->this_id));
+	kobject_uevent_env(&device->kobj, KOBJ_CHANGE, envp);
 }
 
 static void setup_vmgenid_state(struct vmgenid_state *state, void *virt_addr)
-- 
2.34.1


