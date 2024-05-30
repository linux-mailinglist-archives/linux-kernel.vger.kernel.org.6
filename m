Return-Path: <linux-kernel+bounces-195505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 812A98D4DBF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 16:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E96201F21B7B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F6E17C20C;
	Thu, 30 May 2024 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="GuxQ7xrz"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A381DA53
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717078911; cv=none; b=oow/tznyX1Z3dY6RWP4NAJ0XWBycpBF0KBTliXd9f52Vt1BSoV2e3tN9bQfVlk/+LwI7dYnxF/fVGqthQvMcDtQGLhpAW/hgG8kBBlJ2IxAKW0IVIwDjE0oL3LoFpaykDduPx2aQgDWcgrJw4rKVbfBquW2ky9MzKroG10/zuok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717078911; c=relaxed/simple;
	bh=RqN47ZM5bKCA/FGdPPZEAuL99IE1ghaZ06QREC2L+nE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VO2Vvhv1PgVbJj/eNxHugMB/Vm9NY2Gj8tB1zyGv0y7iga/CXqEhFfHxchO4UCzia5vUaUAj3jytgDn1JEvbkYaUPbKO01+vKFpxN0zsp7/VNuEUSSC6S76kdeoDUbtUKxF39WUe20RVYY/kY7jRmaz9mwe1nz7Sazmn9OxxdZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=GuxQ7xrz; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 60B2A3F8EB
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 14:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1717078899;
	bh=B2vGdF2dGkt21QsIPszG+5j1gbhrGScywHg+DXLmaj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=GuxQ7xrz1nI0Dvkc8cIa3qufBmJFpGHQwIEark+91R7hevP3vvODWrGeZ6cwY2DQ+
	 rod0ErNiU8L1WSEj8xeDLH3qkCSePSCxfJ4DIQR5mSkMvi9gerA4RKJW+ynnrFxFMO
	 aGYofT4Aoq7UGl4c2kO6ABwnMCvSqw1gW+jDcW7VwwF+kQdHLkh7eA0ixUQEarpdyX
	 tj8lGAQ++ot4yYHmnf+bXme3mNR64KxIPmYoWxHnnXR7J6dQXcCzODPcNbLiJjFE5H
	 zc3b00fUNnShTk60em/T7mB791H0+BDmYyWbw4lPs/VtWvlEnUbJqGE9JhvrxLTJMb
	 ii69fxePczU/w==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1f4f00cff60so9516275ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 07:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717078897; x=1717683697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B2vGdF2dGkt21QsIPszG+5j1gbhrGScywHg+DXLmaj8=;
        b=Hts7Laj1IVHYFYt3GbSke1GlySMV/qaQo8ttpWB4QaOxMVUhHkpwQ09nuvJh8wQDvm
         B6EpGsmewXl+UevkoE3nKjIO8pkaSUfnmroQePMA/9PrTwQ2/fClnmS2cnCbrgyWF6Um
         +cYUEHlXx2BrKnuRXY3F4YwlqtG1k/aOnBVMkbNFKV700dOxcOX8KPXlzwnOFO+XqpPz
         HKFOmMsYwVL41snlZMAeSAU2pl7Nm/vgXA9g2iTU+kbxuIDiRWpLClXiS5k4wTQ/UJwz
         GiS9A1Bm0hFOiuscbiYGH++L9vP0J0YconnNYZ7Cq8SwhBIw1vzbsk4u6VZZYE3YFTEO
         eXzQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6VQxSU9vN0CxYdn+bC9sh0yC7189M0zeZxZQ+l8L4422wL8isFhjWtbUqVVeAHXRxfVcQ0CBH8EPgTOzSTYYohMttLAHKwuepfzFw
X-Gm-Message-State: AOJu0Ywt3c7HaS4APUa9DFUZ1ydOz7wIGyOKxllSFY2+z9OjpmeqpLYW
	jn49gJ92s+jUOv7XavhtqEVBRknwMnX08IiIa04CXRkB6fsgL93vlPynUwjfol9Dx7lxDa/kO2G
	KxN3WAirsneqDXO/64wRJk5BkJmeGD3eo59kPoYImRnc1QRujZiv1OOHqcI3faxTFiNqeKC4D4N
	GI/Q==
