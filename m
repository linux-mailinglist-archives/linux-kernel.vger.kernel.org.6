Return-Path: <linux-kernel+bounces-322824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B02972F54
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA6D5B26523
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60B018C002;
	Tue, 10 Sep 2024 09:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dg+Eh4+q"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033E646444
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961816; cv=none; b=OOQQBpBgO2CK0a9k+E0bvTURU1BfqN/8eQS/K4CLzFLPLC3U5M/6LHIv5tA/Tdq2GFFyBC9A+Hb/WYJRf2lObqWrhJCM+rgxZu6qZ49UrPUADSCdcdizyqRSd2IhkpRMWH2cC/MjLhxCdINykDrPgj7BDDagnqQhiDSrhO+8F44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961816; c=relaxed/simple;
	bh=6ibsCnnRsJh4fCYwYKcxiPsewwgIOHrtxRq2aJJZucY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rNRi7JKORZ8OSA8WWiTCPMcFRO/a4oI7n2xzexEvV2kVAZAteQi0IzHpBMlsFn8igig9VG6w5dtSPyNdptEoeME3xldrkw1VtzFtYujBIq+MbhCG6z5H3VI0jDJZNkdK+c1lnJA5o+XIjuiPytFyKRFWpTwKtpElQn+GPfRtTsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dg+Eh4+q; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-718e25d8b67so699026b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 02:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725961814; x=1726566614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YrN4LtIu/GTIDIR2JFgXWyv3VXGQnruCjrp87i9urmM=;
        b=dg+Eh4+qEmbHB0byCWmmI0KvxUCxoVsg48D/fUa9xPJkv1n72XPUxX+jin4GWAEJpH
         8vcbMdvQfzmYQnLT4ecLzey4ZfeQVabRaIEX4UN3sAO4aQukceCasfeFg1Cl4IUj3QSq
         CUvjZLB6+9MnLW3XxNpxpvv/250alsC+arGijluQst04bVPrXVZQZvmVfLHd0eL9pvpq
         E8vBcejTZXKELoSEBJeMpyxM9Q4tgEl49Cf7r1QF2clwDVf2ixS/7vEnKSsv4HkzZkgD
         M0Ce2QZ4XKiMWMcpIYghl8xnSyc7zTp3JVPZvXX+ZnYLiH+/3wn/vQpA2UuSZ8usATGJ
         G+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725961814; x=1726566614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YrN4LtIu/GTIDIR2JFgXWyv3VXGQnruCjrp87i9urmM=;
        b=BYhRLgg5UlveInuii7re+4Sp9w3i4+az+1Br1iShe1gt5iNuV9IJkt7BgvzZsZP7fI
         xx2zmGA32L2XJUqGQOezepzOrA0+dc8R01uWeF+S7T84OBsLQQ/2KqRXmX1MbGuyCyW8
         W5XwGrSaMjuanbIleTDC0iTjaycQOWOZ+OefLpUosmvNa5N9hJvHL5/dLcBXrXCOH2sW
         hN3WmxhfwjI1d4frenP5Ewzv65jjfK24m57Msi5sbin385LT3cSAue+zZQCIyvwFmrEJ
         G6ipxPR68jk1MbkGyf/1tnd3wEVgXOpsRp2PSm8F8kAjJHR7iIKzWjWXfs/2pVhcRxKc
         RV5g==
X-Forwarded-Encrypted: i=1; AJvYcCUuMKfGwD2+phkmNi3AfywNl/sqr/WNQIlzYyGIPr7LG1TVyBd311Fs42HZdxw1C88aHyJZXtIfj0ePHic=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEUdHSzIgBdDEs2CgLpOxK7+RaUX605tL6nrRWpEXcc9AjT4lV
	bpKVYHMr3yZrwmSwuZ7ol+O70LGDBkrVs8q1C+70yntiWotMD9up
X-Google-Smtp-Source: AGHT+IET6iNyaS77CBTpY8dfIkYZhLZp4/Fzf239I6gPNbNi4M059RZ2fGZfWvtN9xONI3XosJW/mQ==
X-Received: by 2002:a05:6a00:b87:b0:710:51e4:51f0 with SMTP id d2e1a72fcca58-718d5f5e710mr7460171b3a.4.1725961813980;
        Tue, 10 Sep 2024 02:50:13 -0700 (PDT)
Received: from localhost ([1.202.249.90])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-71908fe2636sm1034308b3a.60.2024.09.10.02.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 02:50:13 -0700 (PDT)
From: Yihan Xin <xyh1996@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Yihan Xin <xyh1996@gmail.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: Force ns info updates on validation if NID is bogus
Date: Tue, 10 Sep 2024 17:50:06 +0800
Message-ID: <20240910095006.41027-1-xyh1996@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When validating a namespace, nvme_update_ns_info()
would be skipped if nsid changed. However, this
happens everytime the in-use controller is
reattached if NID is bogus, causing nsid not being
restored to the previous one, eg /dev/nvme0n2 ->
/dev/nvme0n1.

Don't skip ns info updates on this circumstance.

Signed-off-by: Yihan Xin <xyh1996@gmail.com>
---
 drivers/nvme/host/core.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1236e3aa00ed..c0875fb93b8d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3979,11 +3979,24 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
 	int ret = NVME_SC_INVALID_NS | NVME_STATUS_DNR;
 
 	if (!nvme_ns_ids_equal(&ns->head->ids, &info->ids)) {
-		dev_err(ns->ctrl->device,
-			"identifiers changed for nsid %d\n", ns->head->ns_id);
-		goto out;
+		/*
+		 * Don't skip ns info updates if the NID is bogus as it
+		 * changes everytime the in-use controller is reattached
+		 * to the bus and thus the namespace is recognized as
+		 * another one.
+		 */
+		if (ns->ctrl->quirks & NVME_QUIRK_BOGUS_NID) {
+			dev_info(ns->ctrl->device,
+				 "Ignoring nsid change for bogus ns\n");
+		} else {
+			dev_err(ns->ctrl->device,
+				"identifiers changed for nsid %d\n",
+				ns->head->ns_id);
+			goto out;
+		}
 	}
 
+
 	ret = nvme_update_ns_info(ns, info);
 out:
 	/*
-- 
2.46.0


