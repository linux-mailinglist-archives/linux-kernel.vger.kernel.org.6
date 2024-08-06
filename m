Return-Path: <linux-kernel+bounces-275523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CB89486D5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 03:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA44B1C2264C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 01:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD0A12E75;
	Tue,  6 Aug 2024 01:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bas5WlYw"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFBDC2E9
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 01:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722906102; cv=none; b=StDxStGOhN5T542tOZVevK30pIqYxPFINuKfdKpKX0QsRufKZ5alb+cSkrJYyBPYZgKFnuz7N5TYiUBXuIywpGbCdgbe1q3wnxF7pBgFkksKNa1Q6PBUQZ6laIq0BpuCO/8C0WDWUcVnz4QfsVW0rlkmjQJQLTYHxUBMhsHsxWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722906102; c=relaxed/simple;
	bh=WPQeRoVjbHyBaB1jP3uLP9qNWJc7u6TPtPAVY/T4QWc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eJsGQIPYqpvhk+8FHbDrURYUDhRFRdFTmlRJ70NLD1CPlxl5p6jXF1+taO6LbUJtbOHrU/vRTEH/IR1ndHV9rNKIxMwtr3cw/h1zcspyjOkQfZcayNFje5wq4mQvRXMuUNljfbLJSkBlRQodEngvp6qAn++TWBK5kKhasy/OxU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bas5WlYw; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1fd5fe96cfeso911275ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 18:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722906100; x=1723510900; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xF7GVsamqUptJkU2gJsmYYeaq0bMeaFAbotmm0oMB2I=;
        b=bas5WlYwSx3r/AzHbVCktkFxnLFtVRa5+k9DsxE9hI3YkekosbG5ir2xgUjqdm3oFz
         6O3HOBEcAqSZQLmsy3pEpc8kl+bkjlc+g2422zG8IdWgaK1vZeUolMpbuwfSYJTvrXHn
         CtyTTxuUYWdgxqjteesYBcDr2qdrxiRUEn1uDgi1DkgC/aE55p5dnQP5fIGhEF3cWoVJ
         gBCQLilbfBPWOvTFncIKz3IPicQyoRHk9FQfnvBCvyJXHPRwuNiDAKcNtow4w3Mbr8VK
         3hpzR4FRgog0N0MogJBALDRccEq+uTIBZVxA6zvAnx8iAofRruVF93e3U+zpw4nEkHpT
         SGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722906100; x=1723510900;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xF7GVsamqUptJkU2gJsmYYeaq0bMeaFAbotmm0oMB2I=;
        b=BKSXdsD/oBjrK7BujxviW5xGHU4ji3zWZLNKDhz+S/vQx+oqXjhO5MKaUA0IWoKGAz
         24mXDlUST30m/nECODxerOQZG3a12tlMgolzI/ixngx1WEy47rwmxdELbN9Higgvwjm0
         PBd2vNR5fc0JyRrf0InB6zEjlHL8Zu4arsIs8nP/COtag1Hj8kFOPxj5qSsCFhW1SHoT
         +z+A1AynAvYj+4LTZJOG+uReqcQ25nDpY2pdnCIFoCHimB3q66y25uToTxt4VadutMvO
         vYvCYCI10hPZC7cJO0h6KTXoidT5iI47j7TCkKtqEKHXIHHwvJ6nQ1KZ6unXivL8TMRq
         ISMQ==
X-Gm-Message-State: AOJu0YwOA7QNaq+47EmdmX6KnKfsB2hYO5f0yez4vfvfdLoGggQffjJE
	ZF9gljGAww1Gb2da9IrWD7s2WZXnvdpGCcuddBnZI1R8qigD37UsSXxdDCJp+haSi8bd31azmP1
	Enuf7gNf/eA==
X-Google-Smtp-Source: AGHT+IHnnOp7s9VQJe4Mo68TMAH3l/gac5t/LGDPThZwtPKP9hYBQadcdWj9W6S329YgBaaQyXsGdj8sSjN0Xw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:902:f54b:b0:1fe:1a92:5b2 with SMTP id
 d9443c01a7336-1ff57254d7fmr14295605ad.1.1722906099686; Mon, 05 Aug 2024
 18:01:39 -0700 (PDT)
Date: Tue,  6 Aug 2024 01:01:25 +0000
In-Reply-To: <20240806010128.402852-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240806010128.402852-1-cmllamas@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240806010128.402852-3-cmllamas@google.com>
Subject: [PATCH 2/3] lockdep: clarify size for LOCKDEP_*_BITS configs
From: Carlos Llamas <cmllamas@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Carlos Llamas <cmllamas@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>, 
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"

The LOCKDEP_*_BITS configs control the size of internal structures used
by lockdep. The size is calculated as a power of two of the configured
value (e.g. 16 => 64KB). Update these descriptions to more accurately
reflect this, as "Bitsize" can be misleading.

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 lib/Kconfig.debug | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index baaaedfde0cb..e0614a415348 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1505,7 +1505,7 @@ config LOCKDEP_SMALL
 	bool
 
 config LOCKDEP_BITS
-	int "Bitsize for MAX_LOCKDEP_ENTRIES"
+	int "Size for MAX_LOCKDEP_ENTRIES (as Nth power of 2)"
 	depends on LOCKDEP && !LOCKDEP_SMALL
 	range 10 24
 	default 15
@@ -1513,7 +1513,7 @@ config LOCKDEP_BITS
 	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_ENTRIES too low!" message.
 
 config LOCKDEP_CHAINS_BITS
-	int "Bitsize for MAX_LOCKDEP_CHAINS"
+	int "Size for MAX_LOCKDEP_CHAINS (as Nth power of 2)"
 	depends on LOCKDEP && !LOCKDEP_SMALL
 	range 10 21
 	default 16
@@ -1521,7 +1521,7 @@ config LOCKDEP_CHAINS_BITS
 	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_CHAINS too low!" message.
 
 config LOCKDEP_STACK_TRACE_BITS
-	int "Bitsize for MAX_STACK_TRACE_ENTRIES"
+	int "Size for MAX_STACK_TRACE_ENTRIES (as Nth power of 2)"
 	depends on LOCKDEP && !LOCKDEP_SMALL
 	range 10 26
 	default 19
@@ -1529,7 +1529,7 @@ config LOCKDEP_STACK_TRACE_BITS
 	  Try increasing this value if you hit "BUG: MAX_STACK_TRACE_ENTRIES too low!" message.
 
 config LOCKDEP_STACK_TRACE_HASH_BITS
-	int "Bitsize for STACK_TRACE_HASH_SIZE"
+	int "Size for STACK_TRACE_HASH_SIZE (as Nth power of 2)"
 	depends on LOCKDEP && !LOCKDEP_SMALL
 	range 10 26
 	default 14
@@ -1537,7 +1537,7 @@ config LOCKDEP_STACK_TRACE_HASH_BITS
 	  Try increasing this value if you need large STACK_TRACE_HASH_SIZE.
 
 config LOCKDEP_CIRCULAR_QUEUE_BITS
-	int "Bitsize for elements in circular_queue struct"
+	int "Size for elements in circular_queue struct (as Nth power of 2)"
 	depends on LOCKDEP
 	range 10 26
 	default 12
-- 
2.46.0.rc2.264.g509ed76dc8-goog


