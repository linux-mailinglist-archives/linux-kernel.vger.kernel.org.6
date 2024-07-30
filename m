Return-Path: <linux-kernel+bounces-267720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A52FB9414BA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604F1284992
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FED719EED3;
	Tue, 30 Jul 2024 14:47:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD4F1A2562;
	Tue, 30 Jul 2024 14:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722350878; cv=none; b=JL8LtqbU2x8W5aMOR1u+PgRInLfDv/+8fBSxwuPPYsmZbJULUHiN3/rzd/NKsfNe1dFebBGLzwFAAWh29WuG/u7te7fAahX/KRKxQBbyVyDem8dCs4CtpZ1c4L+/UCAWNaHbBD6Xzc1ysAyUMI9TUhGEtFYOy+rf5bC1P5N/npg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722350878; c=relaxed/simple;
	bh=2sgCmXyTvyCNB45FWIC91IVz4X+itKN3UPLmwF3Xl8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZY1fbJ7z5iGdbztZLVUNmoIznFhE4OKJxIhV3YfZmM0sUs6eqpCWlgbdLl+xvkmsjdouLJrLFMsSbwButAIKWanLGt0TVjgEVBU6e7V2yry5m/XM4gblfyrfGMHfVCj4vULxdSC5UUWd+6AQWbYBJWvTovdQlW94pbVZnrjTtXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 717921007;
	Tue, 30 Jul 2024 07:48:18 -0700 (PDT)
Received: from pluto.guestnet.cambridge.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01B4D3F766;
	Tue, 30 Jul 2024 07:47:49 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com,
	james.quinlan@broadcom.com,
	f.fainelli@gmail.com,
	vincent.guittot@linaro.org,
	etienne.carriere@st.com,
	peng.fan@oss.nxp.com,
	michal.simek@amd.com,
	quic_sibis@quicinc.com,
	quic_nkela@quicinc.com,
	dan.carpenter@linaro.org,
	souvik.chakravarty@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v1 0/6] Add SCMI transport descriptors
Date: Tue, 30 Jul 2024 15:47:01 +0100
Message-ID: <20240730144707.1647025-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

this small series is an extended version of this recent, already reviewed,
series [1] posted by Peng to add a new arm,scmi property to describe some
platform-specific SCMI timeout constraints.

On top of that, this adds 2 more properties to describe a couple more
platform-specific transport characteristics.

To minimize conflicts, the whole series is based on top of another recent
series, which represents a rework of the core SCMI stack to split SCMI
transports as standalone drivers. [2]

Thanks,
Cristian

[1]: https://lore.kernel.org/linux-arm-kernel/20240709140957.3171255-1-peng.fan@oss.nxp.com/
[2]: https://lore.kernel.org/linux-arm-kernel/20240730133318.1573765-1-cristian.marussi@arm.com/T/#t

---

Cristian Marussi (5):
  firmware: arm_scmi: Remove const from transport descriptors
  firmware: arm_scmi: Use max-rx-timeout-ms from devicetree
  dt-bindings: firmware: arm,scmi: Introduce more transport properties
  firmware: arm_scmi: Use max_msg and max_msg_size from devicetree
  firmware: arm_scmi: Relocate atomic_threshold to scmi_desc

Peng Fan (1):
  dt-bindings: firmware: arm,scmi: Introduce property max-rx-timeout-ms

 .../bindings/firmware/arm,scmi.yaml           | 22 +++++++++
 drivers/firmware/arm_scmi/common.h            |  9 +++-
 drivers/firmware/arm_scmi/driver.c            | 46 ++++++++++++-------
 .../arm_scmi/scmi_transport_mailbox.c         |  2 +-
 .../firmware/arm_scmi/scmi_transport_optee.c  |  2 +-
 .../firmware/arm_scmi/scmi_transport_smc.c    |  2 +-
 .../firmware/arm_scmi/scmi_transport_virtio.c |  2 +-
 7 files changed, 64 insertions(+), 21 deletions(-)

-- 
2.45.2


