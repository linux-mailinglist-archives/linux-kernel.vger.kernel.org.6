Return-Path: <linux-kernel+bounces-444342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9D59F050D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 07:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95B73188AB9E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 06:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C38C18E02A;
	Fri, 13 Dec 2024 06:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yj1zfxS/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A4817AE1C;
	Fri, 13 Dec 2024 06:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734072603; cv=none; b=UjvOprQjp9VGYqkFrFRkJ37NyGhZulixc8xgqer+oF+LM0Clz/6eBPhb1b4+kx8TiPF9NZujaxqEGY/1oYEJxG958yqo3DqofOK3tCDdNvta9rASuwukyNUPpte0+gO34rQEGa7ikwX6FnP0mssbmY+4wyq5hCj1Cti7rz08DQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734072603; c=relaxed/simple;
	bh=ILB1AQhxZxkrT/5SN0ocegPLdyqkjoxaxc+zKVA2eFY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FZCZCNUZzu2k0KzMcJw8KWLzaL5cyOjugggsi0wZnybtvObMOv9lsUSrnxqO5Ic9N7VeZBkpkJFMowR/H7usHZGFQ/j1h4tBb1TGReL1zURnShzsy/c3zl3+UI5Rte6dXRl+OO6i+cXL8/3qvkqov4O1NPzxGktsRvUvlfjvlNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yj1zfxS/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB132C4CED0;
	Fri, 13 Dec 2024 06:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734072603;
	bh=ILB1AQhxZxkrT/5SN0ocegPLdyqkjoxaxc+zKVA2eFY=;
	h=From:To:Cc:Subject:Date:From;
	b=Yj1zfxS/MWR9X39IH29D+TMwR7HcZ+vaGv35tSpzubXqhuTpdECYUe58neZi9Kwkc
	 kJUsoEvU0NVvCGj+Lj7DAFbKrXhSuMx3lSw5SvupVh98LZJ5vz1+NmECJXHmM5M0qd
	 Do6LUHYTm+TVPrzUBfBmbL+HKkF3u9ekqlp10CcB6Qn3YyhKnB8XS9HammL0ra5gPE
	 V3hIJArljAsYbsvn7OxPg93+DRwBrcc6PUeIal6kp0cP+gzTRBxgG8u8RqWW67dPb1
	 nLKuaXUKZoLqg6012cobLTr6J/eHfESB5gxf/1gx3q1iDBBe1AdRzt4gslawpr20xL
	 msPmC7Y03sqvw==
From: Arnd Bergmann <arnd@kernel.org>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Nathan Chancellor <nathan@kernel.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] staging: gpib: fix pcmcia dependencies
Date: Fri, 13 Dec 2024 07:49:49 +0100
Message-Id: <20241213064959.1045243-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

With CONFIG_PCMCIA=m, the gpib drivers that optionally support PCMCIA
cannot be built-in.

Add a Kconfig dependency to force these to be loadable modules as
well, and change the GPIB_PCMCIA symbol to have the correct state
for that.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/gpib/Kconfig | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/gpib/Kconfig b/drivers/staging/gpib/Kconfig
index 259f3ff33646..275dbc32b28d 100644
--- a/drivers/staging/gpib/Kconfig
+++ b/drivers/staging/gpib/Kconfig
@@ -65,6 +65,7 @@ config GPIB_NI_PCI_ISA
 	depends on ISA_BUS || PCI || PCMCIA
 	depends on HAS_IOPORT
 	depends on !X86_PAE
+	depends on PCMCIA || !PCMCIA
 	select GPIB_COMMON
 	select GPIB_NEC7210
 	help
@@ -89,6 +90,7 @@ config GPIB_CB7210
 	depends on HAS_IOPORT
 	depends on ISA_BUS || PCI || PCMCIA
 	depends on !X86_PAE
+	depends on PCMCIA || !PCMCIA
        select GPIB_COMMON
 	select GPIB_NEC7210
        help
@@ -177,6 +179,7 @@ config GPIB_HP82341
 config GPIB_INES
        tristate "INES"
 	depends on PCI || ISA_BUS || PCMCIA
+	depends on PCMCIA || !PCMCIA
 	depends on HAS_IOPORT
 	depends on !X86_PAE
        select GPIB_COMMON
@@ -199,8 +202,8 @@ config GPIB_INES
 	  called cb7210.
 
 config GPIB_PCMCIA
-       bool "PCMCIA/Cardbus support for NI MC and Ines boards"
-       depends on PCCARD && (GPIB_NI_PCI_ISA || GPIB_CB7210 || GPIB_INES)
+       def_bool y
+       depends on PCMCIA && (GPIB_NI_PCI_ISA || GPIB_CB7210 || GPIB_INES)
        help
          Enable PCMCIA/CArdbus support for National Instruments,
 	 measurement computing boards and Ines boards.
-- 
2.39.5


