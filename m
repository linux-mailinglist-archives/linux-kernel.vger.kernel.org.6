Return-Path: <linux-kernel+bounces-373870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B289A5E35
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 10:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 528D21C22207
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 08:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D701E1A33;
	Mon, 21 Oct 2024 08:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOfVhyXW"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A951E0E11
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 08:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729498144; cv=none; b=PAKN3af6bRnOn3cS4WyGrO5mII+m7RfHWVGBwoga+XKHGueULyoUrNem+xOD7zyhN7LFg1JGGvWO+Af4ijOdIO6dmfd7VjtcaTNcvJVk/dN25E6nDT8TNAFPcIB8oWncSZR2UIldLTSPcEBmsj8IySDGPTgH9oBTEeGO1A0kkN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729498144; c=relaxed/simple;
	bh=a7fKioebAhttUy/bhAWb0W65CzDUUk4uYoOWLox/uhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XWMhoQKRz4Uku/elwOWLMaGxzzcHOGcDNm19U5pmQ439zQ202WNK0/t/1HtYd6w+gw9Gu001OytPn2Xouhe5Qd6r3TntyBUBlyoSnq7ap/yKI9bTnkcO2LCtkuNXWYT7OKdFH8Mq+EOjP2gzK4i5mD6VRE+nqZx2nctqEeg5doY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AOfVhyXW; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2fb5a9c7420so39499331fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 01:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729498140; x=1730102940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MgLMq6LBoZI6oopSlHmO6YDXt32997TqTP5A06Xl6xg=;
        b=AOfVhyXWn0pNUZv7oJUzGr7R+cYdLOPm+9+CTUld2jb1ZbzZMJf08pQIyP1RzOVnSG
         AzqiW/JUSRuZ039VWcdeEYQ9W6K+ptFPcWcdDkIXAUq7eDagkiHbCq8ldGK1eUA0/d9i
         nmxPAbfGxCPvlaGfavBoooU+KSV8n9oxENcehltujgOBlFuTogrzSyWaJWCDzOgaq1G2
         CX7323wK+pIoIzMpxu2QvVGBLdn4kySLB1CHADLZo5NSRfEEHj+kAVGThZaglgeVRolh
         zRnXhYRUBUVxmF1mRUe5hbLzZCu6rKcEmKH/cQ+2zBvmra9f/Hz+qt979bZYCNq1jLyt
         jT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729498140; x=1730102940;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MgLMq6LBoZI6oopSlHmO6YDXt32997TqTP5A06Xl6xg=;
        b=tvHoVEeyTpzTBDUgq9Zhi1hJW50Q093GxwEBN8OF0yMeeFfMh1pP52UB51lrQ5A0d4
         SCrLkVGz8neqpOnjzmLnF5Oib7iRVN9wI4YLKUOzyzDolzzWh1Yexl2vOq/wpA9tprZr
         yzA8A/vyrZDWaITQ2OsgKSKrWrJw7sFdNNyESs9zyRdKFs1ukflRoSdPazS9PCskjLcW
         EwQJOMp42cNEIu/0Ag5Qu3Zq6puGFBAfyzkBViZBBZzBCea//DUQ3N1WfgMCzjGv2/7Y
         KkQCmPNmEKEfitFP5Wsuq17/GxuK9oHAOgekJdlCr1M7EkzDE6CSs1vyPpTh7NIlycWY
         AgLA==
X-Forwarded-Encrypted: i=1; AJvYcCXpynfBIq70FZxB7g1MI3WLx4Nl6tYCupsQiSfxMTTmRawk2onH9J5sXY63TGBurYiVifIP+xPMIOi98cE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM+vb0GYJh4QiQEOXHFcSeFX/govoVSEHAomT5Qr7pFLJLb8NY
	QgYDV58sVKtffPe5xMxxEl06Hxxn9NwPYprsmGa2MrDFQuynWINGZId1ODgd
X-Google-Smtp-Source: AGHT+IGm0I9oGoA3OhrkX1KUADo64ViH/3eQUSQekHaiP/bGYrIQVdLkfV11y0l2rlbfKlc95r5Daw==
X-Received: by 2002:a05:6512:3da2:b0:536:54df:bff2 with SMTP id 2adb3069b0e04-53a1546fda4mr5124132e87.54.1729498140061;
        Mon, 21 Oct 2024 01:09:00 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.230])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a913706a7sm175925366b.141.2024.10.21.01.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 01:08:59 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/3] percpu: Merge VERIFY_PERCPU_PTR() into its only user
Date: Mon, 21 Oct 2024 10:07:36 +0200
Message-ID: <20241021080856.48746-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Merge VERIFY_PERCPU_PTR() into non-CONFIG_SMP per_cpu_ptr()
to make macro similar to CONFIG_SMP per_cpu_ptr(). This will
allow a follow-up patch to refactor common code to a macro.

No functional changes, non-CONFIG_SMP per_cpu_ptr() was
the only user of VERIFY_PERCPU_PTR().

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/percpu-defs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/percpu-defs.h b/include/linux/percpu-defs.h
index 8efce7414fad..7fa88c5f4b26 100644
--- a/include/linux/percpu-defs.h
+++ b/include/linux/percpu-defs.h
@@ -254,13 +254,13 @@ do {									\
 
 #else	/* CONFIG_SMP */
 
-#define VERIFY_PERCPU_PTR(__p)						\
+#define per_cpu_ptr(ptr, cpu)						\
 ({									\
-	__verify_pcpu_ptr(__p);						\
-	(typeof(*(__p)) __kernel __force *)(__p);			\
+	(void)(cpu);							\
+	__verify_pcpu_ptr(ptr);						\
+	(typeof(*(ptr)) __kernel __force *)(ptr);			\
 })
 
-#define per_cpu_ptr(ptr, cpu)	({ (void)(cpu); VERIFY_PERCPU_PTR(ptr); })
 #define raw_cpu_ptr(ptr)	per_cpu_ptr(ptr, 0)
 #define this_cpu_ptr(ptr)	raw_cpu_ptr(ptr)
 
-- 
2.47.0


