Return-Path: <linux-kernel+bounces-391432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A25969B86A3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 00:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC56D1C231D1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 23:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2217E1D0F66;
	Thu, 31 Oct 2024 23:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="o6vpm5XM"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B26197A87
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 23:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730416095; cv=none; b=d3kKN7JD1W1X4d2PFF+LcLMf1+nb4sG//Cg3Kl1KcrmNhPr31fBTyajNl7iR+pDshbpTC2U6/+PCo2sL1qLwjZ/FYKOlAp2AwdumV6clLr4TmiVky1NwKMrXfv5I3RrgtJu6HUNdePXjpvUaZYydrYw/wjbbBc2VY1nziby8k70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730416095; c=relaxed/simple;
	bh=aS4C9wb/arjnFhENki1yZvPjJaRudyyxwa0/uwKoqGQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLYNAtPqp/BSwbeG/x1Dtck1rtKt4CRynn7jnTDjF+iWCoF4WQDdMcjqqh+DQ1m+FnTv4c3VMEhkzCGBRdpAub1q7UnAPv++B8vfeSYz4YAcDSWJmmUneFbsWxfP6jHGe6p47kFksz3ZEZD4QEnzIh7JrY5K4sHWVGsNgpFVIxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=o6vpm5XM; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 68D0DFF805;
	Thu, 31 Oct 2024 23:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730416087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BCFCPF4B9iVyD6O/ctAFxNBJbZPeroNHpthZdwOLDHY=;
	b=o6vpm5XM39lgmLP0/LUBc9WNNaxujk1B/0UFCHbscX4SgVtnMh1M2qpD/Gwhm22uLhZCEB
	drjtWvLkCGa1tJyJbViIeFZ/D5+q80Oqqm/eTCADf6cu3jstSazdp+zT7tF8yOyAsp2Ekv
	wbyoRae6ykCOibGJKBXjdyccPfUibNDOhN5YqTn32gq/X7RrZzDY1uvY3wN8pMwI5Up0VX
	WCms41Slg4m5UKsIbzllv4K4nKow8EL/tRVvpm4suu7pW2mJuN/KRVvXoFR5aiiN8vwSWU
	f9Psk3iCdncT2xMCcw3L5SLpyW9OqCMuaFFsHJIWV85G2wMrOkKJIfANhh36dw==
Date: Fri, 1 Nov 2024 00:08:06 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
	xiaoning.wang@nxp.com, jun.li@nxp.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	Jinjie Ruan <ruanjinjie@huawei.com>
Subject: Re: [PATCH v2] i3c: master: svc: Fix pm_runtime_set_suspended() with
 runtime pm enabled
Message-ID: <173041607944.2393443.4629872901848219813.b4-ty@bootlin.com>
References: <20240930091913.2545510-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930091913.2545510-1-ruanjinjie@huawei.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Mon, 30 Sep 2024 17:19:13 +0800, Jinjie Ruan wrote:
> It is not valid to call pm_runtime_set_suspended() for devices
> with runtime PM enabled because it returns -EAGAIN if it is enabled
> already and working. So, call pm_runtime_disable() before to fix it.
> 
> 

Applied, thanks!

[1/1] i3c: master: svc: Fix pm_runtime_set_suspended() with runtime pm enabled
      https://git.kernel.org/abelloni/c/18599e93e4e8

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

