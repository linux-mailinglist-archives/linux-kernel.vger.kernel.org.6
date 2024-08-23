Return-Path: <linux-kernel+bounces-298565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF61795C8E4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 11:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CA27B25994
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5816143C41;
	Fri, 23 Aug 2024 09:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sj6fWaJk"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6D2149C46
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 09:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724404265; cv=none; b=IiseVJcEehnkLr6yGtafaPA4Pe+Dd2RA0RKZvS5uP8N551OT5l25Y6hc1v7VysxjjfbuV8VabbRzoIw0ywnSxvGbOtbJ/i9kRZWowDCjBKfhSXyB593UZBRV0TRSjFxcAH57zx1SfJFo/U78YQjxoXIFuaWHE5KbDQDd7ctcdC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724404265; c=relaxed/simple;
	bh=9McQNjtM0EMrU06vDZY3Dzas5wVl3xMcMT56VM7mTq4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C98ItgT3P5d6J/Jx4lzQxSnJ+BeN0DucI6h9ooYzJCNXntngdPX2IMDQ5VBG7jo6rrF8WdjsBHB+qqBB2AcsUP+tV/0L4grqZww/m6OMK/vY5NYr61BrQ2F7Sj1TYdcsnzRbexue7JmzcwGVwsq4FqtDVMzBT3ZkpbAcckVOcQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sj6fWaJk; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f3cb747fafso19310041fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 02:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724404261; x=1725009061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TuhsP/9PjZ//J4olwSLsIOPPzBryfeXX4Y94+xu5m+o=;
        b=sj6fWaJkZBE6PMkjVc1u5bIk4eaExgHDiu5y3cn86fDzPBvKC06YpZitNWZVAnfnCm
         v3YuSR07y5KMA+oChaCJNCUsE8wi7UhxJUz0iu45tdtsFSSth1VlIVoW9x59JKQqT2lw
         0/u3AhlIKOmyiMimtQyPWi0Uko8VPZIagASM6jPfu0P03XIiVpByhdhrR4sl63NUOi+u
         qAEgzST+k0KX5aEoJsYbqL/jKw2aMPCf+8cFRiI81VfKxCDUA+5Ze+o940sVxZcicGcw
         hhmmIcnG/2NWqeIEvjcsyGGabceGS5a9x7TYxcvOXdFUPNwwBhanVGau2Sq4WjM4FHPm
         fQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724404261; x=1725009061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TuhsP/9PjZ//J4olwSLsIOPPzBryfeXX4Y94+xu5m+o=;
        b=wpIMlzTJ7ch+oqnW2tYR7TR4oSuOglTtbZoGWkx0LdqVDyPeY+SVff4c6C6e53tbf2
         ByWM/s2hSZzBxknzJ0rRWFD76zw6fqeIpAciuwY2I1KBdX8imJS9IPVGWMGMXUvsK+kt
         Vaz2j2CPW76fnduF528EheiKb2rluPi452Cn6vzIBwVfr9qui61AzSYXRG19XVVyWKqG
         3rT7V1XxwqgfccpOpre4iMA6Lzxs1iEAwDi2U4eoIGk3XnT9m9ulqEUWXOHjSklpEqfA
         qK/ZbbkPkUmT+sni07RBmOiFdyjX0wD+KVTDfTtfS5lTWjRRIAj3RntKWjWoontiAAUT
         K5/g==
X-Forwarded-Encrypted: i=1; AJvYcCVdm4IPhbXdE1TPdz9brfiQXo66cHdzlx6HHVB+lbnQ3AKRTgCGJaVNKsNBK9pGoeHLdVq4Rxvsi4PwuiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrBuVidCxchqvKwZzu2mu0XCrx5GljvCkuC+bJ/vxMkxBWeirF
	PuWJPwJuww65X3797KlvUCc0un7lo4TBhA2gKudaUPzcGKbxAtQMsKGiD/KBBEQ=
X-Google-Smtp-Source: AGHT+IEmhwphpvha0B7BZxVrNeEMxYBC+/vJsrZsLOklVjtksLvuMg797cynQ3eS4KZPmU6fW6REHg==
X-Received: by 2002:a2e:7a17:0:b0:2f3:f2b6:6ccb with SMTP id 38308e7fff4ca-2f4f4916491mr10134791fa.26.1724404261204;
        Fri, 23 Aug 2024 02:11:01 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f4047a4f6fsm4249851fa.4.2024.08.23.02.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 02:11:00 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain fixes for v6.11-rc5
Date: Fri, 23 Aug 2024 11:10:59 +0200
Message-Id: <20240823091059.389173-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of pmdomain fixes intended for v6.11-rc5. Details
about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed:

  Linux 6.11-rc2 (2024-08-04 13:50:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v6.11-rc2

for you to fetch changes up to 52dd070c62e4ae2b5e7411b920e3f7a64235ecfb:

  pmdomain: imx: wait SSAR when i.MX93 power domain on (2024-08-15 12:47:09 +0200)

----------------------------------------------------------------
pmdomain providers:
 - imx: Remove duplicated clocks for scu power domain
 - imx: Wait for SSAR to complete power-on for i.MX93 power domain

----------------------------------------------------------------
Alexander Stein (1):
      pmdomain: imx: scu-pd: Remove duplicated clocks

Peng Fan (1):
      pmdomain: imx: wait SSAR when i.MX93 power domain on

 drivers/pmdomain/imx/imx93-pd.c | 5 +++--
 drivers/pmdomain/imx/scu-pd.c   | 5 -----
 2 files changed, 3 insertions(+), 7 deletions(-)

