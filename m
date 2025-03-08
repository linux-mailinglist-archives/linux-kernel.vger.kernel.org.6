Return-Path: <linux-kernel+bounces-552659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2FEA57C66
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 18:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B83E16738A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 17:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D4C2036E4;
	Sat,  8 Mar 2025 17:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="XCzQerHE"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B591DE2AA;
	Sat,  8 Mar 2025 17:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741455144; cv=none; b=IB4+BU/YnZomIHbM29dveHPp6gDjTJFt4KqQ5PUhAlpPwtb9e6P1ypWAiMH4pRLPF8MohgYjy2Oz1Px8BzBQqOPCWyfhFu42ULbfSGXarIWJYPh8nY4ntZWBaEmyIXExSzsmXT1I+4X2u9rQvnLl3dkMWZ0akQM11cI5oZ6bIP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741455144; c=relaxed/simple;
	bh=NSj1EXW9H9X2RX2EV73l6q1ga3OiLqMJevnTvUQPh7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cu3AFquTYddQdf7Zgq17Zm4cfVZrrE82rlgWq3zFUxRcbmanDJDHahLns6odhn5EjnJNO6s8yc37NULKgnyIz8qXlCk5p+pva/FULq+ZxXcDP6Tl3N5mtBqiSyuDmPm7tpLgHeYYrbbaC2RmuYzfA1HHHv/TYQK5XWVlC2BOZZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=XCzQerHE; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Mlmp/JejejU48CyLjywWdPMnJaDEMrjKUd4moOR86Fw=; b=XCzQerHE6bawYn8QgC7/JaKHJN
	AHtJnVYHI97Vc/WcgJyglq3M944TP+KLqNdyNAWDfaLvuo5WiFbBL68z4MZex2Zv0TOjnlrWbRruK
	n1tCDzUPMYlHhxQZroZprJvbF/L82LzHa2nkQb+wkM51HI2kq+8pUVKyBisk2VsZmiykn0E5BG94d
	AnBAzJAW10aB+yLO+UIi9f/iKD6XQ4yg4WI+oKpBDjgS9Tk2hCRwzok0WUo/S+LxqhdqzDBCbgoZM
	17rlB6oQsdo0bKVxyrJrCtapS7sJy1P4TJ0Wned2eKtrFABcG7cY6ZSRjoWmpJH5YPLX0oBJzJKZP
	Fb9hgLKA==;
Received: from [194.95.143.137] (helo=phil.dip.tu-dresden.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tqy1z-0004Tx-Fc; Sat, 08 Mar 2025 18:32:11 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: linux-kernel@vger.kernel.org,
	Detlev Casanova <detlev.casanova@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alexey Charkov <alchark@gmail.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Stephen Chen <stephen@radxa.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add HDMI support for rock-4d
Date: Sat,  8 Mar 2025 18:32:03 +0100
Message-ID: <174145503575.101861.8670068937049575401.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250306180737.127726-1-detlev.casanova@collabora.com>
References: <20250306180737.127726-1-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 06 Mar 2025 13:06:31 -0500, Detlev Casanova wrote:
> Enable HDMI and VOP nodes for the rock-4d board.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: Add HDMI support for rock-4d
      commit: 4e4f54aaec204a27d51386a9dd0d3a805fea57f4

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

