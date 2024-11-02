Return-Path: <linux-kernel+bounces-393154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6679B9C7A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 04:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECABF1F231FF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 03:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6838913C914;
	Sat,  2 Nov 2024 03:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="gzNQWntG"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BC52AD00;
	Sat,  2 Nov 2024 03:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730516966; cv=none; b=WCYdDUVgHSMpuhvOVdsJC8l+v7/o+J4lzrUZlNeRg9feah5hxRSde/Zsp54cFwjnvJHkk5dX/UlbY8KbYzuHDdfmWJTqHphyjxqomRV8zt9iIrC7pBfsvphCXPe21X5RIcoB+ZdS+rkvGxeuPg8c7EqP/UUa3D1ck5vXWtXCr3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730516966; c=relaxed/simple;
	bh=m6kuhS/d1UW4myk/mZJ4FBqNBvknHThF4SusqOWR1RM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T9STFAK8Yfde+TjXUR/lQP9K85i727/AmnoImFWVJEB1YlWYikzesIVrKGkItPw4w6C7ZNt3/2a3J+5moEh4Po9OQYa4oVjLy2f0NglTuVy4n8AuvpHeNCGnrkwjWrdFjJlhZT2nDmFm2ttUqmhFmBz0JAxDrWA4GRyUJnyvHfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=gzNQWntG; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1730516957;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IokIVkNSt4ES1wovgJeW/dP40rMHM/y+rSgYmJiJZ6M=;
	b=gzNQWntGZCnSbVnelnFmAvF805b20plMmapOhEpoDjoxcpPEcyMhdwhvA95oHDP1rDH2Ok
	smqsBFfs0okEel18dHG+mOuTfYUmDGrZJK0Bj5CCToG3WiQZ9KTlMlewB1+4Cr2jH/tz5N
	Pcx2aK88jVJ5mYhF2aDJ1q1c3l0xIxGfpwoGdnNYcWZ//HncPqULx2AOl61Zi+7SttR+Tw
	G0fKR7JRxujD2JRe20oe9ITFLv2uo/s8xZUvAuMYG0zskdU6PgTyAxpldsvy7lgreODW2g
	vtmeG3TyWFj80Akd7ah3lhMpc78be+Z3DWBwpJUDyF4GB9ZFx8Ew36RhCBEWQg==
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	didi.debian@cknow.org
Subject: [PATCH v2 0/3] Update, encapsulate and expand the RK356x SoC dtsi files
Date: Sat,  2 Nov 2024 04:08:58 +0100
Message-Id: <cover.1730516702.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

This series tackles the Rockchip RK356x SoC dtsi files in a few different
ways.  First, it updates the lower and upper voltage limits and the exact
voltages for the Rockchip RK356x CPU OPPs, using the most conservative
per-OPP values for different SoC bins.  This is rather similar to the
already performed adjustment of the GPU OPP voltages. [1]

Next, this series prepares the RK356x SoC dtsi files for per-variant OPPs,
with the RK3566T being the first new RK356x SoC variant to be introduced.
This follows the approach used for the RK3588 SoC variants. [2]

Lastly, this series introduces new SoC dtsi for the RK3566T variant, which
is capable of operating at the CPU and GPU OPPs/frequencies lower than the
"full-fat" RK3566 variant's.  The RK3566T is found on some of the already
supported boards and rather importantly, this stops the CPU cores and the
GPU from being overclocked on these boards.

Changes in v2:
  - Improved the wording of the patch 3/3 description, to make it more
    clear which of the mentioned RK3566T-based SBCs are already supported
  - Renumbered the references in patch 3/3, so their numbering follows
    the order in which the references appear in the patch description
  - Adjusted the patch generation options passed to git-format-patch(1),
    to make the patch 2/3 a bit more readable, [3] and added a note about
    the git-log(1) options to the description of patch 2/3
  - No changes to the actual patches are introduced

Link to v1: https://lore.kernel.org/linux-rockchip/cover.1728752527.git.dsimic@manjaro.org/T/#u

[1] https://lore.kernel.org/linux-rockchip/cover.1719763100.git.dsimic@manjaro.org/T/#m786f0e0a45377d29aea826f05c95b5052a8bb3d9
[2] https://lore.kernel.org/all/9ffedc0e2ca7f167d9d795b2a8f43cb9f56a653b.1717923308.git.dsimic@manjaro.org/T/#u
[3] https://lore.kernel.org/linux-rockchip/D4ZZFL98AMFI.1TDPL2DJPSQ3D@cknow.org/

Dragan Simic (3):
  arm64: dts: rockchip: Update CPU OPP voltages in RK356x SoC dtsi
  arm64: dts: rockchip: Prepare RK356x SoC dtsi files for per-variant
    OPPs
  arm64: dts: rockchip: Add new SoC dtsi for the RK3566T variant

 .../{rk3566.dtsi => rk3566-base.dtsi}         |   2 +-
 .../dts/rockchip/rk3566-radxa-zero-3.dtsi     |   2 +-
 .../boot/dts/rockchip/rk3566-rock-3c.dts      |   2 +-
 arch/arm64/boot/dts/rockchip/rk3566.dtsi      | 142 +++++++++++++-----
 arch/arm64/boot/dts/rockchip/rk3566t.dtsi     |  90 +++++++++++
 arch/arm64/boot/dts/rockchip/rk3568.dtsi      | 113 +++++++++++++-
 .../{rk356x.dtsi => rk356x-base.dtsi}         |  81 ----------
 7 files changed, 307 insertions(+), 125 deletions(-)
 copy arch/arm64/boot/dts/rockchip/{rk3566.dtsi => rk3566-base.dtsi} (95%)
 rewrite arch/arm64/boot/dts/rockchip/rk3566.dtsi (87%)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566t.dtsi
 rename arch/arm64/boot/dts/rockchip/{rk356x.dtsi => rk356x-base.dtsi} (96%)


