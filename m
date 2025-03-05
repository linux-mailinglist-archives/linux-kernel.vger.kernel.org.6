Return-Path: <linux-kernel+bounces-546949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0954BA50113
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36C23166D57
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCAE245025;
	Wed,  5 Mar 2025 13:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="MQmaoyaK"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F4E5228
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741182531; cv=none; b=Bsy1DyKQFl/MHulgXqTsXM56tUcjsPdPKjnThdLWP5VaCxLp+I7HB9ZJu9FkzAbEcNazBbPlzZwqhBkZ4zST2uVwKoUQayd4bRnbUGMU8ujjFnZ5TMfHgH5IoCW6b5IXXe+usXRFiS6OrXE+fJA/tnOJ2yQAZOJ4OH9em+NqJY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741182531; c=relaxed/simple;
	bh=uR5T1D3QxAJlJ1Grdi1qVI/wsoVx9nCe/kXwEE6UJyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzBp2mZZxJopYMyjScguGNX0CL78aY9pxvFNqjDkZ5Mx+EWZDR2vLE9ckjI28VL6U5pVZVP2/BE5PNdtD1h/3SUPGleJz/eOv5PJ/Q+tWKYJ5irX2Pxu2YN3O57F7VepEyiIAHMdfd48D657iPA0bodzIkH6mU8WT326pCJA/zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=MQmaoyaK; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Date: Wed, 5 Mar 2025 08:48:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1741182528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wb6rcGnysdOjkFCR0OaNCjFIgpAYP0AzENVy2fFqyCo=;
	b=MQmaoyaKEFYFydhvZcXatALOg9G6+iaxRo27Zubxen26s7vvqy9imItga79vuEh+y5w00V
	tWEGEMppaREoQugpDnYbR5rrnCLUkDGmLLXekj3bTCnlWwTKfATTL2VFzCOFk1cLKVJjl3
	p2kUCg7Ss/0BrMFApcKJ8HkyKZP2dO+qOJRJEzR8ulRPNUYrkZLwVTtdiLl0Noe+JTodZZ
	HGfHLMvlMb8Rt7OjveDAPN+L1D2ryDxl6T2V446BWwiJG5HV0n3U6QjnH0+BW1VCDk4hzb
	oVWXF1wOH8083b0o/tpp1i4RASMkr5/vjDO8iMglqx5P3dgHv/QerJ8pJkwLfA==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Maxime Ripard <mripard@kernel.org>, fnkl.kernel@gmail.com,
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>, asahi@lists.linux.dev,
	Janne Grunau <j@jannau.net>, linux-arm-kernel@lists.infradead.org,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Alyssa Ross <hi@alyssa.is>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Neal Gompa <neal@gompa.dev>, Nick Chan <towinchenmi@gmail.com>
Subject: Re: [PATCH v7 0/5] Driver for pre-DCP apple display controller.
Message-ID: <Z8hWN4DpNyTHQf7I@blossom>
References: <20250217-adpdrm-v7-0-ca2e44b3c7d8@gmail.com>
 <c3927b51-55ef-4a38-8931-18ff00caa8d8@linaro.org>
 <Z8XcH7xoDC7TA7ZC@blossom>
 <dn7zskhxgdgr25nvbnsjyn5brc3yoc446dxz3vqgbiwoccvlcr@5l6f4byj53fo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dn7zskhxgdgr25nvbnsjyn5brc3yoc446dxz3vqgbiwoccvlcr@5l6f4byj53fo>
X-Migadu-Flow: FLOW_OUT

> > > All patches are reviewed, can we funnel patches 1, 2 & 5 via drm-misc-next now ?
> > 
> > I'm planning to do so today, just need to get dim setup first :)
> 
> Nice! As a heads up, it would be really-really nice if you can send any
> kind of 'applied' message. If you are using 'dim b4-shazam', then
> 'b4 ty -a' might do that for you. Otherwise just a simple 'hey, applied'
> email is useful enough.

Oh cool, it didn't occur to me that `b4 ty` would compose with `dim
b4-shazam`. Sent a very belated message and will try to make a habit of
it going forward.

Thanks for the tip!

Cheers,
Alyssa

