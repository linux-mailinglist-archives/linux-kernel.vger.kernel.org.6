Return-Path: <linux-kernel+bounces-330686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEC497A2BA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 15:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF76C1F2345C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 13:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28198155741;
	Mon, 16 Sep 2024 13:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCbgFqNR"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FB21804E
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726492110; cv=none; b=r/ah1D11yKXBRmc3w/Tl2G0veZ2TLG4rv7prqSAtSceRoOftiFS3RqLevbc720XDBIewuthZbdDHYybOd9TiynIWa1NFUiWaB/KLC5GgvZd2wAX3kg64ja80cONW33ebD94o0184bDtC42nhjUOcCB/LlJcARkdzDwj1Y7308EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726492110; c=relaxed/simple;
	bh=TQ3OOR440NXTrcNorfraG8EdQ7Z2Iua+zNSetIl8ZmQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gXeIIpSXQHZuL1uOYxJIpKdsVsDHjJ/YcwmLBhNTFZVP7F45zpXMrGiHUhIRnKCv0aB2TUWdR0Bi0VDqo6Gbxc/j0k1R8uHu8Ih6VPzJ9VKd2iRpX2c68khVvUAez3LV9onra3a7CQfBgeucXeOAvC8rsWXdJ44cxj8BYeUHU+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCbgFqNR; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-374b9761eecso3634918f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 06:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726492107; x=1727096907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=eCpY+RqHdT2qkSitoJN+8KgP2pDW7OwmCvIJRkH69uM=;
        b=OCbgFqNR7FqzrQiscWPg02u5ULuKfVJGjdl8rwj+ZpVb6MF1dikNlPEE24Pa0AIPUu
         64F/j6QxOVB8X2W784J/N+W++1GdDvdewrgyPWrrsQKO7FY5g0dTjJKYHjU29rRMJuBj
         ucifawZ+Pni/sMcLmFXgv5DHfAJtNGnAAbbYoh/2WzEFGNDICKRWy+27l6UI0cttdROS
         AxJItB+MPqMyeyStp6Wr0YKgMtlAiGjGqqdhjjRoyzj4Cki8lG/uZuDNPFuzdVg+5Lu3
         snRN1Zt4hDqJoBCEPYGx4OPd1IwCiUFdFA88BqgCg8ortITdUL53z2bkmv6J2PETjgvW
         uYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726492107; x=1727096907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eCpY+RqHdT2qkSitoJN+8KgP2pDW7OwmCvIJRkH69uM=;
        b=Qr1V5yKEHf+RvLsdhp4xScWbBTvwYJaoBRd7RkHX5MQh6N0XO14gnywSi8MyCXA/qJ
         /BunEgJTDHL3cE/BDb6uQbM1RuzEp/WGnSkhrJNsXdlkiR0CNPkzDvzPo7V7dVUKBUzo
         vT/CCL+TjHn8lwOPnnOrmYqzh2iVFWZ8YowW8R2q+DY2Gbv9WV0H2mc8LrS6xWYvO5YH
         oaApofYX6eEeIKBrtMNg4r9Iw78pSgtFjSFVwU9AWxlFUH1uOvSMZErcjMSBj5wdSRfY
         DTFzPM+jVBPOEHs1UYut10aqhTIPLNM2zIBHgFumUzVk4lSjj6M2O+4Gqk9DUuBdCjyB
         Vmlg==
X-Forwarded-Encrypted: i=1; AJvYcCWKx/DVRHdoZrxaratq5VMU1wunBAHzQWfq+WednqLuMXKdZX3KS/Za/TDcxqeDMdkaNeu0dz77x4Hp/1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1U68G7f2IrPaFdyjfLPCL11b6CX8xDG9SgO+bRK0wxEjZd2WE
	FT5z5J/0jegRnrb7Ep6rBcc7JyNi79K47XZmkWjt3bSV03RPVcMy
X-Google-Smtp-Source: AGHT+IFnEskjiwV8dIOia7DVoqcOvN7T9xrOQL/4+9yd8kHP6cSiznSTyeqViGkXtJ2+cw66ZL7x3A==
X-Received: by 2002:a05:6000:1110:b0:374:b31e:3b3b with SMTP id ffacd0b85a97d-378c2cd41dcmr7823098f8f.1.1726492106834;
        Mon, 16 Sep 2024 06:08:26 -0700 (PDT)
Received: from wheatley.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e72e4cf7sm7188505f8f.11.2024.09.16.06.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 06:08:26 -0700 (PDT)
Received: from wheatley.brq.redhat.com (wheatley.k8r.cz [127.0.0.1])
	by wheatley.localdomain (Postfix) with ESMTP id DD0EA24B44F8;
	Mon, 16 Sep 2024 15:08:25 +0200 (CEST)
From: Martin Kletzander <nert.pinx@gmail.com>
To: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] x86/resctrl: Avoid overflow in MB settings in bw_validate()
Date: Mon, 16 Sep 2024 15:07:39 +0200
Message-ID: <1723949d8053aa74da907165dbdc26755f341736.1726492059.git.nert.pinx@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When resctrl is mounted with the "mba_MBps" option the default (maximum)
bandwidth is the maximum unsigned value for the type.  However when
using the same value that already exists in the schemata file it is then
rounded up to the bandwidth granularity and overflows to a small number
instead, making it difficult to reset memory bandwidth allocation value
back to its default.

Since the granularity and minimum bandwidth are not used when the
software controller is used (resctrl is mounted with the "mba_MBps"),
skip the rounding up as well and return early from bw_validate().

Signed-off-by: Martin Kletzander <nert.pinx@gmail.com>
---
Changes in v2:
 - actually save the value in the output parameter @data

 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 50fa1fe9a073..702b1a372e9c 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -48,8 +48,13 @@ static bool bw_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 		return false;
 	}
 
-	if ((bw < r->membw.min_bw || bw > r->default_ctrl) &&
-	    !is_mba_sc(r)) {
+	/* Nothing else to do if software controller is enabled */
+	if (is_mba_sc(r)) {
+		*data = bw;
+		return true;
+	}
+
+	if (bw < r->membw.min_bw || bw > r->default_ctrl) {
 		rdt_last_cmd_printf("MB value %ld out of range [%d,%d]\n", bw,
 				    r->membw.min_bw, r->default_ctrl);
 		return false;
-- 
2.46.0


