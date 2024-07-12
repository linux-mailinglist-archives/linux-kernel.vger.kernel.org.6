Return-Path: <linux-kernel+bounces-250471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E6F92F838
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 11:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 327701F2422D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 09:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DF0158DB3;
	Fri, 12 Jul 2024 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSbkAQO+"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E91F143C6E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720777495; cv=none; b=Jwu2gn6sIMTn8o8H2/rJeLWX9wvU812dR8xRNIxO8Lq7Il5BTpF2IsMr8H1bEglp7vsLKwOuyWrJ3SIWBGHvY5a8Q8d0zsbRMol/cVkUl5qcccNItIcRsmcwO+O6e0WqWuZksXPsrCrwXhN7aWtCRPs0Eml6Fl0CbZy2ogWqsak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720777495; c=relaxed/simple;
	bh=cXCdImPJbnsBK/VrSVyH007UEnp46KCD6ej0jXeOF/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qeY8QNJomycD6I0N/0CNMmEYk4mkEtRzVw0ScwEXILe2gQRj+Yr+QIQLeaM4i504xy6LoKXaTxYWccxApkgLKMLkoL3g+eh5YGZ9wGSfMqKSEBn7tkGm6uLG+0ANn7mRs39+0LVZOVD/UYW/qk3ZcJJkiTcpv4mguXt4AQMOMOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSbkAQO+; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-36798779d75so1595500f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 02:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720777492; x=1721382292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bx3ZLiQpsD97OnOBkPiwMTW+SDsVv5mtS+7DR50XRN4=;
        b=XSbkAQO+XCpxiraFkzQ1XWnieUFe2kLRiNiO0CAMyhnBHvDrtGieuaBO1uMSGlI5iL
         nCeAnlFFRe1bV+55t9m85q0MKnpzJGew/KI5RuYauxOAbFY1DyDAPYlIKbEtVDCeb8vn
         FDXvKqRAW1W5WT5zXioliFpkXjfbx8fDAQt1qvXphsxAivFSPaKB7a1LxZjkLxGWlXtV
         UXFdPAP9KhIwtb0WxXmgDt8DXzRsSJ+vpGlWfXZRAO+URucu+FXq8u1PZpEv52BxPixA
         3Vo4STPMBDjJb8Nv5aecwF2tSyjEPYw1DU/LKUyBlTT7cs29tlDbm+7WaFS5dDZfhkpz
         5xzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720777492; x=1721382292;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bx3ZLiQpsD97OnOBkPiwMTW+SDsVv5mtS+7DR50XRN4=;
        b=bKRL9adiLp+vb6qX+H9QJMoeRKHOTRUfT3NDPLWUyJfOG/tmVSCKyI1wdq0vL9oTh/
         p//T/q1nB7cAMdJY3EOIRM8BwCJ7IwajcM9O5URFZK5KbWa951tqzMvGDfigBB9EjQx+
         44yN8MMFp9/u7dFaUBk0xqH+8MwVPfqKo+xYIFD+gR3r6whvyi9xdaBf8NxScrPwpLVu
         4jzhSqrqiby0I8kNX++8gbb0ikEMZKLMP5gytN/dyGslz+B51twYT2QIo7jEWS9ZvoKm
         gkJXds3DNOQyV9UPLOUE4k9ryNcDuZLU6y2EgC/3wWtOuBjJLP37OdT/HQOtHUY5WidS
         QSVw==
X-Forwarded-Encrypted: i=1; AJvYcCVCSGFTewLx1ag/fIntaAxb3xQB2/WllN+338930+kHwFKtcsAyuRh/dCfSImVraZY8rtEX02MnuwDiu2enj6zC+7N9hX70gMZJuWYw
X-Gm-Message-State: AOJu0YyebtJAs2Hp9OCt4m1QWeQAmvYXOGSnEQPqbc3tztEuIL6pLHcp
	h2QbCQQoP7cqEcHdefI5yNUdWrx413RPH0mj6lssTGz3ZLsBmZ7m
X-Google-Smtp-Source: AGHT+IHhl2Camhpoa0lc3UDP9FEESedsTjtgIu4HIxAuOHr8BvFsUU79gNYIqPaLnkfMTAJP+HYRmg==
X-Received: by 2002:a5d:5311:0:b0:367:955b:b8b2 with SMTP id ffacd0b85a97d-367cea6b795mr8462599f8f.18.1720777491450;
        Fri, 12 Jul 2024 02:44:51 -0700 (PDT)
Received: from sacco.home ([2a01:cb1d:410:d000:694d:fc10:55f0:9f1f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfa067dsm9851861f8f.78.2024.07.12.02.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 02:44:51 -0700 (PDT)
From: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
To: linux@armlinux.org.uk,
	robh@kernel.org,
	rmk+kernel@armlinux.org.uk
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	javier.carrasco.cruz@gmail.com,
	skhan@linuxfoundation.org,
	Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
Subject: [PATCH 1/1] arm: devtree: fix missing device_node cleanup
Date: Fri, 12 Jul 2024 11:44:48 +0200
Message-ID: <20240712094448.159784-1-vincenzo.mezzela@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Device node `cpus` is allocated but never released using `of_node_put`.

This patch introduces the __free attribute for `cpus` device_node that
automatically handle the cleanup of the resource by adding a call to
`of_node_put` at the end of the current scope. This enhancement aims to
mitigate memory management issues associated with forgetting to release
the resources.

Signed-off-by: Vincenzo Mezzela <vincenzo.mezzela@gmail.com>
---
 arch/arm/kernel/devtree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index fdb74e64206a..223d66a5fff3 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -70,14 +70,14 @@ void __init arm_dt_init_cpu_maps(void)
 	 * contain a list of MPIDR[23:0] values where MPIDR[31:24] must
 	 * read as 0.
 	 */
-	struct device_node *cpu, *cpus;
 	int found_method = 0;
 	u32 i, j, cpuidx = 1;
 	u32 mpidr = is_smp() ? read_cpuid_mpidr() & MPIDR_HWID_BITMASK : 0;
 
 	u32 tmp_map[NR_CPUS] = { [0 ... NR_CPUS-1] = MPIDR_INVALID };
 	bool bootcpu_valid = false;
-	cpus = of_find_node_by_path("/cpus");
+	struct device_node *cpu;
+	struct device_node *cpus __free(device_node) = of_find_node_by_path("/cpus");
 
 	if (!cpus)
 		return;
-- 
2.43.0


