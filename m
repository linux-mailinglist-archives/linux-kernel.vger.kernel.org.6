Return-Path: <linux-kernel+bounces-272762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A11879460B1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56F931F227B5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30141136343;
	Fri,  2 Aug 2024 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2Ewp04y"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DE6175D5B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722613395; cv=none; b=cuXnPs7Rcno9zbAiks5e2g1uWOfJCXXrErTvHNTtIKm2kZNr7oeFqS0SMjtlTg6Rw7ay/8DQlneaerZFNZbY0tqx/ux/TplTw0bHDbxQrxirOcyJn1wq+5SOjWhNDYXGHPRPyICsNToVHzkQ6m4bN6C0U+NsUQIpRH8VI9QDCB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722613395; c=relaxed/simple;
	bh=bdRVmViA7oPswnL/IFtb+d/4xzFqXJAxwpfgyfIMUvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yyl3mx3TrBL3GcX4VJl8E7Bukv5hN8kIyVxHqvUULuaPWhWHF4wySW/SCDClu8SpTYP75s6PxRGHxYTJgGJjFhKS+ekVvJe3mQTCf01mRSl0FAeUZrwvJPFOU55EKt9Z6WMcPchip9vdvvHO5Dgi52CageHgLv2GSisSefAoAuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2Ewp04y; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5ab2baf13d9so11469875a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 08:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722613392; x=1723218192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ujxQ7Z0aREn1NXVH6kG/QMbaYYj06z4ecA6hqd3GKMs=;
        b=W2Ewp04yBFeYoKIbJAOhn0FlTc/fmPFkT/VY6Hzm+hymQxwpMJoU2LDX6WyzEw78ko
         GJcHvw8qNWCVPDs0jWq5kfSoQOxz1SwdODAXuBnlwQJRoCph9qVk1HXvq7IWOIThDQ1Y
         HkXoGYWIz/uxzbXlnEPKcEv83Ty0FTN6zGu9CVNCv4bQ9z8S4dOWv/3ppk1JyafIgpYt
         8CTtrxSog5unPpO2lUJpgj/fMZxRoC/DXDKrONXrnqag7OdA8uJUS7Wykh6prhwWXPUK
         U1gtz/kpO5yeIIVHT5aPXAMJneRo7XXpoQCD1TQar31bd3gz1+QeQFtQO7YC0GNSLQhP
         BhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722613392; x=1723218192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ujxQ7Z0aREn1NXVH6kG/QMbaYYj06z4ecA6hqd3GKMs=;
        b=hvCn32bKfqI5biCvWlCQ8CWIlaQMrss2XoekopSYO2heDnIJ/ipbdqVQnbKGxjmTJg
         KEuSfrt94N/2PixGXjU30kZ08uuZv0XNLEj5ZEAQlyymhyvPsdVfD5WV4dh5y4OFjOkW
         6TT2wCXKQxB2T/QI3rW7mtTTBdTJ5NCEfNWLDMP49kDnxeKNtMJuk5G2/m13YaDzusmN
         jhYFyRNGyOohyUfPJt3lqCGpsze75zU1PLPT16eQDiW06pOHh1xWrr+5KRpTzLTvx5Qd
         Qy4DGMbwMGBGztglf/QNoigAWY8HR7Ehh1mS8elsBcuiKq3Cb7Jofd9dEuJqiQkqaYWy
         Vrtw==
X-Forwarded-Encrypted: i=1; AJvYcCV9zi3fRbpLrsx7qluc8p+IPeZPLmwZhjHqLZwEwVfOH5OZPVTR5z5NCOk3FLSiPi5rvLEzAr0J960igxUcf5e995+qzqQoeCJueYfi
X-Gm-Message-State: AOJu0Ywb2IFs7HIDIRyXTHuo654tvZhJh0a0Yym1ZcqxOKz1i86K8UvC
	Teeal7hi3GS9La7n40fY5lp7vp1MY68hjLI8e6lKj/WghtoagVM=
X-Google-Smtp-Source: AGHT+IEcfZOF6mmX9m/klpliw6ikZtqQN2XLI4lny83bSDA8UNwFPsYiPp91v9UBUUCSP8LEX8a1vw==
X-Received: by 2002:a05:6402:515c:b0:5af:6f52:c139 with SMTP id 4fb4d7f45d1cf-5b7f3cc7458mr3052794a12.16.1722613391716;
        Fri, 02 Aug 2024 08:43:11 -0700 (PDT)
Received: from p183.Dlink ([46.53.254.37])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b83b723e6dsm1239492a12.65.2024.08.02.08.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 08:43:11 -0700 (PDT)
From: Alexey Dobriyan <adobriyan@gmail.com>
To: jgross@suse.com,
	boris.ostrovsky@oracle.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: adobriyan@gmail.com,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	hpa@zytor.com
Subject: [PATCH 1/3] xen, pvh: fix unbootable VMs (PVH + KASAN - AMD_MEM_ENCRYPT)
Date: Fri,  2 Aug 2024 18:42:51 +0300
Message-ID: <20240802154253.482658-1-adobriyan@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Uninstrument arch/x86/platform/pvh/enlighten.c: KASAN has not been setup
_this_ early in the boot process.

Steps to reproduce:

	make allnoconfig
	make sure CONFIG_AMD_MEM_ENCRYPT is disabled
		AMD_MEM_ENCRYPT independently uninstruments lib/string.o
		so PVH boot code calls into uninstrumented memset() and
		memcmp() which can make the bug disappear depending on
		the compiler.
	enable CONFIG_PVH
	enable CONFIG_KASAN
	enable serial console
		this is fun exercise if you never done it from nothing :^)

	make

	qemu-system-x86_64	\
		-enable-kvm	\
		-cpu host	\
		-smp cpus=1	\
		-m 4096		\
		-serial stdio	\
		-kernel vmlinux \
		-append 'console=ttyS0 ignore_loglevel'

Messages on serial console will easily tell OK kernel from unbootable
kernel. In bad case qemu hangs in an infinite loop stroboscoping
"SeaBIOS" message.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Acked-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/platform/pvh/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/platform/pvh/Makefile b/arch/x86/platform/pvh/Makefile
index 5dec5067c9fb..c43fb7964dc4 100644
--- a/arch/x86/platform/pvh/Makefile
+++ b/arch/x86/platform/pvh/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 OBJECT_FILES_NON_STANDARD_head.o := y
+KASAN_SANITIZE := n
 
 obj-$(CONFIG_PVH) += enlighten.o
 obj-$(CONFIG_PVH) += head.o
-- 
2.45.0


