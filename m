Return-Path: <linux-kernel+bounces-203207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 791118FD7E3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F38161F2137A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F6B161301;
	Wed,  5 Jun 2024 20:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1f0eTKJ"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E0015F41D;
	Wed,  5 Jun 2024 20:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717620739; cv=none; b=tIz6hu+eEg9/c2AINgVtrwLfIhS5W+cNHMmfrlORbBaS3PNPcp/PgVHpI10dLvFn2iNshefo4LE7HTBFD7m6DBWbYZbwEjdPWsc2NYvWKf1vEdhKrfDoWLT/gHa8mGknPkstz3UCdRVkGU8DXr8QcK/wcXNoYnxngtpg0LmftTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717620739; c=relaxed/simple;
	bh=SLWqVrVFKIkmiTUZHJG8FYp74OJNI53OWPPhHkDFqyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXwGUVuCUOZUAkzvkLhtI5Ck03u/ewTW+tgMbNhslJJp88EFQLFZVkz7fspgqbMo2TZE9pjXf+T1FSajJn3g6OLJLZ6JAsyRsQ9PXIT9Bbe9pYb1StOiivUKwtgywHWSbwi1SpuV8AzlgOI7zuqFpCdYCO+JmaxRiindnX0Ah+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1f0eTKJ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6c399dbb38so29202766b.0;
        Wed, 05 Jun 2024 13:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717620736; x=1718225536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEz1de1uXTIeqqebkZztUoW9m4tZyjUe1SpkIZLWTwI=;
        b=R1f0eTKJVvlff9g6c0N2Ad2sg0aWxL9xVhh7bkzA4/fm7dq7ik/jndqHW61p+1qdAr
         G2ThaAK5KzcGjAF34vrW+XkeJdQgcXW7axakWhnXPQX9sru+3SXWshAL7oYXUjzKUj5M
         B9QgbSI/v4T6MHNMuEhI1bd+6JlozUU5Kk7X0EcDTowk3mGGICHcup6zRnFD2qJV6+a6
         85zsWO6po5iD+Wf/JeC/NHa7KNZ1H11fCY5eF04zHVg33yGUu5Sm5/nA/HaTVjz4UFRj
         0uM5ygKRX7HgRZucMGvqA2iPTT1MJCklKFH8JGLMF8PAU7e5rM0v3rZ6Iitr+aW5Jkp2
         u0IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717620736; x=1718225536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEz1de1uXTIeqqebkZztUoW9m4tZyjUe1SpkIZLWTwI=;
        b=v+vi6Y0nO70789uYt2L+ZX8uye8VL5bmRbhvJbaZ4W3260gdk8q97/KJcKRjCdnvVZ
         94De+oe6RfpCAOXYh8P8cVKqfFeJYptdePbU59D8IPljYotyuTxCsTMrjInljvygOduG
         dSJ2mwfwT6MxAyENB8k9xJsBBE/fxzBq9mHzl/YGS6R5IrkXyA7Zb0LiVVeuBPaOYguq
         myM/xzRXxKK7JoPZq0Nxxz6C2dMpwu+A3dX/GnX2vYEtHZU/NbYauaJYW1PnSSmPs2am
         raGl2JUxxITUaNyUrsATrJa/Jqo4yP95uznA643c9ymB56DQy3yZzJbE6o9LpyQHnNUS
         bJOg==
X-Forwarded-Encrypted: i=1; AJvYcCVnbV421B6xtxVL/knQUbwXdnLwaKAe6g+1JdOtLb90h+awLMsD3y6Z2MbYk5tMf3nlGJAMNIjClZP/lZy6xYVbHXbdG5VZAon7ujsjlbfoyZ3EfbZryYxHonHcLilMplqkS8Dt9lZiYJVkEghlUshgFxRZlO7cGx9Dk0d127SbecmBGQ==
X-Gm-Message-State: AOJu0YxZxK/uCtiYg/L8OoWxDpwe6BCCf6Bp4wjLimFoKeuPZQYC+5x+
	ANd71za6DGYO+mE1UB+Al6Bjs6CottlUfDOvii4PYpiEqtgCRc8=
X-Google-Smtp-Source: AGHT+IFvJVNAro7XNZmkDXN79dHCw0ldWI5/pYO5embn2/8D1cTCJZJXT7rOoRKPufaz4yQyjUACYg==
X-Received: by 2002:a17:906:33d8:b0:a6a:296d:6cfe with SMTP id a640c23a62f3a-a6a296d74f3mr192207066b.26.1717620735477;
        Wed, 05 Jun 2024 13:52:15 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:5211:58fe:dfef:c48c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c71bb5affsm72265866b.147.2024.06.05.13.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 13:52:15 -0700 (PDT)
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
Subject: [PATCH v2 0/5] Add SFC support for RK3128
Date: Wed,  5 Jun 2024 22:52:04 +0200
Message-ID: <20240605205209.232005-6-knaerzche@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240605205209.232005-1-knaerzche@gmail.com>
References: <20240605205209.232005-1-knaerzche@gmail.com>
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


