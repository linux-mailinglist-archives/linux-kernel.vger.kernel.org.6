Return-Path: <linux-kernel+bounces-369468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A18609A1DA8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0ADCB24AA3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD5C1D63E6;
	Thu, 17 Oct 2024 08:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CVuJiih0"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482521D63F8
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729155438; cv=none; b=kNIMo30vYwffnDxiql5L/WVWNF34hZsMbFFnf9haR24Nqod9AoOmUwlQbItV/jRFyGvTY/QwtUYxzYU5TgFrckmpTrdKXH3xYZqOca0RBQIUoLCMkbArT4zZ5lYRpBr0u8ZZ6l2d6wOfpAdCrMLnQd4jJ0k/0Evd1D68C9jQ0iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729155438; c=relaxed/simple;
	bh=iFSLKi+JqbE5QIXS1t+TmqgxzgU2rhTSmgEUGjgHdvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZyM7MfqhOhEZ9aYP0B2jPETTH0ogLhTm/IsU6u0XwiHjl+ot/+utWguK9hHIwFWIhxSHdtVNjWZHfrYCb2GGl5C1sHKgcsvOVETawRNnjMYXuIxXDwoY3xZiAVrEvbP2cNyCcPVz39Ij0gmXnK+1/VdIG568pj7ZiCNfArFBE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CVuJiih0; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c941623a5aso3148721a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 01:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729155435; x=1729760235; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=71u/2ImVUSG6tRSALKKCPqTPCxFY1jTTM2tTLu1wUA0=;
        b=CVuJiih0AV+QNOg20M84HWc1D6Qg8Qbp6RnfLwcnNyCCnml700FIog2+QQxmVLA9A1
         RQnpEf5aQukcTvuEKCTCBm+pOqDnaLJVnxE3Bsui/OCpBRXW9Hu+caQdbcn3d4K5YNUM
         hUVD58XxbwBt5V2Phkgv5bTX72ADoqe0ZuYogtT/C11dmRcFoiYhJgrAYhglLkd4pDEs
         OO+exGwF19yxR0G7QRKtTCQGGTUVGuHcyuxPX2W3XOHVPpTHLDtfhU7UWAdAy/1EfG1u
         JqZAYlutiouwgOV2Kgyu+ETmFwdPFXfdpDJyDWmIBiFrgTTWPTTudPaYzdyXlIHjsLaN
         4lfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729155435; x=1729760235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=71u/2ImVUSG6tRSALKKCPqTPCxFY1jTTM2tTLu1wUA0=;
        b=OdJ1kIwXnuGHxVGHeJCyykUsLWyQtnZybxJ68MleMlXgqSlbGXdTUSqvNBa+94kGQn
         lspYgLUEgLxdKlgwT3OLHksc+UylBWmCOGjqHmRs7SeC9t4Em3s1FFMuAvB6NTX8ejNq
         3fyMsF0mFMZHCVnEt+L/XdlaFeC1jXfSIKt29oVyZXmPSf1PQUrek7aes4XsKdQk9y83
         n5w/D5OQ4vT7xhulUt/ChCHoDg7T24X9K1aerJTKQ6CpoJZ574PuqqsDowo9S8YD66iL
         xjnw5vXh3zEPq8vc+AI6R5NUGh0QcGyujkAt4J36vYijM314UgiNrr6oK77U7Cyijztt
         IBGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7C5A+50gxQwFYrUa81LLaF/m9Gu5XhE122aWUV0F1t2ekuF/KInIgH2m9pix5r8GWV6PnoIr/ibWObGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoGOfJZlO/X2ziHz/7GC/ahNujBH1YmdbsOFYqBj4WEQ2PyZO6
	ZpJArfAszXJLIuFRlwXFvnVcYWAmvD4+mmYW7qVw9wgUtKiWjYkS6bFTuHdC6JPtEq3a1NDz/mE
	I
