Return-Path: <linux-kernel+bounces-344969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A8398B0C3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30C05282402
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131E5188CB6;
	Mon, 30 Sep 2024 23:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EpylYnZ7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA358187322
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727738549; cv=none; b=fz7nsTAIvltUdVnf7mvoYc/D5MSnwwo5fIYrYjCSD4ZTAL3W0FF737zidfEtKHNlKXrXa5aUR0CAuj6TYzU/VvhFN04lsXzjd0CNmJh4DgqBLVU63Mu/nie9OyrkfU6YH7EhBVpWQXCc2ooYEmwPFX7pGh78wnKK3ftVlYXgINg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727738549; c=relaxed/simple;
	bh=5+AiJaX4UtDbmRH5GAq9t1hjYK48PdL8+bwdm8fCAv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xy2AkzpGWO3SPKoJqzzl6G9IL0B39kLEt2N1xQGx1tYkPiCFYmAvYRxko90CYzXQYnUjkShxwf5OIVMb5cc0V+gOcb4r8m7My5ouzQFG7VbeMvidpsTMo8KMHS8d9cyMw2gXWVl+hvsUfWLGz2DoqAlbau4f11q5oXKWgduLjy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EpylYnZ7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727738547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VKQ5wXzAVJ56Zv2qJN0G0ZqtK5sCYXvmcnZQ07OdvaQ=;
	b=EpylYnZ7BPkKNB89JAkNuqjgf5Vt2rCyqOHX95CcYS0WQimh299ftPEXhzth7T7rEUS9wQ
	ngz8LsFbnjAzIdaW5ePHD3mKf/BYxNxPgi5tqO8l9y/oNQRtgGKF/1ylTnBObM8ntRSgi2
	umgmvr42Z59ZyrKh4kT7bFDI7gQ9NLo=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-MrfbKy2LN5at0WFm4-3B9g-1; Mon, 30 Sep 2024 19:22:25 -0400
X-MC-Unique: MrfbKy2LN5at0WFm4-3B9g-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2e0a47eb73fso6082736a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 16:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727738544; x=1728343344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKQ5wXzAVJ56Zv2qJN0G0ZqtK5sCYXvmcnZQ07OdvaQ=;
        b=EFIEI+5b3YRUaFB5lzN6HZeSyBDXpnlrRetczFG42pBkqI00CzVtoqR1lDDoFrAcmQ
         WlCYXlbMhwzV/RQJG/6Oqup3RL9U/FudaUiGgRNA98vVCNUJ2jUGMP2evNfGyWqDDC6A
         ylHlK+Fc5gC4PKNae/Oi5f3Z60gWCUBo6R7YIpJn3U2w4CBeQQBouEEFpcMoacWCp4tX
         TA7iNXK3tT8i/IAd7ikPE9Z4UJp+2kFvMa4CscLD1J9aYEx/yiDt0Fwcpe+X1iqPxn7C
         ZafeUbxEjRsLhbilN1sI21gzmYl6A6ezsZ600WXiKDYRvA1MvEE6yVpSDg15OERb1YcR
         TxUw==
X-Forwarded-Encrypted: i=1; AJvYcCWFGUD89+Bnq2AR7yC3aujZuENgjiW72ZKXnx5jQDOtiwtE+iRNa8WUBIRLMJQFLM+dhze3DDCnJNUzEbM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Ol63AeY8Web4A1FfyU5az6IzijSLaxkvwkF4/khl6QXkyJjG
	x0t0l8l/YR+c61Yh2Ct2784jg8/jGcd25J8AQqiU74BDX1DI6GV7ckqViz7UK8Te5JyGtnbmioX
	yyWrfRpQ3FAwS15Nv4gIiyBzPur6i97USENybJMRY/YGq9lXfDuxw6yjfb/rJn5yayrlRyjBv
X-Received: by 2002:a17:90a:e147:b0:2d8:a672:186d with SMTP id 98e67ed59e1d1-2e0b8b1bd0amr16498899a91.20.1727738544628;
        Mon, 30 Sep 2024 16:22:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpAD8gHdyuAIdyq8RdFdxD2qGC+R38kuvpPw+3wL6J/iRUtGseYVtWexsa41Ea35x3KpeH3Q==
X-Received: by 2002:a17:90a:e147:b0:2d8:a672:186d with SMTP id 98e67ed59e1d1-2e0b8b1bd0amr16498876a91.20.1727738544307;
        Mon, 30 Sep 2024 16:22:24 -0700 (PDT)
Received: from rhfedora.redhat.com ([71.217.60.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37d685b9sm59241985ad.54.2024.09.30.16.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 16:22:24 -0700 (PDT)
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
Subject: [PATCH 1/2] pm: cpupower: bindings: Improve disable c_state block
Date: Mon, 30 Sep 2024 19:21:54 -0400
Message-ID: <20240930232158.29024-2-jwyatt@redhat.com>
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

This commit fixes a bad comment, removes an unneeded code block, and
catches a few more states that cpuidle_state_disable with the test
script. Part of the motivation for this commit was I kept forgetting to
use sudo.

Signed-off-by: "John B. Wyatt IV" <jwyatt@redhat.com>
Signed-off-by: "John B. Wyatt IV" <sageofredondo@gmail.com>
---
 .../bindings/python/test_raw_pylibcpupower.py        | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/power/cpupower/bindings/python/test_raw_pylibcpupower.py b/tools/power/cpupower/bindings/python/test_raw_pylibcpupower.py
index 3d6f62b9556a..bb2b26db8b10 100755
--- a/tools/power/cpupower/bindings/python/test_raw_pylibcpupower.py
+++ b/tools/power/cpupower/bindings/python/test_raw_pylibcpupower.py
@@ -15,21 +15,21 @@ else:
     print(f"cstate count error: return code: {cpu_cstates_count}")
 
 """
-Disable cstate (will fail if the above is 0, ex: a virtual machine)
+Disable cstate (will fail if the above returns is under 1, ex: a virtual machine)
 """
 cstate_disabled = p.cpuidle_state_disable(0, 0, 1)
-if cpu_cstates_count == 0:
-    print(f"CPU 0 has {cpu_cstates_count} c-states")
-else:
-    print(f"cstate count error: return code: {cpu_cstates_count}")
 
 match cstate_disabled:
     case 0:
         print(f"CPU state disabled")
     case -1:
         print(f"Idlestate not available")
+    case -2:
+        print(f"Disabling is not supported by the kernel")
+    case -3:
+        print(f"No write access to disable/enable C-states: try using sudo")
     case _:
-        print(f"Not documented")
+        print(f"Not documented: {cstate_disabled}")
 
 
 # Pointer example
-- 
2.46.2


