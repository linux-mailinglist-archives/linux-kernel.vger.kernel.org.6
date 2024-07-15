Return-Path: <linux-kernel+bounces-252903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C02339319B1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F05E61C21D6C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 17:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3BF6BFA6;
	Mon, 15 Jul 2024 17:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NLJIjcoA"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CE56A33A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 17:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064894; cv=none; b=dLeEOtgAC21wcU/1rBar41zZD9FstdzBhnvEpfr9R3PcHC379QW7iN2AMAAHUSMAcBNNDGPPbQoMUqi4ByAnNk55OWnfouARsUA7gVCbOZhfgNenoh5bfujykwCFtEWgkkomdv3rrxttzBALxwSMDtoaY71KKs1MqQtfxOjcj48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064894; c=relaxed/simple;
	bh=zHTYgJUSd8AMhAtmrvgOtc17tYwT1AAFxi+FCTnDc+s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tHUVBykWJ9F58ChnMbqeIH/+oituyQ0rqJlcPTEFLlCv59+1ImEggKPBvzyUryJt2U93+pzt0IqhnYOgufrvjUeewvHcYhleuuxC28pl0nn2sX3hXf5FSLmbnnhe7r+xtI0wx16m7sCocwuc+qHhFkYIr/RwzgIxDkH7EaWWeC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NLJIjcoA; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4456F40E021B;
	Mon, 15 Jul 2024 17:34:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qH_f3mQmR0kk; Mon, 15 Jul 2024 17:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1721064883; bh=JbobzmRoh+ZaGzHFkvCxcb2mG2S653Y2TJEqXrSj0mI=;
	h=Date:From:To:Cc:Subject:From;
	b=NLJIjcoASna5vaBrsxsNo+JxJdsK6kTBvJ3bYno2UWu4C5rfP3IUI4Hpi7hEWzM8a
	 iVLcNmbSddxVvj43BLw5IL3S1j2l9JK+Zcm1TnCPI5Qxol40GYu00tKIeq9hn3361T
	 L//zfGqxsNrCacxvV3fTtZpZH0GOd8RcSX5xf3nYnTSzDGJLkh6iC+NDwuOMuhV17B
	 5x8Il90zORozsA5Z1XwlL3+MsDlUxJ61v3DQoTRv4YJUjNlAPDQQYmZOjXQVFmSgha
	 Is27ZIfTjfbOsAxJ1PW7p5JDPXlfsa1whqbfXfr0n6LVn7M8Lti+SrKPmK+Z2qBJx+
	 +CEkYaL0utPYZltA5GRk0NS1hMkeIsmHDcskLIdwjWJRa+I2PPHyEGCMXkw5GORrlL
	 DwUhTxZ8j9DwpTPi0LeP+18cPWaAXOjnUUha36wtE/aMR6tKcIfh+AltrWq804N8tr
	 LPSF5L2D6t50LrtUsYDTnpd5L2IPpb6v1kdkCUvNKZEaYaEvAvNd2JC7S/NK8CPCyf
	 TVjIL3W3bXlgCET5MKVMSvtPS57ur16Kn39o8piKjGqIhfijw5kg6OpMCOw1dN+C87
	 qtccJo/5Me4gNxz71JOC++NgCP4SjAIbUXsLkL81k/ilNwsvgkHuOFJ3UHcT6dErHU
	 C3WLWViztcF/8HmxJSX4loGQ=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0CC6240E019C;
	Mon, 15 Jul 2024 17:34:40 +0000 (UTC)
Date: Mon, 15 Jul 2024 19:34:33 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/bugs for v6.11-rc1
Message-ID: <20240715173433.GAZpVdqWGG1ymjPfER@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the x86/bugs lineup for v6.11-rc1.

Thx.

---

The following changes since commit f2661062f16b2de5d7b6a5c42a9a5c96326b8454:

  Linux 6.10-rc5 (2024-06-23 17:08:54 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_bugs_for_v6.11_rc1

for you to fetch changes up to 42c141fbb651b64db492aab35bc1d96eb4c20261:

  x86/bugs: Add 'spectre_bhi=vmexit' cmdline option (2024-06-28 15:35:54 +0200)

----------------------------------------------------------------
 - Add a spectre_bhi=vmexit mitigation option aimed at cloud
   environments

 - Remove duplicated Spectre cmdline option documentation

 - Add separate macro definitions for syscall handlers which do not
   return in order to address objtool warnings

----------------------------------------------------------------
Josh Poimboeuf (3):
      x86/syscall: Mark exit[_group] syscall handlers __noreturn
      x86/bugs: Remove duplicate Spectre cmdline option descriptions
      x86/bugs: Add 'spectre_bhi=vmexit' cmdline option

 Documentation/admin-guide/hw-vuln/spectre.rst   | 86 +++----------------------
 Documentation/admin-guide/kernel-parameters.txt | 12 +++-
 arch/x86/entry/syscall_32.c                     | 10 +--
 arch/x86/entry/syscall_64.c                     |  9 ++-
 arch/x86/entry/syscall_x32.c                    |  7 +-
 arch/x86/entry/syscalls/syscall_32.tbl          |  6 +-
 arch/x86/entry/syscalls/syscall_64.tbl          |  6 +-
 arch/x86/kernel/cpu/bugs.c                      | 16 +++--
 arch/x86/um/sys_call_table_32.c                 | 10 +--
 arch/x86/um/sys_call_table_64.c                 | 11 ++--
 scripts/syscalltbl.sh                           | 18 +++++-
 tools/objtool/noreturns.h                       |  4 ++
 12 files changed, 86 insertions(+), 109 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

