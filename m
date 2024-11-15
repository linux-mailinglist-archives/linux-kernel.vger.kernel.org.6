Return-Path: <linux-kernel+bounces-410112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EB39CD46B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 01:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE67A282589
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 00:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F293C2C697;
	Fri, 15 Nov 2024 00:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S99dTrdj"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BFF63B9
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 00:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731630956; cv=none; b=oCN5elDKG6YtvQE7I/VmuMDDAkIDufp0YvrdlTRoS0WdGiEanroFbSuQ83OaZF+PEENc8XIvDDWv7q4GWzjK42VWhvRPXhtcW7stuY1ZxnsG/IQCwAvMmnsj3b7AI3Ixm2xgxgK/ZpGae+XMXWyiGs+8+iRghpcUYdGl6Rs+eOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731630956; c=relaxed/simple;
	bh=nR6/NyKUAiIKZ9I4nwODoJQiiqfBOquORStgReTB9Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qSUjT6jr9A/1jwLeXgHm7cS6KVnzgs+n4WSLJWHqFgFA8d6CG41vd8435PjGoNoKmFEDLCE8eIDOCwZsuKroxAFIAoCui3XlifhgNFiTyTx6Y+6dCkmioBoeZisvv8DFA9d49gCz/qrkQ5sq9+1Uv7OOoKBsloOsMEuQa8w0Yw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S99dTrdj; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7eab7622b61so927560a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 16:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731630954; x=1732235754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j+9I2J/x0vPlH5/faHdyczL/jxLpsFKPtH3tWrVfXK4=;
        b=S99dTrdjpHwwHR4OVvIFCGKMYnC2qixGa+Wxvus+oLPVELB/pYB/RWu3WkT8ZvL/lI
         1A0aPG2AXqBGeJ8+w2MLbLAdGvlKa2lUMPbVR3kYQq44nSEAc+zAaMT4peV06yUjhHwr
         w7i538Ed8bASTyZZaQ6Edy99Ewz8P+zIfKdIRMGnug7rYIAI2JLYGHuhppo9YlWToTJd
         7mClQ9CV4kmWBo3wG6jixyg7lH08h1f00xdR3llDSYizB1gZiJXts2qSX740/lAOTupG
         xkgE0WD6d2pD9jxeQXWmLI54YsD6vFnwY45OBvrlWzwq6AsD5Nzw3NRKQeums2WBVCiZ
         g6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731630954; x=1732235754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j+9I2J/x0vPlH5/faHdyczL/jxLpsFKPtH3tWrVfXK4=;
        b=SllbKUk6+T/HuTCGyS01RMCvN7/2kx3stVzCGNrnRBKUVD2o6dObTcORmgcf9gt27o
         rZkLT1TNh1/KnznFmge86+9wxLgIoKN18Da+FH/B9GoxXWrksu/efS/fE+SjAPuV/nST
         1/b+U9hTjHoR+8IBqHI4olXeHyMkGpT3CZ64553NR7U2VNSpwDlDiCO/u4kc7s5BxGhP
         Nz7N4yYgzrAxzPMhpaaPSgl+ADxQpEv6XFWSx16KhKSjll1cDUppKbk0GMSXwLneOAn+
         llZLjRhwdmNp2MFqSaeu/GOLqyrdgOL9vjWeWQm5O5WL5QD0ZowteQYqGTI6ZNYhdPdz
         eP5A==
X-Forwarded-Encrypted: i=1; AJvYcCVJqO+ppv6dgE4WRD5NcY2H7snCAomdzDK0fkY7Vxb0tifCAKrdjJmiWb0qkM0D3q4SB3H28V0XbgyexQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEIHKFFHsw20McSI2fIJbA0G1D/N+boFT9Tz6o5QWCZO9GG7+K
	VFTjAPkQaZCaHFrKJFUkfQK+6JJEvRXr9SSkHySWqobuUXjeGisu
X-Google-Smtp-Source: AGHT+IHco/rQIlfnf2henOLsItUG2Dxmz58iIeFzYDZrO/TXQIO6YXMv5apCwI+3qat8bqhncnB/cg==
X-Received: by 2002:a05:6a20:3d8d:b0:1db:ef91:2e51 with SMTP id adf61e73a8af0-1dc90baa5a4mr1122722637.28.1731630954217;
        Thu, 14 Nov 2024 16:35:54 -0800 (PST)
Received: from localhost ([38.141.211.103])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724770ee889sm261519b3a.20.2024.11.14.16.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 16:35:53 -0800 (PST)
From: Ragavendra <ragavendra.bn@gmail.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	thomas.lendacky@amd.com,
	ardb@kernel.org,
	ashish.kalra@amd.com,
	tzimmermann@suse.de,
	bhelgaas@google.com
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Ragavendra <ragavendra.bn@gmail.com>
Subject: [PATCH] arch:x86:coco:sev: Initialize ctxt variable
Date: Thu, 14 Nov 2024 16:35:06 -0800
Message-ID: <20241115003505.9492-2-ragavendra.bn@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updating the ctxt value to NULL in the svsm_perform_ghcb_protocol as
it was not initialized.

Fixes: 2e1b3cc9d7f7 (grafted) Merge tag 'arm-fixes-6.12-2' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
Signed-off-by: Ragavendra Nagraj <ragavendra.bn@gmail.com>
---
 arch/x86/coco/sev/shared.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/coco/sev/shared.c b/arch/x86/coco/sev/shared.c
index 71de53194089..a0fe7fc9bdc7 100644
--- a/arch/x86/coco/sev/shared.c
+++ b/arch/x86/coco/sev/shared.c
@@ -335,7 +335,7 @@ static int svsm_perform_msr_protocol(struct svsm_call *call)
 
 static int svsm_perform_ghcb_protocol(struct ghcb *ghcb, struct svsm_call *call)
 {
-	struct es_em_ctxt ctxt;
+	struct es_em_ctxt ctxt = NULL;
 	u8 pending = 0;
 
 	vc_ghcb_invalidate(ghcb);
-- 
2.46.1


