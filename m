Return-Path: <linux-kernel+bounces-320928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F9A97122A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BE70281861
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1061B1406;
	Mon,  9 Sep 2024 08:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pm/q3D/6"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2490415B995
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 08:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725870833; cv=none; b=Gm0Kb2nzWdKLWgKI9lH3U0akSrb/ysfI9SuUNOotYbL35to1zy705dXQYtT/aN/0+5lmSLajLVbKCAWy+haU87Jx2YLy01QKuvYX2kUqixfncIhIq3qrOvrBh7PFMUyE1Myqunq2UnHxL8mkJoVwuIhs04bFn5Gj5gcx/0EDDlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725870833; c=relaxed/simple;
	bh=VDfnS2jpKE1hQvq6GelvGA8I6GbCKYPp0U+1lf2dKEI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=scaGH3IvZGBhmShxkcugI5keEE5IUSDBrv4OKkjGRZIthjiPdNn4o+TZutn8qzJ47NYHaLQrZDqghe5UEmR4eBYF9uTHvRm5EO8KpGJUc+jmJ4ipoE5OyDpwBMimKXcT+dq0ZzdBLDeRDKFaVoq9B0VKdquuzmZZ64jHNY2bGrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Pm/q3D/6; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71798661a52so2355583b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 01:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725870831; x=1726475631; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5LY8dASkk+dg4PZXFjTnI2q2Y9JwOZ8jAo1izlcgUA4=;
        b=Pm/q3D/6X44quJ1tNHNGOMiSroMKagRmvSmln5DV6qr3oI9Pnp3RoEKUeh0vJbUCXr
         16IVqDClHsiMHfuAiPrkAuQEOj8f9ZfkUIGHlGnYpXrANeq1cqtvUqyOd4+l3shXQU4C
         ulenKATKiS/fx9dZFbcSN3x0Ajqlck5Fu6u+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725870831; x=1726475631;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5LY8dASkk+dg4PZXFjTnI2q2Y9JwOZ8jAo1izlcgUA4=;
        b=Guwzg1jv/lKC1vKO0lSHOu28waB0ZPaRlLZqlgWcRhPREiOpBLKg6ff8kKMGI8WXer
         VJGIxVUN9NxMfXvWp4Ws+lcEVXaSK9WZ+LF93Xg5089eG8pYUsIn0OtmqwFu0pUxtE0h
         0CpHplQ9EnM+vaO319+BVpOO4vqlp+dWr1oA6TlOuCKmHZ1uYr+Lovrk/Xb38ZBtbJV7
         ++reBiEA0XwBF7gg6uIUu2G+gu315NWm7qfxNykzLxXkfopufX8OSK4Xqs3bqHTRatxO
         JUirzLHWw/0sObQc3m2sH+D6Mcq1h9PTNB9ZsbQBTszS+iktLyauWaNW0nGOgI8CYhwV
         0DEw==
X-Forwarded-Encrypted: i=1; AJvYcCWRTR1GioLLP9WZgeKMvtwNJvuRAKUOBj3H0x4xySGAEGpTzN5b4Id9rKL0Na9Glyy48zXyfY3IheTipBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxifms54b+sjrZpHilz6F3raI/r985vJHwYvA+XFLJpogclKSQl
	7Mfu/HFhPFheT8QNdpaW2p8YQLZodIGcZT7BL72VHmO8si0TCUzkUL9nvKxK/A==
X-Google-Smtp-Source: AGHT+IEmLIcE8qMaxnnv2zZLscrUPbDYWU+TokeaZ0hiGU1HDPHBrhYfK1sSLklczfLbwhjaCOSjjw==
X-Received: by 2002:a05:6a00:99f:b0:706:aa39:d5c1 with SMTP id d2e1a72fcca58-718d546b387mr17613344b3a.8.1725870831080;
        Mon, 09 Sep 2024 01:33:51 -0700 (PDT)
Received: from yuanhsinte.c.googlers.com (30.191.80.34.bc.googleusercontent.com. [34.80.191.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e5982103sm3153558b3a.142.2024.09.09.01.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 01:33:50 -0700 (PDT)
From: Hsin-Te Yuan <yuanhsinte@chromium.org>
Subject: [PATCH 0/2] Fix the address of eeprom of mt8183-kukui
Date: Mon, 09 Sep 2024 08:33:45 +0000
Message-Id: <20240909-eeprom-v1-0-1ed2bc5064f4@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOqy3mYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSwNL3dTUgqL8XF0Dg5QUC6Nk8ySTxEQloOKCotS0zAqwQdGxtbUAfn4
 XUlgAAAA=
X-Change-ID: 20240909-eeprom-00dd82c7b4aa
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>, Ben Ho <Ben.Ho@mediatek.com>, 
 Hsin-Yi Wang <hsinyi@chromium.org>, Nicolas Boichat <drinkcat@chromium.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Hsin-Te Yuan <yuanhsinte@chromium.org>
X-Mailer: b4 0.15-dev-7be4f

The address of eeprom should be 50. The fixed commit in krane one is
older than the rest, so split it for backporting.

Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
---
Hsin-Te Yuan (2):
      arm64: dts: mt8183: krane: Fix the address of eeprom at i2c4
      arm64: dts: mt8183: kukui: Fix the address of eeprom at i2c4

 arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dtsi | 4 ++--
 arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama.dtsi | 4 ++--
 arch/arm64/boot/dts/mediatek/mt8183-kukui-krane.dtsi  | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)
---
base-commit: da3ea35007d0af457a0afc87e84fddaebc4e0b63
change-id: 20240909-eeprom-00dd82c7b4aa

Best regards,
-- 
Hsin-Te Yuan <yuanhsinte@chromium.org>


