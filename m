Return-Path: <linux-kernel+bounces-516506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A45CBA372E9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 10:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7325B1889A7F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 09:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F702156236;
	Sun, 16 Feb 2025 09:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="G+eOAy1E"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605E613C682
	for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 09:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739696422; cv=none; b=MucvXPDxs13cqvv2ORKzpSQyzFt+jGiQMRiMJ1Co96QnmGkLpy0FoaLlO6IKCGynv9qjXD55pOXyv0ZRO449oisB3z4H/2nwB8KOOb1jEOAd5dtmwSbnWxkruDNnRfn5MRoIusc+WfhtytdpqACAdrzXrzTLRmy6bJIS8dRy0e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739696422; c=relaxed/simple;
	bh=EfYAyriXNM/qSoolrJQboWYPWj0SmdItgk/ObDmbGTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ssn12m8+AOrcU9hm+I8D3/cObnI40MwT3h8uHjgzF0rCpofS36sE8ByIQCmspwhWAuJf2Wb7H6VvP8qRZUjjEZPCpstJGBx7Fg6yXt096+vYQX+MpfNOA2T3P15qS+KFp8XkM+XA/zrtZk8Gr/2xaVC80Q5anUP3Ozu9TdMcWmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=G+eOAy1E; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 12CCC40E0191;
	Sun, 16 Feb 2025 09:00:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7liuNlhF0BIG; Sun, 16 Feb 2025 09:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739696413; bh=Lgewwa0gpgwMCyCDZ9aXwVbXpivGeycQwcmTefXM5sg=;
	h=Date:From:To:Cc:Subject:From;
	b=G+eOAy1E964b0bxyn1ReoQArifoGOQL9vhmXgkpVlS6D45mbVK6TAn8Xlqi6iDN+e
	 hgmqZtYGmYPQmpyZgg87MlrLCg/9NzoGB9FeH++Sk0G9dhLQcvWu9teB2RSOSX/Xzq
	 KsQxaHkMyO1WFAOA8aRrjZdHkQAM+1B4EBnDwLT1neofpWU0AtFtE3eSljcs2W+1BD
	 LEavVbgt3OpANmAniTSiCrBtahs9oa3tniHkpy29TBAhxeq/+dmJU1gMgpi2R0917M
	 jIEAhhesWNfgwk+lOACGzgappWzkDedx42qVCk9dIl2WutyLkE4AdEYgG4oIXrYPvl
	 h3BdhgZEmElhZSD1YGVl3e/J0akUDmikcDnwqGr7tt1HTJOU5FVl3WhjqIlcBWcB8e
	 7YZciVtq9XtNnrWJXJUTii8M+94FM/hq1f/u7lw+gGeaZ2j4G6bCjC3PQhPQv7+S12
	 OMH1T/ZjHa+il2/iVUuB/y4357gof78fP1xF1zElRjp6cwRtX5GdApP+4oLNO8dAcl
	 XYckTgD6Wx/+/JG9m+OV/btobKpl9uRck0KaewVr82F1T7paZX7F0XEoQ6oftzfVpV
	 VjFtguqgnPF8IlikvFqfGnkGkGakLGUVc9FXD/uCEY0wlM+aYmRFnHemOEkwwTI/SQ
	 gXdLLUw6Lw0OYDGcpW/CdNq0=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 57F8640E016A;
	Sun, 16 Feb 2025 09:00:10 +0000 (UTC)
Date: Sun, 16 Feb 2025 10:00:02 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] objtool/urgent for v6.14-rc3
Message-ID: <20250216090002.GAZ7GpEpdWUKHyUtr4@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the objtool/urgent lineup for v6.14-rc3.

Thx.

---

The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:

  Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/objtool_urgent_for_v6.14_rc3

for you to fetch changes up to 7e501637bd5b702a2fa627e903a0025654110e1e:

  objtool: Move dodgy linker warn to verbose (2025-02-08 15:43:08 +0100)

----------------------------------------------------------------
- Move a warning about a lld.ld breakage into the verbose setting as said
  breakage has been fixed in the meantime

- Teach objtool to ignore dangling jump table entries added by Clang

----------------------------------------------------------------
Josh Poimboeuf (1):
      objtool: Ignore dangling jump table entries

Peter Zijlstra (1):
      objtool: Move dodgy linker warn to verbose

 tools/objtool/check.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

