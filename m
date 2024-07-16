Return-Path: <linux-kernel+bounces-254256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AB79330D6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 20:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CC671C22C49
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3691A0731;
	Tue, 16 Jul 2024 18:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSPkyWXL"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADB91A00C2;
	Tue, 16 Jul 2024 18:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156304; cv=none; b=q/+56ZQflxcdMIobcAkrCGCg2xWAsA4doEDtz1EZ/VSwWgd3cvJzg0ZKPY3JDw8IzxvOl7EWRJqCT26FDKIgI2o6bNn5UmYzSwWCTAnLkY8hK9qSkULKY5nrp7iwXYzKqKF0kJMWxw6ttSLPidvsXw/N6PY1DqlVJTgQQjAPJUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156304; c=relaxed/simple;
	bh=jMFJSvW8rwGwA9QU3Al6zitYRBQUQs9qdqLxCiJYGlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+nM7KGTo5hr5qoVFSQ5MlTnoGgyDRsyZb+aKrR2A2+GJ0he1ureVNPzq55MDbFARZV51nWkOkIIBAtDmsrZbGdMv48IDrmYaFt/B56eu9iSPckTAFA6Oq77XIetx5PW2PkjQFPnuqntsDNHsurbM0VLdMzGoiWaFXJbVdEG9Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSPkyWXL; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-816b627a7b6so5609939f.0;
        Tue, 16 Jul 2024 11:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156301; x=1721761101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0jicnEuSikysNdrvNl4Iye9B1q1hn5wCOtgRQWjJh+Y=;
        b=cSPkyWXLLctUWEBC3p64Gnz6QSDKpPDc+SuxpMev8XySZ6PcFOMtyYTUFmp7EoRZaJ
         TdciZI6iF8bOmyDytUbP1ULZemskMGFcEHsOzQE094zjjwDSdoEgDxqvisvkcGSZ7f7g
         D2zjjShUXczr/eSuvnqaE/3Vah65dUlgVd+vdngq8S32LV98+L/vzWris2cQBct+AqwY
         pkeiuYb0srGNlNJXFFCnv3iJoM+v9chIigLlgBBV2cvNbt7y7n0KUwHnstbGzLWOkB6E
         xhfVZEhygEfWpQJQr1yWuK6IRbmJc5pASHNDjl1BPsXKvpcGlRYbqozs6SPSKogaqVzr
         fMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156301; x=1721761101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0jicnEuSikysNdrvNl4Iye9B1q1hn5wCOtgRQWjJh+Y=;
        b=cqgEd4EBMJ/9S3G5z15fImb6JB3haI+ZW4JL5GAS82sp7IRlDoXutBo/93GGoeMpzy
         MWQ5ylDQdcBFH7KW6p3pdTxQ1PI0dEiskqQfdbZLUQI/9mhdIU/31eQXMDxMfHIUq5a9
         da45HTOft1BtLveSaZwoX4zYC2z6CGq5Ix+VYwqulZA50sOwc2QCyt6Ueo34HH9bOiCw
         Cdmgz+AnuaAIltIA/JCBx+j5Gf+h7/D2DygAzibEbLdnfbI3yQp/Pg5bDUgGvgTviEy1
         RH5y3hkG3FPfXUOuZO3/Jf/Ih+TrXRLAH6tTaeIalqW4WL8PdXtxGda4oGDRaGXfkVz9
         OKcw==
X-Forwarded-Encrypted: i=1; AJvYcCWn0t1mAvkmtSMBXxDFYWTDwQ/iLnoEEJ9Ym4pY+87h0rrZb87jCJl3LbdUybd9Exh4s6K9J+ce9abcu9SGX0QFPw+JdmzybeK3
X-Gm-Message-State: AOJu0YyDeYrDrjcwO6iZ367Ko4rxr133bzRK+mRMSO7PhNtpftyaOwHz
	khN1r/+2koMnwlaVIakkaZ6GeeINIcZOp+ETdhy0FeWSRlm7yQU7wdCFdrBz
X-Google-Smtp-Source: AGHT+IH/6GmZg205UsWXcwtXp+7UYuUNvdEOD8tXVXy+IqWVen8eLnzAm3KTq1H8aJb2I+6ZPRtN3Q==
X-Received: by 2002:a05:6602:15d5:b0:7fa:a253:a1cc with SMTP id ca18e2360f4ac-816c3f7c4c7mr42921939f.3.1721156301543;
        Tue, 16 Jul 2024 11:58:21 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:58:21 -0700 (PDT)
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
Subject: [PATCH v9-resend 02/54] test-dyndbg: fixup CLASSMAP usage error
Date: Tue, 16 Jul 2024 12:57:14 -0600
Message-ID: <20240716185806.1572048-3-jim.cromie@gmail.com>
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

A more careful reading of logging output from test_dynamic_debug.ko
reveals:

lib/test_dynamic_debug.c:103 [test_dynamic_debug]do_cats =pmf "doing categories\n"
lib/test_dynamic_debug.c:105 [test_dynamic_debug]do_cats =p "LOW msg\n" class:MID
lib/test_dynamic_debug.c:106 [test_dynamic_debug]do_cats =p "MID msg\n" class:HI
lib/test_dynamic_debug.c:107 [test_dynamic_debug]do_cats =_ "HI msg\n" class unknown, _id:13

107 says: HI is unknown, 105,106 have LOW/MID and MID/HI skew.

The enum's 1st val (explicitly initialized) was wrong; it must be
_base, not _base+1 (a DECLARE_DYNDBG_CLASSMAP param).  So the last
enumeration exceeded the range of mapped class-id's, which triggered
the "class unknown" report.  I coded in an error, intending to verify
err detection, then forgot, and missed that it was there.

So this patch fixes a bad usage of DECLARE_DYNDBG_CLASSMAP(), showing
that it is too error-prone.  As noted in test-mod comments:

 * Using the CLASSMAP api:
 * - classmaps must have corresponding enum
 * - enum symbols must match/correlate with class-name strings in the map.
 * - base must equal enum's 1st value
 * - multiple maps must set their base to share the 0-62 class_id space !!

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/test_dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 8dd250ad022b..a01f0193a419 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -75,7 +75,7 @@ DD_SYS_WRAP(disjoint_bits, p);
 DD_SYS_WRAP(disjoint_bits, T);
 
 /* symbolic input, independent bits */
-enum cat_disjoint_names { LOW = 11, MID, HI };
+enum cat_disjoint_names { LOW = 10, MID, HI };
 DECLARE_DYNDBG_CLASSMAP(map_disjoint_names, DD_CLASS_TYPE_DISJOINT_NAMES, 10,
 			"LOW", "MID", "HI");
 DD_SYS_WRAP(disjoint_names, p);
-- 
2.45.2


