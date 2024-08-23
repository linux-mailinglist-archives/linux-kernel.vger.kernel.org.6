Return-Path: <linux-kernel+bounces-298319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E33F195C5B2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0D57284DC0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 06:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090BB1311B6;
	Fri, 23 Aug 2024 06:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dbKcG04Q"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD836F2FA
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 06:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724395359; cv=none; b=eAcdpfhvJPWtqSV1scwmfPUFTVqn1+1wLfY32oWacdncCwRZSEyhJW9wmfqsqFThlC/c2Ae6rI5NSlz5eq6YYio8nP5baGnUgyzyTQBHvnlcjED3gSrqnmxAVGudpkkMEquLPt68egG3z3zwCnM2SszdU7+IU5qV/570kd9sc9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724395359; c=relaxed/simple;
	bh=yVNfu84EOxuzzuoQ2VwUQE90IUgDLNFPqhVINJQyukI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p7Aa3fUruflEzYfqFHixz76v6NCnh2/eHhbWp3SZNrAHcP4cMGGm+7jC+JZnqdNdcAuSdTa48rqIHHtC4+Hskwsrd5rZQqCg8p8oB2c45Ah0v5LZ14xRLLMeWjA2acvkLhG9kBpbx6P2npkgL4cmPRLwzDLwS8TGbNG0VneD9d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dbKcG04Q; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724395355;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fztTFMHOTuuVHt0EpFZOv5Pj1CpwyvhoqX1UCRkwwK4=;
	b=dbKcG04Q9jZNEy/JLcGY9yEzgdwpNxF/BCuGVTEVeJ9MGAwjP74zJoG/mZECdVAnxy3kwf
	Ng1fK3htpzenyC3iBNQ/PGNwJ8KOSqWdaDj4GI49kPAT4HYszI35pCOH7Hq9JIIFB98CKU
	72XSaQrEIDoN5+dhMijWmM7E0b8mLqA=
From: Kunwu Chan <kunwu.chan@linux.dev>
To: linux@armlinux.org.uk,
	krzk@kernel.org,
	andi.shyti@kernel.org,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org,
	gregkh@linuxfoundation.org,
	suzuki.poulose@arm.com,
	rmk+kernel@armlinux.org.uk
Cc: linux-kernel@vger.kernel.org,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH] amba: make amba_bustype constant
Date: Fri, 23 Aug 2024 14:42:03 +0800
Message-ID: <20240823064203.119284-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Kunwu Chan <chentao@kylinos.cn>

Since commit d492cc2573a0 ("driver core: device.h: make struct
bus_type a const *"), the driver core can properly handle constant
struct bus_type, move the amba_bustype variable to be a constant
structure as well, placing it into read-only memory which can not be
modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 drivers/amba/bus.c       | 2 +-
 include/linux/amba/bus.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index 34bc880ca20b..0230c43377c1 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -435,7 +435,7 @@ static const struct dev_pm_ops amba_pm = {
  * DMA configuration for platform and AMBA bus is same. So here we reuse
  * platform's DMA config routine.
  */
-struct bus_type amba_bustype = {
+const struct bus_type amba_bustype = {
 	.name		= "amba",
 	.dev_groups	= amba_dev_groups,
 	.match		= amba_match,
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index 958a55bcc708..dda2f3ea89cb 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -105,7 +105,7 @@ enum amba_vendor {
 	AMBA_VENDOR_LSI = 0xb6,
 };
 
-extern struct bus_type amba_bustype;
+extern const struct bus_type amba_bustype;
 
 #define to_amba_device(d)	container_of_const(d, struct amba_device, dev)
 
-- 
2.41.0


