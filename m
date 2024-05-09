Return-Path: <linux-kernel+bounces-174150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BD08C0AE7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 07:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003C41F23D3F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 05:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0771494AD;
	Thu,  9 May 2024 05:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y0WKAU9y"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B47413BC3C
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 05:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715232030; cv=none; b=glINXmUSdBsUzvcdCIUUsKh8jr7Zx1KDAyy98YsBKJ49RLJJo9iYQF6218wCmkx1NHqpEELD70rAZZr8SAVxEKt0uACBdF/DupauS47enfhlfNAs59xifQFK+CQwrOvi/m4JGoUv+lBBTVGc7s9xPWx433fILe0BE7IHZ8C4vX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715232030; c=relaxed/simple;
	bh=fxzc03xiy1uRj7YT6k0EW66t2TRrHgW9AZuVwi1W1UI=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=TTMvCw8m8AqZq2pFqdlyiVxzlQSJ/abo5ChDXAprBl7M66Pvc3wsogK34kCP/Tv1umgIzEjGSXVcAiFoyIs8XPb42TpWIGqACLjbB+dyrBRmGhXbGia3PujJTDN4URSJ3yqMT9KJEv0VrsMctoqvAbrtvmOrNNd3qwb5FgKFw6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y0WKAU9y; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b269686aso806543276.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 22:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715232026; x=1715836826; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cKR4JQSjtSVuxYtGmSkgtG2zpXYd/NDs31EyHZC9pAM=;
        b=y0WKAU9yBtqi6G5lRbAkYEQJeO83TqM2p2QfrdYfJTS5QRUt6+2ElBrRBUzYirDj8A
         9rAiECRSETXDW+URulonRdH1NrxDgeOa+CwizCgo4Z6oFC58ICgzP2H6yUdT0izPuhyW
         nqa5GEdE814l6Hh7PEbFSdTuBue69pKCsVhVSeeaxENkkB2p6orLNawz+9f8LfHDLOKF
         JbC+SBYaNn4xLapky2WYjIGvmJENGhGvG+hWzCn+i6s8rPEmrSVfgGBatkm9ZmZx7bFd
         B1XdJVuwpB0YFpDeOHcGGuDKadUke0faZPksw9JFe1TUH+Vnw3eJ2QdzvStIJUa2jsQe
         HTeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715232026; x=1715836826;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cKR4JQSjtSVuxYtGmSkgtG2zpXYd/NDs31EyHZC9pAM=;
        b=kGBafylMlbxoOWLxO2bZwol9WfAepTlcffYb2sni+V1zhByQ21mC5WgUwgqy8GxT1T
         QfVtzF9GY2fOt2mkRih+qvXl3lkL4oeKRyDYFSz0mEg5I+gVnP5sp25hLjxtfCcAFqUR
         t4+GHk8Q4fhf+21Jy0PwJ+lBrE/RBzx47WJc6OUE54q///XpsAY+y+vcNLFjKl0hV3e4
         NId5rViSDlwt8oRwZt2yEawodgMFhP7LdshDS1RdKpyr9g1SUtTIl+jaCjNHygBtApqT
         oKwSO0zULK9bZ97KOO2Lf2azCW6okJnTXX6ow6usBXhejmcIzESFa1ydPpAy3moEUPsz
         2ExQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvi9o6YebxtDX4xic4AXmBQzt6AD26lmbu6GeriLJ/PH3qXgbm1Y8NMwnXuZXyIb+p9huTNrzSc9ieD9UYLwUl4Jo4+ddRrRukEM6X
X-Gm-Message-State: AOJu0YzWiJMaQVP3NQ9LW1n4tGSlQWk7KzkqXdz4DciQf2ov4ILBy4mP
	uYVrqzkSKBcPHzImnQtsXXja2PADNud4i4zFfNZU2/wydB2S/qn+6rWwmfC97OPBkF9taIAOxni
	E2oWBiA==
X-Google-Smtp-Source: AGHT+IG4Y8TIjUMmmkP4nU8Gpc4+QcZV+RmNconpozNnzphFTv2apI3oNMa36lTl9GXi5yU0kUH6hsWqD+56
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3887:270c:55a5:15aa])
 (user=irogers job=sendgmr) by 2002:a05:6902:f88:b0:deb:8bc4:e291 with SMTP id
 3f1490d57ef6-debb9d9c0a2mr536998276.10.1715232026564; Wed, 08 May 2024
 22:20:26 -0700 (PDT)
Date: Wed,  8 May 2024 22:20:15 -0700
Message-Id: <20240509052015.1914670-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1] libsubcmd: Fix parse-options memory leak
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If a usage string is built in parse_options_subcommand, also free it.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/subcmd/parse-options.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
index 9fa75943f2ed..d943d78b787e 100644
--- a/tools/lib/subcmd/parse-options.c
+++ b/tools/lib/subcmd/parse-options.c
@@ -633,11 +633,10 @@ int parse_options_subcommand(int argc, const char **argv, const struct option *o
 			const char *const subcommands[], const char *usagestr[], int flags)
 {
 	struct parse_opt_ctx_t ctx;
+	char *buf = NULL;
 
 	/* build usage string if it's not provided */
 	if (subcommands && !usagestr[0]) {
-		char *buf = NULL;
-
 		astrcatf(&buf, "%s %s [<options>] {", subcmd_config.exec_name, argv[0]);
 
 		for (int i = 0; subcommands[i]; i++) {
@@ -679,7 +678,10 @@ int parse_options_subcommand(int argc, const char **argv, const struct option *o
 			astrcatf(&error_buf, "unknown switch `%c'", *ctx.opt);
 		usage_with_options(usagestr, options);
 	}
-
+	if (buf) {
+		usagestr[0] = NULL;
+		free(buf);
+	}
 	return parse_options_end(&ctx);
 }
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


