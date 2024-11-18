Return-Path: <linux-kernel+bounces-413592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BFD9D1B5A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 23:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEA611F2211D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 22:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACF521E8851;
	Mon, 18 Nov 2024 22:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1Xhk9ri"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55C01A9B34
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 22:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731970745; cv=none; b=K4YEy8iEgCubfosD0sOgPA7zYlVDGok/f+S0F3qkhCiqT4bLrwP21/TTNRF6f/KehRmn1FnQdcuLmbqDRZcMRNVppqnxYyJv751zAMlSamt+fKzMzAC/jjdWwGvISXy9g8E2R9EIYKPPma1w/JFsT0AEfRH4lAbQ6pw5nvKPyyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731970745; c=relaxed/simple;
	bh=QqVl+NjUCRT6QDlOEMA6fw+qelIPNF5bBIahHZJccoE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pEWCkod4TbwgWn/7oNvfrPc7LB3J+ZJzH3osAEcncCgipJBYGrTaZkCjHBAUUR3WApmqOIcVCfAlIQVBZuZLKu01wWxrcBdKhhgpvRmN++db25SRscaxzMT5eSpzy/eq6eBvPfG8n3h15jCB7K49UzwQ3wGlFXpKoiQ0gQgLLS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b1Xhk9ri; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-211fb27cc6bso20831485ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 14:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731970743; x=1732575543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AbHTE8mRQYflZeqQtKwhcMBhbRS66x3BS/fqofAiajw=;
        b=b1Xhk9rifydPRMJ+aVLv/lor87SjEpTM2TOGBkLmOH1TWOZ7mtXiPELRCtD4BZc/or
         MnOJRKmuXc2G+NFlGNhIKPKuo8+92AaQgden9KoQJqE041QDJF8Xoj+bd2CCNQZDWppo
         G2/xW1nWI29WrNmNF+VO+RtCPNHOU2Npql+F/JIa7vmE5sl93fxnhQ4hssFg04GgpKrQ
         dliokYlIYmq0tV/K40PGB24DOWFc2Yy25j6Cr0biMPfklEPCOxhISqPU9dtj1nGxiHhW
         gTQoZX7NjQn4jc1pcSak7UHIs3OAkokG5jXmGL7Q+zZa3/ou2Hq+NerMvlBSzJxDv5Fk
         2o0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731970743; x=1732575543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AbHTE8mRQYflZeqQtKwhcMBhbRS66x3BS/fqofAiajw=;
        b=krYW7gXLdAdKI1Y/uvLQkD6xqRITlw8ixL1e6V5+cEXq6taQbQEv/7F0ujAmVfKcYN
         hqXTx3ruK2c9WgY6tYh8w6Jy1veeJLW3dGzHAbhO8CPMPaqXdDibU7B8eZ12Af+imrou
         Dr2jqQKJapn2HUSJNgRs6ALU1bMzMRc7bty2Wb9paQyFaYfnWOnIAsO60xBBrXgaERE6
         6ObHIQv7re4uKBjb1Zmb4HfTbETD8ztubOozQynBxJa8rS4SXCTS/+EqvvJQwi8n8ycm
         NvFlIiGBkhXrglp1QstUPy7nVW4cJFkGKXJ99pc5Y7UlkQo4pgq1slJW9xllEr0cYzIt
         lbrw==
X-Forwarded-Encrypted: i=1; AJvYcCVc99E7R+CuJoOmT19IjvIUGmZSz2sBw+Gh+3wLquC0YkYBlCu5DnfaDpjK1UBEWMtoNiyxL5m7uUCKGhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXTWtaOJXf031wmjyEHLrB/dIRoraO7UFxj5RBki5lQGAObQHp
	F1R9L6h/e8Jql9OqS8TTXY2FkwtQPx+rsnlxBUWh48+J29S7+AZ/
X-Google-Smtp-Source: AGHT+IFeqHikFsu/GhmWbEmvdVXwrl0rB5o/TnuHjj/IBZKYf5Rb/RBelv1SJ1CHmz13ywVND9poHg==
X-Received: by 2002:a17:902:ced0:b0:20c:ee32:7597 with SMTP id d9443c01a7336-211d0d5ba76mr188024505ad.8.1731970742663;
        Mon, 18 Nov 2024 14:59:02 -0800 (PST)
Received: from localhost ([38.141.211.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0ec8608sm62530925ad.96.2024.11.18.14.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 14:59:02 -0800 (PST)
From: Ragavendra <ragavendra.bn@gmail.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	thomas.lendacky@amd.com,
	ardb@kernel.org,
	tzimmermann@suse.de,
	bhelgaas@google.com
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Ragavendra <ragavendra.bn@gmail.com>
Subject: [PATCH v2] x86/sev: Initialize ctxt variable and zero fi
Date: Mon, 18 Nov 2024 14:58:29 -0800
Message-ID: <20241118225828.123945-2-ragavendra.bn@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updating the ctxt value to {} in the svsm_perform_ghcb_protocol as
it was not initialized. Updating memory to zero for the ctxt->fi
variable in verify_exception_info when ES_EXCEPTION is returned.

Fixes: 34ff65901735 x86/sev: Use kernel provided SVSM Calling Areas
Signed-off-by: Ragavendra Nagraj <ragavendra.bn@gmail.com>
---
 arch/x86/coco/sev/shared.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/coco/sev/shared.c b/arch/x86/coco/sev/shared.c
index 71de53194089..5e0f6fbf4dd2 100644
--- a/arch/x86/coco/sev/shared.c
+++ b/arch/x86/coco/sev/shared.c
@@ -239,6 +239,8 @@ static enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt
 		if ((info & SVM_EVTINJ_VALID) &&
 		    ((v == X86_TRAP_GP) || (v == X86_TRAP_UD)) &&
 		    ((info & SVM_EVTINJ_TYPE_MASK) == SVM_EVTINJ_TYPE_EXEPT)) {
+			memset(&ctxt->fi, 0, sizeof(ctxt->fi));
+
 			ctxt->fi.vector = v;
 
 			if (info & SVM_EVTINJ_VALID_ERR)
@@ -335,7 +337,7 @@ static int svsm_perform_msr_protocol(struct svsm_call *call)
 
 static int svsm_perform_ghcb_protocol(struct ghcb *ghcb, struct svsm_call *call)
 {
-	struct es_em_ctxt ctxt;
+	struct es_em_ctxt ctxt = {};
 	u8 pending = 0;
 
 	vc_ghcb_invalidate(ghcb);
-- 
2.46.1


