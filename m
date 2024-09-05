Return-Path: <linux-kernel+bounces-317566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE1D96E02C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 18:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0326A28B569
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24FE1A00F0;
	Thu,  5 Sep 2024 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UTjeX4If"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856DA17BCA
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 16:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725554800; cv=none; b=OPCx3404RUI/X/d8hVAkB/XaOkcxLuazfXgVDV8cZS7HoWp2WG6NdOlxRRyoMTfOsHZC7kzeVzC8BKISgunktICgAb5LzMTP2a1Ked8wg1TuSvUqrfGaovcDRZldtPSrCFFn4l2uZnORqkl92gX4lyn3/+Z7m1uNPcFgvbg83uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725554800; c=relaxed/simple;
	bh=q7g7e4cgOHO6w2S3BGKPvJa6HHCQ/9M9pWG6j8Jv69A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cs8fTXMWrsY1KZLZsNf0eMceArg/ZnBC90S1LiKAEwO+Y3x+/dJVqdgwn0TKAbbCB6PmIPMra4vpuc0vA4M4eRem7q7Q5SyqUIb7OEXvhD5ITrULx7xdlDL2pOtiFLm6flJps+kNhvPWH65LmAdQQkumLREs0uN3gdbvszjBSw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UTjeX4If; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 246A660002;
	Thu,  5 Sep 2024 16:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725554795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=y9JHzPELaFvdfCk8t28Ma1HhiSmtRgZuuju1D+YdvBc=;
	b=UTjeX4IfKUOzgbt+W8oCLkRxz2+rQA2+rozP2xe3a98LGUzNvZ0o3rmg4ootvlL8H1Shhk
	xl9MjIk38iAcG7mjHxglQMbVSYUhJznIIqnH7kcwovTX0WuUgQ9CZiIlS4GwTUl85xKlp/
	uqAuGvRBIqM8DZc/FLs1Zv2BBmeVoSBclbKP5h7gYH+7V2//484eEB4Eq3OPBzLoR2ac5C
	ESqIWvwDOnt60xsuUlUoaSJC9+FH9+jI+sOP/+UIm0DbZC/QKURCv7bdj/9OrPuvxnP2G0
	i2t6iwUX/FvjNJOKKU0e/cCeJzHxUFZTbcrOtDI94/BymT30D4eqGmBwNa9wjA==
Date: Thu, 5 Sep 2024 18:46:34 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	Liao Chen <liaochen4@huawei.com>
Cc: pgaj@cadence.com
Subject: Re: [PATCH -next] i3c: master: cdns: fix module autoloading
Message-ID: <172555478609.907928.16529000879792282272.b4-ty@bootlin.com>
References: <20240826123957.379212-1-liaochen4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826123957.379212-1-liaochen4@huawei.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Mon, 26 Aug 2024 12:39:57 +0000, Liao Chen wrote:
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
> based on the alias from of_device_id table.
> 
> 

Applied, thanks!

[1/1] i3c: master: cdns: fix module autoloading
      https://git.kernel.org/abelloni/c/133f67bea5e0

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

