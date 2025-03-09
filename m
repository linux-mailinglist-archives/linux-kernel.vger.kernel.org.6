Return-Path: <linux-kernel+bounces-553229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8CBA58613
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 18:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D697A3ACD47
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 17:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E901E1DF1;
	Sun,  9 Mar 2025 17:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OG45qjfT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E3C1ACECF
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741540988; cv=none; b=RjIz/1EqCi75h3YTRoJuVXBT6+LFaf+WO0k4qGfCXNhIQO8dXlDifeY3fVgb80yBeONomDaxalu4NBjjQYK3gx3+S43MqNlRU+deNAaMDNnCbuuniwwqo6ARwPo0GGuns4BboZWr7Vd4GMXcaoZR1emmLTzhbUJYo46lEqQz68E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741540988; c=relaxed/simple;
	bh=PFe8M3duTHGeB2amgh9h4kldp1i8+4tkcSbjUXADo2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=nCgV+eCLoo7LcAdo7oPcAe7on7CgoMjJOv3WubdDXRZHC3oEiqKepFfCsCiiS1FkEtLJHP3yPLwzIvEtyngmQEM4ry792inGQ7SKnJX5Yk/fWznEX2AvbefLcsMCp8R9tfPCgWUPepcMP2rVfI0SzyVXvNIRWc+r4ECQROf/Ymo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OG45qjfT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741540985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mQ59WEnwBCLaXKBvNIRZMUSP5U8f8xPmFThCC0Y3exY=;
	b=OG45qjfTFjlDE6829fTXyI+t1x+Gnh0cD51fnseWsC6hGasvQ5CO3Vlh58461XP2p2K+kW
	LqAagYnJKMQIiruWBixXiqkS+/vqFF19pzisQUtGQewyDkc95JWsPLaSZXCcBLQhgFZbk1
	Yz6Ewq0n8bvYYW9IsC55S+Do/hZ1UO4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-itYZy2G7NuCQN40qRPn18A-1; Sun,
 09 Mar 2025 13:23:02 -0400
X-MC-Unique: itYZy2G7NuCQN40qRPn18A-1
X-Mimecast-MFC-AGG-ID: itYZy2G7NuCQN40qRPn18A_1741540981
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8EB0F1830305;
	Sun,  9 Mar 2025 17:22:57 +0000 (UTC)
Received: from rules.brq.redhat.com (unknown [10.45.242.4])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 72AD71828A96;
	Sun,  9 Mar 2025 17:22:51 +0000 (UTC)
From: Vladis Dronov <vdronov@redhat.com>
To: linux-sgx@vger.kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	Vladis Dronov <vdronov@redhat.com>
Subject: [PATCH v2] x86/sgx: Warn explicitly if X86_FEATURE_SGX_LC is not enabled
Date: Sun,  9 Mar 2025 18:22:16 +0100
Message-ID: <20250309172215.21777-2-vdronov@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

A kernel requires X86_FEATURE_SGX_LC to be able to create SGX enclaves.
There is quite a number of hardware which has X86_FEATURE_SGX but not
X86_FEATURE_SGX_LC. A kernel running on such a hardware does not create
/dev/sgx_enclave file silently. Explicitly warn if X86_FEATURE_SGX_LC
is not enabled to properly nofity a user about this condition.

The X86_FEATURE_SGX_LC is a CPU feature that enables LE hash MSRs to be
writable when running native enclaves, i.e. using a custom root key rather
than the Intel proprietary key for enclave signing.

Signed-off-by: Vladis Dronov <vdronov@redhat.com>
---

an out-of-commit-message note:

I've hit this issue myself and have spent some time researching where is
my /dev/sgx_enclave file on an SGX-enabled hardware, so this is a bit
personal.

Links related:
https://github.com/intel/linux-sgx/issues/837
https://patchwork.kernel.org/project/platform-driver-x86/patch/20180827185507.17087-3-jarkko.sakkinen@linux.intel.com/

 arch/x86/kernel/cpu/sgx/driver.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/driver.c b/arch/x86/kernel/cpu/sgx/driver.c
index 22b65a5f5ec6..df4fbfaa6616 100644
--- a/arch/x86/kernel/cpu/sgx/driver.c
+++ b/arch/x86/kernel/cpu/sgx/driver.c
@@ -150,8 +150,10 @@ int __init sgx_drv_init(void)
 	u64 xfrm_mask;
 	int ret;
 
-	if (!cpu_feature_enabled(X86_FEATURE_SGX_LC))
+	if (!cpu_feature_enabled(X86_FEATURE_SGX_LC)) {
+		pr_err("SGX disabled: SGX launch control is not available.\n");
 		return -ENODEV;
+	}
 
 	cpuid_count(SGX_CPUID, 0, &eax, &ebx, &ecx, &edx);
 
-- 
2.48.1


