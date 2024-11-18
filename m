Return-Path: <linux-kernel+bounces-413422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC1A9D18D9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 20:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4822B1F21C11
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 19:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC6C1E4919;
	Mon, 18 Nov 2024 19:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="HZ+7KNbZ"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB641E0DFC;
	Mon, 18 Nov 2024 19:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731957978; cv=none; b=Uxmzaszntv940lnE/b8SAaDv86mr0hR6q21V2rYtFhytaipQWca9fbPt2nHM789L1r69VkfxAQGZ8DJaLFBiBGYoKN0EEZXFt/cSbOLpgPBqX6g71fKINrHQhIAKWSKUdZsnLLQth2zOo5PtguKC6JpWD2ny2vUZxX8yfkHBDv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731957978; c=relaxed/simple;
	bh=/kpCaNpWSefaUOtO8wO0x3ZwJqhUXDDfTytqZYILjYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RTEiLZXcA3BIOD37zDo1ACjuWlT0b04qO1vidorpwCCEkxyIcj0QsfnzLN1yrnJRHBBYzQUWSfD391QX2v0MmV7QpEEre6kEq5Nph5A1ow05HKGC3cfXuTJia7KhTR+wQ9XSMntZMDvZq6XmHOOIliocQvaFDLfkIXm+xhzmRm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=HZ+7KNbZ; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 1633F2523D;
	Mon, 18 Nov 2024 20:26:13 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7PIE06jNsvOy; Mon, 18 Nov 2024 20:26:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1731957972; bh=/kpCaNpWSefaUOtO8wO0x3ZwJqhUXDDfTytqZYILjYI=;
	h=From:To:Cc:Subject:Date;
	b=HZ+7KNbZuciHfqIRHm6J20HHExa69IOA/9P2Nj55VC2MTk8JiUcAKs8pPCSLs3K2q
	 aXy3z21plgViAP20OypA7vAlbDRDOSvpHL2bG2zavukWyJ4A1s1dCrpgPUQZ/eXb6d
	 iNKlKbj9pxBtJ3Hdo7FkzLaXUioLwSm3yyTUHxpzl5adQoCON2uAD3NruK6D5Fwmcj
	 UTo0ghh7W32tj2Niq7nHpK0fUQcdSoNcGdh+YQUDpplt0OGWqJUS0nGkd0Gag5awgc
	 gdnLP/tcaQ1CHe4xIWM6MZt9SktJF5RDeSDZHX5A49D41IMjnNT6a93A5ajtc/0l6g
	 7Ygp+XAaiX1Ag==
From: Yao Zi <ziyao@disroot.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Yao Zi <ziyao@disroot.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: clk: describe userspace debugging facilities
Date: Mon, 18 Nov 2024 19:25:27 +0000
Message-ID: <20241118192526.44180-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Starting from commit
03111b1088f1 ("clk: Add support for enabling/disabling clocks from debugfs"),
it's possible to operate clocks from userspace through debugfs for
testing purpose. This feature isn't provided as a Kconfig but rather a
macro in source for security consideration, thus is hard to find.

Let's document the macro to ease everyone's life of clock debugging.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 Documentation/driver-api/clk.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/driver-api/clk.rst b/Documentation/driver-api/clk.rst
index 93bab5336dfd..1787c07e8e19 100644
--- a/Documentation/driver-api/clk.rst
+++ b/Documentation/driver-api/clk.rst
@@ -310,3 +310,11 @@ driver in that case.
 Note that locking must also be considered when code outside of the common
 clock framework needs to access resources used by the clock operations. This
 is considered out of scope of this document.
+
+Debug in Userspace
+==================
+
+The common clk framework creates read-only debugfs entries at
+``/sys/kernel/debug/clk``. For test and debug purpose, you could define
+``CLOCK_ALLOW_WRITE_DEBUGFS`` in ``drivers/clk/clk.c`` to make them writable.
+This may cause security problems and should *NEVER* be enabled on production.
-- 
2.47.0


