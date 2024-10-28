Return-Path: <linux-kernel+bounces-385380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B20E79B3679
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E39A71C21D0B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F401C1DED7F;
	Mon, 28 Oct 2024 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0hCc6Zq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1271DED5E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133006; cv=none; b=Ct2dCLxoa6yEmIV4VDWMEHckv3XAfVsTGJ1qylVD6Cw4AXwu90/4ly8MKs5fHNA4sC25zwXqjx1U//jD6RNTvV8BlFLcTZHAvB4BYWlBUbTZJm8HJNkEVUgvg3CANNxVnX75CcR03XcHpMi94SnN1E9hSik4wKj+YC0INcch5a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133006; c=relaxed/simple;
	bh=jQFyOpqIMMDVdp3ou6dMZrH1Ej7KK1pQaLeymPARPo4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A4uGGgmES0krgefUTwvX5v6awSCWYWsl7hQsbZGZB/Ujg/2EUqbT0yZFExHDJIkYn4sAvTaCHmJmKxYiw5tkKa9bi6+HQdMkFk0oAlh/hd2SsR5ravjHGmdRf1IfwrZxgiBUX/7HUgLQUVB038IND1vyzWHFOYceimNb/0PIVjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0hCc6Zq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F56C4CEC3;
	Mon, 28 Oct 2024 16:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730133006;
	bh=jQFyOpqIMMDVdp3ou6dMZrH1Ej7KK1pQaLeymPARPo4=;
	h=From:To:Cc:Subject:Date:From;
	b=t0hCc6ZquqSmefKdIYQZHWYA+Bj5JhxwDfm5DQwcVldnAaO/Yst2KO02knp/6wE5D
	 mOHtlRiv/jNr8ZhFmiOek3OEjETWM7QVC0vHM6slT+RT+f5APo0NO1N8JOzOWsvKX0
	 o25D1WR1CFNatZFuDpbEyrUUvWM13iilnrX+mhkdGajInGFdE49QzkfwaHB/JZcqmQ
	 d8J63sFyy49qT/+fljEDiU8rdOlMVa+7RD9Ltr09hTHB6jMx3W0yPGX78XvY9fAoWk
	 EE+/VtLDSz/Nl1fNBBtImsMJzUKqQkE7if4Qt6/CGtXhlen+SjdR4HSHtyPWhmC4/1
	 YOjbsoxQfFY7Q==
From: Arnd Bergmann <arnd@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: kallsyms: add MODULE_DESCRIPTION
Date: Mon, 28 Oct 2024 16:29:54 +0000
Message-Id: <20241028163000.2201045-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The newly added test script creates modules that are lacking
a description line in order to build cleanly:

WARNING: modpost: missing MODULE_DESCRIPTION() in lib/tests/module/test_kallsyms_a.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/tests/module/test_kallsyms_b.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/tests/module/test_kallsyms_c.o
WARNING: modpost: missing MODULE_DESCRIPTION() in lib/tests/module/test_kallsyms_d.o

Fixes: 84b4a51fce4c ("selftests: add new kallsyms selftests")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/tests/module/gen_test_kallsyms.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/tests/module/gen_test_kallsyms.sh b/lib/tests/module/gen_test_kallsyms.sh
index e85f10dc11bd..ae5966f1f904 100755
--- a/lib/tests/module/gen_test_kallsyms.sh
+++ b/lib/tests/module/gen_test_kallsyms.sh
@@ -99,6 +99,7 @@ module_exit(auto_test_module_exit);
 
 MODULE_AUTHOR("Luis Chamberlain <mcgrof@kernel.org>");
 MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Test module for kallsyms");
 ____END_MODULE
 }
 
-- 
2.39.5


