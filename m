Return-Path: <linux-kernel+bounces-225373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7A8912FCB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 23:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87AF4288912
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 21:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B5617C235;
	Fri, 21 Jun 2024 21:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ua8QcNxN"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5215664;
	Fri, 21 Jun 2024 21:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719007103; cv=none; b=jAny8xWwER4WxYfs1PZPY9mFUWpW7hlbB9cTXKz0v47PKen7FTSOwGD0DUOWhdu4cFR+iRE7PD9ARHMiumz5cMC4AlcoxSevy/+k4B9Dxnd3W7LgWRVIjMGitB3opnV4xFaobZufZvkIyadAzNKpyqwh6Pe8fNjSzJvmApesjuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719007103; c=relaxed/simple;
	bh=kCAaRkkx578LV7p5P9HDmqRI3/vziZIbGkP10bXoAzk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LUJi8OPMbtWl3ePmWcpCybMt8eMn3YEaFzi+lt2UgLyyxBA7t+fzfyd0ECzn8pf6eiVBpq5Uq3ZbFVpGQEg5ELBKfE9lW7gvVxvkCMqJkBft8dsq26qfOkr63UgLugNdSrLK8x74991tiTzKbqCgGQCjjh5indAssQapSyRBcVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ua8QcNxN; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719007093;
	bh=kCAaRkkx578LV7p5P9HDmqRI3/vziZIbGkP10bXoAzk=;
	h=From:Subject:Date:To:Cc:From;
	b=Ua8QcNxN4HezrYGzX/x+W0e2MNicHmD0z8G1Io4vQrlApuEzTqDN5qzrrURYSo8mt
	 ZHToDUiH5QBW+HL+KtKTnPCPsJJPjRVPwqc9PjsA9JU7hEUxugYsIDsgnzCsDXxP5M
	 PRsV+tiMuzgWNtDDOAfgvR+MsUmbDXU8ItCnXkUQtfOss6RIzXKwqck3WPgQQg0iCz
	 bqeOakkTJzDPgGYuf2SWia+CCAoqJcpRCZYmgEwL9h5AS7KVk2UqPTJOG//WBKc4/7
	 So41rMONgG+islIIfQZJvy4JM0P5jKR/PblI0bA60nmHGNh7fSnQUFP+La2fzPCCH8
	 WGWFK+VJl0IwQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 582B3378203F;
	Fri, 21 Jun 2024 21:58:13 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v2 0/5] DT fixes for Rockchip RK809 audio codec support
Date: Sat, 22 Jun 2024 00:57:17 +0300
Message-Id: <20240622-rk809-fixes-v2-0-c0db420d3639@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD33dWYC/22MQQ7CIBBFr9LM2jEMtFpceQ/TBcXBEmsxYIim4
 e5i1y7f/3lvhcTRc4JTs0Lk7JMPSwW5a8BOZrkx+mtlkEK24kAa470XGp1/c0JipcSx65mcg2o
 8I29HFS5D5cmnV4ifLZ7pt/7vZEKBzmg12k6Rcu3Zhnk2Y4hmb8MDhlLKF577Q8WqAAAA
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Chris Zhong <zyw@rock-chips.com>, Zhang Qing <zhangqing@rock-chips.com>, 
 Chris Morgan <macromorgan@hotmail.com>, 
 Furkan Kardame <f.kardame@manjaro.org>, 
 Michael Riesch <michael.riesch@wolfvision.net>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>
X-Mailer: b4 0.14.0

Rockchip RK809 MFD provides a RK817 compatible audio codec, supported by
the rk817_codec driver.

This patch series fixes a few issues identified by dtbs_check for the
boards making use of the codec: rk3566-quartz64-b, k3566-roc-pc,
rk3568-evb1-v10, rk3568-lubancat-2, rk3568-odroid-m1, rk3568-rock-3a.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Changes in v2:
- Rewrote PATCH 1 & 2 to move RK809 support into RK817 schema
- Rewrote PATCH 3 to drop unsupported mic-in-differential, as reported
  by Jonas
- Link to v1:
  https://lore.kernel.org/r/20240619-rk809-fixes-v1-0-fa93bc5313f4@collabora.com

---
Cristian Ciocaltea (5):
      dt-bindings: mfd: rk817: Fixup clocks and reference dai-common
      dt-bindings: mfd: rk817: Merge support for RK809
      arm64: dts: rockchip: Drop invalid mic-in-differential on rk3568-rock-3a
      arm64: dts: rockchip: Fix mic-in-differential usage on rk3566-roc-pc
      arm64: dts: rockchip: Fix mic-in-differential usage on rk3568-evb1-v10

 .../devicetree/bindings/mfd/rockchip,rk809.yaml    | 288 ---------------------
 .../devicetree/bindings/mfd/rockchip,rk817.yaml    |  70 ++---
 arch/arm64/boot/dts/rockchip/rk3566-roc-pc.dts     |   2 +-
 arch/arm64/boot/dts/rockchip/rk3568-evb1-v10.dts   |   2 +-
 arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts    |   4 -
 5 files changed, 40 insertions(+), 326 deletions(-)
---
base-commit: 6906a84c482f098d31486df8dc98cead21cce2d0
change-id: 20240619-rk809-fixes-1e330758e1ff


