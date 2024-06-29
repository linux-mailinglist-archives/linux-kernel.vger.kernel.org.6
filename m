Return-Path: <linux-kernel+bounces-234715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5140791C9C2
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 02:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BEE71C215AB
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 00:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E800816;
	Sat, 29 Jun 2024 00:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="DLOktC1K"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE5B386
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 00:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719620775; cv=none; b=DnNPxdE8mXb388mpM9/n0gPiQJZ6wXoAgqrwaK/YUuZuOs1g+5u4cv/2HBjbk18Hz6kZyrTX9FmaK9gZtdnb8MfggMEO7W46UNrSqA79m2fKafwRElER3IzKN9i4e0DXaRJ2V9j8+GLy/QnplnglhszlcZTPAl4PvSXkthMDHOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719620775; c=relaxed/simple;
	bh=juYnk63GENV7/dzTgZy7CMBF5S/a+nYHrdMU1skYSO8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ieUldfVxDf0wJ7FknXXSN8Z2anbVxhKf0c4mmBCatI07x9BIZDKltk8ElXGuliiaft41wNKCtxK0NFG8ARDd9zeSlbd+Qg1FWdNMVRj5yq17T75WuWM3BORi7/AKMYTUhc4Dblqm7aFXiNRByMuDTNJ9s3hgqXvZxP4nkdlo4IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=DLOktC1K; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-706683e5249so852931b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 17:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719620773; x=1720225573; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aSdyuK/9EHV/U4rOZJpo8LtJsTBOsCCeCRMcU68Fw1s=;
        b=DLOktC1Kk5rXSl9aX9V6g7F+dUuf/wE7fSBH8HKq0PZ64f0bw23Y6ry8w0AMu1bO+S
         caOFjV74Z0jRx7wRQtLOVC1JbZ72dlh2oiEw5dUYFqmBWwwW2JewmsJjKKrAEaDHP8AP
         3DENQ24g4PNslS0cQ+GahqUcY9nMm4YG5V4QUGSGPmt1+Mookf60FCeeULPDWSSsFh5j
         87uZNbDAfWv1sWAljoI5bDpFkkQUae9jO8E0LlVzEXeipBF9iFBtotoIGoSgbwEuFD0x
         i6Mm+u/6O6Uh47ASbfKXSRdJ5+uxklkDXoGLNP1iu1wzoDXChfUS8XESGWt8kemZ+oi1
         zewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719620773; x=1720225573;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aSdyuK/9EHV/U4rOZJpo8LtJsTBOsCCeCRMcU68Fw1s=;
        b=GeZDcCCzmPt9T3vjyFJ6Ql4qR64jNR4zCOYVfzdQovXGiC3VKr101z9vqdkVTAs7GA
         /Qf4EX3kIHzCw/TsEXG0jJp9NVx4UlF8R+sxEV7ee8A6a0X+EQG5OGk8SHX1I4G6tLgX
         FAqITJ+BSaa36xm8NxCAlnymoemsRR/4hFnxQUlSGh9NKh225/yY28B9aoeaxLlhO+tc
         vhhim6b3vGsrElurPSmEmOWafoIwgfrB9iiHG1mhQmGRNgLNRwfkJSKs1c2IkDtyBS3z
         BgE5e+8b4jhI0wCkjKhpIit5QqPEz3xyw2QkAh0dZ+Z8f44U97useML45cxlmQJ7pGMO
         lq2g==
X-Forwarded-Encrypted: i=1; AJvYcCWeBm3P6gygU7uVvRYKIWFqZXbwSq7RzCPQnWYf0MSk2a1QdOPMUeNWBDs+MWWIaI4SwXbTrwa9Y5TXQYcJTF8EmERB7IiUOwSyBgLZ
X-Gm-Message-State: AOJu0YyxbVouiY9Kr5EzSOkTlvClwOgLqqCIWXaQsxp0A3GyXrvEgeDH
	4e0it/dxirdun9R9tB2H7AhO55e2jOju2twrHqtHiPjV3dg2ugXxy4dIqhM2OOw=
