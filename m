Return-Path: <linux-kernel+bounces-510429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91154A31CAB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 04:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B313168471
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2AC1F0E55;
	Wed, 12 Feb 2025 03:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g4fzrQYR"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFC91DB958
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 03:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739330524; cv=none; b=eYbUCku3otyBshQdJH629ZNII22WatGG6P8FweybnLCgI4flfcEN6eIA/ljyUWhxCYuB2Hk8JGyZbXegiutJ0rvSJdWo8wpUDpgevzZFOQn+nFhCJNfW6Tz0Gx8gnmj7MY/0cnmgQHDgknCAABu7uX/gEnaiAeRDP0iAaVZVzFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739330524; c=relaxed/simple;
	bh=vaPHeEEUVjAtZeidG2hNXfFKCf7yTmWopFw9HmRLawQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1ziLNdhFGHrZOPynvsfI72d6xvW2QIP+nWpwa2IhFTu0LBqVrYWhTOeMCVw2TKZi73tqNCo8nKyPGpWvA91AzL1lN7IPIHcHy10eJbUpv97KhbYIgY/ylCYiXDWRh5XPRi3P59Hc6h8WE19mt8tpsKPpOVivYdLdPND0btGGTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=g4fzrQYR; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-218c8ac69faso13351665ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 19:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739330522; x=1739935322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CGVA5eSPFfsHEVs7rjQnee/yKRru+0Ft1a+zzsFXds=;
        b=g4fzrQYRZQn8oU/MkluKtm4c4tfyjg0lKP1WP/EccputHeDTs9CVEGRC21WSYmUW9P
         9GYsvTmiMKZ9IcV/oeH2zzR41YqIf6gMQwX0OIUazmdE+Nk1yQFqe/i98OeqMscwY6Ev
         SYGHcSePt1WWnh2Aim2cwItO2U4IPkMEgLO/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739330522; x=1739935322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9CGVA5eSPFfsHEVs7rjQnee/yKRru+0Ft1a+zzsFXds=;
        b=DWcb3XE/7IFU3pSUgTiot8OwK3WnDxhVN6O9XqhSmt07paKA8HDBcIw9mVI0gRv077
         6M2HLI+fuaELLN3M4Ogr77NnmuDYTxprkC0MAF/F8yAfgofywySgrq1R3eCTGiQ0MSoO
         /in4OzRq2RtVbMuajAHMc8lWeDryNMUsfNX2Nji6wMcuLjZ2TOhSfKA88TWcuT66tO6t
         2VDndsxs1hqoZo5v72UNwKtBCYNoQevZTPA6jJ0NJxySCLae1SCbXEp4kNEOS/aUG0vN
         XZ8v8aqSfefg1Vc9CeUqWMg73JrY2b+xKo7JNV/vWrD0hpgTVbBOiD69ljKtJZszijZL
         2QoQ==
X-Gm-Message-State: AOJu0YxkhRvpTuuiDLvo6qO8v7UCuvIgmDvaPKraAcpwEzIVojY9lZb4
	o49dzqCkRmBgijs/C1YZ9ER8CYPK0VEH6LoTpHtztYXDFK5hhjI67ZA4lnWgEQ==
X-Gm-Gg: ASbGncvby1ugWpNmQtHmomjm5cp42j7qFpIBZsRxKCCDG4xvaq0nrECeva6faPfnKWo
	7U7g8D5+Gr3XeroYrm04FREV0ZPH2wXhE2E5KpcPik64maQ/o73YDWjrAChVJnK7jfzKXtEYv5I
	yHcz8y6ATsAlZ8/f99MVAITvmX/9VIqitKdy69itWxmlLM1uLDvVS3Vn6qbynN2AaH+tYP5vqny
	UkHbEHX1mINWo6ZeeYU9d3645SEspTGxoxUcuqvqMp1hwGsnjZt8r4bq1lafLkz5xakQ6t5LLE3
	8wmtNWR/hgiJiyIPBw+MXFif5S6xcu8qqyfU8HWWBUKFSSRK9Q==
