Return-Path: <linux-kernel+bounces-323977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0520F97465A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85E63B213C1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 23:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E801ABEC0;
	Tue, 10 Sep 2024 23:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1xzeT84"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEFF198A21
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 23:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726010734; cv=none; b=PbZj7ddneeqqfUu5s45wYtkEeala+Y76ZCyLZ6LEKPxJaZsjSxEn3d2nXI4N1mp2TSRkD4tSKY2A7oaaj3Cy0PiwWEUx3n4bLOzRYokCIFOHDMNq8qXSmlCkIxpdIuTAAX6phGs5sVx5bu0lTAiQvYaW9cdBvn/UswE/h1+TCLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726010734; c=relaxed/simple;
	bh=zNOMdv7LrqR/hFdNynu5UlEvalMyhiauTkLRtnuGag0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aWmxdykd7NqbKhF0gpLrru7Ozvu0EU0dOSgE96K9z3kAeXfcdsRpnBU0sxUIutNcB+/iReIpkkL/LrrsF3j5/qz06jPmCElsKxJRFrLX7+XbVRhvVFnWpb2ekDJHUDgZMdiSxFqR+hJeWOKxx6BnMichkfaa6E3l4xnrtXN9KFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1xzeT84; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so216014b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726010733; x=1726615533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d/pYRykvIh23RQKfBCMGlDAqwUb25jIRziDiDqhbei4=;
        b=N1xzeT84IfKhH9cbC4CVm0dj/otOEB/eWLB8EE3TNr3zs8JMLyVAmCj70vPaSzVHJC
         vZbSP2c4wR1aW4gdMhuFnyopf1cUCackxfenstxkPegwTxZ4caufRYsUW3mFxPYUcOvn
         L5IK7Toq6KKSHYB+FQNVWgOCci7a54F74DnZzj+Oj3FrH+B6qSTrlVBIx2XoGB4UHuAB
         9uQHpq2QMVSXALPhDTNLPDy71G/KjmVeKLK/iWRbskoYCi1JarLyhv8WStU7v8JVGdMW
         1xzbS2BOJSbBtdEynDt1DtL5A5HRWkiquPmkNVOVJPPUZ1g15vX3vnBo11yMLqxlKhH5
         9ZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726010733; x=1726615533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/pYRykvIh23RQKfBCMGlDAqwUb25jIRziDiDqhbei4=;
        b=hQwW/x0SPBp8KWwYvbPJjIciwJTkuY4WtHeJx6qUhj1qcOteyM/0jKQfB4PpL0gz7c
         wYm+YrrfbtCaU1LPBMP1WGfIV1bhWxzmH4hAhnDRDlaLldI7L0LBYhU2D0GQW3rIwmmQ
         wIVR+ht6inkqKj3Huc8Phkzi8o9pSvCw973soKm2D0z3XNlA4+TAQiHt63CuAlHbODWn
         HhL1wEMhrLTlk27CTR4xkKyzaNhFyBOovWNU9vHV8inEAGusVhfQ0vBU0WTcj3CUbNfc
         2PLZzxMXxsxIaK+Y7C8STN4JFKzF+MCabubwvaV3cY1dvkp2ZTFO8Zmc798cYL7k2GHd
         Te0A==
X-Forwarded-Encrypted: i=1; AJvYcCWBA3vzYvTuhz4bQU1qDC9E/9MJWAVEpD+sh/H4wssoovfk32Pff6pqyG5t4n9ESUK/jQQCLSZx/hD7GlY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3CW9y4ZTPVUfI6gtGxjTyWzi8PiJsR9JOxCmo2MyYBnHdsFqG
	xCl24CKoe5C53Vy2F3U69YDxrsAktRlEQ6+uQF9coN3KEX6eKXOw
X-Google-Smtp-Source: AGHT+IGkXrUax0+/Bsd/fPRqBZE4MnDANmYCqJlz3FnSf8UUOIJJv+DwiwP/gHhDl5RqzL0fWM1fXw==
X-Received: by 2002:a17:902:f908:b0:206:9818:5431 with SMTP id d9443c01a7336-2074cbac86fmr27434925ad.20.1726010732416;
        Tue, 10 Sep 2024 16:25:32 -0700 (PDT)
Received: from localhost.localdomain (111-240-106-94.dynamic-ip.hinet.net. [111.240.106.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710f1f614sm53199675ad.211.2024.09.10.16.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 16:25:32 -0700 (PDT)
From: Min-Hua Chen <minhuadotchen@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Min-Hua Chen <minhuadotchen@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: hibernate: Fix warning for cast from restricted gfp_t
Date: Wed, 11 Sep 2024 07:25:05 +0800
Message-ID: <20240910232507.313555-1-minhuadotchen@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes the following warning by adding __force
to the cast:
arch/arm64/kernel/hibernate.c:410:44: sparse: warning: cast from restricted gfp_t

No functional change intended.

Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
---
 arch/arm64/kernel/hibernate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 02870beb271e..7b11d84f533c 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -407,7 +407,7 @@ int swsusp_arch_resume(void)
 					  void *, phys_addr_t, phys_addr_t);
 	struct trans_pgd_info trans_info = {
 		.trans_alloc_page	= hibernate_page_alloc,
-		.trans_alloc_arg	= (void *)GFP_ATOMIC,
+		.trans_alloc_arg	= (__force void *)GFP_ATOMIC,
 	};
 
 	/*
-- 
2.43.0


