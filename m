Return-Path: <linux-kernel+bounces-177959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D378C46CA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 20:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3ABE28260E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE603BBE9;
	Mon, 13 May 2024 18:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NizuvP9O"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F033BB23
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 18:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715624952; cv=none; b=jltLoGVx1mUgxlbesf2ZxlxRXMwkoTlQe5FWv6Kf8dMdBPwpyucMU4v89ZqqeGHenVfcSX2Hfkc+4ac9SUZ3VfUtXnPlfiH0nLc7eb6wqki86i3i6ISNhloMBYmfWbQus4hF1he2f4uWcVNGW0+mR3fnNIfKz9GIHkz+SCbVOq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715624952; c=relaxed/simple;
	bh=VtkodfHuoeRehP7+RVMWw3fg9LMwBd0LXT4qxXoWTBs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=K8Jpkush/SlqRPTry4dovjs+oWCbTZI93WL9G68gl4aBLmsv6I+Y/VND4ISlPg54sayMV4cTfWBSbrcVVKUpE9d9tru8Y+ZHOs5JyFttWoYLrWya53HywRq5MChm5Si9Hb2tkdYQ3FXhFFCT0/4VpMSOcVM0cHroInneC7UsYNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NizuvP9O; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 78DEA40E023A;
	Mon, 13 May 2024 18:29:07 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Pg1XYjy3Lo19; Mon, 13 May 2024 18:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1715624944; bh=heJMfQ/hBgDafD7NVzacM4cXnmIHNOZJVOvGIFwdnao=;
	h=Date:From:To:Cc:Subject:From;
	b=NizuvP9OPvyOp2YmYDsV3enVQDRjKKAwDoF6HS52YBruKWxdmxFsLkiWJUUO1JCeU
	 LZtNwclMDHNs7puLXE6pKoHIA2rFgV+RGaQO9U+tJReMxG+PqSJPkELoGk8vgDXE1V
	 Bm9HPSpYZQRJIOfK+feuZUfM/jh72ZxT8TE/K/TnT7trY4CF7J7ne3A0vGGffD8aH7
	 aAKlmxalpaxtkg6aq+ed8lPR5UjKzEiiLkCShAeuL0NGGwCuTvGZa41xy/m9k47GTs
	 Eq0jm/ApSf/xX5Jp2/0F7UWoN9A8iBeDra6t3thbA51tTK93wSOnY9ln71qpFeWT5q
	 aI3Qa73kq4QcXIm7a2LWHjod0FXjZnJerdjPdzBPluHletyC4k8F1TEdAQWa+F/D3e
	 qgBNJwzJaF7mA7sbfNuUqzu6SWfHhSbLx4sF4XA5Si7xHYfIOzdOlDdkaoWrEaEOjF
	 cJlzf8VNO2RBFeKtZBvcIeF6M6zlLVOl7wNgbS5lOJMiKPqrJ5cm8OJDTd6gknoy7n
	 kYthxWGPi7pmLVC3fPjDHyhwaOBUPEi7wMyiHEVQ8btxrUQ7RX0pkIAKTBD1mrfH/V
	 AjcrtralQptp7cxcBbSsuXqc30xoUHjxCktLyr3ri5QCVXxT4zs9HKadjlYg883OA2
	 BDefPGEnXz51GGfHxbeBdgUM=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4D04540E0192;
	Mon, 13 May 2024 18:29:01 +0000 (UTC)
Date: Mon, 13 May 2024 20:28:55 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cache for v6.10-rc1
Message-ID: <20240513182855.GAZkJb52i6WCWQpXA-@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a set of resctrl updates for v6.10-rc1.

Thx.

---

The following changes since commit ed30a4a51bb196781c8058073ea720133a65596f:

  Linux 6.9-rc5 (2024-04-21 12:35:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip x86_cache_for_v6.10_rc1

for you to fetch changes up to 931be446c6cbc15691dd499957e961f4e1d56afb:

  x86/resctrl: Add tracepoint for llc_occupancy tracking (2024-04-24 14:24:48 +0200)

----------------------------------------------------------------
- Add a tracepoint to read out LLC occupancy of resource monitor IDs with the
  goal of freeing them sooner rather than later

- Other code improvements and cleanups

----------------------------------------------------------------
Haifeng Xu (2):
      x86/resctrl: Rename pseudo_lock_event.h to trace.h
      x86/resctrl: Add tracepoint for llc_occupancy tracking

Tony Luck (2):
      x86/resctrl: Pass domain to target CPU
      x86/resctrl: Simplify call convention for MSR update functions

 Documentation/arch/x86/resctrl.rst                 |  6 +++
 arch/x86/kernel/cpu/resctrl/core.c                 | 55 +++++++++-------------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c          | 40 ++++------------
 arch/x86/kernel/cpu/resctrl/internal.h             |  5 +-
 arch/x86/kernel/cpu/resctrl/monitor.c              | 11 +++++
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c          |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c             | 12 +----
 .../cpu/resctrl/{pseudo_lock_event.h => trace.h}   | 24 ++++++++--
 8 files changed, 72 insertions(+), 83 deletions(-)
 rename arch/x86/kernel/cpu/resctrl/{pseudo_lock_event.h => trace.h} (56%)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

