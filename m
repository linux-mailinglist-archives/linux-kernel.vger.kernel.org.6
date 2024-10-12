Return-Path: <linux-kernel+bounces-362543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E7299B622
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 19:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3DA1F21B67
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Oct 2024 17:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4C07604F;
	Sat, 12 Oct 2024 17:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="cylJN7TP"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6444175BF;
	Sat, 12 Oct 2024 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728752693; cv=none; b=EnsA/nsZ8e2eci6ng2dq657vt9SGmm4sw62OYv3aYT6jE5rf5/VzNctgKFr6OCIKUBvMMJIiEfFGErq6/hCDIEBEE9lAbxECrU9vF2ubSXopQBcD7ZN8HnyXbut3v8Hj8u8O9AHGn0IEnoTACuQTO1ip19aCb/yN716sHvQJd7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728752693; c=relaxed/simple;
	bh=cehPu9F8GEfyS6AFYDXu9M4zY0McfXYpr7xbHOPtizc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kMSam7X8rik/d/07vQQEpr4naTAQFT8UpevvBHloBx382zo3mLiIKLAFFW6c3Ru9z5E/Rfb3vv1NP42ghbzJYGfrTwmLSEm3/3dXgLDrHL2pyUNPkzEUW3Bt7x6kSPuUbkEZ6iC8vUsGqT8lkZUm9yE6M73oHYuV2wgYKdwodWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=cylJN7TP; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1728752680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iM3UE8DQe02WAdlGsdyyi6qgsRCUdBbEF5+N10Dhsd0=;
	b=cylJN7TPl6anhfCNNFwta7cxiuu7tDHpjk5QkhyU+VPsd3/GOGi7uAf2Uc6XnXXSg0fL5F
	lKEK1SY1ZhmYrQweEsPCcSnhNOPESvRo4QHaq1E7c8xg2uQqTPoplE+S6GLzOBGPJA3C8T
	O7DwbIyi4+zOsyKlom+pcz3TIhxWWQTdn93CPaN7xQnqoeA0lBgcXoPQjDpZEQmf/Pj+Vf
	DnFzc9bCrA8Fbd3U4dON0evcTf6Xrw7cr6vX/73M3JyKYIOfv1vZOeEM8qrN13zge6C8DE
	U04nbhNP3o0ETT7utXNl9Hm0GENZoaNJwr4duP09Q9kabQBNkrws98ffMa027g==
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: [PATCH 0/3] Update, encapsulate and expand the RK356x SoC dtsi files
Date: Sat, 12 Oct 2024 19:04:33 +0200
Message-Id: <cover.1728752527.git.dsimic@manjaro.org>
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

[1] https://lore.kernel.org/linux-rockchip/cover.1719763100.git.dsimic@manjaro.org/T/#m786f0e0a45377d29aea826f05c95b5052a8bb3d9
[2] https://lore.kernel.org/all/9ffedc0e2ca7f167d9d795b2a8f43cb9f56a653b.1717923308.git.dsimic@manjaro.org/T/#u

Dragan Simic (3):
  arm64: dts: rockchip: Update CPU OPP voltages in RK356x SoC dtsi
  arm64: dts: rockchip: Prepare RK356x SoC dtsi files for per-variant
    OPPs
  arm64: dts: rockchip: Add new SoC dtsi for the RK3566T variant

 .../{rk3566.dtsi => rk3566-base.dtsi}         |   2 +-
 .../dts/rockchip/rk3566-radxa-zero-3.dtsi     |   2 +-
 .../boot/dts/rockchip/rk3566-rock-3c.dts      |   2 +-
 arch/arm64/boot/dts/rockchip/rk3566.dtsi      | 116 ++++++++++++++----
 arch/arm64/boot/dts/rockchip/rk3566t.dtsi     |  90 ++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3568.dtsi      | 113 ++++++++++++++++-
 .../{rk356x.dtsi => rk356x-base.dtsi}         |  81 ------------
 7 files changed, 294 insertions(+), 112 deletions(-)
 copy arch/arm64/boot/dts/rockchip/{rk3566.dtsi => rk3566-base.dtsi} (95%)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566t.dtsi
 rename arch/arm64/boot/dts/rockchip/{rk356x.dtsi => rk356x-base.dtsi} (96%)


