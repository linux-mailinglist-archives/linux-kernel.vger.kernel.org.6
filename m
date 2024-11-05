Return-Path: <linux-kernel+bounces-395712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FE69BC1F0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 01:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A8001F2286F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 00:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C54BDDDC;
	Tue,  5 Nov 2024 00:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Kp5YmqM6"
Received: from pv50p00im-ztdg10021101.me.com (pv50p00im-ztdg10021101.me.com [17.58.6.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764C91E868
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 00:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730766095; cv=none; b=mtr3Jni+38AztHq9/FVCh/XnkSl/g9hiJtLpK0zx9IcV75saNsywBiXkOLJhnHcFEOMbJhkfHmxiMfWNtTAIT8McpGO5HCGUQUd3RVxK4mNbK0mbZqx1wGua8yD0WXrBQtHbXs5flG/oOe+N8U/Xkwac/7jvtEXRCcC5bNZdQFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730766095; c=relaxed/simple;
	bh=T3AQgiqjsuEnMeCbV+0XhVRdlrFrG6GLxSc0iff5QbM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hnkcM0L1wsP8h8w97a5Hy19eD7ben7IPMewg5p3f485gpf9SHfFWZ9C7ztB2JnuE5659J4mc4T/IHAYzsDb6aloOwvl0xTKUvAOHY05AZnE3dOmQGA7urG6Z0ZHvzA+uY72OGKLoi4PQekmOJI5BHS/O/7MrpnlXMi40Tg90w64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Kp5YmqM6; arc=none smtp.client-ip=17.58.6.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1730766094;
	bh=5Kts4W3mcfFZfFTKYGxweaNOJFKnlXqAWdud+x19Rso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=Kp5YmqM6LlQ/+m0nhDUAShTc93ZWWEP81KzDXth+8gqlIk8vuVH6rrXnnFZPrMHkk
	 WsZKdJZtMOqKiWSCgqtxtfgT+RwTShmzkod6ku9b7+8fH1HgH7xGxeuKDXjsfji5NR
	 yggm3Aj9UEe+yrL3nBGFuY82Q6tWo8sZswT0Q/au9SljSnO6qhxkhmAXKm8x1ZFSRi
	 wXsjNh8J0UNThjIBbI5pCf4pLMbO15uA8zsSnVYfrbaAcPZ1kwIb+K6vEeHVA9FmQM
	 HsKg+PrKm9CDnrGNqBAzoR49byPSHNgwpCkswIWnTpajotBTZzNG5eBqc8anJA36Cd
	 gdoRgc+Rn8czg==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztdg10021101.me.com (Postfix) with ESMTPSA id 28C65D0012D;
	Tue,  5 Nov 2024 00:21:30 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 05 Nov 2024 08:20:24 +0800
Subject: [PATCH 3/3] driver core: class: Delete a redundant check in APIs
 class_(for_each|find)_device()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241105-class_fix-v1-3-80866f9994a5@quicinc.com>
References: <20241105-class_fix-v1-0-80866f9994a5@quicinc.com>
In-Reply-To: <20241105-class_fix-v1-0-80866f9994a5@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.1
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Delete redundant check (!@class) in both API class_for_each_device() and
class_find_device() with below reasons:

- The check is covered by later check (!@sp).
- Callers are unlikely to call both APIs with NULL class argument.
- Make parameter check consistent with all of other class APIs.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/class.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/base/class.c b/drivers/base/class.c
index e81da280af74..120d3aeb52fe 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -408,8 +408,6 @@ int class_for_each_device(const struct class *class, const struct device *start,
 	struct device *dev;
 	int error = 0;
 
-	if (!class)
-		return -EINVAL;
 	if (!sp) {
 		WARN(1, "%s called for class '%s' before it was registered",
 		     __func__, class->name);
@@ -456,8 +454,6 @@ struct device *class_find_device(const struct class *class, const struct device
 	struct class_dev_iter iter;
 	struct device *dev;
 
-	if (!class)
-		return NULL;
 	if (!sp) {
 		WARN(1, "%s called for class '%s' before it was registered",
 		     __func__, class->name);

-- 
2.34.1


