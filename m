Return-Path: <linux-kernel+bounces-570934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17455A6B668
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3F403BDF33
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC901F0E4C;
	Fri, 21 Mar 2025 08:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ms4pzBpa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CB18BEE;
	Fri, 21 Mar 2025 08:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742547200; cv=none; b=WpiC754+8oiUE+1Fd3DIr1LNz0QVqa6p3rNeXMx5hK43VVMgI4Pgi3+F/26Q9tnRaFcOCPHea2WqPbYskdH7GuDru5dXoVuZ5kQZRJKaYLbaWvButnoIsxA6vU8ZXqOcK0T351iX+eziSc8sQqDLh1CZP/ySQL1FC9Knvdt6BBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742547200; c=relaxed/simple;
	bh=t977FsMUBlc8ZNdRKWvO4yugH+jGz1A2sc1tshC8jrM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tujl0FtBII+53ldPirOpv/dq3qhE9vFGfVvQ0qZdhvDEw2bG0l1aAMIpwFBnIu+1fNRnwVmyQEUFfzV2blboOiIvy8sFhrZqKM6kT2ZSQL+d791QS8EalirDgfVbBtY9GvCNV3BWz5DKXacR0OrIuUI/oaKGy32p+J9LzvLGOyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ms4pzBpa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF8BC4CEE3;
	Fri, 21 Mar 2025 08:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742547199;
	bh=t977FsMUBlc8ZNdRKWvO4yugH+jGz1A2sc1tshC8jrM=;
	h=From:To:Cc:Subject:Date:From;
	b=Ms4pzBpaF/ixuovfKG+R1TVujRf7aHWkE/tkeCd54XjmQ9qwc4CES7TSycue/7rKU
	 myePBDQ+9MlZGEx/VvPcvtI3qucGbohG8rJz/8KQfs0aHTZkfpTPYbVplmuvgAvQB5
	 kuT8K041TiNyMUM9CtTYlaH2wnw2MH9le98d3ykJLkqkSl5Dsm1LZ54K5H8qvhJTAh
	 J0YShJegdRenxGw2pitUd5YrRvIxUE5n9J5wfRbpX9hsxFZVvZKrVIVM6Z0DdeU3kR
	 65yCl++79NzULnmfVenZRkXWV2uO9q3lFnOcqGpjddk6R4IgGzLYrl0mkYOj5vhjVR
	 iuL14M7aVO8lg==
From: Arnd Bergmann <arnd@kernel.org>
To: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: kernel test robot <lkp@intel.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] platform: cznic: fix function parameter names
Date: Fri, 21 Mar 2025 09:53:07 +0100
Message-Id: <20250321085315.915808-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

A invalid prototype made it into a previous patch, causing an clang warning:

drivers/platform/cznic/turris-signing-key.c:25:55: warning: omitting the parameter name in a function definition is a C23 extension [-Wc23-extensions]

and a slightly different warning with gcc-11 and earlier but not gcc-12 and up:

drivers/platform/cznic/turris-signing-key.c: In function 'turris_signing_key_instantiate':
drivers/platform/cznic/turris-signing-key.c:25:43: error: parameter name omitted

Add the parameters to get a clean build with all compilers.

Fixes: 0b28b7080ef5 ("platform: cznic: Add keyctl helpers for Turris platform")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503210450.AoOpbJXC-lkp@intel.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/platform/cznic/turris-signing-key.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/cznic/turris-signing-key.c b/drivers/platform/cznic/turris-signing-key.c
index 3b12e5245fb7..3827178565e2 100644
--- a/drivers/platform/cznic/turris-signing-key.c
+++ b/drivers/platform/cznic/turris-signing-key.c
@@ -22,7 +22,8 @@
 
 #include <linux/turris-signing-key.h>
 
-static int turris_signing_key_instantiate(struct key *, struct key_preparsed_payload *)
+static int turris_signing_key_instantiate(struct key *key,
+					  struct key_preparsed_payload *payload)
 {
 	return 0;
 }
-- 
2.39.5


