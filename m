Return-Path: <linux-kernel+bounces-254267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DE4933132
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 634EC1F21C85
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787031A072A;
	Tue, 16 Jul 2024 18:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XcP65Jr+"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6731A0714;
	Tue, 16 Jul 2024 18:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156323; cv=none; b=KzHORB+7Ycx0VSY0bUXVvV6H+sYkD2nxfe5SFt+t8a4st2uIU6AveK+4E1NeXmZOI/aErGDcHtpFCG6nJXtAY8zyfmP+CKB1dOx0zu/grvmeIwJkWPrCeNL8ncbI8PMeSyfzFptAHyD3u2Ni0oTx2bp5zaNjCmMLvrV6f4v3P8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156323; c=relaxed/simple;
	bh=iJRabDk4n3FOVpiDfU5H29ecoGu4HIZhqD6br1cK+Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZxooWMkdWvpUiXVvFL/9jM4yhrYWdamGjwp1fs6xldGDam8RP+QZJESKmBogCBFxjeALou3mh0sPYYyaVZpRpmvQUQw4GzPK3WvUrbl3zgEc7dNMwPhU1Qgo4VU2gWwpFY4222UqEhvjzNJClwhIXL0BkX9HuZvVhbpp5AKBMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XcP65Jr+; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7fd3dbc01deso6015739f.0;
        Tue, 16 Jul 2024 11:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156321; x=1721761121; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PG0HixeKNGYC1yKqg8pO4K0aUEEvqiNOUzi5OjavD2Q=;
        b=XcP65Jr+QJctdXvLEHQQTdbBVFf6pGFMEM5XKuHRbrHYO8Effh7IWTQ+XA6NgPsOMC
         +1s7W5zogx7FVkgWi4jlmMbZxdTtmjIPJ10SmVXWihVJBXoV/bOE3gZ85STh1kADlZuQ
         Y+39hK+NbXkNzzLHlTgCTmEoNu0Nc1uI9mhkJWvZqedW8iBCdy2cCKO0E3zLvSArxmsL
         N/mWoNXEIO4n+JE74i2VBaNIa25mTtsfI9BXqQVdafULzikKLDqXSbRFH6gmGTibwKo/
         pAqk8A5b7r3HvDLkr6SfN181y6p5H5oQ3sbZAAVV/0o6nzYmCppa/3w1WnIASmgMkz6x
         L4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156321; x=1721761121;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PG0HixeKNGYC1yKqg8pO4K0aUEEvqiNOUzi5OjavD2Q=;
        b=edIO5VaJV3F68lDT6ik54TedVdEVDq8D4xVNVt7eELta6mq3YQ8Nt25MpDGw3zDJV8
         JDEZWh3/rGZR7jIonyvJSZFKrT8XcYMMX85Uf7mwSINWFQ9BOM0N0YRJ13dt5x2/gv8T
         lyanYSExyB2c+hEKANiKuvCMYXFwd1x/jYpG5jrvnF5toovqE6lru3lOh7u/9bvnJ0VU
         yjZGrYkxuDzqwfQs/Z5g/HLe3ZHjt5MFl+8VpIm4yH6AcxbeUtlvQyQIid7EOlR54DT+
         lTtZ5bq7UYyYrlrnRCp/vJUoxbNQvo/Kyv8dmc6xLpH51puMHf/6nIyvihGsmOHtdsXh
         1t0A==
X-Forwarded-Encrypted: i=1; AJvYcCUuIT0IzOygDmZ6OpdSYH9TaK9uG7uwk0rWJ1xQbZ/6WWtl8G46ahXfPafw2R7JTAanYbsnJiRBfNFvIJOVvMDZXtYMrzInGm/y
X-Gm-Message-State: AOJu0YyMJEvJjDdMSgsXtpGXvPgyPGG2wjiLQrgRKDORq/ZXBE76UZru
	Bq76slurCXwQUL7pg9HgSd4/9cgfZfBMMAYIaflZHRTQuB8gmGo4IK1lzy1D
X-Google-Smtp-Source: AGHT+IGTZjuSx59fvBLEZu4nUn6dn9Q2x+1nuEiSc6h7Vo8FFTzb5CNqZWvEdUtshl/goBTMCnhqjA==
X-Received: by 2002:a05:6602:6426:b0:7f9:40a0:dfbd with SMTP id ca18e2360f4ac-816c51c8095mr42802139f.13.1721156321173;
        Tue, 16 Jul 2024 11:58:41 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:58:40 -0700 (PDT)
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
Subject: [PATCH v9-resend 13/54] dyndbg: reduce verbose=3 messages in ddebug_add_module
Date: Tue, 16 Jul 2024 12:57:25 -0600
Message-ID: <20240716185806.1572048-14-jim.cromie@gmail.com>
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

When modprobing a module, dyndbg currently logs/says "add-module", and
then "skipping" if the module has no prdbgs.  Instead just check 1st
and return quietly.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index d4a0ae31d059..43a8e04b8599 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1245,11 +1245,10 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 {
 	struct ddebug_table *dt;
 
-	v3pr_info("add-module: %s.%d sites\n", modname, di->num_descs);
-	if (!di->num_descs) {
-		v3pr_info(" skip %s\n", modname);
+	if (!di->num_descs)
 		return 0;
-	}
+
+	v3pr_info("add-module: %s %d sites\n", modname, di->num_descs);
 
 	dt = kzalloc(sizeof(*dt), GFP_KERNEL);
 	if (dt == NULL) {
-- 
2.45.2


