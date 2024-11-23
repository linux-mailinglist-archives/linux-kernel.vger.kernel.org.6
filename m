Return-Path: <linux-kernel+bounces-419250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9456D9D6B57
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 21:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47F34282000
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 20:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8001C14EC47;
	Sat, 23 Nov 2024 20:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISVv6ieq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE99EADC;
	Sat, 23 Nov 2024 20:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732392220; cv=none; b=Xg6xJeJ9DRkywwoYqiRJMzMwMA6LfCMpjcXXNoMkFSorRgaKFAKuLtLH5awbPnW7IGTtJdNL3GtjGdZ1mVNULznQTRcAfA0zjuK1wgJID/RWkwXJGUR6+tEiKCYaBLmgfVGomSUW7nbz/LSLNhebDyJ62Dj6hQyCEwzYf3f0jpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732392220; c=relaxed/simple;
	bh=awX1OHgdqsxsHC3kU5IcFhrvdjajWLHd4mnWWIWjVM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Fd8CSBRJzfgRabin++uxNwP514ALpoL14VCkt3ugDkQE/vsgzmkxP5gJbCj8QRn+RSZBXmlTlnjLD+c3QpXlUN8VN4MFwNy/hOBWVfKjNLc4M9zAT+IkgwkDL8CsDDuSS+OAaEPNF2Sf1/U/pRq7vnlnLq+U3f2biJ8Y6oAiAiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISVv6ieq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111E0C4CECD;
	Sat, 23 Nov 2024 20:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732392219;
	bh=awX1OHgdqsxsHC3kU5IcFhrvdjajWLHd4mnWWIWjVM4=;
	h=From:Date:Subject:To:Cc:From;
	b=ISVv6ieqm/cuXatmH24O4oeGMpbRkgIXj/sg9WC+froq7CMPaE6Jzc0s+O9ZgXWtj
	 qKLF0UUNR6NYTevejyQJ57ZoN6JnhlWwioZcIi0ppftJ76EptHxfzBTcMzsc5IRaYw
	 HNvCc9/jXHVaJNEkKZ4E/kfd8RR/luHTRy061VuzI8flPDK2soZ8cQRA2WG/v+1us8
	 l0siS5VUAap6D9fGc/oMuLWSglcHcmQJPfc4TbHRFW0PTIU4LpInHpRdi70/IVXbDq
	 8gzisVMmGBhz7SUC8trpVauh/Lhy4a1wvv+1bqMT2aOxTq+rnePczy9gL1Dfa4XQno
	 BOPdnIf6gsjhg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Sat, 23 Nov 2024 13:03:25 -0700
Subject: [PATCH] staging: gpib: Make GPIB_NI_PCI_ISA depend on HAS_IOPORT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241123-gpib-tnt4882-depends-on-has_ioport-v1-1-033c58b64751@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAw1QmcC/x3NwQrCMAyA4VcZORuwsZPhq4hIt2RbLmlpighj7
 27x+F3+/wCXquLwGA6o8lHXbB3hMsCyJ9sElbuBrhRDoBtuRWds1uI0EbIUMXbMhnvyt+aSa8O
 ZmSLfZUyyQA+VKqt+/5Pn6zx/W8aW5XQAAAA=
X-Change-ID: 20241123-gpib-tnt4882-depends-on-has_ioport-bdd24d6e5aec
To: Dave Penkler <dpenkler@gmail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1735; i=nathan@kernel.org;
 h=from:subject:message-id; bh=awX1OHgdqsxsHC3kU5IcFhrvdjajWLHd4mnWWIWjVM4=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDOlOplKzz33ilJr9wNL9XMLJebJ2M7IvduaEGGqWWn1M+
 5F1XM6so5SFQYyLQVZMkaX6sepxQ8M5ZxlvnJoEM4eVCWQIAxenAEyk8hMjw+VDB4OqAtll/S4x
 KrAfCY7frbWz63Cup8+M85cFEr5N/cnI0H3OdGOItyYnT+qxye/bLHdP/PXT+d+3Lxdvhv046iT
 WyAgA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After commit 78ecb0375685 ("staging: gpib: make port I/O code
conditional"), building tnt4882.ko on platforms without HAS_IOPORT (such
as hexagon and s390) fails with:

  ERROR: modpost: "inb_wrapper" [drivers/staging/gpib/tnt4882/tnt4882.ko] undefined!
  ERROR: modpost: "inw_wrapper" [drivers/staging/gpib/tnt4882/tnt4882.ko] undefined!
  ERROR: modpost: "nec7210_locking_ioport_write_byte" [drivers/staging/gpib/tnt4882/tnt4882.ko] undefined!
  ERROR: modpost: "nec7210_locking_ioport_read_byte" [drivers/staging/gpib/tnt4882/tnt4882.ko] undefined!
  ERROR: modpost: "outb_wrapper" [drivers/staging/gpib/tnt4882/tnt4882.ko] undefined!
  ERROR: modpost: "outw_wrapper" [drivers/staging/gpib/tnt4882/tnt4882.ko] undefined!

Only allow tnt4882.ko to be built when CONFIG_HAS_IOPORT is set to avoid
this build failure, as this driver unconditionally needs it.

Fixes: 78ecb0375685 ("staging: gpib: make port I/O code conditional")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/staging/gpib/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/gpib/Kconfig b/drivers/staging/gpib/Kconfig
index 95308d15a55516de9118e7ae90a6103ee8c6c003..9ee4323164654916e7ed49190eaf5bb02ce7f045 100644
--- a/drivers/staging/gpib/Kconfig
+++ b/drivers/staging/gpib/Kconfig
@@ -62,6 +62,7 @@ config GPIB_CEC_PCI
 config GPIB_NI_PCI_ISA
 	tristate "NI PCI/ISA compatible boards"
 	depends on ISA_BUS || PCI || PCMCIA
+	depends on HAS_IOPORT
 	select GPIB_COMMON
 	select GPIB_NEC7210
 	help

---
base-commit: 114eae3c9fde35220cca623840817a740a2eb7b3
change-id: 20241123-gpib-tnt4882-depends-on-has_ioport-bdd24d6e5aec

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