X-Google-Smtp-Source: AGHT+IEUKko/k4/6xXNCFY+KFjLpcjGNhy52rvbM05wygFCT1kSEw2lhuzMfsadc4asggUJvSJSz+w==
X-Received: by 2002:a05:6a00:1acc:b0:705:d8c9:f5e4 with SMTP id d2e1a72fcca58-7067454ad53mr22852485b3a.6.1719620772631;
        Fri, 28 Jun 2024 17:26:12 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708044b1112sm2212053b3a.182.2024.06.28.17.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 17:26:11 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Fri, 28 Jun 2024 17:25:49 -0700
Subject: [PATCH] documentation: Fix riscv cmodx example
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240628-fix_cmodx_example-v1-1-e6c6523bc163@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAIxUf2YC/x2MWwqAIBAAryL7nWD2sq4SEVZbLeQDhRCiuyd9D
 szMAxEDYYSBPRDwpkjOZigLBuup7YGctswghaxFKxXfKc2rcVuaMWnjL+SdVqJS1SIa1UPufMA
 s/c9xet8PCIo2h2MAAAA=
To: Jonathan Corbet <corbet@lwn.net>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>, Atish Patra <atishp@rivosinc.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-doc@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719620770; l=1521;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=juYnk63GENV7/dzTgZy7CMBF5S/a+nYHrdMU1skYSO8=;
 b=99DCJWrEWmIJO23ODkaplB9EBbYalo8Zt/oDmYSmDCSdolAEaR2BUam3bXH8vdjkcvuCGOaXE
 nr6YjNkomtxAROeT1JFwg5zs5LTjxLxWlHNskwi5AmiSm7mtp+oNv2m
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

ON/OFF in the keys was swapped between the first and second argument of
the prctl. The prctl key is always PR_RISCV_SET_ICACHE_FLUSH_CTX, and
the second argument can be PR_RISCV_CTX_SW_FENCEI_ON or
PR_RISCV_CTX_SW_FENCEI_OFF.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Fixes: 6a08e4709c58 ("documentation: Document PR_RISCV_SET_ICACHE_FLUSH_CTX prctl")
---
 Documentation/arch/riscv/cmodx.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/arch/riscv/cmodx.rst b/Documentation/arch/riscv/cmodx.rst
index 1c0ca06b6c97..8c48bcff3df9 100644
--- a/Documentation/arch/riscv/cmodx.rst
+++ b/Documentation/arch/riscv/cmodx.rst
@@ -62,10 +62,10 @@ cmodx.c::
 		printf("Value before cmodx: %d\n", value);
 
 		// Call prctl before first fence.i is called inside modify_instruction
-		prctl(PR_RISCV_SET_ICACHE_FLUSH_CTX_ON, PR_RISCV_CTX_SW_FENCEI, PR_RISCV_SCOPE_PER_PROCESS);
+		prctl(PR_RISCV_SET_ICACHE_FLUSH_CTX, PR_RISCV_CTX_SW_FENCEI_ON, PR_RISCV_SCOPE_PER_PROCESS);
 		modify_instruction();
 		// Call prctl after final fence.i is called in process
-		prctl(PR_RISCV_SET_ICACHE_FLUSH_CTX_OFF, PR_RISCV_CTX_SW_FENCEI, PR_RISCV_SCOPE_PER_PROCESS);
+		prctl(PR_RISCV_SET_ICACHE_FLUSH_CTX, PR_RISCV_CTX_SW_FENCEI_OFF, PR_RISCV_SCOPE_PER_PROCESS);
 
 		value = get_value();
 		printf("Value after cmodx: %d\n", value);

---
base-commit: f2661062f16b2de5d7b6a5c42a9a5c96326b8454
change-id: 20240628-fix_cmodx_example-7a80383b0589
-- 
- Charlie


