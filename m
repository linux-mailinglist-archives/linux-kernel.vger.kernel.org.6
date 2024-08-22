Return-Path: <linux-kernel+bounces-296298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE2695A8CF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 02:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1F11C21C41
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 00:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DBB5684;
	Thu, 22 Aug 2024 00:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRYR3Ntr"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B2F6FB6
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 00:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724286387; cv=none; b=iSM4W7OK4pPjHyWynthJYwJl4WXl36kSqoPTNF8BxWA2qwCVdtpul7Exm5GqRpcg7ejwjt0fqtpM7efhtaxq/aPqnVfxy5bGihGSrY2jC6UEs9t1GfV8/t1bFryC+mN4sw/Hm1RY9aKcpAqXs33l5s0sg/bwDR8jiaucTUb3gr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724286387; c=relaxed/simple;
	bh=ih7XMXQALCvjm8plUarj8ViVVaJzTWpexWos7fRy9t8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=llu9oIYkzY5q1W3T0efQ0j7zvDp4IcGeAvvC3XWnkJPqZKgdFKzkYsxwvj3J2vHwkPNbY0HJTb7f/phirmqzCwvcKICD650FaM7HGzbviy8j/DAhic9ZV+6kbiQ1Q2TT3gMBJYd7aJgLb++v6qmOgnWFUxBl/ckmz9efcxjvg98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRYR3Ntr; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2020430b139so259655ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 17:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724286385; x=1724891185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/ySssmJ41V2INbrn0iqR/C781hHKt3ltF0YIyWsfJgY=;
        b=TRYR3NtrOLs0c10+lmwfZegYWE47yuzseY9QeC1rX9EWi78g/S4sdB7Rqvt7tW0cDY
         pb2hScOTXg9qn339fSOGW7lVoeRkGSLe/pSxJ2M/HaVyZiiz7IhSoNzELcCKi75/YWBg
         urXX2ZwCFbxKSkCOxbLGUQmUJHytzzhovIkfVFTM5WIIFqxV+D7g1f+IkTolgxA43gz1
         AMWB1qTyuUa8YxV8wSgr9eziHPZmTy3vhfbiYbH7dLB5GD5pO/IqCGBDRDo2ECtNPMsj
         dEQ6c1eSEbIqir7nlIrZ7cvoWci+Lt0KAXGaDBM/RI4LWBY332pjHM/BIBuw0miefMjR
         pPag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724286385; x=1724891185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ySssmJ41V2INbrn0iqR/C781hHKt3ltF0YIyWsfJgY=;
        b=mmv7cXi+LgQdE6r9XpNOqJCuxIzecXsPYNqKDO3y/VCojyQJIUck5jq553D8GgnEz+
         Md7xtCuGqHAhz48LTY5iXXRTI/mQOHaFRkZgADEefjUbLdbn1cJJIvAzRsZ+jdon1xip
         1DGDgdIjkFyM7qKRy9EoKpiutLW6qEHXOM8uDZIln6DYT30WkVqaG5pEQDE0UiblIwJ9
         XGp1boPIZkUFPACiXrgekY2uPHWUEwKo6cQBt6QighV3UfvOWzBqvQKmI7+ErEKN0wt6
         86AjYORzKdlF3YQzSE8ZdvLDIMlW5IxsETTbONYNBBHAtReQUAbb3awqKi8xbEjaMAZ4
         HHyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQFjPv9jhZNa9N6MBbOB3JxF9vwunlXm3CxnYrYUBO6Jt+Hlbo0h/Nl1UmhYwmg/BWJ2dFlkA44Jnzf9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhX+JhB6enmoTKv6PoYCnkEbDAij+NtfZcP9k0lVHqL505aGi4
	bLcqrumST06zoDXc0ZiVze3AUpkNw2JNuncVAK5rSr8mjqTtwiez
X-Google-Smtp-Source: AGHT+IFyvhyHxU7tZd4t3B9/RQvMxzUmc5SQihqwxcYd3x5yBILtzMyQDl71W68Yc6CjzQ/QX7lVAQ==
X-Received: by 2002:a17:902:f0d1:b0:202:41cb:7d73 with SMTP id d9443c01a7336-203681b4bd6mr25185815ad.11.1724286385199;
        Wed, 21 Aug 2024 17:26:25 -0700 (PDT)
Received: from archlinux.. ([138.94.103.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038560f569sm1647975ad.220.2024.08.21.17.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 17:26:24 -0700 (PDT)
From: Christian S Lima <christiansantoslima21@gmail.com>
To: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH] staging: rtl8192e: fix parenthesis alignment
Date: Wed, 21 Aug 2024 21:26:12 -0300
Message-ID: <20240822002620.63732-1-christiansantoslima21@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fix line 1326 in order to silence warning
CHECK: Alignment should match open parenthesis

Signed-off-by: Christian S Lima <christiansantoslima21@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
index b3d4b3394284..fcef0def7148 100644
--- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
+++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
@@ -1322,8 +1322,7 @@ static void _rtl92e_query_rxphystatus(
 
 	if (is_cck_rate) {
 		pstats->SignalStrength = precord_stats->SignalStrength =
-					 _rtl92e_signal_scale_mapping(priv,
-					 (long)pwdb_all);
+					 _rtl92e_signal_scale_mapping(priv, (long)pwdb_all);
 
 	} else {
 		if (rf_rx_num != 0)
-- 
2.46.0


