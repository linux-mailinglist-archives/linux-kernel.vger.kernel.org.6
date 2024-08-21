Return-Path: <linux-kernel+bounces-295149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9BE9597B2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FF5B283ED2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 10:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6910D1B5314;
	Wed, 21 Aug 2024 08:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="ynmOhQTs"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039CA1B530C
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 08:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724229658; cv=none; b=BDD3ITSEceBTixeKmfMrCBnB6DuiAAHIzjlM+aoi3kyRkJ2ZCER7XYR6tkBRKzTRqjoQf+p8relm54Ppzak0SbHyRvjUMMBUEX4c/8njILoi+1lLEB98JAmpCcBuZ3TJnUPP3yTUcD4/nPyK5hhXwX+BuWlHSQkIvZTPEmoq7rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724229658; c=relaxed/simple;
	bh=3CBgBIiMh69l3LUJCSC0qPxOAYUxnwz4cowk5DSb+Xc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jIK37KR7EgvTaq7LT15UMg/q7m1pgRayiFpie3wJCJs8AQqHyrXlT/7jZpfXvgk/C7BruWfMxGdTRQ7NCxKA7zwK16w1b8CC5T5J0Jdbghxfr2u9kbr0j3cDjrf7ZcP28ZSzIBt2aU28qz4xe7/wLHOKdUgOR0Pj7Vy/PgMDiQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=ynmOhQTs; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nAzFxZk6Z3MnLZ9qZa4FevLYbStVgrDaS+fUxKzl+Pg=; b=ynmOhQTsWKukMRa+poiaybHxXi
	5nYIhtZsz+Eyf3EK17a7Tte1UnEtvbUqWDZKFoY0cilZwsTWTOKTaEWByFYaTfoiwFdSHx/mL4BGc
	XOLinGm1yeaFngL/F/e1x4RtigAnn/7b2qFax8EFn7SJyiiZCSSLUFsNLjB9bG3jnNVPUALFtd6Nj
	cLlnl73l0+N8Khu+d+HzXsCIph1qG+DKWq012jgv38QzTuccQ4HrBTVDqL5QOygUZHimYz0ijbAR9
	MWE9kfbFFGFo0+8I2A5Wpz7iz70keBViyvog+frawK39pJ80smj0/vnRZ4xm2LHwOnaLZ2U/jjcSA
	woDfYztw==;
Received: from i53875aca.versanet.de ([83.135.90.202] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sggtU-0004y0-6I; Wed, 21 Aug 2024 10:40:40 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
 Dragan Simic <dsimic@manjaro.org>
Cc: vkoul@kernel.org, kishon@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v2 2/3] phy: phy-rockchip-inno-usb2: Handle failed extcon
 allocation better
Date: Wed, 21 Aug 2024 10:41:07 +0200
Message-ID: <39189616.J2Yia2DhmK@diego>
In-Reply-To:
 <96200baf794a0c451f3bbc3f5530b8cf0e359dfc.1724225528.git.dsimic@manjaro.org>
References:
 <cover.1724225528.git.dsimic@manjaro.org>
 <96200baf794a0c451f3bbc3f5530b8cf0e359dfc.1724225528.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Mittwoch, 21. August 2024, 09:37:54 CEST schrieb Dragan Simic:
> Return the actual error code upon failure to allocate extcon device, instead
> of hardcoding -ENOMEM.  Use dev_err_probe() to also log appropriate messages,
> which is fine because the containing function is used in the probe path.
> 
> Helped-by: Heiko Stubner <heiko@sntech.de>

How did I help with this? :-D

Reviewed-by: Heiko Stuebner <heiko@sntech.de>





