Return-Path: <linux-kernel+bounces-574500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1327A6E604
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8939B1891A72
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22AF71F4169;
	Mon, 24 Mar 2025 21:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3ogsvDr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EB71F3D31
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 21:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853388; cv=none; b=UAbUgBOk5pj4oYWAr/tebs4HE7saVjlB22kXhIWBJlLQZAWs9qTa5TW39l0aKzSciBpku5NNtBtW6VyXjj3auzO7Btgzu65ybOL/v6Q/neh6xp1sQOFitbOlasHEQct46T1S53/0Rn+m/mmW6qn2kuG/yG76ZqOy3fN3T67Y+i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853388; c=relaxed/simple;
	bh=eR7/QObM3jTZYr0HPhlYeu90wXJiFEcy1CoDJ5gLsqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8FoujO3oNRgMkqYEqu5X7K8IMu5YdqYiC0GUl29QWpc2LMduNEqfA8ytbBGuFfZa4eh5Jnvy/AbUmUb6JFowOVZ3REWvZ6oG5qwsx3ihfWbg06hEtR2MDPcGgJtS7NGwTKfXMHB1ONSM/GjqoySVlfBBsDGZ5UF/iC4McQUoz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3ogsvDr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DD3C4CEDD;
	Mon, 24 Mar 2025 21:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742853388;
	bh=eR7/QObM3jTZYr0HPhlYeu90wXJiFEcy1CoDJ5gLsqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y3ogsvDrD+H4FnJ051NMhJZsEcDl+n8psooSbTSCzIvh4X6WH0u5HCWIu3G+NKWQA
	 icIjsHuq2PqzOilR++sf3oHMQ0UIxLYmQRPAPonf555qDXh6Vnb37ZCBqHt7yd0LSw
	 ITB/rC5KLyMQumZB7WgPNsFqjOSMOHDVR88NnZB92wpUvUsOjncRPKfIo8Y3PoecqX
	 9k+e+HqJ0oiMyR9uMf97xrRzcq3qNY5Us/b9HxY/Xgj9z/Johk7v3zxZF1GVG2Xbf9
	 3fuVTrhtMsY+KmeHfz2lZjyU3xOf07oSadYd+KGDArNqeeA6GxaggfgRK0y86CT3U1
	 Vd0F1Cw82TPiA==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Brendan Jackman <jackmanb@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 15/22] nvmet: Fix out-of-bounds stack access in nvmet_ctrl_state_show()
Date: Mon, 24 Mar 2025 14:56:05 -0700
Message-ID: <f1f60858ee7a941863dc7f5506c540cb9f97b5f6.1742852847.git.jpoimboe@kernel.org>
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

The csts_state_names array only has six sparse entries, but the
iteration code in nvmet_ctrl_state_show() iterates seven, resulting in a
potential out-of-bounds stack read.  Fix that.

Fixes the following warning with an UBSAN kernel:

  vmlinux.o: warning: objtool: .text.nvmet_ctrl_state_show: unexpected end of section

Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Fixes: 649fd41420a8 ("nvmet: add debugfs support")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503171547.LlCTJLQL-lkp@intel.com/
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 drivers/nvme/target/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.c
index 220c7391fc19..c6571fbd35e3 100644
--- a/drivers/nvme/target/debugfs.c
+++ b/drivers/nvme/target/debugfs.c
@@ -78,7 +78,7 @@ static int nvmet_ctrl_state_show(struct seq_file *m, void *p)
 	bool sep = false;
 	int i;
 
-	for (i = 0; i < 7; i++) {
+	for (i = 0; i < ARRAY_SIZE(csts_state_names); i++) {
 		int state = BIT(i);
 
 		if (!(ctrl->csts & state))
-- 
2.48.1


