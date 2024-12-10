Return-Path: <linux-kernel+bounces-440162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A63C89EB996
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 19:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 974D4284553
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EEC7226196;
	Tue, 10 Dec 2024 18:46:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168B321423F
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 18:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733856390; cv=none; b=fG5SjizLlOm8OFcvr0UsFGVOtdw28TRdLBw063FG+74+82tI9qBCKyykQ0D0BIabYEyYD72TGnKK0kbJgM8bORL81LII0A+ksIGS9p8E3TUjNTdpdM+M2xjrmxkwesD6sFLaCAC3J6pWYIDVjjVJM8rpuwaAPMCvdIv+5+Z30ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733856390; c=relaxed/simple;
	bh=Rb/+N6JWpHDtBCfUQCYpUwBhYVt6N90U8G6DN1hvoqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HpqFk0zOJXjy2b9JxuCvRFQNlDTr+QIuLktq2BEibUUkJ/R3sU3WIlRUliV/+qTw4wZFSYF3v8Is59j2IqBUHDpjJTBgmZCDnu4pnVv4G/hHOLRHQJZgrAExdA+Z5dm+0TcH4nCvoT+eLntw5Mxl5V3RBWNQHIiGOudBHzJuPvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 539BC1570;
	Tue, 10 Dec 2024 10:46:55 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A3863F58B;
	Tue, 10 Dec 2024 10:46:25 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	bp@alien8.de,
	dan.j.williams@intel.com,
	dave.hansen@linux.intel.com,
	david@redhat.com,
	jane.chu@oracle.com,
	osalvador@suse.de,
	tglx@linutronix.de
Subject: [PATCH 2/4] x86/sev: Explicitly include <linux/mm.h>
Date: Tue, 10 Dec 2024 18:46:08 +0000
Message-ID: <20241210184610.2080727-3-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241210184610.2080727-1-kevin.brodsky@arm.com>
References: <20241210184610.2080727-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sev-guest.c relies on <asm/set_memory.h> including <linux/mm.h>,
but that include is about to go away. Explicitly include
<linux/mm.h> not to run into troubles.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index b699771be029..e134bee818fa 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -23,6 +23,7 @@
 #include <linux/cleanup.h>
 #include <linux/uuid.h>
 #include <linux/configfs.h>
+#include <linux/mm.h>
 #include <uapi/linux/sev-guest.h>
 #include <uapi/linux/psp-sev.h>
 
-- 
2.47.0


