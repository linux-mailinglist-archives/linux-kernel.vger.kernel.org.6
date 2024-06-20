Return-Path: <linux-kernel+bounces-222066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 801F890FC61
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 07:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D73C286CDD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 05:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E8B38385;
	Thu, 20 Jun 2024 05:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="pfdeRrN1";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="FmmqvmTN"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6F639FD7
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 05:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718863006; cv=none; b=Ohrqmk3yv6mnuqAurlSEKuIJ83Z6q7YXr0UhiTiq8dVO1qJDNAgKc2OaJK5WoA/vcnSoqwLCZdzZ4sdXlBsIe7fyxZ9Dv5SpH4q6dx2KP2Gn1ahph/thF11cyGurBb6W6Uo1sb1kHd7pkJ5XrG6vF0qc40ORda3/vaLGjPYOGD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718863006; c=relaxed/simple;
	bh=JpGre/SQMB+YKlh6IxbZj6gFT4qKD6FF9cFpcXTWUaE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GG9mC8zUyGzruOzjBejiEyTXcUFsYny2q6IQzGQI9HViAhUCjeD1NcgIfTZa8X4VqhvcnG+q9t43NGTcSnueccTKoyz0ZMwj5QtZKL3LNpGJpL92nInkMZVPUwmVa1yo5oUnyVD1geEk3KjOZZ+6nyeaF/5bmaYfUolKMxNfWLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=pfdeRrN1; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=FmmqvmTN reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1718863002; x=1750399002;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NXOs4yCS8uqg75IyGXnA9UVdnZXJY3hrbimxF27/+LI=;
  b=pfdeRrN1AhYZ9z5mwpHpHf3bQq8WysahfyHvsea7lt+l31F1s9vNPYdW
   EurR3EMC8Bouf7D0sK2ZgZAELia4juDOUGtoLefQuuUeyXe0ND0I/pQjI
   g+akfyrrdK4Ha9DhkoolcYlxE6N7Z+TiXgW5IggOavCN3KKmZZqApXVbC
   F9I+xKpPlYW8w5riyVUcjH5rtfdJgqZOxj+RQBnm/3f3z5FR7OB+YXajL
   zMgnH12w2Wt3CwYkNIOHPVdEtPugx+m5jq3kS/WTg2K1KJEnPHkIUz8MG
   StncUM3ZL7/a+V372L3RniIKvYIFQeFVmJxoJvo/uoe8H2TPnByofiixb
   g==;
X-CSE-ConnectionGUID: 8ruA6ashSgGUXaQicQqFRQ==
X-CSE-MsgGUID: F7IAo7pDReydi8/aAxnETQ==
X-IronPort-AV: E=Sophos;i="6.08,251,1712613600"; 
   d="scan'208";a="37487810"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 20 Jun 2024 07:56:34 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F05E9166E6C;
	Thu, 20 Jun 2024 07:56:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1718862990; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=NXOs4yCS8uqg75IyGXnA9UVdnZXJY3hrbimxF27/+LI=;
	b=FmmqvmTNdiJPa/R6HiKFcv1PzUZxEZGsjTZsp5nBv3Gby674z3GZV6G96XMJRs7Y5WMBmu
	o2OTIN/aqHv+GjF+lUeLQS9qIU1v0ZT/AdPZUXq2ZVS+KFT2xujufc6ss43O4GEReyevZr
	FCcu8FdteM8nxhy7UZ4/V/+C1r52I19FPI6a+uuDqz2a/9CemSvcuRmnYDnH7+ROo77vX3
	T97QB5HXbVBY2KRrHQoDyg/7vpvtzInE6yRs9dpFdA6HulQpGQp5ybJQPwx13i5SIyMFyd
	qkGdrnRcGzVlx0DWWmED6SQvtgokhqi6s+iKJxxc5fOLV1tv3701CYLqD/Xtcg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: 
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] MAINTAINERS: Fix 32-bit i.MX platform paths
Date: Thu, 20 Jun 2024 07:56:31 +0200
Message-Id: <20240620055631.2240151-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The original patch was created way before the .dts movement on arch/arm.
But it was patch merged after the .dts reorganization. Fix the arch/arm
paths accordingly.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Changes in v2:
* Removed Fixes and stable CC tag

 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b4b312d6fc45..e6ebd50b7cc5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22931,9 +22931,9 @@ TQ SYSTEMS BOARD & DRIVER SUPPORT
 L:	linux@ew.tq-group.com
 S:	Supported
 W:	https://www.tq-group.com/en/products/tq-embedded/
-F:	arch/arm/boot/dts/imx*mba*.dts*
-F:	arch/arm/boot/dts/imx*tqma*.dts*
-F:	arch/arm/boot/dts/mba*.dtsi
+F:	arch/arm/boot/dts/nxp/imx/imx*mba*.dts*
+F:	arch/arm/boot/dts/nxp/imx/imx*tqma*.dts*
+F:	arch/arm/boot/dts/nxp/imx/mba*.dtsi
 F:	arch/arm64/boot/dts/freescale/fsl-*tqml*.dts*
 F:	arch/arm64/boot/dts/freescale/imx*mba*.dts*
 F:	arch/arm64/boot/dts/freescale/imx*tqma*.dts*
-- 
2.34.1


