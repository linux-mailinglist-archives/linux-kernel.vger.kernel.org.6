Return-Path: <linux-kernel+bounces-412922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA889D114D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A35B72840E7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53AF19D087;
	Mon, 18 Nov 2024 13:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="aSXpgXLX"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB27C1B85D6
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 13:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731934891; cv=none; b=Zh3MbPBtY/Z3yETmjaqLlzToI/GvxejkQTD5ojg5Q6UbrkP7BphasfK6ArkiSixAhufNQCsG+WQFzxVYu4Nmt/Vl1fOMt1g5cjorqH99igxMIhJLLTUdKjjwqUXAnFeG7CznLEtSJuLv47SZmZVx1ZZ/Yh0XPGzcIm0FnwtpkhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731934891; c=relaxed/simple;
	bh=rFP1tZlaM51qE+7udRa9stuQOFa3ybYtvo2rUhxF5dE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=f9UNDeNVm7M1cxhgGfvmSFprgrX7PIip6RbU9AU9kbWAjofD5rYYr4U/5UWpLDDpynTdHSS9cZG/ZoGPxVFq7LcfzYX+R14z5K5Pl3VaKOtMXG+BXitYCqSGr1ID3oAW7ikhdYMw5wpJeWu03+qUa20Mjy26oozq1vsibVGQcM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aSXpgXLX; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BC21540E021C;
	Mon, 18 Nov 2024 13:01:24 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qXcCZ0i8SBWG; Mon, 18 Nov 2024 13:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1731934880; bh=Wydnuzs1+g6rOh3FGoYEqEbNqNzZpuBNE6+Tu2bMMxs=;
	h=Date:From:To:Cc:Subject:From;
	b=aSXpgXLXFFr888exPuKWDZ2rQnUPsMCvRYZ6iDSdvuI7hEpVYpz0dTDwCdKNeIH0o
	 WRvgyY+jwvCpHPPzXFhvA3qIu99PVh7S0e9zZqV683h2Xk1Jc53+JeFZoHcF4t78ah
	 mSWiUq9XVLG7aHG6v/ABFJL2t39QhAZoKeuuu28Tdeb50XYK6JX6B2j4TFi3Nsoako
	 qDQ4Taxqdv6Wow0l5Qd40iEwdPeugU/JGWlaq29sFAIpvMgYnaWhd5V9OsMHTTtD/t
	 OzLvA38o6Ugob4DZFePPlkAeqY8qOwqwKIgi4ntDOJPmhSDw8JFVkejZnK2YcGPemM
	 zkD9VfxJtFP7L71WKOi/hMFWnAv1zQgXwaCfiV2KFxEfaOY/n06zKHWtmvaaqREiyb
	 pAZEVAJYGc98l/et8dmlyHaklSfHfLMS8ePZtIsU+hypCnxqrZyDM2a4LuVUWksBtO
	 5eGICVxIqoIzLnxW9ko2okpFBc3BX6Hqle5h4VTea5G4T/Z7ScdTlJwAS2fMlf0TDn
	 xUVy+X8NuWYIr5grDP7VOU9sX2w0ftuzud4ngfuOA7kvxkO18OhWwpFMHD/Edpm4I6
	 /hsiM4g6xIfijPMAj7kDsXoymDngpWSU+iaYlRTog4ExZSZjFQzo0SuCGlOQFMtjtn
	 qF0ap//W04+7U3RDHrxWAFcU=
Received: from zn.tnic (pd9530b86.dip0.t-ipconnect.de [217.83.11.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 410B740E0163;
	Mon, 18 Nov 2024 13:01:17 +0000 (UTC)
Date: Mon, 18 Nov 2024 14:01:10 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] RAS updates for v6.13
Message-ID: <20241118130110.GAZzs6lqpsvuNu9vvz@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the RAS updates for v6.13.

Thx.

---

The following changes since commit 81983758430957d9a5cb3333fe324fd70cf63e7e:

  Linux 6.12-rc5 (2024-10-27 12:52:02 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/ras_core_for_v6.13

for you to fetch changes up to 612c2addff367ee461dc99ffca2bc786f105d2ec:

  EDAC/mce_amd: Add support for FRU text in MCA (2024-10-31 10:53:04 +0100)

----------------------------------------------------------------
- Log and handle twp new AMD-specific MCA registers: SYND1 and SYND2 and
  report the Field Replaceable Unit text info reported through them

- Add support for handling variable-sized SMCA BERT records

- Add the capability for reporting vendor-specific RAS error info without
  adding vendor-specific fields to struct mce

- Cleanups

----------------------------------------------------------------
Avadhut Naik (2):
      x86/mce: Add wrapper for struct mce to export vendor specific info
      x86/MCE/AMD: Add support for new MCA_SYND{1,2} registers

Qiuxu Zhuo (2):
      x86/mce/mcelog: Use xchg() to get and clear the flags
      x86/mce/intel: Use MCG_BANKCNT_MASK instead of 0xff

Steven Rostedt (1):
      tracing: Add __print_dynamic_array() helper

Yazen Ghannam (2):
      x86/mce/apei: Handle variable SMCA BERT record size
      EDAC/mce_amd: Add support for FRU text in MCA

 arch/x86/include/asm/mce.h                 |  36 ++++-
 arch/x86/include/uapi/asm/mce.h            |   3 +-
 arch/x86/kernel/cpu/mce/amd.c              |  30 ++--
 arch/x86/kernel/cpu/mce/apei.c             | 107 ++++++++++----
 arch/x86/kernel/cpu/mce/core.c             | 216 ++++++++++++++++-------------
 arch/x86/kernel/cpu/mce/dev-mcelog.c       |  11 +-
 arch/x86/kernel/cpu/mce/genpool.c          |  18 +--
 arch/x86/kernel/cpu/mce/inject.c           |   6 +-
 arch/x86/kernel/cpu/mce/intel.c            |   2 +-
 arch/x86/kernel/cpu/mce/internal.h         |   4 +-
 drivers/edac/mce_amd.c                     |  22 ++-
 include/trace/events/mce.h                 |  49 ++++---
 include/trace/stages/stage3_trace_output.h |   8 ++
 include/trace/stages/stage7_class_define.h |   1 +
 samples/trace_events/trace-events-sample.h |   7 +-
 15 files changed, 329 insertions(+), 191 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

