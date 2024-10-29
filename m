Return-Path: <linux-kernel+bounces-386886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD19E9B4917
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEDF21C23810
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424A0205E21;
	Tue, 29 Oct 2024 12:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fsn66LdY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDBA205138
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730203631; cv=none; b=O50ghRMTIJQrqo5PM96u/B7aE302OLbUl4FgWY2d9fq5+V/H0fErMRwdA8ERoEi1Mi3ZzDRmyY5+OaOj+nNn8/rFj8hH/9m66/zAwRoJIo2JDQjj6cZ+tJJFYwh/Kg4WPPKd2Gj3kVRRMEUfGpGwjrl85q6qs22p4HYXahjiIVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730203631; c=relaxed/simple;
	bh=kiZLkwF8fQO96OiGl46+TaQWs5mkDteNFUwQ8IXPdw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D7qauX0u4UsAW7yxwXJ1J++W1MUAZroA26uHEIt8rRYpG0QIC/Dj/FnWD6cwJ+p94mZW1iVLSbCYgB+L4vltCS2AfCDq4TWeGMo2aI93VEAIBQyDLYrdOcobkqbUxdMHJtT6mAb60iW7uw5uI2GDzknro/C38eWwL24fA6/R9eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fsn66LdY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A757C4CECD;
	Tue, 29 Oct 2024 12:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730203631;
	bh=kiZLkwF8fQO96OiGl46+TaQWs5mkDteNFUwQ8IXPdw8=;
	h=From:To:Cc:Subject:Date:From;
	b=fsn66LdYCVr4VzXxIPYSry3ByPNOpNR1rIMElECX0rWRzNt9nP1WpesiOxWN2HrjV
	 p1p3v8vwUrPQC0VE0kWiTLj+h/FThg083o5CQyx0SskDCbjvDq64+IPlRKhH+HRCfk
	 CUuOKA0reUClb9rzd0aYjm/MwXmH8FkN28+YMUZfZ2cO4/tXoV96lQlZcA9JMKkc7x
	 o9C8NK8bPrYvKsQhzqbf06IotakpMI0jxGYlD5l7A2sQihB0MfDSIYpFXG1lOyL4O5
	 vD4GMBcdPlPc7vLsD1YGFq2sXyYF1WBIAUdCd6JmrjxMEPwtXsMCTJ2I6t1TkBiabX
	 9KJhgWlKiBYKQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Russell King <linux@armlinux.org.uk>,
	Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: pmuv3: Add missing write_pmuacr()
Date: Tue, 29 Oct 2024 07:06:02 -0500
Message-ID: <20241029120602.4061566-2-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix compilation on Arm by adding missing static inline write_pmuacr()
declaration.

Fixes: 0bbff9ed8165 ("perf/arm_pmuv3: Add PMUv3.9 per counter EL0 access control")
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
Sorry about this. Feel free to squash this with the mentioned commit.

 arch/arm/include/asm/arm_pmuv3.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
index d242b5e1ca0d..2ec0e5e83fc9 100644
--- a/arch/arm/include/asm/arm_pmuv3.h
+++ b/arch/arm/include/asm/arm_pmuv3.h
@@ -212,6 +212,8 @@ static inline void write_pmuserenr(u32 val)
 	write_sysreg(val, PMUSERENR);
 }
 
+static inline void write_pmuacr(u64 val) {}
+
 static inline void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr) {}
 static inline void kvm_clr_pmu_events(u32 clr) {}
 static inline bool kvm_pmu_counter_deferred(struct perf_event_attr *attr)
-- 
2.45.2


