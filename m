Return-Path: <linux-kernel+bounces-413134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D24E39D13FD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 16:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 986B62835D4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA821BD9D0;
	Mon, 18 Nov 2024 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RoqiBvWD"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ED21AC43E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942224; cv=none; b=QvCyUaKkN2Pn3B/I4ECE5q3rBktl4T7qMI65JSkuNfIpAw+7/fklPR2RfiM3Oi+VmmKpEljQN3TScm6P3oWlPoVqcIuQ6r1tJJFV1eg+B0cLqPGOzfVqkRHLcOcz1bt60Asl79oXEkTA9h6ERvbuOiqYCDhkpD/6c7Y4rf5IL2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942224; c=relaxed/simple;
	bh=K3Dm9N8RgDQVKjLySeNTpGXytJD8NFVPT4+evyr480A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kyhC8RA+KDhTS/5mn66FK8xFAnjj0MbNAMEGH/bAS2W1UiyhaWo2qGYpDxWW9IscuNSyLO+10qJqUB97NnnPqlMg29bcg3FlLGdPuCICrFAJUt67ifZlu57K2xVaOzi5y5FnpYsWzcAti7sg3A4aS22vAWKWR6i9nP720+f6nTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RoqiBvWD; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C80C240E021C;
	Mon, 18 Nov 2024 15:03:39 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bpBu-gdcuYx2; Mon, 18 Nov 2024 15:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1731942215; bh=vGG+JtqpZ683PXXYiaVi3ln3CS179qfl7ulOTwGKP+Q=;
	h=Date:From:To:Cc:Subject:From;
	b=RoqiBvWDIjnNB945X456HDSUl19nFhTbxbidGdIff/M5pnEa73eTWB0/M67IIVANx
	 XR8Oq6fx+1mRPBLTsNEzBtDCVvryQ0kTqjNLZFRxkV62qPdLGk5ExO0y6neSV2XA+I
	 GXovamaGgM+7vv/DSmTcEwzfqra0TE/l+n+pgJDUPxHBuUPfSGA37pI3Dv6mWzeI89
	 QKzoTSTsOBTqXRmgQwDYVjKH8tJzBTcBJHb57kXTry2MGub9q1IDEH3PLQ+bW5VKPp
	 enmQjUeqAC42A3I3KwBPg+yRxRdBxN0mi7poB8aLPxBQ40QHTk3XY6ERt4MYe8S/8Q
	 YROpPcq/2UyzU63rMk4c9whSi1CZIGI5VpBBaz8yvMFqJSK3lzd/t4XZbK/cDk+655
	 rQ8S2inVVhPgihglKkK7P0p9MpcRa76Wl7+VF+2IyY9UzpvAyS12qH0iHezOqNBV9B
	 70hpnWj2yG26r29EeSGGcgBJ+WiOXLPtM4p9cI5e2cEZ12OUk7a/LH9DjxepxR1H6Y
	 jzg0m19iQk0YII7DV2YWxZknW+fmZDykWkLk4cdAeRIiNZZ346xXRYSukh376nHJCQ
	 0AUq9EZSLuh9B3CMdQB1GQqehp8S0Rr2xP4X4Lu7VOaoMKIPa4HGYLJq8cskgfoiBG
	 NtelWaq4tkE2tLqjpthJSlcg=
Received: from zn.tnic (pd9530b86.dip0.t-ipconnect.de [217.83.11.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 89C6E40E019C;
	Mon, 18 Nov 2024 15:03:32 +0000 (UTC)
Date: Mon, 18 Nov 2024 16:03:27 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/microcode for v6.13
Message-ID: <20241118150327.GAZztXP3hswdK38kJK@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a single microcode loader optimization for v6.13.

Thx.

---

The following changes since commit 42f7652d3eb527d03665b09edac47f85fb600924:

  Linux 6.12-rc4 (2024-10-20 15:19:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip x86_microcode_for_v6.13

for you to fetch changes up to 9a819753b0209c6edebdea447a1aa53e8c697653:

  x86/microcode/intel: Remove unnecessary cache writeback and invalidation (2024-10-25 18:12:03 +0200)

----------------------------------------------------------------
- Remove the unconditional cache writeback and invalidation after loading the
  microcode patch on Intel as this was addressing a microcode bug for which
  there is a concrete microcode revision check instead

----------------------------------------------------------------
Chang S. Bae (1):
      x86/microcode/intel: Remove unnecessary cache writeback and invalidation

 arch/x86/kernel/cpu/microcode/intel.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

