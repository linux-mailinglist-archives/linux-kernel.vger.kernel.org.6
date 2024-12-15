Return-Path: <linux-kernel+bounces-446379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D13729F23A2
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 13:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E141316580C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 12:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8453B17BB32;
	Sun, 15 Dec 2024 12:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DKgegFXS"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C987617B50F
	for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 12:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734264781; cv=none; b=tLw7F0K7vCq3x5usVhWh12G934Q6TBV2waAqx1/A7tCbV8iZqmPe9vbHgAXWuWJeNXsewnTKdTsXy+RIpDijW23Y0gH9thMU0Od2DO4aZX2WOqbRvV7piKu0SjoB1xs4PdcWXxyKVT6dh6lFN2jd5/DHt12IQPu253fHO7vM3Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734264781; c=relaxed/simple;
	bh=TttqRsVgCfE6r9ebvMRJELkBmgx7mejiIA2CHJUF4oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JxZ2GqD64zGLtSjRjLMbNVdgPdfLux3vSyiUPQJP9NR3iEfl7zLg4ke8rgGkzoOZVposmaZehDpAQdv0Vu4i7UhobuEk/444g9c6GDiVqeWHRVXf3wsfGzu52RXerqw4iFZ9GCXzzKEluD+bi0RbinrdW2BuK+oiazlJ4X0hsZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DKgegFXS; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 87E8540E0264;
	Sun, 15 Dec 2024 12:12:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id AuE1ZiWNe0Fo; Sun, 15 Dec 2024 12:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1734264774; bh=SJ5i8l4VTt55KDY9JKzIS0FmiIKL4qBNlGI6lABpLPY=;
	h=Date:From:To:Cc:Subject:From;
	b=DKgegFXSK4aI4Dk/lGCd9UAEhFYFReKoa/f66gCEXbR3cnnmjvTITO4a3GIvKAkeZ
	 G2CdteF2tcwTlzAFH+TbdOjg5lbso3OXJSrVmDvmYYBbKesfR1maCposfRLAdrEQ9h
	 iHEBqi8Et0kYiugcXIaxVoE09sb4D220BrUqYqVKXL1u1a8zjdac+WW+jigKYKlXvv
	 rPlPtnJF38dvMrW4dUpn2Dh/KceGBKnrxZQzJGiiIQjbIobVffAELRtXubWt63rTcV
	 At0HvD5Y1l7cfW1hvIGN96sz+ILp1bN98zRGLdm7EAi+/4E2W5We3FT88g6ZCBUoI2
	 jMFM9+o7LDkhLY/8HuAmZQ9q0ZyqZEz7FSq+GKH/DPd8doP+n6NqXswEromFsGF1Q5
	 0uZf+fwASkkcunLQLnhSQa4aKRokzag5cF9F3Wbz6+Pe2nFhUI1CmLqTUTiUpFbSja
	 bR+xArPmrtPtrddUURgsZdeuJgC2BdNvJF1tjHv62xPMonfBhCnfzn3QzL8+14/0JD
	 W+udaDcndiUBvfF21AOg4Oj4TnyzbJNLfJAB/aa02GRwkWKRK0NsrOscb++bX5sdv3
	 V1aGfwhb4Wf0oiXic9+S4ODIVFuvAbo42N9gw3Bwa0zMMFvqEKkk6ncMtzZh224Hl4
	 db5Ah4MPKy6OX8RwRi8EE41E=
Received: from zn.tnic (p200300ea971f9324329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971f:9324:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DE87F40E01C5;
	Sun, 15 Dec 2024 12:12:50 +0000 (UTC)
Date: Sun, 15 Dec 2024 13:12:39 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] irq/urgent for v6.13-rc3
Message-ID: <20241215121239.GAZ17Ht6EXiItke-uz@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the irq/urgent lineup for v6.13-rc3.

Thx.

---

The following changes since commit fac04efc5c793dccbd07e2d59af9f90b7fc0dca4:

  Linux 6.13-rc2 (2024-12-08 14:03:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/irq_urgent_for_v6.13_rc3

for you to fetch changes up to 773c05f417fa14e1ac94776619e9c978ec001f0b:

  irqchip/gic-v3: Work around insecure GIC integrations (2024-12-13 18:15:29 +0100)

----------------------------------------------------------------
- Disable the secure programming interface of the GIC500 chip in the RK3399
  SoC to fix interrupt priority assignment and even make a dead machine boot
  again when the gic-v3 driver enables pseudo NMIs

- Correct the declaration of a percpu variable to fix several sparse warnings

----------------------------------------------------------------
Marc Zyngier (1):
      irqchip/gic-v3: Work around insecure GIC integrations

Uros Bizjak (1):
      irqchip/gic: Correct declaration of *percpu_base pointer in union gic_base

 drivers/irqchip/irq-gic-v3.c | 17 ++++++++++++++++-
 drivers/irqchip/irq-gic.c    |  2 +-
 2 files changed, 17 insertions(+), 2 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

