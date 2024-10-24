Return-Path: <linux-kernel+bounces-380197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC3C9AEA13
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 233C61F2339C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E141EBFF0;
	Thu, 24 Oct 2024 15:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="M6OPtpzQ"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626821E766C;
	Thu, 24 Oct 2024 15:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782851; cv=none; b=F9Guzo+0AvTkrt5vipQeORGBw0rrq5D7/dWCZ0tQl5yz/zJ1m5/01wgKQPbAhfcexaGCa1aFuib6HJ4v+x8Gu9Jh5vl+HatCE9vFv2Jl3LIfwWH9jKCAkban8EaBZceRUAne5TbbmPz7lTj03Oh/JD6kVq/qmSzRraBZ9MBNumY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782851; c=relaxed/simple;
	bh=7QqExkXjwQmnGrrESPwZ1A1yLN9eMUq5lrMabxvlh74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CsTzSXPVtsdsg+ZMMUCguNxTiBIvjxH3CcWtHz8V3OVDzh5NBwlCub3HMjkPCEee7lA08CiXwaY6tUVzX+1GaZ8GoI1RQ5F4doEWjZMftMNNnDZlR2ZmGwSP7kASBBFqGnpJ6s0YhW41Udb+xjpLyb4V4VYqyKp5VB7EAeJHd5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=M6OPtpzQ; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=CBiG9tFbLqIx7KKBRCWnQHbT9NWhqeOvBRJqbKiGd9Q=; b=M6OPtpzQvZbVZiuWkrc3p230yO
	HPi4NVdrU8/xETZanFmH1TXojf2TVftlbJ0yeckBFO2H5M9ewFODfiIlLKKUQ2TZ4B+VaLOJlYo3V
	gMlBfqXNvnAUIqP4eSMh1ozb4FuGzAwLmSbRRIFS7Z0SEZVtX0zL2n6RD88nuX1zfwTxz5cH/LCpr
	lxKZncYmIzYeesPhCulT5IsBXKxeOb/iKZAGbcntkmVL6ZSwCIjRMmQXfwFIqAMaPOz0rPnD5aALX
	FmIBOq5kt+8/ABsCJ07pe97Qd1SsUFUXSnRweIccoyDDTjjvSyl6GcezzRsZVOhbP7tPnBPJtNxAC
	igChQNHQ==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t3zXK-0004at-Cr; Thu, 24 Oct 2024 17:14:06 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@cherry.de,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] HDMI Support for Theobroma/Cherry rk3588 boards
Date: Thu, 24 Oct 2024 17:14:00 +0200
Message-ID: <20241024151403.1748554-1-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds HDMI support for the Tiger and Jaguar boards.

Heiko Stuebner (3):
  arm64: dts: rockchip: add HDMI pinctrl to rk3588-tiger SoM
  arm64: dts: rockchip: add HDMI support to rk3588-tiger-haikou
  arm64: dts: rockchip: add HDMI support to rk3588-jaguar

 .../arm64/boot/dts/rockchip/rk3588-jaguar.dts | 50 +++++++++++++++++
 .../boot/dts/rockchip/rk3588-tiger-haikou.dts | 53 +++++++++++++++++++
 .../arm64/boot/dts/rockchip/rk3588-tiger.dtsi |  6 +++
 3 files changed, 109 insertions(+)

-- 
2.45.2


