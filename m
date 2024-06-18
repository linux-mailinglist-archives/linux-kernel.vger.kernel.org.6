Return-Path: <linux-kernel+bounces-220120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 446F290DCE1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 901CEB22C18
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE0416DC11;
	Tue, 18 Jun 2024 19:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XAhXj1BN"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7310A15E5CA;
	Tue, 18 Jun 2024 19:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718740434; cv=none; b=cSJvom5hVViDiHBpKLpjZCJ9ileT4NlZFlWDpxMDBV1aXnG/kSp6sqMeVAN5YdvVyo6KhQIT04N7hpX3zH1TU2ddy3HUqkCyIA5IZfcp1tVgsE7Y0pxmB3wvmBIY9MfxY8NWNwlU/zQ209EloYDJHaVXAa0twfBczD3A+zmi8ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718740434; c=relaxed/simple;
	bh=48hbnQ2T9qx+vWEMSlGI9VkZepMhop2InVAKIhpFVeY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mZz8giow7zma4MGR1PT9P24bfHp0CaI/NyIUsvhZn4tWkT8GmwzG30zQCAwSzTdPkaDn3zrcM0fMpQz4dy22FleNP0WnA959rVKASbJ0fp9RFLXxKNZDjFUKJKBpO4g3cYGmCf+V8xw3I9nL56G7TnactH/Y3vd+KJtuu5bAaXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XAhXj1BN; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-705fff50de2so121809b3a.1;
        Tue, 18 Jun 2024 12:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718740432; x=1719345232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=DBczn5UpQRXXikn8dQhHxMmY5ljdSnboHK2eCF3J4e8=;
        b=XAhXj1BNEOpuCu7RI6Qx0NCcQNIXliAGPaqTvktbC0nXfJuQGYfAsaTi9KHnYwzOza
         8mn1jL/ZAgiRk51Yljt+1REhsuiu8OQB1UmOfzz6Se/slo/lLWdV56qWTStR4M+7iS5f
         GeqNsG6pQtl8nXK1NyaabVG36ATn31jvDCtOlETqBIA2Cba8jcytJf75kzicYxazim2g
         GOQR0MyFpsjWXRa0zEd3GKLxDo4MWu/F2tBKpndQ3c1/r0pvvd8kSjVS8ddqoD7WdR56
         xQMVgqFt9e3lQV46S7qWu10I8/me0waEnmuzMYfGzOJTRoP0FiD2G34resc+vqClAbHs
         Mf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718740432; x=1719345232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBczn5UpQRXXikn8dQhHxMmY5ljdSnboHK2eCF3J4e8=;
        b=X7oPSYvOQAyAyS0HdDfRaWajc8H4UpBkNx13M09yAn0KlvjgeEViilM72jKhWJMgZA
         /ltUGrNfW17xdn0eqaAexARJyNhmGbsodM43Pn7m4HFu/HWEfbysmawpKN2OuByLPQEp
         XVW3MYTGcSgyYtUmEepcG8AYcSvqjLWSoICxHP0ztWEEE/MjYBpl/7ZaGuO+Kd8q2OIq
         q6zJXEi4ubobg51x1O8flEUIPwjEJ2XHxHa5oSNeMYB9UmvhZ9reAekkxtc76xbVnzhC
         gP3EezUtheWgyo0wzGq+7Aaex+1jBSJ4UvvZH3szOlydVsZyYIWE6y6wiSraLi5q3j2o
         6/Og==
X-Gm-Message-State: AOJu0YzmkbZZ62LlNw/GSIdGGmLSND8XLKmAKWD1670Ay+CWAGL4hYXd
	Dul9Hr54CCwd0D+JKTRActypCsMWoQ4YjGKH6XUg9TY1E/eUfgKg9OAFVw==
X-Google-Smtp-Source: AGHT+IFB0df60ze5pnoF8vT4dTHB6y9Mbkt3wgx3i9X0E2L6uQNVyPHU5WaHz5qxyoM0W52UmgfqJQ==
X-Received: by 2002:aa7:9ddc:0:b0:704:229e:54bd with SMTP id d2e1a72fcca58-70628fa93eamr985310b3a.8.1718740432061;
        Tue, 18 Jun 2024 12:53:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fedcf36b9esm8340985a12.19.2024.06.18.12.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 12:53:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	=?UTF-8?q?Ren=C3=A9=20Rebe?= <rene@exactcode.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Armin Wolf <W_Armin@gmx.de>,
	Stephen Horvath <s.horvath@outlook.com.au>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Sasha Kozachuk <skozachuk@google.com>,
	John Hamrick <johnham@google.com>,
	Chris Sarra <chrissarra@google.com>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [RFT PATCH v2 0/3] hwmon: (spd5118) Various improvements
Date: Tue, 18 Jun 2024 12:53:45 -0700
Message-Id: <20240618195348.1670547-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch of this series introduces multi-page support using the
regmap infrastructure. This simplifies the code and improves regmap caching.

The second patch introduces a spd5118-specific regmap bus to implement
SMBus accesses. This solves a problem seen with i801 I2C controllers
when writing to the chip. The I2C_FUNC_SMBUS_I2C_BLOCK support implemented
in those controllers does not work with spd5118 compatible chips, so
byte-by-byte access needs to be used explicitly.

The third patch adds support for spd5118 compatible chips which follow
the standard literally and block access to volatile registers if not
on page 0.

RFT: I was able to test the code on AMD systems using the piix4 I2C
controller. It needs testing with i801 controllers and with Renesas
chips.

v2: Added patches 1 and 2; simplified patch 3 to rely on regmap
    based paging.

----------------------------------------------------------------
Guenter Roeck (3):
      hwmon: (spd5118) Use regmap to implement paging
      hwmon: (spd5118) Use spd5118 specific read/write operations
      hwmon: (spd5118) Add support for Renesas/ITD SPD5118 hub controllers

 drivers/hwmon/Kconfig   |   2 +-
 drivers/hwmon/spd5118.c | 131 +++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 102 insertions(+), 31 deletions(-)

