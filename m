Return-Path: <linux-kernel+bounces-385168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6BF9B3365
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08B6B1C216AA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495391DE4D2;
	Mon, 28 Oct 2024 14:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJ2f9wPs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CB41DE3D6;
	Mon, 28 Oct 2024 14:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730125392; cv=none; b=F76Cuw5zO9mXGAUyiGRiGqOR9MEghrNEefYrp+lNmjzDNcdkntvDHc4E+hPM9e4h6oyjg8rHWfmvoDCxSvxKkOZWEem2kolVszUi0clW9MjTWeEmQPIqTd4zpa1FEF0ojX+pwVn9kU2wwskSwZRvaj2frh2T5YQGGP1//ZCso2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730125392; c=relaxed/simple;
	bh=INIyxIjyW8dZrymPTrJki0+QEIhN5rfp5OXIveeeXZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wafxqr2prYQ2YB5fuFbbByg3Bbh0mGGAIy99ymhFyRqvDJazhQRdmYjmY+bB3gA1UBYdv3far0IEQWpr1RaPQ0tx6y+WAiAIep78n/6zCxd6bOFNvhmhGsXMZCExCD+rSrbtqIdzxoWWIYAkvzrvUnRZHSQM7K0T8SqxFHEOrpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJ2f9wPs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58B3C4CEE8;
	Mon, 28 Oct 2024 14:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730125392;
	bh=INIyxIjyW8dZrymPTrJki0+QEIhN5rfp5OXIveeeXZ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jJ2f9wPsfrE+3WverENvTtoDPFfJmQyO1YYV46otysBHoQkrDQ2LSKZfoA5L5qju4
	 Zc0rx+1EQtCOXtkw1hlSTfDUDTPj8y2xH56BUB18XzAI2BFL/qwAeM/g+yv8YoluYl
	 kL5zNLidcdx7h+lqz/o2Pv6MzLCyHtHwBup4AMq8o0aRA5kfbR6vwI2gpoCb+QuGEJ
	 B7cs2vBEe17JVwULTELVB8YgA2/x/b+efJ6oiUZwp/emdJ09HI/DO49eJ+C1IUDeMD
	 CCeuPSTY1jXexgHkvLvTYKhReHQA0VGzVz1D55YRMUrPaDCMTPQeIF04nBTqfJZktg
	 GPWif56YlStwg==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Mon, 28 Oct 2024 15:22:58 +0100
Subject: [PATCH 2/3] firmware/psci: Set
 pm_set_resume/suspend_via_firmware() for SYSTEM_SUSPEND
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-topic-cpu_suspend_s2ram-v1-2-9fdd9a04b75c@oss.qualcomm.com>
References: <20241028-topic-cpu_suspend_s2ram-v1-0-9fdd9a04b75c@oss.qualcomm.com>
In-Reply-To: <20241028-topic-cpu_suspend_s2ram-v1-0-9fdd9a04b75c@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Sudeep Holla <sudeep.holla@arm.com>, Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730125380; l=1306;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=INIyxIjyW8dZrymPTrJki0+QEIhN5rfp5OXIveeeXZ0=;
 b=hEJdSTloRMtioiwdZulRfEu6ZrNIJW/pFqzZKFYyiI1neblGkpxAW34SRPduGpLKNGaZLn5Dx
 8UHBjCVaPk5Cet6SNHK/H7Pzfc47zOOWQ+8V6z1TwP6LpSXQ8RsXjCU
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Some device drivers are curious to know whether "the firmware" (which is
often assumed to be ACPI) takes care of suspending or resuming the
platform. Set the flag that reports this behavior if SYSTEM_SUSPEND is
implemented.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/psci/psci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 2328ca58bba61fdb677ac20a1a7447882cd0cf22..0e622aa5ad58bbe69dfc3a71bced597618e73f15 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -507,12 +507,22 @@ static int psci_system_suspend(unsigned long unused)
 
 static int psci_system_suspend_enter(suspend_state_t state)
 {
+	pm_set_resume_via_firmware();
+
 	return cpu_suspend(0, psci_system_suspend);
 }
 
+static int psci_system_suspend_begin(suspend_state_t state)
+{
+	pm_set_suspend_via_firmware();
+
+	return 0;
+}
+
 static const struct platform_suspend_ops psci_suspend_ops = {
 	.valid          = suspend_valid_only_mem,
 	.enter          = psci_system_suspend_enter,
+	.begin          = psci_system_suspend_begin,
 };
 
 static void __init psci_init_system_reset2(void)

-- 
2.47.0


