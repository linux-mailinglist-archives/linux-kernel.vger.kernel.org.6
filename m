Return-Path: <linux-kernel+bounces-333056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A52DE97C2E7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 04:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58BB8283ACC
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 02:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3470D1758F;
	Thu, 19 Sep 2024 02:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1GfgXYb"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2763D17588
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 02:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726714592; cv=none; b=N6M/Y/bxMjbNEivHx57w5adtfQBOwASV2F65ILLBdNNEpe1IKAkn7MZ+l+QVM8ydqtkLaQbwmycDq7xAvL1CNZXYB5P61h4loLnxkSVJ9MPHjUIexHBchHE3y0QeyhasfBwhQf0fPeaG3U2+V5YQw+w/LbMIBZApemrDvQ/9f28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726714592; c=relaxed/simple;
	bh=ENvgyjReStAE41tUUhhU7m+p1u0Q16yYcDmxWcLik8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kE/7rVRvRMLrx6ZZLS0Aw27t6tXWE/hLFIF5eK/yzOiwKDi5xOimlXeg/vY12JPeLTu8y5+3QxmpYnYWfRH554TAJYAfKYe/MJXyNsP6XZBTGaQc0JYGfEP/ICTRomf/Ln8EJ3qrkW5U9lpJLJbnuTXv7fTt8ozV7lsDuzOr80c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1GfgXYb; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-207115e3056so3701385ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 19:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726714590; x=1727319390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L3z8aqN2PapGEchw6ngaiDWNeD417V3WkhQBwYXWFqM=;
        b=X1GfgXYbTWT+C+eL4PjaUDge1yvjGbwJCnnhBYS1NuTwQQMnkVw+afU8fkq05kdRK7
         LV/vxuBODHqSeJtd7MBy0EjsOEsBeeAOjXq67cYLg2OkzWJP1Ag5dcOnf/NTBDOXDDr2
         5bi8D9ihGbAOHWdG/rOeNRilb9j0jN4vcMqDFfhPlmUzDHDj190wAQTrtlJ6LZ2l/8id
         fJ+9tQ+K9EG6m/pmA5P2I5a22XlIizEz4Xl+pFVoz50XEVpY7V5zfZwKFjzZ5vciBTUG
         fWwJp5wxbr7yAi4iTfaZOCAA8j/TBxEkNAJN7fI/ZTIkXy2F2pfR11aLbEkVrrytfM8s
         HZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726714590; x=1727319390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L3z8aqN2PapGEchw6ngaiDWNeD417V3WkhQBwYXWFqM=;
        b=t609lF/pzxiJ0EvGzbYg6W0RD/78tjAAaTZ3dPwThrmmlr99yCJm9LNryKD0D0waSd
         GIndRsc8d2VB2HgsJrW0SMCEsnsqwH80D51iAbwXgVNkDe7eOYPf9P0EdvZY1kWqukZG
         DYvvyU7IIPCSgYAgFYTugAD5nZg7ykW0r5KX9jC8X8Uq32Vb8DBiX+hh/89sB1tXqguh
         NawydcQOvokH5Yym5ZQynevUnqYACKitZEk6dJqdAAY+9nj3Y+Uat0wgXzeaNPLfAcay
         vhN4R+O/bRKLMvtIlDKNiZYgZ3gnvdhK3kTnnMlvLoffUsq8EPb+bkojARoMWEpdS4Je
         QNxw==
X-Forwarded-Encrypted: i=1; AJvYcCVw7GVSaddxD7/0o83oX43I1OS0gJ2yuaCfYFPjxeRKnu093z+jU7AlHU7Ri92uZWfUooBnE6cV9eF7HfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKWlvb6AtVFaNTkqM545znnxzA7J0Cuy43jq+jgWIDQpsYYs1R
	sBA51O+ypCO1aA0O9emqo8w0A43LKNvFQZWVEGElopkUBN1mCrtc
X-Google-Smtp-Source: AGHT+IG3E3x5sXQMsxEWayCG7th6zZkwGaojJWrlU5aw9OEqWkqNzOuRCe7304FOOtHaaUGVabeHyA==
X-Received: by 2002:a17:902:da84:b0:206:c911:9d75 with SMTP id d9443c01a7336-2076e3b2654mr336649595ad.20.1726714590396;
        Wed, 18 Sep 2024 19:56:30 -0700 (PDT)
Received: from dw-tp.. ([171.76.85.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d2823sm71389105ad.148.2024.09.18.19.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 19:56:29 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Hari Bathini <hbathini@linux.ibm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Donet Tom <donettom@linux.vnet.ibm.com>,
	Pavithra Prakash <pavrampu@linux.vnet.ibm.com>,
	Nirjhar Roy <nirjhar@linux.ibm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	kasan-dev@googlegroups.com,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	linux-mm@kvack.org
Subject: [RFC v2 01/13] mm/kfence: Add a new kunit test test_use_after_free_read_nofault()
Date: Thu, 19 Sep 2024 08:25:59 +0530
Message-ID: <a8ca8bd5eb4114304b34dd8bac7a6280d358c728.1726571179.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1726571179.git.ritesh.list@gmail.com>
References: <cover.1726571179.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nirjhar Roy <nirjhar@linux.ibm.com>

Faults from copy_from_kernel_nofault() needs to be handled by fixup
table and should not be handled by kfence. Otherwise while reading
/proc/kcore which uses copy_from_kernel_nofault(), kfence can generate
false negatives. This can happen when /proc/kcore ends up reading an
unmapped address from kfence pool.

Let's add a testcase to cover this case.

Co-developed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Nirjhar Roy <nirjhar@linux.ibm.com>
Cc: kasan-dev@googlegroups.com
Cc: Alexander Potapenko <glider@google.com>
Cc: linux-mm@kvack.org
---
 mm/kfence/kfence_test.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/mm/kfence/kfence_test.c b/mm/kfence/kfence_test.c
index 00fd17285285..f65fb182466d 100644
--- a/mm/kfence/kfence_test.c
+++ b/mm/kfence/kfence_test.c
@@ -383,6 +383,22 @@ static void test_use_after_free_read(struct kunit *test)
 	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
 }

+static void test_use_after_free_read_nofault(struct kunit *test)
+{
+	const size_t size = 32;
+	char *addr;
+	char dst;
+	int ret;
+
+	setup_test_cache(test, size, 0, NULL);
+	addr = test_alloc(test, size, GFP_KERNEL, ALLOCATE_ANY);
+	test_free(addr);
+	/* Use after free with *_nofault() */
+	ret = copy_from_kernel_nofault(&dst, addr, 1);
+	KUNIT_EXPECT_EQ(test, ret, -EFAULT);
+	KUNIT_EXPECT_FALSE(test, report_available());
+}
+
 static void test_double_free(struct kunit *test)
 {
 	const size_t size = 32;
@@ -780,6 +796,7 @@ static struct kunit_case kfence_test_cases[] = {
 	KFENCE_KUNIT_CASE(test_out_of_bounds_read),
 	KFENCE_KUNIT_CASE(test_out_of_bounds_write),
 	KFENCE_KUNIT_CASE(test_use_after_free_read),
+	KFENCE_KUNIT_CASE(test_use_after_free_read_nofault),
 	KFENCE_KUNIT_CASE(test_double_free),
 	KFENCE_KUNIT_CASE(test_invalid_addr_free),
 	KFENCE_KUNIT_CASE(test_corruption),
--
2.46.0


