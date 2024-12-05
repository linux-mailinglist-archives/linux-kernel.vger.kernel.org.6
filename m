Return-Path: <linux-kernel+bounces-433844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECB39E5DD1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 19:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D07816CD0E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34561227B92;
	Thu,  5 Dec 2024 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aiJJMm9G"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE31225770
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 18:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733421727; cv=none; b=FtGoO55KwoChQIoUoOTL0ul6Xp6Py1CE9jdY1iunCgFJgiMURuelEAPy7vcbAS0l9B9+2KPKLUpi0FH/QL9hqw9y1xEMH0oCTs6wKVUZIimdkU5LjEpQbShKJxJg48bJ2X34Rftk4Dr2rGtijCTt0S6eBjJCf1du4DbEL45LK5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733421727; c=relaxed/simple;
	bh=PvO3ukRF0tA8B0YAj53vIl+BCuzzRx3eAS51sP0o+H0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XfWczz8lj4G8781W/46oQrWTAG+tvAZUeBMPVljV1yLfr+Dck/JZiMf2zVjquvx5qVTFsH7heouCxT96j8xhAhOFUZgAIfQb0NBJ65XXLhYJAvp56LuZ0wgJv3samjBrU4HLhxNo5T3rTSFAKVvaKKxGHcyAg6RZWCCtFNPmuzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aiJJMm9G; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385e5db74d3so701656f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 10:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733421724; x=1734026524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MEBaxrhXtuUNeerBIkR47JpXV/0Yl7e6aP4Ai3bVM5c=;
        b=aiJJMm9GPN1PzhnnVENAY2qH55ZAPk8TjnIT5fn8O5BUsDgj20YzvYzKB7VzcJbZSq
         CYnHfAUtH7IjXTLqoxH8jp6geLdn7PnMpNYegnSMeP2LTHPcCpLg9ZaSsn9vWoZiVS8h
         X/D23H38PRec+cpNQmkvxpozbvv7OT6GxU06d27tVvUqIzumNGR6H4E1hTjA43k6XJQZ
         JApA3Y1nrfjFcXR1TdNWHSm3thQCMRkwXwBH941ZfxXnKHhBVZuK06ZihHLPvejlUl7D
         cx9lV6EQPwifT+Tdhb2mcmCPuZgS2IBOvBTv/p+w7Z3oA13IUfq6Hjtp6pj78YSm5aGm
         byow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733421724; x=1734026524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MEBaxrhXtuUNeerBIkR47JpXV/0Yl7e6aP4Ai3bVM5c=;
        b=RV7PgF5n6Dh9UY7hLZWNX7j+dAO8KrOPfV2ReidD2S/owypxMo8DaKebre3Q7LrmGi
         EJajPUK3HYLFistM98NbtoEd7i9W6uijfzCrbqXo7Hj4k5E5yDvkMUTGhNWDnIIOlocc
         6x/wblL5k/RlNYN56cXFYJaPSLBdyDitY2wi7D91xnY1aJRE06QvU91CboTvtB4/TQ/X
         V8XaYbAvklSibMUab0u9Ar3caWFdZrrELY6twAbohxaeO/J5TkFTrWrm3ZnYn/Pio+I6
         XpcimR1LiTgcg2MmGZ5/OpNYNG9lftihxM1qqFoNDKKrIHdKE86aQEkdamVkmaB3mcT/
         y0yw==
X-Gm-Message-State: AOJu0Yxj8x7yAhYcuRpr6uPBNUuisgrP9GPeFIVO3HCuwucMa3OGsOpB
	ICXPZ+MFgvW/owgVFTun+CQUrlsPfLp6sKIo4ALAVGERUGczbJ2a/v5dZQYhNYQ=
X-Gm-Gg: ASbGncudSPAolUYvuiho3fjThdos+Ng0tjAds92XGjVh+Eg/xgPvinxjtkcj6GAlIcf
	iOs3xq1uK2p27LaztY+Ya3mbnbShOMdMFARSIDEt1eEBzAXW78/45UsluEmXT3zJcGZe+33/zNX
	8P6IDCAtf25xcTRhNmWiTtawvj72ELQZ71PeOCYmnMvIwGdqRaIxzqhiX5y7KOALfvn4cb3OmeO
	YCK2X1+ZJIg7G9lBVxyDVTsIMkaSfWwrzT0EsppHyCoJYNoXyf4ikxzx8rPmpkS4PbusiQVDK06
	SbRI5QxJz1tVqBh7rMayorM8ebPfZwME
X-Google-Smtp-Source: AGHT+IEaRSOep3o6BlOGmjw5C8xn/tsj4Vy2kgRYv+HBcuFUUH34fZUaz5fJUMup+GJE2Tx+FT0gbw==
X-Received: by 2002:a5d:588b:0:b0:382:6f2:df7a with SMTP id ffacd0b85a97d-3862b37afa8mr16766f8f.34.1733421723607;
        Thu, 05 Dec 2024 10:02:03 -0800 (PST)
Received: from ta2.c.googlers.com.com (32.134.38.34.bc.googleusercontent.com. [34.38.134.32])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-386219098d3sm2618228f8f.70.2024.12.05.10.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 10:02:03 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	alim.akhtar@samsung.com
Cc: linux-kernel@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	andre.draszik@linaro.org,
	kernel-team@android.com,
	willmcvicker@google.com,
	peter.griffin@linaro.org,
	javierm@redhat.com,
	tzimmermann@suse.de,
	daniel.lezcano@linaro.org,
	vincent.guittot@linaro.org,
	ulf.hansson@linaro.org,
	arnd@arndb.de,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 0/4] arm64: exynos: gs101: add ACPM related nodes 
Date: Thu,  5 Dec 2024 18:01:56 +0000
Message-ID: <20241205180200.203146-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define SRAM, mailbox and ACPM protocol in device tree.
Enable the mailbox and ACPM protocol in defconfig.

Tudor Ambarus (4):
  arm64: dts: exynos: gs101: add SRAM node
  arm64: dts: exynos: gs101: add AP to APM mailbox node
  arm64: dts: exynos: gs101: add ACPM protocol node
  arm64: defconfig: enable ACPM protocol and exynos mailbox

 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 40 ++++++++++++++++++++
 arch/arm64/configs/defconfig                 |  2 +
 2 files changed, 42 insertions(+)

-- 
2.47.0.338.g60cca15819-goog


