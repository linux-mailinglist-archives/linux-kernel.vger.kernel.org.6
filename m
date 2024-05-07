Return-Path: <linux-kernel+bounces-170929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D568BDDF9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 076001F240F2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0841D14E2D2;
	Tue,  7 May 2024 09:20:18 +0000 (UTC)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024D414D2BF
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 09:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715073617; cv=none; b=iweMJsYUQKdMQ0IPAEGT7Fz7CjIRrRCgCnCxrla795Ujuqwj+en0RkrdNAv0VXlGQ27eVpgAga8CmTMFoRpLBI++ZdED5xoiEtpCophmNZ8oYbLhFNj8KS06A8j+K13wEjjg744GQJm7c+GuAB1BwyyR72QOkyQxQ6cIp3jZJhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715073617; c=relaxed/simple;
	bh=wmfxCx98oiGEm0S2u+uUju/dQan/1Xv1qYRtUIqEhig=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OpLwmLsh8NP55aJWhqlSEki77AeBX0OwN/f8EyE04adOPcdBAdr8i+BNrs19xqkdP90Cu+MwdUUS4rqIkdTWh0rJP085yQRVlzGw/ceHpdZYxTcO2496gcxAn24nljrzhbRnIaY7PdOSlS43fzS6OiQ/FHJ2CbW0dGdneEWTVhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
	by Atcsqr.andestech.com with ESMTP id 44793Dkq098770
	for <linux-kernel@vger.kernel.org>; Tue, 7 May 2024 17:03:13 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
	by Atcsqr.andestech.com with ESMTP id 447931Cg098720;
	Tue, 7 May 2024 17:03:01 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from atctrx.andestech.com (10.0.15.190) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0; Tue, 7 May 2024
 17:03:01 +0800
From: Ben Zong-You Xie <ben717@andestech.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <irogers@google.com>, <adrian.hunter@intel.com>,
        Ben Zong-You Xie
	<ben717@andestech.com>
Subject: [PATCH v2] perf daemon: Fix the warning about time_t
Date: Tue, 7 May 2024 17:02:41 +0800
Message-ID: <20240507090241.3853998-1-ben717@andestech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 44793Dkq098770

On the 32-bit platform, the size of time_t is 32 bits or 64 bits according
to the architecture. Therefore, use typecasting to resolve the warnings
for some architectures, e.g. RISC-V.

Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
---

v2: By Palmer's remind, patch v1 may introduce a warning for some
    other targets. Thus, use typecasting instead.
 
---
 tools/perf/builtin-daemon.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 83954af36753..cb04caa902e8 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -688,9 +688,10 @@ static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
 			/* lock */
 			csv_sep, daemon->base, "lock");
 
-		fprintf(out, "%c%lu",
+		fprintf(out, "%c%llu",
 			/* session up time */
-			csv_sep, (curr - daemon->start) / 60);
+			csv_sep,
+			(unsigned long long)((curr - daemon->start) / 60));
 
 		fprintf(out, "\n");
 	} else {
@@ -700,8 +701,8 @@ static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
 				daemon->base, SESSION_OUTPUT);
 			fprintf(out, "  lock:    %s/lock\n",
 				daemon->base);
-			fprintf(out, "  up:      %lu minutes\n",
-				(curr - daemon->start) / 60);
+			fprintf(out, "  up:      %llu minutes\n",
+				(unsigned long long)((curr - daemon->start) / 60));
 		}
 	}
 
@@ -727,9 +728,10 @@ static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
 				/* session ack */
 				csv_sep, session->base, SESSION_ACK);
 
-			fprintf(out, "%c%lu",
+			fprintf(out, "%c%llu",
 				/* session up time */
-				csv_sep, (curr - session->start) / 60);
+				csv_sep,
+				(unsigned long long)((curr - session->start) / 60));
 
 			fprintf(out, "\n");
 		} else {
@@ -745,8 +747,8 @@ static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
 				session->base, SESSION_CONTROL);
 			fprintf(out, "  ack:     %s/%s\n",
 				session->base, SESSION_ACK);
-			fprintf(out, "  up:      %lu minutes\n",
-				(curr - session->start) / 60);
+			fprintf(out, "  up:      %llu minutes\n",
+				(unsigned long long)((curr - session->start) / 60));
 		}
 	}
 
-- 
2.34.1


