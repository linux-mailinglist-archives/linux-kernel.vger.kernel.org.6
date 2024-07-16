Return-Path: <linux-kernel+bounces-254276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F28933161
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DE1D1C20CA0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47311A7088;
	Tue, 16 Jul 2024 18:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ep1/mZdm"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7340E1A6524;
	Tue, 16 Jul 2024 18:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156336; cv=none; b=HtCWaLKQHX4Gq2svXoshk5Wl9WaJC6kHczIQ8QncAPJcGy+VVRwsTCa2K9vUoOQxvpAntXdojDqcOzMEpQvFu1ytcGdMzWoYBRFmP+5unp8lsx10S24gBBQWKs/9n3V4SP0oYJZSv7NC9iPxzIQuZ9ETQo7gOPPGGpRCxzQ6+Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156336; c=relaxed/simple;
	bh=XNa+7BsfG3j+8ZebdUR1b6sN3/Wty2dm0XB0JSgVOIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ruX5WdNmmt86tcEmy4cgNaBttljxFZEQcmZJwb5HEWBny6vMFTojnhRK3w1JrMYJGk8JmRY2XGuUnsDQGXWNE4QnnYCaL4MmX5L0upYvSj0QMcWCgNK1GaUytkin+ZFLiBdldpDdNQ6GDVloPO2JbtqU9/fFSYuXYwtEvbitek4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ep1/mZdm; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7f97e794f34so4334639f.3;
        Tue, 16 Jul 2024 11:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156333; x=1721761133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFcSRVkNrMoAaN9TOyRvWGwNcmbCrlZN4vnmf8E27Go=;
        b=ep1/mZdmc4oUCyQnztYm6hnSlxldv/WfNzPSM6XOE/REdeBG5CErMN22xHQqHflj4n
         okErHgJczoyrNZHGKZys0ZY1yShipDbi3wwRvA3gHsCdAAnfKhtk0mspKVbw1JvoxzPI
         Z+ThW5TzKnYN4HuZf+BQM4UQanCH0cl3u231O0ct/tnJNBePKOMN+TM0Tus86L/DRLp3
         r1l14tWywu0J8Vg6K9QC+YGH684Uq7LVeiAT52gkZ+ihL+CTOUzOuvhZeBub7I2pC/o9
         EQGWN18WrRhKjpsjhVJG2fWSqw1ZKh3f6C1EhuJ7ZCP6LZWCDZljpMugcHbtyuH1oSfm
         GY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156333; x=1721761133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aFcSRVkNrMoAaN9TOyRvWGwNcmbCrlZN4vnmf8E27Go=;
        b=dUVW71nfkr73EbqtFcZi2/oBbthFcvNDNfoISTNjRBd/qEloSMROQs6qpgCYKFRPKz
         2uQRNFBTCJLEpZybv/47gizBh9cm7XuiSxxVp6nTgcAEjEC2lG4s6M8wM7x7fMGw8koS
         pQVd0CHESdrge8JCzioRterI6jhqGpXuoSKFAVAQSPxoWs60i3C0+gM9FLOpkyqDB/g3
         ELGm3DjUTBWVsIPtBncVmifn3tmeVYLA5oy8ehhFvHcVTqipmAkMzowBn8naVpMZiL8m
         DPxvxa9sUsyvqsphRTm8G/8jemntQBa32UN6Sren71lZSE2ESrXpm6JZch36n9XyqcG/
         tFtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhZDgi4ybP9RlJCOnOGHADjtkOzJ2qH/SUbhrkTXk7aXRo4JZBVEHzDMYoQH1RGYi5RE+pPu0lYZWYmk3na3vFmN6OzbpeJnMo
X-Gm-Message-State: AOJu0Yxw/679XNnPEz1QxvmDbgaG6XdXDzP/yBISVZWj9bnjqieOj/CA
	yxhZRqMDE28mHiUx1UXyE+Vgty48tvkQQguUcwhHdydcGpM3G4Ag8uRYEYz/
X-Google-Smtp-Source: AGHT+IFg9obh5N7uqV0H0s+HstduYRg6QMF6jZMCgR24AZccd/1wfKc7SoX9qV+9pLjIo/o6Xjceyg==
X-Received: by 2002:a05:6602:2cc2:b0:7fc:89ed:c15d with SMTP id ca18e2360f4ac-816c4a1693emr26868439f.13.1721156333211;
        Tue, 16 Jul 2024 11:58:53 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:58:52 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com
Cc: ukaszb@chromium.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	linux-doc@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	kernelnewbies@kernelnewbies.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v9-resend 22/54] selftests-dyndbg: test_percent_splitting
Date: Tue, 16 Jul 2024 12:57:34 -0600
Message-ID: <20240716185806.1572048-23-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716185806.1572048-1-jim.cromie@gmail.com>
References: <20240716185806.1572048-1-jim.cromie@gmail.com>
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
 .../dynamic_debug/dyndbg_selftest.sh          | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index b4ba293ab227..996e6fdcfb52 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -226,9 +226,30 @@ function comma_terminator_tests {
     ddcmd =_
 }
 
+    
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
2.45.2


