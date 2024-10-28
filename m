Return-Path: <linux-kernel+bounces-385394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4479B36A1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09771C22124
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2951DEFD3;
	Mon, 28 Oct 2024 16:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anMVQLCM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C611C1DED59;
	Mon, 28 Oct 2024 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133360; cv=none; b=pQ0C2VymP6UrVuTbr6BAqidR2yVljzQwH4QiuhEzD8jhIFlheQhrAyuIRgzUFONUbvaHNItityb6q2eIno3YTMgigmPDNbIB+lUfIqYvvA3VT941ZzUKHA6sW0h7YF2J6+kacuuo73u2Dg7WOS1bdHMEnlWr6VefpC5i6GImBUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133360; c=relaxed/simple;
	bh=xdGiQWMlOc2GWNr8BFQjy6F7f2VQLFtCYg1i3syZ90k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cshm2e0fRAVeuj045IaF/7dUFvyS+ntfWxN1bxaWx/SCbkJZG2vZLvnhfXfzw20mTHpnqulHr0iVDBo24d0UqWaCiUpHuOyTiv5hsXQ5H+8cbu+KOBcJgs3cRXzg2S2OrJ98quza6K9GSx7e6v2yvFtaGgvT6O6NcaOTmFrrvHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anMVQLCM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE1AC4CEC3;
	Mon, 28 Oct 2024 16:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730133360;
	bh=xdGiQWMlOc2GWNr8BFQjy6F7f2VQLFtCYg1i3syZ90k=;
	h=From:To:Cc:Subject:Date:From;
	b=anMVQLCMntblLAEq/unrqH4pRumPIY59wMltOSYs/pD8k7zbxBjv4QO8VMmAIsTNt
	 sDJpoE7/IgaN19QpESr5S67BnhDWJow4DKA8IE6U15/wNpP9LLFxsgjJMUzEkQm21+
	 a/yinuejQA5PekFq3O6+9egw6Cg43IzO5LSJLb/gK/G+EWRk6oPeskkIDb+SQOBPVN
	 pLqYrGTsd+HGZfHe/T3bfO/q4r4VNx0cfT7zCY8whsdsKwwqdYUiC75oa4xGtZgy/T
	 OCorWtquqN33W3JENMFP+Qlb19OpM1xjKUdZKt3DI+rgXby2ahvZprYl/kUTU8bJ5+
	 18rYNMUwSZZHg==
From: Arnd Bergmann <arnd@kernel.org>
To: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Suma Hegde <suma.hegde@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Carlos Bilbao <carlos.bilbao.osdev@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86/amd/hsmp: mark hsmp_msg_desc_table[] as maybe_unused
Date: Mon, 28 Oct 2024 16:35:46 +0000
Message-Id: <20241028163553.2452486-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

After the file got split, there are now W=1 warnings for users that
include it without referencing hsmp_msg_desc_table:

In file included from arch/x86/include/asm/amd_hsmp.h:6,
                 from drivers/platform/x86/amd/hsmp/plat.c:12:
arch/x86/include/uapi/asm/amd_hsmp.h:91:35: error: 'hsmp_msg_desc_table' defined but not used [-Werror=unused-const-variable=]
   91 | static const struct hsmp_msg_desc hsmp_msg_desc_table[] = {
      |                                   ^~~~~~~~~~~~~~~~~~~

Mark it as __attribute__((maybe_unused)) to shut up the warning but
keep it in the file in case it is used from userland. The __maybe_unused
shorthand unfurtunately isn't available in userspace, so this has to
be the long form.

Fixes: e47c018a0ee6 ("platform/x86/amd/hsmp: Move platform device specific code to plat.c")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Ideally this array wouldn't be part of the UAPI at all, since it is
not really a interface, but it's hard to know what part  of the header
is actually used outside of the kernel.
---
 arch/x86/include/uapi/asm/amd_hsmp.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/amd_hsmp.h b/arch/x86/include/uapi/asm/amd_hsmp.h
index e5d182c7373c..4a7cace06204 100644
--- a/arch/x86/include/uapi/asm/amd_hsmp.h
+++ b/arch/x86/include/uapi/asm/amd_hsmp.h
@@ -88,7 +88,8 @@ struct hsmp_msg_desc {
  *
  * Not supported messages would return -ENOMSG.
  */
-static const struct hsmp_msg_desc hsmp_msg_desc_table[] = {
+static const struct hsmp_msg_desc hsmp_msg_desc_table[]
+				__attribute__((unused)) = {
 	/* RESERVED */
 	{0, 0, HSMP_RSVD},
 
-- 
2.39.5


