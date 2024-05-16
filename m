Return-Path: <linux-kernel+bounces-181409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8183E8C7B99
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2D121C21D2C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EB615B98E;
	Thu, 16 May 2024 17:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFNXW8jZ"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC6515B57B
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881512; cv=none; b=Kp07iUM8728WUgSr+QA2PQUBxek4L34tWbjjBdzgFR5b8W/C71M25fq3VGqkKuZsOj++iILDZSQBpLvUM6Ev1azb4uTC5qov9sUfaL8jRbgR8cXQEqJN03OhFQRDLf0k6wEPjECCBOeFrnlbOvLY70PugjjupTt+Zt8sh+FnRu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881512; c=relaxed/simple;
	bh=iEWH7zvmoluQNd3cpiL4vVd8VXHqKLc5fjTMhj4nCus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KoFwmLc2CJHsnwlud2Clm8QkBz+MtDiyD9jZKwAkPOItajxThwEaBPzzl7oU7aZhE5PHEALrDOVI+w3pTBukqh/eE2WngC6in0I5fnwgyx/xzDSKodrUME4fpZH4p3dKEFMoEZnFue/Os03MaddLSkJAdCBiC20NUJ2QOM3hmXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFNXW8jZ; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7e1e06c9a10so67254039f.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715881510; x=1716486310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYLAhiYI1/roEBWDhbogtJUk4/pmxUifIXzFJQa7vcs=;
        b=FFNXW8jZtev1UWPeOUYF2YLVRKY+ljBzqPM2uNV4rML/VqmzGYrP0iTDo2szDKMADx
         8SsMJdHkVTa7ikQBiOCNZjSLB3UBWv7A8i1Hcl3ysLH2ztOLgnRM5q5pMyqc9mgJyRjg
         kIH3BauyEQ5VjX/Rf8Zrz71OiCBT+LzFFKWHjDuOuYMDzbVQyTxs/zPZJC1RaUt0Cb7d
         /ClNiIdVj6IPLvtf5/+5o+oeM55oa4wZ1NgVsq42uttSh/RJWR3qNHcTdcxahNmUOkhJ
         On1Yj4ZGInZS5+zkCJjKsfY3hAwwAvkVyQH673H/sPbTwcBSvsKDIjH/UqUA/G2ODLdj
         siCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715881510; x=1716486310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jYLAhiYI1/roEBWDhbogtJUk4/pmxUifIXzFJQa7vcs=;
        b=mIkeQc8VOlAGgqipVe8MrRXY/d5OKBW8jQ3luwQhtMw1DiLOsM2lG7UOIJHHmrZLve
         BxFPX3J74skC581iP4lHTkVK0dCJx0quPtjEuijLO8W4RJHzzFU59DoT1xH8VpSyFMwY
         jtBpa3xojwWd93t67xH7Tz04Qcx9KICm8SOTo8ZAYGG8kixh7m6h8jp8X8LBcs2OrnTn
         4kb96Kpdqi+c6yGJIsiB/kkV27gq7mZe10/uX+rR+vE/2hTSnu15mHDBuhkiok18nJlN
         1Yy5iK96bk7LmD4ZvTv9/DfoqjLEjnNJMi92tJKINSXiXnsSXX5eHcOfJjdMhjKVdlUN
         MOUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2ZfaRfDLnZgb+zZvFCfFHkg30N9m4xntPREgWhd9K1l61mhf40b11O+Z7ev0DC7P0DhkPT1mEl14ZCtgZY9G+CEBBcvf2JncOkW31
X-Gm-Message-State: AOJu0YzA2hvvAtWZPd0giwD0L7hKqlTfhcQ7FYsZVIZEvMrO3ODE+VMp
	sjeyEb5CoznldOinSsXoXCzcQohFMTmr3bemmDLN/54VewrL/Aht
X-Google-Smtp-Source: AGHT+IGIdTPbyslC01Cdbd1cvSyv9qr4G4n7N4xFnyRNiv7RzxcT944yQoZm9BlEp5dprYc/0AZU1A==
X-Received: by 2002:a6b:5b0e:0:b0:7da:4135:89be with SMTP id ca18e2360f4ac-7e1b521f9b3mr2248352639f.17.1715881510432;
        Thu, 16 May 2024 10:45:10 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4893715057csm4273595173.80.2024.05.16.10.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:45:09 -0700 (PDT)
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
Subject: [PATCH v8-RESEND 27/33] dyndbg-doc: explain flags parse 1st
Date: Thu, 16 May 2024 11:43:51 -0600
Message-ID: <20240516174357.26755-28-jim.cromie@gmail.com>
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

When writing queries to >control, flags are parsed 1st, since they are
the only required field.  So if the flags draw an error, then keyword
errors aren't reported.  This can be mildly confusing/annoying, so
explain it instead.

This note could be moved up to just after the grammar id's the flags,
and before the match-spec is detailed.  Opinions ?

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 7b570f29ae98..ccf3704f2143 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -106,6 +106,16 @@ The match-spec's select *prdbgs* from the catalog, upon which to apply
 the flags-spec, all constraints are ANDed together.  An absent keyword
 is the same as keyword "*".
 
+Note: because the match-spec can be empty, the flags are checked 1st,
+then the pairs of keyword values.  Flag errs will hide keyword errs:
+
+  bash-5.2# ddcmd mod bar +foo
+  dyndbg: read 13 bytes from userspace
+  dyndbg: query 0: "mod bar +foo" mod:*
+  dyndbg: unknown flag 'o'
+  dyndbg: flags parse failed
+  dyndbg: processed 1 queries, with 0 matches, 1 errs
+
 A match specification is a keyword, which selects the attribute of
 the callsite to be compared, and a value to compare against.  Possible
 keywords are:::
-- 
2.45.0


