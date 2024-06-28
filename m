Return-Path: <linux-kernel+bounces-234035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C5091C135
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3285287A13
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950941C0071;
	Fri, 28 Jun 2024 14:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N46pqqDP"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A06E1C005B
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 14:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719585530; cv=none; b=eR0Jz9PGVg+z8vrNprKD0xznNG3BVNAd/Fv2mAu2DzvscXvndXsXroMxgbJEIwGYK173+tm+UNIZuuC9t/TZcEaVVJGGHAhoICvgGx9XzUtQ9z/QUbvmdkOutbMPN4L7sNH7BR+ROCmBe7GLYGAqhXDRJ+IaOPdg9IbL4MVX2gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719585530; c=relaxed/simple;
	bh=7BxXM2M7LUj0CalzYzQjijmgAqZazR20jhvg//iGevQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pwF7mUQFwFGAdXEqNam56VhAiz3wGO7uR8yhmTorJlz4GE+1NLXBsHbpWAHmqxvjHTbGsTTn2/N/ivZW+dR64f60xAKqzYRUQniqacwa4JizfUk/4WCbbgBc3Pfg5ybl4Ya51dtaprWVZyViHuKZgPJxBAUvqjoyijAwt3u4Tmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N46pqqDP; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1137120003;
	Fri, 28 Jun 2024 14:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719585527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E8uMvsd4WS+2K8bjcQh7iIB/i1TtRbmb1QqX781ydsA=;
	b=N46pqqDP9XPqSqocLAjTDryh1mRIf4Sk0f6YZ6Bxlrw0IGUKE6UekXF0JkyxKr5kg8Rcm3
	HdaAwtoaTrjLR1arPRMUgMEQ5MAEsC6HcTB0QZquuzX2Yl5oNGzvXw3/QuHsIdkYHhtr7N
	qDdtL9dvfahG3IAeyNvsbM9mp3jI1V7PrIuZuG8ae/9cftoZ7panu5syYiGSfVtc3YeCgn
	KiEOl7nZWdYHHHQxlCfwjm7+pzMaICIFeLdQPcs29hie3zDQJ9rttygkRfHd22fQ9MNvtP
	0Q1dr2anrh8lXKmApzLcyYfTaDEROQf2p74ldYYYcsMZ5dFNPKzTGoVRx/7skg==
Date: Fri, 28 Jun 2024 16:38:45 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Aniket <aniketmaurya@google.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] i3c: dw: Remove ibi_capable property
Message-ID: <171958551738.36342.10923962764152593663.b4-ty@bootlin.com>
References: <20240627034119.3938050-1-aniketmaurya@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627034119.3938050-1-aniketmaurya@google.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Thu, 27 Jun 2024 03:41:19 +0000, Aniket wrote:
> Since DW I3C IP master role always supports IBI, we don't need
> to keep two variants of master ops and select one using this
> property. Hence remove the code.
> 
> 

Applied, thanks!

[1/1] i3c: dw: Remove ibi_capable property
      https://git.kernel.org/abelloni/c/11e2594fd316

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

