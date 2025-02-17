Return-Path: <linux-kernel+bounces-518102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC51A38A00
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56FFB7A3D55
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 16:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF54225A2E;
	Mon, 17 Feb 2025 16:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WN+MjK2Q"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5CD226197
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 16:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739810641; cv=none; b=oh0RlJwUFIcHYRBwA67nxQIqD59d9UOP0t7B0+COzneX0M6oMudKrgMkRG7MSUAZyOAXhfzTGRi8E10fy3xh//8EyG/ZzUg5DG8OIfXv8xLJI3vbCFf44e8Jw2g3r7NeLG2P2tjpQBqIdf73J/3dQp8C+hMbrtG3fRZiSBHqpeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739810641; c=relaxed/simple;
	bh=3/kATWS4kohOxbPPssCh7+aHcYDw4ao15tY3RhtlT5k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lWpVLsfHRFnSOqVeAKJAKJuinkmXGIkmAtoueuHWgl+5Pcx+dQpYMzsT9o9yLNRnZRnvPwThA4I24lgMZaUH2Mx7x6CETjL/8Ay0LQKrrsScTUOoN+xqtYDLGsXQfOh0vv5/H/YUJ8cUqSLPm0fExYl6qapTd5hpMnY148ysL3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WN+MjK2Q; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2fc0bd358ccso9140425a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 08:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739810639; x=1740415439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QeeiiJberKqp+MSuQnxPBfH4/FsnHt7yucRyT35nN7k=;
        b=WN+MjK2Qmhel5h9E0BNQPc7Bl9WOMowQo8mpuVCbDEd/zNagg9DDrXbX/Ydcd4Q2V9
         JBvNIBINUW+mwcnOMUDtAsUNiHssxD9lwetDNoWPHikuWdCmiHZ13uyGdqcqmsN/RiLc
         8guI8V+alP6Dg9Ozs9RC58aTyVXrOOvc5h7RnKuFvZdA+oAsztsEsoIQeas015pID998
         lHkWjSYae2R8taXC/Jnp51lc5gacanQ3LSTMlkEKDVcg704HVHcTmyk8Agsr7/BRytss
         jZNK/jR8D3p0JN2Z4tTHuwdPLc5QfXLcW6hGMr+A6p66rF41rd5HVNQ1xUf1azj+3Vlz
         48qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739810639; x=1740415439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QeeiiJberKqp+MSuQnxPBfH4/FsnHt7yucRyT35nN7k=;
        b=RuEC1VQg+a8bJd/u/b9vJ9TzKBE09cjKkbRRMwdE7yr7BMdQpT2kYb7Q54QFNSyq1F
         iY0nfiCy2nRIjXRHwm0LRidmILxcB04lYeofyiXpoNGawtE5XxHbx73d2oL5STk5GgZl
         BWs2SAbf1tWHxLFA5JmnpvSlzqPllm2Qu0dGqgsUiASqadEYhpk3ZZsfh2J38dqpjS6z
         e2NYUrLxn7LWlaT+fXIQhkxFkNdw3lBzPLHvzwGYBXFJhsbU1X2W0OBrj36855pqZvxb
         FM6fq5ijQXA8OKCNm4yX3yrPX36sLUxD/JCLtmT+rXBME/ZDTX84VjYpscoyRgHIsY5M
         s/Hg==
X-Forwarded-Encrypted: i=1; AJvYcCVuWcKsdJBtXl+oiN1bBk5pVQPpvLDPvkGtPVdoSGX3O8sC9qQqHhrGNIMT2XKTkWLhPnPtNqXJmMAAl7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsWSSYpQlQB94rzZRcvuV91Yj4SG9NKghWZlrUeNZvAIbhmSH7
	MQtkM3DesjGrxdahK2pCHw35zTDx/KX5ZfuAla762SaCR3vN+7tJ
