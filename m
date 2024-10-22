Return-Path: <linux-kernel+bounces-376374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AAB89AB08C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B262B284342
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADAD1A0BFB;
	Tue, 22 Oct 2024 14:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="QnMI8CyD"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE101A0B06;
	Tue, 22 Oct 2024 14:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729606366; cv=none; b=kUvZVRrwSwDgoDijuvXIQ9JjIKf/BXpQ+75EZ52M2eE90l5aVeQ19Fk32K3hzwmcmcsUQT4uoe5SLyaHfgdIPJV9xfiI62ZQis3LGyyuCpsJpMWvzGM561ZcUh1HZIWgDSf4JhVCMVGIDzYXe/+4UsC1poYIDQDEP8LL/f7nUQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729606366; c=relaxed/simple;
	bh=MhVfohK+sGK1VAxtbAbwzlF9KjahQK5RH0ylIW5VdG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V9/T3mIXjEiF0Wu2Kc23y1R0x4MOSdEh2AcLk6BiuG3UqsCcgvfVJA/b2OVguf1jt+rknVeGi3CLApkBvCzkzNJq5qQPWAQlJ9nYg+xFm3TxgCg5rC8ytaM7K7hGBILa/cPHFME3mZKrYQyP8jBitaYyyEm6MyQXUDt7kykOG6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=QnMI8CyD; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UxZ/LQTB5w+igQ3WZWFh8HXKq8DmKFsglx6Gq5shKmc=; b=QnMI8CyDwu219x6xL4nByl2Ch1
	WilKJ7www6+MbzER6ZkGZrPv3n9VWxLsZ6PPojNF0Di5rD9B+mxRfZHAksHM3x+mtXPdT2Gedl9bn
	Hs+6CXU9vJGQRFt4GxIDISIYNrg4V/HBg0+HA1kY49iZFzfNp40I1GJmEZ5dw6UfYTBRvyKgfcafs
	czN+DI1zPWH1vJWt0rVkw1s4Apl+hYUXM71oPtNIb2fn03eVPXI6aIw3d6bJfz4E7PSDQy355yN7A
	+pSxngw0+7Jwkc7JNGi0hn6s6SsmM6CEl6jN4nTaz3IE+GuCmU/q2r2jCf5MIZTNKw+V22iA+Ffz/
	Fks5qoyA==;
Received: from [213.70.40.217] (helo=phil.sntech)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t3Fcl-0005eb-RR; Tue, 22 Oct 2024 16:12:39 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Heiko Stuebner <heiko@sntech.de>,
	mturquette@baylibre.com,
	sboyd@kernel.org
Cc: devicetree@vger.kernel.org,
	conor+dt@kernel.org,
	robh@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: (subset) [PATCH v4 0/5] Binding and driver for gated-fixed-clocks
Date: Tue, 22 Oct 2024 16:12:28 +0200
Message-ID: <172960632904.1476617.15904648018389149552.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906082511.2963890-1-heiko@sntech.de>
References: <20240906082511.2963890-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 6 Sep 2024 10:25:06 +0200, Heiko Stuebner wrote:
> Rockchip boards with PCIe3 controllers inside the soc (rk3568, rk3588) have
> external oscillators on the board to generate the needed 100MHz reference
> clock the PCIe3 controller needs.
> 
> Often these clock generators need supplies to be enabled to run.
> 
> Modelling this clock has taken a number of shapes:
> - The rk3568 Rock-3a modelled the generator-regulator as "phy-supply" [0]
>   &pcie30phy {
>   	phy-supply = <&vcc3v3_pi6c_03>;
>   	status = "okay";
>   };
>   which is of course not part of the binding
> 
> [...]

Applied, thanks!

[5/5] arm64: dts: rockchip: fix the pcie refclock oscillator on Rock 5 ITX
      commit: e684f02492f99d6f6f037a35a613607339cf8e8f

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

