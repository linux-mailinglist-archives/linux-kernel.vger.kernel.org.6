Return-Path: <linux-kernel+bounces-426586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 779B79DF54F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 11:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4C1BB20DC3
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2024 10:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DDA139CE3;
	Sun,  1 Dec 2024 10:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="KoxfH2T9"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1D82B9A2
	for <linux-kernel@vger.kernel.org>; Sun,  1 Dec 2024 10:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733050697; cv=none; b=gRHViVmlYbztJze1KZSiv0CWxeG2SJ4MJpQHCpnx3dfrsqSuAaBPgfYg7HkR+mqEYHoqUkDJH+v+UdpGz7aZjMQMlT+92VMPLtQjLNQIcLGaUNhG3FoibFDIp7FGi5bVPwyvdZdkKisg99AFqusznynvn9E9Zy4A5Gh9UjsIFW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733050697; c=relaxed/simple;
	bh=mCH6LwWNKTAOxwyBbB2by2LIW3TpbnGbWIvmRqcUb2o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TQZGAp+lY2eVHQoQk06rvFo16iBsfu0tqz53ct/zURPV/BtOxvw6rqPKgKHVCZdfWs8MnICovQX+4PMWT2VENnPhh6gqZmTi5vN8Emg7mTaHeADCXRoJKRKF9kZ0ycIvJ9MoypJ1NteIa0H1TXXHhUnDVWO7hh270p/Fz/cxkWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=KoxfH2T9 reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9DDB440E021C;
	Sun,  1 Dec 2024 10:58:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id M-lEFpz-gYGW; Sun,  1 Dec 2024 10:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1733050686; bh=+3vY6/eXK/xfO05lSRYbZvSJw5V2HftOj5dgVgS4qEo=;
	h=Date:From:To:Cc:Subject:From;
	b=KoxfH2T9sirGfogdt0oGnKu1/qhKsIDquOTc4po2rQlkYjfuVH01TT6vm4jChzVyM
	 fAlKqWBq4CtYe07mMCxOJk4QVJF2oyobjIrgj2pj/kUKQFOnCtEojm6fG+9+Fq6r8l
	 BKFZa9+4pJBl9orUEvp10lhOU4oXLoLDY1E5jIGiYGzN6JBaW6LKCLqiHNTqkDC23A
	 PRbZtIV11GDy6OYrrZGDMdZ5YDLQCpvIsgpH9JWzJ3a+Hc6RYwHNYyV8jx+uUfUrTw
	 AzLtMEwp/ZS4JeK9x7+EhRLv/Htv2B5rwGnV9gqbSBVm/s9rYzeb00JlFZ7N9NSiD9
	 bm8FD54Om8S2cQQsdvDU8KtU9tEDN21GAyAAWHYUWPvoZ+0k/1g0Z4ETsaybcQrYAE
	 ftDCrPk2JS4q5hG+9wbgJnvPAZcLu9Ks9IVjA7Iv3YnkvSHNHFRuYvtIoR6cGADr6g
	 IyMZ+R4vhUsD6Cy3rfkxF8ZJLvrqYkFW97ZLTsf7p7naXhVHtilZ6gMEabQAYH3epZ
	 wOwDMpqHaGDZwXqJxm+VHjyD9oqA48V8Q9Rz87UA9HpI5gD5BC/xy0FTgapKOOKrKl
	 oi8aoClBrRXlcbnTda4VOY5SXAEpOmFwWAJkAREnUcGxXHdjtsMaEuMFUEBQKbmd1j
	 bYbYm3g3+VhE7i+77z/5+uE4=
Received: from zn.tnic (pd9530b86.dip0.t-ipconnect.de [217.83.11.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B623440E0169;
	Sun,  1 Dec 2024 10:58:03 +0000 (UTC)
Date: Sun, 1 Dec 2024 11:58:02 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] irq/urgent for v6.13-rc1
Message-ID: <20241201105802.GAZ0xBOqZH001RiV4D@fat_crate.local>
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

please pull the urgent IRQ fixes lineup for v6.13-rc1.

Thx.

---

The following changes since commit 7eef7e306d3c40a0c5b9ff6adc9b273cc894db=
d5:

  Merge tag 'for-6.13/dm-changes' of git://git.kernel.org/pub/scm/linux/k=
ernel/git/device-mapper/linux-dm (2024-11-25 18:54:00 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/irq_urgent_f=
or_v6.13_rc1

for you to fetch changes up to cc47268cb4841c84d54f0ac73858986bcd515eb4:

  irqchip: Switch back to struct platform_driver::remove() (2024-11-26 20=
:09:06 +0100)

----------------------------------------------------------------
- Move the ->select callback to the correct ops structure in irq-mvebu-se=
i to
  fix some Marvell Armada platforms

- Add a workaround for Hisilicon ITS erratum 162100801 which can cause so=
me
  virtual interrupts to get lost

- More platform_driver::remove() conversion

----------------------------------------------------------------
Russell King (Oracle) (1):
      irqchip/irq-mvebu-sei: Move misplaced select() callback to SEI CP d=
omain

Uwe Kleine-K=C3=B6nig (1):
      irqchip: Switch back to struct platform_driver::remove()

Zhou Wang (1):
      irqchip/gicv3-its: Add workaround for hip09 ITS erratum 162100801

 Documentation/arch/arm64/silicon-errata.rst |  2 ++
 arch/arm64/Kconfig                          | 11 +++++++
 drivers/irqchip/irq-gic-v3-its.c            | 50 ++++++++++++++++++++++-=
------
 drivers/irqchip/irq-imgpdc.c                |  2 +-
 drivers/irqchip/irq-imx-intmux.c            |  2 +-
 drivers/irqchip/irq-imx-irqsteer.c          |  2 +-
 drivers/irqchip/irq-keystone.c              |  2 +-
 drivers/irqchip/irq-ls-scfg-msi.c           |  2 +-
 drivers/irqchip/irq-madera.c                |  2 +-
 drivers/irqchip/irq-mvebu-pic.c             |  2 +-
 drivers/irqchip/irq-mvebu-sei.c             |  2 +-
 drivers/irqchip/irq-pruss-intc.c            |  2 +-
 drivers/irqchip/irq-renesas-intc-irqpin.c   |  2 +-
 drivers/irqchip/irq-renesas-irqc.c          |  2 +-
 drivers/irqchip/irq-renesas-rza1.c          |  2 +-
 drivers/irqchip/irq-ts4800.c                |  2 +-
 16 files changed, 65 insertions(+), 24 deletions(-)


--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

