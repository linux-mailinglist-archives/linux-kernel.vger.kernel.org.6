Return-Path: <linux-kernel+bounces-256703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A189935233
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 21:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA8C2B21E51
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 19:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F7B145A1A;
	Thu, 18 Jul 2024 19:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQBnzRyB"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80777145359
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 19:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721331492; cv=none; b=DN9Yq6x1XLDgGcas7eJkuc/LfBmaqJRLFJfIWgZpDBl3zc4m6tLyZSnVEJ+982D59A6reuUQDVP8VX1erpY+DXz/9ONGwUiR6dXWk5KU9gG5BPVktwZRkKYpJWZvHmxa6AiJ1JGvKZicgXwU8PdPWS0UwVlWzw030Sec4dIMycQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721331492; c=relaxed/simple;
	bh=RYuacLTG+z634FBy6S6dcaYTEgCpyJ6rTHqYmBDdDPU=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PrG3SOMPLCEhgZQZoQquSR6VUXrfVDi1E4Q0rCynQmnEYH29V+gvUPU50Qy9q+vQXOeGqFKiBCCO17SbSaNyt3YneustRT/jdjQ0ItMpBPbwd8+vtRIEFwFWUGbNO92ybItTxk9mCzf5bt3sWpaXe25uRqE+3wbHS6xWU8czVyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQBnzRyB; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fb1c918860so18074065ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 12:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721331491; x=1721936291; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xlvbcmfbLNtQB/g1YUVOloxgGcbDxiAVH5DBzdK+Zy4=;
        b=KQBnzRyBd5BXSG1Phky2Ik6AFq9mFr+ovKhKj+u9dkk3pFtm/WRlqzHOwnc3gmsKJm
         uTYlV+SbNNNbKWHz8DNLjRdJarqs6LUHLjmXCDGlLBFMCIItwqlqTQtFpnC6aquIKZm3
         kpg/AX0wXKI1ulLpRgTNpuZV5caKmTfsJtDzK3BcJxICM4kceNKYIV5sk40kgVKF7IjC
         z4n9athcgch4tjdZnKjAGULlVveXG1AKo4nw1yQGO/7oSHngT/usA4omwZS6I8yZ9BEn
         uC0AdHkLg0ISg2BuOCdNEvzdJ7C3731S/nIeSQZG93OLdh9C2gg0EEAvw3m2eEXGXNKG
         1Img==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721331491; x=1721936291;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xlvbcmfbLNtQB/g1YUVOloxgGcbDxiAVH5DBzdK+Zy4=;
        b=LxV6RIy2apmHuhM75oCeS8Saau5Hd4/g8S+KT2D6xGZvYiqTv7BvfiMTH1TLRolJeK
         0v4DkjB6bq2BcX2Msy+qq3MSRvPzo37VIBuXVRdSUtXxKWY1/VjoUcmLgADIs43m8HnT
         65wgGPjBlH6+eet0klh40UbY8hjohS5bLgsKOkYzDid8CcaGq3ADnmhh5tAJ+Ror+P2H
         AZM/UZo1L7dX1Abx9Xg4R0j9jzP/CCrtdKTRD3m2KhZsuqcfqwrKePKNC3br+s6U+6k+
         Qc22a9kThDhPNjS9gWCnBnFCweYueM0Jmme+a3AFcYAv7eiZ5NoqfMv1oPfQ9LGgg1cs
         5odw==
X-Forwarded-Encrypted: i=1; AJvYcCUyd0oDF97LPZuK6xfsWelIa4xeGqazyYs5g64nPfdL7Ow8A8wRvPXbjDtDDpKmtGJUQ6LvSjW4Bj/zffc4kYPKFQZOmLnJih/zIS66
X-Gm-Message-State: AOJu0Yxk0YvqqJWR60SNpgiwwZ7PrYpjFuXjeJtg/i7knizi1EbGmdTT
	5Cy8ZlDbar4KB2lrch/YbWVvMrH/1gQdYMlqGrFzCpHQ4Uhop/DS
X-Google-Smtp-Source: AGHT+IHsUqhh+XVVyUQrl9f8/4GnVrFP6k1Z70IknXZEWEGomJDovsBSVGGzpjk1aX4pH5Xw1iSRCQ==
X-Received: by 2002:a17:902:eccc:b0:1fb:9b91:d7d9 with SMTP id d9443c01a7336-1fc5b647251mr64844255ad.26.1721331490555;
        Thu, 18 Jul 2024 12:38:10 -0700 (PDT)
Received: from localhost ([138.0.199.154])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc72faa189sm5898605ad.46.2024.07.18.12.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 12:38:10 -0700 (PDT)
From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Thu, 18 Jul 2024 16:38:07 -0300
To: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH perf-tools 1/1] perf daemon: Fix the build on 32-bit
 architectures
Message-ID: <ZplvH21aQ8pzmza_@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Noticed with:

   1     6.22 debian:experimental-x-mipsel  : FAIL gcc version 13.2.0 (Debian 13.2.0-25)
    builtin-daemon.c: In function 'cmd_session_list':
    builtin-daemon.c:691:35: error: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'time_t' {aka 'long long int'} [-Werror=format=]

Use inttypes.h's PRIu64 to deal with that.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-daemon.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index de76bbc50bfbcbb6..5c9335fff2d396b4 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <internal/lib.h>
+#include <inttypes.h>
 #include <subcmd/parse-options.h>
 #include <api/fd/array.h>
 #include <api/fs/fs.h>
@@ -688,7 +689,7 @@ static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
 			/* lock */
 			csv_sep, daemon->base, "lock");
 
-		fprintf(out, "%c%lu",
+		fprintf(out, "%c%" PRIu64,
 			/* session up time */
 			csv_sep, (curr - daemon->start) / 60);
 
@@ -700,7 +701,7 @@ static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
 				daemon->base, SESSION_OUTPUT);
 			fprintf(out, "  lock:    %s/lock\n",
 				daemon->base);
-			fprintf(out, "  up:      %lu minutes\n",
+			fprintf(out, "  up:      %" PRIu64 " minutes\n",
 				(curr - daemon->start) / 60);
 		}
 	}
@@ -727,7 +728,7 @@ static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
 				/* session ack */
 				csv_sep, session->base, SESSION_ACK);
 
-			fprintf(out, "%c%lu",
+			fprintf(out, "%c%" PRIu64,
 				/* session up time */
 				csv_sep, (curr - session->start) / 60);
 
@@ -745,7 +746,7 @@ static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
 				session->base, SESSION_CONTROL);
 			fprintf(out, "  ack:     %s/%s\n",
 				session->base, SESSION_ACK);
-			fprintf(out, "  up:      %lu minutes\n",
+			fprintf(out, "  up:      %" PRIu64 " minutes\n",
 				(curr - session->start) / 60);
 		}
 	}
-- 
2.45.1


