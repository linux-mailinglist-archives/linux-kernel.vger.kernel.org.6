Return-Path: <linux-kernel+bounces-192070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D56738D1800
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8975F1F26369
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA8017E8F4;
	Tue, 28 May 2024 10:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="SsYsZ3Kl"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787DB1E4A9
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 10:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716890608; cv=none; b=Wpa14sgmDK0dGLCFfo/v/VM0roB+eeBsWHLy29S4HhOPavACb4RXPovfT5YdrNRLBQIqVm7gRFC4IaQrOWaFT9wItMiM3czCe+GWl+pQ3Wne614H0C2W1jpwNUfoVguPELoiXV7IJ00PvHJpe3SkyIp64o+4PNM4sCUaG0LD8Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716890608; c=relaxed/simple;
	bh=3ZQs+XnucPl5n5LBoNVNaoK/IFXx+wgEWwOilSxoEcc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KfDR6DFgUrF8l6hKWc+a51iLrkd2ZVb1r3UkKPImK+zek4+a69k+FEqCueIBM0xF4vYQ/dqu2TuBXs842dTsDqnQeaNkYtNR2nU6NfDkzGEwsqj8s6OjaLigcKDtEDbFe6NSkHzjNY44WTZPMzo/zx8asfAqdfMWIKMpwcsQbFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=SsYsZ3Kl; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7B2D73FE4E
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 10:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1716890603;
	bh=6WRU7oiqAgX1SgryE9dbJiu4Oq2IxMJRrC30Dv4YbFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=SsYsZ3KlJNfupE3HEdc4LOe+Ll8lYT/uqAvY/VYJ7UqGyZpclki4yMMijtAx9HxtR
	 ZbR3K5kJQsfHbGJSL/jNb7Vf44nwsovVVfAXbWRoHLDOG6O9j9G1CB4B3L/XBYFla4
	 m/Ooe/jmzcm4RIYvv+0n8yB8qe30mDiYx/mvzBQZPBabd4iDH9/Ip9bIZB9yWJ+FIk
	 B5WCzGeWB84Ebll3+AE80b0Us3Ize95XvzswMH2yTmcT5geeifKgMHjZXB7gESALl/
	 HFIFUkLJyHgB2ZAbzfNYM56NSa+rNeUXjDD+mYyYMDTYihDups6KJFk26GYoGa9Wj/
	 MI6M91N0zvbfA==
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-66957d4e293so572655a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 03:03:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716890601; x=1717495401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6WRU7oiqAgX1SgryE9dbJiu4Oq2IxMJRrC30Dv4YbFE=;
        b=jqYDQZKlzrSRAIaV3F4hTGZicU6Pgixjo5Wt832JeNf6fbiFp8xBbrMIPqPPURviLR
         kQpfmAPKhI8FxODskoXhQAn+hWg/RYiTU4QKe7Zmq5fJCBf+F+sv+jnfLnixD9De43Dp
         wnSefJv4ZEF7wYrWux5QurviwB1iX6nePoGFYYpihCqs4wGnkozerCbBSKiy47/R1Vrx
         cgdCyYDmaPtpjOnpazOk3yQssGqzmwvF1b5CkOuwH3r9pvFi0c3W8FaU71Ba/Z83bDzf
         zoxYutQcyiLmhr00F/EAlvINVqBx0C9CKH2ZRSAZEK9ricSYxiaTSIR84CpJqdeCWffZ
         Hxfg==
X-Forwarded-Encrypted: i=1; AJvYcCUu+sfuieIXSqelyut1LO7scruMpbygivsm+1YEhmsWuT81IZQpO8mg/NJD888TCZTVPcpdMlwyThLg8V+XYFNsXliDZ9JhsJ7zHxsA
X-Gm-Message-State: AOJu0YwCjmxcsmmIYtrXnA9/aoYrd0e1fAXWB6WTru2XiE1x3nzXtfIu
	n8TlkdZ46cUnHmCwn2PR2hiu7owJ9nxt781pUNmJuJV/O9QL9RHDkImtVx9PgTbVOdG6fJ/5qLY
	k4/JcRvIvlGtu90Wl4rTq2vBqlwaLGtWGl9OIPu0LgWEtyu/hop+QJhQl1rxaSHtJ1M6rljZ/EV
	js+A==
X-Received: by 2002:a17:902:c40e:b0:1ea:26bf:928 with SMTP id d9443c01a7336-1f4497d4f41mr127749175ad.50.1716890601664;
        Tue, 28 May 2024 03:03:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFr7mQdxwJ5uObWTqJnfBsmGsiLDRd7S61bF/cj5zmUV790lNuVg+GUHeIftezcSrwY30vjCQ==
X-Received: by 2002:a17:902:c40e:b0:1ea:26bf:928 with SMTP id d9443c01a7336-1f4497d4f41mr127748755ad.50.1716890601069;
        Tue, 28 May 2024 03:03:21 -0700 (PDT)
Received: from rickywu0421-ThinkPad-X1-Carbon-Gen-11.. ([150.116.44.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c96ccfasm76871095ad.147.2024.05.28.03.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 03:03:20 -0700 (PDT)
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
	en-wei.wu@canonical.com
Subject: [PATCH] ice: irdma hardware init failed after suspend/resume
Date: Tue, 28 May 2024 18:03:15 +0800
Message-ID: <20240528100315.24290-1-en-wei.wu@canonical.com>
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
irdma if we've dynamically allocated them). On Resume, we call
ice_init_rdma() to rebuild the ice_pf->msix_entries (and allocate the
MSI-X vectors if we would like to dynamically allocate them).

Signed-off-by: Ricky Wu <en-wei.wu@canonical.com>
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


