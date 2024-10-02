Return-Path: <linux-kernel+bounces-347779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFB898DE7F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF2931C20BBC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D3A1D094A;
	Wed,  2 Oct 2024 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cQgW+PWD"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBC41D042F
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881832; cv=none; b=cbB+9vf89W6hwo4/8I1EX+vxTlbXvzeWo3/qs+LWh8gu0H1NK2RXJUeBLkna8IhF3TqphEm4E0x+CHpc/FfwCQYu4LVQ8ar+TKBP8hyg4u31VLhaZue7+mIZgrklCaj504JfUlsJt2folGogGJWCNynnZVE2bnjQaMGLbOqY13M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881832; c=relaxed/simple;
	bh=Jv3BSoSXayHjJO9mpfCrUpTwrBajht6DBRvNIgM8Cgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tuwe9l8zVkjge/krqUQAsbBzIRTt29C//NALQt6/0JPV817oX1o95p6jbHdUiScOR+isf5GEtf8SIhPUgVtaojVCU95ew7fGTa2Y1Cc7MsqRo4zD71Mg344kFzPe5hFeQnL0UYStTYMaRA9vgJBh76hg+GtYPcw4XmW43w+BH/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cQgW+PWD; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42ca6ba750eso6513835e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 08:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727881829; x=1728486629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ytY+ar77BVBH0wQTJr3+McPNOBDHSfuoaIXrHTvJfgk=;
        b=cQgW+PWDm/QWe33Nu3WbgBXc56bwvAbqWzHKm35UVEseqPzLKnA3P34NDW++EmBelq
         GTGz9xCQsodpNlgXWeXYwKPR/4kECH0dT3gWlv648XvExP67OQzSoaBrLiHmFmhZ58mO
         IbkOEwqA78Dn9wpsrbcRmX+clzn+BnH3dRWgOlQ1IRuthdGX+Yo0vFmaOzsFNOkqbgFP
         zDqBQhAkaUOZXj886gUAhiejWcsZ27Uo3t5ZBm4aCnqTQi3CdVhxPqVrOPMVJ4k9Nwxn
         e6VHg53vmE62/L9W1abyEFqzJ76q+LCohUs9PW2c45GO26np1ArfG31Wx8EfYQo6i35z
         4AVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727881829; x=1728486629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ytY+ar77BVBH0wQTJr3+McPNOBDHSfuoaIXrHTvJfgk=;
        b=NU90O4AAgYFrPY4oq+CNqOtndyH+WlQX9Jl3a3/LwKnxeqkYABYP+4afksyfqV+0HC
         QudzBJQSO+YQvbh0FqMw+RRa5FagecegZpMOz2M0IsesuR26yyyhBhzplIXvjFbjGLVq
         laPuWT1XGSw0zXvLUnTp2v0bqFuj5DnE4Pazl/mERnmnEuXyLWOV3tcR/qVsS/u1zyzE
         SlSL+zFvNoC8Hww26fItTndlSF0QjmOcGiIl/TcWmpLnGT9br3J6jxlE1LczU7EeJJ+6
         3UC5uRuptjX3KFajaXrDGWjHY2Q/irpVe+tJJNxwc2ukogltF1VNN6QGkM/kDmCs/5Pn
         eRIw==
X-Forwarded-Encrypted: i=1; AJvYcCVZv0H37DO0rVSHpMVVA6r689utft0Fd49nHBF6BtfnU2ay6+jJKTiAnKmWh3HlasrtkLUViYU+WDFUims=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK/uHZ8EnJqsmnYIL0J2HkBt0ChLAE9So+PiyzrGtADUFlR4tK
	nZ1GzcK1/M3FssJueJA0tbH6YV77t2WCuC3xNkDSJcQbfVxZXRbmlIspW4ueXZ4=
X-Google-Smtp-Source: AGHT+IHF7zqlEp9IeuwLJShnugMExSE1H16YmOR5aR1iwh0hK9YSmm+5poKeibk26oOuuEuWUsBUkg==
X-Received: by 2002:a05:600c:3b9a:b0:42c:b377:3f55 with SMTP id 5b1f17b1804b1-42f71306ff6mr43518465e9.3.1727881828851;
        Wed, 02 Oct 2024 08:10:28 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79ff6857sm20844225e9.36.2024.10.02.08.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 08:10:28 -0700 (PDT)
Date: Wed, 2 Oct 2024 18:10:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] scsi: scsi_debug: remove a redundant assignment to
 variable ret
Message-ID: <2be706cc-0944-4413-b1b0-52d34fbdadf8@stanley.mountain>
References: <20241002135043.942327-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002135043.942327-1-colin.i.king@gmail.com>

On Wed, Oct 02, 2024 at 02:50:43PM +0100, Colin Ian King wrote:
> The variable ret is being assigned a value that is never read, the
> following break statement exits the loop where ret is being re-assigned
> a new value. Remove the redundant assignment.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/scsi/scsi_debug.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
> index d95f417e24c0..7c60f5acc4a3 100644
> --- a/drivers/scsi/scsi_debug.c
> +++ b/drivers/scsi/scsi_debug.c
> @@ -3686,14 +3686,12 @@ static int do_device_access(struct sdeb_store_info *sip, struct scsi_cmnd *scp,
>  		sdeb_data_sector_lock(sip, do_write);
>  		ret = sg_copy_buffer(sdb->table.sgl, sdb->table.nents,

You would think there would be a:

	total += ret;

here.

>  		   fsp + (block * sdebug_sector_size),
>  		   sdebug_sector_size, sg_skip, do_write);
>  		sdeb_data_sector_unlock(sip, do_write);
> -		if (ret != sdebug_sector_size) {
> -			ret += (i * sdebug_sector_size);
> +		if (ret != sdebug_sector_size)
>  			break;
> -		}
>  		sg_skip += sdebug_sector_size;
>  		if (++block >= sdebug_store_sectors)
>  			block = 0;
>  	}
>  	ret = num * sdebug_sector_size;
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
And that this would be a "return total;"

The comment at the start of the function says that it's supposed to return the
actual number of bytes that were copied.  And you can see how that was the
intention.

But what it actually does is it always reports that it copied the complete
number of bytes.  #Success #Woohoo

I wouldn't feel comfortable changing it to report partial copies without testing
it.  Someone needs to look at it more carefully to figure out what the correct
fix is.

regards,
dan carpenter



