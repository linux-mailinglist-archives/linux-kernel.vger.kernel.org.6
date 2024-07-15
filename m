Return-Path: <linux-kernel+bounces-252458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2466931353
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 13:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881D12845AA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 11:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6F51891B0;
	Mon, 15 Jul 2024 11:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BkacbQPM"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9116A039
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 11:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721043951; cv=none; b=XnmQabpNklKs+c6wmyVrNoFNGWyY0GtbzyGuyRbCQIE4FG2fXOvjxIkU+rBwAD442aX+Xd6xs5g0M+ifWaDF+R+q0Ig/X2JzhKwZsL7urJ9CE7lhKtJ6pQe+cZzEQPqcSNFnioNmhX9HKIsbUnlMru4fJ6B607isP18kQoWXHlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721043951; c=relaxed/simple;
	bh=f0yTWDRZBo9XYJkLfy0ZVqBiaNvsuRcfFSv6+YRSvYs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=n9N/PqXRc9U0l8uJqF3yCTt9rSrAZdB26QkOs5D+I8mCIDYOHk4zIu1+pcNiBktviKj9PnsPJIO/KxsYY5OJBOITxqhSP7uUjDXWioj+Alm1+CXz9WlZ8zcba5i0w0sEe5b63d79tngsyTMJAW7tvsPKBikM8AjfMAjOd6EtW8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BkacbQPM; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7148F40E021B;
	Mon, 15 Jul 2024 11:45:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZIYkWI7xacgA; Mon, 15 Jul 2024 11:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1721043945; bh=jId0y6P6FAEZ3Jiqg2bTDr/X1faFTitxsJ8Ls8T+ELk=;
	h=Date:From:To:Cc:Subject:From;
	b=BkacbQPM1NOZfva3XsdZ7ROJ+H8O0eHLfVblT0W33A8PzX7Es3Sh6Ulj9jkECkZqe
	 uKjWdFf0vzzqPsi9OmI0ClYHsNoZ+cbUzuQ2UOyWibFX8evLkIeWrzfptuW/drkGYA
	 RfRWTZJDo2wcT6YLgYbtvBHE2ITDMKhQOX6iG2Dz4SunNj0EZ07WGv1A6oZbJCyYHx
	 uV8Hr8lcFg/ffGNXrCsbzajhzIKHsm36iyDS/UTu/Asv0npYQLOk5AHoG0dXPHhfqS
	 fsRvY3mxuC+f7w8BSH4b7+wI1eCWkuH8F/+IAWdLX1A6h6nucZucfliMpyS5MQUuKx
	 Th8+giFiVhxUkDCUGhY3Kqk4BVxF5E5/sz6VVd2Pp74NdJhft23BYtKBKz/jKYI/R+
	 lXx1lSk7Y/k3BhbT6heBRsHD9WT/RscHpy+gdZfLttp4tnMYM3+0oU3scv5aq1qLqm
	 3BzIa15+2AKetnHCQ+/Id5JlS3RIUrdZX71NbezcPSA6sKMHISU3BHRJ+xb7e2tQNI
	 lxN/7CQkkjbzS8I4sgw2J3M7yjRurQcJdHXlbn0IswcI6sC7f+ZBk3vz/tzW9ofMVH
	 mL5zoWKQrTAX/MlZh6xs8dG8HEU0g4ZmQH11FTjxuWwMrXmIffcYOgsp/61OSUGKuE
	 vn1i2654G8gxAjJ0PmEgUCMI=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DECD040E0192;
	Mon, 15 Jul 2024 11:45:41 +0000 (UTC)
Date: Mon, 15 Jul 2024 13:45:41 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/core for v6.11-rc1
Message-ID: <20240715114541.GAZpUL5d-GJH9RQ25O@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the x86/core lineup for v6.11-rc1. Basically your own patch. :-P

Thx.

---

The following changes since commit 6ba59ff4227927d3a8530fc2973b80e94b54d58f:

  Linux 6.10-rc4 (2024-06-16 13:40:16 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip x86_core_for_v6.11_rc1

for you to fetch changes up to 8a2462df154799129d8259079ec1fecf78703189:

  x86/uaccess: Improve the 8-byte getuser() case (2024-06-19 19:56:07 +0200)

----------------------------------------------------------------
 - Cleanup the 8-byte getuser() asm case

----------------------------------------------------------------
Linus Torvalds (1):
      x86/uaccess: Improve the 8-byte getuser() case

 arch/x86/lib/getuser.S | 69 +++++++++++++++-----------------------------------
 1 file changed, 20 insertions(+), 49 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

