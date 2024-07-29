Return-Path: <linux-kernel+bounces-265121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B90A593ED00
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21DC1281FAC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 05:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B902381742;
	Mon, 29 Jul 2024 05:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nl1wY+9n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060791EA91
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 05:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722231218; cv=none; b=LY51aI20oKn1XXwK8BphS1GLfD5C5XTWj1dgWOQl+98LlLwgDfv/EmBTmKPATaGD79JM22qmxIyqXtbf57NyqJi4w6ta7rk/bKtVS4FvchV2IP4NPlvWgXkKlEVL8fIuUxmw8KGJyM14CbrgBSlgg0GjDCctgxVsF7LBBK/bNuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722231218; c=relaxed/simple;
	bh=xn9IkdzphgnCYwLR2Fq1grIvkIhPiQX7h9Wxn+pcM0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HpZ7HNu2pOyXl4OykVB4cldOY9DtLdWzMtuPbYNJdOWFEr1tudeALkOQ4BDOL0ndmhLE/T6CxZyZ7d6J2c0yHcx2F5Jahj7/zOZcLbTj/fiwUluCRG2xUazHRqn7gjzK0UqLnpOS4ML117OUQamyzz3CfSZIFdQk4I7QiD2+5Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nl1wY+9n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06271C32786;
	Mon, 29 Jul 2024 05:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722231217;
	bh=xn9IkdzphgnCYwLR2Fq1grIvkIhPiQX7h9Wxn+pcM0s=;
	h=From:To:Cc:Subject:Date:From;
	b=Nl1wY+9ngVqBNz6xMK9sfbm0dxSVCqjX2TmlUT30oDA66YU2USb7SN4OSa5ybNkPJ
	 sPnGReb9CiEZkmXwSLY3nsCtveE5lRI7atU4eM/cUNsYDzp3oWf6w98j1bRHVTLlH1
	 1lb+KTJ9Hwpkl7lwcYG4viVqYqRaP//jgpZf9XHo0pXAQRRImEQJXCRCL9+iUYb9t5
	 msGcCAgaPAeOnxCcGqjQ4HU/qyR6hmpB7dSpOnCaqJiLxBcmeyeyBaNGt1mGnfyjde
	 xE1DlU5b0fCTQXd0npzv7HkiNlYBjP/wudqpnmdirOSxM3rH1k6Ee+QVztH4NdISm+
	 wXS2IpFhWqU8Q==
From: Mike Rapoport <rppt@kernel.org>
To: Michal Simek <monstr@monstr.eu>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Mike Rapoport <rppt@kernel.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] microblaze: don't treat zero reserved memory regions as error
Date: Mon, 29 Jul 2024 08:33:27 +0300
Message-ID: <20240729053327.4091459-1-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before commit 721f4a6526da ("mm/memblock: remove empty dummy entry") the
check for non-zero of memblock.reserved.cnt in mmu_init() would always
be true either because  memblock.reserved.cnt is initialized to 1 or
because there were memory reservations earlier.

The removal of dummy empty entry in memblock caused this check to fail
because now memblock.reserved.cnt is initialized to 0.

Remove the check for non-zero of memblock.reserved.cnt because it's
perfectly fine to have an empty memblock.reserved array that early in
boot.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Mike Rapoport <rppt@kernel.org>
Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
---

Looks like it fell between the cracks.

 arch/microblaze/mm/init.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index 3827dc76edd8..4520c5741579 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -193,11 +193,6 @@ asmlinkage void __init mmu_init(void)
 {
 	unsigned int kstart, ksize;
 
-	if (!memblock.reserved.cnt) {
-		pr_emerg("Error memory count\n");
-		machine_restart(NULL);
-	}
-
 	if ((u32) memblock.memory.regions[0].size < 0x400000) {
 		pr_emerg("Memory must be greater than 4MB\n");
 		machine_restart(NULL);

base-commit: dc1c8034e31b14a2e5e212104ec508aec44ce1b9
-- 
2.43.0


