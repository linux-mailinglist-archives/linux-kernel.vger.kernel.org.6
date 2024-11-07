Return-Path: <linux-kernel+bounces-400148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82EE9C0990
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C321B2164F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1E8212177;
	Thu,  7 Nov 2024 15:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="aqa/AA6I"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E11D2940D
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 15:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730991915; cv=none; b=r+nnBMb0W9T4nPMu1CtBn7NP7jKgKdbekGguWB3wrjoGGZomkTgyBRt52hBvHXBpvkbOy2XazGv2GV37q14r+KjijSMDC+GOgmV1WllLNlU3ykgBJsA1wvC1FgDVr7atQk4kfwLh+UkHvJWo24yKsZqq0rqtJ0VWTurHt2fLGOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730991915; c=relaxed/simple;
	bh=JYB2rONnGgA9cyzBUQh8hHxI2XT6QsjpR3+KbevXCsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IzEf1ybJAWM5vtwP6pKGyQM0x3LGctIRHjHLbT8sNP0jWeIiPKLbqYEWUJD4OhxKBPm2SL5BewJq+r7oPMbyOguu+UtJswsmZfA9zBIhtmrUhWoBeg+H1tw1ik2K40KgIndL+IYnq0JrHNH1qi2VMqwH3tT2aL35LX/6ice/VdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=aqa/AA6I; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4316e9f4a40so8899995e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 07:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1730991912; x=1731596712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lg27wTI8f39QfS8u2we5QcBCxwqdnW6Uymk0y8tPYVg=;
        b=aqa/AA6IbohN5ZLZt3ir+29mxl/ywqaKZ8Bc5e4gRb4Ad4rLqVadsRjzqGyX6O0GLi
         a6M//Q56/mAF1g+z7FPatVVbKK2SnrbD282F9L6/TDqjHU+uyVEl4uBkqqI/J86rv9rx
         Et3zlK5Wx9Q8qE/CYh8usg2mDU2Efv0AQs2E2JuidNuC5yFVfzFEaInjjh5pBMhbm81V
         aVzMFQ8xGtr0Trsfmgp/L3x4cMBVUOZEQr8HXQU3h7WwCIw/olyLRa7So/6xr29Vp3ns
         YRLlp3hCHS12h9jXFjBe/gTnS1+WReiCv61ur0eBp8EdzRIRHfMyolzaw9TQbAsToEnV
         lyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730991912; x=1731596712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lg27wTI8f39QfS8u2we5QcBCxwqdnW6Uymk0y8tPYVg=;
        b=maoZV9e9kxUnNjOEOijfJ/EJnzyAtlIXN7KHD+R+1Vi18oiS7ofV7BhJ2IIDDgAih4
         gtIPHNCo9/e9GxzYbY/IyM/qC11+6faI3sY+JO6ZCggV0eTPGnnuCm1oMzNHEWBEC0kD
         DQw215L9iMQYmnv69JEI+Xraxwa55zItw7AI4KBc6N71jCTqqoPHPv7y2W0m6DafWrFx
         yc+Vt/fI6bRqlkv9/f4Ul7EkiFNuHP31swsQowyVVO9rxQYckJIgYYA1CUl8ikSCnPml
         ebwGToLAjrEOL97VfiODnO0WdxLcgOI8L8XLmYFXbqxiSgXNf4Wk0r+O6CLBQnXl0VVC
         g/cQ==
X-Gm-Message-State: AOJu0YwkLjXf6IM4dQ/DiJNGuTCvTueMbfajn6IARSIKQUw5WnwBLi5e
	WphuD1SVUBZhbxRtBtBkT1hd5q/GmSJHo4SGgw0cJHAyZzeEt2BnvSvkJycNagc=
X-Google-Smtp-Source: AGHT+IHJQOj8gJUFLGdhzZqxrtrZoHhp+SVRoso935asClAWrK+CzNptX0NLsDU1i9rUv+QJpZEWjQ==
X-Received: by 2002:a05:600c:34cd:b0:431:157a:986e with SMTP id 5b1f17b1804b1-4319acb8d3amr359558585e9.20.1730991911554;
        Thu, 07 Nov 2024 07:05:11 -0800 (PST)
Received: from matt-Precision-5490.. ([2a09:bac1:2880:f0::179:1ba])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa5b60cfsm63088485e9.7.2024.11.07.07.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 07:05:11 -0800 (PST)
From: Matt Fleming <matt@readmodwrite.com>
To: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>
Cc: linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>,
	linux-kbuild@vger.kernel.org
Subject: [PATCH v3] kbuild: deb-pkg: Don't fail if modules.order is missing
Date: Thu,  7 Nov 2024 15:05:08 +0000
Message-Id: <20241107150508.2835706-1-matt@readmodwrite.com>
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
Cc: linux-kbuild@vger.kernel.org
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
---

Changes in v3:
 - Wrap modules.order logic in 'if is_enabled CONFIG_MODULES'

 scripts/package/builddeb | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index 441b0bb66e0d..fb686fd3266f 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -96,16 +96,18 @@ install_linux_image_dbg () {
 
 	# Parse modules.order directly because 'make modules_install' may sign,
 	# compress modules, and then run unneeded depmod.
-	while read -r mod; do
-		mod="${mod%.o}.ko"
-		dbg="${pdir}/usr/lib/debug/lib/modules/${KERNELRELEASE}/kernel/${mod}"
-		buildid=$("${READELF}" -n "${mod}" | sed -n 's@^.*Build ID: \(..\)\(.*\)@\1/\2@p')
-		link="${pdir}/usr/lib/debug/.build-id/${buildid}.debug"
-
-		mkdir -p "${dbg%/*}" "${link%/*}"
-		"${OBJCOPY}" --only-keep-debug "${mod}" "${dbg}"
-		ln -sf --relative "${dbg}" "${link}"
-	done < modules.order
+	if is_enabled CONFIG_MODULES; then
+		while read -r mod; do
+			mod="${mod%.o}.ko"
+			dbg="${pdir}/usr/lib/debug/lib/modules/${KERNELRELEASE}/kernel/${mod}"
+			buildid=$("${READELF}" -n "${mod}" | sed -n 's@^.*Build ID: \(..\)\(.*\)@\1/\2@p')
+			link="${pdir}/usr/lib/debug/.build-id/${buildid}.debug"
+
+			mkdir -p "${dbg%/*}" "${link%/*}"
+			"${OBJCOPY}" --only-keep-debug "${mod}" "${dbg}"
+			ln -sf --relative "${dbg}" "${link}"
+		done < modules.order
+	fi
 
 	# Build debug package
 	# Different tools want the image in different locations
-- 
2.34.1


