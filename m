Return-Path: <linux-kernel+bounces-438045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 195229E9C21
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A12B28340E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA651547D5;
	Mon,  9 Dec 2024 16:50:32 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90341547F2;
	Mon,  9 Dec 2024 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763032; cv=none; b=P+g5bEX4bQuJ7phtKvWpHiGRtsgS85UmUywzRrk8Vx+Ir7tvfRlGuqRfmHgpQL8HJ2buA4MZwybKHbk3Yb07biMB7/6zvyCu+OpUZjAjmYLY/3rAEoXjVeHTFouxoVuKEuzRIRblp4iOGnwcgLqdI29Pii57Q3FOCvNgAptAIPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763032; c=relaxed/simple;
	bh=wQAJR3PGJ00qhM2mIn9A9yT4Eg8X7acxsZcv4ljCrsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OABl95Rrew1NazhqDnHyhr+zr3awLyH34BqaP0IcLRGGj4Q6nAqpuCRLG7a4zPGq99nk4wUMYEFpaucKy3rjTDz0EcP5NiVZTk1Nbv11yD5BaseRnxgiwDu9ATmg79IRqqiM86R4iypCUVonpmaf5TdJIe9FuD+u2qy5sv+mXoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A07E175D;
	Mon,  9 Dec 2024 08:50:58 -0800 (PST)
Received: from pluto.guest.local (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 965393F720;
	Mon,  9 Dec 2024 08:50:27 -0800 (PST)
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
	dan.carpenter@linaro.org,
	johan+linaro@kernel.org,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v2 3/3] firmware: arm_scmi: Add aliases to transport modules
Date: Mon,  9 Dec 2024 16:49:57 +0000
Message-ID: <20241209164957.1801886-4-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241209164957.1801886-1-cristian.marussi@arm.com>
References: <20241209164957.1801886-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SCMI transports when built as loadable modules should be loaded by the
subsystem they plug into, based on the related subsystem specific aliases.

Add, where missing, the MODULE_DEVICE_TABLE() directives needed to generate
the aliases required to enable autoloading for SCMI transports.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/transports/mailbox.c | 1 +
 drivers/firmware/arm_scmi/transports/smc.c     | 1 +
 drivers/firmware/arm_scmi/transports/virtio.c  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/firmware/arm_scmi/transports/mailbox.c b/drivers/firmware/arm_scmi/transports/mailbox.c
index b66df2981456..bd041c99b92b 100644
--- a/drivers/firmware/arm_scmi/transports/mailbox.c
+++ b/drivers/firmware/arm_scmi/transports/mailbox.c
@@ -378,6 +378,7 @@ static const struct of_device_id scmi_of_match[] = {
 	{ .compatible = "arm,scmi" },
 	{ /* Sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, scmi_of_match);
 
 DEFINE_SCMI_TRANSPORT_DRIVER(scmi_mailbox, scmi_mailbox_driver,
 			     scmi_mailbox_desc, scmi_of_match, core);
diff --git a/drivers/firmware/arm_scmi/transports/smc.c b/drivers/firmware/arm_scmi/transports/smc.c
index f632a62cfb3e..21abb571e4f2 100644
--- a/drivers/firmware/arm_scmi/transports/smc.c
+++ b/drivers/firmware/arm_scmi/transports/smc.c
@@ -301,6 +301,7 @@ static const struct of_device_id scmi_of_match[] = {
 	{ .compatible = "qcom,scmi-smc" },
 	{ /* Sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, scmi_of_match);
 
 DEFINE_SCMI_TRANSPORT_DRIVER(scmi_smc, scmi_smc_driver, scmi_smc_desc,
 			     scmi_of_match, core);
diff --git a/drivers/firmware/arm_scmi/transports/virtio.c b/drivers/firmware/arm_scmi/transports/virtio.c
index 41aea33776a9..cb934db9b2b4 100644
--- a/drivers/firmware/arm_scmi/transports/virtio.c
+++ b/drivers/firmware/arm_scmi/transports/virtio.c
@@ -921,6 +921,7 @@ static const struct virtio_device_id id_table[] = {
 	{ VIRTIO_ID_SCMI, VIRTIO_DEV_ANY_ID },
 	{ 0 }
 };
+MODULE_DEVICE_TABLE(virtio, id_table);
 
 static struct virtio_driver virtio_scmi_driver = {
 	.driver.name = "scmi-virtio",
-- 
2.47.0


