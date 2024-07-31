Return-Path: <linux-kernel+bounces-269725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C4694362F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 21:16:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B691D284775
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 19:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A51616D9BA;
	Wed, 31 Jul 2024 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="poI2Or9p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE67B16D9A8;
	Wed, 31 Jul 2024 19:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722453238; cv=none; b=PD7xQMJbvJys5kcV4wY2qew4SLBoLFFWdP8Kd5uufYy6sgQE4HaEbZXVXSgvRlqiNU0xh9ynUg1jIdSx+/kVpkRF5IU8P2uky+fTkVQNonEqmUS9NLRq/r9BUy56n/LYvpqDRGudBreDUi6PNwKYDXYBaH5JTkTSJYcOefvQQDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722453238; c=relaxed/simple;
	bh=B57o1SV3zRToqiSMqD2BRI2alnivLDeH2CgGFuQHidc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oxkENs3R8eXkRR3fUWTq5zcNK2uvhH7tittIOjGuAyuI3tLhIPVBKFEHRPIvIaj71pggCV86rcshvDTW3of5HbZQSjMRYPFLGd5N5GbAC7KqxBYsHFkypX9NAfBM4KxBPGgWs58jZrzZK43aiycORQdjPDcv9dYR8tGLTpd0Bwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=poI2Or9p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDF7C116B1;
	Wed, 31 Jul 2024 19:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722453237;
	bh=B57o1SV3zRToqiSMqD2BRI2alnivLDeH2CgGFuQHidc=;
	h=From:To:Cc:Subject:Date:From;
	b=poI2Or9pnWnOvRjcRnO3MXsmCJ/rM3NeJ5kvGl7KK++OXFPKMMeJV/K7WyN1SSn2q
	 iW/jGdbMdLhczNJDA0Ef1KZYyfyYsmAB+wdxcJfGK4i7U89wuuV71Fdv86R+hHRexB
	 o5UyGNEkQ9H9CMNWhfCh0TtpUve91tTQUt8h/+ajAZfMDvQvpRbmOzDVxR1Wp8vgtm
	 4XfdhtbWLREX2Dq97dwqLiR8Qx+tvBqotYxbP2rm/LvQRSUAd/YMSo32Eyf2sTPSoM
	 EJi+yRk6RnMVPLxc/Z9Tt1PbWo146B1R2sRnydJrLphgTdLCD61dXOJcsTBgXEwTS+
	 XEuG/UwBPXIIg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: vexpress: Use of_property_present()
Date: Wed, 31 Jul 2024 13:12:51 -0600
Message-ID: <20240731191312.1710417-13-robh@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use of_property_present() to test for property presence rather than
of_get_property(). This is part of a larger effort to remove callers
of of_get_property() and similar functions. of_get_property() leaks
the DT property data pointer which is a problem for dynamically
allocated nodes which may be freed.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/hwmon/vexpress-hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/vexpress-hwmon.c b/drivers/hwmon/vexpress-hwmon.c
index d82a3b454d0e..a2e350f52a9e 100644
--- a/drivers/hwmon/vexpress-hwmon.c
+++ b/drivers/hwmon/vexpress-hwmon.c
@@ -72,7 +72,7 @@ static umode_t vexpress_hwmon_attr_is_visible(struct kobject *kobj,
 				struct device_attribute, attr);
 
 	if (dev_attr->show == vexpress_hwmon_label_show &&
-			!of_get_property(dev->of_node, "label", NULL))
+			!of_property_present(dev->of_node, "label"))
 		return 0;
 
 	return attr->mode;
-- 
2.43.0


