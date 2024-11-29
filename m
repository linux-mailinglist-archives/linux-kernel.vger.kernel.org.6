Return-Path: <linux-kernel+bounces-425458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 434419DC258
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 11:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5A43284ABF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 10:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D469A192B83;
	Fri, 29 Nov 2024 10:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFRnyGgp"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90A1155345
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 10:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732877071; cv=none; b=k73Qgw4QGAY/BpgM3q1ZNuv5kxLCGc6bm1TFa6JuoGO88aL9n5AH6piW+Q5KFHYiALx5TPor5QTN1E7wesJsFqYkUdpxb3NwE96KgaCQlxZZJ62G7xfUW/G1Y96xNv9nHsaTlZwI2IlkYLwGc9xGShKPjWmRlkmTVXX3mWufzqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732877071; c=relaxed/simple;
	bh=Phd/LB4UQBllK0RmKrAK6deJdMBBXi2MiYI40qMZVsE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AqayG2hXcvMB7dFESvCa4AQkZZQMWlqJhK97VDb6cr4dAei6P8+zBgURhAKCwadViZemqWE3Pin48NH/QnbFTrEgdkWivte5AXpns2sga64MYSqjHN/hkzO1cNCY6moijcLsJjBUyrb4poW3yMbwMvTfBXfrhQ8iKuHnREkuM3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFRnyGgp; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7fc99fc2b16so977931a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 02:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732877069; x=1733481869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+tceCOdD9w17Xb0NF05p4gwCJE5PDpjfmbXsA+3YzBI=;
        b=eFRnyGgpvoIyEKDuL+rug8RzK3kym6CfAkW9jxop5QEeUwGHl8bMOEgi8k5oaD8ky/
         m6Vh8kaM08gJwn3lHxGaoRQfUOZaqRXRZBx38+Gjelrl3DWYtFUPRZfjlXMc3KzULe/v
         QRK1VNEFhiez1ccAcToIQcMG4u234IgsYMGvOyaW20z7XuFOS4ZBhhNZyIIpvx0RVir8
         H6AxltkcPEqv0yv/OpS6KODFaylhFnFH9yuVru6rbwTvI+KT8GVV5qXoRJa8TKfnv+TG
         U96JWAqTyuUqypdzbfW1hTqliKkebniAnhCtVj5jEM+12kzLU0smxvC9AMwVBBcCpNy9
         FMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732877069; x=1733481869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tceCOdD9w17Xb0NF05p4gwCJE5PDpjfmbXsA+3YzBI=;
        b=R5cEUI+Hmj2TuU70sayCkiLvkoSQA1KrkPNwUwDtChe7stJqZ6huFApJbkfoHflbal
         cruottA3sV8jjTdLpjqM8kAuEgaW2I943ct18Ky28BF3WfQzqO7BioA47MV63jhRzZ4t
         /mAQctavz+yQiU3lo1WCtUaTFgAtFAuLtWxGplZmEv+wIFJ6OaZOfbL4HfnBBjgecdK1
         amoJ/WI8RyPVsiJdiPbcCmyGZdAtw7BADXG2hkM7fTIwvJadMFn2dXLB4AdVOHUYuAk8
         mY2/3eIEV97xjI+PueZ2TbR/j/tmtljbYKOEoH5vt/kmrzqjbtOpqX3sf6fQNouPJYlN
         RI1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVOyvnmxvWC6EpTvC/CH5+KsM35PeLDYej3rBBuzsO6z7ITzOeE1lj9rJFTZzOUVV28NGhqElWaiBK6DZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1DTZZ8ziSnUqyrvKraTj6O7r55bmM2tQvxYpMM/JG8cxubUHP
	sYqWN/3TLbJaz4yqR9gCDe7CLjr0abXEYVxKtn5ESS0L0rZE6WdD
