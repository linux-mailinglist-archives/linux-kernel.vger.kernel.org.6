Return-Path: <linux-kernel+bounces-570218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E76AEA6ADF1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBC744A11CB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AEE229B3D;
	Thu, 20 Mar 2025 18:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dN6byAd3"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BFC22FE02
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496816; cv=none; b=LvVY6sWd0iupUTBnsgP/adK1lhkPh1aMBSZs7MQdIwSvZ+U85CAO1uPMnypGOaGvhoiA8cwIjeLVqU999LSMNiNwPGeAG2y+bFIX33nEjGk5nhxSH+/Wg7nXAinAxy7ZrzmTNa0LwIHq0kYaupzWKrJMULZMbusPMhVNrxcbh24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496816; c=relaxed/simple;
	bh=7spOpURb5o7FkCgSn5q4NtBqN1dQS/vR/iSS3MjQXiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FWmkhsYURiAxCrk/ik8NDONIMVD2YNc1+brtfESzDXRxNpsOmtFnXuH8lpQqa6taE5D3BbS34aefa1e/jfT7LQsmxq+TmC2Ayeh7po/FVJwwD2GzDBVmQBr2/kiksVxw9c15bYlcUy4oHDLi5fZ7nZf8+REK4sd83mUgnODAFoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dN6byAd3; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-85dac9729c3so88972539f.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496814; x=1743101614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=noT9vSRMS6zrMZV/pKEC2dkjvVvkFYCSSlOoHQZH1zE=;
        b=dN6byAd3fpvG2+u3BCXcCVKetCUAxP+soKuXGBD2e9TFDQyL07S/jTi8bpvuheKQMB
         xsbkYPmJLIBqMk/oRvJRpkmcI7bGzwJps2zRB0Bufe6TDM/CLdgotw4QPTOBPsJIYxwU
         9a1Ns28PZ+gf+EOcUjN/OkaqMP6ubQoWdYJAKAQDBWEi1+IWyHcqfAR/r4V3D2n3VatG
         J/RPPhP5BIzgjMcdoge3LEC0d7Pn2bC2GIAGimJpX+9qLRcXryXQUUEuMjRkDYw+O9Hz
         cBFRHOMYzANSuTrJ0bMG/lPJU7yiyM+a/D01+hpkaVm7vhb0xdEt1QTAe2aPIrPsq0L8
         fxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496814; x=1743101614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=noT9vSRMS6zrMZV/pKEC2dkjvVvkFYCSSlOoHQZH1zE=;
        b=YxMBYXF7rF4CQLqVAimQKLLP9b/iD9Lmpuptz5/OAskXDVC8gCbxCO7H8Rm+exxZBZ
         EINqehG1Z7Gpc7leOqAgFNmfraMm8rS+lKptjA0HDNcCY8xtBvknIvPm03afeZMs4uWa
         jffowmVajjskZYe0kmD77CKLhUMcxP1I5rhsDpm5fun9GhkNUlc212f+EAlMX2NqaikF
         ay8tof6V5nldvZ0hzHonMK09ZcPhX6Jl/6fCxGKoEbumNd+qugU2mvh4iOogGRQEj0t/
         3sdIXPwlb9XsdIJ8iKkQqC+1zqrIrfChBPFMuJRUqZLEiTdB3B9YKXQCF8stsk0niGZs
         MTUQ==
X-Gm-Message-State: AOJu0YzNG9No+7z+DE3Pwy5IE/zh0X5U0CWk08RvWAQttHvOAl3wHOoJ
	6bGkQP0u9wn9Tq4jpBXdOJME728c1m23z3MxiSd5kaQzHMNnVk6p1/DzE3P9
X-Gm-Gg: ASbGnctJAj3LS8TJSo8MiBbapn0wtrRPZqpFIehX+qdIpCkvwiN8u8PEOrPX22kFyJQ
	28u+BLk7LX+QQ9zozUhKuGllaUoc8HGfL0heRxHnIKfzIQqIHfSZ49ysudsURY9TenZyVUeynZe
	cRwu78JReoHvuuxtIU71gEMeu4F/nl9fDelZLY85qim//mev+aRFHAB5etqXw2L7oC11DlQAFPT
	zqD4M3xaBwYL0e2TYKdH7P/zBZb0U3XBSzpTORNvXVQXUjylr1/+zP3g0OILi9+Cn7G9ll0XI+/
	UJTSxmAJAG6oek8k4XRr7W4XU+iozt+Z703Zp5RUCVlO4YASlqLb/kK4MM0ebN7ate3Gr4X/+DD
	mWxQpC06gspaK
X-Google-Smtp-Source: AGHT+IE7BXJOLQ/Ch2HIew0cYtasFTxiOy98Pt2Smp2K+0XTe4H0Bm49hhGoWTZCYRcS5D1a7aVvHw==
X-Received: by 2002:a05:6602:399a:b0:85b:43a3:66b2 with SMTP id ca18e2360f4ac-85e2ca808ffmr55825739f.7.1742496814018;
        Thu, 20 Mar 2025 11:53:34 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:33 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-gfx-trybot@lists.freedesktop.org
Cc: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 27/59] selftests-dyndbg: test_percent_splitting
Date: Thu, 20 Mar 2025 12:52:05 -0600
Message-ID: <20250320185238.447458-28-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320185238.447458-1-jim.cromie@gmail.com>
References: <20250320185238.447458-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This does basic testing of classmaps using '%' separated
multi-queries.  It modprobes test_dynamic_debug with several classes
enabled, and counts to verify that the expected sites show the
enablement in the control file.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../dynamic_debug/dyndbg_selftest.sh          | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index 368d10a691a0..c97c9391d0f4 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -256,9 +256,29 @@ function comma_terminator_tests {
     ddcmd =_
 }
 
+function test_percent_splitting {
+    echo -e "${GREEN}# TEST_PERCENT_SPLITTING - multi-command splitting on % ${NC}"
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+    ddcmd =_
+    modprobe test_dynamic_debug dyndbg=class,D2_CORE,+pf%class,D2_KMS,+pt%class,D2_ATOMIC,+pm
+    check_match_ct =pf 1
+    check_match_ct =pt 1
+    check_match_ct =pm 1
+    check_match_ct test_dynamic_debug 23 -r
+    # add flags to those callsites
+    ddcmd class,D2_CORE,+mf%class,D2_KMS,+lt%class,D2_ATOMIC,+ml
+    check_match_ct =pmf 1
+    check_match_ct =plt 1
+    check_match_ct =pml 1
+    check_match_ct test_dynamic_debug 23 -r
+    ifrmmod test_dynamic_debug
+}
+
 tests_list=(
     basic_tests
     comma_terminator_tests
+    test_percent_splitting
 )
 
 # Run tests
-- 
2.49.0


