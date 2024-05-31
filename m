Return-Path: <linux-kernel+bounces-196786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9BC8D61D8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB827B25165
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896B2158A16;
	Fri, 31 May 2024 12:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDt2rPcu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E13158A06
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717158915; cv=none; b=Jwm/z5SY2nvAUxUVLlJUipz3qmfR06Rw/udveO65aeEUdU9l0ou36F3bzjAhVOQqe3TBwbMDqUzlZY4bGJ18XF8ZJPlydrKzBthrNstdRWc7f7DCCHbs3uRL65498hYJiMp1An5oK8qAdiBmvo/LLdfqYICy+Cmulis6wHiE/3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717158915; c=relaxed/simple;
	bh=RMJnFiJ/QSXWNtlgr0UhK+itvTx0Gqfv+NvnGdA3Xb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CEzuW1am/7O5SKyeNj8YNo8RIfspYKAyq7HRELr1UPffS2ziRrttv7ClZ3barYh30gD7rY0Loiei64pHU94rYE4VIC1x1NBa/57lIs04rmFmxOClYAD+06y6dJmJTU170yhCrWU2IN7gTeMcEGEgDHvRKFEt+iRuJjAmODntLOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDt2rPcu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D37BAC32786;
	Fri, 31 May 2024 12:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717158915;
	bh=RMJnFiJ/QSXWNtlgr0UhK+itvTx0Gqfv+NvnGdA3Xb8=;
	h=From:To:Cc:Subject:Date:From;
	b=SDt2rPcuGYZmHKJiCePd9ilbZVDNKrluOuTnVKdj1ivjt00H8/MXf7GKEN19Y0Rg7
	 SUDSwdQbrqnvEFCmCHlv7jI3ghWNd1Ti65/dZCzriImHiL4DWq4WpiO1nsSKDkTxZ0
	 3rN5w6mGK/GOsRGLERs1fu0fB2SZf89LM9x+gfUyNMHgBSahdDIewI5WKKW7cWFNqH
	 Kv8EHWuZ7PjBGapoWspmav1Q2ur9JKB/PYmGQjLkJ3n5aBuWmkR7NbEPcMDP5uYO2C
	 eQxXqXRRz+GgR5Y45kKpuouhGKWQY6zvcIw6oT+gbkVQDgFQXfYWNhRP0e66vPiIEk
	 +Tu49rGnYlqnA==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH 00/14] x86/alternatives: Nest them
Date: Fri, 31 May 2024 14:34:57 +0200
Message-ID: <20240531123512.21427-1-bp@kernel.org>
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

 arch/x86/include/asm/alternative.h | 214 ++++++++---------------------
 arch/x86/kernel/alternative.c      |  20 ++-
 arch/x86/kernel/fpu/xstate.h       |   6 +-
 tools/objtool/arch/x86/special.c   |  23 ++++
 tools/objtool/special.c            |  16 +--
 5 files changed, 113 insertions(+), 166 deletions(-)

-- 
2.43.0


