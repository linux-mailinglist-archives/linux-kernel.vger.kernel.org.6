Return-Path: <linux-kernel+bounces-511063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93447A32548
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 199371888537
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C820620B20B;
	Wed, 12 Feb 2025 11:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AE2wbHoa"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156C920AF85
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739360955; cv=none; b=iiLl4HLeinDHNiRyPDXVXBzBoVQn+diZELdP3aPIec6LGbZb2b3jZm/sIG/c4EfJGQoqMM5VTKxJMu3aJb/X9V6xTT7z8RlwVDuCiUu/+/Rejws+9ppMDjcIAbEfYoCHuPMJVFU05pln8DCIoPGiuzhPVQCAR1RCYV5vZyfUipc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739360955; c=relaxed/simple;
	bh=07JmhWhvRFk0Z4sL6DT/erCBtB7AIf1na4MQ8CeTDVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bI4OGGHn7L01oJcoQDNwzl3605OQdtqaxCsvAskIipUIw1+pqscJgR/gpmQbCg48f77/56DWamfPj5RhKl8EkkVGz3WdzjvJFB/9MXAedukX36VdGkp3z9L6kCUyY+RUQo8qKMCT6UemJgtNZ00oVq8k7tJChyjE2QowSAmj30o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AE2wbHoa; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739360951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LjbJlf27aNWCQLb/rfsm7XEzIVE0DW2f53O2KyRIXj8=;
	b=AE2wbHoa4bcRa5aiXRxQblc1bEl/Ym74nWNSWLyjFlW7K1Vr8x8IorNS8FxKziKAMFGZD1
	68DFVwjc96iK4VqRsbU9UBOiA2n/RpnJK8pLnfB+1befafbyJ8Kvv1QPGFJrykFB6DKuqe
	jjw9ofvUbaEqSi/jbtMeQC2IK29ORRo=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Amit Shah <amit@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] virtio: console: Use str_yes_no() helper in port_debugfs_show()
Date: Wed, 12 Feb 2025 12:48:41 +0100
Message-ID: <20250212114841.74650-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_yes_no() helper function.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/char/virtio_console.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 24442485e73e..35af0cc11d93 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -26,6 +26,7 @@
 #include <linux/workqueue.h>
 #include <linux/module.h>
 #include <linux/dma-mapping.h>
+#include <linux/string_choices.h>
 #include "../tty/hvc/hvc_console.h"
 
 #define is_rproc_enabled IS_ENABLED(CONFIG_REMOTEPROC)
@@ -1269,8 +1270,7 @@ static int port_debugfs_show(struct seq_file *s, void *data)
 	seq_printf(s, "bytes_sent: %lu\n", port->stats.bytes_sent);
 	seq_printf(s, "bytes_received: %lu\n", port->stats.bytes_received);
 	seq_printf(s, "bytes_discarded: %lu\n", port->stats.bytes_discarded);
-	seq_printf(s, "is_console: %s\n",
-		   is_console_port(port) ? "yes" : "no");
+	seq_printf(s, "is_console: %s\n", str_yes_no(is_console_port(port)));
 	seq_printf(s, "console_vtermno: %u\n", port->cons.vtermno);
 
 	return 0;
-- 
2.48.1


