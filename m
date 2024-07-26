Return-Path: <linux-kernel+bounces-263127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F2593D15A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 12:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FD53281E00
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C6217836A;
	Fri, 26 Jul 2024 10:50:10 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DF87F8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 10:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721991009; cv=none; b=g3pKqUBoavr2OvYQBBE76bTO5/+SNszjcruax+5X7JAKpRcpPe4TQM6ihGzcSS8hGttvp68OTriGer2YjeSAN8Tj6Ln9MWM15OApjWbI8CCv1qojBH46vSowxdUlRrfI7yo0XWqnXQtxTR6h+aa8zi+48vZ6l4F9Pz0w8VeilO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721991009; c=relaxed/simple;
	bh=hmUvLOCjxWHlgQdM0TgHUG/r5tnI2pMKD7HZtMLInk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RRT6ZNiQ19er9tkpantoAQRu1vSVr3ahH/gLwk3ljgrZwfYOfJQTSsgi2JbUaBmk9BPrWqqCnWuTWGkvFJCE1zit6ClfpzaIVvsUtkVY+tr1sHxSMS3MGpJJrMajLzaUeMLNEwC+Kt7Y3GdFXryJ9K+G1FCK/TzcFN9LTX6jym8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7a9a7af0d0so195712666b.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 03:50:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721991006; x=1722595806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5/TaFwgH7oBT4VeR5Uyq0sXwbZTRatSQuEyidwWom8Y=;
        b=eLnOMEEXi5iJlBu4wkfvWjVc+78VO7zbXJO6wfrpgO7QShmfp+toa4in5nUVMLRwtw
         qxI1bwnDZDlRD4TUYUsKoArwbOBR1EpeAwQ6Nx5D0P5Aw5JLLJqvTUwHvEyLTLkK3/zA
         eKwyr3YPC3ur8+lJdWmP07+Emlr10HMe/hkesY8dnx6Kq8Q/88jM1k7U3TCQVGTOSNhe
         RgjtpWSYVDquCDoLaNEjh8o2g6tsZM/mBsGr5WYRO/6KEqB0C4RLeRskxeBzxWv3J/R/
         3GRPzRa92PpolSqCv7qzW1NDhWuFWhVJwV5eH8CsTXw0RUMNrYG1WUliRAz8yMhlYgu1
         O3Ig==
X-Forwarded-Encrypted: i=1; AJvYcCVmqXXvycbwT3tahWlMHe0Q2x5WBSdKyV+8VAQ9M+f/dIUK9eyitEqnNWRP81KjNsYyTBQR8XTOb7e/wEIHHChgnrrq50Skeqokjpwt
X-Gm-Message-State: AOJu0YydIQXHsdzqf67a1caWzLonAY2v8OT3OFIMBrEZtvc9x0LacP51
	+Xmp0dch9+aYxbZnBEl4JoiYg2LG/2k/mor/DiPovDuO/+B36afb
X-Google-Smtp-Source: AGHT+IGGZQsobC5No9JHzguxU8M6fDoVGjyqPHIH5upkHCDst80ydY6wFLaHPHliag+3w9/Ntv6KZg==
X-Received: by 2002:a17:907:3da0:b0:a7a:bad3:e5b9 with SMTP id a640c23a62f3a-a7acb3d65dfmr357156166b.11.1721991005671;
        Fri, 26 Jul 2024 03:50:05 -0700 (PDT)
Received: from localhost (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad4148fsm161257666b.121.2024.07.26.03.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 03:50:05 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: akinobu.mita@gmail.com,
	akpm@linux-foundation.org
Cc: leit@meta.com,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] fault-injection: Enhance failcmd to exit on non-hex address input
Date: Fri, 26 Jul 2024 03:48:45 -0700
Message-ID: <20240726104848.2756962-1-leitao@debian.org>
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
 tools/testing/fault-injection/failcmd.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 mode change 100644 => 100755 tools/testing/fault-injection/failcmd.sh

diff --git a/tools/testing/fault-injection/failcmd.sh b/tools/testing/fault-injection/failcmd.sh
old mode 100644
new mode 100755
index 78dac34264be..234d49fc49d9
--- a/tools/testing/fault-injection/failcmd.sh
+++ b/tools/testing/fault-injection/failcmd.sh
@@ -64,6 +64,14 @@ ENVIRONMENT
 EOF
 }
 
+exit_if_not_hex() {
+    local value="$1"
+    if ! [[ $value =~ ^0x[0-9a-fA-F]+$ ]]; then
+        echo "Error: The provided value '$value' is not a valid hexadecimal number."
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


