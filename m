Return-Path: <linux-kernel+bounces-347683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A175F98DA97
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F5172834A1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025DE1D0BB1;
	Wed,  2 Oct 2024 14:17:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AFD198A1A
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 14:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878645; cv=none; b=Z/AxvfqKEuyn36Ojf7M3U9QVcDBZF+T4bpVCFwgyV4LTtNqw+PvOEIMpzeR7DGQrYi+jz/nwq/E4WWgYXokE0elWLhzuyRTMa84II0uytWj3elL6rZA4w2XZ5L0R21IDD1+f0q6AjJdQ2wkmm17CSAo9QjU9WrlTjZpz19gsEt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878645; c=relaxed/simple;
	bh=t4FDcwOOZMqi7I6NdJLmjCUcD/nWJCsN4rB1YyaZ/8w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XxciD2cFqlOz43XYpMeTBnB5wrEBl6rGuFuMKlKC4hOYsruDx8Qej19oahxEl0jPVetIbuWDA6gGfkiRCVP8xK0SSlUoyMU3AVFpm5iRNQfkCbSKZW7CM5lWWtIuYOJPyFUt5CZ2dzPI7GV+IPHZYMkbxEhrYM02l23tVrWx5u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 14BE6339;
	Wed,  2 Oct 2024 07:17:53 -0700 (PDT)
Received: from e122027.arm.com (unknown [10.57.64.205])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 927363F58B;
	Wed,  2 Oct 2024 07:17:21 -0700 (PDT)
From: Steven Price <steven.price@arm.com>
To: Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Steven Price <steven.price@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH v2 0/2] irqchip/gic-v3-its: Mark ITS tables as decrypted
Date: Wed,  2 Oct 2024 15:16:28 +0100
Message-Id: <20241002141630.433502-1-steven.price@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These two patches were taken from the larger series to support running
Linux as a realm guest in CCA[1]. They add support to the GIC for
allocating the ITS pages such that they are decrypted so that the host
can access then for emulation purposes.

Note that there are likely to be future changes to make this more
configurable in the future, as it's possible that in a future
configuration a protected component within the realm could take on the
emulation responsibilities ('Planes support')[2]. But this is a good
building block for the future.

[1] https://lore.kernel.org/r/20240819131924.372366-1-steven.price%40arm.com
[2] https://lore.kernel.org/r/beff9162-e1ba-4f72-91ea-329eaed48dbc%40arm.com

Steven Price (2):
  irqchip/gic-v3-its: Share ITS tables with a non-trusted hypervisor
  irqchip/gic-v3-its: Rely on genpool alignment

 drivers/irqchip/irq-gic-v3-its.c | 154 ++++++++++++++++++++++++++-----
 1 file changed, 129 insertions(+), 25 deletions(-)

-- 
2.34.1


