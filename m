Return-Path: <linux-kernel+bounces-278863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF17194B5C2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 06:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FF59282DF8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 04:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3266680C13;
	Thu,  8 Aug 2024 04:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJPjsH/e"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC4E6E61B
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 04:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723090184; cv=none; b=TurMn3QpK3tBSUI7z7Qs+tQs/h0BasPwl6s7fOTn+e8fadw4kAhl++/x+a3kHu4ZVpzdenpVxhWl3J+OVIySpOOVAa2m2cHKfDYC1OAq76ML+wdcOnn9Hw8z3OQzFZSZf9/SdlxenVJJUS7NDGNa557VLYAjMc1qLYyV63/fyYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723090184; c=relaxed/simple;
	bh=dhuSugdtI57IIEkqYrZzbHxmi0y/832YL+0TlpkK0yc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VeiC55BgIA/HsORpoQLijF/fz93GkqwvU4pP8AuvxxzgbEj+p23xlr2ZKf9B7/8Nizs/I4nHiwo0+NYfPNohS0LShXxIVC5lOe/PbwqOSPRabwPBodgO/aDJ4VYPkpM1ncuxs6Zl9/cAeNLGIZbbuFKSom/pYkTx4W5tWLwePCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jJPjsH/e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723090180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BuInqvPD+oWLYg4MqJMCVqaaQqCELRkqQQ4G5anOxEE=;
	b=jJPjsH/epusCyxXzhUMQkxlP7zySOTUfAFaRxG1TMxh6lfoHPuN0C+v9mltdSocHhbhnEE
	vhTGCSsHKF2dIL7fCEAeST2KhVsCRTOHNTe1oEQoc4QgWQkyheCzfqZQpHlqIJVhx/W72Z
	+VYMkOIft7g9iP6ICaxAnS5E8HdOD7o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-5hFFU7rxOzOYlixSoQRUfg-1; Thu,
 08 Aug 2024 00:09:35 -0400
X-MC-Unique: 5hFFU7rxOzOYlixSoQRUfg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E7131195608A;
	Thu,  8 Aug 2024 04:09:33 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.remote.csb (unknown [10.64.136.133])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A8F9A1953BBB;
	Thu,  8 Aug 2024 04:09:29 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	Jonathan.Cameron@huawei.com,
	salil.mehta@huawei.com,
	shan.gavin@gmail.com
Subject: [PATCH] cpumask: Fix crash on updating CPU enabled mask
Date: Thu,  8 Aug 2024 14:08:08 +1000
Message-ID: <20240808040808.647316-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

The CPU enabled mask instead of the CPU possible mask should be used
by set_cpu_enabled(). Otherwise, we run into crash due to write to
the read-only CPU possible mask when vCPU is hot added on ARM64.

  (qemu) device_add host-arm-cpu,id=cpu1,socket-id=1
  Unable to handle kernel write to read-only memory at virtual address ffff800080fa7190
    :
  Call trace:
    register_cpu+0x1a4/0x2e8
    arch_register_cpu+0x84/0xd8
    acpi_processor_add+0x480/0x5b0
    acpi_bus_attach+0x1c4/0x300
    acpi_dev_for_one_check+0x3c/0x50
    device_for_each_child+0x68/0xc8
    acpi_dev_for_each_child+0x48/0x80
    acpi_bus_attach+0x84/0x300
    acpi_bus_scan+0x74/0x220
    acpi_scan_rescan_bus+0x54/0x88
    acpi_device_hotplug+0x208/0x478
    acpi_hotplug_work_fn+0x2c/0x50
    process_one_work+0x15c/0x3c0
    worker_thread+0x2ec/0x400
    kthread+0x120/0x130
    ret_from_fork+0x10/0x20

Fix it by passing the CPU enabled mask instead of the CPU possible
mask to set_cpu_enabled().

Fixes: 51c4767503d5 ("Merge tag 'bitmap-6.11-rc1' of https://github.com:/norov/linux")
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 include/linux/cpumask.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 801a7e524113..53158de44b83 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -1037,7 +1037,7 @@ void init_cpu_online(const struct cpumask *src);
 	assign_bit(cpumask_check(cpu), cpumask_bits(mask), (val))
 
 #define set_cpu_possible(cpu, possible)	assign_cpu((cpu), &__cpu_possible_mask, (possible))
-#define set_cpu_enabled(cpu, enabled)	assign_cpu((cpu), &__cpu_possible_mask, (enabled))
+#define set_cpu_enabled(cpu, enabled)	assign_cpu((cpu), &__cpu_enabled_mask, (enabled))
 #define set_cpu_present(cpu, present)	assign_cpu((cpu), &__cpu_present_mask, (present))
 #define set_cpu_active(cpu, active)	assign_cpu((cpu), &__cpu_active_mask, (active))
 #define set_cpu_dying(cpu, dying)	assign_cpu((cpu), &__cpu_dying_mask, (dying))
-- 
2.45.2


