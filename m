Return-Path: <linux-kernel+bounces-291410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 902EC95623B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 06:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DD59B20D1D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 04:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C1414AD23;
	Mon, 19 Aug 2024 03:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1/nbitl"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EA613D2BE;
	Mon, 19 Aug 2024 03:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724039814; cv=none; b=gTL0VH1wcEOZHXPopW5AlghW22OYNZL9+s2KwMsCpFQHzaSlDlTK+d2jDc6KbuQ5uWea3IgVfFvLv+M0rGiiG8i54XBSjfrZP+4TFp4CGeiqtreqjZqygdG/KYHi1VnmMkf9KEfbzUgHszw9ZpJ1hjbhJwEoeY24Vf4cEP0u9jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724039814; c=relaxed/simple;
	bh=VQlTy3JyL1JO54tUqyiMgXOrpUvf2/2jKwU1ZodpQFU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DKE1wj/q5z8g0VJLJP5oftGdiEWospPGv+A0NjSTbMeXIHUZnC8oilSRIpL2jhBh/n7NPy6Z19ZLJN2xkJ0XLXW+TOmekhM30gtr/8PSsQoQ8z6yQznPCflaZhsg6tQ/8LoMrQqnDZomC48OLxaVwlkIhbnkGihTMyfBTbG1R7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1/nbitl; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-201d5af11a4so36301385ad.3;
        Sun, 18 Aug 2024 20:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724039812; x=1724644612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GMZ9rvcN3iR9Q8xwVCUJVcQ9FiUXOexqld6lBS5xZ1A=;
        b=T1/nbitlMWd1lGv59RxRyNanAgumgTw1znYdnbsc2zdjQQTc7Jt4yjQV9+eqsqdfTV
         V8CvSir0WDm/zUUQOIlCNIZpx6HCcdLryz4r919URIRWywPbF2oj0T9W+eY1TPVip6iP
         N99/0tuIg+sq9tKOVbbOf3S+Jic7mn5FWAhOFmxBY6DWB3A+tw4MMRL1y+diBaUUoI9c
         C+VsX9ufsmPPmXIyNQYoHObaafIMiDgljnOLEPE0X+L1K6V/1kpL1YwFAq8k3W1ig2ph
         mpcWd2AuxCOFBV0SUqBW0BOWuGFkpqE9ev0umnCohCpyZguY27gil1klrzneU6bNE8HF
         RKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724039812; x=1724644612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GMZ9rvcN3iR9Q8xwVCUJVcQ9FiUXOexqld6lBS5xZ1A=;
        b=vOsN2UkOYAly5jxydHTYZ0VHDousgfykQ6Ot6ZuuqB3Jtk5XkeUN4qE/kE3SPmCDd9
         gMfaFvh0HqEOfrwWxdbgqojwHIKsbPTG0cinADRaWafsAkEh+idB9LDKJ4Y6xMrvimNU
         clctg/lWq28oq4sSphDhzAQvptiZzVzC4jS6Rs0XPawMfqY974sYJlIXE4uOHMmsPzDA
         il1svGBY3yIq4i/T9VsD8nH8vG3pZI3mb0l8l+xfseYz9u1LvaERej1Is4IrOGAlGOup
         sKNfx/Hbk82ucHazjZly6JbyypC2mjUknTap/3opesKL7OJ/8ZpOgnmaclR2u3t9z3Hm
         Y4sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbGgJCYqSVpIN8OHd4HAu7Mm6nVVeqYEJ/pzTGBPghsoR8P9kAm4k/nQ8XmZf4ScVw51K0+Fi6Imo9tK/3IxHGu091qU8Ysq9V00pNJgTZ2n/WWpzfx2DbZjvJhgLNuPbk0LAUypqYSA==
X-Gm-Message-State: AOJu0YxpgtNVD3RGkdvh7dez8ZE9pePtfLYcYQlektB61HsXRGQqrsI+
	kBS4Pd3kRSApfKooYda92JiAsKldMlS2OWicnFEb2QtMnipBqIsr
X-Google-Smtp-Source: AGHT+IEKBhYBnAvPKWan3AhEl+XTUbhdrUsrDNblATEFmLfYDep00piSaKlr6N+dv4Cf4D8iPzgKWQ==
X-Received: by 2002:a17:903:41d2:b0:202:19a0:fcba with SMTP id d9443c01a7336-20219a0fe95mr62909075ad.41.1724039812219;
        Sun, 18 Aug 2024 20:56:52 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0375649sm55784435ad.124.2024.08.18.20.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 20:56:51 -0700 (PDT)
From: Jacky Huang <ychuang570808@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	soc@kernel.org,
	schung@nuvoton.com,
	ychuang3@nuvoton.com
Subject: [PATCH 0/3] arm64: dts: nuvoton: Add pinctrl and gpio nodes for MA35D1
Date: Mon, 19 Aug 2024 03:56:44 +0000
Message-Id: <20240819035647.306-1-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacky Huang <ychuang3@nuvoton.com>

This patch series adds pinctrl and gpio nodes to the device tree of
the Nuvoton MA35D1 SoC. Additionally, it includes pin configuration
for UART nodes now that the pinctrl node is available.

Jacky Huang (3):
  arm64: dts: nuvoton: Add syscon to the system-management node
  arm64: dts: nuvoton: ma35d1: Add pinctrl and gpio nodes
  arm64: dts: nuvoton: ma35d1: Add uart pinctrl settings

 .../boot/dts/nuvoton/ma35d1-iot-512m.dts      |  80 +++++++++-
 .../boot/dts/nuvoton/ma35d1-som-256m.dts      |  83 +++++++++-
 arch/arm64/boot/dts/nuvoton/ma35d1.dtsi       | 151 +++++++++++++++++-
 3 files changed, 305 insertions(+), 9 deletions(-)

-- 
2.34.1


