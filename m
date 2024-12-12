Return-Path: <linux-kernel+bounces-442730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F269EE0E5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 09:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88F2C168327
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0982A20B7F2;
	Thu, 12 Dec 2024 08:09:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD29B204F96
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 08:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733990960; cv=none; b=O1AoQSIsASaQI1i93Nha6YYBcfRr8F6vumO8fv9Nf5EaTldDUJe1bE+zitZUdW9uEhrmaqaMuNSpEmbXdQ1MsC5rGURSVhVj4Oc1xI2L926jbuydR+XlMlggDmEH/TtZKOuyz7HDz6aKDatsau9uzsruOm4PkTsHu+dLOPKlWwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733990960; c=relaxed/simple;
	bh=E6LdvKY2hZ41K5gteMkurkHJILBEeRiMyScR25JrLiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wh1ROjB4RPHB2vg5muOKpgRFtEsvppOVIgJKOnAnlg4zfiC2Wxoy+qKBYuRllBlSOGqf6Lb0f6OhuNrwChGPXR5n2Kh36J7m1qoLAbHf3XwzQ33GRHPxAhHd2D/430Baib++/7v4DpvcMVqZX1CkVkbTIr83KFyfogOpvLqcnac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC754169E;
	Thu, 12 Dec 2024 00:09:38 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A07C3F5A1;
	Thu, 12 Dec 2024 00:09:09 -0800 (PST)
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
Subject: [PATCH v2 0/2] Remove problematic include in <asm/set_memory.h>
Date: Thu, 12 Dec 2024 08:09:02 +0000
Message-ID: <20241212080904.2089632-1-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series removes an unnecessary and potentially problematic include
of <linux/mm.h> in <asm/set_memory.h>. There is no functional difference
in v2 compared to v1.

v1..v2:
* Squashed include fixups into the last patch removing the include from
  <asm/set_memory.h>. [Borislav's suggestion]
* Moved new include in <asm/smp.h>.  [Borislav's suggestion]

v1: https://lore.kernel.org/all/20241210184610.2080727-1-kevin.brodsky@arm.com/

- Kevin

Cc: bp@alien8.de
Cc: dan.j.williams@intel.com
Cc: dave.hansen@linux.intel.com
Cc: david@redhat.com
Cc: jane.chu@oracle.com
Cc: osalvador@suse.de
Cc: tglx@linutronix.de
---
Kevin Brodsky (2):
  x86/mm: Remove unused __set_memory_prot()
  x86/mm: Remove unnecessary include in set_memory.h

 arch/x86/include/asm/set_memory.h       |  2 --
 arch/x86/include/asm/smp.h              |  2 +-
 arch/x86/mm/pat/set_memory.c            | 13 -------------
 drivers/virt/coco/sev-guest/sev-guest.c |  1 +
 4 files changed, 2 insertions(+), 16 deletions(-)


base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
-- 
2.47.0


