Return-Path: <linux-kernel+bounces-566060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEABA672A6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D578420471
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 11:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B244D20ADEE;
	Tue, 18 Mar 2025 11:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="MahbrOJS"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1B97E1;
	Tue, 18 Mar 2025 11:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742297127; cv=none; b=FTfu0SlNO01YR7rxQJGNnKq0D3LhBixXt7LnSNUL23rG/4TPbbq+9rIGRElg274RO0TMRsq8olb7t6/6+3JzrBS+eXrWjW0lTWBNtU8U6ZfsVkt63WrY1xqoBMHEvJKhG5tFVRibUO6f0TsbtR5td/+nZcgg+eFY6DqF18D/Z90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742297127; c=relaxed/simple;
	bh=1hko+ppXt0dRMWhQzOOAmDEchVvdK62uXhM3cIvTaGo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hB15xra1QPNXlroWklwbf81ZrCTVIWXkgLZlXZCZ5UrOuscO/LYUahVAa7QcpC5dVc+C6xC3dceP7ClUpyhniAIhr+SKQkX+fzwS1KfcPGXS5GYXBlXQc9wepN0mHg6VHkXkYvarwGgtOogr8CmMTvk8RmWbFYYKJHuhaRRZCzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=MahbrOJS; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1742297113;
	bh=AXWKcikh7y0dX2+PuBRgIKM1or7UWpe1fD4PbsIUNRU=; l=1405;
	h=Date:From:To:Subject:Message-ID:MIME-Version;
	b=MahbrOJStl7BpOg9Dkc6U9LXcy/8LYGgK4j56hzo400w7J/lC6M8Wj7eeGlhU/d5H
	 TN00um3UPJoVAdwz9uyHIMY/78Vyymb8r5YY7K2YRePxL9huXBl1HRIsFCzyqdgVdZ
	 MaAz+bi9Q3kKAyFdnIJ1VwbFesApD9tCJu3tcTV5yaHndHZT5Mva0NoXqC3+IWJLYT
	 GUxgjNEYMCujpIRnCMonsqWehGOz17mtlPrv4YiYz2pC+ReMXz8aGK7uf30EhDCvwu
	 ui+8wuZp4YFzLmShrI5sAKyx/fxvyI21Li1TX6ZvG+kLvjQKjB2UiElHid3vCH4KfL
	 3/bhXN7v7hpKA==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(3810276:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Tue, 18 Mar 2025 19:25:04 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 18 Mar
 2025 19:25:04 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Tue, 18 Mar 2025 19:25:04 +0800
Date: Tue, 18 Mar 2025 19:26:14 +0800
From: ChiYuan Huang <cy_huang@richtek.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Tzung-Bi Shih <tzungbi@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Otto Lin <otto_lin@richtek.com>, Allen Lin
	<allen_lin@richtek.com>, <linux-sound@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: maxim,max98357a: Add compatible with
 richtek,rt9123
Message-ID: <Z9lYVram80dbWWl0@git-send.richtek.com>
References: <1884c3ce2d901ead5d742958889f5a742e168376.1742259040.git.cy_huang@richtek.com>
 <20250318-mature-dogfish-of-ecstasy-3dcea5@krzk-bin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250318-mature-dogfish-of-ecstasy-3dcea5@krzk-bin>

On Tue, Mar 18, 2025 at 09:55:48AM +0100, Krzysztof Kozlowski wrote:
> On Tue, Mar 18, 2025 at 08:57:51AM +0800, cy_huang@richtek.com wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> > 
> > The hardware control and specification of 'richtek,rt9123' are similar
> > with max98357 or max98360. It's no need to add the new source code. So
> 
> Are you sure? I looked at datasheet and do not see anything about
> SD_MODE in RT9123. Also you have two supplies, while max98360a has only
> one. You have I2C but max98360a has no.
> 
Sure, consider the I2C mode. Then it seems different. For the power
supply, yes, we have one more supply and it's used for digital input
output reference. It will always tiled to SoC digital power domain.
It's no need to control, so I think DVDD can be ignored.

If not considering the I2C, and the DVDD power supply, for HW control
mode, then it looks the same including sample rate. One pin to turn on
the amplifier.

This IC is designed for 'easy to use'. For the normal condition, HW mode
will always be suggested to the customer.

May I have your suggestion? If it can not be compatible, should I write
two drivers, one platform driver for HW control mode, and another I2C driver
for I2C SW control mode?

Hope to get your feedback.

Sincerely,
ChiYuan Huang.

> These devices do not look compatible.
> 
> Best regards,
> Krzysztof
> 

