Return-Path: <linux-kernel+bounces-194442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EC28D3C64
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 18:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606B028452B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91AB1836FA;
	Wed, 29 May 2024 16:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="guea9sdN"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7731836D1
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717000093; cv=none; b=Gne9DJNCZeXV8/CqTClOgWEkfRrBYwcpbKdsYVzV8gqhfz6Lu2P3TkWCqr39rWgrkm3An2ZJtaAQ1Udg3q11wytpWqEOPlRUgWXzxTaZaZXCuHVb/qIEHuEuhmsY1fZ7gFQEs8+u2c2BRDrJXzxbW4lOmEfEVBloFHqRcpPOLCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717000093; c=relaxed/simple;
	bh=vNJiDOu1HJQcTh2QoH0ZF6EeoU/vMa/maD5ym7acze8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+YbD7pu8xZx8e5c/6DpZJStKxJaBkQE4jj6LJNvNz1XUotI+lSauW4pUOehDlRpgunx0UCsv/ZqvptwflO+sPS6r7ma5mkDUNrjtdGpu4BP6+SkcVHfmvaoHQGTcumuglVfZLJf3WF3KG+4abiM8Sfp1yMVFj2ZNf/X05DfUfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=guea9sdN; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e95a74d51fso6712831fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 09:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717000090; x=1717604890; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NEJH+7+vj6ruF1GbLbgob2BE38yHKh8JHlHGL8KdovU=;
        b=guea9sdNPBp2+nH2CwK0kuAmxX84BW8S6340QSc4xEFZnpdR+AIISSsoZP3ilcwh/8
         W1Xs1+bN2zkeAWzlAWBZa48MpUlC9TYXxOk18PuiMcKYZvQKUrOj6j9KYEZfeFrYViNa
         oPJttLcbj7UefRTjWchYzSCyRHf2gkbzKeVynXLB/iaDD8t0X9CYQvMdQTL+bHzALPEK
         /CzRBu3CvK2gEse5Xd8XPrqDTncDxNfe++Sk5bLHdLjSfiEEIHSp+M203xdoFzrlRN2m
         e/AliR3tZKSAGbAosEVBJD6bTi+I6S1ba4ZMUWADTzpxbVm2lax7G9wEX7pYXj5hThCK
         /bjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717000090; x=1717604890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEJH+7+vj6ruF1GbLbgob2BE38yHKh8JHlHGL8KdovU=;
        b=u1tgeJdiZ56FG+igj52fsJiCwDS2b4QQ3DGVqT9jUf0tspzWg0FwOFHnsToQYlIrmV
         8UHOhcdoj1GWMXvvwKl2nFrG5vux6OfY66sceKvH0lJ8o/YJtL4Y+0m1gzT3yYp9pAH3
         +ig9KJ6gbj3jQ2FWpyq0nRJ6fD50as+xKBq/VzUAbG5iBdhL9ECkIrwIHAFDcTwtaf90
         dIHEnAMcbMYSOn0DHDiv8SgSwDwXzIT2CJVz36jebKuWiq74gK0J0DXpP/dyjADo6L5P
         KQFdjceh0MIWzCmUCUDNM5PQ2XOA9wE8tDvPHT3L2yVLIvzV2KOk01g0Sl9BTx+xn2kr
         zBLA==
X-Forwarded-Encrypted: i=1; AJvYcCWG5RhHe1r4wjmclORxXqvUQQ8j6sPHpHCGvfLBfwu4L1pR4v9spgPA45Akag7lEadcigCUosOEDXya7ExXWHgMZgXZzwY1AnHC46W5
X-Gm-Message-State: AOJu0YzIYEIOgVkGVYtG9A0Ww2j5mHnpnOQnoa3TBXlxMjkqrLZ05WE+
	ogfzQoDASLAT9jkiKR3CZ4ZqAggkGaPPWEED2A18D5HIOf4IPAPWhuJLh1Aok9k=
X-Google-Smtp-Source: AGHT+IFmYVGVDhXJ/UgzgklvENZdHrtaQJwa288W1cA8geS62OGiVwASpA0S4D47EdPq0VKN1MsXJw==
X-Received: by 2002:a2e:9d91:0:b0:2e9:821a:82fb with SMTP id 38308e7fff4ca-2e9821a837cmr55797371fa.6.1717000087636;
        Wed, 29 May 2024 09:28:07 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c93a828sm735495666b.83.2024.05.29.09.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 09:28:07 -0700 (PDT)
Date: Wed, 29 May 2024 19:28:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: adt7316: remove unused struct
 'adt7316_limit_regs'
Message-ID: <c0bcb7b5-3155-445f-94ff-4020fe05109d@moroto.mountain>
References: <20240528233008.191403-1-linux@treblig.org>
 <d9a3c974-8a13-43f8-a0d1-0e55f6e1f3ef@moroto.mountain>
 <ZldRVBPi4utAfRd8@gallifrey>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZldRVBPi4utAfRd8@gallifrey>

On Wed, May 29, 2024 at 04:01:24PM +0000, Dr. David Alan Gilbert wrote:
> * Dan Carpenter (dan.carpenter@linaro.org) wrote:
> > On Wed, May 29, 2024 at 12:30:08AM +0100, linux@treblig.org wrote:
> > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > > 
> > > 'adt7316_limit_regs' has never been used since the original
> > > commit 35f6b6b86ede ("staging: iio: new ADT7316/7/8 and ADT7516/7/9
> > > driver").
> > > 
> > > The comment above it is a copy-and-paste from a different struct.
> > > 
> > > Remove both the struct and the comment.
> > > 
> > > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > > ---
> > >  drivers/staging/iio/addac/adt7316.c | 8 --------
> > >  1 file changed, 8 deletions(-)
> > > 
> > > diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> > > index 79467f056a05..23d036d2802c 100644
> > > --- a/drivers/staging/iio/addac/adt7316.c
> > > +++ b/drivers/staging/iio/addac/adt7316.c
> > > @@ -209,14 +209,6 @@ struct adt7316_chip_info {
> > >  #define ADT7316_TEMP_AIN_INT_MASK	\
> > >  	(ADT7316_TEMP_INT_MASK)
> > >  
> > > -/*
> > > - * struct adt7316_chip_info - chip specific information
> > > - */
> > > -
> > > -struct adt7316_limit_regs {
> > > -	u16	data_high;
> > > -	u16	data_low;
> > > -};
> > >  
> > 
> > Could you delete the blank line as well?  Otherwise we have two blank
> > lines in a row and checkpatch will complain.
> 
> Sure, v2 sent.
> (checkpatch didn't moan at me with or without).

Thanks.  You'd need to apply the patch and re-run checkpatch.pl with the
-f option.  It's not something that's obvious.

regards,
dan carpenter


