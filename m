Return-Path: <linux-kernel+bounces-332233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1A797B70E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 05:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEDFF1F21653
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 03:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B26139D09;
	Wed, 18 Sep 2024 03:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFIjCi2s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0941282E5
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 03:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726629343; cv=none; b=nhaqrPmmgaKBw5nxihFWaFB0sU5ZeeBB46Q7L8ufb3is9e82WEgQot5SDI20xjy2BnZ9dhtNKfR4yPFHBd8+UFwCdsPfej8ksdJMaouZ0vhnQ6Jp2VujfZtfVaWVNsSs+vn16AjA9mhA9hPDrvdimAnQG8zx1Qw0i8XLk94aOGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726629343; c=relaxed/simple;
	bh=jbAlT+6F9gOa2OphJ+w80G9qShOjt07teyAPbMdfNfg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oFpXMCT6eFnfEmHXEcVn0jOknT1pUzOkpcDL3bbzHsceVAx4EIYz8L71c3fYl3BPNGtTDEXEZ7FK56xEsNf3gHS6bRb9PUNiDn9jtqoNYNk1v/cMlQ7YpxMW6LgunW+33DKkwLm8k/HjAFbC7G48DXdvcGSWjS8sPUYhkASyTgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFIjCi2s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43635C4CEC3;
	Wed, 18 Sep 2024 03:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726629343;
	bh=jbAlT+6F9gOa2OphJ+w80G9qShOjt07teyAPbMdfNfg=;
	h=From:To:Cc:Subject:Date:From;
	b=CFIjCi2s4giGgRAuQ+LhQtj0d4kX1F7T7JNtL7A+DCNEUkPFXQz7gBu6ijNB9ZaiY
	 vkO5ufbhx+1nDu6pwupH7Pypp5J7kbErrzfX7+mc0IjvLYv1WsHUNjd31GJwjo37lo
	 94kJqRPDRaBBurQbbMldWC3LzwHpPuzpD7onExaODKNcNp04X43MkgZusts2TfcMuL
	 4QepOujfcbbh52ees54EI5uwBWJJV57XNerF7Slji6+IC5vmV5LldFGDrw7v7EFM17
	 Zhoyn5HtC4tqnZMNqH/LT0YwSJJfThEqdTXMctBq4X9/yNduDYGoiHnPUWCp4/94y7
	 082cjvNka9+Eg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kernel@vger.kernel.org,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] xtensa: annotate dtb_start variable as static __initdata
Date: Wed, 18 Sep 2024 12:15:34 +0900
Message-ID: <20240918031537.588965-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'dtb_start' variable is only used within arch/xtensa/kernel/setup.c.
Mark it as 'static'.

It is only used by parse_tag_fdt() and init_arch(), both of which are
annotated as __init. Therefore, dtb_start can be annotated as __initdata,
so it will discarded after boot.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/xtensa/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index bdec4a773af0..3e076b64cc61 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -55,7 +55,7 @@ extern int initrd_below_start_ok;
 #endif
 
 #ifdef CONFIG_USE_OF
-void *dtb_start = __dtb_start;
+static void *dtb_start __initdata = __dtb_start;
 #endif
 
 extern unsigned long loops_per_jiffy;
-- 
2.43.0


