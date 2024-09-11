Return-Path: <linux-kernel+bounces-324415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D58974C2A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA9C1F25575
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2305C14B97E;
	Wed, 11 Sep 2024 08:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPp6rRjC"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1029B13A265;
	Wed, 11 Sep 2024 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726042039; cv=none; b=nx0xKiAyj+CxGjYqJ1qMq78s4O3LdKXSnXQy/tjWAwPh74EG/G01MsuxYvShzyEAlpLCt47nZHhVGKap6Yv+Y+AqM0qOOQ7Er7OPfYfIPG1YaVzi1d1iLt+vXcmXQ4ibWnTNwSKSei5fuuOxUhuG9Yyl1YzLPaHFL1HqOT9zGgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726042039; c=relaxed/simple;
	bh=BZq6+q8bbZt0R5ucjpyVPmu6SzP5lx4HOz9jWC47YHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJF1zCTDAR5Vsh7cZGwDEsqw9NdNeISLaCIPYL6I7y07dF7xdnWpQjy93dqTzwVXU9o/EFmktuk9gpkYDSJbiE4QoA5M65G0a062ERwTA5SbkV5iJ02/oQW3dxK44yrZboQtoZFspEwUlNEg486TdlHrteACquyjB+YnS8It8AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPp6rRjC; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cb60aff1eso31667445e9.0;
        Wed, 11 Sep 2024 01:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726042036; x=1726646836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KlrFnjoiCduc+X7w1TixBUXFhOeoooXPO+ytTh1hP4g=;
        b=BPp6rRjCGR5mENEmRg23pgezsjijj3xLxBd2cEur0cY+qsCsfKC/MzW3gy52QvEdX+
         BhX7RGhNid/sqnSQRj6LlhWUQBP7cVwvIALBMPmMVRmTgmdVTgWJafSORX4gAr75ycKt
         d24GUElsAD1XscMCDUS3JamFMjCxpHTz5CHfRiokwu3XjY4IOfNOkaRx5uqXH5xcc6D+
         3mIn1q5g9SH854AKIQqYDsQplk0kXV/AQn+CeOXDJeeZyPNu1+b6Tr4ftrUo1+G9Bl9x
         1b9ugu51tySxiiMmRc6/Kf0g1kb1DlWdtyKGM3zfaCT30sn71DJ74c+ZPhDePEbjZop1
         iCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726042036; x=1726646836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlrFnjoiCduc+X7w1TixBUXFhOeoooXPO+ytTh1hP4g=;
        b=BoPd23sc1gOOpeRidL2vJNxCWgx/3otUBHFOE86j2gnH12XSeMpCUhE5eAEnGZ3mOy
         5Xkk2YEoi6/4GB1FMo7PTTVSmZGAIIdBdt3645R730URSd3kkZVzinef+l8f5XcRqKuP
         N+LU73U02gAtjDxVL770/cp58Msy7Hd5VBww9pwihwp7gafhilg+JgROmcNuu99WcWYO
         yXEBICEpii48dN4RSPiAV5hMGRvx8+zK30wp7WHZexHtzwmH+iGEZuD1MCKhTxpjr0yd
         XKLHumUk8WCCdwX+vvPBReHvxI6Ujb3t/mb4VjtS/XI/uyHuX+f4jPS4mbvo82ag0ICk
         SSHA==
X-Forwarded-Encrypted: i=1; AJvYcCUdjeFnBaKc/+X9v12cH3hK4cO8SV9MlsVBXU+0P0DEsSY7lDOAVwZHWVeZcxKyADdEwOj9oR+IoQcQRVbK@vger.kernel.org, AJvYcCUucYqSGw7T4+8ceynGbzbkiRFg+RrjyrBTC//UGDmTNdBXviOwjIcKmInuRZ2KHeHtHpK+9FvwBMN3v/LO7L4=@vger.kernel.org, AJvYcCXSFgLKjCdc8QywixYUaYQle/WJMlgj1nyoj4H967m9MLMT9fbPFcEqs9tzVsb8eOyJhCgl3ufZtDX8HLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaPYSwmr+DBHwu9LL0sO1LL5hL153sNFmA5vUzOyRzdOlkKQK3
	/ixA5vV09hBOobwYQIaa0xnsexBLrKMkqFHWrDq7BPJXm+Zhyesg
X-Google-Smtp-Source: AGHT+IFtsWzA1krV4TnK5wYQrFD2heYZw9fKGrydZsvH/HYHpnoRdSvc7bg3h9Az1MjCWnJBSC2HzQ==
X-Received: by 2002:a05:600c:4713:b0:426:5fe1:ec7a with SMTP id 5b1f17b1804b1-42c9f9d38a7mr122692515e9.31.1726042035638;
        Wed, 11 Sep 2024 01:07:15 -0700 (PDT)
Received: from void.void ([141.226.10.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb1f0140dsm120034425e9.39.2024.09.11.01.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 01:07:15 -0700 (PDT)
Date: Wed, 11 Sep 2024 11:07:12 +0300
From: Andrew Kreimer <algonell@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Fix typos
Message-ID: <ZuFPsKkobcws-iZ4@void.void>
References: <20240910211302.8909-1-algonell@gmail.com>
 <a8e6f267-9eae-48db-8a8a-b9e6d93809c8@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8e6f267-9eae-48db-8a8a-b9e6d93809c8@sirena.org.uk>

On Tue, Sep 10, 2024 at 11:03:52PM +0100, Mark Brown wrote:
> On Wed, Sep 11, 2024 at 12:12:41AM +0300, Andrew Kreimer wrote:
> 
> > -		/* See bellow for details how fix this. */
> > +		/* See below for details on how to fix this. */
> >  		return -EINVAL;
> 
> This is audio, bellowing seems entirely appropriate!

My bad!

