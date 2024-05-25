Return-Path: <linux-kernel+bounces-189337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E16E8CEE94
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 12:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FF5DB21265
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 10:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDBB3B1A4;
	Sat, 25 May 2024 10:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnjgcrXg"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27283A1A2
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 10:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716634091; cv=none; b=aRTbxll5fylor7JBPCoGoKVWwdLAA7hCoRgQh0TdHYhnzlfAjNA4MaW1F9FII86hI2aJHKTecNyDjpOzPRbBf4Q46VlOoU/hQimC6FW7xDiec+kSvbgpJeC8/hPFd/JKk3v9tydqqlpkNGhzHoZbl2cyzFYTMEHuaGIfzRTEi7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716634091; c=relaxed/simple;
	bh=DahPjolownOPolnvZbPaBwYUo+sbYj05TOymbLZ70uA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pAnCh76qExRQTTnpYv8JkM/T8N/Sp1sCUbiWdg8TlVN+eWTYW2U1/u90Eor1GYF9PLB6pmD5wyGTGawF/rSrjoolJGLYSVa6LjfRTEMBaOtb4ldoN7vEYu04TauKIE98tHDCakwURdONhDYGSWK5gNNKGbSaMoOHX0E+8Z68laA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnjgcrXg; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4202ca70318so69272385e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 03:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716634088; x=1717238888; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8xmUsGyXjU4xgHKHmVwvAZTA+eItI9pAI/paK0kmRg=;
        b=CnjgcrXgIP2lppXhiHYI/JjhMWL2pan/eOgPF05+WQT1e3aupHzjurdE261QxkX27L
         irK2quFwhAhdGKTrKGR8oyG5DsUjr0u3TCI+emyGPQGbMDFA4/DMJUMbvGwIKhxvfHpw
         /gqUvTDIuDMkXuEsCsSQCb/6u4EAsFRvFTvWRyDulMeoaAL19HhMvzwi2RdobAdfFEEE
         FnHY+RqNhK0GEzObd+MdcspG0WMtd64zd3+B5YWdFX8UeI0N0Tb26HBfMKfY28KXb258
         LXSB50z5L9wQNkbEUHAWjp7RcN6R3IoDCueSuZcLxvR713CUDBOiBIi8ng6r5HIKe1hu
         MJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716634088; x=1717238888;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q8xmUsGyXjU4xgHKHmVwvAZTA+eItI9pAI/paK0kmRg=;
        b=QevqvFZr8Wds7ldPhyp9johuZ0qYzzHSBl7wthUZDbN3nrBQ7oo1HrDWLpJkF2pncJ
         hrOggO6VgY0WllCbv8US1EEJUO9wnz6Tv3op8f6TjdDrKA7BNhhaUQjOYYxFatxm2oGH
         dNL5715ACICcuKX+PXRqut/9yLG0A3XzAc2R/HyTvFFlwrhBshsj96oi3OtQ9zcuIJty
         1yrK2+9CsvkcgYmXHvrtZnAQiYU++b5gNMbxTh8YP8F7MD0DJ1gcNo1Xy7Pgj9Ho9ooN
         wF06OA1FWK38Xx5imhUsiMbOLs8JMCzblTStEI06UcJrJxu2QUFogmBx+I2Ug2tmofbA
         chJw==
X-Gm-Message-State: AOJu0Yx2Se6ztJZBk1B07B1cRbzJC1jLd/m5R3H4NLIzxUO53Zn15u8R
	FO2UaI1TgezIEq5bm5PkW5hMAofldCGpB+H/Ab+bv3vjCrXyrZW4
X-Google-Smtp-Source: AGHT+IEXqbbVU2L+Fxv+BJoIqyP5sf80DlA7GlqgTyU1KmiAaN4gj0W04gXs1NMpZCQYdOiSrGf9Ww==
X-Received: by 2002:a05:600c:19ca:b0:41a:3b7e:2235 with SMTP id 5b1f17b1804b1-421089b1b42mr36750845e9.5.1716634087683;
        Sat, 25 May 2024 03:48:07 -0700 (PDT)
Received: from gmail.com (1F2EF63D.unconfigured.pool.telekom.hu. [31.46.246.61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421089ae96bsm45779575e9.35.2024.05.25.03.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 03:48:07 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sat, 25 May 2024 12:48:05 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Andrew Morton <akpm@linux-foundation.org>,
	Borislav Petkov <bp@alien8.de>, Marc Zyngier <maz@kernel.org>
Subject: [GIT PULL] IRQ fix
Message-ID: <ZlHB5UO55nTuG6II@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest irq/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2024-05-25

   # HEAD: b84a8aba806261d2f759ccedf4a2a6a80a5e55ba genirq/irqdesc: Prevent use-after-free in irq_find_at_or_after()

Misc fixes:

 - Fix x86 IRQ vector leak caused by a CPU offlining race

 - Fix build failure in the riscv-imsic irqchip driver
   caused by an API-change semantic conflict

 - Fix use-after-free in irq_find_at_or_after()

 Thanks,

	Ingo

------------------>
Dongli Zhang (1):
      genirq/cpuhotplug, x86/vector: Prevent vector leak during CPU offline

Palmer Dabbelt (1):
      irqchip/riscv-imsic: Fixup riscv_ipi_set_virq_range() conflict

dicken.ding (1):
      genirq/irqdesc: Prevent use-after-free in irq_find_at_or_after()


 arch/x86/kernel/apic/vector.c           |  9 ++++++---
 drivers/irqchip/irq-riscv-imsic-early.c |  2 +-
 kernel/irq/cpuhotplug.c                 | 16 ++++++++--------
 kernel/irq/irqdesc.c                    |  5 ++++-
 4 files changed, 19 insertions(+), 13 deletions(-)