X-Received: by 2002:a17:903:234f:b0:1f4:6252:dba9 with SMTP id d9443c01a7336-1f6192ed35bmr21911595ad.9.1717078897717;
        Thu, 30 May 2024 07:21:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj4WhAEo6jH3/j42l91y2guETPciufxMGGZdNuOrkvNj5+sjOxoLTEayUXIdr7icIln7gdog==
X-Received: by 2002:a17:903:234f:b0:1f4:6252:dba9 with SMTP id d9443c01a7336-1f6192ed35bmr21911375ad.9.1717078897341;
        Thu, 30 May 2024 07:21:37 -0700 (PDT)
Received: from rickywu0421-ThinkPad-X1-Carbon-Gen-11.. ([150.116.44.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c967cd2sm118577925ad.166.2024.05.30.07.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 07:21:37 -0700 (PDT)
From: Ricky Wu <en-wei.wu@canonical.com>
To: jesse.brandeburg@intel.com
Cc: anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rickywu0421@gmail.com,
	en-wei.wu@canonical.com,
	wojciech.drewek@intel.com,
	michal.swiatkowski@linux.intel.com,
	pmenzel@molgen.mpg.de,
	Cyrus Lien <cyrus.lien@canonical.com>
Subject: [PATCH net,v2] ice: avoid IRQ collision to fix init failure on ACPI S3 resume
Date: Thu, 30 May 2024 22:21:31 +0800
Message-ID: <20240530142131.26741-1-en-wei.wu@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A bug in https://bugzilla.kernel.org/show_bug.cgi?id=218906 describes
that irdma would break and report hardware initialization failed after
suspend/resume with Intel E810 NIC (tested on 6.9.0-rc5).

The problem is caused due to the collision between the irq numbers
requested in irdma and the irq numbers requested in other drivers
after suspend/resume.

The irq numbers used by irdma are derived from ice's ice_pf->msix_entries
which stores mappings between MSI-X index and Linux interrupt number.
It's supposed to be cleaned up when suspend and rebuilt in resume but
it's not, causing irdma using the old irq numbers stored in the old
ice_pf->msix_entries to request_irq() when resume. And eventually
collide with other drivers.

This patch fixes this problem. On suspend, we call ice_deinit_rdma() to
clean up the ice_pf->msix_entries (and free the MSI-X vectors used by
irdma if we've dynamically allocated them). On resume, we call
ice_init_rdma() to rebuild the ice_pf->msix_entries (and allocate the
MSI-X vectors if we would like to dynamically allocate them).

Fixes: f9f5301e7e2d ("ice: Register auxiliary device to provide RDMA")
Tested-by: Cyrus Lien <cyrus.lien@canonical.com>
Signed-off-by: Ricky Wu <en-wei.wu@canonical.com>
---
Changes in v2:
- Change title
- Add Fixes and Tested-by tags
- Fix typo
---
 drivers/net/ethernet/intel/ice/ice_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index f60c022f7960..ec3cbadaa162 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -5544,7 +5544,7 @@ static int ice_suspend(struct device *dev)
 	 */
 	disabled = ice_service_task_stop(pf);
 
-	ice_unplug_aux_dev(pf);
+	ice_deinit_rdma(pf);
 
 	/* Already suspended?, then there is nothing to do */
 	if (test_and_set_bit(ICE_SUSPENDED, pf->state)) {
@@ -5624,6 +5624,10 @@ static int ice_resume(struct device *dev)
 	if (ret)
 		dev_err(dev, "Cannot restore interrupt scheme: %d\n", ret);
 
+	ret = ice_init_rdma(pf);
+	if (ret)
+		dev_err(dev, "Reinitialize RDMA during resume failed: %d\n", ret);
+
 	clear_bit(ICE_DOWN, pf->state);
 	/* Now perform PF reset and rebuild */
 	reset_type = ICE_RESET_PFR;
-- 
2.43.0


