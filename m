Return-Path: <linux-kernel+bounces-207225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C71901422
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 03:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55BB4281E85
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 01:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9574C79;
	Sun,  9 Jun 2024 01:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qI1m1mCh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C33360;
	Sun,  9 Jun 2024 01:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717896441; cv=none; b=QlCKukF90P9osDUDyxItyc3fHhbWLmVjt1JUMDcVQ91pa25JJEbd/1W0LvcdXU84LBkp9cfoc3+w1esh0Lb2yEpbjMmHKPaKPfqDAbHyl1W7EQG3Dp+cjLaYmalPLRfjzIJTk4nBSK8pVwR5SuCoX0mO2CHFPyQIYVnJj0S+V5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717896441; c=relaxed/simple;
	bh=6sl0ZI6qGZzRme/1+79bRsWchE453bSArJoTsSrkLV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GsSdsPN7rbhofsysfZDIB/RhABA2mcoo1zb1w0ANUZviYc4vRIhJLJuDHBmXlUAYLAixhtlMgopO/K91I2nn1oduFQ/fLe43yEC+ePlN0enO9E3NlmN4kCUuE4o80rCprAowBtAW4IEw1CXeRB3kY9LqN9PO/01gMzUvQC2GppA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qI1m1mCh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A56DC2BD11;
	Sun,  9 Jun 2024 01:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717896440;
	bh=6sl0ZI6qGZzRme/1+79bRsWchE453bSArJoTsSrkLV8=;
	h=From:To:Cc:Subject:Date:From;
	b=qI1m1mChsBBXCMYPrz83KBIxYo8pdVn3C21dc3HrzmLX9OTjIJ74GhDPuOy01VI1e
	 l320XL3fQ8os1aIIU3BO9R7w/tj5yYZaxJ5LFt8lIICmFEh4ILcKysji9LRyZE1wUQ
	 RrEN4VhleT3OL/wqDFzaUhG9TEMDPkUzOTPWucPCd6HxQzw1GV6hdG/mqriUsSBSI7
	 4yjo/QZPaBAiBizEZoV42qRGbXIdoCl2AiR7crymAcCB8cWCH2qJRNI9UcFhBPaGgT
	 bR3clRSEvCtn+XIfIkSK0HkUuFByizeKc76zAE2+5qolfQqWU83qQCaFrfSSaaDZZV
	 95EbwlrjNMhTA==
From: Stephen Boyd <sboyd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v6.10-rc2
Date: Sat,  8 Jun 2024 18:27:18 -0700
Message-ID: <20240609012719.1748309-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 2607133196c35f31892ee199ce7ffa717bea4ad1:

  clk: sifive: Do not register clkdevs for PRCI clocks (2024-05-29 12:31:02 -0700)

----------------------------------------------------------------
One fix for the SiFive PRCI clocks so that the device boots again. This
driver was registering clkdev lookups that were always going to be
useless. This wasn't a problem until clkdev started returning an error
in these cases, causing this driver to fail probe, and thus boot to fail
because clks are essential for most drivers. The fix is simple, don't
use clkdev because this is a DT based system where clkdev isn't used.

----------------------------------------------------------------
Samuel Holland (1):
      clk: sifive: Do not register clkdevs for PRCI clocks

 drivers/clk/sifive/sifive-prci.c | 8 --------
 1 file changed, 8 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

