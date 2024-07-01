Return-Path: <linux-kernel+bounces-236473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D1C91E2BC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8681F24D99
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E97216CD01;
	Mon,  1 Jul 2024 14:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hqWpwlJ5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TSkvctnu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A17916C698
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719845298; cv=none; b=mRwI6XYiqEKF/zCsysHWnZADaeWz8KZPb4efkCnsobCo9JN4sBmBPlLnuNSIzXU1bcko6SSGl87SIfWXApPbHHZzOsbCWWi0su6h6f4Mgyi5MmZiOyKwMCwIgXdLHecbocCfu/o0HBJz735rYkF2O106TmsXZTG92dF38dYhQKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719845298; c=relaxed/simple;
	bh=wAT6G7YSOUdMLUFvrObvp5TsBYs0k8ho7/PDRYau4KY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rafENREy2IiEqd6ae9a9yZomia7U58H/DmpToJEcB2B//I+7fKfOp+F4xyMsXIpyC1C4PodPc7TTrkanVzJRy5tRzGqgSbY2tZseyePSMucBRg7lthMMie2d4Jh+jmH221gnMxUq1HkN6cv4Svoq1BFDavOpwvpHmeqxL5Sqmjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hqWpwlJ5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TSkvctnu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719845290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MZEHWOXSxyN/t/eZpG9BBndys+z4enM5BAIpn5b7nwk=;
	b=hqWpwlJ5vMhe3Uv6dacS2qLctIdKT5J22QRIAioZvsQzMtA1lD3KjsXcbP3QCb4yoBodRK
	5M4ZBfnR4TpRxdFK45JR8/iw696VYtFUhuKKw45ZEKQeGzkZCfBcTTo4P5l9V27M4ardue
	v2eXStg70oxHZMhFiq31TMaCCcbcGZGGbzxQpnnu5oZfbfJ1nDcy+jjeO7nE8iTdPNB/hQ
	1Zt72d3wHyC6ouG2K/AFoHg2lBilw2AnOBXWqg90hSYierQ0+Jw5WtvEGuEgKpj7L1vwxh
	DdTjhxwtT7i/q5oNANDeCw3kzZfqBcUxWOLHpKSKCj3dKmlWvreXkZtRPkneXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719845290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MZEHWOXSxyN/t/eZpG9BBndys+z4enM5BAIpn5b7nwk=;
	b=TSkvctnu2XnQE1lrrjoYI4hVouFpCH3FWs3xAca5o5MedShOvXjOX7/4XNtTCl707+6Mt/
	oP5Tq7gQjjsFeyCw==
Subject: [PATCH 0/5] vdso (generic and x86): Misc minor cleanups
Date: Mon, 01 Jul 2024 16:47:53 +0200
Message-Id: <20240701-vdso-cleanup-v1-0-36eb64e7ece2@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJnBgmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDM0ML3bKU4nzd5JzUxLzSAt1kI4MkA2MDc0tj8zQloJaCotS0zAqwcdG
 xtbUArCll714AAAA=
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-kernel@vger.kernel.org, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
 x86@kernel.org

The queue contains minor vdso related cleanups such as fixing/adding
comments and removing unused stuff. First two patches are related to the
generic vdso part. Last three patches are x86 specific.

The queue is available here:

https://git.kernel.org/pub/scm/linux/kernel/git/anna-maria/linux-devel.git vdso/cleanup

To: Andy Lutomirski <luto@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-kernel@vger.kernel.org

Thanks,

Anna-Maria

---
Anna-Maria Behnsen (5):
      vdso/gettimeofday: Clarify comment about open coded function
      vdso: Add comment about reason for vdso struct ordering
      x86/vdso: Fix function reference in comment
      x86/vgtod: Remove unused typedef gtod_long_t
      x86/vdso: Remove unused include

 arch/x86/include/asm/vdso/gettimeofday.h |  5 ++---
 arch/x86/include/asm/vdso/vsyscall.h     |  1 -
 arch/x86/include/asm/vgtod.h             |  5 -----
 include/vdso/datapage.h                  |  4 ++++
 lib/vdso/gettimeofday.c                  | 20 ++++++++++----------
 5 files changed, 16 insertions(+), 19 deletions(-)


