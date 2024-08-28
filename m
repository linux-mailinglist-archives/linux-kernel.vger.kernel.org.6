Return-Path: <linux-kernel+bounces-305248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CC7962BD5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA503B23C1E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9721F1A7063;
	Wed, 28 Aug 2024 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="CBFVj1CE"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4D01A3BAF;
	Wed, 28 Aug 2024 15:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724858062; cv=none; b=nUIfVI2Brc9YYYLQlENjNICPyvn6izVFz1AHVG9TYBfaBxE7I0uOwpUlqR4ga8fQE41+5bXUXwXbB4/Z6P/0bK2M46NtRnMK/2HrNpH/qiSxFNrQjM3MOMzdFmkHzxx4CpDKbiM3RyczUC4SUldmd30sq98XHb8+k1CAyBAKp8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724858062; c=relaxed/simple;
	bh=GSuLSojALIbQR4KZF6xcyKyxQ0Reo6aOSnplz8L0V7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ly+okHa97HcEnOd5VsGwZiO4Idp4zQuk8rBpqbJfKqiJa4CPn22rNyV/CcNEC1IAEwR/+ZMHBaCbLhNTxaDL/DpDAJtMYaltY5CXHvb8RjOL+3+fHVvcJ1sKrGQUwOevvBHlea8iFN9VyyQK+IVVX5G5/05Hj+p4HUr5PvG+3kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=CBFVj1CE; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qO+auz81JILQiPonn+3KFLDW+eIXTBATRojCXRXQL4M=; b=CBFVj1CECsX7O0hGFIEFKwKGMl
	13swb7gcTQLpSA0jxaXO4GPGvCpnHeL3VtNRDq0p+wfEjtMEVzJi4MI+ryJVJGQH8S90UNUdaOQbt
	C/xQVedAtTEhzmb/636lCSP1eMATtQMGtA/O0H9lEeKbD0LI26w8y2k1z9fw0LIEKTz5yE+w+kqg1
	yPwp55ldNbdi2gwmsJLvwt0G9Z79fVFaVUtlgoxWZfvvX2XVuzQqyr4rweOT+atfY220vDVjPb94m
	US8F5jJBuFnm90YfL4RNJuFG5LV/ozFpLoUBudOmSkNUbkizVab/73RE451Onqf5yscqPteYA4mTa
	1QDUq4iw==;
Received: from i5e8616cd.versanet.de ([94.134.22.205] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sjKNF-00065f-8O; Wed, 28 Aug 2024 17:14:17 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/1] arm64: dts: rockchip: disable display subsystem only for Radxa E25
Date: Wed, 28 Aug 2024 17:14:09 +0200
Message-ID: <172485421377.1511809.12375078793933979207.b4-ty@sntech.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820120020.469375-1-amadeus@jmu.edu.cn>
References: <20240820120020.469375-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 20 Aug 2024 20:00:20 +0800, Chukun Pan wrote:
> The SoM board has reserved HDMI output, while the Radxa E25
> is not connected. So disable the display subsystem only for
> Radxa E25.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: disable display subsystem only for Radxa E25
      commit: 5d4b29c2bf1b2b08522c48f211311404b8075bd1

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

