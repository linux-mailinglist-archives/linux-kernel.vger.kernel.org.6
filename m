Return-Path: <linux-kernel+bounces-203219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 539DB8FD7FD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 23:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69C561C23266
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 21:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1977315F3F0;
	Wed,  5 Jun 2024 21:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKFwiyE6"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE6D3F8E2;
	Wed,  5 Jun 2024 21:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717621254; cv=none; b=mcIgl8V/QNisZi8dxkVC5WXLSaQbt2W2fPohrVqxv1u6+hBuZ24GdD+WnTHFyZr9q7BwEILzgwqVChMD8QE2gZLoIJMNsgNqEaYwyMF3kz+LyFmcrwFAEwHGSHX2/VBgGBPyUwQq1cB3mEWCrm2pxqoG+M4JI4W9fIlnVZHvprQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717621254; c=relaxed/simple;
	bh=SLWqVrVFKIkmiTUZHJG8FYp74OJNI53OWPPhHkDFqyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u+uS6MnCAAYE8VvwdjNX8yn0sUlZ9mYuiTNWmXhimIY6DxpSvn9w7EI5LFi+UvWxQVAAchP9ivuZKkeaGYQ+2MbADwLvAoQ8a4M51q73nCK1I+NxgOLOtjoDoCog8WM2cmgibp8+Iwch+eVdgf6WCoyS+XBGfMUIXdwHNFDTahE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKFwiyE6; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-35a264cb831so252372f8f.2;
        Wed, 05 Jun 2024 14:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717621251; x=1718226051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GEz1de1uXTIeqqebkZztUoW9m4tZyjUe1SpkIZLWTwI=;
        b=gKFwiyE6gYjRwpTMGwuIwSzgPw1fgTLntJXMqFL8fKYILt0WkmRvWIREV/tKnStitO
         EfCwp0b17OlvSK8i2h9kjE2JykVzsI0Ks1AsRZbnFVokCivclb6gf1hRS1UxBi+w1Kz0
         m4C64ZVoV0vRkKGHb4w6VAAtyJUgsMCGyujpRy1JqBkCyZat9GmY1fwU6CiAs8Utb2dE
         9RrZhNLxAmlIe+JbKQPamoUsIMY2KL1jnUHkorL8eMTycPg3rG7dCUfs4u8jNdavafcC
         sHm6g1FA74NWFrlLbWxq7R4Sys5CU5WfO5Rlf4+jywrCyJzCxGWWdENj0Kw3yRL3jAI0
         Z7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717621251; x=1718226051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GEz1de1uXTIeqqebkZztUoW9m4tZyjUe1SpkIZLWTwI=;
        b=h/7u5yWE7I2+8iNLquOGsHO2c9oIJNv/lAZEcWy6UuIo32wn9TpJoI5dKh0AlGtPho
         CY0R4g+8Cb/YxtnswwPZqhuKzOvsYnEhsG5iuj+t1RzgxVWdOAlzMkEIP1Cnf1NT9Ve3
         s6Ox/5RCTtHqtZBTRymCDqlK4vMAa325uXcFYJCXwxCZfAPYWGMw77x7U9FFPuqrAJnw
         26Ghng7wFkoKbar20L3CGMgZtKaONBA58lFPsC4Ox6fDMSvkTnhDMnmJX8aLWyYdjlXu
         NUsXbNt6l2wInIr1l9aicK7CbNwB9oIgChGZPeUoG5OPNwK0nkgoOVAshUXAP8JaeSUV
         LF7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2bJmthbAyM8efx562G2tgrnwQTaHo7sTT3sbX5XfpCi6lYoW9AZ6bgHwcEldICt8lkk+/gpGk0yhRnIUOmXpPGO4hAIETXl/zPZ1n7Zz7BEVeu7OiLKXBpBQasBzFDO+C9/GKBipJya754F21n0riHILRz59HIRC2aI3eqCJ8dGTDOg==
X-Gm-Message-State: AOJu0Yx6WU+WAwde8gmPcFP/3K59aTJhXqEuHeM7HUMbW/URd/kPeA4d
	tC+pH/69eCr+Q0uz4k3MfaKPkTN5QOqpFaIVXvIaFKVt8e8AU2LaMWvr
X-Google-Smtp-Source: AGHT+IH9LL99z0MTv1+jQF9F2sePDzl73lNh17BbV9ZjLHWp7Mick2PRDD0mTpfpJyEfuh1jNHOhNg==
X-Received: by 2002:a5d:5547:0:b0:351:c2c1:3682 with SMTP id ffacd0b85a97d-35e8ef88819mr2810501f8f.62.1717621250945;
        Wed, 05 Jun 2024 14:00:50 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:5211:58fe:dfef:c48c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c0d77sm15955721f8f.5.2024.06.05.14.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 14:00:50 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 0/5 RESEND] Add SFC support for RK3128
Date: Wed,  5 Jun 2024 23:00:44 +0200
Message-ID: <20240605210049.232284-1-knaerzche@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the Serial Flash Controller (SFC) found in
RK3128 SoCs.

As without using some "id holes" we would run out clock ids in the binding
and would have to touch the ABI, I added patches which removes the
CLK_NR_CLKS macro and uses the recently introduced
rockchip_clk_find_max_clk_id helper instead to find the highest clock id.

changes since v1:
 - added patches to remove CLK_NR_CLKS (Connor)

Link to v1:
https://lore.kernel.org/all/20240605172154.193047-1-knaerzche@gmail.com/

Alex Bee (5):
  clk: rockchip: rk3128: Drop CLK_NR_CLKS usage
  dt-bindings: clock: rk3128: Drop CLK_NR_CLKS
  dt-bindings: clock: rk3128: Add HCLK_SFC
  clk: rockchip: Add HCLK_SFC for RK3128
  ARM: dts: rockchip: Add SFC for RK3128

 arch/arm/boot/dts/rockchip/rk3128.dtsi | 35 ++++++++++++++++++++++++++
 drivers/clk/rockchip/clk-rk3128.c      | 21 +++++++++++++---
 include/dt-bindings/clock/rk3128-cru.h |  2 +-
 3 files changed, 53 insertions(+), 5 deletions(-)


base-commit: 234cb065ad82915ff8d06ce01e01c3e640b674d2
-- 
2.45.2


