Return-Path: <linux-kernel+bounces-564875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C44B3A65C2A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D73B27AE380
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB2A1DF97C;
	Mon, 17 Mar 2025 18:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Om1uRYGy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF6B1DDC22
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 18:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235260; cv=none; b=JywiPWI4Npc+9XtnQNWhxXf5M8+8cuQRBduwDjKLGZ2CS3DhhjKEEtFcn20OVydwaXg3ZzLtrL6xBmfD+3qaE3gbmVxPBQVaPgOv7Ley/PjKD4aBc6rn6qUJXgFE2XUlwCq/8d8z0AE2tLbZ1PkTZdRwu3N7ETbGEPwx36NrOTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235260; c=relaxed/simple;
	bh=BCS+LAApzPn0VpycoT4cKgO+h8D+U5JWJTPAWhH9ZmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EojospHZU+5NDbg2uSP1OjSmQ3eQe5i7MSzBKFqd+x0fo1Lc8fthJACbyaPMpctGjqVy52D3ygLsO+vViELj3SjeWkWdB6g6tZ9JMBM4BgaN61X2wMTNKpo4qNAuytP0oGvho8y43AtfYX/9PHgKvpYZi4pt35oThgeOi4Y5eos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Om1uRYGy; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742235259; x=1773771259;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BCS+LAApzPn0VpycoT4cKgO+h8D+U5JWJTPAWhH9ZmU=;
  b=Om1uRYGyFi+yTjplIplq3a2sezHbEedZJMFXj7dUXyPl4FRMHilaxD2d
   Mt49+AuoCI1Z4iv8CHkVsXBsY/kvhLe+eKSoOs0Cx1isQOQbJZvoAR4Un
   MOT+IaXbJ4xLgY0aiWhO1wnfFREbJmqVNHYw3oH38g7K59uhoGJmkWAHw
   wyXyEciVTYfKrJtgTgRlP+bYR8fufvLRdzOLCyg6umK9tg5Fo1coOaQ0C
   ZvjNp1xZ7gl9HpnebS5oBum6yREyytDYWAz/sJ3C41eqFAWQ5Jvi4fLRW
   zpQ0ry04Mkx6TO8NoQu5omK0+aubxCZesYJnP11Mh5giBWQRErMloNuuA
   Q==;
X-CSE-ConnectionGUID: CsnnmFo/R4mdz3mh1mOVWw==
X-CSE-MsgGUID: DZnl3SpWRue2HHivnvOojw==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="53972040"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="53972040"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 11:14:17 -0700
X-CSE-ConnectionGUID: 8HHXcig6QG6YeotNZx6L/Q==
X-CSE-MsgGUID: 0YT96iZaSUyIzbxn0Kft5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="122512766"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 17 Mar 2025 11:14:15 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 302F64FD; Mon, 17 Mar 2025 20:14:14 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 3/4] resource: Replace open coded variants of DEFINE_RES_*_NAMED()
Date: Mon, 17 Mar 2025 20:11:12 +0200
Message-ID: <20250317181412.1560630-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250317181412.1560630-1-andriy.shevchenko@linux.intel.com>
References: <20250317181412.1560630-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace open coded variants of DEFINE_RES_*_NAMED().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 kernel/resource.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index dc9031267942..a30a32b47e0e 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1728,18 +1728,13 @@ static int __init reserve_setup(char *str)
 			 * I/O port space; otherwise assume it's memory.
 			 */
 			if (io_start < 0x10000) {
-				res->flags = IORESOURCE_IO;
+				*res = DEFINE_RES_IO_NAMED(io_start, io_num, "reserved");
 				parent = &ioport_resource;
 			} else {
-				res->flags = IORESOURCE_MEM;
+				*res = DEFINE_RES_MEM_NAMED(io_start, io_num, "reserved");
 				parent = &iomem_resource;
 			}
-			res->name = "reserved";
-			res->start = io_start;
-			res->end = io_start + io_num - 1;
 			res->flags |= IORESOURCE_BUSY;
-			res->desc = IORES_DESC_NONE;
-			res->child = NULL;
 			if (request_resource(parent, res) == 0)
 				reserved = x+1;
 		}
-- 
2.47.2


