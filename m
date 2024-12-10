Return-Path: <linux-kernel+bounces-439829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF639EB473
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 16:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C37E91886F7A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9A71AA78D;
	Tue, 10 Dec 2024 15:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SYrib5ak"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E18E23DEBD
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 15:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733843861; cv=none; b=Efwt+y/dkFJ16gSN7fZIe73AnjunH0YX0/YqCxusu84zeNa/mNnLVtPHX2OmDdRFmKOsJMQ1m1wbMgQMwml987jdneX8ZpYhV3+x/HhUPXJcLR6Esdz582OzgjEvjQG5VcB9m2LqMQkY0UgtwKQWi+KAcei6Yntqkk2RV3ph/OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733843861; c=relaxed/simple;
	bh=RBFYFnn5S9ViV7pUTYK4Q7ziGMwWy4vS6dfXUKlsZR0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nUXnMyPQphFJh6iETj90uCNf0roZ+n44tEn4A0s4znpuVsQXq9vpx8IWSCNFvFdOyJhluI3Vx+kOP5HzeIwoPuFouQja6HixCjV+CuYlmDT11CxtYHVG8riiduw7JxbT3+KYFcwqWgWaPtNXZjdjH8P5phLmz3o67WdIcFr2P4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SYrib5ak; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733843858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QsZOAVqzo/LiP1stt2YYZXhh+00BJjoKftbK/7AwUEU=;
	b=SYrib5akuqqK3d/0psSBbe/PALiarOoX7S+WIqBXhF5fRSO4EL85NHX0EGNmlFe/69cg8w
	A5fsC8+WMxYvQ2EqsneoRdifNGvVzEyNKF4E5+ADe9K5HR3Vm30VwCgajKoay+fNEfw+bo
	Af2h948N+vbeeAXbc6j2VO7FbPfq8p4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-p913SiZ3OkKyseaNuavc9w-1; Tue,
 10 Dec 2024 10:17:34 -0500
X-MC-Unique: p913SiZ3OkKyseaNuavc9w-1
X-Mimecast-MFC-AGG-ID: p913SiZ3OkKyseaNuavc9w
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 35FC4192E3F8;
	Tue, 10 Dec 2024 15:16:56 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.226.93])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4F3881956096;
	Tue, 10 Dec 2024 15:16:52 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Michael Petlan <mpetlan@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/entry: Add __init to ia32_emulation_override_cmdline()
Date: Tue, 10 Dec 2024 16:16:50 +0100
Message-ID: <20241210151650.1746022-1-vkuznets@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

ia32_emulation_override_cmdline() is an early_param() arg and these
are only needed at boot time. In fact, all other early_param() functions
in arch/x86 seem to have '__init' annotation and
ia32_emulation_override_cmdline() is the only exception.

Fixes: a11e097504ac ("x86: Make IA32_EMULATION boot time configurable")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/entry/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 94941c5a10ac..51efd2da4d7f 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -142,7 +142,7 @@ static __always_inline int syscall_32_enter(struct pt_regs *regs)
 #ifdef CONFIG_IA32_EMULATION
 bool __ia32_enabled __ro_after_init = !IS_ENABLED(CONFIG_IA32_EMULATION_DEFAULT_DISABLED);
 
-static int ia32_emulation_override_cmdline(char *arg)
+static int __init ia32_emulation_override_cmdline(char *arg)
 {
 	return kstrtobool(arg, &__ia32_enabled);
 }
-- 
2.47.0


