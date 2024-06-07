Return-Path: <linux-kernel+bounces-205880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6659001D4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 13:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16B75B21932
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA681862AC;
	Fri,  7 Jun 2024 11:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fm9v8s1z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F27561FDD
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 11:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717759027; cv=none; b=Jtei+JGoKjb9crMiqZn8xz5nRUGkAdB3WzkLeDmYSrOba/A3+E9J0crEziCNow/DRsJH3Uer8Q0lT78o//vbLzbWwwAtpdUldfnyWOCyrm5HPfhodbWKIh2KDZzUCsOCgWRouHdIlTTUnWM5NAPIxMgPLpZzvddHWPWlv6FqoyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717759027; c=relaxed/simple;
	bh=uYd/JYZxqM1CXexTe3zzP5owUXcenU+W7Ko6xWLKq/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ftNXupTXxWrfJrkKdq4WuzbJw/ir/DKpNvrU9StOeHr8u2kDP3k1+Votz8pnTRWUjr4xN+FWZxL5X/MHhm5InM7ZmkMGGvrif/1ufSNjJ9yfvJhQM44Ouj1LBGuiCQsFNUAtKZnz7ULBthrt6Ow1PXKPHtXBt65PJr7ssR9U7jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fm9v8s1z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C41FC2BBFC;
	Fri,  7 Jun 2024 11:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717759027;
	bh=uYd/JYZxqM1CXexTe3zzP5owUXcenU+W7Ko6xWLKq/4=;
	h=From:To:Cc:Subject:Date:From;
	b=fm9v8s1zzADfrtHx60+YiJVD15ZB4hxADk3trSN22K015dYutbPEIuUXZgXg9vV0D
	 Dn5boAu/gMy0JSUHdY/YTWjMS8bQBH0OU8toEKMP1FmXljiWjsRoHZPw4C53T2RHmj
	 QCGQ50wzb3hRSXf8EpbSD6LkTDaRnOIvG3rtvsf2oX12EUrFGjlvSDJvBwlx0hjAf6
	 4Loh5ekWFsuhXzbHfre2HrptdaldHR7IZpaQRm+Cm06g6tf5/8IwDXju3dxEXNhFhC
	 GGkHVS29neGQ9nFgXXIaZdf1gQolbgU3V3LZq7o8ZWGtjw116Q5l2jn4o32bXbpiFY
	 fHhPifvU5wbjw==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH v1 00/14] x86/alternatives: Nest them
Date: Fri,  7 Jun 2024 13:16:47 +0200
Message-ID: <20240607111701.8366-1-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Hi,

here's the next revision

  [ v1 - the last one was v0 even if not denoted as such:
    https://lore.kernel.org/r/20240531123512.21427-1-bp@kernel.org ]

of the alternatives nesting patchset.

All feedback has been incorporated and testing with it still looks good.

Thx.

Changelog:

v0:
---

this is basically peterz's idea to nest the alternative macros with
a fix to an issue I encountered while testing.

For ease of bisection, the old macros are converted to the new, nested
variants in a step-by-step manner so that in case an issue is
encountered during testing, one can pinpoint the place where it fails
easier. Because debugging alternatives is a serious pain.

Testing here on my farm looks good but who knows what happens out there,
in the wild.

Thx.

Borislav Petkov (AMD) (13):
  x86/alternative: Zap alternative_ternary()
  x86/alternative: Convert alternative()
  x86/alternative: Convert alternative_2()
  x86/alternative: Convert alternative_input()
  x86/alternative: Convert alternative_io()
  x86/alternative: Convert alternative_call()
  x86/alternative: Convert alternative_call_2()
  x86/alternative: Convert ALTERNATIVE_TERNARY()
  x86/alternative: Convert ALTERNATIVE_3()
  x86/alternative: Convert the asm ALTERNATIVE() macro
  x86/alternative: Convert the asm ALTERNATIVE_2() macro
  x86/alternative: Convert the asm ALTERNATIVE_3() macro
  x86/alternative: Replace the old macros

Peter Zijlstra (1):
  x86/alternatives: Add nested alternatives macros

 arch/x86/include/asm/alternative.h | 225 +++++++++--------------------
 arch/x86/kernel/alternative.c      |  20 ++-
 arch/x86/kernel/fpu/xstate.h       |  14 +-
 tools/objtool/arch/x86/special.c   |  23 +++
 tools/objtool/special.c            |  16 +-
 5 files changed, 125 insertions(+), 173 deletions(-)

-- 
2.43.0


