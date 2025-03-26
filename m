Return-Path: <linux-kernel+bounces-576376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7FEA70E6C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 02:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A1267A4019
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 01:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B331F94A;
	Wed, 26 Mar 2025 01:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZb/op7r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2D028E8
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 01:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742952660; cv=none; b=g9aJRBx+qz4hnR77czLw2/WS/M4DoIKIGhDlBquC8lUlPKKrJtiU9b7+vUTljTZ0+CKuU9C6D/JOEO7dZ2HRG9PYhh9XN3WOZStFTD/WZlE/u18VTdffh4UZhqXH25uwY//UtrXYI6wtnyHu5x0ivT96j4UWuaGT4MdgfKmxQiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742952660; c=relaxed/simple;
	bh=5gHcAuTQrQAksQjRD53/tJhS2YvQTnGQBoKv1ZxbKtc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q55A+N1WPt9LROg3D0kQ5eCIktOP/tZovHNmRANJecGo2uuRBOO3srho/6UqofF0+B1q0vKoMGpzLd4rAPiERv05mW1kGezsGPNElMy/k30OtJqu3q/bZdbUXA7VT8/Iui3UYuaoC/aEgt+y2uTxlegoJzbimJOrBCX+6UmAya0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZb/op7r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F84AC4CEE4;
	Wed, 26 Mar 2025 01:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742952659;
	bh=5gHcAuTQrQAksQjRD53/tJhS2YvQTnGQBoKv1ZxbKtc=;
	h=From:To:Cc:Subject:Date:From;
	b=iZb/op7rvCWqB+BDOtjzmAJVdKM+MFCc/ACrLvy+IJ1v/PiW1QBhO5N8Debc1p5sX
	 +tcMltZXEJXF4KSDHd6uuEaRogEyIyyNtZqiewSVwudBsdCKigul3CSYEz5ggltwhX
	 DOcnU/AtdRAo08SlDIT7l1D5u4+PNgt5uO3GL+D+H94iB5oAO+zkjI1h//9M3rTbyP
	 G1mNbJkD/NYaSO1PIoqj4M/7+gMLStRM4d6b/4n7HULc5i9DqUiER6Gu92+YPQ34G8
	 f9CcCfzboqQHrx99ytKpY3GG9xeWW59f6Rj4wHVKoy3zVbG1QZT2uKt9T0++7CIW3q
	 gp5AipQgr+p5g==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] objtool: Fix NULL printf() '%s' argument
Date: Tue, 25 Mar 2025 18:30:37 -0700
Message-ID: <a814ed8b08fb410be29498a20a5fbbb26e907ecf.1742952512.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's probably not the best idea to pass a string pointer to printf()
right after confirming said pointer is NULL.  Fix the typo and use
argv[i] instead.

Fixes: c5995abe1547 ("objtool: Improve error handling")
Closes: https://lore.kernel.org/20250326103854.309e3c60@canb.auug.org.au
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/builtin-check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 2bdff910430e..e364ab6345d3 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -238,7 +238,7 @@ static void save_argv(int argc, const char **argv)
 	for (int i = 0; i < argc; i++) {
 		orig_argv[i] = strdup(argv[i]);
 		if (!orig_argv[i]) {
-			WARN_GLIBC("strdup(%s)", orig_argv[i]);
+			WARN_GLIBC("strdup(%s)", argv[i]);
 			exit(1);
 		}
 	};
-- 
2.48.1


