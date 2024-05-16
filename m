Return-Path: <linux-kernel+bounces-181392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C82F8C7B85
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 720391C21C4E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7845B15884E;
	Thu, 16 May 2024 17:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJtJ/iFY"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F07158201
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881462; cv=none; b=VDJInATOiGewG+OXXjkLt2hCygR8cp2AK+lnEARibgIVFla368viYqQ2T4VUoJXWJXrHsxxbXlXV9xuzfQlUk+XDSTTaA0aFmZTeK0jE8z7sLzoP852xvJe9AZrI+1bylxWtdxbjzFBHmGlNls+FrbCbpktjZ4T3Y5WVdTTzDmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881462; c=relaxed/simple;
	bh=9XiOjohp1hYJYfm2iFjvfUXyGkHh7anpuGPbKPE4nT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l/PVLg6VOCEVHCICnu+KbhgW+U8AGhpuAb18Rqw87Sgot9dE3vz2ffn1/SSt3lIfovYABlEZcPY79zE1QkygPfXv6JsMQxdSRM+9PDrS7j9JI/4ZwwPU5BazvwQM/Agqeh/Pz6Mp7oBVPZILRFrfF2NjJpcjxpDNLC6Fy7N6XsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJtJ/iFY; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7e1e06c9a10so67174339f.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715881460; x=1716486260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrAtiNlsGgy2mJ/VgmedHbqkrfkDf3H48YRHd61EFag=;
        b=HJtJ/iFYqAXIBGWex8NOCqZAM5Nkv9BSAcn+kqGVRDJBgd4wKvUQecmOaF+Da/6OJj
         vmfoofYyahFFupzihDKp0oGAcStoabncIZoaCl8DTob/RaS0pdnGjqCntREq1OmZ6wvL
         HKbiDsOjJihYMyjH8G5V34tln9kzGbtORqLgeIlYCcdIBCejbqiI94514kkpqiU6BA1+
         imcex4EueTjvPIThnIb4c0qKFpI6SIlda4wEa7vezetzO+c2LU0O1dJCmUO/Fq3kMwHI
         z8L0ChKfd9g7KgVTN6sj7xgnYKGn2yJYWEKLzM/sAvCdr9TSM9vnWgiPtaIgVAZTgxub
         PnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715881460; x=1716486260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qrAtiNlsGgy2mJ/VgmedHbqkrfkDf3H48YRHd61EFag=;
        b=gzMdb5u5DmxndFsowR0CZuxbDYiwtnY2+bfzyh6F4eHpgvwvPySQQL+ndBf6k060Q9
         Mn5eL5CbhG3hW2brBVogJK7vm7/+79LvMUmAQdXBvnxFRz95pEoZ3CfxHRWL1hJMp8k/
         gQJrpj8h9b6m1fc/azC81LWpcK/vAyCPYbjBhcYOHWWAse259EYSRT6r1hWxF3ZyEhrv
         PaPAiku3jjWF0rN8Tt9t8S+omad2VOFNCfHv38MmwUcHEb0AR/MLiblItR+D3gCp4hY5
         +8Jk3nI84gWE/MNY0hturlQQ/mNGHXw/6RJwkOmnoilP6nJtaVsJUw+tlJdmisZLwZqi
         FM9A==
X-Forwarded-Encrypted: i=1; AJvYcCUeOMzyAwcn6huiBQnKec2FcDPHDyDwkiEE5B9vyDwVBw0+6bK4uCuJS62l49NaEG1zffT/y2Je2AbSa+qlcUo1TScyBj4JGyEWdDeC
X-Gm-Message-State: AOJu0Yxg96+nowgtSO0wyLX8rtsz8bUm+6X+yCXTh51PeaXIhRvQfzdf
	Z3NogIgjma6GRkGTF4BJvqH/eMuuCjfAWW7Qn6bKzloOo38AxfjA
X-Google-Smtp-Source: AGHT+IFMd1pg5rsL5/HOW38BU5NB/dLpvbMDich2MsVqx7QRoTD72I08NOTev2lFylCy2uQZMmwNZQ==
X-Received: by 2002:a6b:6a19:0:b0:7de:cb15:1b17 with SMTP id ca18e2360f4ac-7e1b51cdac0mr2038560639f.9.1715881460566;
        Thu, 16 May 2024 10:44:20 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4893715057csm4273595173.80.2024.05.16.10.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:44:20 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Cc: ukaszb@chromium.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8-RESEND 10/33] dyndbg: silence debugs with no-change updates
Date: Thu, 16 May 2024 11:43:34 -0600
Message-ID: <20240516174357.26755-11-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240516174357.26755-1-jim.cromie@gmail.com>
References: <20240516174357.26755-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ddebug_apply_class_bitmap(), check for actual changes to the bits
before announcing them, to declutter logs.

no functional change.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 368381dbd266..8320cadeb251 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -595,7 +595,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 	return nfound;
 }
 
-/* apply a new bitmap to the sys-knob's current bit-state */
+/* apply a new class-param setting */
 static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 				     unsigned long *new_bits, unsigned long *old_bits,
 				     const char *query_modname)
@@ -606,8 +606,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 	int matches = 0;
 	int bi, ct;
 
-	v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits, *old_bits,
-		  query_modname ?: "");
+	if (*new_bits != *old_bits)
+		v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
+			  *old_bits, query_modname ?: "'*'");
 
 	for (bi = 0; bi < map->length; bi++) {
 		if (test_bit(bi, new_bits) == test_bit(bi, old_bits))
@@ -622,8 +623,9 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 		v2pr_info("bit_%d: %d matches on class: %s -> 0x%lx\n", bi,
 			  ct, map->class_names[bi], *new_bits);
 	}
-	v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits, *old_bits,
-		  query_modname ?: "");
+	if (*new_bits != *old_bits)
+		v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
+			  *old_bits, query_modname ?: "'*'");
 
 	return matches;
 }
-- 
2.45.0


