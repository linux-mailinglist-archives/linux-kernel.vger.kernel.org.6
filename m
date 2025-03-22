Return-Path: <linux-kernel+bounces-572578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7690A6CBC0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 18:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 987FA3AA5BE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 17:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373FB230BDF;
	Sat, 22 Mar 2025 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=o2.pl header.i=@o2.pl header.b="Pd6SaZ1z"
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BE89443
	for <linux-kernel@vger.kernel.org>; Sat, 22 Mar 2025 17:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.222.135.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742666272; cv=none; b=hwDx8AIquWWjzZStwNEbx57Yub3XmINVkIQ8WfuoQm7gGrGUYGSw3hnmF5aY9hb5STDWxYzMhtX+TpzwGAwL1mTd8ZedYo3epgplmI3ymj4KwePgyU8zGt3UXhUjhcFf7K/LqpmT4+a0wC11Q7EKvdtJTE4XD7DEKzowSOxLT3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742666272; c=relaxed/simple;
	bh=IN9GnPkW93zwmQoHRW6SR9yKu5QESfsxc0Crrszh3kU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DTgCA3Ph662O06+bM+WtBoVZncBVtUCk7o5e867wbVc+MUNqGEamPfz/lnN4QJPZhDkZSymzV8p9163g4Oei0m01dqu5MaOVjp7dpHhzfEz0wWyeBDsbd1EqOBMXhmsjNIlIk9XKeUiPgGFGsSGrs/K0ByTXUS+tz7/1bl0rqX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=o2.pl; spf=pass smtp.mailfrom=o2.pl; dkim=pass (2048-bit key) header.d=o2.pl header.i=@o2.pl header.b=Pd6SaZ1z; arc=none smtp.client-ip=193.222.135.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=o2.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=o2.pl
Received: (wp-smtpd smtp.tlen.pl 22108 invoked from network); 22 Mar 2025 18:50:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=20241105;
          t=1742665858; bh=f4k7vElZ9kpIGxGizgeRbh7YTpHhKuRdxcYAX8HWUlc=;
          h=From:To:Cc:Subject;
          b=Pd6SaZ1zGz24UpYzp6Fu4/UPpTo7/WybfCLsMkdLGh+bj+cB6cz7Ug+N3hjlXwCRE
           EkvPIWBs9hjWBJ0jgy9MhysUSq0p4u2ckkso+P0dRbm9aYSHxb7CWT/Lx/zhYON3OW
           FLandsj8EEWk3ejSn0UBee7IKkzfVvgRNwyWg7jFSHW1wsLsMwUsEtfrU2EvZC9zF5
           hRtVxQ9khBtWNrOUKxyQvqY86MQPytuQHkwm2EufVs32Upt26qAqWDnbqDoYbwGKp4
           4pIGd4+hge086xY6w754Jh61Od1+p8BDRZfZice5u/hoegbrFcVhFssf136Zc8Z1J3
           yo7s8oUx0hMZg==
Received: from apn-78-30-75-41.dynamic.gprs.plus.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[78.30.75.41])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-kernel@vger.kernel.org>; 22 Mar 2025 18:50:58 +0100
From: =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	David Heideberg <david@ixit.cz>
Subject: [PATCH] x86/Kconfig: fix lists in X86_EXTENDED_PLATFORM help text
Date: Sat, 22 Mar 2025 18:50:52 +0100
Message-Id: <20250322175052.43611-1-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250321-x86_x2apic-v3-4-b0cbaa6fa338@ixit.cz>
References: <20250321-x86_x2apic-v3-4-b0cbaa6fa338@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 2ad147852fb354878829770cd5bb1ba0
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000005 [wXZN]                               

Support for STA2X11-based systems was removed in February in
commit dcbb01fbb7ae ("x86/pci: Remove old STA2x11 support")

Intel MID for 32-bit platforms was removed from this list also in
February in
commit ca5955dd5f08 ("x86/cpu: Document CONFIG_X86_INTEL_MID as 64-bit-only")

Intel MID for 64-bit platforms is a duplicate for "Merrifield/Moorefield
MID devices".

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Fixes: 4047e8773fb6 ("x86/Kconfig: Update lists in X86_EXTENDED_PLATFORM")
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: David Heideberg <david@ixit.cz>

---

Hello,

I have re-reviewed my old patches resubmitted recently by David Heidelberg
and applied today by Ingo Molnar.

Only two of them needed updates, the other one was in
commit 9232c49ff31c ("x86/Kconfig: Enable X86_X2APIC by default and improve help text")

I am sending the updates as separate patches to be applied on top of tip.git.

Once again thanks to David.

Greetings,
Mateusz
---
 arch/x86/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ef48584c8889..ce46252af1e5 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -545,10 +545,8 @@ config X86_EXTENDED_PLATFORM
 	  32-bit platforms (CONFIG_64BIT=n):
 		Goldfish (mostly Android emulator)
 		Intel CE media processor (CE4100) SoC
-		Intel MID (Mobile Internet Device)
 		Intel Quark
 		RDC R-321x SoC
-		STA2X11-based (e.g. Northville)
 
 	  64-bit platforms (CONFIG_64BIT=y):
 		Numascale NumaChip
@@ -556,7 +554,6 @@ config X86_EXTENDED_PLATFORM
 		SGI Ultraviolet
 		Merrifield/Moorefield MID devices
 		Goldfish (mostly Android emulator)
-		Intel MID (Mobile Internet Device)
 
 	  If you have one of these systems, or if you want to build a
 	  generic distribution kernel, say Y here - otherwise say N.
-- 
2.25.1


