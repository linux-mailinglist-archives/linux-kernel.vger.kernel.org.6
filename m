Return-Path: <linux-kernel+bounces-562027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E0CA61AA0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3A3F463B26
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74B620DD47;
	Fri, 14 Mar 2025 19:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsMLPkhY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F9520A5EB
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 19:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741980572; cv=none; b=p+f79N7OrmG4m9L/115rXHtSeUQXJsSe1r4gpjvCul1+5Rv1lSo9vLvubGizZ5V5QqHZ9ZX46AZVU3O3LBIcuTvroGR06907oMAvNx39IFiM3fnwHE79qC+X3q2z/ORGuAsM9C5bG89zOo3MOX5X0CONMgVTzHji+QB8TCnAHZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741980572; c=relaxed/simple;
	bh=8bNnqgfdWIJ00VMJF4b2nsxmpSSKNLE/p89AYncO9Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K1lFlgOzOMmVAW4e5fkr7wWUr3O63/pA6LOeRfbeMmI1iCvUeuoOMhZPASPjobFEAvEFI0jpdD/e5agt23fkZmAH24PkSd8mGZk9LLaQ8GsA6UNX3leBDzMby4n4OG++LMIWerhJPWMLM/OyOA2nOQOXJ7Q8Qs4CxuQBm3zBZhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsMLPkhY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68939C4CEEE;
	Fri, 14 Mar 2025 19:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741980572;
	bh=8bNnqgfdWIJ00VMJF4b2nsxmpSSKNLE/p89AYncO9Eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UsMLPkhYiEARsQr06oH2RGIPJ7B4nanjkY/Rp14b1v1t4mqo9ybI/sqK27qLXSsmv
	 2ayCRxRNL/pdJ7hrCL3EW+Ji+7PU5GruLIK5fNprdOn6aNMq+fNlZZl/bHbpf/Mzx4
	 lsKQpzUTEzRMonKSx17RKC+5/rSP3MLNswg/Wx1rfDpPHIoXA1h8fp0nPXVzI20Xwl
	 qmqGvBoTksZ2K0Wlviax055KIhsZjp8oY0AZcwoYEp6kpSqf5e6SxMU5xG3FbHnTUz
	 71R3e2p3sh4hZEKyyMAAo4GeYvL9yktjODP0JvdAbBLl4CQfoQ+Ojf2Bu3oymvx2e4
	 PYnbWwcslJp0g==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 10/13] objtool: Add --Werror option
Date: Fri, 14 Mar 2025 12:29:08 -0700
Message-ID: <e423ea4ec297f510a108aa6c78b52b9fe30fa8c1.1741975349.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741975349.git.jpoimboe@kernel.org>
References: <cover.1741975349.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Any objtool warning has the potential of reflecting (or triggering) a
major bug in the kernel or compiler which could result in crashing the
kernel or breaking the livepatch consistency model.

In preparation for failing the build on objtool errors/warnings, add a
new --Werror option.

[ jpoimboe: commit log, comments, error out on fatal errors too ]

Co-developed-by: Brendan Jackman <jackmanb@google.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/builtin-check.c           |  1 +
 tools/objtool/check.c                   | 15 ++++++++++++---
 tools/objtool/include/objtool/builtin.h |  1 +
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 3de3afa0a19c..c201650efe49 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -101,6 +101,7 @@ static const struct option check_options[] = {
 	OPT_BOOLEAN(0,   "sec-address", &opts.sec_address, "print section addresses in warnings"),
 	OPT_BOOLEAN(0,   "stats", &opts.stats, "print statistics"),
 	OPT_BOOLEAN('v', "verbose", &opts.verbose, "verbose warnings"),
+	OPT_BOOLEAN(0,   "Werror", &opts.werror, "return error on warnings"),
 
 	OPT_END(),
 };
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 3ddaefe97f55..b574f2e8b07f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4737,9 +4737,18 @@ int check(struct objtool_file *file)
 
 out:
 	/*
-	 *  For now, don't fail the kernel build on fatal warnings.  These
-	 *  errors are still fairly common due to the growing matrix of
-	 *  supported toolchains and their recent pace of change.
+	 * CONFIG_OBJTOOL_WERROR upgrades all warnings (and errors) to actual
+	 * errors.
+	 *
+	 * Note that even "fatal" type errors don't actually return an error
+	 * without CONFIG_OBJTOOL_WERROR.  That probably needs improved at some
+	 * point.
 	 */
+	if (opts.werror && (ret || warnings)) {
+		if (warnings)
+			WARN("%d warning(s) upgraded to errors", warnings);
+		return 1;
+	}
+
 	return 0;
 }
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index 25cfa01758b9..b18f114cdaa4 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -39,6 +39,7 @@ struct opts {
 	bool sec_address;
 	bool stats;
 	bool verbose;
+	bool werror;
 };
 
 extern struct opts opts;
-- 
2.48.1


