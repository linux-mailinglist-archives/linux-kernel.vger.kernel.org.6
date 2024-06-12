Return-Path: <linux-kernel+bounces-211416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9B1905160
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BD3B283AE3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6102D16F0FE;
	Wed, 12 Jun 2024 11:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Kux3XY7j"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CE116F0CB
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 11:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718191803; cv=none; b=AnCYuw4xkOZzaofNJGxhnT5mzk85nY5k3o9Jr2mvXea/QSwyKtl3j16Jn1HRbW4eIxb6Zcy4Xt27RGv43RKqPvZ81G7wGonlSOU8gJfHSQJoyLGTQ/28EbWpayDOd2KwF/Zkmj/ZwmEvAL4/8jse6SEISU+SeoodXHLkTFZJqZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718191803; c=relaxed/simple;
	bh=gNuCvJHiPsplupaqqLmNzsGe//s26kGlbP+C9lEfkzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4Sw4KNJLzvjiJeFQp9kYoZBeoqURJTqlniD/qv/qi07/kOGyhPD+piL7a0fMYx7MSRriD1D0vndg8Z8ezoR3/vbWcthkbemEJmA6vm9ssM7TWTDnOELapkf6f+s6dE4FKh+wzWpMUVHts78VK1zH9vaTirEdrfLHm4PTmFHigU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Kux3XY7j; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52c84a21b8cso719109e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 04:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718191799; x=1718796599; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ggc41s1xFDytmiIRx6WqUeauOWT0puNfK03Y/4MiVTg=;
        b=Kux3XY7j05/6HvbROeNPhyXY4/H06xc+HUSF4DHld0L/+2tew7VAEyRQPl+C/ccF4c
         8IkXu8CnHDpRt5jMC1CV/u4AuylY1ogAfSqqvWGhLMpDrMdVfC13vxvlvZtlDYXBhmgS
         jdj66Epgmwz6tTrHz+bslX08iWuPip7McObPFopNtIERsWvG5Xf4lkwgufh87svcQz69
         SQDLQAAx0PShEhHG9HobKzvWRyyLsN1+b01f+gmGvXXV3YZmSlnKkScOmf3Z3p8Wd2VQ
         xwlpHDor7CcqpHW7A29oqUI2zaS9hSmDfOd0OLpC0h70X9weS5HNYFBt59ulmVVs5EvW
         AJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718191799; x=1718796599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ggc41s1xFDytmiIRx6WqUeauOWT0puNfK03Y/4MiVTg=;
        b=meKgBxyifKgBWyir0Vx0DzWEI6WXLAPshgz5m7NWys5M1wvX9GoSVwVut/qvbk3BuY
         trvZWJ9wkNq+ERzVQCk6o1Un5BdubN4vAPp06boYqg3BjEgmYw5Pp0favDl2h8lnKJ4e
         WBcu2+MmY9jDwpua4uquDsYiQsmeWeNY9COZ131PwlUhy46aIuN0d2JXk4j9jn1snSpJ
         bvDcAjouDldq1r39aJUoeEkVgr7zoqzfdDM8LtJ3lcz2JaK6ZRitejsuiCDmTdocgdlV
         glhR9CUAmEcC8CeekBU3MXVPXC0hBF/XcOTOm2+jrzbdWJrfaLSqrpUAvsHZ/bTT0kJW
         iVWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFDoYyM6WznSdd5Uf6Y9LZ2F8B/QQvQTt1r4U54ingM77vHa4+1bi4nPgdZR4eJNnt9Z3g/xJCnB0vyfqtThWqPs137G3TUauUr+tT
X-Gm-Message-State: AOJu0YyjCaNAAqzdrGvBlcFtgJcHa97Btt5q967UTFmd/M/hDIq50zGn
	aQxk3aLPdljm98rEWsc6UHTnfBJzlIXpUrgSTec8rBeuCZs1/L+nf+B0+kC3MhM=
X-Google-Smtp-Source: AGHT+IEb+HkuGtmX+A7+HewHkLMtey9b0gN6G8NRsTakT+eTQXDShYDGHEl0gd3bXYFniSe1ZalEdw==
X-Received: by 2002:a05:6512:1c8:b0:52c:8355:422a with SMTP id 2adb3069b0e04-52c9214fc32mr1600954e87.9.1718191799330;
        Wed, 12 Jun 2024 04:29:59 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52c9a100278sm181968e87.22.2024.06.12.04.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 04:29:59 -0700 (PDT)
Date: Wed, 12 Jun 2024 13:29:56 +0200
From: Petr Mladek <pmladek@suse.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] vsprintf: add missing MODULE_DESCRIPTION() macro
Message-ID: <ZmmGtJLKdQAHhDOW@pathway.suse.cz>
References: <20240531-md-vsprintf-v1-1-d8bc7e21539a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531-md-vsprintf-v1-1-d8bc7e21539a@quicinc.com>

On Fri 2024-05-31 19:42:25, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_printf.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_scanf.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

