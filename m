Return-Path: <linux-kernel+bounces-557879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B218CA5DEFF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736D9189EA7F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC442156653;
	Wed, 12 Mar 2025 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jwx+kk77"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA99824E01A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741789880; cv=none; b=c0gQmke64lzbhDBSG74uHLmzHIPy5NzBXMWXVHwbti1+LfG+XDLH+mTIDMKeqBNILJZ5aJEchU8V0UWqg6MKNQUmthcrNGK+t2K9vJq6J6DrQtOXzbSow66tB8QasDk55pHHBcmib9Ye0MkOIygMuQMQoAJitEd6+D9B37I+T68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741789880; c=relaxed/simple;
	bh=K1NuAEngcPclmCzbSgtaq+RrDGOZqTUJu3ZdtBcGZ2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BePiCuQReLzfHCCAhi1zWSt2Lg7BzCcw0eChPMkAybhJuXYEm+sMntjimpzeXYH0lk4LLNAbyi+KZe4tI0+ZeAM/fQoid6vJ6ud8KRXcq8AP4oOPUPQJ86iaYAsT5m/yExMXPmwjlTGGlF9RxiqSbUW6mF16w+Hn1ym0zJf7TV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jwx+kk77; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22185cddbffso18032155ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 07:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741789878; x=1742394678; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7wHVeTdcbD/lMPZ+7RVnSVzW4Yy+8n9avYr5uzJiRKg=;
        b=jwx+kk77FolmhrTxmZxn/WcsnAr+FgFEGtF4C6eZqAN1rfsUeSCRmOkxmBxEYF0p5C
         yMmAryUn5rYQNQ0Q/O6HyTbE8WEwIs80vB3Mei2QCnZQ/vSvw+B8/RyqjRDBwgj0jAij
         QgHPpGQdjEDVlo7xy81bdMv9cQ8nRD847+lC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741789878; x=1742394678;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7wHVeTdcbD/lMPZ+7RVnSVzW4Yy+8n9avYr5uzJiRKg=;
        b=wet1RzEh/d2240GAIXd4CzRKgperUnGvCJ5ZFuk7WLs+3uTGcnxBzgaGdQ0lLCYnHS
         8D3Mf/t8JYDRWhow9ZjDHMeVhyxDICMg369VkiL7Brl2E2GRwrnKqg1M+3hnp2CjbJaf
         i2z/EbdEg6Ifj7BQXb0Nv/Xo1XvOGqKiTbeXvEMcGFmQW4VEIMPsQBE11OmSwilmrVMM
         27H3oUHzqFaKbIpLasGxhl6pqbtUfW65Dibd8T7uIEeJVfVzFSU9C1SkEOG6uu0Knj1Y
         i7Ym7JzR85/HNl9gnkqDjiW17adylDfqMdKL9vasYnNQeCECM4gLi6cDbiep/PAVvxSV
         Jztw==
X-Forwarded-Encrypted: i=1; AJvYcCXllopbiCUFowQ5pStq2xJ1GZ+DxwH6Czrrvfm3BXVbbvM5wHt1fxGejGRX5CJwPDMzNRRyiti34XwASHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCskrifM2jlyrSrrZyOXcCuDw+kIsIAggTHQGP2VUjff9Aops6
	cywbiyHXE2XOrlkSxHYR5QlxgcEGTLhvJGbG/ug8duvcdpxwaS0988xpEu6B3ZP0l9Pf6hPWgUg
	=
