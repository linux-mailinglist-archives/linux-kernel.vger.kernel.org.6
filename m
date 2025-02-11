Return-Path: <linux-kernel+bounces-509977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6971A316C9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 21:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C73C167703
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 20:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42BE264FA5;
	Tue, 11 Feb 2025 20:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="NsYHkrYT"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A4F264623;
	Tue, 11 Feb 2025 20:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739306156; cv=none; b=rpXp5o1maVa4ymMlE1quchidpwzr7bMk+Jk3ALoeJhNg3d3NCRrCa2JHUiItx0we/WxF6Q2ArdnztJIr2MGir+ybEpja/SenixZLvFVIxMs0OiP50lFzKsYL1gIj6WbOYKZqFkxMiD84q0WksIv6Xygc0pkLcYNel7Igy42MZv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739306156; c=relaxed/simple;
	bh=f+qTEFYcWW8cwpuLgQjGWT+veeES6rNjhCJGEP+uXmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AAUigpQecRO4tSdO+0S45jzow6lp4NS/I30HDRlcKt5kbh6NZe802IBO6s2VES0qq8YnP2279FCgClbW6TNx7tTRUUMUeVY+eBqkKVZFqwLQIxNRu6Juu/M66KWRIlGS/oFZpaBo3KJAfxVEvM8IFVWeqMuzT2cPh2rixdcOEMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=NsYHkrYT; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qrR+2zWNpEZwV3iTqp2xAc/x4CQZ8LH6NthsoKKPaFk=; b=NsYHkrYTBZ9GMfCvJ5EELeLw7P
	yeU593GVZSjLLwDBWcV5oih5VCinlpUxDjlJDmaJxoYhv1N4dzUoVdUYII7SQ23SV5Rz5jCBOLFue
	olm2HO4Yy9vaTzPpqR6hVHFavbettwuiWa6WGE8Tm2Dm+JTUeeOQ8cQiThQNCnACXIHCS+A3fHDh/
	nZCRrL8JoTaWu7ZucvoOeZwVPFBwko2sf3l9azgxfb2LK1YOnaXb6nS3MsjP5G0O8mo0hnwEXCem5
	A6LAr86MHKDPnvYo/qwvF85sJFMbD/8CgXSozAug1Y88JGkK7eK4mUr60lTSdHn4kpWoiOVcCnGwT
	3/WH0NBQ==;
Received: from i53875bc0.versanet.de ([83.135.91.192] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1thwz0-0003OL-PH; Tue, 11 Feb 2025 21:35:50 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org,
	Dragan Simic <dsimic@manjaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Reflow Quartz64 Model A/B board dts files a bit
Date: Tue, 11 Feb 2025 21:35:37 +0100
Message-ID: <173930613282.1358259.15016931391448973048.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <7eea4ebdb19d5f43d24074a166e6c46bb5424d46.1739218324.git.dsimic@manjaro.org>
References: <7eea4ebdb19d5f43d24074a166e6c46bb5424d46.1739218324.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 10 Feb 2025 21:17:00 +0100, Dragan Simic wrote:
> Going over the 80-column width limit, and using all 100 columns, is intended
> for improving code readability.  This wasn't the case in a few places in the
> Quartz64 Model A/B board dts files, so let's reflow them a bit, to both obey
> the 80-column limit and make them a bit more readable.
> 
> No intended functional changes are introduced by these changes.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: rockchip: Reflow Quartz64 Model A/B board dts files a bit
      commit: e857cdedbe1f9aedad4e307188c55ccba28a3e76

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

