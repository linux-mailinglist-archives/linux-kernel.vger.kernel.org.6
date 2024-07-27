Return-Path: <linux-kernel+bounces-264163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16A193DFA7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 16:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1A161C20DFD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 14:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D27C16F27B;
	Sat, 27 Jul 2024 14:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7HA93Qu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C454C9B;
	Sat, 27 Jul 2024 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722088986; cv=none; b=h+LRyIe59ioQcSVGjstDg0Ka+Z5x4pzxeVQWcSu2vvVuTexBvusYlZNhmFh4iPxxzgFScR3VepDKQcQdm1R6cU2+cf7+KRK/B4FxOuSW70uaDEZZX/mwkhPrVrbsi3Ape9+w7/23yX+ahtRvWr7Ov4IM7HXs7VNj9+cc/ZW+MY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722088986; c=relaxed/simple;
	bh=JlnARo1+2U7ZszBtmY5wjUSRQZ/RtDlKPPT+ppYwIw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PlQOLOvvyw+UopWpORvF+aHMfC4lORPWOXDa3LUBiHZJbqB4hIIR/eFzztex8h8np0sRHVYnKSw3HW3DZ9wttuK38bB6jt6r413zJetpk+CiWDeJlahfp8Jef8bTEcJKhk96H3TIXKQ1+ftcvcefm6/FmkFIsiExwEj1kOq4ouY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7HA93Qu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34FDC32781;
	Sat, 27 Jul 2024 14:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722088985;
	bh=JlnARo1+2U7ZszBtmY5wjUSRQZ/RtDlKPPT+ppYwIw8=;
	h=From:To:Cc:Subject:Date:From;
	b=X7HA93QuqjeF6WxmFyecnL5Gunp+TQuk+NEAoJeU6jJ3UkYGq/5Jt8+64P1/aTgfK
	 WvCyuN8EuYC2VAk029XG7zLoFsI9irgk/Xavh12J4UyLbn8pJueLCNV0wsaoi9JrfW
	 uK4U1O6b05HB4ve027W9TYHSQIyjcCpelDZvZbkQwG7VAi7yfNutR96Vf0EKivZk+Y
	 o2AhhYpxjzceJQsmRf8BmOe5R60u8RxmIaCfu1mRbX6hFMwTCiF4ivI6a5QhmZ8VY4
	 fuVrvXOeOU8daW0cnSxgJJnzJiBQssLFHVoo6tP5fQW3EmtaZec+w0ORjStcco4CQI
	 T6Dn1h7tJbsqw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/2] rust: suppress error messages from CONFIG_{RUSTC,BINDGEN}_VERSION_TEXT
Date: Sat, 27 Jul 2024 23:02:59 +0900
Message-ID: <20240727140302.1806011-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While this is a somewhat unusual case, I encountered odd error messages
when I ran Kconfig in a foreign architecture chroot.

  $ make allmodconfig
  sh: 1: rustc: not found
  sh: 1: bindgen: not found
  #
  # configuration written to .config
  #

The successful execution of 'command -v rustc' does not necessarily mean
that 'rustc --version' will succeed.

  $ sh -c 'command -v rustc'
  /home/masahiro/.cargo/bin/rustc
  $ sh -c 'rustc --version'
  sh: 1: rustc: not found

Here, 'rustc' is built for x86, and I ran it in an arm64 system.

The current code:

  command -v $(RUSTC) >/dev/null 2>&1 && $(RUSTC) --version || echo n

can be turned into:

  command -v $(RUSTC) >/dev/null 2>&1 && $(RUSTC) --version 2>/dev/null || echo n

However, I did not understand the necessity of 'command -v $(RUSTC)'.

I simplified it to:

  $(RUSTC) --version 2>/dev/null || echo n

Fixes: 2f7ab1267dc9 ("Kbuild: add Rust support")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 init/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index c41260ffe99a..466849f9f1b9 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1919,12 +1919,12 @@ config RUST
 config RUSTC_VERSION_TEXT
 	string
 	depends on RUST
-	default $(shell,command -v $(RUSTC) >/dev/null 2>&1 && $(RUSTC) --version || echo n)
+	default $(shell,$(RUSTC) --version 2>/dev/null || echo n)
 
 config BINDGEN_VERSION_TEXT
 	string
 	depends on RUST
-	default $(shell,command -v $(BINDGEN) >/dev/null 2>&1 && $(BINDGEN) --version || echo n)
+	default $(shell,$(BINDGEN) --version 2>/dev/null || echo n)
 
 #
 # Place an empty function call at each tracepoint site. Can be
-- 
2.43.0


