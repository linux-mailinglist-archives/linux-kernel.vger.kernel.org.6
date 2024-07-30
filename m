Return-Path: <linux-kernel+bounces-266697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71723940582
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 04:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16AB51F21E58
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 02:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68116286A8;
	Tue, 30 Jul 2024 02:50:16 +0000 (UTC)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1F811187
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 02:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722307816; cv=none; b=Ir3yx1i3anz02eS6xYUJLZHejmveC+5+b2509/XgN1upPE2+k6nYpcf0aerOpdD8gq5NvcuIsKGBujp27rzWeBbFIr797pObqxZV945xaLyig55j2kAbL0Ul1zTHtEr9L6Ww00Q6/EN2nz7nquc6k4oWPv0ib/9mAqdUB1Flm2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722307816; c=relaxed/simple;
	bh=d4AAtdpiVcqtblplTUerKHN2Gfn/qxD6PMdHt3nkN7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dk/gyrQ9USYniSbgM5wTdE9g7kyX3LS8W4HEkCjQTc81TmUfRAtMtwSUN1mFFbLGJ4B072zfDVLZYFNWBeaUneAyov5m0eX7Pa/DX9mlnH4rLgcPWKSkYTSP3YZTBq0Otb72VrRZN8bLrUBqR1AA2Qbg03kcb9xKUuGmBS3VliQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp89t1722307787tix1ez7j
X-QQ-Originating-IP: plZbv7fD9m5728FOzOd6QOnUfiMt0RJInxk2mVrt32Y=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 30 Jul 2024 10:49:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10170749019226549382
From: WangYuli <wangyuli@uniontech.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	wangyuli@uniontech.com,
	seanjc@google.com,
	xiangzelong@uniontech.com
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	wubo@uniontech.com,
	guanwentao@uniontech.com,
	baimingcong@uniontech.com
Subject: [PATCH] x86/cpufeatures: SGX: Adjust the error message when BIOS does not support SGX
Date: Tue, 30 Jul 2024 10:49:31 +0800
Message-ID: <D345627B0A699F37+20240730024931.1026933-1-wangyuli@uniontech.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1

When SGX is not supported by the BIOS, we still output the error
'SGX disabled by BIOS', which can be confusing since there might not be
an SGX-related option in the BIOS settings.

As a kernel, it's difficult for us to distinguish between the BIOS not
supporting SGX and the BIOS supporting SGX but it's disabled.

Therefore, we should update the error message to
'SGX disabled or unsupported by BIOS' to make it easier for those reading
kernel logs to understand what's happening.

Reported-by: Bo Wu <wubo@uniontech.com>
Link: https://github.com/linuxdeepin/developer-center/issues/10032
Signed-off-by: Zelong Xiang <xiangzelong@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
---
 arch/x86/kernel/cpu/feat_ctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/feat_ctl.c b/arch/x86/kernel/cpu/feat_ctl.c
index 1640ae76548f..4a4118784c13 100644
--- a/arch/x86/kernel/cpu/feat_ctl.c
+++ b/arch/x86/kernel/cpu/feat_ctl.c
@@ -188,7 +188,7 @@ void init_ia32_feat_ctl(struct cpuinfo_x86 *c)
 update_sgx:
 	if (!(msr & FEAT_CTL_SGX_ENABLED)) {
 		if (enable_sgx_kvm || enable_sgx_driver)
-			pr_err_once("SGX disabled by BIOS.\n");
+			pr_err_once("SGX disabled or unsupported by BIOS.\n");
 		clear_cpu_cap(c, X86_FEATURE_SGX);
 		return;
 	}
-- 
2.43.4


