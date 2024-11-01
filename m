Return-Path: <linux-kernel+bounces-392874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACF19B991D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 21:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434971F2257F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 20:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46AED1D2707;
	Fri,  1 Nov 2024 20:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YP5bc3OU"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F891C7287
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 20:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730491416; cv=none; b=Wy8U91Wnx5RMFkPjrajTur1x3zJL5DPhRMX8Q2ZYC8SG13+bCkJY5CLzOdFHEVk3JxyExbgkEtzyDqR0bXqLQN9jSuKRClVVtRsFMC+whj/lHd8hL+VftjUgonauSDCSoHY7wzWkeECawEbQCPfXn989FCQvO4U/oSIPcmAS/pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730491416; c=relaxed/simple;
	bh=7g9We0eqUUXCq1dSP9cANthL3PcqEPNeijHoAQFcdeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dNlshMWEj05XJ0p8zmTbhOTP4WR6hUJ8EDtSWXV8+lX30Q7+7tj9RA3pgmJQAEhoI98BR4UkIK+2N04zAg5PFMciRZCN52Rh6qWnh2xr5dIrbsw6RDE6ZLq+AaIWKhAe0EqWs7HysTkRfb/qMa5hrjkHdLcFIUIdBjKN+EP05gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YP5bc3OU; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-431ac30d379so18551445e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 13:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730491413; x=1731096213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTwdGSzq+YwPJ1wyOfDmkaz+xCRodSguu/W6kdVGHDY=;
        b=YP5bc3OU93SjSNK+V1S5s9A3wfc5vc8f6ELqd/bdZJ57TtDXpT0hpb3Axde6CpUwuL
         pF5X8ZCqn9JXf6DfhdYjUVQkTaU/d4Vd8RVZYmaUaiXlEphtOzrTqHZrdLTob/RycpU8
         qg3K858i0mMGaXSkhxSrEHgZbYmJXnLgp2i8YmXQAWv5NU0F4ITSu3dJ5Zi+jrp0KL9D
         wuuWUEAyMAjSGdcjBJgRMSqd3hyuDQPT1FwOIG6yM4KJ+EG06uRTKyqZfsLC5ULMcMc3
         oMutviYC8USpeCsT5yBxg4f2P3VBU78pfyJ4zKUEZQEx2CZD79KucclkAEqP4M40tirR
         VCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730491413; x=1731096213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTwdGSzq+YwPJ1wyOfDmkaz+xCRodSguu/W6kdVGHDY=;
        b=RqgsrY9dQORARjTmQK68knsWLzxpLrd3jHofJW0kf3tsAZFXEDCi10GR8aGLrWXwVf
         oUw57ftEJzIFOIbPrirz9gHe5ynopBJ2qS/3WEuuQeO3abUazhrRC5AWh9IFMoN2nrHi
         W68xztPLQD1cl6y4BwielsnGvJHumro0VN8qlm2ySVxfOIYiFv84SC6Y7CJYTANAdW88
         Q4KGAtYHwFXfZE5905Ztsw0AFPEbQ//o2WXp+30xYb4mEDbEqps9xbFjj+l0vPkOTnia
         Y7s3jhi752O0lVlT9VdcGa9sdNkQgIXGa35BlkA+SlljeV04tOvd5RolXj2qNwENVEeu
         XJSg==
X-Forwarded-Encrypted: i=1; AJvYcCUZFLzbRxP6zusNvxfjT2WHmU7svTR4Lz2SsJCi5w3wx6u6lv1amkmAbkdpy068zezgYN0GVWyw8S9L/W8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUicuRuU+naDvt+DAwhHbB2w1iRMbeLI9CDFj15Vfe67Bxf1J+
	1Z4bkadeyn1uzX7YtIvj2+RRqB+5e02pPS288ebhNz8m1J9AGY31YhQm+ooDbVM=
X-Google-Smtp-Source: AGHT+IH56j6i9DW7fWQlDcdl8QaW+GasYdpjnjmrM7SdtYAGoiqdGQA2eBZs7NIru/zegqA6HHkZ4A==
X-Received: by 2002:a05:600c:4fc5:b0:42f:75cd:2566 with SMTP id 5b1f17b1804b1-4319ac77208mr215911435e9.2.1730491413203;
        Fri, 01 Nov 2024 13:03:33 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d6848b5sm71791775e9.32.2024.11.01.13.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 13:03:32 -0700 (PDT)
Date: Fri, 1 Nov 2024 23:03:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dave Penkler <dpenkler@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	arnd@arndb.de
Subject: Re: [PATCH 7/9] Fix Kconfig
Message-ID: <350940b1-b497-4890-9892-0e9281a7ab2d@stanley.mountain>
References: <20241101174705.12682-1-dpenkler@gmail.com>
 <20241101174705.12682-8-dpenkler@gmail.com>
 <4c5d1b45-a3eb-447b-8269-8828dcdd2088@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c5d1b45-a3eb-447b-8269-8828dcdd2088@stanley.mountain>

On Fri, Nov 01, 2024 at 10:51:10PM +0300, Dan Carpenter wrote:
> On Fri, Nov 01, 2024 at 06:47:03PM +0100, Dave Penkler wrote:
> >    The NI_PCI_ISA driver also supports PCI and PCMCIA
> >    Correct spelling error COMPIlE_TEST
> > 
> > Fixes: 2c9f5d8c6ece91ecd33350749230494d224550f1
> 
> The Fixes tag format looks like this:
> 
> Fixes: 2c9f5d8c6ece ("staging: gpib: add bus specific Kconfig dependencies")
> 

I use a little script to generate Fixes tags.  You have to have "abbrev = 12"
set in your .gitconfig as well, I guess.

#!/bin/bash

git log -1 --format='Fixes: %h ("%s")' $*

regards,
dan carpenter


