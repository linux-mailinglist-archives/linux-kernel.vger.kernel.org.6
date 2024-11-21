Return-Path: <linux-kernel+bounces-417321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 468A59D5278
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A99E284089
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD871ACDE7;
	Thu, 21 Nov 2024 18:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eI6U8O+S"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E42B189B99;
	Thu, 21 Nov 2024 18:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732213607; cv=none; b=p8nwYrK9ua5XnJRD5hrRog+Si81l7WEnPBUPVksEmhhYHUIgFwZbiq2pNWVw3tnVpTweXmZ6AtLD1+XhH2G4X02x3yULhXmBj4EV8RoOy9gO7cz4/JvGBRtfoUqrntkJb3wviZ+DXKlzjj8kH+4SQy4lUD/30MGpKCQ2puvY7Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732213607; c=relaxed/simple;
	bh=jJVlHXxkvOxMmOVSOLNHWjb0L09n1HTV9VN/a4Pr+Co=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKfnisM5zFsN1fmHKjqJuuUQzRgkkyMx62lnGEqw519ZzPnvkVPGK2amR23Z02fDbhF4+AP+RWrQGALUfaMIdhCCuXNyfQH40aWNPBb6RD4tJnRRw27gVhib/loYFEJxaIxQHKDzU47QU07dDHi8erTeKCZwPGQ+bBxm38LRxU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eI6U8O+S; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7f43259d220so1018914a12.3;
        Thu, 21 Nov 2024 10:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732213605; x=1732818405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SVOBFOKuqBGbfrg3WBc/6wZEOqghmHz/iJmzqxnnw8I=;
        b=eI6U8O+SEGb7wyaoQTZ1hiHyhEAGlH0qdSTpasoHs/9PWL3uUoA2l1fk/As0oal1xm
         j99XEuI4NrpsiO3ySn5C67Ewg6OD7jUgd2atG6jpjGBJDlgu2AjVwQaA13QVNfx58hHe
         XguvTfDtfyJEPNTDhkYPTEPgqW8poZZlyhOPcWFhqUoHOaIUmC6dwshdM5ZHn9oD2/oO
         cRLFazTEl7cU2PhZutfEcCElc7mxZU/UHZ8qsksf8WEcJ4//8aGgaVBVhLYnJwc1G5Ss
         o5U7D4JbsTS2JJa6i30vG7MZ8cVM+FLHXgPFGV+pVdUdeamyshvqfaiKlB3kszmQWvvp
         76/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732213605; x=1732818405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SVOBFOKuqBGbfrg3WBc/6wZEOqghmHz/iJmzqxnnw8I=;
        b=g4Ehuey6IXev11qzmnRJzZEDdHZh4WxA9+fmCDFek/rbWEcqa16T3mp40ZmTo2HYf0
         sAsMAGSFFcb8bRuPRva1UJrkZnTk+JgSCcV1acy2+6XlKIc3IAYGeCYnc+ILFHo4YWrZ
         s67Jh5ke/QNopXzFtlJig3LeY3EiMGCJP/Pn8tqEthfdnlrcPa9RZRpYOcJU/sMlUbQ0
         MhNMX6+2M+gmq8grZkP16NsxM97rJAETs16YNLSQqObr4mvW/X8JR5MB0Q1V/T8Z+gM+
         +Qc2ZpGpWWcJhr5TEEdiaA2cnNZl9FjEmjeCmwAjUSQXZRQgETPY4oOo3m9AnmnjFGXm
         cCzA==
X-Forwarded-Encrypted: i=1; AJvYcCV10W97inshI2R0PDUm/UKpBFtL/MB9/o9MKe8rJJxEO2lqO0oVphTdNp9vrs1GPUA/mh7oej7MxVmc6g==@vger.kernel.org, AJvYcCWNOCD9LGKu6NFec4pq+c/ecgcqLiRHrI/fTWOIWUnkQsxVdg5QrI69D0gExKfn+6HjGqziHoFhooFuaqIy@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2LF306ljwA+s6HOF6gtlmuVqo0t/NNH+YIPgW8NU/gzj/CYko
	5gGcMJgLqP18qVFFV71xUfubyNmg337q1DZ2Jj5dBBek7fFkzR6r
X-Gm-Gg: ASbGncv3B0ZrWGGxQeyOcaPNBzzc5C94IWNZzWQV/EUEr4Z1LbyfoW2e4Oo8OgMXAdf
	BR8bC4bQG2two7IpM+YjK1+vvM/UMugcn5EJ090hNturw6U4Moy1J+CUMz/RfRYnZ5f2B3TELEJ
	MV/MJdpNFjEgxIOp45JABQAwO3WsISJyOJB69jYA0Mf1fIapaiA70vsmmtuYbnGBPTeqzLtQV/m
	JSRoSFLuBB/pSAvjt14a0LtlpRT6RJWHUHJGJt6XksI9HR/IIBf8Q1/Kw495XI=
X-Google-Smtp-Source: AGHT+IH4par6O8k+Xi5rb1GPyYYMD7Avbr4dl/CNjcfGuleH0je1qkVYecwOYXAN7JtwdjwDFq+Hdw==
X-Received: by 2002:a05:6a21:6d97:b0:1dc:c1af:e7e1 with SMTP id adf61e73a8af0-1ddae5dc725mr10963106637.16.1732213605209;
        Thu, 21 Nov 2024 10:26:45 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de470c50sm70046b3a.74.2024.11.21.10.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 10:26:44 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 21 Nov 2024 10:26:42 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Murad Masimov <m.masimov@maxima.ru>
Cc: Robert Marko <robert.marko@sartura.hr>,
	Luka Perkov <luka.perkov@sartura.hr>,
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] hwmon: (tps23861) Cast unsigned temperature register
 value to signed
Message-ID: <c51416af-518e-477f-8177-2d39c6dd4dbc@roeck-us.net>
References: <20241121173604.2021-1-m.masimov@maxima.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121173604.2021-1-m.masimov@maxima.ru>

On Thu, Nov 21, 2024 at 08:36:03PM +0300, Murad Masimov wrote:
> Since the temperature is supposed to be a signed value in this case, cast
> unsigned raw register value to signed before performing the calculations.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: fff7b8ab2255 ("hwmon: add Texas Instruments TPS23861 driver")
> Signed-off-by: Murad Masimov <m.masimov@maxima.ru>

The patch is correct, but both subject and description miss the point.

The problem is that negative values resulting from subtracting 20000
from an unsigned value are translated to large positive values because
there is no sign extension from unsigned int to long. So the patch fixes
a real issue, but both subject and description make it sound like a
formality.

No need to resend, I'll fix it up myself.

Guenter

> ---
>  drivers/hwmon/tps23861.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/tps23861.c b/drivers/hwmon/tps23861.c
> index dfcfb09d9f3c..80fb03f30c30 100644
> --- a/drivers/hwmon/tps23861.c
> +++ b/drivers/hwmon/tps23861.c
> @@ -132,7 +132,7 @@ static int tps23861_read_temp(struct tps23861_data *data, long *val)
>  	if (err < 0)
>  		return err;
> 
> -	*val = (regval * TEMPERATURE_LSB) - 20000;
> +	*val = ((long)regval * TEMPERATURE_LSB) - 20000;
> 
>  	return 0;
>  }
> --
> 2.39.2
> 

