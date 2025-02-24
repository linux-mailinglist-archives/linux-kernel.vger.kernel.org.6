Return-Path: <linux-kernel+bounces-529719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DB8A42A36
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF1113A5ED9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F19F264FBE;
	Mon, 24 Feb 2025 17:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oX45CEQi"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BBE264A89
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419119; cv=none; b=Vcc3Lgq6JIeA1nFB8C5cKVMXSIsdEm/9R83HWYdt3QXUx1fHBLBCaNgdyDcUniTviol9FX6y3az8Iv88254jUnb55DrKEDuVxEMRXmSCbUsTAOmX2V6J9drRacLg9PUcdfX42nQT6jb/cBn4FsqrhZNcs7knoJ/ROK1JFdQ8fMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419119; c=relaxed/simple;
	bh=OBBKl96vxFBmA1av2T8KVacZIA2ShhvhvpxM/xuQFAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ALxRMke69j5gf2LN1TEV4yELushYOvHGp4hvX0NdVNWNUus7WQaZYbUKAPECWuqGXsLGLtMa0TQNENFkXk4SyJhOuS7wOIMcrPaWztelzMWN5kzE67jlNyyVfTMGCDmyQq4IRslc8LSU8E0vmQb31bX4A5GHHqITGyIa5d5KZsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oX45CEQi; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2217ea6d8daso12081325ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740419117; x=1741023917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOuDnv83CpzU9+Is9rRk+mGWBAWQzFMYMR0kufccTA4=;
        b=oX45CEQiaBFt2c3ke/zIZRDDmgl/Gj6ptwCMxYGCLSi197WwLvGN5fy2oVTYvCI5Fr
         dazXMgrlaCwHfVgQv43jtSJpMO8Ra+sKfpCo0VpxZl5EZqSeEe4fT6yiLytsL2R8S8Lv
         7WBYKy7l+iykCRvn4gHJUa4vWJCav0WYNCwks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740419117; x=1741023917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOuDnv83CpzU9+Is9rRk+mGWBAWQzFMYMR0kufccTA4=;
        b=BDW20xU7GdOYmWoSZcWXSJ9X8CE61nHgHZplfyyX2ugbZ0dQ+ohuhxwPumvWnbrEot
         FJLBCp/xbu33AlB+QcpZaFvFVojQe9GLYHgwHErUDZTo4wbvLsok00QkWC7ub1E6QwnI
         uIAW1BEoqFrUFAahbhcUT3BY+HMvSaxFow+4a6kmwRo9xwwxs+juBQYrYEmaDT/EH4Mz
         sfFQ2YrhB4bOONE51AapXcMLfVCLyFPM8cW67xsQBlkK6rHiVAqvhMa1KW9cbyaKOPYs
         NUjpkZgVPqt2CBVmuNnmC44SvH6xnnY5TwcWGj58kEQUeTpXzFZpdAsbe1BQ7a/jCbfS
         rJTA==
X-Gm-Message-State: AOJu0YxonxjhWtio/aE3olNvWM0lY+yrFckh6qdRxhzIz0tUea0aJQYo
	ZTxUvYxbZ6F/iwCaZwuAnDb7UC2H0g//0+1oHf7lkRfOTENlKbC2tLTG6fFjei9IajIR+JX/IXc
	=
X-Gm-Gg: ASbGncuQF5ja5ZH2/CluyCTQViOSnXxLAQk67Z74ClGDlxFRYZrkdd4AAIPC6C/9gWu
	Uq5RUAGnwP9rXp9dA5JFo0bjVp2et1XOqw/Kwitvyg2WBFJyHWvnblmsaiu/1g+1VbasTDkXZ8f
	6LxaF5OY14KELG75se+YqcbGral9HA43XJPKHsNoxaL0XEn6BXnNIRn1SofNH6e3F9KFNDwH4t+
	cdU5zzFlvTyLVWNC79IcDeY85vJ4jdK2mDIAdAe3Cex/UG19Laj0PxpuFOnJt42mayTUD5si6aN
	QYtoh26f/lkpU0IsWMW9dmBaHvR0z4fGsOny6jQ3ySxwxxLt2Rlbe4qz2sPF
X-Google-Smtp-Source: AGHT+IEeYZ54rRUbGdZQIOlhhcGLgC+WoktvweDeP2f3Op4uks5fDxTwn3C0YXbJAivdUXc4ZCp44A==
X-Received: by 2002:a17:902:d4cb:b0:216:1d5a:f348 with SMTP id d9443c01a7336-2219ffc3d7amr90719385ad.11.1740419117182;
        Mon, 24 Feb 2025 09:45:17 -0800 (PST)
Received: from localhost (201.59.83.34.bc.googleusercontent.com. [34.83.59.201])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d5349634sm180515125ad.31.2025.02.24.09.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 09:45:16 -0800 (PST)
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
	Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v6 2/7] selftests: x86: test_mremap_vdso: skip if vdso is msealed
Date: Mon, 24 Feb 2025 17:45:08 +0000
Message-ID: <20250224174513.3600914-3-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To: <20250224174513.3600914-1-jeffxu@google.com>
References: <20250224174513.3600914-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Add code to detect if the vdso is memory sealed, skip the test
if it is.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 .../testing/selftests/x86/test_mremap_vdso.c  | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/x86/test_mremap_vdso.c b/tools/testing/selftests/x86/test_mremap_vdso.c
index d53959e03593..c68077c56b22 100644
--- a/tools/testing/selftests/x86/test_mremap_vdso.c
+++ b/tools/testing/selftests/x86/test_mremap_vdso.c
@@ -14,6 +14,7 @@
 #include <errno.h>
 #include <unistd.h>
 #include <string.h>
+#include <stdbool.h>
 
 #include <sys/mman.h>
 #include <sys/auxv.h>
@@ -55,13 +56,50 @@ static int try_to_remap(void *vdso_addr, unsigned long size)
 
 }
 
+#define VDSO_NAME "[vdso]"
+#define VMFLAGS "VmFlags:"
+#define MSEAL_FLAGS "sl"
+#define MAX_LINE_LEN 512
+
+bool vdso_sealed(FILE *maps)
+{
+	char line[MAX_LINE_LEN];
+	bool has_vdso = false;
+
+	while (fgets(line, sizeof(line), maps)) {
+		if (strstr(line, VDSO_NAME))
+			has_vdso = true;
+
+		if (has_vdso && !strncmp(line, VMFLAGS, strlen(VMFLAGS))) {
+			if (strstr(line, MSEAL_FLAGS))
+				return true;
+
+			return false;
+		}
+	}
+
+	return false;
+}
+
 int main(int argc, char **argv, char **envp)
 {
 	pid_t child;
+	FILE *maps;
 
 	ksft_print_header();
 	ksft_set_plan(1);
 
+	maps = fopen("/proc/self/smaps", "r");
+	if (!maps) {
+		ksft_test_result_skip("Could not open /proc/self/smaps\n");
+		return 0;
+	}
+
+	if (vdso_sealed(maps)) {
+		ksft_test_result_skip("vdso is sealed\n");
+		return 0;
+	}
+
 	child = fork();
 	if (child == -1)
 		ksft_exit_fail_msg("failed to fork (%d): %m\n", errno);
-- 
2.48.1.601.g30ceb7b040-goog