X-Google-Smtp-Source: AGHT+IGYYEqktdQg4/62lwG+WcVcV3tKvLYkXGKPRL6l8VihPBEL2cH/36Xj6ngD8Ie71PGXZIKeJQ==
X-Received: by 2002:a17:907:3fa5:b0:a99:fcbe:c96b with SMTP id a640c23a62f3a-a9a4cc3aaacmr224024166b.25.1729155434615;
        Thu, 17 Oct 2024 01:57:14 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a298173c8sm268786266b.123.2024.10.17.01.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 01:57:13 -0700 (PDT)
Date: Thu, 17 Oct 2024 11:57:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Colin Ian King <colin.i.king@gmail.com>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] scsi: scsi_debug: remove a redundant assignment to
 variable ret
Message-ID: <a2515a3d-1dbb-48b6-a489-25aba3358068@stanley.mountain>
References: <20241002135043.942327-1-colin.i.king@gmail.com>
 <2be706cc-0944-4413-b1b0-52d34fbdadf8@stanley.mountain>
 <9151ca6d-7153-4a97-aaa2-7277fc5ffa84@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9151ca6d-7153-4a97-aaa2-7277fc5ffa84@oracle.com>

On Wed, Oct 16, 2024 at 08:16:16AM +0100, John Garry wrote:
> On 02/10/2024 16:10, Dan Carpenter wrote:
> > On Wed, Oct 02, 2024 at 02:50:43PM +0100, Colin Ian King wrote:
> > > The variable ret is being assigned a value that is never read, the
> > > following break statement exits the loop where ret is being re-assigned
> > > a new value. Remove the redundant assignment.
> > > 
> > > Signed-off-by: Colin Ian King<colin.i.king@gmail.com>
> > > ---
> > >   drivers/scsi/scsi_debug.c | 4 +---
> > >   1 file changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
> > > index d95f417e24c0..7c60f5acc4a3 100644
> > > --- a/drivers/scsi/scsi_debug.c
> > > +++ b/drivers/scsi/scsi_debug.c
> > > @@ -3686,14 +3686,12 @@ static int do_device_access(struct sdeb_store_info *sip, struct scsi_cmnd *scp,
> > >   		sdeb_data_sector_lock(sip, do_write);
> > >   		ret = sg_copy_buffer(sdb->table.sgl, sdb->table.nents,
> > You would think there would be a:
> > 
> > 	total += ret;
> > 
> > here.
> > 
> > >   		   fsp + (block * sdebug_sector_size),
> > >   		   sdebug_sector_size, sg_skip, do_write);T
> > >   		sdeb_data_sector_unlock(sip, do_write);
> > > -		if (ret != sdebug_sector_size) {
> > > -			ret += (i * sdebug_sector_size);
> > > +		if (ret != sdebug_sector_size)
> > >   			break;
> > > -		}
> > >   		sg_skip += sdebug_sector_size;
> > >   		if (++block >= sdebug_store_sectors)
> > >   			block = 0;
> > >   	}
> > >   	ret = num * sdebug_sector_size;
> >          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > And that this would be a "return total;"
> 
> Right, the function is currently a little messy as there is no variable for
> "total", and we re-assign ret per loop.
> 
> So I think that we can either:
> a. introduce a variable to hold "total"
> b. this change:
> 
> diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
> index af5e3a7f47a9..39218ffc6a31 100644
> --- a/drivers/scsi/scsi_debug.c
> +++ b/drivers/scsi/scsi_debug.c
> @@ -3690,13 +3690,14 @@ static int do_device_access(struct
> sdeb_store_info *sip, struct scsi_cmnd *scp,
>                sdeb_data_sector_unlock(sip, do_write);
>                if (ret != sdebug_sector_size) {
>                        ret += (i * sdebug_sector_size);
> -                       break;
> +                       goto out_unlock;
>                }
>                sg_skip += sdebug_sector_size;
>                if (++block >= sdebug_store_sectors)
>                        block = 0;
>        }
>        ret = num * sdebug_sector_size;
> +out_unlock:
>        sdeb_data_unlock(sip, atomic);
> 
> 
> Maybe a. is better, as b. is maintaining some messiness.
> 

I'm happy with option a.

regards,
dan carpenter


