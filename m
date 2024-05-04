Return-Path: <linux-kernel+bounces-168598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF9C8BBAA5
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 13:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2D9F1F21E9C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 11:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D261C6B4;
	Sat,  4 May 2024 11:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i1aTwC4N"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EA4171CC
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 11:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714821491; cv=none; b=I42873HgDTxCiMQPoCKM5h61d02uHKJXoGByTIF+DskdogD3d5avlbUVh24EFNTcAdFHOgYOjYlaQi0dwa7pAGtiyIfIVqr+TR15Kcj70xx7eHI4RmaRmT0SBVwCSQzz/kP8YP15DoEZGiGQ9ni/jXF+WE5fzyvlwkMsSPnlV0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714821491; c=relaxed/simple;
	bh=smELU36PpAU3prIkce0be7IjpSNr4t5xDRxPzlw1+z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDDewyha8aWnpdEacbXBr6lmbtyvee9ACnvxuzayX0gCRX5Jv0mbDTU6yNbAdqrQAx59+rOVdcQMdUO4gKF2sQT27IYRBWaSi3v8xAEWs45k92PrpmNrCk+3MGmXpg6p5bQ1O2NNDkCYr9K4MvDZfiw0TdC50MCZoIMyH10rddU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i1aTwC4N; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e0933d3b5fso5682141fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 04:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714821488; x=1715426288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yv9FzWOzBDzyrTcS40BSQArXvrw2k2j9CKdjQ6IcHqo=;
        b=i1aTwC4NEW3INdzcaNBVaLUCr6SdSrcrrvlIKuqGTwswEUDUB0w6G6n2TGMwp0RsBS
         bqj0RroFlXEq9ieRVn+8HIdc7x5wUoJw9fJZMpO3MJsJTscERmSk78nGnzXGO23oiK0M
         bvaMVmlPHhdJP81x5xKg4dLu3hYkdTTwI6lnm/okJ2Fvqm1OuoklHiMuEEMWPr2bnLdG
         jYJoqsXrQKDqoEcEkFC59LhbIqGIy+/+5NAkp0M/5aGwzPiX9+/3grjZrDQek5pvimmw
         30pt/FqjTW+xqExwaHo7dpuWZG9bCw/j6A/rTKb0LSr9Hk49qoU7iUB5xhoOGMl1U9Xa
         Z+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714821488; x=1715426288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yv9FzWOzBDzyrTcS40BSQArXvrw2k2j9CKdjQ6IcHqo=;
        b=jzAo19UGUPsR/lxTq3LoWRZSFQBOXmYBcm4KrGTSJbgOyQOS7ngVrCoHb7NoFz651R
         ze7mBI1YAJkpz3rjWOwauAAXwyQuQcb6G4LG4gD6cBVF7e1kM1Wsy3vh6Z5mgO90GMBp
         TUy74s4wl7/cPzYWB4EvgVQblAMUGngu/FsxMNeW4rGvuGbXEtbKQBvA+zCxa78VnCnb
         7rXsgPUBtPQ8byRaJF/jjpGpV/h4D2O7SuDs6mp1ddCbHg+r3Ixo3gUtpub/w3YMMd9e
         zdNV/0Uw4Uq82B5WZXjjUparGb5o8GAPXu0Rq5Xq8AYW4t9SFM2NT9YqjebpQuIlT70f
         WcKg==
X-Forwarded-Encrypted: i=1; AJvYcCVJp3alWrO0tF2AmBQOqej/bc262IE4vnebujch7Edkj6MIEr75BDgkxwm3/eG6vlBCLqO7sAiMFe/D6SUSrXLjKKvjMX+rQuWszm/h
X-Gm-Message-State: AOJu0YxaE2xmPAN4WitNlWlox+V2cFp9OW+TLU1dFsiDp7DK5l/DXUr6
	f/dB7aXJT/Nk+j9M4on0y2irOcVPT9cRDz7icxD31yQfezqeLSEFn2Lpl60Qlt0=
X-Google-Smtp-Source: AGHT+IEggVHErInNqsEkGN4lf9Fm25s9yd+oVBzpPNb90IQ2CCo7mKtWyU3ysBaUz2WYQTnosuIkqw==
X-Received: by 2002:a2e:9dd4:0:b0:2e2:2791:9842 with SMTP id x20-20020a2e9dd4000000b002e227919842mr3499876ljj.44.1714821487428;
        Sat, 04 May 2024 04:18:07 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id je8-20020a05600c1f8800b0041bf28aa11dsm8916105wmb.42.2024.05.04.04.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 04:18:07 -0700 (PDT)
Date: Sat, 4 May 2024 14:17:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ashok Kumar <ashokemailat@yahoo.com>
Cc: Julia Lawall <julia.lawall@inria.fr>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
	"linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"outreachy@lists.linux.dev" <outreachy@lists.linux.dev>
Subject: Re: [PATCH] staging: fb_tinylcd Alignment to open parenthesis
Message-ID: <45366e52-47e7-4e9d-a2a2-7eede9d3b450@moroto.mountain>
References: <ZjRDUO6/M+RDCcQJ.ref@c>
 <ZjRDUO6/M+RDCcQJ@c>
 <c8d24241-1763-f7b7-4491-2e5aa3ea3be@inria.fr>
 <1389558595.6771301.1714753224419@mail.yahoo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1389558595.6771301.1714753224419@mail.yahoo.com>

On Fri, May 03, 2024 at 04:20:24PM +0000, Ashok Kumar wrote:
> 
> Is there a list of exceptions to the checkpatch information that we can ignore in general.
> 

For Greg's subsystems ignore the warning about extra parentheses.
You can search on lore for if a patch has been patch has been sent
before.  Otherwise ignore checkpatch if it tells you to do something
that makes the code less readable.

regards,
dan carpenter


