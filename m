Return-Path: <linux-kernel+bounces-536302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7482EA47DEF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3804D1893219
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA7122B588;
	Thu, 27 Feb 2025 12:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="N8sF/g18"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27967231A5F
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740659826; cv=none; b=tZYxwMWp9S4UvYWL4EXdUPglrabyAB8JO9SJ2V90ha2fxV9GGevEQE0I5BoY6rWxM1U3wRIlCavGH6N9jBtYVf7BzIkI8sq7Qr7rhsgFYXbEKt4Z22/KP/SggpBEiB4CfO6HGqziJ/hyt/3c4P3oc9u4ni9QV/KkM6X0yIGFtak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740659826; c=relaxed/simple;
	bh=Z//TrE4r/P2ORzzHAfm4GTTR/FxL7V8in1j3CWT877s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZbyluQ4cIUTMpoFzsmYm4Kti5nGDu8TLOgQHE9Fn9SCXpIRiVXOM2XDKO1eLYQ9YOZ/Zb4VFZneOoCoSWKDjb1OQfmPo4N7VKv7D3uktyJYKB5t7nDEi+U/blbdpcpVb1qQx4h+rMcalTvKDpBZnXB+9ENiaFeOSmztSbQuUPcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=N8sF/g18; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22356471820so7770795ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1740659824; x=1741264624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtQ05xO+EnCCpS3XXknTi9mJFSuRz+8Y7aZxhDwaUdc=;
        b=N8sF/g18F4mULr2QnOeMcijsv9rbPzKDiy535tf7ppdmm6v90UZrtJ+px9jcdoKXXR
         nc2bbymnOr+QWE3R6+lNFbdCR6Dzye5GzAAMBAJZ3u3BZEBpCJ/KBhBcJKuSUwPJYaps
         wnFoL67qy8MkzA1QCI3Njl/g55O+s1PNcRCd9OW70JKtoQFwuqd0nvsWVsOd6x7ayG5O
         4uwbHPvTklIYnX1VO+UcFvY7cQ/wf+1GhZZRsS0vXrmBOJW8fJtQwS0FhVzSNtQT/rrt
         RqqKtX0SSI1b4AMgabkD/VhcU+q6dp/RbY51yghXY4GzNbElV/VTJZGatbR7r2s3ePH/
         UQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740659824; x=1741264624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TtQ05xO+EnCCpS3XXknTi9mJFSuRz+8Y7aZxhDwaUdc=;
        b=N0KKpMgpsXYjv1jDvsUVYiHHTif/utCvm1Cfkl2MB/xycu2zQfCmQqyW2xMuhkoUZS
         1slMQZnC89PjolhUjxH37uDtAjcwyFxlkjB8dJ6oCpZHpu+qAXg2eMT99RSoBwhfA39E
         JI+BkrGYCYVwhPSAbxKzqbVjx6vCKQmT1mnMQdB/kmbrzJHyfZa2eSvw0DBHwW/qJOn0
         ai5YaiRFcX6DgL6VMYTgBd417iNXZdCs4H3yh5dA8hq+hGacaF1fCvIei+/SG+LztU4S
         1NUoa9xMPMvdX2YnA2kXq+1MZOUqX2qfYsYlTlodih3o2Jwk0Xpiu//6538QFwHWrSot
         jWRg==
X-Forwarded-Encrypted: i=1; AJvYcCWtpalEg8AMsImbQq5oFHb8s2DWjWJwSEIIAwJNi3aybzeoqGfMoZOVyXxmMKOudQicqMUnkAlLHGjLk78=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGTqShoj9bXeQUb1KP5Y/5yFFp6PoDML7ezmUsubSGqED4g0yX
	23tSe4glD5jBjUOL+G0ptQ0JrKtow+EPUNE9fOYaJ7Gx70gBwc5crlJ9Aq8zmc8=
X-Gm-Gg: ASbGnctZORtX3QA1T2u56nMidOI4MzketCQSLcZQSVJlyQIw2LG0CL7jEbjCq1qGAfQ
	RXm6+Wr9Q5UjXN4WgIvjLJzJnCZSZZxSwhHdLReyXsB5PNwz6n51ZmB+Y1sId/o6vCvBWDQnI/J
	1xamOMrrHWt2ij+pGznxN9T+/Rl7qY5Rdq9HIXD6ddC8B/Zk+aaz1x/DOZWLwzFXcQC0C6/aLYn
	oP3g4PoUHUw+QIMQQMO9DdJ2Gcn56BIiExCFwcS/ZDZCsGSe6+EgNkhchuvk8l9biM8iT/ZRKPg
	t/zmeHfNG00kerenm7p4amze9+JSwPsQoIbE
X-Google-Smtp-Source: AGHT+IFkP7CS9xqANnPn4d9Sz+3RrDXTk1H1Jji56UTUSX5o72PLQQPlMQJClQVJhKn4XxMTw6Hpiw==
X-Received: by 2002:a17:903:2288:b0:221:331:1d46 with SMTP id d9443c01a7336-2219ff8278fmr376544635ad.2.1740659824356;
        Thu, 27 Feb 2025 04:37:04 -0800 (PST)
Received: from ventana-bhyve.. ([49.37.249.43])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5bddsm13219135ad.140.2025.02.27.04.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 04:37:04 -0800 (PST)
From: Himanshu Chauhan <hchauhan@ventanamicro.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-efi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	lenb@kernel.org,
	james.morse@arm.com,
	tony.luck@intel.com,
	ardb@kernel.org,
	conor@kernel.org,
	cleger@rivosinc.com,
	robert.moore@intel.com,
	sunilvl@ventanamicro.com,
	apatel@ventanamicro.com,
	Himanshu Chauhan <hchauhan@ventanamicro.com>
Subject: [RFC PATCH v1 05/10] riscv: conditionally compile GHES NMI spool function
Date: Thu, 27 Feb 2025 18:06:23 +0530
Message-ID: <20250227123628.2931490-6-hchauhan@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227123628.2931490-1-hchauhan@ventanamicro.com>
References: <20250227123628.2931490-1-hchauhan@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compile ghes_in_nmi_spool_from_list only when NMI and SEA
is enabled. Otherwise compilation fails with "defined but
not used" error.

Signed-off-by: Himanshu Chauhan <hchauhan@ventanamicro.com>
---
 drivers/acpi/apei/ghes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index b72772494655..8a1029163799 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1231,6 +1231,7 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
 	return rc;
 }
 
+#if defined(CONFIG_HAVE_ACPI_APEI_NMI) || defined(CONFIG_ACPI_APEI_SEA)
 static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
 				       enum fixed_addresses fixmap_idx)
 {
@@ -1249,6 +1250,7 @@ static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
 
 	return ret;
 }
+#endif
 
 #ifdef CONFIG_ACPI_APEI_SEA
 static LIST_HEAD(ghes_sea);
-- 
2.43.0


