Return-Path: <linux-kernel+bounces-530189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0FEA43044
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 23:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1392918936AD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 22:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7013B20B7F9;
	Mon, 24 Feb 2025 22:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iJlAgvdg"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE19209F27
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 22:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740437571; cv=none; b=G/tvNwoY71utyMRNvIQC4HGX3SPLk4c2/y14rwEIcP6ZHaEGWn2tgOSzbvHzNRbRWpgzpk3Hx9a5jofy6KIcWo0Oj5ZMskQCNtsMUM/CU8uMcLoq7V4PB35YNEWkLNOLrC9Wt+c1cEBcE5mxX+vyhuIc4uW0Uxx2SIPl+r9KyJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740437571; c=relaxed/simple;
	bh=vx6vB9UgcnLZOWNDu7hZerIV11aErIGRCAi4dguYZw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XUQLWfDC79PiknzwraM0d0zCcJcUJk1OUlCiv1beLIxY1YIJ3XpnKM+OtiVU2F+1dnbTNRX/bJUlZcIOKAcj74icw3yIeYRk+jzsOmLFcAQDtGm6owMFplihgBOR//EQg5Wx7qYXnNXexLVU09EF76m/neIIgL4rZ30rG7CQwAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iJlAgvdg; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2211ea911b5so13208795ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 14:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740437569; x=1741042369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uLPC0aGcYNb1lvLik1r4PuSirlrOiN9ljuV/brKB6K4=;
        b=iJlAgvdgtTCfaG6hOyucqOw1zthzJhXyoPf3t6Hjzd8UNgQKw1ZL4OxgbmboUsgn8S
         RjI8F9+PArJQgNj45YkaZZN7U+yP9Mum/+ccQQNLJZfDhPx8YQhhwhlTMvHlY14ywlYX
         62oT0Hf2zlrA7P78A8JBXzWhWqLDbVEnQXiY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740437569; x=1741042369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uLPC0aGcYNb1lvLik1r4PuSirlrOiN9ljuV/brKB6K4=;
        b=ovpJC/WQcEDW9Hb3ZV/n/XvozuwsNyVbccFEH5l1KAma0+UWCxIsIhQ/bORPnaW8G7
         dh/gR2RxmmAt4Veak+5i9yAqGbAtHVgAudfoWrL4ldKcK0i1zF+ZGRXRgnTQIJbL6Pg+
         gdTM7iJaWKg/FNFnJmEgaI2rqDJiAheKZpbOKmC4z2JpM15KYbO6xQESNS8J8YjTc7N+
         5ShbBBZKkyOoPLM2g+6i9S4T2unPvPnxnu9HhgVNYt0dxirn1Ty7yvZWaneAzTbNgHro
         4jo5AoZ8kwlGRbVkfXiMgjBCPte0ksQpNgotlyrCxBgHEFZNII6o6nC/4kmKheCaa7y0
         ruWg==
X-Gm-Message-State: AOJu0Yzl021/bR9WsXvBPqbDtXjSWC1DuDOQ9YCwMpxkV7TiNOo9WOpD
	Wt0P200BWTmwyCmhTbj3gLt7H4r2LwOIQabkQ5gVFHqmAGygjoyncgqJQHI4PA==
X-Gm-Gg: ASbGncuSCUePnNLSHOBkG7faw1Fb3BP7sT/cAA46GD6yjv4dyFj/NuQqW3NJ57OdSGd
	Y+w8LtRHhKdAYlhIuLwMyTkiSQfs0cHSloqPB7dKt/CNwPkswWiDEmZYEuQIpTTNKuR0TbLXExu
	Fn94XOa3C4z7FGBMx640FlnvEldFvAyI0bpDaQQ+YM+YxFCcz8xO4aWFWU+O+zugLKgoP53jfmK
	IFtRhfoA1Jzf41dLm8UdTK87NlION9CyLBRbsv/4TGzelNa2J6/tAcsyyl2vGXTf6wU0MlWgqDO
	FiFGHiEmQSXbHiYegvKdTSyVY2x5e942HXTaRyGabaUwkgRtLyFTk+23L0mr
X-Google-Smtp-Source: AGHT+IHCp48/6UHF/fa/HDiAGSPZBXV+VJjrvt3aHCsldayQ5uHsZNAe0/b2WwYSN5ozi8oGHlQeSA==
X-Received: by 2002:a17:902:fc8d:b0:220:f708:b7a2 with SMTP id d9443c01a7336-2219ffdfe62mr95535885ad.11.1740437569437;
        Mon, 24 Feb 2025 14:52:49 -0800 (PST)
Received: from localhost (201.59.83.34.bc.googleusercontent.com. [34.83.59.201])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2230a092fe4sm1292045ad.147.2025.02.24.14.52.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 14:52:48 -0800 (PST)
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
	Kees Cook <kees@kernel.org>
Subject: [PATCH v7 2/7] selftests: x86: test_mremap_vdso: skip if vdso is msealed
Date: Mon, 24 Feb 2025 22:52:41 +0000
Message-ID: <20250224225246.3712295-3-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To: <20250224225246.3712295-1-jeffxu@google.com>
References: <20250224225246.3712295-1-jeffxu@google.com>
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
Reviewed-by: Kees Cook <kees@kernel.org>
---
 .../testing/selftests/x86/test_mremap_vdso.c  | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/testing/selftests/x86/test_mremap_vdso.c b/tools/testing/selftests/x86/test_mremap_vdso.c
index d53959e03593..94bee6e0c813 100644
--- a/tools/testing/selftests/x86/test_mremap_vdso.c
+++ b/tools/testing/selftests/x86/test_mremap_vdso.c
@@ -14,6 +14,7 @@
 #include <errno.h>
 #include <unistd.h>
 #include <string.h>
+#include <stdbool.h>
 
 #include <sys/mman.h>
 #include <sys/auxv.h>
@@ -55,13 +56,55 @@ static int try_to_remap(void *vdso_addr, unsigned long size)
 
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
+		ksft_test_result_skip(
+			"Could not open /proc/self/smaps, errno=%d\n",
+			 errno);
+
+		return 0;
+	}
+
+	if (vdso_sealed(maps)) {
+		ksft_test_result_skip("vdso is sealed\n");
+		return 0;
+	}
+
+	fclose(maps);
+
 	child = fork();
 	if (child == -1)
 		ksft_exit_fail_msg("failed to fork (%d): %m\n", errno);
-- 
2.48.1.658.g4767266eb4-goog


