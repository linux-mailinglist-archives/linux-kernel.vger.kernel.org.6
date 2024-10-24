Return-Path: <linux-kernel+bounces-380420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6BA9AEE35
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F3DD28473B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A820D1FE0E7;
	Thu, 24 Oct 2024 17:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/uM+gsK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BFB1CBA17
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 17:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729791292; cv=none; b=CtHFJ8GWA2J+VGZyF71IfXsPQq2RLi/tDfvV6sVvRIjA/5T/NsUhkUh46BwNZJbUx8CIaLaMsd5MQQSt24hjiZnaMV+i6uIj82iovPCoJL03ZgWmiIKhpZgaXQH4r/SOG3OK/blWjgyms2cRX2VwcBRZrtIwslZf36QWWQOvjPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729791292; c=relaxed/simple;
	bh=H+iEc2RxYP+7aT5fPGyflx/19MbUQptYWZMoH5FKxlY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LE8txisnCe6yhAgZe1g7vfDRj8j3nd/6CYDaiFOifRleSCZFtS3MvF/p+m864VVqlal/SJC+gOeokvzUI3EhQP5BpRYZImI75rqj5SovPggqVHUXXz9FXLHCqXOiiXY706AS+X9FaxVPfIvrwU0b0Z+fhz/gSE+bB+u3iqYIilI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/uM+gsK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DAD6C4CEC7;
	Thu, 24 Oct 2024 17:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729791291;
	bh=H+iEc2RxYP+7aT5fPGyflx/19MbUQptYWZMoH5FKxlY=;
	h=From:Date:Subject:To:Cc:From;
	b=j/uM+gsKkpVE4YpcJt9ze+h8cYWqUt4881GxAfQ04paMi9PCMLfj7J90dPvISK1EH
	 v4AYU64jKzW7zMNGm98jhsZ7Fs01kB2iQ4cMcKtv94oXjZBTueNar0W1ZpM/Plxd1w
	 3R6HuCeGoRtikyQxOEmpmSXd3Lp/yZEyPLs78sfSL68nDVFU01xe06MvVb5FxKonsP
	 nX8dVplDkJDIVpjwdRwekrlz6qyOVpXZf5kVprkJbH37iX8QAycVLgtaX91ZJpyMaJ
	 GjEEmQV3xdz8YuPrFTMlVmMhmTU5rpy86GEDCyP6LoszO9jpUSlgYB+JrJYJAwSulp
	 qkEMIARqqDhtg==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Thu, 24 Oct 2024 19:33:07 +0200
Subject: [PATCH] nvme-pci: Force NVME_QUIRK_SIMPLE_SUSPEND on Qualcomm
 hosts
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-topic-nvmequirk-v1-1-51249999d409@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIANKEGmcC/x2MQQ5AMBAAvyJ7tkmLkPiKOCiLjWirpZGIv9s4z
 GEOMw9ECkwR2uyBQIkjOyui8wzGdbALIU/iUKii0gKezvOINu10XBw21IoaRbXRpRlAKh9o5vs
 /dv37fsNT6EthAAAA
X-Change-ID: 20241024-topic-nvmequirk-10e70e6b13ba
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729791288; l=1918;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=Vo/r6/bSWAK8A6+AEU3IEBIjDMn/12uUNGfpjEqGMJ4=;
 b=+0Uss2EOp/Krb4dQS/+UAdVZAMvPtqoWqNnnVWBMS5++C7Ojxagn1+61IEQOF/k01j8CFl4cd
 AwigjGbzmfiAI8Sm7cYhvTjRaSs9U8Y9urkoi2Gr3gvELZqtYuPlatZ
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

The Qualcomm SC8280XP SoC requires that all PCIe hosts are powered down
before the platform can reach S3-like sleep states. This is very much
similar in nature to the issue described in [1].

Other Qualcomm platforms we support upstream require more complex code
additions across both the PCIe RC driver and other platform-specific
ones, before the link can be sustained in suspend. Hence, they
effectively need the same treatment for now.

Force NVME_QUIRK_SIMPLE_SUSPEND on all Qualcomm platforms (as
identified by the upstream bridge having a Qualcomm VID) to address
that. Once the aforementioned issues on non-SC8280XP platforms are
addressed, the condition will be made more specific, with a PID check
limiting it to only the platform(s) that require it due to HW design.

[1] Commit df4f9bc4fb9c ("nvme-pci: add support for ACPI StorageD3Enable property")

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/nvme/host/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4b9fda0b1d9a33af4d7030b72532835b205e9cbb..007b28a03cf2c7b3a90f7b7faa1c4c1950e25b6e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2999,6 +2999,14 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 	if (dmi_match(DMI_BOARD_NAME, "LXKT-ZXEG-N6"))
 		return NVME_QUIRK_NO_APST;
 
+	/*
+	 * Qualcomm SC8280XP must shut down the PCIe host to enter S3.
+	 * Other Qualcomm platforms require more driver changes to restore the
+	 * link state after wakeup.
+	 */
+	if (pci_upstream_bridge(pdev)->vendor == PCI_VENDOR_ID_QCOM)
+		return NVME_QUIRK_SIMPLE_SUSPEND;
+
 	return 0;
 }
 

---
base-commit: fd21fa4a912ebbf8a6a341c31d8456f61e7d4170
change-id: 20241024-topic-nvmequirk-10e70e6b13ba

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>


