Return-Path: <linux-kernel+bounces-380509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0939AEFBF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 20:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 124451F22B33
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1973F2010EA;
	Thu, 24 Oct 2024 18:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jO59gRw+"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297E4201013
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 18:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729795003; cv=none; b=I3uGOXVxBun6iG0scB5aAwDWxZg0lsthte5yQqSXghE51uVIxREZ3zL2vmM41ArsgBjLtpVjaTj9uBSvj5byckqdnp4LSYi3kCT3gs/xlfYrLigu/45vqqT3ebgsMvrn7O+2VS9G02cUezpYKOSYmD34roMj5CGYB3DwBE4zRsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729795003; c=relaxed/simple;
	bh=/y6OxllrUT1nN0LgLmw3lPkqW4Tw1P93wwYxo4f1gmI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gy6biLsujUZ1BCaNAb35DK3tlpwiQK8fIucaJVgfaRiTAitTmHBHImwtaHvjH4f/Q0vKrWO4//bxt2jZsxpAoIMBxLoTnDpkm74mHO0pOD6U54LhFxToULqSjUXny8pM9BDUTe5lbjKw+0axzYqHMAtc6/H+m2b/plmML25+WOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jO59gRw+; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2e3321aae0so2326294276.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 11:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729795000; x=1730399800; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z5wH8AnQS7+BaI6kmGVBGOrDe1FUvidsmVrFSdWsbto=;
        b=jO59gRw+z2z4+gidlBFQa54CvElBOouGNJKhFNtvHJNCfPl3baPcGmUeAgnQMCknjl
         BhBju2WC8/m//fV+Mf5r3gCbgFWbmacS6CUK0TWIaDf/AxPX8aER9I3ydLqdGDzKbAj1
         Sqj1OkuBzYOzKNMmyV9ps+cST19FTrkjk9wss0jEJyXWzY4pqbVZQ8Ole31vWqgDelqY
         8G+RXqB/O+B4i1moy7+ssx7afBSFYcevooVEj/4UUfQQTOPrYGjmUz1sTs94+TbLXLDX
         W/vJjAUBr0T/eijrSjRRah3DrYyDdPQMXinqiTSEe0j3ij2iHpg/mftAGLTNT8QLWtxq
         Q50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729795000; x=1730399800;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z5wH8AnQS7+BaI6kmGVBGOrDe1FUvidsmVrFSdWsbto=;
        b=vkLjOKoiL+/CL/QAxb9b5+hnoxqrGGU3pUV+/CogB1P0pikL+kOLP28Ki9gdpW4SPO
         WCowtuXbX3dRg7Ej0Tyg6BW8NfWRBl1QCMqBtlh368s+YFyujocKmuSO3yX4CI9pyllE
         4tlj51PjFp3k/MLqTlCYSgpKrSaAxDaKJYPUK8cQdYT1bPOkFwKrtS0/yocS8wyolSXd
         k/1JqfC6Fy91rY62osoJYCDst4bFrR74hiOvNvIeDrMZMv6Sjv5WvOqUn6vbfyyW69ez
         yOmXFIlUJT9R+/IRe1VuP9b/i7t0OISNecFs9sqo7csgV/R4U358/5kGkiF1KRNrtPpz
         SDjw==
X-Gm-Message-State: AOJu0YwNA0Yl+kEQUdtsxoSOdVd8zOcpSOZv7UlJLEU2o3FvWy3pBBYH
	aqoDNJSTodUSpR5nh4JHRJZG7aDwlvP/82u3RtHrxs+IJ22ckDFxxXFGCFzuYwMl9cSITpEvt9J
	f5IodpcqAyA==
X-Google-Smtp-Source: AGHT+IGkKVPnTjJs6U5A2GreOrOdPMRV2LTjYukXzULIzZf1LKre3y7W/hjlkjFOS0EB6yCjYAW8oAnmRkYqBg==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a25:ad5c:0:b0:e2e:2c0c:d02b with SMTP id
 3f1490d57ef6-e2f2fc2730amr1372276.11.1729794999539; Thu, 24 Oct 2024 11:36:39
 -0700 (PDT)
Date: Thu, 24 Oct 2024 18:36:27 +0000
In-Reply-To: <20241024183631.643450-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241024183631.643450-1-cmllamas@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241024183631.643450-3-cmllamas@google.com>
Subject: [PATCH v3 2/3] lockdep: clarify size for LOCKDEP_*_BITS configs
From: Carlos Llamas <cmllamas@google.com>
To: Boqun Feng <boqun.feng@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Carlos Llamas <cmllamas@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
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
index c8b1db37abe6..5a769cbf4bb2 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1522,7 +1522,7 @@ config LOCKDEP_SMALL
 	bool
 
 config LOCKDEP_BITS
-	int "Bitsize for MAX_LOCKDEP_ENTRIES"
+	int "Size for MAX_LOCKDEP_ENTRIES (as Nth power of 2)"
 	depends on LOCKDEP && !LOCKDEP_SMALL
 	range 10 24
 	default 15
@@ -1530,7 +1530,7 @@ config LOCKDEP_BITS
 	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_ENTRIES too low!" message.
 
 config LOCKDEP_CHAINS_BITS
-	int "Bitsize for MAX_LOCKDEP_CHAINS"
+	int "Size for MAX_LOCKDEP_CHAINS (as Nth power of 2)"
 	depends on LOCKDEP && !LOCKDEP_SMALL
 	range 10 21
 	default 16
@@ -1538,7 +1538,7 @@ config LOCKDEP_CHAINS_BITS
 	  Try increasing this value if you hit "BUG: MAX_LOCKDEP_CHAINS too low!" message.
 
 config LOCKDEP_STACK_TRACE_BITS
-	int "Bitsize for MAX_STACK_TRACE_ENTRIES"
+	int "Size for MAX_STACK_TRACE_ENTRIES (as Nth power of 2)"
 	depends on LOCKDEP && !LOCKDEP_SMALL
 	range 10 26
 	default 19
@@ -1546,7 +1546,7 @@ config LOCKDEP_STACK_TRACE_BITS
 	  Try increasing this value if you hit "BUG: MAX_STACK_TRACE_ENTRIES too low!" message.
 
 config LOCKDEP_STACK_TRACE_HASH_BITS
-	int "Bitsize for STACK_TRACE_HASH_SIZE"
+	int "Size for STACK_TRACE_HASH_SIZE (as Nth power of 2)"
 	depends on LOCKDEP && !LOCKDEP_SMALL
 	range 10 26
 	default 14
@@ -1554,7 +1554,7 @@ config LOCKDEP_STACK_TRACE_HASH_BITS
 	  Try increasing this value if you need large STACK_TRACE_HASH_SIZE.
 
 config LOCKDEP_CIRCULAR_QUEUE_BITS
-	int "Bitsize for elements in circular_queue struct"
+	int "Size for elements in circular_queue struct (as Nth power of 2)"
 	depends on LOCKDEP
 	range 10 26
 	default 12
-- 
2.47.0.163.g1226f6d8fa-goog


