Return-Path: <linux-kernel+bounces-169582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A588BCACE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 11:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A93541C214C4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC1014263A;
	Mon,  6 May 2024 09:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfjfdQQr"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD5F1422CA;
	Mon,  6 May 2024 09:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714988231; cv=none; b=KKvB4bgu+5rKBo7VAOXzi7Z+MhHVHyHoOl+7jQB3inGWRnI61hh1uFuWYNtdOk9unhrVAoLgnGCZawNosyomgsFW45cb/Jg0S3XopUL43DvxWXB5Xx+5e/SqYB+ZR6wPuz4XvlfY7zI7nEIGRqGnxYCnQFvR1Xuof7PlRt4M0MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714988231; c=relaxed/simple;
	bh=7vZGPc76DrGzVO0f10p7VjAUkU9H6GCoaoBNveOsq+I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UolyOGz157fnJn8Wdtx06hrQaIgfMlq5L0PEM0W5B72lpQWUiJR8LoYe8BGjOLmcYvbGwuViuNq7Rvv1zhI/z7knrrhafYuIV2BTdq2brUMMcrPoBX0Jr8Wi3bwFkaTjF3/T6+WKMNXJkvKfZ6rstoLhUC72mMRJWHjFws7tRQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfjfdQQr; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a59ce1e8609so108912466b.0;
        Mon, 06 May 2024 02:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714988229; x=1715593029; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r5jIPijYH58Tf3UqAkdEdhYtcZDbmpkBfkvefoQcR1g=;
        b=bfjfdQQrcjeqgJiIbs7LyN1XPcxubS0ojT3twuo8THGfv4vMU9M+9AHNvnhsGVFC07
         lRL1qqGfHLuTDSef301MT+DH3RXlMyQ9Dz+obPasXARTNmXNx0c6ahFyJq4mSYal8t4W
         8FpIrXkEbcVhVJc6QtzC29Kbfy3ili347J6H+LkgYjaeoOMJEwozhXzVKwN6z148xlyN
         PdLkObXvIB7xWpjKhEi4SnClYLaB7HcseMr3zdEX2TwLpJEqG1QD6u1A2gXTb66MwxGs
         yRIDVHRn4rPyE3sL3/tRN7PRdm+vNV9GNUsVI1INHblIoLzvYOOFXNw/8WQ8ZxO9AWde
         0RNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714988229; x=1715593029;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r5jIPijYH58Tf3UqAkdEdhYtcZDbmpkBfkvefoQcR1g=;
        b=CgAZwtIN9wty6KG5dT40KHj7bK7G5ynCIRn/CXiUtmLGU/2v7d/2ZeZayV9Xgewfme
         LdSgRHtFWk/2q856L6fJbtZ8fiUbdka/DfL/nf/5+X3wzLPTgrNiyaoYDstkLQPb9WAX
         bPnwBDr9r/KqD56Nd8FzvXzSyRrp2fF/3PwnoQ3MrufzVDhq0cVfyt1QySZ32E3LFEeB
         TnL54KshqawD3JXwMpOvt78mRXz/98r25gihBYxjmNtdqrtjoCNk3NX0H+aJ9oSNQIqv
         sM2JLM4SEBJK3bNXOvBbJtyfEiT0DZt4PTk+ZjCMXPzRw6K7jlBhiP2z8JYRnwaJWw1M
         /7cA==
X-Forwarded-Encrypted: i=1; AJvYcCV8ZBA5mYK5kGosgc3OC00BoHVF5pbdCVjT/BrAspGc1YgLdIQTtAhi0Q1MpesUDSvpYWiPw2oqEhWKI6Ioe8bhbL87UOAwBATpTxFDjFF8Cm8XmJ4zn2rvlxekKidPToC/k2Hx9Ru6yA==
X-Gm-Message-State: AOJu0Yyhl9BDpwEtDJ9P+n6Qxn/ITZPsjI85GkDmQIDIxa+wKWPjIeva
	TJ34SXvUtYGBzI8Mx1wT7JwyYHHYMt8a0oX82Qstxw303Ye6Kq/ES/opRN+iDFA=
