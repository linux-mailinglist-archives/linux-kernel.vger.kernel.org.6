Return-Path: <linux-kernel+bounces-256909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CD1937224
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 04:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7812AB21A0A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 02:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFFC1B86D6;
	Fri, 19 Jul 2024 02:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="N5BoJ0QF"
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CDD1B86DD
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 02:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721354404; cv=none; b=p5AmOobJ42D7gkXk5ARPzPoYkEtor8/y9/6aq1WhdlrZAfroB0KbbTU6C1lONpW+qc8fTHdfjHzcs+oxYKwK+569B76T7wmB+FBYwa8Qt/nUGsWCFSuUn5+FYT8eP1K8p01HVmTQY2hhTHwfmVHyxunI3fMJseLa4NqG4X/O9sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721354404; c=relaxed/simple;
	bh=cGDvTByA6KTed0UxScYm3+Rd0JNJ+VCZM7hXObyA1MA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FsLWr16RvUCTSHQ6FkgVvccJcHUVzUBSxonqyvSznyxXMXb0ktvfvwgoQojzFIF5i82zFbIjpBVRo5qNOVQUaUFBU5a8zNMnnh1GEZmv7Q9lijD3GHMpnC36J4YkJA2LObZXG4MVuzeeTKKC1jsGbh80Yt6/9srfFcEREZGuCXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=N5BoJ0QF; arc=none smtp.client-ip=139.138.36.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1721354402; x=1752890402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cGDvTByA6KTed0UxScYm3+Rd0JNJ+VCZM7hXObyA1MA=;
  b=N5BoJ0QFDhC1motQimx80zU8Kg1WXlPYHU8JEE5qH/cXH4SounU4Vwkr
   HEqdor80JzhsuzHSvvjlqNAvi44L6z22cQnk7jxouZloS5ehT9z/Hmi+U
   ACwgx96X+SqCZlhKtzdnVAT6UofNy2YjvIFfhJLIgI8ECoGtP6DefSzbI
   8Onlu/TwaD4GuY+jbYFHTwR6px17Wk6C4OWqjOkPfqcRyRa1WbAl06026
   YJ+bub+o3XNMqk1IgvZL1OPkUD3MCdxHBFUStXBn6HF07JHFDUtPy+0ll
   SBlV46LgN1idMlV3lrWL149cB7Kp2geZr9xjU8d9Ba3CTmDOmRveEisJE
   w==;
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="156106865"
X-IronPort-AV: E=Sophos;i="6.09,219,1716217200"; 
   d="scan'208";a="156106865"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2024 10:58:51 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 221B3C68ED
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 10:58:49 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 6401DD50A6
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 10:58:48 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id F13DE20086E81
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 10:58:47 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 736D31A000C;
	Fri, 19 Jul 2024 09:58:47 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: nvdimm@lists.linux.dev
Cc: dan.j.williams@intel.com,
	vishal.l.verma@intel.com,
	dave.jiang@intel.com,
	ira.weiny@intel.com,
	linux-kernel@vger.kernel.org,
	Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v2 2/2] nvdimm: Remove dead code for ENODEV checking in scan_labels()
Date: Fri, 19 Jul 2024 09:58:36 +0800
Message-Id: <20240719015836.1060677-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240719015836.1060677-1-lizhijian@fujitsu.com>
References: <20240719015836.1060677-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28538.002
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28538.002
X-TMASE-Result: 10--6.042500-10.000000
X-TMASE-MatchedRID: wJuAbHRzrYfH3ZCJRIiNpAXGi/7cli9jG3SoAWcU42VD0XHWdCmZPCXj
	tnu2lwmLkPI1/ZdqoS0pVSN22QMNpsyvuTCA7wzlolVO7uyOCDXBOVz0Jwcxl6vCrG0TnfVUIb5
	NpqK++5qbpZ8QUEHE+lcnoO4Nx+lojejKCMx4rt64u3nS+3EEDpki3iIBA3o/vy9ABIQaa1mjxY
	yRBa/qJcFwgTvxipFa9xS3mVzWUuA4wHSyGpeEeiw2x397pFEmTHLkTUFitAOaKHuLVl3J1P0zo
	l91xrHXEgajmqqPXvQ=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

The only way create_namespace_pmem() returns an ENODEV code is if
select_pmem_id(nd_region, &uuid) returns ENODEV when its 2nd parameter
is a null pointer. However, this is impossible because &uuid is always
valid.

Furthermore, create_namespace_pmem() is the only user of
select_pmem_id(), it's safe to remove the 'return -ENODEV' branch.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2:
  new patch.
  It's found when I'm Reviewing/tracing the return values of create_namespace_pmem()
---
 drivers/nvdimm/namespace_devs.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 28c9afc01dca..21020cd16117 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -1612,9 +1612,6 @@ static int select_pmem_id(struct nd_region *nd_region, const uuid_t *pmem_id)
 {
 	int i;
 
-	if (!pmem_id)
-		return -ENODEV;
-
 	for (i = 0; i < nd_region->ndr_mappings; i++) {
 		struct nd_mapping *nd_mapping = &nd_region->mapping[i];
 		struct nvdimm_drvdata *ndd = to_ndd(nd_mapping);
@@ -1790,9 +1787,6 @@ static struct device *create_namespace_pmem(struct nd_region *nd_region,
 	case -EINVAL:
 		dev_dbg(&nd_region->dev, "invalid label(s)\n");
 		break;
-	case -ENODEV:
-		dev_dbg(&nd_region->dev, "label not found\n");
-		break;
 	default:
 		dev_dbg(&nd_region->dev, "unexpected err: %d\n", rc);
 		break;
@@ -1974,9 +1968,6 @@ static struct device **scan_labels(struct nd_region *nd_region)
 			case -EAGAIN:
 				/* skip invalid labels */
 				continue;
-			case -ENODEV:
-				/* fallthrough to seed creation */
-				break;
 			default:
 				goto err;
 			}
-- 
2.29.2


