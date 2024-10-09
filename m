Return-Path: <linux-kernel+bounces-356085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 450BC995C4D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 02:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADED5B23131
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 00:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC0079D2;
	Wed,  9 Oct 2024 00:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="LYkc+tJm"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86102370
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 00:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728433852; cv=none; b=I3B0vINWBFXQuoyo7BL3PMJkiq8soxDpipKpZdgcJU76/LrxToq6zTuODu3aMdSa520qUiNyJbuFYF/5rukfFowqdwnMgf1zAwOPOoTrNs3mWQ54S8ROmZp3fmF3WIeImnh/nIFvgaKyU+IvkFmWA4oP4Oa2VcUIqGnS7Qkcluo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728433852; c=relaxed/simple;
	bh=wGLUgDimauMg8gU0zhx4VSCFfHAeQkhv/erG8CN4fKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=elOZqKf0mU2yISDhnfDB7PBP8NiaPZEZYbfHkwR/lhmo83jV5pQMPOdXQnibFqujcV7euAIR1TuIvNb4JPFDZpb/SAgnUSCE350rv4EHA1+pWAka9WZWGmBY8hFzmZcgNUaUEl0RdDbHglIatm0DybJ1+5xQJ2nvw5k0i2VZbvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=LYkc+tJm; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=rCQzsDCYr1TSRQZPEjx/tkoR9SXubA01OxHXzxwR73E=; b=LYkc+tJmmodI0KuG
	GX/v1hUTv+Aw4eC6FwkYhIbZ6O1zATLRnq7gHukUEbHoSukiC72HSNAzwOzsXO9shNXmd69llkS5k
	mP3u1GfN/r28yT9KnLs3fzawgHI2WXdW5UXc+gSJKTmnfDR7F0T5mQIYEIPTpq+/Pm/JFmD3PjHW7
	DlHQPTnTrUmDKmrd1KlZz7VWbzTYJqPQnFHiiV8fsU4QRVukbzipdMSDr4TitfKPS+1ZcymrW4p/E
	IOqudQAHDw94kVjJPCduyb2tfPsKxgbIoD+X+T4KXWcsdXXlobCxfgncrAyZ7xJU7ufwZ83XhfTbe
	oKjVOqenT8WQ9rONow==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1syKb2-009q0n-2b;
	Wed, 09 Oct 2024 00:30:32 +0000
From: linux@treblig.org
To: jstultz@google.com,
	tglx@linutronix.de,
	sboyd@kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] clocksource: Remove unused clocksource_change_rating
Date: Wed,  9 Oct 2024 01:30:32 +0100
Message-ID: <20241009003032.254348-1-linux@treblig.org>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

clocksource_change_rating() has been unused since 2017's commit
63ed4e0c67df ("Drivers: hv: vmbus: Consolidate all Hyper-V specific clocksource code")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 include/linux/clocksource.h |  1 -
 kernel/time/clocksource.c   | 21 ---------------------
 2 files changed, 22 deletions(-)

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index d35b677b08fe..ef1b16da6ad5 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -215,7 +215,6 @@ static inline s64 clocksource_cyc2ns(u64 cycles, u32 mult, u32 shift)
 
 extern int clocksource_unregister(struct clocksource*);
 extern void clocksource_touch_watchdog(void);
-extern void clocksource_change_rating(struct clocksource *cs, int rating);
 extern void clocksource_suspend(void);
 extern void clocksource_resume(void);
 extern struct clocksource * __init clocksource_default_clock(void);
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 23336eecb4f4..e041ba81c2f7 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -1262,27 +1262,6 @@ static void __clocksource_change_rating(struct clocksource *cs, int rating)
 	clocksource_enqueue(cs);
 }
 
-/**
- * clocksource_change_rating - Change the rating of a registered clocksource
- * @cs:		clocksource to be changed
- * @rating:	new rating
- */
-void clocksource_change_rating(struct clocksource *cs, int rating)
-{
-	unsigned long flags;
-
-	mutex_lock(&clocksource_mutex);
-	clocksource_watchdog_lock(&flags);
-	__clocksource_change_rating(cs, rating);
-	clocksource_watchdog_unlock(&flags);
-
-	clocksource_select();
-	clocksource_select_watchdog(false);
-	clocksource_suspend_select(false);
-	mutex_unlock(&clocksource_mutex);
-}
-EXPORT_SYMBOL(clocksource_change_rating);
-
 /*
  * Unbind clocksource @cs. Called with clocksource_mutex held
  */
-- 
2.46.2