X-Google-Smtp-Source: AGHT+IEIt+uXhXBzY5x1yHpICtzLpB4DBfyF6+9n8Ln7qiLnBjv56h1If998ClUbsWoO14PRhjI8pg==
X-Received: by 2002:a17:907:983:b0:a59:92b0:e0d3 with SMTP id bf3-20020a170907098300b00a5992b0e0d3mr7434959ejc.34.1714988228446;
        Mon, 06 May 2024 02:37:08 -0700 (PDT)
Received: from [172.30.32.119] ([2001:8f8:183b:f2c::d35])
        by smtp.gmail.com with ESMTPSA id f6-20020a056402160600b005722ce89ae2sm4983647edv.38.2024.05.06.02.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 02:37:07 -0700 (PDT)
From: Alexey Charkov <alchark@gmail.com>
Subject: [PATCH v4 0/6] RK3588 and Rock 5B dts additions: thermal, OPP and
 fan
Date: Mon, 06 May 2024 13:36:31 +0400
Message-Id: <20240506-rk-dts-additions-v4-0-271023ddfd40@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKCkOGYC/23NQQ6DIBAF0KsY1qWBAUG76j2aLhBQSas2YEgb4
 92LJk1NdDd/8ufNhIL1zgZ0ySbkbXTBDX0K/JQh3aq+sdiZlBEQ4IQCx/6BzRiwMsaNqZsmYWS
 VgyxkVaJ09vK2du+VvN1Tbl0YB/9ZP0S6bH9YvscixQTnhSxB5qZior42nXLPsx46tGARNgAjB
 wAkQAsA0FzLwuwA9gcAygOAJUCo2hZcMiUY3QLzPH8BaK8b5DIBAAA=
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Dragan Simic <dsimic@manjaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
 Chen-Yu Tsai <wens@kernel.org>, Diederik de Haas <didi.debian@cknow.org>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714988224; l=5215;
 i=alchark@gmail.com; s=20240125; h=from:subject:message-id;
 bh=7vZGPc76DrGzVO0f10p7VjAUkU9H6GCoaoBNveOsq+I=;
 b=s+4z6Z//zqaTm0lGuKZ8UgFm6uu2TETMUwL1oXERwQO1v59SLNQrg71k+12jQqguH3qa4XY7o
 41zRfeO4x0jArjk0vxhg5jwu6CT/um8WzHMoGQb6SFSGMHxfuu5SMm8
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=xRO8VeD3J5jhwe0za0aHt2LDumQr8cm0Ls7Jz3YGimk=

This enables thermal monitoring and CPU DVFS on RK3588(s), as well as
active cooling on Radxa Rock 5B via the provided PWM fan.

Some RK3588 boards use separate regulators to supply CPUs and their
respective memory interfaces, so this is handled by coupling those
regulators in affected boards' device trees to ensure that their
voltage is adjusted in step.

This also enables the built-in thermal sensor (TSADC) for all boards
that don't currently have it enabled, using the default CRU based
emergency thermal reset. This default configuration only uses on-SoC
devices and doesn't rely on any external wiring, thus it should work
for all devices (tested only on Rock 5B though).

The boards that have TSADC_SHUT signal wired to the PMIC reset line
can choose to override the default reset logic in favour of GPIO
driven (PMIC assisted) reset, but in my testing it didn't work on
Radxa Rock 5B - maybe I'm reading the schematic wrong and it doesn't
support PMIC assisted reset after all.

Fan control on Rock 5B has been split into two intervals: let it spin
at the minimum cooling state between 55C and 65C, and then accelerate
if the system crosses the 65C mark - thanks to Dragan for suggesting.
This lets some cooling setups with beefier heatsinks and/or larger
fan fins to stay in the quietest non-zero fan state while still
gaining potential benefits from the airflow it generates, and
possibly avoiding noisy speeds altogether for some workloads.

