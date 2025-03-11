Return-Path: <linux-kernel+bounces-555936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCEAA5BE86
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7637916A7AF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9BE241681;
	Tue, 11 Mar 2025 11:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OqJ9THso"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAD3250C1F
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 11:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741691217; cv=none; b=VT/GYopmd+0HGLghj/Xn1sg3O2mF1lxpoXCqhiNQPW4RLMHAcaG5ou4kODQ3jeur7PxaZ9qVUBTwsIxRAbR8QOybdLu5GpanrmiKFgNHvz8b2wVLSmT+sCaUQ1mHFTmZ4oO54zrliheMJ+sB3H+TFEvTYwlD07riHk3oUdDCU1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741691217; c=relaxed/simple;
	bh=CCtdg8bPoEQ5IX1Tk6eXV7RUmPn4ZTciWYH/jpx5Y68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M0oTWM7czXZtks7Fmtru8uFU1Njn4PBdIJaPXQ6upXPMRtO2SXEDOfxYZWTqK+Dp3Bke1OsLjUq8l+ANPI3IYXjeQINLHn1FT8JbYB2OTZ7L8agOeLn6XLoDbF8+XsVSqx265h6uhrFZ2t5g5P4psVMFKqdC5c8vYDPEhXzCYsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OqJ9THso; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741691213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XdoBqfrjgVpZY+qL5BmkwpRsMBkP0Cbacjg8tv3cBbY=;
	b=OqJ9THso2QxBCmtFlJhQuLDbwPDY14C2vXDDQJ5nT5ir9odJ4ElsncnKHQtrPk4ZWUCan+
	YhOIzgEZ6V4w24d4HUGmTZ6wiIVhhGSdvtdrutlg+jxaIfWEBqNJLHo0L+THIl1iO5CSMX
	5rLB55VdTqmNEeZbqnx/uKEAU0stIjc=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] clocksource: Remove unnecessary size argument when calling strscpy()
Date: Tue, 11 Mar 2025 12:06:24 +0100
Message-ID: <20250311110624.495718-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The size parameter is optional and strscpy() automatically determines
the length of the destination buffer using sizeof() if the argument is
omitted. This makes the explicit sizeof() unnecessary. Remove it to
simplify the code.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 kernel/time/clocksource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 2a7802ec480c..e0eeacbe2521 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -1510,7 +1510,7 @@ static int __init boot_override_clocksource(char* str)
 {
 	mutex_lock(&clocksource_mutex);
 	if (str)
-		strscpy(override_name, str, sizeof(override_name));
+		strscpy(override_name, str);
 	mutex_unlock(&clocksource_mutex);
 	return 1;
 }
-- 
2.48.1


