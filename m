Return-Path: <linux-kernel+bounces-425074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E729DBD2F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 22:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA154B219E7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 21:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409931C3030;
	Thu, 28 Nov 2024 21:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="ZICoxLpN"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B7C537F8
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 21:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732828256; cv=none; b=QhhyTixVWU4J/wGu0xIdv1JMEkAaIVBcU70yKWwtwudtKDSZY9KsabNr1tmV93H0HBEKTuCuMmExD1hAGHKfTc1Rx9CuhmOQuNq9dLisIR0Q8BoRIy4p7SOmlH7suESsQTSW2V6eWtvVWFiPGI1gltDf1VrK8a5m2sUlS7bU0ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732828256; c=relaxed/simple;
	bh=O6nVlZciNoA9krjB/LfsUPAebaD5uqiqRBH8NZdZwi8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bW/mcEvHu23h+QLvYvndygDH8HyUdy6MVJOOp4f8Y4uioguLBcTQ/clOSxxOsAErM6X527aiCbWWWNYBJFpNU5krb6AGSQihwhIP8bigJJoiSmdjBrGHByCqcAa+pP2VGZZ/TZTTuP1jQ8s0pZ5to3iNgcjnzipGgHV6GHlqTws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=ZICoxLpN; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dRGDSLsH1Ba5TlpGi2/Qppd+TqYA+uIyrCSKV8c+2WA=; b=ZICoxLpNRbdIDou0AmGn11jvlc
	k03QIEqjQElwbzcq4BLd4vJIAj0vxYBM49xS66tC/8H0HkgCthYtDSsnTQA+p9oNSM5ND77P7Gstm
	PLHz3JTUgHezjhaLnl1LgIgqJs41QR5KT94GVpPKokNyyLGy/UYbJmbLg0LeyArhA2Q0Q2Rgoz5YS
	gVzkXjmrcRllJu45vXd0Q9c+TF8j/1deQYNLQIZHcCHyo1tKBys+jGiDrHmKvnv1LP57MZb1bqaf4
	IcTqWIkje74vkMCvBCNcevb04kafzs5W3X8JAK3FaLWtlc0ckgYdh7MPjtOnqD0oAMYivtAMObQFd
	hRUwMh/g==;
Received: from i5e86190f.versanet.de ([94.134.25.15] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tGlmY-0007ud-1h; Thu, 28 Nov 2024 22:10:38 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Heiko Stuebner <heiko@sntech.de>
Cc: quentin.schulz@theobroma-systems.com,
	hjc@rock-chips.com,
	andy.yan@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	sebastian.reichel@collabora.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Andy Yan <andyshrk@163.com>
Subject: Re: [PATCH v2] drm/rockchip: vop2: fix rk3588 dp+dsi maxclk verification
Date: Thu, 28 Nov 2024 22:10:28 +0100
Message-ID: <173282819998.1000394.12551012503214788208.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241115151131.416830-1-heiko@sntech.de>
References: <20241115151131.416830-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 15 Nov 2024 16:11:31 +0100, Heiko Stuebner wrote:
> The clock is in Hz while the value checked against is in kHz, so
> actual frequencies will never be able to be below to max value.
> Fix this by specifying the max-value in Hz too.
> 
> 

Applied, thanks!

[1/1] drm/rockchip: vop2: fix rk3588 dp+dsi maxclk verification
      commit: 5807f4ee6d32a4cce9a4df36f0d455c64c861947

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

