Return-Path: <linux-kernel+bounces-271502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1D0944F25
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C166283D74
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DFC1AE87B;
	Thu,  1 Aug 2024 15:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j9xFhMFt"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7427213B5B9
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525969; cv=none; b=p3RTXJ+fFXL7HLSNuYAhbimeiZDCYU6oV0Eh/RqxPsOgXGFzUEjv2xzeJjnXadtwGthB4TlnB6aLbEzpJcdcibEGtCJxS2z2gYTI0zlxNqNxo22DcQY1xttMFYlBGpIHXhVFyatyZnPaqI0fn8j7/X3yXiOVPPxRtIjeQSBmqGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525969; c=relaxed/simple;
	bh=R93pHP072SK7QJJ7HyWepTn6TkGT3M0R9Ju9YpXM1jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3nwwHy94JmeHtXMvDv+nOZBs6BUBaL8QLE80yLU10QzjDFtB+rTYsFnFd4n3PFffM+QZZPSrkMvVcfb0mbQX7N1VwDMTx2vffyE+Nn1I7NMXi/wa39r3M5z1imXOisWsG2UhK9d48chvqkyUHkEXnc9oHWUzWoohGNTcerEctU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j9xFhMFt; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3db51133978so700012b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 08:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722525967; x=1723130767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NdZF/DtZnBoYnBkdCQ2kKbzbppoVZ6B+UZkFoAdo3p8=;
        b=j9xFhMFt5uhF5ACPaApTfITtug3AU+9rXBtgxf2FmCRLFXFIlfXSyRV8a6LLjseV5R
         9aKq9wsjKG7mr/whNb9lRbUYnfv+bUNycxOfQmEDmTzBnR2s+ugIc18XiiJh66lwU0m2
         PFJrz8FRsin8Upy2/o1GyI6oWYhtsEL632bBupA93OAB+IPO1reF6Zlz0YG1iCoDTkDz
         H1LNKYWEZ2Y7y2yp37BE+TRmBhVIyA0Ey1LObE56kLKgmaOch11o5VyMTd5QeDLt7UI5
         5s6vOFwxV547m6qlyzsQ4NrA/gLkJYtACtB5smsoxH5vdLOykQGdbSOXikMX+f+afme8
         aV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722525967; x=1723130767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdZF/DtZnBoYnBkdCQ2kKbzbppoVZ6B+UZkFoAdo3p8=;
        b=kaJLmJy5ijOWM7/hQ4aeaGIRkLKUGEJ+EZEwU/E6zIgouokD0si7hoQebce3XFxCW1
         olCeOaBbFv8HRsmCIBd9UaXUvYE4koCjKiZkdq7miVLJMGz5t5tE9PMcLSQ9Wjb0omBc
         R0AxeFMuPJP5X7Tus/sNoVTeg+QI+YJ3gPz6xrFC3n0xP6xNLHPamLbq4i+yWcAbuxBu
         VNifY4RRVuwhD1nSy1LoFCKjLgdrFSpt/wAhaOMBs92aQeBWrVJi7aIYszaLSfo+MGL+
         pKOjxPo1M2U49aHogntJdn75i1Ep03jd5h2qlIlDGK0SxgHGQcaCsGic5lPeJWRgEtaS
         v4TQ==
X-Gm-Message-State: AOJu0Yym0RxlNPDQIHthUlKnLW/gn/jTqWV4RRXLpJwxUD4D5gy+34Z3
	oKK6s+LNtnQpJCP6jMMphJGaWHa9wq+WY2FrjodKTY6TXqdE8h+sRXY5nBREWUI=
X-Google-Smtp-Source: AGHT+IHBMeZxdmaY1Tz4aYl0ORJfyOwbMMZr65eQOrL9+mRM2tod3ckdr6LKuPfBXK+OG2tKVdeSAA==
X-Received: by 2002:a05:6808:1a06:b0:3d9:33d0:cc4b with SMTP id 5614622812f47-3db5577bd58mr724105b6e.0.1722525967524;
        Thu, 01 Aug 2024 08:26:07 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:920b:58f5:7792:ff2c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3db41805faesm1144700b6e.30.2024.08.01.08.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 08:26:07 -0700 (PDT)
Date: Thu, 1 Aug 2024 10:26:05 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
	Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Arnd Bergmann <arnd@arndb.de>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: i386: kernel/sched/debug.c:341:57: error: integer overflow in
 expression of type 'long int' results in '-100663296' [-Werror=overflow]
Message-ID: <e11ca9f9-d780-4d92-b9be-d549f97b4e67@suswa.mountain>
References: <CA+G9fYtE2GAbeqU+AOCffgo2oH0RTJUxU+=Pi3cFn4di_KgBAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtE2GAbeqU+AOCffgo2oH0RTJUxU+=Pi3cFn4di_KgBAQ@mail.gmail.com>

On Thu, Aug 01, 2024 at 08:42:07PM +0530, Naresh Kamboju wrote:
> The i386 kselftest merge config build failed due to following warnings / errors
> on today's Linux next-20240801 tag with gcc-13.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Build log:
> --------
> In file included from kernel/sched/build_utility.c:72:
> kernel/sched/debug.c:341:57: error: integer overflow in expression of
> type 'long int' results in '-100663296' [-Werror=overflow]
>   341 | static unsigned long fair_server_period_max = (1 << 22) *
> NSEC_PER_USEC; /* ~4 seconds */
>       |                                                         ^
> cc1: all warnings being treated as errors

It needs to be 1U << 22.  It's probably more traditional to write it as
1UL << 22, although they equivalent here.

I can send a patch for that.

regards,
dan carpenter



