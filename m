Return-Path: <linux-kernel+bounces-265366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F28B93F012
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10B73B21BE0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDD613DB99;
	Mon, 29 Jul 2024 08:45:23 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C415A13D2A9
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 08:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722242723; cv=none; b=FUDOFW9UiyGQPUhW8RXPM8oX2QWVU4ZJwYVpMxQYT3IeQAtQPdQ9lAUP79pdHxWdE7I/EhBkeUBmu3tawS53aZykTvosvumntnBuchQzOLSUQZtXzhP/xoP7eAsvJKuTtX9W9VGs29JuEAfXPk765fBXHFI9pjvRKOVP6wjB3Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722242723; c=relaxed/simple;
	bh=AHiP/+QNH5fh+ikjMrKSTqjSntg0RzkyLEi5w2In0CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cj5De1meOQO2L6/KvomUthOpOFpqvL21U1uQGu/AD1ASoBP95okR5CoYFYks2JJbVIrAWJOtbUQH//v3MIoq96AZJi9zpJSn2STw/kY7p3RqkfCIdg+Y9PokE/AWr+gD/d2pWV22ZJWnVjeEHFNWbqVuURIbb5xKaEW3wgOWjwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7a9e25008aso417977966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 01:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722242720; x=1722847520;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WZRLolYCc5eb0y9v7K/t4D2hRAhcTkQ4s2KgdfYlIYM=;
        b=PSy+/+GTWNTzzSc+kyKqC1qifS6750ruAhXH1yKGs/V+UsalVK7mNRmumnoyyoBoik
         NZC64MFYwtKYkFjVY1J4IpFrcW2JzJ50IbikIse/GWG0AeS6ZQZqe5cq7jr7Yqt25nbW
         GVksnXsmCwx9H1qpJTRp9JBzvaLsFmSEmnnjTU9wv6KS6hRrX3ikqzWikQFbGYWScEE5
         4OH+W0sZsAsfUqZh53vTJiHss0MzN7y8auRCwacv+UjN2r7yT6y5QRXKEzJf1+4HZqGw
         rls7w42PQbzgIDsp9GjMgfoOpB1IGk+kk1nKJ124AcGzLP+pPHJSxNbUenncyjpko3Y3
         vPxA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ7kQBqmLv3QprcuOEN2Ddgo6tRqgUmkunVMzrBvE5xhWzobSr1jbNwyX6V91Ear0lI135Kl/2XsJw2i/drL+Wo+zfxhsSNuY6fyNH
X-Gm-Message-State: AOJu0YyLkwpfyITj/5aS41QBkVyjCuzNgBZooGKh7OAaTCqwjI60pLc1
	nPwXwV2XgV8legpXPWzzJ8AHsieAbp16JxA7BI198HIHW/HWW0RT
X-Google-Smtp-Source: AGHT+IFrkN02wWTC3ZEtwaVDI/gj+jV61hNlM/Ccq24zeA960+qxYs5jKVilc8+S1YnEomNimjdeZQ==
X-Received: by 2002:a17:907:c50a:b0:a7a:bae8:f299 with SMTP id a640c23a62f3a-a7d40166eb1mr422963366b.51.1722242719917;
        Mon, 29 Jul 2024 01:45:19 -0700 (PDT)
Received: from localhost (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acac615c0sm477438266b.97.2024.07.29.01.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 01:45:19 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: akinobu.mita@gmail.com,
	akpm@linux-foundation.org
Cc: leit@meta.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] fault-injection: Enhance failcmd to exit on non-hex address input
Date: Mon, 29 Jul 2024 01:45:08 -0700
Message-ID: <20240729084512.3349928-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The failcmd.sh script in the fault-injection toolkit does not currently
validate whether the provided address is in hexadecimal format. This can
lead to silent failures if the address is sourced from places like
`/proc/kallsyms`, which omits the '0x' prefix, potentially causing users
to operate under incorrect assumptions.

Introduce a new function, `exit_if_not_hex`, which checks the format of
the provided address and exits with an error message if the address is
not a valid hexadecimal number.

This enhancement prevents users from running the command with
improperly formatted addresses, thus improving the robustness and
usability of the failcmd tool.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changelog:
 v2:
	* Write error message to stderr (Akinobu Mita)
	* Remove the file permission change (100755) in this patch. Going
 	  to send in a separate patch.

 tools/testing/fault-injection/failcmd.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/fault-injection/failcmd.sh b/tools/testing/fault-injection/failcmd.sh
index 78dac34264be..c4f2432750f4 100644
--- a/tools/testing/fault-injection/failcmd.sh
+++ b/tools/testing/fault-injection/failcmd.sh
@@ -64,6 +64,14 @@ ENVIRONMENT
 EOF
 }
 
+exit_if_not_hex() {
+    local value="$1"
+    if ! [[ $value =~ ^0x[0-9a-fA-F]+$ ]]; then
+        echo "Error: The provided value '$value' is not a valid hexadecimal number." >&2
+        exit 1
+    fi
+}
+
 if [ $UID != 0 ]; then
 	echo must be run as root >&2
 	exit 1
@@ -160,18 +168,22 @@ while true; do
 		shift 2
 		;;
 	--require-start)
+		exit_if_not_hex "$2"
 		echo $2 > $FAULTATTR/require-start
 		shift 2
 		;;
 	--require-end)
+		exit_if_not_hex "$2"
 		echo $2 > $FAULTATTR/require-end
 		shift 2
 		;;
 	--reject-start)
+		exit_if_not_hex "$2"
 		echo $2 > $FAULTATTR/reject-start
 		shift 2
 		;;
 	--reject-end)
+		exit_if_not_hex "$2"
 		echo $2 > $FAULTATTR/reject-end
 		shift 2
 		;;
-- 
2.43.0


