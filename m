Return-Path: <linux-kernel+bounces-548165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F18A54109
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 04:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3804E7A324E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 03:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9B1192D7C;
	Thu,  6 Mar 2025 03:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Slrm9usl"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339CD19258C;
	Thu,  6 Mar 2025 03:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741230441; cv=none; b=tdbpsDIv003ug59gtU4GaDBz8a6B1nO2fAzf01kGJ/MlzZGB9nnGTjjEGCTC2ItY0Ob0ibl48cIifU8SNDYZdGzrLvibx7CCI5EA8mCTn4m3Cilk0oY6Xc+wNVU9HoZc77eR8c1slmA2iZOF+zaPAW4UnP7JA27p25iHhd7rDUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741230441; c=relaxed/simple;
	bh=LsiK1PtLzBNU+Zsxf5D5WIPUn+Rc0N+TrbjFUPPQhac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eIqcOKmvisfh9mmNxWajcdSDmGLi76hvpe1+kL6KHWppGvbauBPGamAMANTlSrRPlf/Ge1ah2YpiXqa/fVRDTX7lvCIofhaSd6Wn+8h1LTNC78AEQrme8F34HPJAl2+Qs70PD4WueLJC0lVfA0GkDwtnh3Y6ASg/Z4AF4S0GVI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Slrm9usl; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2234daaf269so3280565ad.3;
        Wed, 05 Mar 2025 19:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741230439; x=1741835239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MI0fbHebgBz6v/BSUgcM6nVgauPx5ELe0SOjBFPEjn4=;
        b=Slrm9usluUz0/biyljAeFnqlkjFhsYm7HVBL+gYX4jfLmJlR51KwSp0OhIWdYFmzNL
         IoBjmHYH1Dw9elW+1jErTSCcKgBbs16PgbJhaDSU7C918Y+DPZBXh5DuP97wIyk8z9ES
         ove2XQ5Y3hZ+O4rS7bikS2RZYBw4yTwPdC9IGmMRVJDu51/wEEV4Ksp2O+SZ9HQwOn0e
         M8WPue9AqJ6BSiqTHC64yBlLD5JhSlhBOYN+DKWjN4ISKpv+Lo31K/3lKfylRkotTx+Y
         N+klikTuYwOkUVLOW7wX2iNJeLnPv2obq5txCuWUgK4XvhfWIGNs89isE5RbMWDkBI7E
         fSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741230439; x=1741835239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MI0fbHebgBz6v/BSUgcM6nVgauPx5ELe0SOjBFPEjn4=;
        b=CG+xWX9jZY9K8TOGFAg0Xnm/4FeBcp2DdZ1qHQdUvSwEIMxNKffQ+WZkNJZeCV5rQe
         +acOFLtIYomrk2ejQ/IkAjAdqKUSmo446IGHurQjo2YWWtfDYzJ0GW0UwpnBeAW2syOD
         duA/4xD+GlQdMXk0hXEL5wyRaWmRnXMf4L35w3Mhfs5p3636TkbbwqCly5eKjebrJ1g2
         epBvt3Jp88T+HrZzDu1ds8OTnGxI9wLfi4fwoio8QprJhteH0D249pEXDJZ1wRrCwDlK
         3kf6WS81f0HvujUkvs7CVKUsQQU8prE83m2m6ZKLirDdRjb/fUXCI8PRVyI1EmybUyhc
         l5vA==
X-Forwarded-Encrypted: i=1; AJvYcCUHwBbYyf8dM2JSht8f+Vd1/WGtiq/6NEq3fUyODSyqapwIRVA+baA4slI8mzLsOgoAYa58v6kHakomBV/E@vger.kernel.org, AJvYcCUWUEl5f+ceGjwZyu7N62TR+ddCkLrIBfFK4IrONyYkBRQZWfIonN0u/Q1I/QAjya+/AtU2LqyxH2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy404nUixaqEeybaMxCHotYou2oLQHsfMngJT5fcY7oXcBc+w6b
	3fRaLhp9vWQbjGGco/wsd9yUmKV/my8vfxBMGHMAm6xusB2C8HES
X-Gm-Gg: ASbGnctGWnLw/q1Kx9g4q9CSD5A+x2ry5Wn2QqXr3dV7MCJbwjdZ3UfRs/vGNBgEsnM
	vG5sCtmFXbZjRUmILInht743kDXVIEInZbTbrHe7deDF2hQTa86MtnwjNzEM4Qoxo0dQwn79j7k
	7xHBJ06woBMNlNfWOSSq6inHAoTPe+Byts30YlwQl2JkII+YYlcYkrEnHCL1GzT+tuHFxcQ2F5S
	MvFF/GJvoJZkSVjS0Rn+uEzM6q+Nqo9TJKM3va3KU5M8A2JEVYGwTdHGnlqWmHGOyyMtoMljedE
	zigHBaZWeXr+Rf/2XuLXktLCJghDZf5/HLDLOT4d8UIGNJRG+uAglVp2LPeYdvENrOS35fHTuqA
	=
X-Google-Smtp-Source: AGHT+IFU1Okx3IBuKtWa6ysy6/4EZjEcW1feeyWw+AcHqh4+Mn9vvzzCyXVswhdznFknOim/+7R2bw==
X-Received: by 2002:a17:903:f83:b0:220:c86d:d7eb with SMTP id d9443c01a7336-223f1d26114mr86155555ad.36.1741230439318;
        Wed, 05 Mar 2025 19:07:19 -0800 (PST)
Received: from vaxr-ASUSPRO-D840MB-M840MB.. ([2001:288:7001:2703:a5bd:ac04:2744:49da])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109de255sm1642685ad.45.2025.03.05.19.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 19:07:18 -0800 (PST)
From: I Hsin Cheng <richard120310@gmail.com>
To: corbet@lwn.net
Cc: charlie@rivosinc.com,
	acme@redhat.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [PATCH] docs: Correct installation instruction
Date: Thu,  6 Mar 2025 11:07:08 +0800
Message-ID: <20250306030708.8133-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ammend missing "install" operation keyword after "apt-get", and fix
"build-essentials" to "build-essential".

Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
 Documentation/admin-guide/workload-tracing.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/workload-tracing.rst b/Documentation/admin-guide/workload-tracing.rst
index 6be38c1b9c5b..d6313890ee41 100644
--- a/Documentation/admin-guide/workload-tracing.rst
+++ b/Documentation/admin-guide/workload-tracing.rst
@@ -82,7 +82,7 @@ Install tools to build Linux kernel and tools in kernel repository.
 scripts/ver_linux is a good way to check if your system already has
 the necessary tools::
 
-  sudo apt-get build-essentials flex bison yacc
+  sudo apt-get install build-essential flex bison yacc
   sudo apt install libelf-dev systemtap-sdt-dev libslang2-dev libperl-dev libdw-dev
 
 cscope is a good tool to browse kernel sources. Let's install it now::
-- 
2.43.0


