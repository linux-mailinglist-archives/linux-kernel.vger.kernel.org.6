Return-Path: <linux-kernel+bounces-202987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7838FD44D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 19:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED4682867E2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 17:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE81E13A86C;
	Wed,  5 Jun 2024 17:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGLIpDd0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969AF19D894
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 17:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717609681; cv=none; b=YrbkSIMRF409BLxgLSYxWj+KF7N1BuuiqKfylbttALT4IJKdS/Kl46OSrNyYZLftaJGcqIRz5u60nt7wru+0xgSKH7y0yHLBwLaazHWvTiA6z8ZrBuUvCTpuy5qVTvF68qnnmMose/wlGAgLZaGBI7t5QyQ/oy/gvWraP8cB65g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717609681; c=relaxed/simple;
	bh=2ePoGtviorHv5MYlnnTCYKkNag6t8EfNqORat+63x4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=WUC1yXpRcIxoxc6Ofria2KhXXsyjZ2A5tTRhA4VBVAd6eSvxZv5rGN7Q/Js85BkFzu8q/FRsEZcYZJwYCQE7PffN1rimvfy92S6DLh8PFrDWQ9at4EoujMBuqbCmXflBRBtg4+QDTLKfPB26NylsZexL4l7yV6GlMriOl99SXn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EGLIpDd0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717609678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2YY7fTMX+q+tYZxy6V7LYKvYJ5cbuDxCJC3bLLYk/Aw=;
	b=EGLIpDd0rV0c4uWo6ZouTKDwg9ww0LRjsmwO5E8WjFnzp9W47qoEy6ss+/BQIW2zlF3ebH
	Hhy7osnsiEgcTVMxF4cTXRIRBwj/VGpnBcsJedSplvmQRT01Qh3QFHpZFkWNGvZ5OhbY/c
	udLAk4aS/m2WeAtDua7P0vRQ/AcukFY=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-DGB3z8kWMRGsqT0jIDvI1Q-1; Wed, 05 Jun 2024 13:47:55 -0400
X-MC-Unique: DGB3z8kWMRGsqT0jIDvI1Q-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-627e6fe0303so76897b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 10:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717609675; x=1718214475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YY7fTMX+q+tYZxy6V7LYKvYJ5cbuDxCJC3bLLYk/Aw=;
        b=vl/y66xRNRYH/sY1xAk9bRDa0lnxdVeEzOmFanU4F0tyv9bt6aXjsCOsc12RY5AcVa
         6PU5T5SWZOJANvjNEfyHXkILdUaBax8BhcFg0a3YHiTYqCa11kWhlk9EF+HYjG+mR060
         qYkSxqCw1qTciwx6vR55fmKQnS3Wr10H71b98jgh6vl0tRNOX5ApAFmmSb58i4HHPpuY
         RF/tQLHbUIC9qNz7VJ+uDyPnum2j7NDIyV+ygKMZnJSqWHje/PdYJJWNS3bXRO/EL8UY
         y6o41jIV6/ZHzEKZmZIjw4JmBRrNnnAGdYSs6Y81QZOM05U5za0k9lA620dZX1AMi0UN
         8ubQ==
X-Gm-Message-State: AOJu0YwyncBTsb1ncKPb+XEMsUW9ZPcldZ0O7MyjsoJO0nCgGdAQc4xp
	KL6iuQqkLGJUi0aW+jyumfmRC3IINirvlyft+Kep6vnoWg7SbK1CDV59UffYlcx4TnR+eIbG+jN
	WG9QbF3/XcbIIKaIb8NXKabT60gzx0fkqGHIU1P9xr/MAQC8eLQMqswXgk/Hkcg==
X-Received: by 2002:a05:690c:942:b0:61b:1d8d:8c11 with SMTP id 00721157ae682-62cbb48d578mr31659127b3.4.1717609675139;
        Wed, 05 Jun 2024 10:47:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbSNJBxU153XjsZBtK1DBKVSMon8g9mo0gRe8AL9qpVYgMgMXTRjRhJug8mVTAUkVuSgS11w==
X-Received: by 2002:a05:690c:942:b0:61b:1d8d:8c11 with SMTP id 00721157ae682-62cbb48d578mr31658987b3.4.1717609674834;
        Wed, 05 Jun 2024 10:47:54 -0700 (PDT)
Received: from x1.. (c-98-219-206-88.hsd1.pa.comcast.net. [98.219.206.88])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ae4a74e636sm50070696d6.54.2024.06.05.10.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 10:47:54 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	javierm@redhat.com
Subject: [PATCH] lib/Kconfig.debug: document panic= command line option for PANIC_TIMEOUT
Date: Wed,  5 Jun 2024 13:47:35 -0400
Message-ID: <20240605174736.778321-1-bmasney@redhat.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit

PANIC_TIMEOUT can also be controlled with the panic= kernel command line
option, so let's reference it in the Kconfig help. This option is already
documented in kernel-parameters.txt.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 lib/Kconfig.debug | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 59b6765d86b8..a6eb7425b888 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1043,7 +1043,8 @@ config PANIC_TIMEOUT
 	  Set the timeout value (in seconds) until a reboot occurs when
 	  the kernel panics. If n = 0, then we wait forever. A timeout
 	  value n > 0 will wait n seconds before rebooting, while a timeout
-	  value n < 0 will reboot immediately.
+	  value n < 0 will reboot immediately. The kernel command line
+	  option panic= may be used to override this option.
 
 config LOCKUP_DETECTOR
 	bool
-- 
2.45.1


