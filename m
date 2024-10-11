Return-Path: <linux-kernel+bounces-360875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6F599A0DB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD60EB24A1E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41357210C00;
	Fri, 11 Oct 2024 10:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCcRHa+m"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D852101B3
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728641396; cv=none; b=MRXXQFmAPg97XV8Gl0dxNgllLkPptCUwdUNlBLzKGQk3ATJOEN8uHSqX4cKDizAWvt4XLKCJJHd9aKx1XL19Cz+pyPJuhwHSGWvVukl5TWGanKJAIqrM6zPqslhmxOCh3LblCB1GB/uWxvTraA5V1hmrUCRJmyg75lDyaO1POXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728641396; c=relaxed/simple;
	bh=IBd98wkpT56IfTS76HtUT6h1W66IzWZcH5w/zYGflM4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ovbnxxvTQSjSUw2WEuSnbt3GJ61lkmqXZeskMnYJ4+SLsjfV4SihgtYcJa1wb2yEXxFVePdvyWYHuY83na5mII4VDDUjWOuaHEzQfkM62M4dnkwhmMfgXTjZ8qZykuAqgncYaO+63/q0VnmBahRAhNdd7ItMLxJgOSFtiVguxKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCcRHa+m; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ea3e367ae6so238166a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 03:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728641394; x=1729246194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b/y3joT4t3IK13RKjZ6BzEDxAFTvU2c3jUZXESXkMEw=;
        b=PCcRHa+mAK3fDIhvsrOL4eEYhDb+B61R6h5CsQvksVIAaI/a5swokYt9PI7NoGtuPa
         hU9x3YbuAFpOxfnH3a0l0G3gizMELzU00bxrPUKxMdGA0uMhVxKO7Bov9KIqVJxVUeaZ
         hxopw+K298VH4N9wx5D+4UeieilUQrHYubMEHr3OHmlGBVRqQQMcqg102VnvuPOoGjJf
         CNxuo0jevWo8RsfxZrYUC/f1dgR/G2AuN203byDFRD+qAMuI7+uSCT2hennJukPypcQ7
         wUvsS7cSsS6Pd2jBOA9ijyZsS3epm9N9NIzGyBgnz7Aki3rKspSmdDdWlwe/ZAGOwdqs
         7z8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728641394; x=1729246194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b/y3joT4t3IK13RKjZ6BzEDxAFTvU2c3jUZXESXkMEw=;
        b=xJemGfFKqk5+XAJpffCiQsWBT8BxVgIMcj4XPa+tlju/t6cRHlqt3dObtgUtz/6Fv2
         IdEVnZ2IxTlDxQ42kh/J/yOMM4sHCqXyICHhkDtv/vVDKlnDKkIUCnLzzMiMlWDnhrzk
         VTBUI5h26cWTgB+/Djhi4tewyp9qM6W3Y4Zg24fqT7DzYn2RorzCU/jP+CNwOI4nP/Sn
         qzS0ohLiK+jN5+Bj20uoEjoGn0oEWePb5764RK3U1si0oW3fCMchuqzNr+usJpBCmJnM
         rcDU2cZt+H+orh9qZQkhRk6ps8v72eKWApPVex9jmcHdeWuNc0Zyr88t+P4BTuLWnW/T
         rISA==
X-Forwarded-Encrypted: i=1; AJvYcCW+Ri2OBt+vs9TtqdNxkVMSV3eu74uwevcND3BdNtNqhhniIHSAohIE7ecPZru16KOMuemgyS06Rn/bkGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiwfglCkDaps2S0h9q9kTSKP21fEwPk8NhVvVm7FEwGOVoVVCm
	WpKEikD8yu5s9qscWaT89l3tMoEOtsug6Cv5+EKaCYGIELA1QnyJ3SByTHO78ac=
X-Google-Smtp-Source: AGHT+IHgz6qQKCepciHGP/T3zg35hSmde6I/W0j+FWRy1aPGfioAAMR0s3vk2rlE2YSOPBYungXGcA==
X-Received: by 2002:a17:903:1d0:b0:20b:bd8d:4281 with SMTP id d9443c01a7336-20ca130f7ccmr12094555ad.0.1728641394464;
        Fri, 11 Oct 2024 03:09:54 -0700 (PDT)
Received: from ice.. ([171.76.87.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bc0d34bsm20980575ad.97.2024.10.11.03.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 03:09:54 -0700 (PDT)
From: Nihar Chaithanya <niharchaithanya@gmail.com>
To: ryabinin.a.a@gmail.com
Cc: andreyknvl@gmail.com,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Nihar Chaithanya <niharchaithanya@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2] mm:kasan: fix sparse warnings: Should it be static?
Date: Fri, 11 Oct 2024 15:23:00 +0530
Message-Id: <20241011095259.17345-1-niharchaithanya@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sorry about that, thank you for the pointing it out, I understand now that
compiler might optimize and remove the assignments in case of local
variables where the global variables would be helpful, and making them as
static would be correct approach.

Add a fix making the global variables as static and doesn't trigger
the sparse warnings:
mm/kasan/kasan_test.c:36:6: warning: symbol 'kasan_ptr_result' was not declared. Should it be static?
mm/kasan/kasan_test.c:37:5: warning: symbol 'kasan_int_result' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312261010.o0lRiI9b-lkp@intel.com/
Signed-off-by: Nihar Chaithanya <niharchaithanya@gmail.com>
---
v1 -> v2: Used the aproach of making global variables static to resolve the
warnings instead of local declarations.

Link to v1: https://lore.kernel.org/all/20241011033604.266084-1-niharchaithanya@gmail.com/

 mm/kasan/kasan_test_c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/kasan/kasan_test_c.c b/mm/kasan/kasan_test_c.c
index a181e4780d9d..4803a2c4d8a1 100644
--- a/mm/kasan/kasan_test_c.c
+++ b/mm/kasan/kasan_test_c.c
@@ -45,8 +45,8 @@ static struct {
  * Some tests use these global variables to store return values from function
  * calls that could otherwise be eliminated by the compiler as dead code.
  */
-void *kasan_ptr_result;
-int kasan_int_result;
+static void *kasan_ptr_result;
+static int kasan_int_result;
 
 /* Probe for console output: obtains test_status lines of interest. */
 static void probe_console(void *ignore, const char *buf, size_t len)
-- 
2.34.1


