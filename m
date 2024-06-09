Return-Path: <linux-kernel+bounces-207304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEED890154E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 11:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B67FB2820D9
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 09:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB8F1CF92;
	Sun,  9 Jun 2024 09:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="SVVysXUf"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A53DD51E
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 09:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717925400; cv=none; b=e2YmhC0CVLSFJ1blVhBokvKJwJBjIxrAkdnt5IHRG1lyT721HkQsBQ/DD+wcsad4iJhIoodW7kFkGx64I7hX985xrNZhvKCGppdmioYiL8n7HUpQ3XmV3CCKVzsm5MnMgcsWOCKZus9U3chHJNr0zTA6SEI9H+JW/g802Y6fl+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717925400; c=relaxed/simple;
	bh=LqWX8wWHJZhnMooernAGHq7Of7mX1CTp2okNICELCwE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RO8dtaF8Elhwvq+HJLige+AECiBPUTaY3IgyDmCC+jAHTU7tHumg7IxaxglJDXAJIUOExIJNyckjcrU1R4X3HhIWQ7MqC3p1geDV6XwEcveSE2MeAD0lQifLgwndPzGH81N7baA2Sw+JNa/qOMvUbW7mwB8btZS+E3vXRD+7weA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=SVVysXUf reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D065940E016E;
	Sun,  9 Jun 2024 09:29:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id d8PBt5z1Vr1E; Sun,  9 Jun 2024 09:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717925389; bh=FeIeUTfj/mtsr9foDOiIer6mP7/wHiyT9Q1v0CqbZnU=;
	h=Date:From:To:Cc:Subject:From;
	b=SVVysXUfe0GNjFExp3451XkKfkhz8oCyx9fJS4PbRCF0fBil5TRGmSlAtw6+4ogpC
	 EM6MO2aLRKB5xJC+C1Y8+4PCNMmWv1QRIlh3NYyTdrJSHlWGUqXWBnVrJPGJGuLV0t
	 mvc/vhqH5f4+daMdD2oZUmr9T19NL9gbB53fyEUDeIQx8KvzIuzayXGIhVx3z/7CV5
	 O17RQ52YJC7INbOlZ11oVQUdE6ISqaVZROGuBWMpsiBF83HOXE8ItU4ci3yiRhshMF
	 +dGLdB6CUmkGRuyVXelpb2m6I+bEX0zlCwDG6ut3ykw9jBVjo76SFg2q0M6BsIufwV
	 NwUfNsLwQIA0wIYb7/upFLB04Zp6+EWmYdYAojA3nYgJek/pFYU8TRzqbdRTe1bjw6
	 N6jldL5DG13rewBafSeKN/UETQ2VkZ0QS2SLiR3DyeM1rOQ/NUpw2gQcr1uCMQqoW+
	 nmI5fMW/X/ANMCq7ns73vHYk/6yyThBERe4UTKTUrpRk5HlyqTU2FiqcmGwj3Dd6eY
	 CDMQ5/zZk9Fxqg5Ze/lYw5WOjwjv68q/V150bf1VNBxDrJFX9hZu7laqrginCzG3GM
	 OS2WeUOkHatJtCtNQBrvZsiIvBa29iyR+rxoS48QZJsfSHSnH/DIc4m7rysH5abVHZ
	 4pRKljs6R3gCzglCnqMIIN84=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5BF3D40E00C9;
	Sun,  9 Jun 2024 09:29:46 +0000 (UTC)
Date: Sun, 9 Jun 2024 11:29:33 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC urgent for v6.10-rc3
Message-ID: <20240609092933.GAZmV1_Q8VbuAw_e7-@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

please pull a couple of EDAC error codes propagation fixes for v6.10-rc3.

Thx.

---

The following changes since commit c3f38fa61af77b49866b006939479069cd4511=
73:

  Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac_urgent_f=
or_v6.10_rc3

for you to fetch changes up to f8367a74aebf88dc8b58a0db6a6c90b4cb8fc9d3:

  EDAC/igen6: Convert PCIBIOS_* return codes to errnos (2024-06-04 11:29:=
52 +0200)

----------------------------------------------------------------
- Convert PCI core error codes to proper error numbers since latter get
  propagated all the way up to the module loading functions

----------------------------------------------------------------
Ilpo J=C3=A4rvinen (2):
      EDAC/amd64: Convert PCIBIOS_* return codes to errnos
      EDAC/igen6: Convert PCIBIOS_* return codes to errnos

 drivers/edac/amd64_edac.c | 8 +++++---
 drivers/edac/igen6_edac.c | 4 ++--
 2 files changed, 7 insertions(+), 5 deletions(-)


--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

