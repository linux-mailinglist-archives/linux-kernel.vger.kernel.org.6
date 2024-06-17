Return-Path: <linux-kernel+bounces-218135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4798790B9A5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 20:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C76E1C22172
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C01196D9E;
	Mon, 17 Jun 2024 18:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jfpDXqan"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F49192B88;
	Mon, 17 Jun 2024 18:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718648968; cv=none; b=J/L7PkAdGblp+0T0YWyaVm/P3xUTJ1LWVf2hy1sRhO2oxhdLgpkk2ehrwWne+PaQPwuSr7olLc3I87M3ntY26b88HM6zXGidpduvZ7oXubt+5SB4oQ9jtQp+IlO05yxRawflzgAficO1cs+lA5cUZqjEwizf/Y+OMWZg2o9G6bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718648968; c=relaxed/simple;
	bh=WMbige49UsQOmc4Mz5m2i0vvhik3vgzfKYhW/ajYTP8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qjS7IkeGfR+M1UHy8vzEp+Hu1kLMqsEQZoczfTflRlhp0RQW8nrGNSAm1yeGEWws4B3soXJR1d31aUZFt2kNVk9/MB/aIW7mrcgvDtSMpubYvX9/EKsVJn+KAisxec/ZJE+j83Jo1dHuqQtYyL5+hC0aCexJHQGrxQ21n88kkMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jfpDXqan; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6f253a06caso551780966b.1;
        Mon, 17 Jun 2024 11:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718648964; x=1719253764; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8q3oJJYJeDsZ6fkX48D57T9FGaelorV2PIDQFy/zp9s=;
        b=jfpDXqanMpOjo2L7aO96cz/LzjK6uv35CFurwupEGPYVsXrFSfn27yl4KaFLtMN0Dw
         XoKm15UxazYTexFtF+1M2UHlWjQDiIUfwcOKZeHCNkNrDEOOCnWI7cCtrScyVN4CjYDd
         jr2NmbXiz1AulzI+8pLyWNAvjYzAfFKIXWUP4dplUJrMZ/t75pvL15gsSBAeov7yuTq8
         qon99gUguBzobCVlt/rNKeE+WHI35N+J0H6lVSaQGZ6dDKhGylD2ttwJECvnoaQXxFDc
         zNwcANyYo6SmYvOg/auHD+fFkQL45ooSJh1vlKxya/Szr7XahRy/mW9xG+gKjOC+MJvn
         LB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718648964; x=1719253764;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8q3oJJYJeDsZ6fkX48D57T9FGaelorV2PIDQFy/zp9s=;
        b=VBFWg4C2YFhLqnvTqW2LKIxjOW7I3wdapodfVhNV1jU2LSZQT+tQV8sAdUjdG4C/Xv
         zDNrHn5sHI+CWJ5G+Qt8/ZD7vhX1D2FvMoVWVURm4vCsznsx4DmR2oT0b2ctttR3+sRd
         H6He2PNXWWH96r6HzXIPxINyllxAgAluqYik538Um5AXulT4zHR/uFEY6SKPudJVnRsF
         +PgpkpMJx/EG4W0Z9BWqKp6rduiYqeKATCQAF6PbXaPT0oMiP1lr4gabbpswmcxwgI4T
         e2n2CpZjWnJq87q2aKsLMdj/V8i7wIJ+n0alkJWRTGSkG/U5tOCx1pC3ByARaCIfkZVb
         mkrA==
X-Forwarded-Encrypted: i=1; AJvYcCUYU7tBiTkSdjRsfv/H73uCRTYJt9GVPXYweDOAn+E/KGxtvXm3M9gyT+uY8sm56vowRsOPZZkKIsdz4qJDlalH6MHu5I93UMPHjQAA2gaIzyLRzMGIZO5NZ2zJbNugCWuCrxWIqVFNGQ==
X-Gm-Message-State: AOJu0YwrHSC4A/HRD8N5NoIDgXcthuGyejSHtTz2/dq9bPrbdC/6B/GN
	8MjTaw6Rw9acZhkFucefvVFGuNvRlXaQIRlZJgGMbEMpFQJKH0VH
X-Google-Smtp-Source: AGHT+IGZZrE2bW+5FrRCYR2ZqxaY6uc5IUZIpBu8pTxwSJg1wXzvYHdXgbwlKLrIdXEj94HJFUt5AQ==
X-Received: by 2002:a17:906:3912:b0:a6f:4b2a:2877 with SMTP id a640c23a62f3a-a6f60d377d1mr917724166b.22.1718648964053;
        Mon, 17 Jun 2024 11:29:24 -0700 (PDT)
