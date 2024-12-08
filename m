Return-Path: <linux-kernel+bounces-436336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 628689E848E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 11:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12C0B1884A96
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 10:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0EF13B7A3;
	Sun,  8 Dec 2024 10:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="A17DUSOA"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8983018E1F
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 10:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733654722; cv=none; b=hm584ZP7shtyassxYog3g9kX1M7lPRCFWhfWOok22iIxI77x4xvTTYeuTX7sRNjDS+lZkMckSNbXOSCmzioQCeOYu3Iwt6Llz1eE0ZPsH6bgAKwpNL5x/IUesKxFM3JkfpsxoyMPtcsgnKMU1GCqvbiF0J3e5SGOLukfcqCxGNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733654722; c=relaxed/simple;
	bh=RII0E6R1B+ih2dUA2cVncIXtg+lPTwX7AenSELVmqf0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TEIyBbHkFC8r9lsXw/pDjBQgwUvXZG/L0zOqTtYB0EawoHDJgk2kKpDhSYdz8BDPcpT1KrAezJv9363tegHLqcls8bMl3pP8cbUX/4VAq2IEbboQazQHgYW+DuP8N9OLTj492fYOkkXtVLQ6JYUP/vCMXMATFGWvIDKqnUg6CvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=A17DUSOA; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 94AD440E0269;
	Sun,  8 Dec 2024 10:45:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id jnNIHt8bZ2p5; Sun,  8 Dec 2024 10:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1733654713; bh=QF1ZF2147QzrzNT+j3tg/zjdW2n2/exWUN/WYlP5LW8=;
	h=Date:From:To:Cc:Subject:From;
	b=A17DUSOATv/NrTT99mk6qeGAA4y+DDqtV7gwRUkG/uWgP2VKAZuWiZRO73phqG93V
	 kcMTPJgwbMcF2Cb5Z565SsGjEtOd53thlEueJxBpgiICpNLrZdEOzVA4xvwTEvNj9m
	 csJp03niJtksbjhDZcOaDt4MDxq7llzV/R9bmMNMtm2ZJLx07jTZy7ZgW+BLPeerMw
	 rcIrCwib6r2STJceqbu9IARjkevztE93eFWSnJwSCV+eD6Wk5gtXeV+NNoXkny9PSy
	 wOAwEOUcztGiN/gONLBssb6M+1/r9JrRLOUP3evsiWof0BXAb0X2hD31TuafUEXD/Y
	 n6RmRjXbR2EuyJCR4/BJBZwsSJmsCXaH6BfSfTYt5uMGGbKcue6+mxY/BTVTpPkNVR
	 RaSCwRuix2C7u/wvEf3vYPWbgBZU3jLdgqqN8cAVmqeLtSBPRKXwH9oDt2wQ8vDLMf
	 SHS7VOfUCZbaX7BS2Qp/8FsideHm4G+QbB7LMYZS3u6+wBV+f7un107LYul/NCf2SK
	 j5nDqgQameEmOFTOow5Ujnh5kEeD3iIUhZQaKCnHh8TuXMVmmuh7YvMlmvFAeQeqyx
	 vih+iFByI8NgA1S457AdecfUXlCJVUrh+SNIH0VRS4EpgoYvCXhJXphKy8pNERl9x0
	 DWR7DElRoAH752/k33mbwITQ=
Received: from zn.tnic (p200300eA971f9358329C23fffeA6A903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:9358:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0C95840E019C;
	Sun,  8 Dec 2024 10:45:10 +0000 (UTC)
Date: Sun, 8 Dec 2024 11:45:03 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] irq/urgent for v6.13-rc2
Message-ID: <20241208104503.GAZ1V4ry-o8Pf3jrGR@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the irq/urgent lineup for v6.13-rc2.

Thx.

---

The following changes since commit cc47268cb4841c84d54f0ac73858986bcd515eb4:

  irqchip: Switch back to struct platform_driver::remove() (2024-11-26 20:09:06 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/irq_urgent_for_v6.13_rc2

for you to fetch changes up to 9151299ee5101e03eeed544c1280b0e14b89a8a4:

  irqchip/stm32mp-exti: CONFIG_STM32MP_EXTI should not default to y when compile-testing (2024-12-03 17:40:30 +0100)

----------------------------------------------------------------
- Fix a /proc/interrupts formatting regression

- Have the BCM2836 interrupt controller enter power management states properly

- Other fixlets

----------------------------------------------------------------
Geert Uytterhoeven (1):
      irqchip/stm32mp-exti: CONFIG_STM32MP_EXTI should not default to y when compile-testing

Lorenzo Pieralisi (1):
      irqchip/gic-v3: Fix irq_complete_ack() comment

Stefan Wahren (1):
      irqchip/bcm2836: Enable SKIP_SET_WAKE and MASK_ON_SUSPEND

Thomas Gleixner (1):
      genirq/proc: Add missing space separator back

 drivers/irqchip/Kconfig       | 2 +-
 drivers/irqchip/irq-bcm2836.c | 3 +++
 drivers/irqchip/irq-gic-v3.c  | 2 +-
 kernel/irq/proc.c             | 7 ++++---
 4 files changed, 9 insertions(+), 5 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

