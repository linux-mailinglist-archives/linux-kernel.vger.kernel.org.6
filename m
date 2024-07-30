Return-Path: <linux-kernel+bounces-267595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F15BA941330
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 15:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97A51B265A8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 13:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C05B1A00F8;
	Tue, 30 Jul 2024 13:33:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130B319F499;
	Tue, 30 Jul 2024 13:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722346426; cv=none; b=bmhuQxCQxy8oXhk+m1T9/EcFMo5+El+8Eo75/xtb9zUuCkhtOqnyd49mlW+YlQ2bv69izyx6Hcp7Af+kdvpqgENu3/H2W8uK+kHDhkhz+emJ30yTccEfOnC+vNjCikEOm+/9NLwi7e2vTjxZsfv1/11UjUj48+7vdyIkntg50Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722346426; c=relaxed/simple;
	bh=B4Mt04DHLpCnBffsmbdlRl31oSaexKqLft6+Vvaqa1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RlT1wCJtH/EvsRson1BbTOP202LOTPea17/t5rD4XH5tDaT7Giwe0r88o+2gseEISVouPCj6ftxK4mRTrzR3N/73SktmGF9Yb46N4SFRS9SgtlkRz+YCh02MX7fCNim7+xAmocD4Qnoyuh37GcK2rBaHv+mcKWP558abuIXaIQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49EE4106F;
	Tue, 30 Jul 2024 06:34:10 -0700 (PDT)
Received: from pluto.guestnet.cambridge.arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F39733F5A1;
	Tue, 30 Jul 2024 06:33:41 -0700 (PDT)
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
	ptosi@google.com,
	dan.carpenter@linaro.org,
	souvik.chakravarty@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v3 1/9] firmware: arm_scmi: Fix double free in OPTEE transport
Date: Tue, 30 Jul 2024 14:33:10 +0100
Message-ID: <20240730133318.1573765-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730133318.1573765-1-cristian.marussi@arm.com>
References: <20240730133318.1573765-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Channels can be shared between protocols, avoid freeing the same channel
descriptors twice when unloading the stack.

Fixes: 5f90f189a052 ("firmware: arm_scmi: Add optee transport")
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/optee.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/firmware/arm_scmi/optee.c b/drivers/firmware/arm_scmi/optee.c
index 4e7944b91e38..0c8908d3b1d6 100644
--- a/drivers/firmware/arm_scmi/optee.c
+++ b/drivers/firmware/arm_scmi/optee.c
@@ -473,6 +473,13 @@ static int scmi_optee_chan_free(int id, void *p, void *data)
 	struct scmi_chan_info *cinfo = p;
 	struct scmi_optee_channel *channel = cinfo->transport_info;
 
+	/*
+	 * Different protocols might share the same chan info, so a previous
+	 * call might have already freed the structure.
+	 */
+	if (!channel)
+		return 0;
+
 	mutex_lock(&scmi_optee_private->mu);
 	list_del(&channel->link);
 	mutex_unlock(&scmi_optee_private->mu);
-- 
2.45.2


