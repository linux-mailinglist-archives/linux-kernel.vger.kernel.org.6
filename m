Return-Path: <linux-kernel+bounces-238443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E90924B0F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EC611C2182F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148C518B446;
	Tue,  2 Jul 2024 21:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxaZOwHe"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC46189806
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957524; cv=none; b=Xrf3g+WNo8cDggOU5olUng4tX8GKkXArlmUWlI/0kPfxHOxopgwaJ59ffVjTg3h/aeSUBWXgbnzhNXG2d91Fq7CwINpJir8E/XQKGHBwN1upDJcDdRVssrlzhFiGd6Us3RTILFk6fG1upy9cqFxF2flJzjUgOq9JPTzM6q45+u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957524; c=relaxed/simple;
	bh=XNa+7BsfG3j+8ZebdUR1b6sN3/Wty2dm0XB0JSgVOIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nv6ooQPiv5g+qBbHlXCJz5Jwo7nSogZ9HqPulJUdu3H71d23OgPMhMDSqFMptbLtJD56iHQtZAHwZAQJLtXaibdJWFYxkRxZFpEfOZhdOMFvQ3y2GKH0PBcopAXWYP48NU7aHPMcsof2E2P+xq5huIRs/ns4M8xSS26IxZp5vzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxaZOwHe; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7f3d3919a4aso177936139f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957522; x=1720562322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFcSRVkNrMoAaN9TOyRvWGwNcmbCrlZN4vnmf8E27Go=;
        b=IxaZOwHe7eGUU8+9PyKEyvznMnudWGfnt5kVj0ZDXWdNTWCJ46HBSnnncbapMISEJF
         jVolwXW1/AgVSpcz4nIb4B+lo2pTovJWvgWxWpMZT6QwsDXerLKueKakNfJ7M18eDBmo
         qkAJUNqOwWu82dg+ISrWrnQuGQg248zzFHzChNNXODI2WDhMyTgn2IrJofap1UPn9E7r
         1hVvo0n5Wz9RzCkAz58ij///H/XHJeCKxTPGc9gR62eWF6qyiKGdkODt4GV8ceIz4q/H
         DTPx1mrA1Fi1SGX/gS+dbPuW2f+vJmdaOSwgPQFn3O4Hr8yms/M/6aNtO4fZMBXKTGcP
         Meag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957522; x=1720562322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aFcSRVkNrMoAaN9TOyRvWGwNcmbCrlZN4vnmf8E27Go=;
        b=RrS0+rRKzl8qO+7zGnPV4qxmf8vS23Bm1EA0gKZ0nF5NOY/HXqRF0R3nli6O4opTFK
         cor2+DY6iqrrZEijO2Fqnm/93M6v7A28C6myEFQsjpSDOugS6VFBLHfCE+dNkJGeNKE0
         kdm0mB3orv5DUwaisT+5vdE6UTsKcR9fBWKbtr+dhiEEpVOX65YGPWUKbbTiqy+XDBfD
         h3MQD6G3dzHtAXenHKuJdEemabq0fsbFaiiK/+BYeCGAhYh/0u3WH1fBPQCknrSvobe1
         7j1v8p/uYUeEsw0TOgWk2BsbxZeyni2jcN+bKClSNEmnzt+8vblnNdED40QCOfWNlO+u
         noQA==
X-Gm-Message-State: AOJu0Yw5SIDXduC/vOsWws68TwORQlbN4ubidI+3ao27KPwVDt0fNpih
	fHx+S8nfIhAokxVVzgnnyO4vxmC9dZxceHVlYyAaIAzlyP7+6X/0
X-Google-Smtp-Source: AGHT+IF5HPTrp3Ibm1axLqWBCHtlXKaMWg0JUdhWqqnYWUpVoXtgbCh5izMMhwYMrBWm7qH5p9dPSw==
X-Received: by 2002:a05:6602:da:b0:7f6:1542:4e94 with SMTP id ca18e2360f4ac-7f62ee9d603mr1046263839f.20.1719957522025;
        Tue, 02 Jul 2024 14:58:42 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:58:41 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v9 22/52] selftests-dyndbg: test_percent_splitting
Date: Tue,  2 Jul 2024 15:57:12 -0600
Message-ID: <20240702215804.2201271-23-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702215804.2201271-1-jim.cromie@gmail.com>
References: <20240702215804.2201271-1-jim.cromie@gmail.com>
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


