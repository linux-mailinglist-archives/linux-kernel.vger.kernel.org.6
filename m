Return-Path: <linux-kernel+bounces-403175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFEE9C31F3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 13:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18E201C20934
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Nov 2024 12:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFED15687D;
	Sun, 10 Nov 2024 12:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="amKl0RHp"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B714149C4A
	for <linux-kernel@vger.kernel.org>; Sun, 10 Nov 2024 12:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731241692; cv=none; b=rc2Wagr1oCKe/dHqBTzA/WnN6xn1sDf1zM3FRD8fYnnNz/ZzmWum08aGXaq/I0xLUOy53XwWD/ZBJwPh1m5MBmQlK291hIlKXglLIkCghRz++P40ZotIlXqQgfohlLHDS8+1KAJs5fBVxPoIcjVOOaxQRV7w+k8Ldizz8lkbaR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731241692; c=relaxed/simple;
	bh=UaSxx09/rBgt/0qGafJf8Kl8J3/QjMtT3bmaOIdf6es=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dSd4ky2lsPdxD6P/9j5odtyrAvBWx7ubfUMSPPO8BXvOqLAvNcF+snMeCVXFDG6p1mzaK+pyvs1FyWqooZCmzAcKY7RTIgw20eUqXP75R86sRd0L3XzeJiodEzXDcSzHZxpZvL4A3ulHoBZELu8gxvHPgDtg1mg3HeinAXd+v/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=amKl0RHp; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2CC7640E0169;
	Sun, 10 Nov 2024 12:28:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wiN-Tm4JIZ5t; Sun, 10 Nov 2024 12:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1731241683; bh=O/fmltV69mMZbltRFNrebXs+seHsTBNMqxI9J2yyGqQ=;
	h=Date:From:To:Cc:Subject:From;
	b=amKl0RHpOhZmu7u5qLNpJvouzpRJKpsDY5RFJRWRi2d5iAf4G07EhE/dC4MrA5c/6
	 jNu6AtQ7vgytzcgHUfiulmwnDnE+gSduERMX0ztZZ5t3VzgqTCLeAQ26iEZmaNGcV/
	 XHu3wEooWbeJkKe0QOcG/3KbIKEk+Xxz6jy9/1ePBtf+5YK+4FQYd4aLI0w4kbJn/G
	 WkliDALZc37h1ROkpHZlQSowCy0AU6C96gA9pM8pW7nZRhSoljEz86KXWukCgexM6E
	 a1CTADz20irObxZ+Nq4GAMdi84fGkP+tPY7zl7IHPSo1UoeSmG+3VxfG7GbFK+/I4O
	 q00/96VYiu2kLPyDGJd2eftjZmNNaR4LTYL8IScaLVHSGEJCJcp51I6TJx96Rk7WVG
	 BDe3+nsaBu/xdAfxyDgGqMmEOG4Jm4qXAbsyD/rYYruRGKiJmCGnS8/CSaSupn6bfM
	 sknmIw/dmZtIwoenPfgj7ZDnQRP+eOZoZ3MxNiiht2nphT6iLJuT5Ea6jOzppjihYA
	 2QmuBDTr45pgmA75/dr8zE5a3P5Lk5VbQGhn/BYfvIHVWtr+UAmQH3Mwdg//zKmBZ4
	 rusMCMXnit/LCCE1k858INWdVf8VvHa9uKmkJjyNgHmp/dGah0SZSPAVHjc1m7fkms
	 +7sFG7iCXJ2RMpONhgmUtd7A=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B307440E0028;
	Sun, 10 Nov 2024 12:28:00 +0000 (UTC)
Date: Sun, 10 Nov 2024 13:27:54 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] irq/urgent for v6.12-rc7
Message-ID: <20241110122754.GAZzCmyq5OfNCN4_Ts@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a irq/urgent fix for v6.12-rc7.

Thx.

---

The following changes since commit 59b723cd2adbac2a34fc8e12c74ae26ae45bf230:

  Linux 6.12-rc6 (2024-11-03 14:05:52 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/irq_urgent_for_v6.12_rc7

for you to fetch changes up to 464cb98f1c07298c4c10e714ae0c36338d18d316:

  irqchip/gic-v3: Force propagation of the active state with a read-back (2024-11-07 00:22:44 +0100)

----------------------------------------------------------------
- Make sure GICv3 controller interrupt activation doesn't race with
  a concurrent deactivation due to propagation delays of the register
  write

----------------------------------------------------------------
Marc Zyngier (1):
      irqchip/gic-v3: Force propagation of the active state with a read-back

 drivers/irqchip/irq-gic-v3.c | 7 +++++++
 1 file changed, 7 insertions(+)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

