Return-Path: <linux-kernel+bounces-258521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 719B193891A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 08:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F6971F214DB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 06:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED3718EB8;
	Mon, 22 Jul 2024 06:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZBTCjPP"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A4317BD5
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 06:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721631049; cv=none; b=pNDYbRO+MlnPXx4+HSkKfib0D1vEQrlr2i2GqQzNLr+Z8IDEF4tFZagkOoJxMPmLrcnNNFWwT9PHTraZ80ewzAtSoWSlrDsMTEM5/Z9oyS29AFBv0OUkooSFwTVhx/3BoBY6qZw7YgcvxIXVopecak9pQrxgmgrP7AtlKBBkia0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721631049; c=relaxed/simple;
	bh=1JqDh9FSdhgOeLwoQkVMkmAxsvMDwuQMKwMeYB+tpjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A7R3iTetdyI2PWKOAMgG/rK2/WC97+XDhvRIf5qCN5jLPk6fpzPL1GBEUJUkwM5Gh8Vyk8OQHdcRmzJBcUDCSLHfFeT8y4OcqI0D8uczS4v71uSCxJniNHc3I2MQoFQZplsZZm2M/w8+ymwfEVbmu6TTVmbedXZqqGi3YZ+46oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZBTCjPP; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-710437d0affso2295184a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 23:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721631048; x=1722235848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BJCDkDHUe0i/zLQZ0saQxvrhTTRS1dH3nPv+QtvXQHA=;
        b=hZBTCjPP9Kn2FURuJChEMPm6fAfOMXE2HMLE1YcBdAFMU/Ixo/v3GVjwlulSiHZCiz
         Cx2vqt3C3NOKav/HObNQTJRiMXelBGAPhVP431SXn5ltBben4uaEa6Lgw1e27ArO1H/l
         kg0IL62n54H3O9edQZR+GkbQhXlfLrNzUbM85h3h5Yx2fUyPARI//wU8sjRIuG4epLoW
         bHejF7+ecx8H+hNMAcpcusF0rjHruWQ0H4Nhw0I0rnLTrOOvr4wHjCsbeYJbeFWJ+Yj3
         rCW8EhqrRL2CJ/PUc5XCHXr9iQV+W4/nFEQ/mbG354lk0f0lW0lLoEF+a8c4nehBcGcX
         tniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721631048; x=1722235848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BJCDkDHUe0i/zLQZ0saQxvrhTTRS1dH3nPv+QtvXQHA=;
        b=E470zhGt+Rjy0dtP05pYeEw0E8SxcY+8I2O7j0acoMGFfKQVWyKMixKGNz1d8ax1o1
         0RZVQYFh4ej6MnWqLZw+azepZgEAshrsu8AY5495ADPxMhMW7zAMhCPbpKkWeyJn1ar6
         I1EU/EVdsT9Vo7J8ymydApNmuwqcg5BPGiFgW6AhWaOf0PSdaJgiqeGigK93Kz2kqmID
         tbKvZy+F5ULeVaMM/sN2X2lF65L+TmbGc8hvbBEh7yo7vHsgmQUAk9vjJqzvBfi2GTyv
         9Lxo457dgCe+Rf7rp1O6+IUBkcV6aoreUIPMWJ6LdZf4jQPW2iqx091jCVCtQsXabt5b
         72kA==
X-Forwarded-Encrypted: i=1; AJvYcCUEPxkWXxE+9Qp3S79KX+QozVmiz8paRVxfCamLrInxKvO7AiLHPDnAwEaLshRmdQkXoqkh/h7HpjwFSLiRs+2YJVI9uI9FfWEmAaoo
X-Gm-Message-State: AOJu0YyNdO8y9CFmVCFxbwu8fCbZvsJJbU9swSuSyhyr8Lixb61JStZY
	X1hGz0Lz9DR7CEkHQpOFotA6GgttylNjnFXng5oz0/vvQol90xtL
X-Google-Smtp-Source: AGHT+IGenYDEmZuw45sDxN0ZWvdGhm8Vv68TCey7sPL9Z636mLJxswdd2LHFS63u61UraD2sVFkZPQ==
X-Received: by 2002:a05:6a20:1595:b0:1be:ca6c:d93 with SMTP id adf61e73a8af0-1c428679304mr3527108637.52.1721631047643;
        Sun, 21 Jul 2024 23:50:47 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ccf808f05bsm6155248a91.40.2024.07.21.23.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 23:50:47 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id C928B805EC;
	Mon, 22 Jul 2024 15:00:27 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: tudor.ambarus@linaro.org,
	pratyush@kernel.org,
	mwalle@kernel.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: leoyu@mxic.com.tw,
	alvinzhou@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH 0/3] Add support for Macronix serial NOR flash
Date: Mon, 22 Jul 2024 14:49:19 +0800
Message-Id: <20240722064922.606172-1-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

Add support for Macronix serial NOR flash.

Cheng Ming Lin (3):
  mtd: spi-nor: macronix: Add support for serial NOR flash
  mtd: spi-nor: macronix: Add support for Macronix Octal flash MX25
    series with RWW feature
  mtd: spi-nor: macronix: Add support for Macronix Octal flash MX66
    series with RWW feature

 drivers/mtd/spi-nor/macronix.c | 61 ++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

-- 
2.25.1


