Return-Path: <linux-kernel+bounces-344970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D960598B0C6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 170731C212EF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622F318C909;
	Mon, 30 Sep 2024 23:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SLztyrPq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6492D5339F
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727738554; cv=none; b=TA5CVXQkLbD5fmi16VLBKo7yG/gM68UNCzd4MBwHbXHlL88gIAudR5P8gLZmb4T3XZAubce5mymQfDguiqRHp6CySjPrGlvt9bpSWdg7koJztY+7vifDBlRUVhnL4dpen8hlDY1y/Usk1hhi4ak5XLKR78aDYAX8Mxf0yeb1w80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727738554; c=relaxed/simple;
	bh=clfiWsrp4dGFaYI7d55/qc7iYZnYzDRDMc8mRva9740=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKAShbWv7u+9w5ZwTcmLgZNFd3sIdMrHOT71GHdvExnWZN+OdP2YQvOoIPq6WOuUhcbSft4/yVWHWSNsopzTybtlhU22K9RqX638rLgSaxbXothuSYbGNgdxYbLUc8Jd9c5tHQ0Ktx6gvXOLxl0DUU3MpzLxY2PX+ebWVbGFZOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SLztyrPq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727738552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hpg+FWuxwhA58ZIorLNy68eTkaxxlrOGEB+b9Y3QOMc=;
	b=SLztyrPqbcrdDwcggrzwDCCDBlDKhC/Ddzn/LZ5QdVKk8wkxDmbJG4BFLoyUYwCyqy2ZL/
	cmhDl4IpTJBrpNIeaKT2gviSqejE3CTsdlsPARgpU8K8uN+A4q+mkk0HSDV7u7x7CZfGX7
	EKOrQzHTWRvRTUQwRPWYUDzaIFpqBNQ=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-zohGQS-sP8apNsogHPmLaQ-1; Mon, 30 Sep 2024 19:22:27 -0400
X-MC-Unique: zohGQS-sP8apNsogHPmLaQ-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-20b410f0acfso32546225ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 16:22:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727738546; x=1728343346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hpg+FWuxwhA58ZIorLNy68eTkaxxlrOGEB+b9Y3QOMc=;
        b=FwUDv5Iz4l/TLPFBiJwAI1jFPGoem9vUe0aj+ldyVee+PjnQgfDPv5FePRGhyFF/Wt
         2WZXOuT7A/Akjn5gh9m1YExXfczJRVHsR6S0oCkOP0h0J+HvcjZnRSdXxsQ8W/HnK0T8
         +zfRCRWV8EwKkzwsCqbyF2AafWkK6PnZrx0tyYS5otQ7m9GMtK7lO2AMAw74zaC9N9n+
         Xs2AMXvFkK4esAD95GgvM3KEtQkj9+XPPqrcp52/2nXNCxcR77YT5dbmHhMFx8HKRG5t
         TWbifqyzQ0eYW4DtKPr/3gJ9fBnYe8m81n51pYYfUIDpuMu9Vtkacd/xBhb5gBJ8K47n
         0cjA==
X-Forwarded-Encrypted: i=1; AJvYcCXmrtkQ9D+/WMsh4krneLvbwqeCwdTjYscZYvLGkDAYzy8WPuBJQ9BbVg3lASNgWrqSq5aWdBfSdYi6rXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBB5GqFG0ZUXw5KXOCkcKXhvHBDEqJxRj8sa1BzeiAcQtALqh3
	jHas4vdIw3DXSxvQtGPPKKj/5V7+cCJmDw8ud+/CD3fpcCP0L0JDWyuaa5UZhL6qcELuPQEgp7v
	csHy9mx/Mtwb0KQx43U9C62/i9cdA2dHENl+xCPL7DkXDJBE05P8dfZ3KzKTA3I3gI+KEWxXw
X-Received: by 2002:a17:902:cecb:b0:206:ac11:f3fd with SMTP id d9443c01a7336-20b36ec9b08mr214932925ad.30.1727738546508;
        Mon, 30 Sep 2024 16:22:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnYVM3rVsKkpiUQxEbwOG3luHyMLmr1bdJqCCYCtJdpCXHQ7vbgtwthaQeN36rNE2/HI+hAw==
X-Received: by 2002:a17:902:cecb:b0:206:ac11:f3fd with SMTP id d9443c01a7336-20b36ec9b08mr214932605ad.30.1727738546155;
        Mon, 30 Sep 2024 16:22:26 -0700 (PDT)
Received: from rhfedora.redhat.com ([71.217.60.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d685b9sm59241985ad.54.2024.09.30.16.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 16:22:25 -0700 (PDT)
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>,
	Thomas Renninger <trenn@suse.com>
Cc: "John B. Wyatt IV" <jwyatt@redhat.com>,
	linux-pm@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	"John B. Wyatt IV" <sageofredondo@gmail.com>
Subject: [PATCH 2/2] pm: cpupower: bindings: Add test to confirm cpu state is disabled
Date: Mon, 30 Sep 2024 19:21:55 -0400
Message-ID: <20240930232158.29024-3-jwyatt@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20240930232158.29024-1-jwyatt@redhat.com>
References: <20240930232158.29024-1-jwyatt@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple test to confirm and print out the cpu state.

Signed-off-by: "John B. Wyatt IV" <jwyatt@redhat.com>
Signed-off-by: "John B. Wyatt IV" <sageofredondo@gmail.com>
---
 .../bindings/python/test_raw_pylibcpupower.py    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/power/cpupower/bindings/python/test_raw_pylibcpupower.py b/tools/power/cpupower/bindings/python/test_raw_pylibcpupower.py
index bb2b26db8b10..ca5aa46c9b20 100755
--- a/tools/power/cpupower/bindings/python/test_raw_pylibcpupower.py
+++ b/tools/power/cpupower/bindings/python/test_raw_pylibcpupower.py
@@ -31,6 +31,22 @@ match cstate_disabled:
     case _:
         print(f"Not documented: {cstate_disabled}")
 
+"""
+Test cstate is disabled
+"""
+is_cstate_disabled = p.cpuidle_is_state_disabled(0, 0)
+
+match is_cstate_disabled:
+    case 1:
+        print(f"CPU is disabled")
+    case 0:
+        print(f"CPU is enabled")
+    case -1:
+        print(f"Idlestate not available")
+    case -2:
+        print(f"Disabling is not supported by kernel")
+    case _:
+        print(f"Not documented: {is_cstate_disabled}")
 
 # Pointer example
 
-- 
2.46.2