X-Gm-Gg: ASbGncuw9aKWzfpYmCIqpWN4bJPCs7NFYJ/XXOF9oaSsuP6hCSnmZeogDZLHXJx5k75
	xg+BpynWvnsgD2xE04OUP9syDIcoyJd3e9MRBObrS3F5OJGBvrlPLrToV96fgTBnfRaCSwkDY1m
	ubY4joZRZLXpxdbt9J2p0bZRYTsGhV2x6yQprSHZ43WxpU/ZWexH35o4uD0NgZxXb2vKXbkCVt0
	3fYeEZbioTHwDvLctsobgx25JrkDJ3xxoYWE72FsOxZPBce/FDqsHtc6rZZxEvVKruyemx9HhGR
	tJ2IgzAkfRKrB61HOPWaKdlhxUzoRxKugpFfx5Qmx9+uDg/i2lcv3WNoKaoowdONRueQWOln5OV
	JrxofzQGvUL6+EUcIOpqr883+
X-Google-Smtp-Source: AGHT+IGso4VXNf4LaA6gyp5gDGaLztOCm9ys3zkim+c3BRQl8gd7egffGxKYj+WJgPgAHh1RMcUppg==
X-Received: by 2002:aa7:8449:0:b0:736:b400:b58f with SMTP id d2e1a72fcca58-736ec417889mr10251381b3a.0.1741789877798;
        Wed, 12 Mar 2025 07:31:17 -0700 (PDT)
Received: from zipper.pdx.corp.google.com ([2a00:79e0:2e13:6:ea1:ba82:2605:7d4e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736af3a69b2sm10408708b3a.6.2025.03.12.07.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 07:31:17 -0700 (PDT)
From: Fritz Koenig <frkoenig@chromium.org>
Date: Wed, 12 Mar 2025 07:31:16 -0700
Subject: [PATCH v2] Documentation: ocxl.rst: Update consortium site
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-dead_site-v2-1-920a313743ee@chromium.org>
X-B4-Tracking: v=1; b=H4sIALOa0WcC/23MSw7CIBSF4a00dyyGR6XWkfswjUG4LXfQYqAST
 cPexY4d/icn3wYJI2GCS7NBxEyJwlJDHhqw3iwTMnK1QXJ54koI5tC4e6IVGfb6rNpecK0V1P8
 z4kjv3boNtT2lNcTPTmfxW/8pWTDBOvNQFo3q2lFerY9hptd8DHGCoZTyBbJ8ivOlAAAA
To: Frederic Barrat <fbarrat@linux.ibm.com>, 
 Andrew Donnellan <ajd@linux.ibm.com>, Jonathan Corbet <corbet@lwn.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Fritz Koenig <frkoenig@chromium.org>
X-Mailer: b4 0.15-dev-37811

Point to post-merger site.

Signed-off-by: Fritz Koenig <frkoenig@chromium.org>
---
Changes in v2:
- Update link per feedback
- Update commit message to reflect sureness in corectness
- Link to v1: https://lore.kernel.org/r/20250311-dead_site-v1-1-7ab3cea374f2@chromium.org
---
 Documentation/userspace-api/accelerators/ocxl.rst | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/userspace-api/accelerators/ocxl.rst b/Documentation/userspace-api/accelerators/ocxl.rst
index db7570d5e50d..4e213af70237 100644
--- a/Documentation/userspace-api/accelerators/ocxl.rst
+++ b/Documentation/userspace-api/accelerators/ocxl.rst
@@ -3,8 +3,11 @@ OpenCAPI (Open Coherent Accelerator Processor Interface)
 ========================================================
 
 OpenCAPI is an interface between processors and accelerators. It aims
-at being low-latency and high-bandwidth. The specification is
-developed by the `OpenCAPI Consortium <http://opencapi.org/>`_.
+at being low-latency and high-bandwidth.
+
+The specification was developed by the OpenCAPI Consortium, and is now
+available from the `Compute Express Link Consortium
+<https://computeexpresslink.org/resource/opencapi-specification-archive/>`_.
 
 It allows an accelerator (which could be an FPGA, ASICs, ...) to access
 the host memory coherently, using virtual addresses. An OpenCAPI

---
base-commit: 0b46b049d6eccd947c361018439fcb596e741d7a
change-id: 20250311-dead_site-e96834910663

Best regards,
-- 
Fritz Koenig <frkoenig@chromium.org>


