Return-Path: <linux-kernel+bounces-278744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE0194B437
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 02:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C0861C215A5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 00:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB6920E6;
	Thu,  8 Aug 2024 00:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="GwmrmzP6"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340162114
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 00:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723076872; cv=none; b=l2kP0MwZmK/6eJYHXPm1oYlykDVqjDt150zqoahBl5nVO6f8Hsbgb1tpCFp9PdiPiWxm1Ay4o3XkNcOShCX0BI8ufl+srcbzF7wJvE4DazpEC/UJt3ltuuJTwHrWeB1u3tTSYGH/wnxSNW16agSDKpzHRRTx4kEK2zRVrMb1X4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723076872; c=relaxed/simple;
	bh=DQwLqUHrTK1JlrmD8XgoTRvGDFVdZClo7VKPzlh1pR4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dMqhtCD2YDZFXqHOxOzFLnJH60C4zn4CYFL8MtFLeHBssdJe2tV9v5LTPfp4B9qvhvzOWX4NDGbQWGo1fZl/Bd6qfzwxw67V6bDlAv7Yj419yZsO2guqMa/j7b3l49jILA52wPXTXfAWg/GrvCqpToFTJcm9uU8nOEQo1w6OkAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=GwmrmzP6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fc611a0f8cso4437495ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 17:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723076869; x=1723681669; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CMCnmdcZgvzSJd0o4YZGau9nL4J4n+yPR6pjHiIEuKs=;
        b=GwmrmzP6UXGSLaB3jMnO5GqZrVpv0eThXUFsrvpuGV/1McqUQVB0VETd05WtdCFQeZ
         Y+xN8lnCveomp4NyImWFG9UiUpCp0fJI7YPwg2+cbRiMWoqQ7xezBLUysBOKdSPdvR4o
         swq2jtAdbtdJDvenHwZtrsMRMOcmQsAsq1EjDIjyPYebhHG34ZoYBJZoPGUvU43q6Y8X
         7r9BLdBTMVXoUjpJoi2/DSsw5VWiWdQnM7et8EAnz8rcrWj+hTSEF15+93SJDVL4bijB
         N/xL4uWVWs6NYoeTYijbqb3gHxUd64bUDhEd4j/7KHRyVwenc5b6YdmZdX3toA8fMeCI
         urWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723076869; x=1723681669;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMCnmdcZgvzSJd0o4YZGau9nL4J4n+yPR6pjHiIEuKs=;
        b=wFYO/mC4DhoVn33zFiQExjweiyjr8rimzEGdOUy1YkO3/PkyjdBy8FCfJTZfV9r52O
         F3FNr9Y0X0K29ywwUhNG9JULxp8XAK8WYOvGPvJ7AKc56X0q7LhdekVhY/vGwtHBd10z
         jyCiLpRXYrAzf6+K9Y/s9tPbPrdPmS8UN5q20RMa3YfxQGGzVEVP7to2STaqiE4X+h8B
         hf7V8HsXzmobrbVFtHEWiM75XLuuFRErbAVMB/v4Va51MVdQDI4lcuzEjZrST7wQnBO4
         l5vsFAvX6umPdBiiQ1wOSnXz5gDLN0y3K/NmLkCDSHE9xWC3pQ03br38ADlLqPTzNy3m
         aPxw==
X-Forwarded-Encrypted: i=1; AJvYcCW753ppv4KkLkgQO9ibWHB8atqY0NCxFURSOzt4M5GPUilLltd+KVEqV8N3txvJwPsO2tz6x/v/kyWP1MJSggvfmtlFXlwqG5KrU5rW
X-Gm-Message-State: AOJu0YwUquH4NN140I6oxfWjAV+bBbaz7o5fTUhT2DGFA+xhUpJC1ojC
	3fjJ49UDjPDo759uO765hvTmq+aCGthhgYSQpHhfwXkay+lSzgjd5QHS2JnDruzdM87olzvcQNe
	m
X-Google-Smtp-Source: AGHT+IF6WhApaAmTvQg5R+K6rlrg18SJbE+TpPymw85NtHx9975p3ORyi+6PJGAGtq5rUai5pIM1Kw==
X-Received: by 2002:a17:903:1c5:b0:1fb:3d7:1d01 with SMTP id d9443c01a7336-200952e51bdmr3299615ad.59.1723076868899;
        Wed, 07 Aug 2024 17:27:48 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f2172esm112242445ad.5.2024.08.07.17.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 17:27:48 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 07 Aug 2024 17:27:42 -0700
Subject: [PATCH] riscv: Make riscv_isa_vendor_ext_andes array static
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240807-make_andes_static-v1-1-b64bf4c3d941@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAP4QtGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDCwNz3dzE7NT4xLyU1OL44pLEksxk3dRkUyOTpMRUI8M0IyWgvoKi1LT
 MCrCZ0bG1tQAwN9pGYwAAAA==
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>, kernel test robot <lkp@intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723076867; l=1059;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=DQwLqUHrTK1JlrmD8XgoTRvGDFVdZClo7VKPzlh1pR4=;
 b=yjn0YLa8jHNQbhhGJyhPs89KWIRTKOoXHsaOaN6uGWpNTVy/6gA/3PERl6LtmukFHt+s7s/oh
 YZk4FVrOb9NAoxy5OF/zwR0agBR5GObQPGv9xdo0mIagRUDQhzBOlHU
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Since this array is only used in this file, it should be static.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407241530.ej5SVgX1-lkp@intel.com/
---
 arch/riscv/kernel/vendor_extensions/andes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/vendor_extensions/andes.c b/arch/riscv/kernel/vendor_extensions/andes.c
index ec688c88456a..51f302b6d503 100644
--- a/arch/riscv/kernel/vendor_extensions/andes.c
+++ b/arch/riscv/kernel/vendor_extensions/andes.c
@@ -8,7 +8,7 @@
 #include <linux/types.h>
 
 /* All Andes vendor extensions supported in Linux */
-const struct riscv_isa_ext_data riscv_isa_vendor_ext_andes[] = {
+static const struct riscv_isa_ext_data riscv_isa_vendor_ext_andes[] = {
 	__RISCV_ISA_EXT_DATA(xandespmu, RISCV_ISA_VENDOR_EXT_XANDESPMU),
 };
 

---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240807-make_andes_static-ec524bae21f2
-- 
- Charlie


