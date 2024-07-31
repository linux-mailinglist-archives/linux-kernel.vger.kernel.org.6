Return-Path: <linux-kernel+bounces-269727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E39943632
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B26F928174E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26E716DC2D;
	Wed, 31 Jul 2024 19:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOj1uF0w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D9516DC1A
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 19:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722453242; cv=none; b=TUu/efvl7O4Y+42DcYbQ7nV32KTuiU8SA3ocdbq4NzuD14nrw4kxKFA3m3MjLoZCKIOzVhxENffW1D/selXwXsyVAN+0k4d9A+RsdB5YvWPiFNH5Ophs+VOHGXUWw/fxnzeneaqDyWlj/dicsKE7azKh1/X0xSvonj2A+M4KZAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722453242; c=relaxed/simple;
	bh=MzhjOtidPvD9tmAq1Vmzm3l/VuTAOlQGU77txvIYT6A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sm44z7iAgbaxWBE0/zo20im/am/UhsQkzKYd1X512uxMj9oxQEy1qZbuKkGnwoNE7vHOCWnX5iimktdTRNzjNyVrYqiSfWjA360Xu/fw9UxodQH1MzqVHxi1Im6v2xleiS98T27ZE3JJz+myRRlhsDJC77zJNkJ+HoT9GtZYtM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOj1uF0w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9AFFC4AF0C;
	Wed, 31 Jul 2024 19:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722453241;
	bh=MzhjOtidPvD9tmAq1Vmzm3l/VuTAOlQGU77txvIYT6A=;
	h=From:To:Cc:Subject:Date:From;
	b=GOj1uF0wynjsywFdPZtSMK2/6bzSgUiDSmG9GYsoGHYIrRbmXlCK+G05kJBl2msjC
	 Y3hb/W5/EwR4/pwexDz+0i0SocbatP/F3rr49P3d6xVrYtfWkHZAI0QadhWA13Rheh
	 4VAmLG8HSTylbToAr5HeaMt0UcS7g3UEvMLQ7CAPoXXcLvj9EJI0xl8FalBPCSMMx9
	 xWntUaFnVHbCYIhbNqLL/bOSdQQAuF5Bob0cAiYmSXqurw2EOzPsVzBqWY+ZoQrTHZ
	 X8K6z6JK4UbIyzhTcWECkvKOUoElLexOhnjuRjJkf3QdtZ495WHjtf2Lm/Zi/jxuU0
	 TdFj4OL719d6g==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf: arm_pmu: Use of_property_present()
Date: Wed, 31 Jul 2024 13:12:53 -0600
Message-ID: <20240731191312.1710417-15-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of_property_present() to test for property presence rather than
of_find_property(). This is part of a larger effort to remove callers
of of_find_property() and similar functions. of_find_property() leaks
the DT struct property and data pointers which is a problem for
dynamically allocated nodes which may be freed.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/perf/arm_pmu_platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/arm_pmu_platform.c b/drivers/perf/arm_pmu_platform.c
index 4b1a9a92ea11..118170a5cede 100644
--- a/drivers/perf/arm_pmu_platform.c
+++ b/drivers/perf/arm_pmu_platform.c
@@ -59,7 +59,7 @@ static int pmu_parse_percpu_irq(struct arm_pmu *pmu, int irq)
 
 static bool pmu_has_irq_affinity(struct device_node *node)
 {
-	return !!of_find_property(node, "interrupt-affinity", NULL);
+	return of_property_present(node, "interrupt-affinity");
 }
 
 static int pmu_parse_irq_affinity(struct device *dev, int i)
-- 
2.43.0


