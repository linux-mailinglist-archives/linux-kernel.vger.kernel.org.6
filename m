Return-Path: <linux-kernel+bounces-434881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 788B29E6C44
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 11:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 354F628778E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2379F1FF7AF;
	Fri,  6 Dec 2024 10:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pz5mKd00"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8228C1FA24D
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 10:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733481044; cv=none; b=fYKHRYMaQYHAQIXZZyeo5sp69FIKstVPwHqW7y3KMtqncKpkXStaqw1R+auXDJplenFGzG6t92WLooNTPKm92xd5scxMA8zdTTmi+DvWD+8WQFwq6L7V2n5yB4BUGj8zWfvB7nESOmJfA25Rj6BevcpWlw/u03xWe6z9qB/q46U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733481044; c=relaxed/simple;
	bh=zEfXT4Lxg8TufRHalylMKp53KlYmN1G7C80NnpnoqeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MlWlK2ny+PGYGbZryIEOh2LkEWr74TA6sOY4a7YsLe/Hterd3ktkqmSQWPusG7s7hl7aSh2Kd1k1ORbVWXNJ4hclxgr/ov7TsmtsplMBO0vWfQeEDOBlQwGfA43NWUY5vt6AJfruSrWuBdX8OZr74/P0RpHlf21CnnR1Q/j8kiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pz5mKd00; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B871AC4CED1;
	Fri,  6 Dec 2024 10:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733481044;
	bh=zEfXT4Lxg8TufRHalylMKp53KlYmN1G7C80NnpnoqeU=;
	h=From:To:Cc:Subject:Date:From;
	b=Pz5mKd00nCbCdx0BAJLADzKJBUfnF8tyGf7O/s3sfCkm3Wk+oVUs9eBk08eczC1Wc
	 hTm7pgNRWGFOLbW34MUIKGMVFDL3e8J6yq5TMmAaJYtVw1suaVJbTyFFHq0pLwD34i
	 I+QctS1Yg+jDwmiqeNluJFJZOXlSNTN408BkX+c3lcTMmFYj9RdPs0QLJ/OY5FZGyA
	 cEgcm2cQHMsCvpaT4+Nd713snbIWjWkO1sfnrjS7Y2MzAOdjA8sAgS0az+oIU4tDNq
	 p7PamsWz3HPdNjY5F55pH6T2101FrvcLBHOKBCh7NKjMXf9JaCO6bmkDX2hqU7TmPQ
	 A9HruHlCASy5Q==
From: Mike Rapoport <rppt@kernel.org>
To: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Mike Rapoport <rppt@kernel.org>,
	Ning Sun <ning.sun@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	tboot-devel@lists.sourceforge.net
Subject: [PATCH v2 0/4] x86/boot: a few cleanups
Date: Fri,  6 Dec 2024 12:30:27 +0200
Message-ID: <20241206103031.737458-1-rppt@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Hi,

These patches cleanup x86::setup_arch() and e820.c.
No functional changes intended.

v2: update comments as suggested by Ingo
v1: https://lore.kernel.org/all/20241203112525.591496-1-rppt@kernel.org

Mike Rapoport (Microsoft) (4):
  x86/boot: move setting of memblock parameters to e820__memblock_setup()
  x86/boot: split kernel resources setup into a helper function
  x86/boot: split parsing of boot_params into a helper function
  x86/e820: drop E820_TYPE_RESERVED_KERN and related code

 arch/x86/include/asm/e820/api.h   |   1 -
 arch/x86/include/asm/e820/types.h |   9 --
 arch/x86/kernel/e820.c            |  95 ++++++++-------------
 arch/x86/kernel/setup.c           | 134 ++++++++++++++----------------
 arch/x86/kernel/tboot.c           |   3 +-
 arch/x86/mm/init_64.c             |   8 --
 6 files changed, 97 insertions(+), 153 deletions(-)


base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
-- 
2.45.2


