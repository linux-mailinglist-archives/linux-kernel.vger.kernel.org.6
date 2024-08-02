Return-Path: <linux-kernel+bounces-272712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F449946028
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE39F2853F9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F90166F17;
	Fri,  2 Aug 2024 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zr/R/VDh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34873136321
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722611821; cv=none; b=s+AszMYG0Oknhz52Mux63xSUZ82zJ4D2CcL62dZndTcLdiamoUO9RF93fSfP9tsbUIFElO3Z6Q84En78Sy3HWAf9svWT5Rbn50t9EvTPIBEURz4e7b34HjT+5ALfuUAKjwsxB5ZGQ652/5IycjFOP3C8ajE5DQRgzCCTn6QVnvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722611821; c=relaxed/simple;
	bh=YwTaLLfcFa8ZppYJq5D5kqu8GP2hndoCpgozsutlapg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oB2s2FPamza6PHrVDH3b9fLtT02yU5+mYL/04eEM1gj/8M5LJ+UV7zm8DEDJ/DQZzAHgMloVSSBmZhhEmhd1+rlTG5ABlckFygHijNYQFq4pXOayH+2kOAJ3Kz6l6mBqHcPdX+zJWlDW/QtpRfsfUXWTS+dxvjdnwLFijDDbWck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zr/R/VDh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722611819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g956mcwL4jKSwzWVtdE4m5jBhvk+sHhrxPl5sZLIQU8=;
	b=Zr/R/VDhffQq2R3Rdp2Q6mMRHDRY+jIg3E3/QwoN/vpYQY+boPqkjaaZP2it24PG1fM+db
	C+nU+f0a1KyuQlWBVHs/F//7SsOoIlfEzoN4oJGCREG4lrrq6VMo9zvlCbm9/2n4EWazqF
	HvDURn/2HUGHlB1rxSJcZ9CpCq4L8XY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-127S9fHcPB-rfpz8p1_O-A-1; Fri,
 02 Aug 2024 11:16:53 -0400
X-MC-Unique: 127S9fHcPB-rfpz8p1_O-A-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8BFB01955EAA;
	Fri,  2 Aug 2024 15:16:51 +0000 (UTC)
Received: from llong.com (unknown [10.2.16.79])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4F0521955E80;
	Fri,  2 Aug 2024 15:16:49 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Douglas Anderson <dianders@chromium.org>,
	Petr Mladek <pmladek@suse.com>,
	Li Zhe <lizhe.67@bytedance.com>,
	Joel Granados <j.granados@samsung.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] watchdog: Handle the ENODEV failure case of lockup_detector_delay_init() separately
Date: Fri,  2 Aug 2024 11:16:21 -0400
Message-ID: <20240802151621.617244-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

When watchdog_hardlockup_probe() is being called by
lockup_detector_delay_init(), an error return of -ENODEV will happen
for the arm64 arch when arch_perf_nmi_is_available() returns false. This
means that NMI is not usable by the hard lockup detector and so has to
be disabled. This can be considered a deficiency in that particular
arm64 chip, but there is nothing we can do about it.  That also means
the following error will always be reported when the kernel boot up.

  watchdog: Delayed init of the lockup detector failed: -19

The word "failed" itself has a connotation that there is something
wrong with the kernel which is not really the case here. Handle this
special ENODEV case separately and explain the reason behind disabling
hard lockup detector without causing anxiety for those users who read
the above message and wonder about it.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/watchdog.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 830a83895493..262691ba62b7 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -1203,7 +1203,10 @@ static void __init lockup_detector_delay_init(struct work_struct *work)
 
 	ret = watchdog_hardlockup_probe();
 	if (ret) {
-		pr_info("Delayed init of the lockup detector failed: %d\n", ret);
+		if (ret == -ENODEV)
+			pr_info("NMI not fully supported\n");
+		else
+			pr_info("Delayed init of the lockup detector failed: %d\n", ret);
 		pr_info("Hard watchdog permanently disabled\n");
 		return;
 	}
-- 
2.43.5


