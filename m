Return-Path: <linux-kernel+bounces-397145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5589BD74D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 21:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3167B1C20CA1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 20:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1853215F5C;
	Tue,  5 Nov 2024 20:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="kGS+HU7q"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF80215C40
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 20:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730840227; cv=none; b=GgaX6o1ltLQXFMTKpivznv06edNNG8XPaHYbrY83f6saD2RWXepXREedpvcPMIgz+p2TyKnnh4e40Q4IqjxqW0OvfMhxLAKlRyKt5XdW18+QO10O19TUDKDg/r3dT1sHQZ+dsYsCDVFHzMszdy3xdfggJeC3cuWecM3LT3J+epI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730840227; c=relaxed/simple;
	bh=GHpjGdiNrlJ/7iw59JS8J/mY1OoJHcBkilxMS2ryE3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kl6vicDD4ekGUPGuu0OrlwvGq6M0HxmY7Psj4OK3DcwHe2Re/YBpjRFSDyGNaW7EBeM9G/PonHoofV/VBSvQO8e4nSVRldSGCE5Q907z6lHRun6gC1H9w1+CBDxUGWqomZuEDRGk0tsZ8uQG2yTxnrxqxPtbAmnoQojeO8VbjpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=kGS+HU7q; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so69807835e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 12:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1730840223; x=1731445023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0+h6eWp6OotT+r7lMrVR58Ao9mez6yY3tHkYyNaM+uI=;
        b=kGS+HU7qw+MvRJEn+/GGMd3v1HxzgLeW4x1YgjtSksNp7odvh+n/pmwVSOIvEaOvtH
         3ELbIWG58Zre841VCuRTuH/Db4QrwZ+Bx70vJe47Kef1K6O+F4VKpA+0mAdBmSOGYCzp
         i+zxneFBxi9swqcWrIKqKfgouvmQuzy6gKOwq6SLqWl9GaPWQW4lf6CPEBHS580r8gfW
         PUzeghOfOepLe13YumIgv/I+S+bdA9kwc1KsNkV8mmtu4vxtWxl+datn0oj/8ATvNxJ+
         Axs1Mr/i30G+Hpw6uwRlI6hSEiYkH5ceJt4uMd2+i5lJefX9F9QfuwhFNdaOJ3hlwqQL
         T50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730840223; x=1731445023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0+h6eWp6OotT+r7lMrVR58Ao9mez6yY3tHkYyNaM+uI=;
        b=Xl/83QjIxX7Df17tUxooZvaPNEky4jMX9pzVfdyQZ/bqMqvvoQBxebGCFAhRVSg+qq
         f+sRQHumrzvXyJkz5vXYLsHiH3nvfW8j7XqHoik7IzbJWAujNwcJhYxepyNuThBu75Sg
         p/lGhQxD0Vs14s7/skbdOnUm0pKNCa2h9GjBem1CSOKfUViU1IH/P+9w966yOUoFE6Dp
         w903WR3ojNgdRmCSHB+/tinEe9l9c3Xe+PWwj2m732cQaEiNtvHhSbHrjPJjGZ5tUOfs
         rNGjp2t4c9R4EPZ3WGCb4GhuAxzx2hczYxH53JsWCW7hoNfKCPzTE01HmUiigN0pdxQI
         3wdg==
X-Gm-Message-State: AOJu0YwGpHNFCZPjcTheVKeoB25nO8542/5SRhPs1nOh0fG2WTCcXVHD
	qFewjIhHQhYTq049AlhXKhDamCn+my2SmpmdR7978OIx3p/SfkIeN90YMz3S208=
X-Google-Smtp-Source: AGHT+IGNTAprke7q8Kfcfh9acW3N/v/EM6pvpYUITgjv4XtEuXLbxeOduBoisgqfinsCnkoh7AX2rg==
X-Received: by 2002:a05:600c:22d3:b0:431:b264:bad9 with SMTP id 5b1f17b1804b1-432849fa045mr187587885e9.14.1730840222846;
        Tue, 05 Nov 2024 12:57:02 -0800 (PST)
Received: from matt-Precision-5490.. ([2a09:bac1:2880:f0::179:1ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10e61f9sm17171301f8f.58.2024.11.05.12.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 12:57:02 -0800 (PST)
From: Matt Fleming <matt@readmodwrite.com>
To: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>
Cc: linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>,
	linux-kbuild@vger.kernel.org
Subject: [PATCH v2] kbuild: deb-pkg: Don't fail if modules.order is missing
Date: Tue,  5 Nov 2024 20:56:58 +0000
Message-Id: <20241105205658.349180-1-matt@readmodwrite.com>
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


