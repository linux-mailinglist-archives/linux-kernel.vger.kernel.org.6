Return-Path: <linux-kernel+bounces-305010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EB396281C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91D511C209AA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2A217A5A4;
	Wed, 28 Aug 2024 13:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eurOd9Dr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9D416BE1A;
	Wed, 28 Aug 2024 13:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724850062; cv=none; b=JblaXhBHEbthi4NfdYL/7iz00XMgpbOekZwnN1X+Vl0St8YLJ7jOQx3Ktf485EqhNaH3VOki4fvoKxsieeF9K+v+ul3Im8zKeYxIBbrAqXwc+hbXWtGJ/mJ9+HGkPTm8jpj9drvzsx3G6suD3D1jzwMOfmg9azhNMKQxizk9yCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724850062; c=relaxed/simple;
	bh=DMx89/M6A3gPXYVGxlU2/okNE/PkH+UqmZ871NmT0rI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kBOhuzSWdnah+Ms6Htp5OYRf+HLsPjvlUiNEGk8/G/C6XBGGFaE4DH0B/1YIg1iR0qSh86bNJeklbmyLUGtT0kD+1SsQFQDZfBBWEK4QjqmTbNPCx/rFc70NI9CK/eXOymHOC4Lwm58YxkJSicgIghG2mm819ZyIhQLL3U7hgg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eurOd9Dr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2C7C4CAC2;
	Wed, 28 Aug 2024 13:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724850062;
	bh=DMx89/M6A3gPXYVGxlU2/okNE/PkH+UqmZ871NmT0rI=;
	h=From:To:Cc:Subject:Date:From;
	b=eurOd9Drftv5gz5GQrJZGi9oOdWnevoqybSR6tyK7IUe5tvsk1Jo3jN7P6oSux3V7
	 ZVkkPgi/z5NuCQYSpoohaeJUO2u/99kLfDapg0hfj8J1Gac7jBdWNoLRyyWhfHiUFs
	 fdHYY30GeQe9Nf/t5H3FHPD9iB+KDp28XmBq6p30+CO+N/HrBjB6EkC6XV59tMb5Qp
	 GTjYuMonKIIhgfImTjpeq56W8OAFY6BkgTbxCUMll5+n8wWRciHDm/NEQKOheRrCH+
	 /WQjT2RvqmPVkUYyBVKQNEkVY8U/4nxopWVV1Hso1P8C0l0jk/qBNJXlv4LZsD0saB
	 OCc1laXMHw+jA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] regulator: qcom_spmi: Drop unnecessary of_find_property() call
Date: Wed, 28 Aug 2024 08:00:54 -0500
Message-ID: <20240828130056.3481050-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There's no need to check for presence of "qcom,saw-reg" before parsing
it. If the property doesn't exist, parsing it will return NULL.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/regulator/qcom_spmi-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index 9a9fa20dcd95..68603649db48 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -2528,8 +2528,8 @@ static int qcom_spmi_regulator_probe(struct platform_device *pdev)
 	if (!reg)
 		return -ENODEV;
 
-	if (of_find_property(node, "qcom,saw-reg", &lenp)) {
-		syscon = of_parse_phandle(node, "qcom,saw-reg", 0);
+	syscon = of_parse_phandle(node, "qcom,saw-reg", 0);
+	if (syscon) {
 		saw_regmap = syscon_node_to_regmap(syscon);
 		of_node_put(syscon);
 		if (IS_ERR(saw_regmap))
-- 
2.45.2


