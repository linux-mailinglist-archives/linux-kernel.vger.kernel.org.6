Return-Path: <linux-kernel+bounces-385166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 240BA9B3361
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBDC928339F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5881DDC13;
	Mon, 28 Oct 2024 14:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kntAFHzS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83671DA631;
	Mon, 28 Oct 2024 14:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730125384; cv=none; b=Mbf7eihOHzgVzAnqPh11NaYmcO4H0MW0boQmFKZEzcf/j42oA1yn/SsJHUuVtSiOIjKtJgpfOsMOAPkQpwwRyvQHnUHKLbnTSqxWLMXxT+dpDCBuM3ShCIDC8m5AHgfEveV2diBZcWF50d7MPs2q2bZT+J1znRvoKsTZFRnaWaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730125384; c=relaxed/simple;
	bh=ZQCzSCdRJnarUvUNjH4dcubxSkcXGcHBY3Q+CZQ2Yus=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aQZHUDdOWhaV5UVCLn4FN9CROmRlalO9W16ZJ8k1qf+LiemuyTvMt/xY6kQMeI2AiVRFaiS7q/m2dpaTaKnzmuNRzvBzNmBQx8zoJ0IXUpG/4cwT8tJt0FtwvbEbPLIVETZdChQqnTn4XlR1yeUCyhqHUddRmL+rXKgjUdjQGfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kntAFHzS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF3EC4CEC3;
	Mon, 28 Oct 2024 14:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730125384;
	bh=ZQCzSCdRJnarUvUNjH4dcubxSkcXGcHBY3Q+CZQ2Yus=;
	h=From:Subject:Date:To:Cc:From;
	b=kntAFHzSa2STXgjS3+YZA6rDD097Rmxcv2cwb13ucIBzhSUPKir7czv48YTSwBCmk
	 s/nt9qfNjkC8hx4YpyCledjyzk3Xyq6fIVbpDpqhgtWh/+ymhhjwE4ssKqOZMDoTsf
	 0FicV63BQ+MfiTFrj8eouf9lv4cu0hm3K4FfcQ3d8117m4U07LL5WbIjSLm+Ba04ml
	 fWCUvy5Cwmb6hQTNc84YnNhUelOTQryn21sTuJ6qRu/r/qyn0Thfats9R78w0U5L91
	 5JdWjwqGTA4y+iz1eyGMnXOJqxfhiovfuWpksRMUxoifQLHcacIK332IFoMZqmWW/A
	 H/woj9j5T0ggA==
From: Konrad Dybcio <konradybcio@kernel.org>
Subject: [PATCH 0/3] Allow specifying an S2RAM sleep on pre-SYSTEM_SUSPEND
 PSCI impls
Date: Mon, 28 Oct 2024 15:22:56 +0100
Message-Id: <20241028-topic-cpu_suspend_s2ram-v1-0-9fdd9a04b75c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAECeH2cC/x3MQQqAIBBA0avErBNsKLCuEhGiU80iFaciiO6et
 HyL/x8QykwCQ/VApouFYyho6grcZsNKin0xoMa20WjUERM75dI5yymJgp8Fs90VmsXpvvPa2hZ
 KnTItfP/ncXrfDxOo+w9pAAAA
X-Change-ID: 20241028-topic-cpu_suspend_s2ram-28fc095d0aa4
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730125380; l=1608;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=ZQCzSCdRJnarUvUNjH4dcubxSkcXGcHBY3Q+CZQ2Yus=;
 b=CJb5iv370J3U0frllG/BZzoHQSaWIPmZgpGoQ58p2btL7ihJwcbBT8zD1VKQ/ziRzdc1U6Uas
 0G+Ugzn/wmLBSi4AbM9rrHA7dtq5o+QUORoJO4QpnMwGDqz1XQcdumk
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Certain firmwares expose exactly what PSCI_SYSTEM_SUSPEND does through
CPU_SUSPEND instead. Inform Linux about that.
Please see the commit messages for a more detailed explanation.

This is effectively a more educated follow-up to [1].

The ultimate goal is to stop making Linux think that certain states
only concern cores/clusters, and consequently setting
pm_set_suspend/resume_via_firmware(), so that client drivers (such as
NVMe, see related discussion over at [2]) can make informed decisions
about assuming the power state of the device they govern.

If this series gets green light, I'll push a follow-up one that wires
up said sleep state on Qualcomm SoCs across the board.

[1] https://lore.kernel.org/linux-arm-kernel/20231227-topic-psci_fw_sus-v1-0-6910add70bf3@linaro.org/
[2] https://lore.kernel.org/linux-nvme/20241024-topic-nvmequirk-v1-1-51249999d409@oss.qualcomm.com/

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
Konrad Dybcio (3):
      dt-bindings: arm,psci: Allow S2RAM power_state parameter description
      firmware/psci: Set pm_set_resume/suspend_via_firmware() for SYSTEM_SUSPEND
      firmware/psci: Allow specifying an S2RAM state through CPU_SUSPEND

 Documentation/devicetree/bindings/arm/psci.yaml |  6 ++++
 drivers/firmware/psci/psci.c                    | 44 ++++++++++++++++++++++---
 2 files changed, 46 insertions(+), 4 deletions(-)
---
base-commit: a39230ecf6b3057f5897bc4744a790070cfbe7a8
change-id: 20241028-topic-cpu_suspend_s2ram-28fc095d0aa4

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>


