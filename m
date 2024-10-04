Return-Path: <linux-kernel+bounces-351453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BC2991168
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 23:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D97631C2377E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 21:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3091AE015;
	Fri,  4 Oct 2024 21:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="IDfNB8Cn"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A8B1AE00C
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 21:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728077114; cv=none; b=a9/2nMHIdeiBO9JQvLziGTZwoMqPDIZjo/D1fJmay5uPuwtn/4cofrv8zSl0G00EmZyJ6IsdQgv1+aBUJhplqL0LmU4yFKROhgapD28cMxOBSYsLuvs9PlkvpIxT6+XBZ6/WwnDIq3039xtcrwcm10VTXAthvsa9UtBFb1MZQC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728077114; c=relaxed/simple;
	bh=xWcayRwGq99qmIJOCaLa8kUZscX03I82nm2+VL9TA4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gi5g7poRrcbLL2XAsSQsqu+8JntlLYHi9nycygVBJ+9IigZ522fzag5TbGiAuatnfR1G4hBf4/vx08iY+daTtuy5UFoUp/ePNK5AnQm5+QWifHHuOzkFfxAne2OjvMW387rVtAXol/TT7bvM56AfMklVf6pEBCJSaxzu9BEisxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=IDfNB8Cn; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4583209a17dso21100361cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 14:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1728077110; x=1728681910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c38DjANBRpYnTCiRKoh3ao5Dt3VewIRXoROl0i/M6LY=;
        b=IDfNB8CnXupAkFroRP2q1wzwSTjZnGwOxs5OJ2CMFPei+0LK60UK5xQl5DeJ28qB53
         G8tWDUfs/wiWxaqMFTO3P+aYuCp9a70uH/jZf8mhhvWekBwVKMXmB5yREEtPhbSE/en6
         1dmPLkEYqLtGcYy5CLzENqWxmq9ySbtpwXXQazqw5QKEc3Wz59iO0/mqG/Fttl6V2K1p
         igW4Evr8dMaEJS1MiUzR3V7LkFLEcofOcLQhlUr7Ix9M+Wi2JrckyRSr224rjJfPk33i
         AABVzB29U31iuGIriZNnYur+J4GxBfIGRsnMTyE87EVrvH/HMb6zickseshsmJUCLOzU
         TulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728077110; x=1728681910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c38DjANBRpYnTCiRKoh3ao5Dt3VewIRXoROl0i/M6LY=;
        b=J6FJbrkwb4aUrpfpcgL8lX+SmfppiX/qLNU0Pq65wIwT4rpgXmFrNVjKfmDwPSYtuT
         nhGRQ9jEXQgXBUda7I9+D4zZMijgZOvU0CQf1KxEJcjLUxPHbxsmkziR/eSZunvn+Nv3
         JlBfZ04TM7eO3ga+2jv8EJtnxp8dgUTZV3f4gwP9j2KqcuWFrdtrNVg+Pa0WZ6O3n7Oi
         Amnc2N/DSflMehKG9vqIlmcQjG/rL2lciT36nXP/5MpznZprlttONZjNnkEdwwUkPEqB
         axhcJPR2nk3ymCxKgYMUnD1TdJGDSH8Df0UQSk0COlb7ie2A6lF5a/GP7COjpQT5IQP4
         qikg==
X-Gm-Message-State: AOJu0Yzm5rqnFkrJDuid68/Zx0DWNg6OMuBJvl4WFh1YcktsxERFe2H0
	IV+aKq9GEGCtVtmTPHLgjiAmJj0boW4x7MnPwFGXw/Y4IyLErYK8G8oTdanvcEw=
X-Google-Smtp-Source: AGHT+IHiEiOEDSUe+eNwT3Ozk4QbVjqwugZuiizvLvWkgugVkAkEIZArS9gYMMA4Xs2+CzRDpN8KWw==
X-Received: by 2002:ac8:7fcb:0:b0:458:40e9:8d0d with SMTP id d75a77b69052e-45d9bb3a6d9mr71503881cf.58.1728077110093;
        Fri, 04 Oct 2024 14:25:10 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45da74ec504sm2660471cf.23.2024.10.04.14.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 14:25:09 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	dan.j.williams@intel.com,
	Jonathan.Cameron@Huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	rrichter@amd.com,
	terry.bowman@amd.com,
	dave@stgolabs.net
Subject: [PATCH v2] cxl/core/port: defer endpoint probes when ACPI likely hasn't finished
Date: Fri,  4 Oct 2024 17:25:04 -0400
Message-ID: <20241004212504.1246-1-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In cxl_acpi_probe, we add dports and uports to host bridges iteratively:
- bus_for_each_dev(adev->dev.bus, NULL, root_port, add_host_bridge_dport);
- bus_for_each_dev(adev->dev.bus, NULL, root_port, add_host_bridge_uport);

Simultaneously, as ports are probed, memdev endpoints can also be
probed. This creates a race condition, where an endpoint can perceive
its path to the root being broken in devm_cxl_enumerate_ports.

The memdev/endpoint probe will see a heirarchy that may look like:
    mem1
      parent => 0000:c1:00.0
        parent => 0000:c0:01.1
	  parent->parent => NULL

This results in find_cxl_port() returning NULL (since the port hasn't
been associated with the host bridge yet), and add_port_attach_ep
fails because the grandparent's grandparent is NULL.

When the latter condition is detected, the comments suggest:
    /*
     * The iteration reached the topology root without finding the
     * CXL-root 'cxl_port' on a previous iteration, fail for now to
     * be re-probed after platform driver attaches.
     */

This case results in an -ENXIO; however, a re-probe never occurs. Change
this return condition to -EPROBE_DEFER to explicitly cause a reprobe.

(v2: additional debug information)

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 drivers/cxl/core/port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1d5007e3795a..d6bebf70d142 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1553,7 +1553,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 		 */
 		dev_dbg(&cxlmd->dev, "%s is a root dport\n",
 			dev_name(dport_dev));
-		return -ENXIO;
+		return -EPROBE_DEFER;
 	}
 
 	parent_port = find_cxl_port(dparent, &parent_dport);
-- 
2.43.0


