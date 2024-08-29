Return-Path: <linux-kernel+bounces-306080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E889638DC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 05:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9412B227F8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 03:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA7B3D55D;
	Thu, 29 Aug 2024 03:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Pcxy6/Eh"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5206200CB
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724902770; cv=none; b=eENnjYEwaocBKgU/udVcBXMhFT7Z6+dg0QByNBKqosVnzy3F2/0Col9WLWwWEY+f55ITlBNuAwaXwYrWsjLg/B6iOWPnD9zCgQkd976fOEwr4ZiH354wJTaI9r4qqd1FZlAJVL3D1wCtHDbOC2FLGju5rLrPxHQiYb9ZPaKhErE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724902770; c=relaxed/simple;
	bh=U/z2Ry2HbymX6DysxD7lszwnCGQ9QsdFYg6KidWVkoQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=rYoyTvcs7VarRB1fOJ8wn48vwXHVFWq2N7yYdYdIgCc72RvZLnS4ZxH5vfgXQTQgrvgYb0DlG567mMop2odUHKPSkEvNkKfTgOKv1AkBZ4z/xr5s3mluVO+z9WCGfkzYC969GnvzBmQ3lTyc7TnSv+u6mv4KCuvvLWEpJciNqPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Pcxy6/Eh; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2021c03c13aso1652785ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 20:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1724902768; x=1725507568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BAQT0Tw9Rk30mAgD9ZQwkMJ4XScbb1aQuooCJT7sX3w=;
        b=Pcxy6/EhOUouB8BbH/j+4fAgUAfArq0et7vpYF33LlKtOKaHkQ0Q7RJ87ulfFppfzO
         o4F2Q9Alhc68Vu1Esmx9Mr+XEKp+8w/AR61wPmI9W3rdUlZX7uRDxNtVFO/xV9yYNARk
         axsw+ur4L7tpQ+d8u7DHC/+CXtz/e0q2wIofAivbwlRRrhzdhngchZh5k6RYn5LHQ5wh
         LnY0QaTfdlKFYaRbjjQYyedXjh1AAlDdqtvkmFIJKafrbw99OPkpNjsqe9KNki17/rlN
         nMZXcizNXfDihRiBBWnRnO654RW5iSq3UTtN2Iv4nFavCLxukzMa9nbNUfGm3nCRQROi
         ePMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724902768; x=1725507568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BAQT0Tw9Rk30mAgD9ZQwkMJ4XScbb1aQuooCJT7sX3w=;
        b=Cts6Rt45qej2wGtZvt7dyY3irgq1f5uDYmxt4Yd83MozPM/ywXi2FidIY/g/mEh98p
         4hwbs+ja3VGhqXTK6pmhhOeVmKsmiq3X2aViQvmoHnVZ9TE+FCvmIHG3CQFPQzqjMncg
         tR6sq9eTmBl1tB8zkPA3PBNjZU+0p6JjKKWjTp14RYSAYZLI+UdQI4bDe74BTPVanjkg
         xEWhDyYDMkayEot64OCIvuHYX716lCW8Kj9ehHaBLtb3+WzpjkHHpRjMHoEImk1ca20u
         FQVuOOnIAyLhG+D7AqIC8MX1Ys2ELjnnB+t+SVi2rzqgwZk5opz1x+Pnhg9sLccz87I4
         3Qmg==
X-Forwarded-Encrypted: i=1; AJvYcCUkfRLr2DGFdNWkG/OTR5JCzO5MESpDhPEQ45aAknI1q2iuG3xieQmNibOp1tAa5NSWFTyF2SSgAFpvMhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiIfhu2j6dqiklj0LLhYPNIR4DD+GM+WtQyYIAzHsoDz+uItnW
	qAgG+JY2zggjIzCkggqZPOHGxUEajGgjSDgVeek7HCmIz1zbTohdrr4rZXQgxeI=
X-Google-Smtp-Source: AGHT+IFzR3mo/xxAAKksCuseQ/Fe4/G2ieJWnxXB9IsXXS2RcfaqgejY2ZMhA5ktYXe+Hc36rdRCSQ==
X-Received: by 2002:a17:903:1c9:b0:1fd:8b77:998e with SMTP id d9443c01a7336-205168cec40mr3886715ad.29.1724902767587;
        Wed, 28 Aug 2024 20:39:27 -0700 (PDT)
Received: from hsinchu35-syssw01.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20515542498sm2056065ad.188.2024.08.28.20.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 20:39:27 -0700 (PDT)
From: Nick Hu <nick.hu@sifive.com>
To: greentime.hu@sifive.com,
	zong.li@sifive.com,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Jones <ajones@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Hu <nick.hu@sifive.com>,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Support SSTC while PM operations
Date: Thu, 29 Aug 2024 11:38:58 +0800
Message-Id: <20240829033904.477200-1-nick.hu@sifive.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the cpu is going to be hotplug, stop the stimecmp to prevent pending
interrupt.
When the cpu is going to be suspended, save the stimecmp before entering
the suspend state and restore it in the resume path.

Nick Hu (2):
  riscv: Add stimecmp save and restore
  time-riscv: Stop stimecmp when cpu hotplug

 arch/riscv/include/asm/suspend.h  |  4 ++++
 arch/riscv/kernel/suspend.c       | 13 +++++++++++++
 drivers/clocksource/timer-riscv.c | 22 +++++++++++++++-------
 3 files changed, 32 insertions(+), 7 deletions(-)

-- 
2.34.1


