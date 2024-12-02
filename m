Return-Path: <linux-kernel+bounces-428283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 893AA9E0C63
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25140165593
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF111DED70;
	Mon,  2 Dec 2024 19:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qj4K8j2w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855121DE8B1;
	Mon,  2 Dec 2024 19:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733168492; cv=none; b=fbuTHFKMvA5C1HKHgzaZ9vTq16S9bq0ADOq42qjD3hIDiOw8yUhmUAgqapngEMqlkVkkKrPtszmU01myq5CRVw78WHS9OLoNgqU+D5AoRu3+W6A5oRR4RA+c/Cyz7UwaJBQ0w0+IfksYsJcrlGUuJZ8CK75Cfk/0qr+E04jCEPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733168492; c=relaxed/simple;
	bh=COLrg2AbV+4KaQRU2Xw2S5L8rp55JjS366Yv/REeB7o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pyVtKQQfg9tlQnLM14yB3PUEEBzKGWM8QEfmYh0E8JZDc4cOs65OWRGpBLOIXWP0/D1m2vrHPc66nescrx9fPHjPSE+2X1UiBRcFewg2hFtrnNoOUZg6Ol3pLvrQuLzRP1/C4PBsILtGMtxXy9ajMrhQq5JgvmPwah0Z9XDhvm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qj4K8j2w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3FD9C4AF0D;
	Mon,  2 Dec 2024 19:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733168491;
	bh=COLrg2AbV+4KaQRU2Xw2S5L8rp55JjS366Yv/REeB7o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Qj4K8j2ww8UVzzpyWXa6nhUv1TFhoo6m7C8XYiSpWJJY8b7NWNKrGNHzKY4fIf08s
	 EHBa7pgtzlyid00u3T/DzA8zEjQjE0X8E03mJVrZLa8gesvXq2MT3JXCJbMTc4KZSo
	 Vd51VL3c+oUZdQaMUL0m2orlHqZRq4CByThPvziau905SKp9a3TRXViNbTbpA2kmZK
	 7z1gddksE9xNOaviBVEYaOTeOIihExuy4iYJ/OCjjggUwG95uGgs03o0h9CNDFYQbN
	 3pQxYB1h5librzicU4vd/5vs2OsAx4NAtfIr3ZVVm+W9bXYiolSqlVFq0s8V9rLCX8
	 MystByqjlX5fg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47BEE69E8C;
	Mon,  2 Dec 2024 19:41:31 +0000 (UTC)
From: Jens Glathe via B4 Relay <devnull+jens.glathe.oldschoolsolutions.biz@kernel.org>
Date: Mon, 02 Dec 2024 20:41:30 +0100
Subject: [PATCH v3 2/3] firmware: qcom: scm: Allow QSEECOM for HP Omnibook
 X14
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-hp-omnibook-x14-v3-2-0fcd96483723@oldschoolsolutions.biz>
References: <20241202-hp-omnibook-x14-v3-0-0fcd96483723@oldschoolsolutions.biz>
In-Reply-To: <20241202-hp-omnibook-x14-v3-0-0fcd96483723@oldschoolsolutions.biz>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kalle Valo <kvalo@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733168490; l=867;
 i=jens.glathe@oldschoolsolutions.biz; s=20240919;
 h=from:subject:message-id;
 bh=5Oq4MdNKXVyJJvjmJFPu8lXVv7qb44phd5FkFC6DLHc=;
 b=DCkZgJqU7s8ayLGPhLMi/Ea2aN1ZrE17xovmsmP/VglNQN3GrW3m0b2+fdqQ4bVne8tNGa56K
 Ux+fTQJBVvBBwwnxKoYD90fyNR2Tme2ZwXxJ8zNnljHe1khKMwsgis1
X-Developer-Key: i=jens.glathe@oldschoolsolutions.biz; a=ed25519;
 pk=JcRJqJc/y8LsxOlPakALD3juGfOKmFBWtO+GfELMJVg=
X-Endpoint-Received: by B4 Relay for
 jens.glathe@oldschoolsolutions.biz/20240919 with auth_id=216
X-Original-From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Reply-To: jens.glathe@oldschoolsolutions.biz

From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>

add "hp,omnibook-x14" as compatible device for QSEECOM

This is required to get access to efivars and uefi boot loader support.

Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
---
 drivers/firmware/qcom/qcom_scm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 72bf87ddcd969..2e148fb7167be 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1769,6 +1769,7 @@ EXPORT_SYMBOL_GPL(qcom_scm_qseecom_app_send);
  */
 static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
 	{ .compatible = "dell,xps13-9345" },
+	{ .compatible = "hp,omnibook-x14" },
 	{ .compatible = "lenovo,flex-5g" },
 	{ .compatible = "lenovo,thinkpad-t14s" },
 	{ .compatible = "lenovo,thinkpad-x13s", },

-- 
2.43.0



