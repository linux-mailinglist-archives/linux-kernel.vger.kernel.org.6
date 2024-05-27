Return-Path: <linux-kernel+bounces-191199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7018D07E0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 18:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0AAF1F21E26
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA630161325;
	Mon, 27 May 2024 16:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdX2ZPf8"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8237216089A;
	Mon, 27 May 2024 16:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825856; cv=none; b=g7JvDWJRFLEuzoYctBMBthGCW/dGPn07neYMnP/7zps6m7naE39ijAf4/kYSg3yjd8t8KXzCW3xoEKCmrWY88kDcl2n42gSMSfbxYYA+FzDaOPhHreaDrnisJ9sN4z6ubJ0Q7BJNRnnRqFED5uknCX7SxncMOEQnmKUDGVPQgCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825856; c=relaxed/simple;
	bh=uacHh6EhTGWzGPaDWbj67AEeFIW5+96vG5JumV2wf8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PgCXfpvHj9e5bz5hIkS27uCb1pGEldR57u1uX1zFVCCHJw5G0LtGxX2s4IyjA7qfz1yqf67WHThFH7pxw+acAsDFhcqwYD5zrZXMBOVsZW+ss3AyzpVINfhsVpHqrgVO4WQk2b4+5szrJIXC1drQ/msY6ZpmZz5pDASZdWGNDko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdX2ZPf8; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-523b20e2615so12503057e87.1;
        Mon, 27 May 2024 09:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716825853; x=1717430653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=apgO11dWsw7OelFO7SGE1rP5mAwL0hohwTCwi5aPKr4=;
        b=hdX2ZPf8TQX/06lw88IvBCXWseogAUNa4uvJVDp0Z7c2Xd9i67RlpSA8yo4FZ5CJzo
         e9w5i7fgQD8OnzHwPFX1RQzgz9CptyL/bMJljoM7k+vph/y6AGtc4gG1C6GLZR+/M3YE
         Eo5AE15eE1MLmdZjHX9BUvO3XhQK3Oq1CarEc4fafZ/fv7unlTNsTDJ6InFkfYbITXyJ
         ApynQSisbEmSyHV0fPxu4wSvO9pgR0HOqZMp4kKKMBTmR3SeBPU/+VDKWKQ8dTZ5woaC
         ZvLxuNUK9qRezn4UgMt6/wehMiNboPwb7FGcvUB1zTCmSFJ4vnsWN+Ukq58tY9Irf13F
         pjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716825853; x=1717430653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=apgO11dWsw7OelFO7SGE1rP5mAwL0hohwTCwi5aPKr4=;
        b=RbPypMa0SpxnrIWCkduyKbpsZYBG1P2E6tCxQ4qb3z7ErNgUm8lPuqdmz8hsc4QvhE
         j8bXeLf0mCpWsrMUIse0LxPQ76fl1vpExG7WZMTTNkZL9zWwbkMbgaasuLO90/D38iWO
         LP2F/JUW1RKwI5XQKQZ/Y3ZfZXwIQjAvI1FxjkwnIX6ky2S7JeBepLoR/SdXX4wysT11
         7TELGHkC5DwyATLhzb24XpE2bN6BXXBvqbum0YqaUBeDbpIb59iVkTiHAfL8QoUEDpU3
         1hWD2UznBledwaol05Q+3nYdoD8ufhSlvma0vy9fh5QeucZSsIMMl+mBFoK9HDY/ClsL
         oGQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXAoBHpYZlpoLCu547HpFDc2hgi83DJuXsJe9P/CYKHtZHyjVZFaiZd1hWkWuCa0Ter1mlRSzEBxKj/Z8vSVk/D5fj7WIvzdNFk9z+cmctMgMwb4wqS+1zdOyLVJL7wRI49+Qxc7qm+8g==
X-Gm-Message-State: AOJu0Yz1P12qeyY5LAztcWAj6uJUTSF8ZJmQ/VG5M9ZFb2Y6n7OdvSV9
	8KT1yui3Jl6tAsyEvaqNenhkMHoFvoGEk4XIs6h80Ctcm1yMyiTD
X-Google-Smtp-Source: AGHT+IHd8fZ9ZjNj+cQlcl9SkrUQUbQdMMCLLzdPkGhasZplYnYRHIfSakWwJL6yK3us9V6TLzOhaw==
X-Received: by 2002:a05:6512:454:b0:529:b697:a0d6 with SMTP id 2adb3069b0e04-529b697a37cmr663484e87.8.1716825852032;
        Mon, 27 May 2024 09:04:12 -0700 (PDT)
Received: from toolbox.int.toradex.com (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579f96519sm9349394f8f.26.2024.05.27.09.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 09:04:11 -0700 (PDT)
From: max.oss.09@gmail.com
To: Max Krummenacher <max.krummenacher@toradex.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] arm64: dts: freescale: imx8m{m|p}: don't limit i2c2 max. clock
Date: Mon, 27 May 2024 18:03:44 +0200
Message-ID: <20240527160359.1965512-1-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Max Krummenacher <max.krummenacher@toradex.com>


This sets the I2C clock frequency to something people expect it to
be by default.

For I2C DDC we do want to lower the I2C clock to have more reliable
communication. However that should be done where the I2C bus is
assigned to a HDMI DDC, not as the default.


Max Krummenacher (2):
  arm64: dts: freescale: imx8mm-verdin: don't limit i2c2 max. clock
  arm64: dts: freescale: imx8mp-verdin: don't limit i2c2 max. clock

 arch/arm64/boot/dts/freescale/imx8mm-verdin.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/imx8mp-verdin.dtsi | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

-- 
2.42.0


