Return-Path: <linux-kernel+bounces-374815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3800B9A709D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED4A0282112
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 17:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA9D1EB9EE;
	Mon, 21 Oct 2024 17:07:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412C61C330C;
	Mon, 21 Oct 2024 17:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729530476; cv=none; b=TrALxRwIsrt7n3UOG4nQpzVGX3c6AsAwKmBkaWhijUZGH0FafMVqaMiJlydfccVCKF5z4rApMPEFdC6nK2HsL3F6CcKCheo8YcUxEE1OswsEO6JP9bTzvr+H8ysYocYyu6RBBmlsJhQE83+/cn8/6Aa5ZkA3MwzYM4QTG5nUGxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729530476; c=relaxed/simple;
	bh=AUqjCS8s+1tQYcFNru8CYi9fDpGqg3e9qTG0dNnZXx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pLPfGAMrWgpyCNs8zIK3VldMS7B9F9E6fBLc8wfCBcwr9i2wVZOWYEBSZn29L6vSCeyPmOx1Kn8D2eYDtVm/zUsDSR+ZIrLQIgAwIDVtftfpJsjED3vUofWofITs60v3Eo06OHEEe4otMZXx0YbCthVsrsCHx8cmz2LtssAoplc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1DAFDA7;
	Mon, 21 Oct 2024 10:08:22 -0700 (PDT)
Received: from pluto.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9EC8E3F528;
	Mon, 21 Oct 2024 10:07:50 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org
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
	Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH v2 0/5] Expose SCMI Transport properties
Date: Mon, 21 Oct 2024 18:07:21 +0100
Message-ID: <20241021170726.2564329-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

SCMI transports are characterized by a number of properties: the values
assumed by some of them tightly depend on the choices taken at design
time and on the overall archiecture of the specific platform: things like
timeouts, maximum message size and number of in-flight messages are closely
tied to the architecture of the platform like number of SCMI agents on the
system, physical memory available to the SCMI server...so on and so forth.

Moreover, since the SCMI specification does not delve into the details
of specific transports, that are, indeed, outside the scope of the
specification itself, such characteristics are NOT even discoverable
at run-time on an SCMI platform.

Currently such properties are simple default values defined at build time,
but the increasing number and variety of platforms using SCMI with a wide
range of designs has increased the need to have a way to describe such
properties across all these platforms.

This series, at first removes a few ambiguities in how some of the current
built-in properties are interpreted, then lays out a way for the core to
propagate back to the transports any possible setting gathered at runtime
from devicetree and finally introduce a pair of new properties used to
describe such per-platform transport characteristics.

Based on v6.12-rc3.

Any feedback welcome.

Thanks,
Cristian

---
v1 --> v2
- added arm, vendor prefix to new DT bindings props
- clarified arm,max-msg bindings meaning
- removed useless warning on advised minimum size on arm,max-msg-size
- fixed maintainers CC list
- removed CCed maintainers from commit log
- using new prefixed arm, props


Cristian Marussi (5):
  firmware: arm_scmi: Account for SHMEM memory overhead
  firmware: arm_scmi: Calculate virtio PDU max size dynamically
  dt-bindings: firmware: arm,scmi: Introduce more transport properties
  firmware: arm_scmi: Use max_msg and max_msg_size devicetree properties
  firmware: arm_scmi: Relocate atomic_threshold to scmi_desc

 .../bindings/firmware/arm,scmi.yaml           | 15 +++++++
 drivers/firmware/arm_scmi/common.h            | 11 ++++-
 drivers/firmware/arm_scmi/driver.c            | 42 +++++++++++--------
 drivers/firmware/arm_scmi/shmem.c             |  7 ++++
 .../firmware/arm_scmi/transports/mailbox.c    |  4 +-
 drivers/firmware/arm_scmi/transports/optee.c  |  2 +-
 drivers/firmware/arm_scmi/transports/smc.c    |  4 +-
 drivers/firmware/arm_scmi/transports/virtio.c | 15 +++----
 8 files changed, 71 insertions(+), 29 deletions(-)

-- 
2.46.1


