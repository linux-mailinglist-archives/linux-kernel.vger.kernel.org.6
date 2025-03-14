Return-Path: <linux-kernel+bounces-562217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8997DA61F4C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 22:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3244617D283
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 21:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891EA22CBE3;
	Fri, 14 Mar 2025 21:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkAEvpgF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E90229B2D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 21:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741988521; cv=none; b=q2kJgk44VZrrQlZnVc4uwb6YJMjqbfaa1M26ekraucypHxBT2TfDPls98pKh//SMkOKI0f0zFrxxhMAUjcy3i+XlVBH6nrzmEwCKPZCrmFgRb2+vo2uOcMcaFp+aQH9Mh0XZPYJzwfZcv32cx/695ESc/ZtGtGuaw6OnDjGGW68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741988521; c=relaxed/simple;
	bh=SwyNGWtwQgHOApJI6bIB7Y2YZV2fZzV/abNiCm9lxKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTPF5xAa4ltAFmJ6agUDYmSosGiMIuXQsxYASDYPHybLzNtbp6MwyIuDULG6lgH4gMNag+Oefn3EI6NexBuENFdWTUHAK6g0OplRMFg9540cHiUXuSmR8XqZ4TDE01NmIr7UfKVoarWg9LyQ5jE818pJSY/cv91vkhg+iiAQoYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkAEvpgF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3B87C4CEED;
	Fri, 14 Mar 2025 21:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741988520;
	bh=SwyNGWtwQgHOApJI6bIB7Y2YZV2fZzV/abNiCm9lxKw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mkAEvpgFyJI9gYhec+b37dyVF5dYFBk8pOV34YLpBDnjAheJGY/+qR28TEQLkYk0G
	 dS4T1jpmZW+aXWmdH9Jf9Ky3pKngBiIDFfa3QFRs4ue5HhoqeKjTfBoSXE8oX+fkJx
	 T476dnurSeVW5kHkvkDqJ3aI+fd8aU71laYyVaMvSAXDujTJYBJU+PwTuswcECs9ts
	 7o1D20TD3Lx66+EdE+XzvVLTIaahBIQ7Jd+3uFGsovbNLODC8Ym0ucNRNU7dL6YIT+
	 48Mp4AAeSapbsGNnCuJReaEUXFR31DqBobSfg2fv4ZLaAXsaU0r88sZf1+puvhJHz9
	 NP8+CkTad3g1Q==
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 11/20] x86/alternative: Make alternative() a wrapper around alternative_io()
Date: Fri, 14 Mar 2025 14:41:24 -0700
Message-ID: <7861339dadc2bfff65634db421ca0fc81d468c1e.1741988314.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741988314.git.jpoimboe@kernel.org>
References: <cover.1741988314.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To reduce the number of independent implementations, make alternative()
and alternative_2() wrappers around alternative_io() and
alternative_2_io() respectively.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/alternative.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index 0acbb013e7ae..92014d56e3aa 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -204,10 +204,10 @@ static inline int alternatives_text_reserved(void *start, void *end)
  * without volatile and memory clobber.
  */
 #define alternative(oldinstr, newinstr, ft_flags)			\
-	asm_inline volatile(ALTERNATIVE(oldinstr, newinstr, ft_flags) : : : "memory")
+	alternative_io(oldinstr, newinstr, ft_flags,,)
 
 #define alternative_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) \
-	asm_inline volatile(ALTERNATIVE_2(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2) ::: "memory")
+	alternatve_2_io(oldinstr, newinstr1, ft_flags1, newinstr2, ft_flags2,,)
 
 /*
  * Alternative inline assembly with input.
-- 
2.48.1


