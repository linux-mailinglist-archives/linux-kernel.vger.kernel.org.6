Return-Path: <linux-kernel+bounces-363897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CFB99C832
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 13:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20783B26A2B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E0F1D5AD8;
	Mon, 14 Oct 2024 11:02:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EAD19E7F9
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728903721; cv=none; b=AoY7w7iRdNSnj/keGJlImPZE3PdC5tdy+6vM60mxZH+vxKFfwMO2IrKC+g9gLvx8eV3L8QGb067VE3WHl4j+Wis2MmEJNZbAE/+LQFFOqQie9IMHWs0gNSEVh65R5tx/CEkeMyrf0EDYmOo8xFKeBqo3MtOtlHorR3f5R2d5PQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728903721; c=relaxed/simple;
	bh=rZJg017nt4htXjkCFuzwuk8tBwQ3ejv4vX3jpdMs5FY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j5B15fX53kdrLCA9Z1APabyC7WzBNuksbyJZpXsuQrYiaHJqhpVe3XO6slMpsmLcJ+CxUzYND8qEPao+fOBLOPRjzeKEJGneiIYZNUjHjYdZkhOGh1C8qwp5fWSTh6AhF9HOmKJ1sOlU/AhMwBCuCfHDhH3S9eCUSzeB2zAXRnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0495C1A00;
	Mon, 14 Oct 2024 04:02:29 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0154B3F51B;
	Mon, 14 Oct 2024 04:01:56 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>,
	Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Miroslav Benes <mbenes@suse.cz>,
	Will Deacon <will@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 50/57] arm64: Remove PAGE_SZ asm-offset
Date: Mon, 14 Oct 2024 11:58:57 +0100
Message-ID: <20241014105912.3207374-50-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014105912.3207374-1-ryan.roberts@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PAGE_SZ is not used anywhere and for boot-time builds, where it is not a
compile-time constant, we don't know the value anyway. So let's remove
it.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---

***NOTE***
Any confused maintainers may want to read the cover note here for context:
https://lore.kernel.org/all/20241014105514.3206191-1-ryan.roberts@arm.com/

 arch/arm64/kernel/asm-offsets.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 27de1dddb0abe..f32b8d7f00b2a 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -111,8 +111,6 @@ int main(void)
   BLANK();
   DEFINE(VM_EXEC,	       	VM_EXEC);
   BLANK();
-  DEFINE(PAGE_SZ,	       	PAGE_SIZE);
-  BLANK();
   DEFINE(DMA_TO_DEVICE,		DMA_TO_DEVICE);
   DEFINE(DMA_FROM_DEVICE,	DMA_FROM_DEVICE);
   BLANK();
-- 
2.43.0


