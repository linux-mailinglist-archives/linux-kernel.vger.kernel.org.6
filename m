Return-Path: <linux-kernel+bounces-565136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05866A661A7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9BC23A9191
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABC1202984;
	Mon, 17 Mar 2025 22:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6g2dwN8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD6A169AE6
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742250647; cv=none; b=jJHYXles6a4sRMZwzQOmqHOVxqaVo1J9zUV9RzZ5eaS3M5F/b6NcZ4oJKYxSYOFog7jAMiE0SR5QFBl3JZ5uiCavNwpXAT5Fy5PeeTMZS2yo+ztC3q3EJuaV5E+j8uygACSd0vbaJnjRMq6MwEiBCkahjJ3Nimuos4NWGgoMH7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742250647; c=relaxed/simple;
	bh=tJ04ia7KsnA/njcoWWeuhbv49Y5qk4iZJEmd0qZEd7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FIxrLA4ldJZ+i0mFb7msh9pSnpnysi9uwJul36rJcA99lBtX8ArzfXrUqO3iitLirJxbHGO59q2NA7gpL9XqSBAlQVXCi5ZwPnL+x6e6sKG0iBZ5lDqYWCLRGZR24xb68sJZ0gzoqp1NcWyBXJUgzi6aNgrTu7jHlPg0hAVOme0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6g2dwN8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC81C4CEE9;
	Mon, 17 Mar 2025 22:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742250647;
	bh=tJ04ia7KsnA/njcoWWeuhbv49Y5qk4iZJEmd0qZEd7Y=;
	h=From:To:Cc:Subject:Date:From;
	b=F6g2dwN8yIhB2WGuKpnEASGmM9o7tulaOne5Z5YuWvGmF2aiiaM4T1YEivwuKPiXM
	 hzS9Cyb4/KXdbopuuYg+KXJ0Kq5mbRS2T5hc7FJ0i6aPSinoXA/UiDUqPYql6dQoh7
	 zpnwSxhOpnvtpWybG85YJL68++/rWJ4FaApOOLzNcFIHaj2NaoejYVpdpGlMnqRc8e
	 JBfaLWaoVsUNM/N5EuKDzeAR+RA6Vw/Ph3I4bYJR9MBXO/Ji24SO0Z7Fbdx4DrCYmb
	 3E3VXAUjeyQzXMXNvIdPrwLFFR2owCdmcDkF9KYfAK2eRjaqYKHcoP78lOJCxovwh8
	 uYyMcZpLa5v/g==
From: mingo@kernel.org
To: linux-kernel@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	"Ahmed S . Darwish" <darwi@linutronix.de>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	John Ogness <john.ogness@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/5] x86/cpu: Introduce <asm/cpuid/types.h> and <asm/cpuid/api.h> and clean them up
Date: Mon, 17 Mar 2025 23:30:34 +0100
Message-ID: <20250317223039.3741082-1-mingo@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ingo Molnar <mingo@kernel.org>

This series contains Ahmed S. Darwish's splitting up of <asm/cpuid.h>
into <asm/cpuid/types.h> and <asm/cpuid/api.h>, followed by a couple
of cleanups that create a more maintainable base.

[ This is a resend with a proper SMTP setup. Apologies for the duplication. ]

Thanks,

	Ingo

================>
Ahmed S. Darwish (1):
  x86/cpuid: Refactor <asm/cpuid.h>

Ingo Molnar (4):
  x86/cpuid: Clean up <asm/cpuid/types.h>
  x86/cpuid: Clean up <asm/cpuid/api.h>
  x86/cpuid: Standardize on u32 in <asm/cpuid/api.h>
  x86/cpuid: Use u32 in instead of uint32_t in <asm/cpuid/api.h>

 arch/x86/include/asm/cpuid.h       | 217 +--------------------------------------------------------
 arch/x86/include/asm/cpuid/api.h   | 210 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/cpuid/types.h |  32 +++++++++
 3 files changed, 243 insertions(+), 216 deletions(-)
 create mode 100644 arch/x86/include/asm/cpuid/api.h
 create mode 100644 arch/x86/include/asm/cpuid/types.h

-- 
2.45.2


