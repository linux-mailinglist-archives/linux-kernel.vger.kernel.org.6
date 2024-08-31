Return-Path: <linux-kernel+bounces-309820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E199670B5
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 12:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F367FB2104C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 10:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B2B17B4FE;
	Sat, 31 Aug 2024 10:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgG9p/vk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D51713A27E
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725099058; cv=none; b=Hb9hsRpwogxfGMnmUEFx5/Y0JjYtzPuJxihJxn5z79fqnzjRo+knro25SZzYdv52WmYvd6Dhwen9SrkSqyI4jRc9Z0I2fXxR72valEACZqdamHNzK/AA6Qi4hXCdn+uaTef++t3St557Hi7289rsY2BRHBPEARnjOW7EDZm5njE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725099058; c=relaxed/simple;
	bh=ENYPBa+mfsr5L1+d7LCfa9JspPswURc8zoi7eWZUPAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k+uQ/TAjcJvIM05JEUvdXdD0gN8LLMTCiKu8n/6njRp0AJEyoIh2aQ/OYEkHapUkG+FiKP5gamEp4sglAsycD9csq/viXSx45qzMkRkXBezaIOFXITvUTlgKDgMq42caneuCzTETH4Q917pJR74+ROXuk1PAlSGYA5gU4hUSPEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgG9p/vk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1985CC4CEC0;
	Sat, 31 Aug 2024 10:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725099058;
	bh=ENYPBa+mfsr5L1+d7LCfa9JspPswURc8zoi7eWZUPAY=;
	h=From:To:Cc:Subject:Date:From;
	b=GgG9p/vkn3pFQoUD12/y+1Rml1JtTk5aa/Pgqk9YZuBEMFrKgkax3ondaUK382N/O
	 n7uDQLcvdPaSMCp40TGrrXmYiZTRmZeIt1soM8g6QNF5n28eY3RSm3WfH6/FH5kLMk
	 5Stdc05rARGhTkrKs24G+gv5FbE63Se8aL/2fEg8Q5X8QQEXztzd7IV8ChqyG1cLge
	 n46+sbN09wpnnHx8xnqcGU6uNHSotPvuIxIhp4dv76ELcTZsR6qXydD3q6TWPHarGJ
	 7BPrCgt/N977FA/7V6CJBFJKjNVoeQEanInF/SSL1fVG6sp6SQ0mTjsEJwrwdCQ/tD
	 uKjn+Jko1qemQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Vineet Gupta <vgupta@kernel.org>,
	linux-snps-arc@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] ARC: update the help message for CONFIG_ARC_BUILTIN_DTB_NAME
Date: Sat, 31 Aug 2024 19:10:28 +0900
Message-ID: <20240831101045.1381258-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit abe11ddea1d7 ("ARC: [plat-arcfpga]: Enabling DeviceTree for
Angel4 board") changed the default built-in DTB from "skeleton" to
"angel4".

Commit fd1557923b2e ("ARC: [plat_arcfpga]->[plat_sim]") changed it
from "angel4" to "nsim_70".

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/arc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index fd0b0a0d4686..d01e69a29b69 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -553,7 +553,7 @@ config ARC_BUILTIN_DTB_NAME
 	string "Built in DTB"
 	help
 	  Set the name of the DTB to embed in the vmlinux binary
-	  Leaving it blank selects the minimal "skeleton" dtb
+	  Leaving it blank selects the "nsim_700" dtb.
 
 endmenu	 # "ARC Architecture Configuration"
 
-- 
2.43.0


