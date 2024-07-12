Return-Path: <linux-kernel+bounces-251224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B403A930254
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 01:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7614B283A54
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 23:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC64130486;
	Fri, 12 Jul 2024 23:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="P6bR8M6o"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4479376F1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 23:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720826264; cv=none; b=ts3e2pFUHw1n/iUiz87Dfr18sw64xNuavRjIqdZORi3GQNqKTONAj6bxxc50flupn8pc+/ybgOb0lTSm7lHoJZyEB/ivcdSE1AdO1pY5G8qTXJqPwCCT4rove2rmDXlwQd9l48PCQdi4dCiR39LKfC5WLPuEpK14Xw5WclYkAqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720826264; c=relaxed/simple;
	bh=QYgVRyzH8PcMNACMLIrauxK296Rh5jioM9J1lSlVUyk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tP4rcHiC+HvXYAWFSgLNw5lcUvqH8WQCZl93FeMKjUH46s7TAWc5C0aI9K52gdZlEDrW4o7cNTHZAxLhru4RZjYiN55pFfyjIwqpnMChwTd0DuQL/dmCbnRJnGPiJcIADxcVScmurXCE0XF+ceV4KxBWCJLY4sHCWPbmiGHrdU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=P6bR8M6o; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70b12572bd8so2122889b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 16:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1720826262; x=1721431062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UZ/x0PvWt6cH5OnfaR+19VuRmz9ObiIe9IQ/Uhq9F24=;
        b=P6bR8M6of7AP2f1RHPwHJDWbjumG3sqdwQGNonMdF7BdNDWfC/Wbt2hXC4WaUWhQ49
         0qpK/k3Um6qlOuBFjB16hPu17XShjVpIteW/77o+aDfBKZC6/wGFT+5NkhmoyRomTmNv
         3Z4sOnTdET1yiaKZMyn2E4Q1C4Qz5VHJAfV5eYQinISOzXRp0HK/MbMV9cSUQn7gC5H3
         jxaT+T0uHaeQsfcB9pYiJZ2JSl9cxB8uLUVOhOw0wBlb5edtr72x7uqT0ruxr6RtIqEN
         71jOhjj/3IboJzebEWJl6caD51AullwwXV84bsfL1KFgZ88zCLeFF9avsfEpIOUM4Dmm
         iheQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720826262; x=1721431062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UZ/x0PvWt6cH5OnfaR+19VuRmz9ObiIe9IQ/Uhq9F24=;
        b=LumcGymrgg9xt070JwvR6J4hyI6yhiOPMjvHF+uzgKyR9FyDaqsAW9VlwcrrlEZBz8
         PHIuF4o8VtgJsEXHAyWpKPQkMXMHfCStxgubDOhhGpyMud1iDSXRmPDoCdO+DmKy/OUm
         ByLY1ngDmAbc9X5g8Umx47hW3jvlaaqCanIIXQgJZ0FX/K85HDV2HRWqhMOSXeYqh5Tb
         ih3OPNP14L40i4Pyt2uEWtrg5qOr1uhAel1DdHA2XgNHN0FWw+l1EimKttjSE63UJjM5
         ymcekEqUeOZvdBB9w0D50wV0VzqVwqMVUd/p/687ty7bTzzl6bF08oPjqjd5u0lHQL49
         4b/g==
X-Forwarded-Encrypted: i=1; AJvYcCWHT+/vq5qyY2C+qMkRsvZiOV0SYQSH2eFso54TLG+mKcgsdeuM2S0C1Zy7M1RJT8WjLsUnk8OCjLcMRN53pX9MNVU1nIj2robFyrkN
X-Gm-Message-State: AOJu0YyJrNcO843BQky6VSQFMEcPXlOD4Lay42e+hNbCuiTcLF90FeXr
	Sn6P8r9ezg0XG47Juh9NSj5nR3MbnfI+k4ij28p09nDYIL2e6zpLb/kp4BSCAeM=
X-Google-Smtp-Source: AGHT+IHLHwjE5E7P2KMkGKIVL/NKhjh2eaHWxkdiky4ouJUHcC8YM7Sv7rhWy/oTO/b5bjM+LvWERQ==
X-Received: by 2002:a05:6a00:3d08:b0:706:5dab:83c4 with SMTP id d2e1a72fcca58-70b43576a80mr13644912b3a.14.1720826262020;
        Fri, 12 Jul 2024 16:17:42 -0700 (PDT)
Received: from alpha.mshome.net (ip68-4-168-191.oc.oc.cox.net. [68.4.168.191])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d5f0ab0d8sm6292960a12.19.2024.07.12.16.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 16:17:41 -0700 (PDT)
From: Remington Brasga <rbrasga@uci.edu>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Remington Brasga <rbrasga@uci.edu>
Subject: [PATCH] kselftest: missing arg in ptrace.c
Date: Fri, 12 Jul 2024 23:17:30 +0000
Message-Id: <20240712231730.2794-1-rbrasga@uci.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The string passed to ksft_test_result_skip is missing the `type_name`

Signed-off-by: Remington Brasga <rbrasga@uci.edu>
---
clang-tidy reported clang-diagnostic-format-insufficient-args warning
on this line, so I am fixing it.

 tools/testing/selftests/arm64/abi/ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/abi/ptrace.c b/tools/testing/selftests/arm64/abi/ptrace.c
index abe4d58d731d..6144f83f8ab4 100644
--- a/tools/testing/selftests/arm64/abi/ptrace.c
+++ b/tools/testing/selftests/arm64/abi/ptrace.c
@@ -156,7 +156,7 @@ static void test_hw_debug(pid_t child, int type, const char *type_name)
 		/* Zero is not currently architecturally valid */
 		ksft_test_result(arch, "%s_arch_set\n", type_name);
 	} else {
-		ksft_test_result_skip("%s_arch_set\n");
+		ksft_test_result_skip("%s_arch_set\n", type_name);
 	}
 }
 
-- 
2.34.1


