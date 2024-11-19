Return-Path: <linux-kernel+bounces-414795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D36249D2DE4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 246F6B28F3B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F571D174F;
	Tue, 19 Nov 2024 18:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQfs1Z/Q"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6C31D0F63
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 18:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732039562; cv=none; b=Ikz9Cr66yzZorezew9vdHfAYA7d/XYhXlXqGG8LgHLlCUmzlBcQaeDgvDibYDQ8BbcsE62IHhcnVXOKYf+gNsOaMNJe9CoP3+8nS4H1Cyf6OrEcwRPf8xxLM8Bp5sLIEKvBapUuLlgMq9qSaaQ0hcXZYPTpQ828kvZEcqWLWG/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732039562; c=relaxed/simple;
	bh=STE9JFqnlTAfZ/i/oOOtvS3HCy01Lw0yY8KiuXEVR/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HfMmV36biYwWn25hboKpq7yGIgTOs7+w+0nVoO1svh7hXufeL8DU+xzzJKCnRlLBMxYqe0mSxaJOcE/9xAotrJK4p6Pzu4441cmsS8xs4v3BJL1U6QaoRrY7kHtxJfNDZtgE2/PFy8YDINVth0aFA33oTa/XMG973DCR+oy6ipw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQfs1Z/Q; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20cb47387ceso12871535ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 10:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732039560; x=1732644360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y/FlE2aHc/QsNDaHWvtYvH2BMza0ovXyy81H1Sc5/I8=;
        b=ZQfs1Z/Q9NBOGrFVvPOLfJ7E3+D7TMr+hEGOL8lhbusUVPzDVyTtrKCLcJEWrK3m9x
         ditVTACC7qGMvmWtZp6pfmtXrcbHinobQ74BwqZqPxY5+XD9N06ETRTk1vVYPZqtlMxZ
         Zfl2ryGBUJ6zt77wNomTaSBNTlsKdUDbQuiQ4nsN4xRjT9SzZkx9t1ttUilF0Bd8sFFX
         l4dj8qg2gJhgYFVCaytZ4CDEpulQ/0DgkZ4UEPSMFrw3R8DVolIHpcHM8hdYGocR1Su6
         zliwwY/R65ryZTXuKtHqRTufENLLIBYdsrvesrgnodSjY3YiJyat6GWEje+ixEeyUruy
         HJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732039560; x=1732644360;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y/FlE2aHc/QsNDaHWvtYvH2BMza0ovXyy81H1Sc5/I8=;
        b=AWi7Azsc2b5TF/kO8VhShm3+KerhkhXqoBZqzVJ7IRX3xA+OjfJWASwrgtG21Uh8zj
         Fw+VWO1BVtTRyOQLUxcDwYDstbJKb2I1CEqz+drdaFgBryxtU1ZWZC0Q86aht/vUIbqR
         3Z36F6WdTNA2nQMDXJYHBhfXYhBZ7dDiLnRSWveDv9UR2FGqNqps7Y1Sqa7ArqHbGT3a
         z0CEkuFNctMs8JllHTdk6N6B5+7yDuOpCbShta2TbYyRAcMRtvBPKWJyLIS9z2Ts4eEp
         RQiYlKjwin1/T+9QSSmkPlFK5wMbHqgglmTVQZ6oebi37GcrMvdNSIl/sq1Uv/3v42RB
         0bXA==
X-Forwarded-Encrypted: i=1; AJvYcCVXnE0UTNbD+QpsbLq+yUxfuJfzJTp4xc4A65t5sSYUPG3P/GQ0IMOL76jaRmX5BiO+OfhroVYkvpFWy6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YynBWnueONTLHIttt2+mw+l3GpR3wA+Wm1P0aM9atc88qezDCeC
	iHr+sJGztv/q5IlNriyWnx76QAKmalasZtNrN8nwrFhN00tmkgbt
X-Google-Smtp-Source: AGHT+IHH/C1zxnC4To6VFinpcC5jGM+peR5xpjNtpRKinlMIx6rqfBFFr6fAl9OaD/7nDysyGRldTg==
X-Received: by 2002:a17:902:6acc:b0:211:6b21:73d9 with SMTP id d9443c01a7336-211d0ebf447mr170610775ad.37.1732039560385;
        Tue, 19 Nov 2024 10:06:00 -0800 (PST)
Received: from localhost ([38.141.211.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21223e5e1d2sm38932615ad.163.2024.11.19.10.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 10:05:59 -0800 (PST)
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
Subject: [PATCH] Updating es_em_ctxt fi to zero
Date: Tue, 19 Nov 2024 10:05:18 -0800
Message-ID: <20241119180517.196079-2-ragavendra.bn@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Updating es_em_ctxt to zero for the ctxt->fi variable in
verify_exception_info when ES_EXCEPTION is returned.

Fixes: 34ff65901735 x86/sev: Use kernel provided SVSM Calling Areas
Signed-off-by: Ragavendra Nagraj <ragavendra.bn@gmail.com>
---
 arch/x86/coco/sev/shared.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/coco/sev/shared.c b/arch/x86/coco/sev/shared.c
index 71de53194089..b8540d85e6f0 100644
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
-- 
2.46.1


