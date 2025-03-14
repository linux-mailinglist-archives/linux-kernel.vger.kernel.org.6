Return-Path: <linux-kernel+bounces-562028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CA6A61AAC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 714E13BDEE2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EC1204F7C;
	Fri, 14 Mar 2025 19:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5Z85cPl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2573420B217
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 19:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741980573; cv=none; b=SwOJsf1R5pmhVM2rn9ZM1ccqQvPaueWs8OvuLSh7Qiyp47NPdFBgIfd7r5QzGnvKg24s1QNS7yBoggJmeX5TV+ALgeH+yjIiMktpi2DpxXeA5h/CaQHUTXwhXUiP0psYD3b5ydokQCxKb6EGgrRpb0zoAyMz/rdhhCfUNHHM1nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741980573; c=relaxed/simple;
	bh=omUmkLw0f0UbB3xgJ3lIhVidBc43HYclIvLEBahfasw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GHQrfQDa81Rx/MXEfZ6V0Ib5FbDek0P/mh2u2OSu0psGOci8WDoXu5Sfl9ow1AoCdmUlONqkeFUlVuN0J6Sw9DlZHLI2a3eMrbOr7dpUB1T+0ZufWzBVLPkuUA7xV0kCf4n2S12vUb7LfBznT0d0SVRg9/04jJUJsOUUgvO0DlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5Z85cPl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4375C4CEF6;
	Fri, 14 Mar 2025 19:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741980573;
	bh=omUmkLw0f0UbB3xgJ3lIhVidBc43HYclIvLEBahfasw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H5Z85cPlgN87BEBpHwuOFpdb9stmTcetB2tbkHrIRzsrfHG1SPoMf2+tKb/+NLvgb
	 y+Qq8C7W4Ob8ze3pSOA73Ra+PjvwiKJJgFsUECETBgzdS/AsjCjKp9qIKXd2MWQxNc
	 zfaAJParRwzw0F1XTTEMpeYfU9mtvBhmD4OhtIa7ZT0NYt8fpiGFSvf0gqVzmT1cq0
	 GunYXHqWyHtekJjFa5+3oorRvHFDAolXJJ3IE5cavRAzLke8u1eFpzDZbYwIschck8
	 c2rB0PxtulVErNef9bvJ8CbKQlFIFfzta7VUHEcoNQQMtPdVE50l0wUQ9NzXeHGaGY
	 DDvoAoNrCe9NQ==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 11/13] objtool: Change "warning:" to "error:" for --Werror
Date: Fri, 14 Mar 2025 12:29:09 -0700
Message-ID: <56f0565b15b4b4caa9a08953fa9c679dfa973514.1741975349.git.jpoimboe@kernel.org>
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

This is similar to GCC's behavior and makes it more obvious why the
build failed.

Suggested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/include/objtool/warn.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/include/objtool/warn.h b/tools/objtool/include/objtool/warn.h
index 6180288927fd..e72b9d630551 100644
--- a/tools/objtool/include/objtool/warn.h
+++ b/tools/objtool/include/objtool/warn.h
@@ -43,8 +43,10 @@ static inline char *offstr(struct section *sec, unsigned long offset)
 
 #define WARN(format, ...)				\
 	fprintf(stderr,					\
-		"%s: warning: objtool: " format "\n",	\
-		objname, ##__VA_ARGS__)
+		"%s: %s: objtool: " format "\n",	\
+		objname,				\
+		opts.werror ? "error" : "warning",	\
+		##__VA_ARGS__)
 
 #define WARN_FUNC(format, sec, offset, ...)		\
 ({							\
-- 
2.48.1


