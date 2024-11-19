Return-Path: <linux-kernel+bounces-414203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0079A9D24B1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 12:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1EB01F23052
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D51E1C243A;
	Tue, 19 Nov 2024 11:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OueN2wXK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43285198A37
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 11:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732015169; cv=none; b=RKlVoFj9pKlUowYYAXhko+wo8r4LQzf0h+JIpTj5ghZlno8eDlSEws8NxkYXlTXUo6+8LAwxMQRSV7ZTFGePN7Lrn26jEn5nvN4VbvflanDSzZb3tFKDM1lGLL/ue4CeGTV6tKokxqGpyzHfXITgqSM52oRoLByRmgL2OJcM8QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732015169; c=relaxed/simple;
	bh=FTk3to+APvZ2K4SiX8JXEK+u/kjewSu/nPStFnJMHcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YZw97S4D0kkfUQIODHX4AfUPR74D1sZIB/MQQOeeIQJ4Lu/2zmmJDPW5Ezffg+qDLIH1EDC9SdV4MCSWX7vlCqiegy8+cv7xXClzSZE7DKAYOT9jqO62zncMaaEKEbUIEPL0wOVjdyEOQpGd+QjlUT91lTw/V5pF19/HimqPbAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OueN2wXK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732015167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/bbQUZ4g/AMfEyINJryBtDXPUexxWYGnnHWUD7zB68U=;
	b=OueN2wXKTLFfmVZOcoesfeTfcbczOuK9yzTpEQCiHihvrPlYutaT8CS+CbUojrZaO+S9SJ
	BLg79E27Of8vmthgPuFupk2uOjSCQ6dwxHx4vZru0pTp8MLO6NqOq7deKma4jH70e5cpGp
	W7l7NqGyFOScilDX53yF6fq6DUwSFw8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-d5saa3f-P_u85Il7t7FtHQ-1; Tue, 19 Nov 2024 06:19:26 -0500
X-MC-Unique: d5saa3f-P_u85Il7t7FtHQ-1
X-Mimecast-MFC-AGG-ID: d5saa3f-P_u85Il7t7FtHQ
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-432d9b8503cso27823585e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 03:19:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732015165; x=1732619965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/bbQUZ4g/AMfEyINJryBtDXPUexxWYGnnHWUD7zB68U=;
        b=qawenKkZCt9Nm221xyFPTnh655P/ItKbH8OaEURCeJ0aJdrDGQBtCDrnU59TU5p1EV
         gRjTVq4HiOk1dvPWFgrUA5PUxkbH7P44JisEt/kXiqP400L0wJMcLhnPeGanBl/itKgH
         3lziy9iaJM6R+lZGmk4Wk8lXzmnq2aBVRKXyRqFKHBxJPG3j6V007Q0xetT0rcColUcw
         GokeZXWZbFaPYAQ7ShDB0o8IkMuMcbmo8Go+PXzk7lNSzUc9ZubljtZFT3OfGWgNQixF
         Wa2JMvx9uRHiyS6Ba5fl6QD9S/xtRZx7uXqOjVbPwaQsM605dyL1o+RBtoR/IDvuQ627
         23hA==
X-Gm-Message-State: AOJu0YxbKAoI1lBBPgqmJQLA8tVuYapaix6zXd71bGozGXakdpllmcCq
	g6DJe77thhPwoRKY+fzQs5u6RSXGkQn0CDFsw6OUH9nqjuF5qohH4O551yNUbzEgi7KgtYeZDCJ
	sgCKW9IAeGHLWfP0KwYiuoWC30cDhU4o6zvCehBBJFwyKuh4REDufbdh5ge2euSAGnMk93sv+eS
	hF41fDkeyAwsUquh1C8QBPeX4ftzFgNJqmZ/c1KL5jRJRa
X-Received: by 2002:a05:600c:1e23:b0:431:7c25:8600 with SMTP id 5b1f17b1804b1-432f579dfa1mr21216565e9.2.1732015164690;
        Tue, 19 Nov 2024 03:19:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnO+P6Y3L3RleitGgCW2feaObroQXDR14baW5GwWQWlh1l+rapLy0YUc43rfD7/yjVZP99aw==
X-Received: by 2002:a05:600c:1e23:b0:431:7c25:8600 with SMTP id 5b1f17b1804b1-432f579dfa1mr21216255e9.2.1732015164295;
        Tue, 19 Nov 2024 03:19:24 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da2982fasm196865525e9.36.2024.11.19.03.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 03:19:24 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Radu Rendec <rrendec@redhat.com>,
	Zhipeng Wang <zhipeng.wang_1@nxp.com>,
	Maxime Ripard <mripard@kernel.org>,
	javier@dowhile0.org,
	Javier Martinez Canillas <javierm@redhat.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org
Subject: [RFC PATCH] cpufreq: dt-platdev: Fix module autoloading
Date: Tue, 19 Nov 2024 12:18:22 +0100
Message-ID: <20241119111918.1732531-1-javierm@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver can be built as a module since commit 3b062a086984 ("cpufreq:
dt-platdev: Support building as module"), but unfortunately this caused
a regression because the cputfreq-dt-platdev.ko module does not autoload.

Usually, this is solved by just using the MODULE_DEVICE_TABLE() macro to
export all the device IDs as module aliases. But this driver is special
due how matches with devices and decides what platform supports.

There are two of_device_id lists, an allow list that are for CPU devices
that always match and a deny list that's for devices that must not match.

The driver registers a cpufreq-dt platform device for all the CPU device
nodes that either are in the allow list or contain an operating-points-v2
property and are not in the deny list.

For the former just add a MODULE_DEVICE_TABLE(), and for the latter add a
module alias. That way the driver would always be autoloaded when needed.

Reported-by: Radu Rendec <rrendec@redhat.com>
Fixes: 3b062a086984 ("cpufreq: dt-platdev: Support building as module")
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---
Posting as an RFC because I don't have a platform that uses this driver
but I'll let Radu test since he reported by issue.

 drivers/cpufreq/cpufreq-dt-platdev.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 2a3e8bd317c9..7ae7c897c249 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -97,6 +97,7 @@ static const struct of_device_id allowlist[] __initconst = {
 
 	{ }
 };
+MODULE_DEVICE_TABLE(of, allowlist);
 
 /*
  * Machines for which the cpufreq device is *not* created, mostly used for
@@ -236,4 +237,16 @@ static int __init cpufreq_dt_platdev_init(void)
 }
 core_initcall(cpufreq_dt_platdev_init);
 MODULE_DESCRIPTION("Generic DT based cpufreq platdev driver");
+/*
+ * The module alias is needed because the driver automatically registers a
+ * platform device for any CPU device node that has an operating-points-v2
+ * property and is not in the block list.
+ *
+ * For this reason the MODULE_DEVICE_TABLE() macro can only export aliases
+ * of the devices in the allow list, which means that the driver will not
+ * autoload for devices whose cpufreq-dt will be registered automatically.
+ *
+ * Adding an "of:N*T*Coperating-points-v2" alias is a workaround for this.
+ */
+MODULE_ALIAS("of:N*T*Coperating-points-v2");
 MODULE_LICENSE("GPL");
-- 
2.47.0


