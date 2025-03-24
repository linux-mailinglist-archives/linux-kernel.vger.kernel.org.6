Return-Path: <linux-kernel+bounces-573639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CA9A6DA10
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 13:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B67E16E425
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 12:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B6225E833;
	Mon, 24 Mar 2025 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="TPUqGKdj"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A57F25E818
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 12:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742819203; cv=none; b=cshYAkDn7ZYieVR+Zfr+en3jHZ9yil9ioXbsb+Y+mFDx8hgb01ODk5cak9DGy7mBbaGqbiIyeAEnay4OZ6sgS1eAhxkY6PsOfJDcvmBa+6ydF3hxsqEjRchBMCq/90BXu2Mc1wC2LO7TBGsGeEBVbJArpYnrd0cYfGlAF5Nss0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742819203; c=relaxed/simple;
	bh=hzKJikXi8Sdam4B/PqIlud3Ck4EKL/r9ynDMwDVjci8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ao+4n46rg3yRneq+9oTqExuFEo0IwqUFV2Y8iQ18/fG+BXTpboKptnYtVOjIyVdMDNo5Wwhdo3npLoZY3VXCnZYZjMgLwthRzNZSBgX8+WfT9RPlnQjiTDxi+pjaAPVMuxd+Tnr7WqqfO/Aq1/PORPc+Ki4/weKz3a5l1FRALMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=TPUqGKdj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso31730575e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 05:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1742819200; x=1743424000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Phk711bqqwQtp/5ohR16dSgoW1rYqnvCMt8zHzDni7g=;
        b=TPUqGKdjygNWlcpTeLDimpy36254zyMMHrxh46im4G4Hmffkmwu1jtBrbfq7ktCC3C
         2CpL2RLHBN+kNk9Xyyk7y/020NqVIIvk4ZrC+6UeMF/9H9fJntFsrg9+kRPd2+8MLB3u
         Sq7nRCqLp1dlAzd2PkcdX0ID3p9QyKncuciI5lLqP0QH+GSvo7BXoZZ4em0dkmgbULvz
         Sg11lcZzqyJZ58CE327X9vibX+God7my9kMr6tWRPvgMngDWaIm2lZlhoW9LQcPOjVnJ
         qkrY6kNaL3ufKGDvqSx6md4W5CWuI9ClcqNLe7jcXSW1niOvufI8AKBWXVLteZrANrhg
         lMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742819200; x=1743424000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Phk711bqqwQtp/5ohR16dSgoW1rYqnvCMt8zHzDni7g=;
        b=dxG/P31IxtRkO76Yp4+1Q4LzuZSfmv/CtJXY1JFtoZ5zMS2766nNZfNiyurCzLag0v
         zQ7/qnEYJJf2PD8HPgTwFueV7tID4nabIBR+w1s6t87uBiHRIx9+7ulcmqtt+Wb5jVrZ
         7y5AY52/D3NCMh7fco/+heCftcchbw8S5YCzk9ofvAOOYb8XGXgOfmBwY1FMstbzpw/G
         QcvDbFDW/RTbfygnLAmjuP6LYMGmB6Cz3cH2HLGllxxw42hVMOP53Ix9EknzckLYI2VY
         wAM/PxxaM97JJKvCY1l0KW56lk7o+f0Oavjmg0mt3QwUm9WdGupaVadILlkXwtVMlsQ7
         jVCw==
X-Forwarded-Encrypted: i=1; AJvYcCWuH28vPMS0pQfuM7FRDI7Y0C+DnJUNfFuZHYDamKHHQ895FLN5FDkoujkZ9Wk0pTIjqnNTp0tpcZjlNW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQkySYUowfh2pZwCZdY66KZwiEB8LCIKybcAcK5iQMabjJTcRO
	YJb7GtS84P0XTaqmXLUCCNkHh0WSSzbYIE/SpwLSUqi0+iiD0JNlucj1VC/XI9I=
X-Gm-Gg: ASbGnctjly6QylqgJuwM5QzI0UHOPPLhaf870lI45bYgRaDTRdDKSS0hqNONi+h1RYk
	ZPsp/nNJ7XmcKdl1T9bjLb8TLeO6GAJyQj/ddrlvdalKz06KD2jCURl9rQxF0WnqXmiC6yRTAl5
	HEuRe9gjYC7B3gGxhVtF1LrkaeWUMt+2axy02O2Ll6VLXOqSRuCOJhtAjBqouxUyzlO/FAwfuXV
	rPK3C1BDn54DPr8zViOE96QHC4G93EV5LADhBY7Y9lrb04782GuM8NEBujTrywNxR2FYOMHwBOQ
	VbPwXkEnhB5lsFpPu+LLx74Vl0D+I3WsBIks0KHglNLmPXWjbLTyrfO5D2x2NudBMkQXJRTNlw=
	=
X-Google-Smtp-Source: AGHT+IFyAHj/IByQ5z9fmeWSfg359IdFmkN1k1RzZoQFKjZ1j9affxNGuCzLwR/XkeM9MsmBLjG4aA==
X-Received: by 2002:a5d:5f46:0:b0:399:7918:541a with SMTP id ffacd0b85a97d-3997f8f5c13mr11994851f8f.10.1742819199656;
        Mon, 24 Mar 2025 05:26:39 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9ef16csm10729080f8f.86.2025.03.24.05.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 05:26:39 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: prabhakar.mahadev-lad.rj@bp.renesas.com,
	jic23@kernel.org,
	lars@metafoo.de
Cc: claudiu.beznea@tuxon.dev,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v4 0/2] iio: rzg2l_adc: Cleanups for rzg2l_adc driver
Date: Mon, 24 Mar 2025 14:26:25 +0200
Message-ID: <20250324122627.32336-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series adds some cleanups for the RZ/G2L ADC driver after the support
for the RZ/G3S SoC.

Thank you,
Claudiu Beznea

Changes in v4:
- open the devres group in its own function and rename the
  rzg2l_adc_probe() to rzg2l_adc_probe_helper() to have simpler code
- collected tags

Changes in v3:
- in patch 2/2 use a devres group for all the devm resources
  acquired in the driver's probe

Changes in v2:
- updated cover letter
- collected tags
- updated patch 1/2 to drop devres APIs from the point the
  runtime PM is enabled

Claudiu Beznea (2):
  iio: adc: rzg2l_adc: Open a devres group
  iio: adc: rzg2l: Cleanup suspend/resume path

 drivers/iio/adc/rzg2l_adc.c | 67 +++++++++++++++++++++++++------------
 1 file changed, 45 insertions(+), 22 deletions(-)

-- 
2.43.0


