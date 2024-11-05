Return-Path: <linux-kernel+bounces-396339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 837879BCBDC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 12:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35E9E1F24593
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 11:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761FD1D414B;
	Tue,  5 Nov 2024 11:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0BaiiWd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3BA1C07D9
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 11:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730806105; cv=none; b=r4DXWy5SY1JLiAKxY1+6ZiNmQ/bt7I3r2Sp0Zj4bS8Q7SL2CeEK96fsayxdn0IUvVAx2bVdzKO681nstJ5RSfT91CHQyb26K7L6IUQHE9/3iOzlJYWwrxuGh55EIPoiqQGpd9iOuZ6EnwkKW8F6jeDeyUpZ1Py2OoW/9wS1Qg2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730806105; c=relaxed/simple;
	bh=t0ebFl9Qur+HH4lW6ifWESijNaGHWR/cV5VnNhCltKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k1Gli/s9tyQv0svmbBtKAWozFK2n1qRsQGYRV87lms14r9NicWfyPnKiuV4HYNTLbfW/y8r15jgs91gPNrO/9KDdgrCXeG0/+lFs0M/NtooKAcex0ERBcQkmQtIWNxXKu3fZvGppp37WtcA1oMxRXA4TTUOgoGObCUy09IkiU84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F0BaiiWd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730806103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M77VfgZS1cdpIcCG2VhSP2ERRVSFmbayjwOHepEQJsU=;
	b=F0BaiiWdveDfuFEvy6SLNmrCVlOCb861PNcHplC+2ZgC0ClhB4hi0W1wT6HVNmUPZ+VYHa
	F0Sarc+RGocVbKv/VwqNcBbGvh7sl8Dqi4axp9kjwGPeJ2quDm9FdVjCfFVgCu8KSl4EpD
	AUrydnBSBOmW/WvknHiU4V543KvEOrk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-370-WcXZ3ZirOLSC63gP65niGA-1; Tue, 05 Nov 2024 06:28:22 -0500
X-MC-Unique: WcXZ3ZirOLSC63gP65niGA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4315d98a873so31395625e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 03:28:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730806101; x=1731410901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M77VfgZS1cdpIcCG2VhSP2ERRVSFmbayjwOHepEQJsU=;
        b=PLwxobadY4SmTKw40fgB2CXXQ3bGW2uFAdw+MTNL/ux2L/LPpwbeD6wa/zEDnhEj1U
         0qgIq3xPN0ifi0stdU3K6k9NEMCc/Qbn+9hDQhNOp749G5VWO8uV776JwDgrJ0HMTy4m
         0aFS5lBRXE9I3Y5ZrvkQdwqLBupJ2N+UosXFrlD3mWzckM5YgFJBxyz4n5nvXBjTWSqW
         SvUP25UWFB1WtG6zj3AxmmHAGeZ706sBE3XkqmPMTcbEYrli9+cpHg3yzEv+42bNdTCY
         c9yfo3SFR1eb9h34wjK03mBpkyrtH5XCZ8npdEa8Iy+OCvEe0uGP6mpqM5hOeCDyFGVo
         GkYQ==
X-Gm-Message-State: AOJu0Yyq2B6gVGy4DuDVR3zjxIvZ0Ur/vQMDnK5g51Oz0BX4/NCgYzLp
	as2iE2PhriyqerWrwsdc7Ti/hUbcALIKpLLvfCCBXNk66PcruFdabTL48A7QNJ14/6bCMqjWFP3
	VV6a2G9Kp+LsMX++26ieC+1CQeZIJHUOBAiEqhQmT6JbZAcu1Jf6ZS2xolmHT1g==
X-Received: by 2002:a05:600c:3b88:b0:431:5e53:2dc4 with SMTP id 5b1f17b1804b1-431bb976d14mr189868695e9.6.1730806099745;
        Tue, 05 Nov 2024 03:28:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHawKmUXX8F/rNdY2rYv3lZFA9RQ8JlajR/gpDDH3mHry8G7Y1Jk2S6G5jfQ0Rri5nUyM/7FA==
X-Received: by 2002:a05:600c:3b88:b0:431:5e53:2dc4 with SMTP id 5b1f17b1804b1-431bb976d14mr189868445e9.6.1730806099364;
        Tue, 05 Nov 2024 03:28:19 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d40d5sm15785511f8f.25.2024.11.05.03.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 03:28:18 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Andy Shevchenko <andy@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH] x86/platform/intel-mid: Replace deprecated PCI functions
Date: Tue,  5 Nov 2024 12:25:22 +0100
Message-ID: <20241105112521.58638-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_table() and pcim_request_regions() have been deprecated in
commit e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
pcim_iomap_regions_request_all()") and commit d140f80f60358 ("PCI:
Deprecate pcim_iomap_regions() in favor of pcim_iomap_region()"),
respectively.

Replace these functions with pcim_iomap_region().

Additionally, pass the actual driver name to pcim_iomap_region()
instead of the previous pci_name(), since the 'name' parameter should
always reflect which driver owns a region.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 arch/x86/platform/intel-mid/pwr.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/x86/platform/intel-mid/pwr.c b/arch/x86/platform/intel-mid/pwr.c
index 27288d8d3f71..96fe7bf60ca0 100644
--- a/arch/x86/platform/intel-mid/pwr.c
+++ b/arch/x86/platform/intel-mid/pwr.c
@@ -358,18 +358,15 @@ static int mid_pwr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return ret;
 	}
 
-	ret = pcim_iomap_regions(pdev, 1 << 0, pci_name(pdev));
-	if (ret) {
-		dev_err(&pdev->dev, "I/O memory remapping failed\n");
-		return ret;
-	}
-
 	pwr = devm_kzalloc(dev, sizeof(*pwr), GFP_KERNEL);
 	if (!pwr)
 		return -ENOMEM;
 
+	pwr->regs = pcim_iomap_region(pdev, 0, "intel_mid_pwr");
+	if (IS_ERR(pwr->regs))
+		return PTR_ERR(pwr->regs);
+
 	pwr->dev = dev;
-	pwr->regs = pcim_iomap_table(pdev)[0];
 	pwr->irq = pdev->irq;
 
 	mutex_init(&pwr->lock);
-- 
2.47.0


