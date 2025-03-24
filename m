Return-Path: <linux-kernel+bounces-574503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3730A6E608
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D884175056
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15DF1F461F;
	Mon, 24 Mar 2025 21:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdlJUBGC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04BB1EFFBE
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 21:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853390; cv=none; b=iqmvEi2CLwO5w6weHayu3pxVAhgSxcDEc0aimv9DuxdGF1OYzl34mr2n49R4a7J4n3uHFpDuXzl6hTN/ZfwMjnjuHuPGR7x0CWBG+XkVhX4BTAJvo6KJ/HDb1hphRswCAhEFha32ugBmhsMRjiVKUhPHpDKLwBeMuR/lhWUc3s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853390; c=relaxed/simple;
	bh=Q+oJTrzDRTBEawN/MRBhV9wQOgT+O+sJjJHoqlU0wrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/UxirjXHYK90qxMRvKHSeiZzdvCujnbYIo1eFYsjQvAI4kGU6cg8qCzxJfm6Ul3XSk7HLmcup/fwLJHumID/BVNw7edSsk9E1H1kgspj7JFrj22y7TwXcCorVkehutdj4T0/I8LctBVCbEgsHY/gCpDT3H7QD8bosxmznjFq0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdlJUBGC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C7DC4CEE4;
	Mon, 24 Mar 2025 21:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742853389;
	bh=Q+oJTrzDRTBEawN/MRBhV9wQOgT+O+sJjJHoqlU0wrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JdlJUBGC7nJY13FX8KAoHeCJzDqXlWMfA1arSy34IJVcDfKlg4I2DWugoHUgPNLX4
	 Nbe1koZexCG4oYN0Vls8wJdyWL0JMHzkpMCKmkFYAeEV68K/IbQ4zpYtIL+2uL16mZ
	 EtIExeCLzVNAnf7YlZCf+aIOWdhu9zhZp4ZoI3An4nRbFwEEWNyMk+trkS1hq4RWPf
	 hQBgnye80opoAkCQRsOlNykXRhtydVaYWXeaCMvtRd137ORbVYqZK3p1n/enXW4sLc
	 5knYyL1ttM6CGGVkG6Jgzwlpu6r93YnkyMpuxUVkDgAiZcgGmvbx57fhiDIHkFFlbM
	 /xamqj8TeA8ZQ==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 18/22] Input: cyapa - remove undefined behavior in cyapa_update_fw_store()
Date: Mon, 24 Mar 2025 14:56:08 -0700
Message-ID: <73ae0bb3c656735890d914b74c9d6bb40c25d3cd.1742852847.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742852846.git.jpoimboe@kernel.org>
References: <cover.1742852846.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In cyapa_update_fw_store(), if count is zero, the write to
fw_name[count-1] underflows the array.

Presumably that's not possible in normal operation, as its caller
sysfs_kf_write() already checks for zero.  Regardless it's a good idea
to check for the error explicitly and avoid undefined behavior.

Fixes the following warning with an UBSAN kernel:

  vmlinux.o: warning: objtool: .text.cyapa_update_fw_store: unexpected end of section

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503171547.LlCTJLQL-lkp@intel.com/
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 drivers/input/mouse/cyapa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
index 2f2d925a55d7..00c87c0532a6 100644
--- a/drivers/input/mouse/cyapa.c
+++ b/drivers/input/mouse/cyapa.c
@@ -1080,8 +1080,8 @@ static ssize_t cyapa_update_fw_store(struct device *dev,
 	char fw_name[NAME_MAX];
 	int ret, error;
 
-	if (count >= NAME_MAX) {
-		dev_err(dev, "File name too long\n");
+	if (!count || count >= NAME_MAX) {
+		dev_err(dev, "Bad file name size\n");
 		return -EINVAL;
 	}
 
-- 
2.48.1


