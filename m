Return-Path: <linux-kernel+bounces-181385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 024D98C7B7C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95BEF1F21D22
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE4915746C;
	Thu, 16 May 2024 17:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBA59cNo"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF239156862
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881455; cv=none; b=Izv/2yZv39Pd58HXZCws6DiQvrUCjTID7t29r95xFfpIf6xKy0aqIeiLPfGrcUEZ9b1i9k+1ZOjk+BBlCyz0zIXkhuu1EnS8yqnghdeYk8XEFNdHu03l9HNZ3rx4YbfDUTR6dgLW41UiCrfesZMZjpUh8QKhO/hV2y80pOwXIy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881455; c=relaxed/simple;
	bh=ZXhuDL5iIMt9rsPdhO1mxJVUwD3pwrVShJ9CSDPP6+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qrbrnIAlmD+ebPcoEbUq11duXq1/tOVRx365ADKVsoUeHWX3He2+FBYX/HWqQ88zw8dlA8MyV5X7KdQ3ge4H/G26fHYEBZgMinacV/6ItSIdyITa5uxTWwfg7cdDpaOfXPEDqRxbQ73QjemIaTYRBFICyOhwaz4iIMbip9Kxj+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBA59cNo; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7dad81110cfso63435339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715881453; x=1716486253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3jkEN2lvr8AQ7hFLPVcKhBqkSuaqnJkQBzyL1liDm8=;
        b=lBA59cNoe8xrch+z4OskxqlYuFYnxH+KWVubnsrPn6YfLhVOm3spaoM7i5BulfHeNw
         ZwAiygp2yFdj9iP6mtUVGL75VVGmwJE6ODV21P/8j+z7egZoYby03Kedfnw8skYgreHp
         w4OmjLeHuQECPmZYaIzrDTIKMQ9EevlKTvKQvAnJWd0DmMexALI5+mBtFyFf+FAsavQo
         dq8g8iriGUgCTtDZtCfih/fUdQAgx6gH401SZC//Uf+UBvjOiEKu/p3qFV0zlEIpmQqe
         ZOE6V4LyFDbK1U8wORmi8RxeLfEB2TeEZd3o2PmCgEh018du6UieNG+CwegBHU/noZge
         KK5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715881453; x=1716486253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3jkEN2lvr8AQ7hFLPVcKhBqkSuaqnJkQBzyL1liDm8=;
        b=c4tQLanNfY1engWsUM2ErAzaIWFuV9/wQJ/C9LTMepJLHxCwOjgfcYsGxAGke4oiaf
         yCv5DPYW5wR1TXBeiaFZpepHGvUB4l95s/wQ4EjKfU18La0gE/qygQaNc48ioItEOHvz
         b1hyTLoiZbkbPyYziF2MvQaHVgWziC+1jd2vtwqXtZwtgKo4DUApzBx6UFecNQ+XNvFt
         OBC1sPAllcY8jAzZTnY6HmK2Pgtt/7pkxUu21fQJG9/5zCe7YM3QkLHlo0gQz04n3qfX
         NEQ1B5fAa6R0rD8PRLZS1baz1zI2CjaNrlJw8KajvUPMQpYJo5N3hllcoA/Wlw5DMV03
         5wyw==
X-Forwarded-Encrypted: i=1; AJvYcCU1xAR1fwxdwsCn+gHTiNgqLueFtyIcIRuFWV9AcjoVdbK5ButvfIPP9Dvn3nIQWthwphFcX23rTfzbpAdmmdu5FtgoGFPgM5Z18Mle
X-Gm-Message-State: AOJu0YyMgnRLnJva9LHsZt0I8EMUxMfHmy3u8GCABCiddZWylR2SGYEL
	8MqBZ1DO8JDo6L3AGoi2YeEPqXUKGpca2OqZouri6Mfkw61bJuVP
X-Google-Smtp-Source: AGHT+IFz4usrZY3qDynwGeLrK+pO8sKyO9l3hH6ryzb2bPM6HcQI6YFG4ZZBc2EBHW4DKC86KU+PAw==
X-Received: by 2002:a5e:c702:0:b0:7e1:7b55:ad28 with SMTP id ca18e2360f4ac-7e1b51a2218mr2195390139f.3.1715881452835;
        Thu, 16 May 2024 10:44:12 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4893715057csm4273595173.80.2024.05.16.10.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:44:11 -0700 (PDT)
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
Subject: [PATCH v8-RESEND 03/33] dyndbg: reword "class unknown," to "class:_UNKNOWN_"
Date: Thu, 16 May 2024 11:43:27 -0600
Message-ID: <20240516174357.26755-4-jim.cromie@gmail.com>
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

When a dyndbg classname is unknown to a kernel module (as before
previous patch), the callsite is un-addressable via >control queries.

The control-file displays this condition as "class unknown,"
currently.  That spelling is sub-optimal, so change it to
"class:_UNKNOWN_" to loudly announce the erroneous situation, and to
make it exceedingly greppable.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index f2c5e7910bb1..73ccf947d4aa 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1154,7 +1154,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
-			seq_printf(m, " class unknown, _id:%d", dp->class_id);
+			seq_printf(m, " class:_UNKNOWN_ _id:%d", dp->class_id);
 	}
 	seq_puts(m, "\n");
 
-- 
2.45.0