X-Google-Smtp-Source: AGHT+IGRZPknLjE2cjsyC6HVD4KIdBjVV6wxieEwLxc5+sxlPK5wduEZddMX8O/rsN2prx5qJfmRrA==
X-Received: by 2002:a17:903:22c5:b0:21b:d105:26a7 with SMTP id d9443c01a7336-220bbb045admr10703335ad.6.1739330521639;
        Tue, 11 Feb 2025 19:22:01 -0800 (PST)
Received: from localhost (9.184.168.34.bc.googleusercontent.com. [34.168.184.9])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21f3683d8b2sm102324115ad.119.2025.02.11.19.22.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 19:22:01 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	torvalds@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com,
	adhemerval.zanella@linaro.org,
	oleg@redhat.com,
	avagin@gmail.com,
	benjamin@sipsolutions.net
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	sroettger@google.com,
	hch@lst.de,
	ojeda@kernel.org,
	thomas.weissschuh@linutronix.de,
	adobriyan@gmail.com,
	johannes@sipsolutions.net,
	pedro.falcato@gmail.com,
	hca@linux.ibm.com,
	willy@infradead.org,
	anna-maria@linutronix.de,
	mark.rutland@arm.com,
	linus.walleij@linaro.org,
	Jason@zx2c4.com,
	deller@gmx.de,
	rdunlap@infradead.org,
	davem@davemloft.net,
	peterx@redhat.com,
	f.fainelli@gmail.com,
	gerg@kernel.org,
	dave.hansen@linux.intel.com,
	mingo@kernel.org,
	ardb@kernel.org,
	mhocko@suse.com,
	42.hyeyoo@gmail.com,
	peterz@infradead.org,
	ardb@google.com,
	enh@google.com,
	rientjes@google.com,
	groeck@chromium.org,
	mpe@ellerman.id.au,
	aleksandr.mikhalitsyn@canonical.com,
	mike.rapoport@gmail.com,
	Jeff Xu <jeffxu@chromium.org>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC PATCH v5 5/7] mseal, system mappings: enable uml architecture
Date: Wed, 12 Feb 2025 03:21:53 +0000
Message-ID: <20250212032155.1276806-6-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
In-Reply-To: <20250212032155.1276806-1-jeffxu@google.com>
References: <20250212032155.1276806-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Provide support for CONFIG_MSEAL_SYSTEM_MAPPINGS on UML, covering
the vdso.

Testing passes on UML.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Tested-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/Kconfig        | 1 +
 arch/x86/um/vdso/vma.c | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 18051b1cfce0..eb2d439a5334 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -10,6 +10,7 @@ config UML
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_KCOV
+	select ARCH_HAS_MSEAL_SYSTEM_MAPPINGS
 	select ARCH_HAS_STRNCPY_FROM_USER
 	select ARCH_HAS_STRNLEN_USER
 	select HAVE_ARCH_AUDITSYSCALL
diff --git a/arch/x86/um/vdso/vma.c b/arch/x86/um/vdso/vma.c
index f238f7b33cdd..a68919db0ff7 100644
--- a/arch/x86/um/vdso/vma.c
+++ b/arch/x86/um/vdso/vma.c
@@ -6,6 +6,7 @@
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
+#include <linux/userprocess.h>
 #include <asm/page.h>
 #include <asm/elf.h>
 #include <linux/init.h>
@@ -54,6 +55,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
 	struct vm_area_struct *vma;
 	struct mm_struct *mm = current->mm;
+	unsigned long vm_flags;
 	static struct vm_special_mapping vdso_mapping = {
 		.name = "[vdso]",
 	};
@@ -65,9 +67,10 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 		return -EINTR;
 
 	vdso_mapping.pages = vdsop;
+	vm_flags = VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC;
+	vm_flags |= mseal_system_mappings();
 	vma = _install_special_mapping(mm, um_vdso_addr, PAGE_SIZE,
-		VM_READ|VM_EXEC|
-		VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC,
+		vm_flags,
 		&vdso_mapping);
 
 	mmap_write_unlock(mm);
-- 
2.48.1.502.g6dc24dfdaf-goog


