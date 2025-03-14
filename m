Return-Path: <linux-kernel+bounces-562024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B07E8A61A9F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0BD0463A90
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC03B20D51F;
	Fri, 14 Mar 2025 19:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQXwKpl7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F36209671
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 19:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741980572; cv=none; b=VsAkRe5w8o7F9r1TisEoWHIzkV74kyO/qt/NCHsR3zNj1/qv1JpnVnwkO6WHJgBaADGOwzfD2o9lQMEA00kch1BUNhOCcaERv61FfruhzJp/X9LoZkToqI+W5s8zDIntGMZw1Zq81Rv3BdQdKNLNa6+eY0/SoTfPaO+DTQW8+TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741980572; c=relaxed/simple;
	bh=2RPx1BxZaiNmZR7J25T6h9oAjTbEay4C0cyWTnIeJzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VS9g3IQh1+kk/By2Sx0Em9wrR7XFr6JXlZoyzSxuBoGxyWFDdRfTZpFOBshySPHqcfP7vb/cPS5d9styuDlKOgRY6T7v+RET0KWOs2FJ0jfUhvFa7LAkpCh+Aoi6k5zqJhkRNCFl7r1NCg6ScLy29vsYaUwE466368kX6Njk0GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQXwKpl7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B08AC4CEEC;
	Fri, 14 Mar 2025 19:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741980571;
	bh=2RPx1BxZaiNmZR7J25T6h9oAjTbEay4C0cyWTnIeJzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kQXwKpl7eMhqK2cO7O+skTbnPEESf+u9HNIPgPyIzU1j/9SEP/viGHf0D8TCvz/Ue
	 xdfqDfLy8oWMy6yNIx+xrKUmj6FLQeFjukTfYfWPXO8X8Pe5VOl6XM99APVLGEq9on
	 AsBixYpPvxIOhmQ3JwITqW8aJHhXmQVvo4H+tIATy6Da5fkE8FGzWRQKXaPCIf3yID
	 AuZNK9mh/U5k2Geyx4/IW0q91SYSFtn082AEnFyvRCZxe7lbEYYlTi29yPJu8r5I5t
	 5eWyexav763x6xyw0OTXcIUctaPwTo+xxy7ycK2nyLaXOpLcDItOGNxcr29rgABCNO
	 oPsqqaOJa9zJQ==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 08/13] objtool: Upgrade "Linked object detected" warning to error
Date: Fri, 14 Mar 2025 12:29:06 -0700
Message-ID: <8380bbf3a0fa86e03fd63f60568ae06a48146bc1.1741975349.git.jpoimboe@kernel.org>
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

Force the user to fix their cmdline if they forget the '--link' option.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/builtin-check.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 36d81a455b01..79843512a51b 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -198,8 +198,8 @@ int objtool_run(int argc, const char **argv)
 		return 1;
 
 	if (!opts.link && has_multiple_files(file->elf)) {
-		ERROR("Linked object detected, forcing --link");
-		opts.link = true;
+		ERROR("Linked object requires --link");
+		goto err;
 	}
 
 	ret = check(file);
-- 
2.48.1