X-Gm-Gg: ASbGnct/CBIg1acGu5tpW6lSlOSGFQrD3UqYeAADmow4jCyTj3L/+LLE8+dm3VVzx2D
	Oc1ri3ECrnCGItdu1UnkRuq3pUqBo9lzKkXGeCVvipIHhMZeC8vQzFMCggL8/aknSm4SMNiYRK+
	SuWhkmQFEn2ESJxRsjIh/JJtIgRftsQTc8nLoiPN2WvZXNnxQ9EVOPZzERpgSi1xqrf1rGYPWFW
	bn/6gyp7vWnAgiTn2z5NmtO/WsS7bMMKSvSspRZQoXzGqdtq7GmoDb7V5vZNqI0gexcTD41m/6P
	MSAhltI80vcSghCccLzA
X-Google-Smtp-Source: AGHT+IEKsuo9K4p+TFMgWRMBmU7I0H/gBvBPtsGGOeSrqFEODTqFS6pZ4ey3eyKwXgZdE/5vDqzimA==
X-Received: by 2002:a17:90b:3c04:b0:2fa:2252:f43c with SMTP id 98e67ed59e1d1-2fc411509a1mr14228429a91.34.1739810638732;
        Mon, 17 Feb 2025 08:43:58 -0800 (PST)
Received: from eleanor-wkdl.. ([140.116.96.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d534906csm73910315ad.52.2025.02.17.08.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 08:43:58 -0800 (PST)
From: Yu-Chun Lin <eleanor15x@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	naveen@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	visitorckw@gmail.com,
	jserv@ccns.ncku.edu.tw,
	Yu-Chun Lin <eleanor15x@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH RESEND] powerpc: Fix compiler warning by guarding with '__powerpc64__'
Date: Tue, 18 Feb 2025 00:43:52 +0800
Message-ID: <20250217164352.3123729-1-eleanor15x@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As reported by the kernel test robot, the following error occurs:

   arch/powerpc/lib/sstep.c: In function 'analyse_instr':
>> arch/powerpc/lib/sstep.c:1172:28: warning: variable 'suffix' set but not used [-Wunused-but-set-variable]
    1172 |         unsigned int word, suffix;
         |                            ^~~~~~
   arch/powerpc/lib/sstep.c:1168:38: warning: variable 'rc' set but not used [-Wunused-but-set-variable]
    1168 |         unsigned int opcode, ra, rb, rc, rd, spr, u;
         |                                      ^~

These variables are now conditionally defined with the '__powerpc64__'
macro to ensure they are only used when applicable.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501100247.gEmkqu8j-lkp@intel.com/
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
---
 arch/powerpc/lib/sstep.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
index ac3ee19531d8..eea8653464e7 100644
--- a/arch/powerpc/lib/sstep.c
+++ b/arch/powerpc/lib/sstep.c
@@ -1354,15 +1354,21 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 #ifdef CONFIG_PPC64
 	unsigned int suffixopcode, prefixtype, prefix_r;
 #endif
-	unsigned int opcode, ra, rb, rc, rd, spr, u;
+	unsigned int opcode, ra, rb, rd, spr, u;
 	unsigned long int imm;
 	unsigned long int val, val2;
 	unsigned int mb, me, sh;
-	unsigned int word, suffix;
+	unsigned int word;
+#ifdef __powerpc64__
+	unsigned int suffix;
+	unsigned int rc;
+#endif
 	long ival;
 
 	word = ppc_inst_val(instr);
+#ifdef __powerpc64__
 	suffix = ppc_inst_suffix(instr);
+#endif
 
 	op->type = COMPUTE;
 
@@ -1480,7 +1486,9 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
 	rd = (word >> 21) & 0x1f;
 	ra = (word >> 16) & 0x1f;
 	rb = (word >> 11) & 0x1f;
+#ifdef __powerpc64__
 	rc = (word >> 6) & 0x1f;
+#endif
 
 	switch (opcode) {
 #ifdef __powerpc64__
-- 
2.43.0


