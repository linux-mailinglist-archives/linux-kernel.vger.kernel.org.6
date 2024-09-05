Return-Path: <linux-kernel+bounces-316707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F8B96D2F4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E7621F24C94
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E41D19754D;
	Thu,  5 Sep 2024 09:17:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69404C92
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 09:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725527873; cv=none; b=OBuwkeFPya8vCOVTsvtxmBYM8vW3asMBqBedGBPe4MRdtkNEZ29F9seMGvJU9bCa5Ye+9HYxjuSSQFrRT652XaoSDsF8e5vWjAs1ZhO0+ixt1dsSfZLZ93Mmw/CaxqYS6/OyHMOv3obf9YQcj9rNuFqAP2jCjnop49XpqqZnjM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725527873; c=relaxed/simple;
	bh=gnCbAnIpGvYIut1+slkxwkMRCqRMG3aaEFaCrjbGO8I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dDzmf6/WrUmD7OjGo8PgUtP+xMARMtqkZccces9F2XyIYNIvXjA56r5lRVGZNpL71vRu2QPSqvGIj9IJXKDIB8yHuf0vT1TXSc4ACmVJZCggA2ai1HX63M+oWfBDViAhhrZkANVzhv7fJGAWLwn4KfcpzYTkssyNfTuzUxHty6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACAECFEC;
	Thu,  5 Sep 2024 02:18:17 -0700 (PDT)
Received: from e122027.cambridge.arm.com (e122027.cambridge.arm.com [10.1.29.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4588B3F73F;
	Thu,  5 Sep 2024 02:17:49 -0700 (PDT)
From: Steven Price <steven.price@arm.com>
To: Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Steven Price <steven.price@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 0/2] irqchip/gic-v3-its: Mark ITS tables as decrypted
Date: Thu,  5 Sep 2024 10:17:36 +0100
Message-Id: <20240905091738.28544-1-steven.price@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These two patches are taken from the larger series to support running
Linux as a realm guest in CCA[1]. They add support to the GIC for
allocating the ITS pages such that they are decrypted so that the host
can access then for emulation purposes.

Note that there are likely to be future changes to make this more
configurable in the future, as it's possible that in a future
configuration a protected component within the realm could take on the
emulation responsibilities ('Planes support')[2]. But this is a good
building block for the future.

Sorry for the delay in posting this as a separate series!

[1] https://lore.kernel.org/r/20240819131924.372366-1-steven.price%40arm.com
[2] https://lore.kernel.org/r/beff9162-e1ba-4f72-91ea-329eaed48dbc%40arm.com

Steven Price (2):
  irqchip/gic-v3-its: Share ITS tables with a non-trusted hypervisor
  irqchip/gic-v3-its: Rely on genpool alignment

 drivers/irqchip/irq-gic-v3-its.c | 142 +++++++++++++++++++++++++------
 1 file changed, 117 insertions(+), 25 deletions(-)

-- 
2.34.1


