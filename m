Return-Path: <linux-kernel+bounces-333738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE4897CD26
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 19:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43FE71F24F94
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 17:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11261A2578;
	Thu, 19 Sep 2024 17:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GuKHmjjT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAC51A0718;
	Thu, 19 Sep 2024 17:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726767467; cv=none; b=nugDieHbyiPbzLtUoSJiunewWO/zWa3jcdbszZ4LSBobwWbSqqImwDI5lP3xO9qMqru4g+n2KbkhUspG68zfZnyIOcvF/870jJJsjFrkHBB3tb/8jw8yt4HquFLf0OSBZf/iky46lnmyfhr+wI0hQ+zwqm1toXhDRUS/Ji6W5jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726767467; c=relaxed/simple;
	bh=N/mW8g5kxumYZHOlcz6gF4FNUJq76OQN7SMb5YzXnqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=goYwz6NrxQmTNUksICyndJ75PZ0vKAFx/eOX9V0Zm2MsiyF2+d+AMEhd7eG2hxvCKByQvR7FE4todt64XUiEGKtM9XVaVk3lSOwhKKrMWXiFehVwx40bNwiIm9ffd35s75mv+PAorAPPSnEs8hcNzBb1SB0i9iiU4a5YcG/paY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GuKHmjjT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A89AC4CEC4;
	Thu, 19 Sep 2024 17:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726767466;
	bh=N/mW8g5kxumYZHOlcz6gF4FNUJq76OQN7SMb5YzXnqM=;
	h=From:To:Cc:Subject:Date:From;
	b=GuKHmjjTyXcFV+kqH+WKansOjxhaagaXJUFfSEjH8BkU6etRnXvZpNsa4nvsut/1H
	 EOdTJe7Z7d9JubwK7L4+c4Rk3AEky3X7t8Y6AdVVzmmm9mN0Uk9o047hqpOEg1DrW3
	 aE3mKSZQVlN5FDzjc1wyiuAO7K+UFNaHMpUev7i3eV5zqEtyRM2Zwf5oit75qJcdxM
	 68lkZNpsr8NTmXaFVyrQFzfPw1aNE5S2uDOV0dWN+Q9apC/hnYJ5KKgLzb9/65cd6r
	 ATiYnlRVAI2lFJo+WUiiW0nj+GuiA2TJXEl5AZIiPugebASIUEK9l9qqD05TfruAih
	 WTD2xNkfMMGOw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 1/5] kbuild: doc: throw out the local table of contents in modules.rst
Date: Fri, 20 Sep 2024 02:37:14 +0900
Message-ID: <20240919173740.1080501-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do similar to commit 5e8f0ba38a4d ("docs/kbuild/makefiles: throw out the
local table of contents").

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - New patch

 Documentation/kbuild/modules.rst | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/Documentation/kbuild/modules.rst b/Documentation/kbuild/modules.rst
index 7eceb9a65e9c..4f67e6a27afe 100644
--- a/Documentation/kbuild/modules.rst
+++ b/Documentation/kbuild/modules.rst
@@ -4,35 +4,6 @@ Building External Modules
 
 This document describes how to build an out-of-tree kernel module.
 
-.. Table of Contents
-
-	=== 1 Introduction
-	=== 2 How to Build External Modules
-	   --- 2.1 Command Syntax
-	   --- 2.2 Options
-	   --- 2.3 Targets
-	   --- 2.4 Building Separate Files
-	=== 3. Creating a Kbuild File for an External Module
-	   --- 3.1 Shared Makefile
-	   --- 3.2 Separate Kbuild file and Makefile
-	   --- 3.3 Binary Blobs
-	   --- 3.4 Building Multiple Modules
-	=== 4. Include Files
-	   --- 4.1 Kernel Includes
-	   --- 4.2 Single Subdirectory
-	   --- 4.3 Several Subdirectories
-	=== 5. Module Installation
-	   --- 5.1 INSTALL_MOD_PATH
-	   --- 5.2 INSTALL_MOD_DIR
-	=== 6. Module Versioning
-	   --- 6.1 Symbols From the Kernel (vmlinux + modules)
-	   --- 6.2 Symbols and External Modules
-	   --- 6.3 Symbols From Another External Module
-	=== 7. Tips & Tricks
-	   --- 7.1 Testing for CONFIG_FOO_BAR
-
-
-
 1. Introduction
 ===============
 
-- 
2.43.0


