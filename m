Return-Path: <linux-kernel+bounces-402967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 430DB9C2F16
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 19:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0078F28209F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 18:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F21E1A0B00;
	Sat,  9 Nov 2024 18:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="agD5J8ox"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7871819DF5B;
	Sat,  9 Nov 2024 18:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731176857; cv=none; b=O3WzlTzBCxFiJ2tCUTZ5DuEOcs3SvkXx7giyGJ7rU+ujGqREmk+t/Q4F+L1c6k4iSiAiRMPHqTkX15lfAY7sj4odwQKJDXjE/GCYDkkuaaVeeKtZR4i31cPtjNbjCqwbWSWMZXkhNzjMzxIUoKsTtGi0Y5jCREG3FP4Zz2RQxwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731176857; c=relaxed/simple;
	bh=9asIXFzlRsDg+fLdDGS+Cba0MyQCkHSC76BCJq/MJoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rzdjGUhP8aSYOVN0yqMS1GgoMxPH5TgkNStLc+3K7j3XTmKacne/JTbKmjHAauB5l/2g15SP7HgkzgB4xkiSsfkPVN61k85V/o6s4TpQp/Q8mST9gE1NzhrzRXDB4znSGZbg4qT8BM9DvHhWlYK/SD/PLDROLx9wpXTkOdvBIXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=agD5J8ox; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+Wdep8RPIJhzasUweFFiPencut32kq2qM4uF0qs/pOY=; b=agD5J8oxNzc4+u7EbHFk64lJ63
	oZEyLwJ/uYmZx77KJBxcyxE2TBAa3/4UEUPRRv1DSIwxamF5blvvUAkQWLspmH6qg6p0BvlSE8qLr
	AUKOhDD++hKdTgz73S7vNGy34dbRE0CmeDVRxtRhegNFXPWuhFHY3lfrWDWYzF9LOKAYebXIybtrd
	UScMtMK0CYFZg81lSaMMnC/jz6mPuYQcU1c5sr6kHlGeFJvKagwOCTQPbMB9MIzD440K7IvT3HMrv
	BBHO6+1PziSJwQQbyh8hLAQLb2mnF+l5pOffu2Zrnt+cjN2oEvp7CXeQOP08K8Iy7H7rz1lfpIGWM
	1YQfOp/w==;
Received: from i53875b28.versanet.de ([83.135.91.40] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t9qBH-0007Km-Kw; Sat, 09 Nov 2024 19:27:31 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
	Dragan Simic <dsimic@manjaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	alchark@gmail.com,
	krzk+dt@kernel.org,
	robh@kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add OPP voltage ranges to RK3399 OP1 SoC dtsi
Date: Sat,  9 Nov 2024 19:27:12 +0100
Message-ID: <173117675956.1131306.6493161181935634177.b4-ty@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <dbee35c002bda99e44f8533623d94f202a60da95.1730881777.git.dsimic@manjaro.org>
References: <dbee35c002bda99e44f8533623d94f202a60da95.1730881777.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 6 Nov 2024 09:33:08 +0100, Dragan Simic wrote:
> Add support for voltage ranges to the CPU, GPU and DMC OPPs defined in the
> SoC dtsi for Rockchip OP1, as a variant of the Rockchip RK3399.  This may be
> useful if there are any OP1-based boards whose associated voltage regulators
> are unable to deliver the exact voltages; otherwise, it causes no functional
> changes to the resulting OPP voltages at runtime.
> 
> These changes cannot cause stability issues or any kind of damage, because
> it's perfectly safe to use the highest voltage from an OPP group for each OPP
> in the same group.  The only possible negative effect of using higher voltages
> is wasted energy in form of some additionally generated heat.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Add OPP voltage ranges to RK3399 OP1 SoC dtsi
      commit: 37e4ad9c795a725e7308089e9d59d094115138dc

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