Received: from latitude-fedora.lan ([2001:8f8:183b:6864::d35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f8a6e58bdsm115397666b.187.2024.06.17.11.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 11:29:23 -0700 (PDT)
From: Alexey Charkov <alchark@gmail.com>
Subject: [PATCH v5 0/8] RK3588 and Rock 5B dts additions: thermal, OPP and
 fan
Date: Mon, 17 Jun 2024 22:28:50 +0400
Message-Id: <20240617-rk-dts-additions-v5-0-c1f5f3267f1e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGKAcGYC/23NTQrCMBAF4KtI1kaSyV/rynuIizSTalBbSUpRp
 Hd3FETR7uYNb765sxJzioWtF3eW45hK6jsKZrlg4eC7feQJKTMQoIUEzfOR41C4R0wDdWmy6Bo
 DrnJNzejskmObri9yu6N8SGXo8+31YZTP7Rsz/9goueCmcjU4g42y7WZ/9um0Cv2ZPbERvgAlZ
 gAgIFgACDq4Cv8A9QEA6hlAEWB9GyvtlLdK/gL6AxhhZwBNADgpQCG2qMU3ME3TA4j7KNtzAQA
 A
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718648960; l=6562;
 i=alchark@gmail.com; s=20240125; h=from:subject:message-id;
 bh=WMbige49UsQOmc4Mz5m2i0vvhik3vgzfKYhW/ajYTP8=;
 b=bhB+rM748aIfI2h+5Lw1aQRCpp3YKwof7eIKnQgzq/eMJIC3xRlmxAWgQTbMuZFfWenszV626
 unYHXPNIvQ1DN/MUjiC3AywITeCI8RbXuzbKA6psctGcx6Ze5ChCaya
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

This patch series has been rebased on top of Heiko's recent for-next branch
with Dragan's patch [3] which rearranges the .dtsi files for per-variant OPPs.
As a result, it now includes separate CPU OPP tables for RK3588(s) and RK3588j.

GPU OPPs have also been split out to accommodate for the difference in RK3588j.

[1] https://lore.kernel.org/linux-rockchip/CABjd4YzTL=5S7cS8ACNAYVa730WA3iGd5L_wP1Vn9=f83RCORA@mail.gmail.com/
[2] https://lore.kernel.org/linux-rockchip/pkyne4g2cln27dcdu3jm7bqdqpmd2kwkbguiolmozntjuiajrb@gvq4nupzna4o/
[3] https://lore.kernel.org/linux-rockchip/9ffedc0e2ca7f167d9d795b2a8f43cb9f56a653b.1717923308.git.dsimic@manjaro.org/

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
Changes in v5:
- Rebased against linux-rockchip/for-next with Dragan's .dtsi reshuffling on top
- Added separate OPP values for RK3588j (these also apply to RK3588m)
- Separated GPU OPP values for RK3588j (RK3588m ones differ slightly, not included here)
- Dragan's patch: https://lore.kernel.org/linux-rockchip/9ffedc0e2ca7f167d9d795b2a8f43cb9f56a653b.1717923308.git.dsimic@manjaro.org/
- Link to v4: https://lore.kernel.org/r/20240506-rk-dts-additions-v4-0-271023ddfd40@gmail.com

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
Alexey Charkov (8):
      arm64: dts: rockchip: add thermal zones information on RK3588
      arm64: dts: rockchip: enable thermal management on all RK3588 boards
      arm64: dts: rockchip: add passive GPU cooling on RK3588
      arm64: dts: rockchip: enable automatic fan control on Rock 5B
      arm64: dts: rockchip: Add CPU/memory regulator coupling for RK3588
      arm64: dts: rockchip: Add OPP data for CPU cores on RK3588
      arm64: dts: rockchip: Add OPP data for CPU cores on RK3588j
      arm64: dts: rockchip: Split GPU OPPs of RK3588 and RK3588j

 .../boot/dts/rockchip/rk3588-armsom-sige7.dts      |   4 +
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi      | 197 +++++++++++++++++----
 .../dts/rockchip/rk3588-edgeble-neu6a-common.dtsi  |   4 +
 arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts   |  16 ++
 arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dts   |   4 +
 arch/arm64/boot/dts/rockchip/rk3588-opp.dtsi       | 190 ++++++++++++++++++++
 .../arm64/boot/dts/rockchip/rk3588-quartzpro64.dts |  12 ++
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts    |  34 +++-
 .../arm64/boot/dts/rockchip/rk3588-toybrick-x0.dts |   4 +
 .../arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi |   4 +
 arch/arm64/boot/dts/rockchip/rk3588.dtsi           |   1 +
 arch/arm64/boot/dts/rockchip/rk3588j.dtsi          | 141 +++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts   |   4 +
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi          |   1 +
 14 files changed, 577 insertions(+), 39 deletions(-)
---
base-commit: 5cc74606bf40a2bbaccd3e3bb2781f637baebde5
change-id: 20240124-rk-dts-additions-a6d7b52787b9

Best regards,
-- 
Alexey Charkov <alchark@gmail.com>


