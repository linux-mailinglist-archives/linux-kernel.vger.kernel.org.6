Return-Path: <linux-kernel+bounces-414965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5799D2FC6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 21:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72E1EB29669
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49751D31BE;
	Tue, 19 Nov 2024 20:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjx13qWP"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D741D31B8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 20:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732049487; cv=none; b=qF6nfnCzp6Gxi17wvJOLuJe081wAWJPhWiWPUHDC/YpWyrmZh+vUxUrcqqepxk2DTuQ3n4e6YRNO3jBgBGVXymLDKW4aqoU36WXXslPItFdYm15EkH8VZmH10yGoULW/Tk2hPxh8ocVqrUIRm7plDIaaBN9u4a8eSBKVy41H0sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732049487; c=relaxed/simple;
	bh=b5RjjHkf3OMWvD1D7V7kekH703Ld7VmOUHsY0LFtpJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Q5mOtKbhHxEDlfc/Cx363W3RtbzhdPYukdmRuppjGx9KasxDz22K17wCj1Pt/jITqW4Itng0THET9gQv/nt3RXfUC47J2fYP1loi/W94eel2QHF89bGwSYXyyQwb/NtmLMebN5/VO/QYk39m76wVeLcSehmxnq8QhkOhQ8PxEks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjx13qWP; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ea39638194so2832232a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 12:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732049484; x=1732654284; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BImHzjlL7Qnl/A3a7PuXoVcVmxRHy3J0MyvSenkTVCY=;
        b=kjx13qWPEZMIvIzlEdWx/rs4iOvPoVs1RuqP4lMB3A5CMSXLICHA6wNioGgGEmCvff
         yKJKAOyWAogc4/vpLjDx6FMaQmFbY5KB37RFLB6QxjzvU4ovHVXgLeN9jHpfA+kuCszL
         HptbdtdhB5nQhTA6c/n25nqIRY5tb4VX3LUAootrdJh25C3tdbVUQ1s7gm2E2btAdFZc
         H9/6J0J3BrRUPBRv2vRhGqjF2uJ4tkcmOQoSs3mLF/H0maH2t8EwK6rToHsVHe4FA2ja
         uWWjEaU4l7XOXRd9lxglOAf31O8jrGtniu/qNY/EY3a0o35gwSgdd7Vj9twXz8PLjAtB
         bR8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732049484; x=1732654284;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BImHzjlL7Qnl/A3a7PuXoVcVmxRHy3J0MyvSenkTVCY=;
        b=oWKD9MHswJBgY6rAkvqmJwzoMOTe/PMAFtPJVGR22PDeJP2ct5aC7SCVldMT1Txlaj
         /FXmy7ZI5Wn8duAVD+6ajTUEaFXqiOEkQsh+W+co3XhSWSSseCkmC+AcF1ODcSvE5ANV
         gvqqxpavSRlTj09E5QRLHhNg7tJgrH+C9o5y9OdKRr5RoV/fq6yFD9tfZ59yRDuCR6L5
         FRuRXOSXPGPUNt9pzjLEW3+bobRW7Qfb9P9mi+s0dYStvqzyQDsGKGUUYOXGh9OwXi2A
         7HoVR+IYZA+70IeJPkz9l7h81JjWILRaqd+ZUlcsXW6DsXr3zHmUUByzv+jnWXI9MoRY
         wGeQ==
X-Gm-Message-State: AOJu0Yyo35/c6pdFvxaCGtWrzy4APEd5GOK+8TBRvfq1kgys0bjjtyX8
	7IdS4GlSPFU5nL02+k8vujBjWdVR86rBpmNGV9CBzWIvmzuTrmYqpcrkuA==
X-Google-Smtp-Source: AGHT+IEf/Bb+SrZdi30PnoNJz5kObncCzYOS7Y1al29ouMu4s793JkPEZtDMB5YqgG/CikztBFZZJA==
X-Received: by 2002:a17:90b:3cce:b0:2ea:3ab5:cb7b with SMTP id 98e67ed59e1d1-2eaca6bc3f7mr203558a91.5.1732049484547;
        Tue, 19 Nov 2024 12:51:24 -0800 (PST)
Received: from [127.0.1.1] ([2401:4900:81e3:2e18:a5ae:e552:ce3c:c9da])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea5828c7b8sm5140629a91.47.2024.11.19.12.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 12:51:24 -0800 (PST)
From: Shresth Prasad <shresthprasad7@gmail.com>
Date: Wed, 20 Nov 2024 02:21:13 +0530
Subject: [PATCH v2] x86/sev: Fix dereference NULL return value
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-fix-dereference-null-x86-sev-v2-1-7e637851dfe2@gmail.com>
X-B4-Tracking: v=1; b=H4sIAED6PGcC/42NQQqDMBBFryKz7hQToiRd9R7FhSajDsRYkjZYx
 Ls39QRd/MX7fN7fIVFkSnCrdoiUOfEaCshLBXbuw0TIrjDIWiohhMGRN3QUaSwJljC8vcdNt5g
 ooxpa6bQhPRgNRfEsO95O/aMrPHN6rfFzvmXxa/8UZ4ECtXSNqXVDslX3aenZX+26QHccxxdfW
 rBdyAAAAA==
X-Change-ID: 20241119-fix-dereference-null-x86-sev-4b62d89e8b98
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, Shresth Prasad <shresthprasad7@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732049480; l=1396;
 i=shresthprasad7@gmail.com; s=20241118; h=from:subject:message-id;
 bh=b5RjjHkf3OMWvD1D7V7kekH703Ld7VmOUHsY0LFtpJM=;
 b=M3Mp90FPVqWCQ+I0+xf04+xN6U57b3NTekOw8aK6C9OGCIQgQ3FuoksAN8OG1yqEkUe04hgei
 csOT9TQ4coyCGSOllgOoCxOxyD7Oawl4ixSB0jfrGDLzuBK+rADiI2P
X-Developer-Key: i=shresthprasad7@gmail.com; a=ed25519;
 pk=HRYCrybNfNIKx/XGWuHaebtR9EfV+fP52xNB7eY5XoU=

Prevent a NULL pointer dereference in snp_kexec_finish() by checking the
value returned by lookup_address() call.

This issue was reported by Coverity scan:
https://scan7.scan.coverity.com/#/project-view/52279/11354?selectedIssue=1601527

Fixes: 3074152e56c9 ("x86/sev: Convert shared memory back to private on kexec")
Signed-off-by: Shresth Prasad <shresthprasad7@gmail.com>
---
Changes in v2:
- Reword commit message
- Add Fixes tag
- Link to v1: https://lore.kernel.org/r/20241119-fix-dereference-null-x86-sev-v1-1-82d59085e264@gmail.com
---
 arch/x86/coco/sev/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index c5b0148b8c0a191f5aa38af73a52c77d6bba3e2d..0436366243e19a72bf9521f2e96a3ceec9c1270c 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1079,6 +1079,8 @@ void snp_kexec_finish(void)
 		data = per_cpu(runtime_data, cpu);
 		ghcb = &data->ghcb_page;
 		pte = lookup_address((unsigned long)ghcb, &level);
+		if (!pte)
+			continue;
 		size = page_level_size(level);
 		set_pte_enc(pte, level, (void *)ghcb);
 		snp_set_memory_private((unsigned long)ghcb, (size / PAGE_SIZE));

---
base-commit: 28955f4fa2823e39f1ecfb3a37a364563527afbc
change-id: 20241119-fix-dereference-null-x86-sev-4b62d89e8b98

Best regards,
-- 
Shresth Prasad <shresthprasad7@gmail.com>


