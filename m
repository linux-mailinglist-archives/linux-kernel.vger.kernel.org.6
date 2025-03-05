Return-Path: <linux-kernel+bounces-546962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83198A5013D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 15:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ED54189243F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A63820A5F0;
	Wed,  5 Mar 2025 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="Q5wNHCqC"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8905D13959D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 14:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741183293; cv=none; b=cVN+09OGq+rdwh89iek8iJpWfCPFACvK7fIgIMoD3H1Fl+QOE4H3Xl/1jCgwB6l8VxzYSntpuQC0i8VpgDorLQn06yFEQixALPa4H//ufq1Ljam2dpaEdmNt/Dw9u8JGHSypMSb14XaWoSHCx34D9MKt0IErLFmEdJC5nJNQZI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741183293; c=relaxed/simple;
	bh=+16XLBLXQOQTl4r4xUi5JkqUsmF86tVo/VWtoHczKcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmYCFuTW4fs2d589YTXKhRqrzZJ8J6iegxMaDOIFSHQg7j/c7ue12z/Vci1+Qv341PRgfbw5UQ3X0YBiDN2zjoWssb/vHhuriXxL3BiRCWP6MwnkX6Tq/1soiFuMrVkCvoURF22GGnrgE5Nl5smD8KP4tuTeclmPO2S3neRcQSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=Q5wNHCqC; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Date: Wed, 5 Mar 2025 09:01:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1741183279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8aO4nUAYYsK7CbYcngMFkNu2vCLer0vDQ0Tj5RInDJY=;
	b=Q5wNHCqCR4Ez8bHn5tp61cOjO45ii7ooQ70GuXfN2lAV0c48bwr1Qsc3x9jEOkiOnChGU0
	amhTJW4fa6MOAjgg5bSWoybFgzRC/ihNpp2y8XcrGvRdNlXUWNTRwX0V7hg6lr2N+TXcq9
	WXVlEHQs6qrYMubYwrelO7ZFwcfuaq/e6mqQQTw73asaOad09YXmOsMimMjvWeft3BmQPo
	ezUG/ZiE34dWpyUU7uep7BaxZAk9yMpjzisK+LbXXunqEPe8vkjP1VPoYsf/6N34qJ27st
	Fpl3VymGb7t8lSsmvOqzOyivlEeF7i2KqxL/waOmVH/l3icaTDy818PmiY6BsQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>, asahi@lists.linux.dev,
	Janne Grunau <j@jannau.net>,
	Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alyssa Ross <hi@alyssa.is>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Neal Gompa <neal@gompa.dev>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Nick Chan <towinchenmi@gmail.com>
Subject: Re: [PATCH v8 0/5] Driver for pre-DCP apple display controller.
Message-ID: <Z8hZKW_F-HtzYm-w@blossom>
References: <20250224-adpdrm-v8-0-cccf96710f0f@gmail.com>
 <174118223158.156873.6982508045942987984.b4-ty@rosenzweig.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <174118223158.156873.6982508045942987984.b4-ty@rosenzweig.io>
X-Migadu-Flow: FLOW_OUT

Er... I only applied 1, 2, and 5. Patch 3 was already merged, and patch
4 is going in via arm soc. I am, new to b4, sorry!

Le Wed, Mar 05, 2025 at 08:43:51AM -0500, Alyssa Rosenzweig a écrit :
> 
> On Mon, 24 Feb 2025 12:02:15 +0100, Sasha Finkelstein wrote:
> > This patch series adds support for a secondary display controller
> > present on Apple M1/M2 chips and used to drive the display of the
> > "touchbar" touch panel present on those.
> > 
> > 
> 
> Applied, thanks!
> 
> [1/5] dt-bindings: display: Add Apple pre-DCP display controller
>       commit: 7a108b930a84e71be71c3370eef6dd96fbb8f618
> [2/5] drm: adp: Add Apple Display Pipe driver
>       commit: 332122eba628d537a1b7b96b976079753fd03039
> [3/5] drm: panel: Add a panel driver for the Summit display
>       (no commit info)
> [4/5] arm64: dts: apple: Add touchbar screen nodes
>       (no commit info)
> [5/5] MAINTAINERS: Add entries for touchbar display driver
>       commit: 4d2a877cc0efefa815648f1ed5f5b2b796f55bab
> 
> Best regards,
> -- 
> Alyssa Rosenzweig <alyssa@rosenzweig.io>
> 
> 

