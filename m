Return-Path: <linux-kernel+bounces-378558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1347C9AD23F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C820E281CB8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 17:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89E01CBE8C;
	Wed, 23 Oct 2024 17:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="Q4z3DZUV"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AFA1ABEB7
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 17:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729703562; cv=none; b=tax4cB6z4Rg1qn1Y+XSxuJyJZcbetjQMh3uFKVMNzKSQPQ/jkFU8S0tzxGqWYqb0t8o/hogHkrn5vjTQzma8+nyKlTEbmp61lgEHPJtFtSeDWFCr9t3LwJ3o97eWPjtDAnIoghC478JREMRh/KJOOK1tIDCWvu832fK4Y1eeLZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729703562; c=relaxed/simple;
	bh=uzGA9RVFnk0qBU58qh8yjBhrBeuqaB9HoLcmPezi6F4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fU6ineZq7O6+VyEadvthG7XDFe6W6tqkCfx6XMELr/xZKgoSqrMZJjzFqIVds858rBV4tAlsGsXXnfxisaHWWaCC7GhfOIQAeMACHwxte9FMNYbRphh5Cg7bZPNhlhLoTi8aI1g2pPQ+kHR8Hdb8G5PloaRNw/kY92nnj9wWBnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=Q4z3DZUV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43167ff0f91so51510165e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 10:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1729703559; x=1730308359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zjubN0/lE98qNcr+3HybfjjmRgyyjqUeTk1wD1P5OHE=;
        b=Q4z3DZUVfQocgmLG3vYyQf91hTQNdbbGS5H6qIu+geDJTyjC4kiGfQzgC+fSdgttrj
         shWqVJNAdVcqcYF22t1uXMwSC6VMjuB2766qEoho3eNeldRdM3tG8cDpP+c22T75iKI/
         D+qRa5CZkqhk16BUwPR1Q6zE9sW31PlKdW7RPiK1MYmSKxkYFWgYSvC/fALg9B2YFGCW
         NuhR4kXpiYQPB8ZQKeWVAx42WCc6qj4uqgnTD6xleO80hfxfGJvH/bph0QgmyghgwWut
         Vm8O+y52j378JdlEBqwbGqEQQlma6dz2skXWw6/Ty26pEh3mj7Bv+gFw8imAJxKB87gE
         PFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729703559; x=1730308359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zjubN0/lE98qNcr+3HybfjjmRgyyjqUeTk1wD1P5OHE=;
        b=llat5Kbt8K6+A4TuBBbc4gUZWZucUFKIHmlx102wQvR0XLoT9ZNsv2Ct32vayvPSnq
         +sQrlZQHExPtjIZyL0A/55Y53pH4X/aNleTIym214J4rUsdEQdJc6iAonZi8ouHvrqhn
         DWJ4QDMr6Z2Umx5Y4xJZ106qg9fjSk9rRxvTrwhR4HLxX0NUOwmpz2vqMdg3ncq2gWFJ
         aJqyPrzNRheS8Q023jj/o94kfwFzgQBu4N8mo5tQBlr85Ih/xJ4VphWQ3yjZtVOmnz3j
         c66lEGRYLWzN1O/PEQm440PXON+hw73y8gl5okZYEW7ZxsImwvR33uNsJbZ9s3YfdKkE
         GsOQ==
X-Gm-Message-State: AOJu0YxXGxh6gppScKUxcwY+O6CjYsAKxiuLh8wD5P+8AkAuJhZsOE7K
	2LSmQhy0YMU/gH33pn+VJzWGIGIHtrTZn3okjr2L1bSc0QiNHXSdqHJMtw8i+0g=
X-Google-Smtp-Source: AGHT+IH/6AJyCkpKBLtzeKCyUTg1sp5aVMHfflIE0xvRfBn5HglEjq8MIzew/rJrDzJ4B3il8qQ5cg==
X-Received: by 2002:a05:600c:3555:b0:42f:4f6:f8bc with SMTP id 5b1f17b1804b1-431841441b9mr28419005e9.9.1729703558520;
        Wed, 23 Oct 2024 10:12:38 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac1:2880:f0::15:342])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43186c50947sm22047965e9.45.2024.10.23.10.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 10:12:38 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>
Cc: linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>
Subject: [PATCH] kbuild: deb-pkg: Don't fail if modules.order is missing
Date: Wed, 23 Oct 2024 18:12:35 +0100
Message-Id: <20241023171235.1592295-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matt Fleming <mfleming@cloudflare.com>

Kernels built without CONFIG_MODULES might still want to create -dbg deb
packages but install_linux_image_dbg() assumes modules.order always
exists. This obviously isn't true if no modules were built, so we should
skip reading modules.order in that case.

Fixes: 16c36f8864e3 ("kbuild: deb-pkg: use build ID instead of debug link for dbg package")
Cc: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
---
 scripts/package/builddeb | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index 404587fc71fe..9739b0429337 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -96,6 +96,11 @@ install_linux_image_dbg () {
 
 	# Parse modules.order directly because 'make modules_install' may sign,
 	# compress modules, and then run unneeded depmod.
+	modules_file=modules.order
+	if [ ! -s $modules_file ]; then
+		modules_file=/dev/null
+	fi
+
 	while read -r mod; do
 		mod="${mod%.o}.ko"
 		dbg="${pdir}/usr/lib/debug/lib/modules/${KERNELRELEASE}/kernel/${mod}"
@@ -105,7 +110,7 @@ install_linux_image_dbg () {
 		mkdir -p "${dbg%/*}" "${link%/*}"
 		"${OBJCOPY}" --only-keep-debug "${mod}" "${dbg}"
 		ln -sf --relative "${dbg}" "${link}"
-	done < modules.order
+	done < $modules_file
 
 	# Build debug package
 	# Different tools want the image in different locations
-- 
2.34.1


