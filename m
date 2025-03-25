Return-Path: <linux-kernel+bounces-575067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B07A6ED22
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 10:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 244BB3A68A8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 09:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B8B253B64;
	Tue, 25 Mar 2025 09:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="AHFxqWLO"
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C1B194094;
	Tue, 25 Mar 2025 09:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742896675; cv=none; b=l+98bcZYcPUJXOKKEkizDWo4VYR1Dxt0kNh6liqEhN5uPMcMpyinmqXwLnZo6C/7aVh+ymCYV8NZg5dsQy3vtUKTBLXDfso6pWpp1qKyqbaCxNcuoJgSsvIvD6lZff0qqt7w1NuXPXKCnIua1c6F7Cac0chATD6WWtyhqcb4OXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742896675; c=relaxed/simple;
	bh=BAcGLV2gROaH61d2upyHEAfq6TIAYGSRatBT/GV/s0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KWEP2zD392SEqzPT+XeFb2ydAtcuQd1Y9jLBDi1A/optmHKx/LHhEMPcTuq64AYfhMXriSO4DN11fybMGIEZuBUcJdskRfE4sHSjGMFN69k46KB92L+qvhYrbu2qpVm3s2oti70kBgEfT/Y2tCReeABqTXZeIYznUuN1xDuSFQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=AHFxqWLO; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1742896660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=W/iG3eeUUjRo4LRsKssknGqy+N5wFg8aMaSR8xK6czo=;
	b=AHFxqWLOIbDgzGIhxRRLbvJlC1ZHzMiYYUEftXwKVZIe+fFxvo4uiwad9AeI0kW7g1ctBK
	FTOzOaxpPchGYO9hVnOYjnQJelzC7oQKfbayNiWjKbUYfQ18GyE6sSMp7TUqXYFa0I0VF0
	iA0uyO9s8nwgD3fghsODc9ffNDMVs2c=
To: Corentin Chary <corentin.chary@gmail.com>
Cc: "Luke D. Jones" <luke@ljones.dev>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] asus-laptop: Fix an uninitialized variable
Date: Tue, 25 Mar 2025 12:57:37 +0300
Message-ID: <20250325095739.20310-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The value returned by the acpi_evaluate_integer() function is not
checked, but the result is not always successful, so an uninitialized
'val' variable may be used in calculations.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: b23910c2194e ("asus-laptop: Pegatron Lucid accelerometer")
Cc: stable@vger.kernel.org 
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 drivers/platform/x86/asus-laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
index d460dd194f19..b74b7d0eb6c2 100644
--- a/drivers/platform/x86/asus-laptop.c
+++ b/drivers/platform/x86/asus-laptop.c
@@ -427,7 +427,7 @@ static int asus_pega_lucid_set(struct asus_laptop *asus, int unit, bool enable)
 static int pega_acc_axis(struct asus_laptop *asus, int curr, char *method)
 {
 	int i, delta;
-	unsigned long long val;
+	unsigned long long val = PEGA_ACC_CLAMP;
 	for (i = 0; i < PEGA_ACC_RETRIES; i++) {
 		acpi_evaluate_integer(asus->handle, method, NULL, &val);
 
-- 
2.43.0