OPPs help actually scale CPU frequencies up and down for both cooling
and performance - tested on Rock 5B under varied loads. I've dropped
those OPPs that cause frequency reductions without accompanying decrease
in CPU voltage, as they don't seem to be adding much benefit in day to
day use, while the kernel log gets a number of "OPP is inefficient" lines.

Note that this submission doesn't touch the SRAM read margin updates or
the OPP calibration based on silicon quality which the downstream driver
does and which were mentioned in [1]. It works as it is (also confirmed by
Sebastian in his follow-up message [2]), and it is stable in my testing on
Rock 5B, so it sounds better to merge a simple version first and then
extend when/if required.

[1] https://lore.kernel.org/linux-rockchip/CABjd4YzTL=5S7cS8ACNAYVa730WA3iGd5L_wP1Vn9=f83RCORA@mail.gmail.com/
[2] https://lore.kernel.org/linux-rockchip/pkyne4g2cln27dcdu3jm7bqdqpmd2kwkbguiolmozntjuiajrb@gvq4nupzna4o/

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
Changes in v4:
- Rebased against linux-rockchip/for-next
- Reordered DT nodes alphabetically as pointed out by Diederik
- Moved the TSADC enablement to per-board .dts/.dtsi files
- Dropped extra "inefficient" OPPs (same voltage - lower frequencies)
- Dropped second passive cooling trips altogether to keep things simple
- Added a cooling map for passive GPU cooling (in a separate patch)
- Link to v3: https://lore.kernel.org/r/20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com

Changes in v3:
- Added regulator coupling for EVB1 and QuartzPro64
- Enabled the TSADC for all boards in .dtsi, not just Rock 5B (thanks ChenYu)
- Added comments regarding two passive cooling trips in each zone (thanks Dragan)
- Fixed active cooling map numbering for Radxa Rock 5B (thanks Dragan)
- Dropped Daniel's Acked-by tag from the Rock 5B fan patch, as there's been quite some
  churn there since the version he acknowledged
- Link to v2: https://lore.kernel.org/r/20240130-rk-dts-additions-v2-0-c6222c4c78df@gmail.com

Changes in v2:
- Dropped the rfkill patch which Heiko has already applied
- Set higher 'polling-delay-passive' (100 instead of 20)
- Name all cooling maps starting from map0 in each respective zone
- Drop 'contribution' properties from passive cooling maps
- Link to v1: https://lore.kernel.org/r/20240125-rk-dts-additions-v1-0-5879275db36f@gmail.com

---
Alexey Charkov (6):
      arm64: dts: rockchip: add thermal zones information on RK3588
      arm64: dts: rockchip: enable thermal management on all RK3588 boards
      arm64: dts: rockchip: add passive GPU cooling on RK3588
      arm64: dts: rockchip: enable automatic fan control on Rock 5B
      arm64: dts: rockchip: Add CPU/memory regulator coupling for RK3588
      arm64: dts: rockchip: Add OPP data for CPU cores on RK3588

 .../boot/dts/rockchip/rk3588-armsom-sige7.dts      |   4 +
 .../dts/rockchip/rk3588-edgeble-neu6a-common.dtsi  |   4 +
 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts   |  16 ++
 arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dts   |   4 +
 .../arm64/boot/dts/rockchip/rk3588-quartzpro64.dts |  12 +
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts    |  34 ++-
 .../arm64/boot/dts/rockchip/rk3588-toybrick-x0.dts |   4 +
 .../arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi |   4 +
 arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts   |   4 +
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi          | 281 +++++++++++++++++++++
 10 files changed, 366 insertions(+), 1 deletion(-)
---
base-commit: 160b088184ec81028ff67a5032be33f1baea4b67
change-id: 20240124-rk-dts-additions-a6d7b52787b9

Best regards,
-- 
Alexey Charkov <alchark@gmail.com>


