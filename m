Return-Path: <linux-kernel+bounces-353165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5460F992992
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 12:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1DB21F22718
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463121D14F8;
	Mon,  7 Oct 2024 10:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="TJgg7xD7"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B021CC8AB
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 10:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298675; cv=none; b=HvXYZE7j9gjdNhL/ZzRN5bMX+yv6BEUo8jg8TY5cKSqQUMsFFdP0pMquTdsXxwDXl2l/izEgoPMqJGlx5bBi5rZrYFI2pOuoYvd5kPX+2Y68abBDpBfSk+hUCeweOLiufLE3q5Y3VdgewZ5H3RGUmpiXpbYk4OTGgcHFj2kdr7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298675; c=relaxed/simple;
	bh=C6rSHyZj+HiWtECQxIMp+kIhHtaybbcxr/2p7AegOwA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dFmLownxn7okbgFwPMfkjKd1IVLSFM+Pu6cMP+bSPIj8bbY0O4uBQC4YnNDBxD9rLjMwGLmV6sQ2keL2sfNicaTwugxVWM7bxIT/uIjT3xbFVLQp7uu46T/wwiNoC1+LncNKzn6I/eipiRkACqu3c4/faESHvjYji53AaHuLBSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=TJgg7xD7; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1728298670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CkGa68OhlcHrCUmYTHDXO5x5tcltH/saI7jrYbKriso=;
	b=TJgg7xD7XzDaP/Z24GttARxNUJe6++DhnQec3JTX/ypYaZC1uYFXCM0twMZHgvr73ECKDt
	8qYteGrGSAQmzvLUt3UWZOrXjkNZZ/U5SeX7aOeI9wx2SrZpVwpZ0kaentKwUSuPe8llb5
	0aWDqu3RTaGv32M0X7jn9Dfko4yjmGJDZ1Dh+hRUe8TJ9xZFiMUOh0gfVw3uE94ccKPL+I
	Z6Yb0RdBbKprZtvQgA1ImT5HpQRxDfUk9XfbEcG2owYu5qPhhgC+5VbE5GIDr57mpUUAqs
	JLr47clAOz02IfXxRcaGx/I+DZMOWpCGbG0pYkxTLzao+b3MveskJXJDkh3yXQ==
From: Diederik de Haas <didi.debian@cknow.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Diederik de Haas <didi.debian@cknow.org>,
	Dragan Simic <dsimic@manjaro.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: rockchip: Fix several DT validation errors
Date: Mon,  7 Oct 2024 12:28:15 +0200
Message-ID: <20241007105657.6203-2-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This is a set of 4 small device-tree validation fixes.

Patch 1 adds the power-domains property to the csi dphy node on rk356x.
Patch 2 removes the 2nd interrupt from the hdmi node on rk3328.
Patch 3 replaces 'wake' with 'wakeup' on brcm BT nodes.
Patch 4 replaces 'reset-gpios' with 'shutdown-gpios' on brcm BT nodes.

 arch/arm64/boot/dts/rockchip/rk3328.dtsi           | 3 +--
 arch/arm64/boot/dts/rockchip/rk3566-box-demo.dts   | 4 ++--
 arch/arm64/boot/dts/rockchip/rk3566-pinenote.dtsi  | 6 +++---
 arch/arm64/boot/dts/rockchip/rk3566-radxa-cm3.dtsi | 2 +-
 arch/arm64/boot/dts/rockchip/rk356x.dtsi           | 1 +
 5 files changed, 8 insertions(+), 8 deletions(-)

