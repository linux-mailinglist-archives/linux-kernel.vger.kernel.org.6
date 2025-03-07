Return-Path: <linux-kernel+bounces-552026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2984BA5744A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9150A18964BA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC188205AB6;
	Fri,  7 Mar 2025 22:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgpWRweU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B077E9
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 22:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741384981; cv=none; b=JeToKhuOSVMoADR8vfEgJ0kNwCTc2s7zKgam4wPyTm4OAtyqNiV5m27yH60/D1BfhtWjggWGTUvEFexJuFvcnMTzzAl4Ef1GVUfZlsJRBZdp2/k4oEYNZ1/uJAzhQfO/wiN+4paaYrjc/F6gM9aX0+JRxJSuTcCkEksRRi/V33k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741384981; c=relaxed/simple;
	bh=JA+g0ghH/DykcYjoH3niay4tjJZ/0OoSu+xpufGpKsw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e1Kb18aQYqTHU817K/aU29/b854zdP+dmpA0m2qB7it1B0kHlJXzyEp5Jhg03tjv9RaytdUd58UHMAeqih1DHK8+POlpHoJL/2Xs1swxb+BWK8J1T4eqTd3v6DmAzBF8/wgJW512SLOEJmhVNpwDBKDBwgDzDpx1yDEmR99MbAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgpWRweU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EC5C4CED1;
	Fri,  7 Mar 2025 22:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741384980;
	bh=JA+g0ghH/DykcYjoH3niay4tjJZ/0OoSu+xpufGpKsw=;
	h=From:To:Cc:Subject:Date:From;
	b=MgpWRweUMFfEtflJgBcXg3akIBv4OZKbW5GHoYjv6HUm3x5OMQkZp7MnWk9zByHMc
	 fZ9Z9BcZCLESc1nFn6cM8GIUYw3BGGDkGETeCV6rtZF69/ifP28GGUWy9tkuVO+OSY
	 0epMjvyVDKpHNAZKQAB9xb5FKqCRs3CuGH6L8kwLHhwLHAG6GYqHl/Cqwk1fajSKhS
	 aRSeO/qESs2pR8fQaVS/Cs7QInUKRzcuzZ5S4n+eWfDiKvQvE8J1MgN6XZx/G0TY1J
	 5gOaRfsN5HSgqa5h5WamOcueQdv53CpmPYSz/gQMNs6lPz3tb3xvKVuRVFuvqnyP42
	 rBcqXHVDB+h9g==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	=?UTF-8?q?Toralf=20F=C3=B6rster?= <toralf.foerster@gmx.de>
Subject: [PATCH] x86/microcode/AMD: Add some forgotten models to the SHA check
Date: Fri,  7 Mar 2025 23:02:56 +0100
Message-ID: <20250307220256.11816-1-bp@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Add some more forgotten models to the SHA check.

Fixes: 50cef76d5cb0 ("x86/microcode/AMD: Load only SHA256-checksummed patches")
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reported-by: Toralf Förster <toralf.foerster@gmx.de>
Tested-by: Toralf Förster <toralf.foerster@gmx.de>
---
 arch/x86/kernel/cpu/microcode/amd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 95ac1c6a84fb..c69b1bc45483 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -175,23 +175,29 @@ static bool need_sha_check(u32 cur_rev)
 {
 	switch (cur_rev >> 8) {
 	case 0x80012: return cur_rev <= 0x800126f; break;
+	case 0x80082: return cur_rev <= 0x800820f; break;
 	case 0x83010: return cur_rev <= 0x830107c; break;
 	case 0x86001: return cur_rev <= 0x860010e; break;
 	case 0x86081: return cur_rev <= 0x8608108; break;
 	case 0x87010: return cur_rev <= 0x8701034; break;
 	case 0x8a000: return cur_rev <= 0x8a0000a; break;
+	case 0xa0010: return cur_rev <= 0xa00107a; break;
 	case 0xa0011: return cur_rev <= 0xa0011da; break;
 	case 0xa0012: return cur_rev <= 0xa001243; break;
+	case 0xa0082: return cur_rev <= 0xa00820e; break;
 	case 0xa1011: return cur_rev <= 0xa101153; break;
 	case 0xa1012: return cur_rev <= 0xa10124e; break;
 	case 0xa1081: return cur_rev <= 0xa108109; break;
 	case 0xa2010: return cur_rev <= 0xa20102f; break;
 	case 0xa2012: return cur_rev <= 0xa201212; break;
+	case 0xa4041: return cur_rev <= 0xa404109; break;
+	case 0xa5000: return cur_rev <= 0xa500013; break;
 	case 0xa6012: return cur_rev <= 0xa60120a; break;
 	case 0xa7041: return cur_rev <= 0xa704109; break;
 	case 0xa7052: return cur_rev <= 0xa705208; break;
 	case 0xa7080: return cur_rev <= 0xa708009; break;
 	case 0xa70c0: return cur_rev <= 0xa70C009; break;
+	case 0xaa001: return cur_rev <= 0xaa00116; break;
 	case 0xaa002: return cur_rev <= 0xaa00218; break;
 	default: break;
 	}
-- 
2.43.0