X-Gm-Gg: ASbGncsrDA+k0y4/tOiGyHWdNnG6EY9Wsd4I3PpnDEuwpsdmm/Q1ljHkfM4eraxedK3
	5GJyuJq11y+ddEI7DIraYQmjeKy7e8xqDMQK0Pj5r7TJ20ziHDbiYWufHkZERS8wsb8SeFr1D6V
	e2RQb0fYh7Mrp20+NyGpop5SXcwsyoSyAlN9b7hYpMOnoYxxKbquYawYBt/RGRKYCoLj16TaG+p
	S/ZrPCAWFEC7kIvz+qqXxFGMKCUEiTJB/SqlZw/z19hQCdG2tk09m/pcTKJOTiTdukw4IibDph0
X-Google-Smtp-Source: AGHT+IFXf4FfV/mmpqOgApowWW1WEgFHCNbUvuebjgKU838+pqiz1rhyPZ+W2eSrg3lBkm0/2WC2QA==
X-Received: by 2002:a05:6a20:9185:b0:1e0:d618:1fe3 with SMTP id adf61e73a8af0-1e0e0b249a3mr15187416637.26.1732877069118;
        Fri, 29 Nov 2024 02:44:29 -0800 (PST)
Received: from kernel-VirtualBox.. ([2401:4900:1c80:568a:3302:a169:fb39:495d])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72541770310sm3153455b3a.74.2024.11.29.02.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 02:44:28 -0800 (PST)
From: Atharva Tiwari <evepolonium@gmail.com>
X-Google-Original-From: Atharva Tiwari <atharvatiwari1101@outlook.in>
To: 
Cc: atharvatiwari1101@outlook.in,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Aditya Gupta <adityag@linux.ibm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Eder Zulian <ezulian@redhat.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fix: add safety check for OPTION_END and refactor code for consistency
Date: Fri, 29 Nov 2024 16:13:53 +0530
Message-ID: <20241129104401.5997-1-atharvatiwari1101@outlook.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Added a null check for 'o' before copying the last OPTION_END in options__order function to prevent potential uninitialized usage.
- Refactored the parse_long_opt function for improved readability by aligning function signature.
- Minor formatting fix to ensure consistency in the codebase.
- Updated the wrapper script for pseries architecture to handle 'notext' option in a more reliable way.

Signed-off-by: Atharva Tiwari <atharvatiwari1101@outlook.in>
---
 arch/powerpc/boot/wrapper        |  1 +
 tools/lib/subcmd/parse-options.c | 10 +++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 1db60fe13802..d25ad8c622f4 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -267,6 +267,7 @@ pseries)
     link_address='0x4000000'
     if [ "$format" != "elf32ppc" ]; then
 	link_address=
+	notext='-z notext'
 	pie=-pie
     fi
     make_space=n
diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
index 555d617c1f50..f85b642bc9aa 100644
--- a/tools/lib/subcmd/parse-options.c
+++ b/tools/lib/subcmd/parse-options.c
@@ -360,8 +360,7 @@ static int parse_short_opt(struct parse_opt_ctx_t *p, const struct option *optio
 	return -2;
 }
 
-static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
-                          const struct option *options)
+static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg, const struct option *options)
 {
 	const char *arg_end = strchr(arg, '=');
 	const struct option *abbrev_option = NULL, *ambiguous_option = NULL;
@@ -828,9 +827,10 @@ static struct option *options__order(const struct option *opts)
 
 		nr_parent = nr_opts;
 	}
-	/* copy the last OPTION_END */
-	memcpy(&ordered[nr_opts], o, sizeof(*o));
-
+	/* Check whether o is  valid before using it to copy the last OPTION_END. */
+	if (o && o->type == OPTION_END) {
+		memcpy(&ordered[nr_opts], o, sizeof(*o));
+	}
 	/* sort each option group individually */
 	for (opt = group = ordered; opt->type != OPTION_END; opt++) {
 		if (opt->type == OPTION_GROUP) {
-- 
2.43.0


