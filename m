Return-Path: <linux-kernel+bounces-322391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5E1972873
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 06:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E37E1C2246F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 04:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D324170A23;
	Tue, 10 Sep 2024 04:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPy18MtF"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD8F157465;
	Tue, 10 Sep 2024 04:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725943229; cv=none; b=m6+/bmKvn2eD2z19wsA1qeh9isYuDeHAniUaR37tQMfp19hfiH9MV6UzZItD3X8tT7wD0X1evh0qEP7yhjlCc+XQ8B7wN/PKBIirMqueHkHjidP/r5Cnh1oar007F1AfhBn+I7Pcrc3sJEUvJqIqzd6M8ip88hMNABY+w4tQYb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725943229; c=relaxed/simple;
	bh=/z5BXhIgjUIpkYElzoyDwkqDeDF4MqQez8i033x54dA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pExtKz1YrGeqYg6y9MEZTd8xDAdikLdhU5KRp5nzHKF1/w7DvSV8LiwxXmBpnhe9CZc8Hg/VUpHVFetgLuHREHmTYES2n4Ar8PSONTMJAmeHyMwiu3x8lb8dbmonXEXv9QL2LMN+Sx4ZmddEhJZxEtY3tVqNzZmuKTaTICvg3/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cPy18MtF; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-374c326c638so3753250f8f.2;
        Mon, 09 Sep 2024 21:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725943226; x=1726548026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nsJ8q/7VOmurZioYPpEDxud6PCKTaVIUoy70tilwNYw=;
        b=cPy18MtFSD7cg5qJFUschuq4pEC4e3mHc+mpQtRnaeh8+Wo88/q82PPON7ZFvTqElz
         2J6egWMfIDflKFt3OBKgs4li/p+VlC9l2cCvDIftPhlfaEYBxzhLVPG5wiHSEuFxpu/K
         XzTr1F1bDUEhPRqGcRs5bytqimnjA9Wac3qZvbIEI0qfYnySCgg0MBMWg7rxE9kM6AYz
         1U2TDh3JVVC5LJHpqTb4BxB/nQiVQpk3R5lkTRRTXoo9Pz7jycUWj57CwngjBgDJJrKd
         J8MAzccSlcw2uBkO3E5EU2iq6mSJ/JnKYl0x7B+iYy/L0D3puzKcWJdf17TShLO7Lj3p
         f1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725943226; x=1726548026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nsJ8q/7VOmurZioYPpEDxud6PCKTaVIUoy70tilwNYw=;
        b=xLG3CbQVdfgrSdo+2Ff3hchBNq21Pkc06nU2xT8s2IqSgM5HTpghuKhI8vuco2ZX6F
         armVZr/NY30Nstikcpj0N3ep3TmX6UyVYzE6Jbp82US4UGq5ROsnaPNUp77vcJDHyC1H
         bPFsGE/J1zc6DQxNL9QLPzOraY9azmT+EvqHC6tzBw0CwO24E3irSgeEQqMSVMfm6GA4
         AF2Pc+SyaTyqbqxOzHwYdqZR0BL+2K0wrz/VYNszam7zw45N1D1tPD3FjAIA/GWEJHN+
         FmFLzRRRZC/f2KGPrpx6BSatcTFlWBpdHau1fRORrPo3Dd73vtMi7+v6tl1gpN41VcaS
         5N2w==
X-Forwarded-Encrypted: i=1; AJvYcCVyveDpNu+5CvLFY9NhADMtL4QBPd6ogUvvh2I31IOMyjcUhjuYLWtAu1dMlmmu0ejM8iSPDaIMm2DVElc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxLiNElnKNLk02OjPu9ze9X3N508x5xE+2ClKBYXbGo7zt2LLa
	+sF1vuzV9oIukyC0VGCWdHA3GADBLp1I9D81Xt2PrncCf0994SpDEJ8n7w==
X-Google-Smtp-Source: AGHT+IFoMtPhKhOjWEfnKprNyd0E2fJu8wHX/DQCgGBnbm+355qbjty0WZIuVHXbw9JT3O0qD5KcMg==
X-Received: by 2002:a5d:4e51:0:b0:374:af59:427d with SMTP id ffacd0b85a97d-378896c3a8fmr8103113f8f.49.1725943225881;
        Mon, 09 Sep 2024 21:40:25 -0700 (PDT)
Received: from localhost.localdomain (201.red-88-10-59.dynamicip.rima-tde.net. [88.10.59.201])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cc01cae3asm5516055e9.0.2024.09.09.21.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 21:40:25 -0700 (PDT)
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
To: linux-clk@vger.kernel.org
Cc: sboyd@kernel.org,
	mturquette@baylibre.com,
	tsbogend@alpha.franken.de,
	yangshiji66@outlook.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] clk: ralink: mtmips: some fixes and sdhc clock support
Date: Tue, 10 Sep 2024 06:40:21 +0200
Message-Id: <20240910044024.120009-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Stephen,

The following first two patches contains several fixes for having a correct
clock plan from the beggining in old ralink SoCs that could not be tested
when the driver was mainlained due to the lack of users. Now some issues
have been reported regarding RT3883 in openWRT[0] so I am addressing and 
fixing them here.

The last patch adds new clocks to properly support sdhc 48 MHz clock for
Mt7620, Mt7628 and Mt7688 SoCs. OpenWRT people updated to use SDHC upstream
driver so they were forced to add a not desired fixed dts node[1] to make it
works. The correct thing to do is just support it in mtmips driver. Hence
we have add it here.

Thanks in advance for your time.

Best regards,
    Sergio Paracuellos

[0]: https://github.com/openwrt/openwrt/issues/16054
[1]: https://github.com/openwrt/openwrt/pull/15896/files

Sergio Paracuellos (3):
  clk: ralink: mtmips: fix clock plan for Ralink SoC RT3883
  clk: ralink: mtmips: fix clocks probe order in oldest ralink SoCs
  clk: ralink: mtmips: add mmc related clocks for SoCs MT7620, MT7628
    and MT7688

 drivers/clk/ralink/clk-mtmips.c | 56 ++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 15 deletions(-)

-- 
2.25.1


