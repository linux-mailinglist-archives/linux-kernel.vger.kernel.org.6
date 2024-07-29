Return-Path: <linux-kernel+bounces-265179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DFF93EDA0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC2711F21FA9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 06:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456E184A57;
	Mon, 29 Jul 2024 06:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dC3dVWUj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE5D82C63
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 06:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722235593; cv=none; b=Gz7S92Bb8fam9OQs+GkVqyj8h5LldE7TNrOVUna88HFOd201xl22vBKY43DzwZfzFx8WzjPWcK9dTYR02w3hqs1rQZje1uCdeYeMPSMjyEVwe+3NPR2XJF7i15pT/MWoo+yAIqvPi+eXMaSDufkRwLhXGPQmNIKW6r12bLk/AhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722235593; c=relaxed/simple;
	bh=WfNoO+Op1iB0sOWV6PdCS20rqZ1LSsleP9gX7q/nNbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OcQStWwEb5+gjOWMJkNzb40zSHKBp8O04gnv07EY0kbmVOcA21LZQvPw9UFThC524Cn/C5v56qVZ0+K2Udm4F/LW5bkyqR3TKTFZcC4NZP6Xa6DYLEWpZsAH9VfXV9BvHQEKo8QUmP98ocJqgblz9Qi/QimiDoAX74Ioo0UWZRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dC3dVWUj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3ABAC32786;
	Mon, 29 Jul 2024 06:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722235593;
	bh=WfNoO+Op1iB0sOWV6PdCS20rqZ1LSsleP9gX7q/nNbg=;
	h=From:To:Cc:Subject:Date:From;
	b=dC3dVWUjGhwtyBBH29vix7fzgL0drPg1w4INIjqJjyNV5Hx3EBAhH/dddLL6FRqSs
	 A2jcMIQcOHj/UsA5Ziru7wT+02TDlCHGvMWe2XL1b7wfOnBnjAjLDsitEfp0KxiNeo
	 bppdPzQz+sz1nV2bccfwI9G+05G8+sVtFhKCTIl25eC1mJ+sLA/XVRLX4JYqDa0Mjp
	 ltRWOag6k8OfcE/NRgn4l4t70aIrq0Q5l1cLjTHAKuJevzpC0BKbbOEpRC3MGfjbKn
	 sPEfWZs7rNagA0COACvjSkGWXFbFZdhcRf6p5x6hSao0gLzOIw5KK5d7cDDQ7wp2aH
	 cKBrxbH5BcsKQ==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: jon.grimm@amd.com,
	LKML <linux-kernel@vger.kernel.org>,
	Perry Yuan <perry.yuan@amd.com>,
	Borislav Petkov <bp@alien8.de>
Subject: [PATCH] x86/CPU/AMD: Add models 0x60-0x6f to the Zen5 range
Date: Mon, 29 Jul 2024 08:46:26 +0200
Message-ID: <20240729064626.24297-1-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Perry Yuan <perry.yuan@amd.com>

Add some new Zen5 models for the 0x1A family.

  [ bp: Merge the 0x60 and 0x70 ranges. ]

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index be5889bded49..1e0fe5f8ab84 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -462,7 +462,7 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 		switch (c->x86_model) {
 		case 0x00 ... 0x2f:
 		case 0x40 ... 0x4f:
-		case 0x70 ... 0x7f:
+		case 0x60 ... 0x7f:
 			setup_force_cpu_cap(X86_FEATURE_ZEN5);
 			break;
 		default:
-- 
2.43.0


