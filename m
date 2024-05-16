Return-Path: <linux-kernel+bounces-181390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A7F8C7B83
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E82028226A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223341581FB;
	Thu, 16 May 2024 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Isq9LXxu"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAAB157E78
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881460; cv=none; b=SRk0jUO67jJM/ozJ2U0oG23JFNC2007P0AoyVw1G7JO5sRyIxXrAwx1YBEaxWeOSWctYDe+UwEGekOc/zxeYJFhLZbGDqIZasLvn5FGrqcPlhHP29GoTUrtr+NxXvkZn+TAFUPUJGQa5RYYAvN4oZKEhiJp6lAjS+CNd7cN42iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881460; c=relaxed/simple;
	bh=qhaSWleYG+r3n9pGZPTsZ6CKG0mS38934T1f4hN35uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mLFpatWBFvJO9s7Bsb636oGghqLQ0VoChf+a7TSPK04E+pce0lUxvqUJzulI8vAy5qk62TAiReDkDvsbAQMTKlIXqW9H55jnGgQSgwqw+rnWgwDAUXBz8+8kDnu/kXgy9vu0oaVrxk8Kl4yXQEM5IcGme/Jrdh7QIkPvCIg9QjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Isq9LXxu; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7e1b887c488so29574439f.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715881458; x=1716486258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0mUDwLsKTvN+KYpp0nKUCtynM6CNCM+YNZSzAF3Qbg=;
        b=Isq9LXxuLwRfNKIQYfhVHtfQMI0yjnZRL+WNsPAyhet39lZDvXImPGw30D/XIgHI2p
         E3PwCHueAGfKvGKHQDdzHowe3d1VgUeELYZ2IfE9JIWPGausjvs9I1QCfQyHt8hjq4Dz
         soFz6ELnHeIYtYZdj66tTlO+CxjWXoi1P+iCEnjcyJrfL0It9qDVTOl4hgQqPJ3Ls1IA
         OLVBGVANPGlcEgWR3mjtkvxRe2QbbhMhBJLhuFERotXl5PGm6Da6NNnUGKaIl3vXStgQ
         zPKP11HTrTu+sKfBC8++k51sb5LZR1CL/jvRVqX0rxVkitGIOy8I5KcpE7VkibDtpoJt
         oLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715881458; x=1716486258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0mUDwLsKTvN+KYpp0nKUCtynM6CNCM+YNZSzAF3Qbg=;
        b=H2TyJDVbHVZ0oVY8jUf5MmXM2hkcU4rlmWqlIAGPr5H/rkfh1h/Kmp8a50qMJcvq+C
         l5Gk+qfuRN6lXQ34BPAyc1hH2DdHVAMTHXEj9LAbnoeV+jLFwphy71GBB0G/SJH4ttvo
         /SxSR9RpYsZbGZmLXl6UPwoBjyscBSxZlJYLaxJmYGhpcsLFDb1+ws/NaWviKWI9JVFI
         c2ix6gUL2rADMpG/WwdTkvyqyy2fqV8RIGQvqD/97N4YhEMSpS9tZqcCgCynpBjl4IgB
         lYC1ILEP1ZXffK0h6HexjNdK9ysk49eFVGIi52JMOD4VRambNFHcdtbAKF5D2eYdWf/I
         zYUA==
X-Forwarded-Encrypted: i=1; AJvYcCXfFj84ox5vggXSfLhwZmjEvYVUvQlWL3qimPKfTf1/L7bPe0Zr00e4oO9LssMqa+q+/KVXmFz2Qb8ju5WK/TkYow78NX4yFglKDKn4
X-Gm-Message-State: AOJu0YyYeHNEgoiVWVoGyKHGthHHmJT4ktr3pPvL/e1odND6g+QGZnKm
	E1rk1Z5oySHUDKLaSR8dPF61w7kHREDJUqVRUTT6ScieGhuzt8pA
X-Google-Smtp-Source: AGHT+IGIOrAefexRX5iLZLVQpG/mCdV8Mzhuo1qT7J0aV4gPdaHlwEYUam8FNXCpbVmmpbDjB/83qQ==
X-Received: by 2002:a5d:8358:0:b0:7de:cb34:98ad with SMTP id ca18e2360f4ac-7e1a337fa7dmr1822853239f.1.1715881458411;
        Thu, 16 May 2024 10:44:18 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4893715057csm4273595173.80.2024.05.16.10.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:44:18 -0700 (PDT)
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
Subject: [PATCH v8-RESEND 08/33] dyndbg: drop NUM_TYPE_ARRAY
Date: Thu, 16 May 2024 11:43:32 -0600
Message-ID: <20240516174357.26755-9-jim.cromie@gmail.com>
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

ARRAY_SIZE works here, since array decl is complete.

no functional change

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index b53217e4b711..8116d0a0d33a 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -106,11 +106,9 @@ struct ddebug_class_map {
 		.mod_name = KBUILD_MODNAME,				\
 		.base = _base,						\
 		.map_type = _maptype,					\
-		.length = NUM_TYPE_ARGS(char*, __VA_ARGS__),		\
+		.length = ARRAY_SIZE(_var##_classnames),		\
 		.class_names = _var##_classnames,			\
 	}
-#define NUM_TYPE_ARGS(eltype, ...)				\
-        (sizeof((eltype[]){__VA_ARGS__}) / sizeof(eltype))
 
 /* encapsulate linker provided built-in (or module) dyndbg data */
 struct _ddebug_info {
-- 
2.45.0


