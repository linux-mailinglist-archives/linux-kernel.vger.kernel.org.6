Return-Path: <linux-kernel+bounces-372889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AD89A4EDA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 16:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FD561F227B5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 14:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D71E623;
	Sat, 19 Oct 2024 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Il3pnvk1"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B69CA62;
	Sat, 19 Oct 2024 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729349429; cv=none; b=I7lZ8Xri3mD7IITsg+kda4jvLX80knhOEBc2XfAWo1vcvG2WzrRZxrpCt3akZE9XbRtIfRs6MXg2cTYPlS5m4xmSybLYdBRuVZqMdv4vggxvxW6YzTaRog3T80IyMDmPZW2oQVdYEEoKlryGuXFStAaDkcn8fVAP+HtgGfhwMp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729349429; c=relaxed/simple;
	bh=iVz9MgFDqW3A2okj7PFLlo6OP0zu7aS8cV/I/kkg2oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgxCIgiL65LWzEBncynr/bb0nJbYerXy16Zy7+x0UB0zsO6rHPrGPL+V+oafHjYtL39am2CLBs8zlcnp2nLxwVb8+raxYBc9/lDyRsQ4ltccCT/C4yAT/4lMmi9c1OTy3/BI+F855VnMVC6T3VGGQ1C8fLkafRjjbX72u18d+yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Il3pnvk1; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7ea79711fd4so2182376a12.0;
        Sat, 19 Oct 2024 07:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729349426; x=1729954226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6AGS1Jx8tq8YrSq6i+8D80WTBqFKEiXsMIaXzasi12M=;
        b=Il3pnvk1FTxpGP9mMPAbkQgJ9KSQgdkQtkXQa5u1s7wK12CkKtx07KW5fz8Yifpucj
         PnWs/QSdwR+GYMQqFqWWoRNUuWIIiUB93R1WMP/uTNGogICs9K1q+Rzk4SERwIitQ2t4
         7hHKPT2cmJlYT/RGgApqLzqWIBubopq6KghapQv4EmY/f4MBpytu8Swqlz5kpbFJgPf7
         LHcL4kL1MsIqioYljuQM+pIuSF40nYyTuLibUx/EhDxijs2XjoixmYrgCPhk6XF/eDs5
         EsLoGCXVeY3qRDgcqf8llSTYvY9LuvVeynuAR859u+VZXYKTsM0KUpDOMRGaDXJkdTlJ
         PxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729349426; x=1729954226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6AGS1Jx8tq8YrSq6i+8D80WTBqFKEiXsMIaXzasi12M=;
        b=jGUi8bUTMr5l9wVn6rbFPtXo2oYPpG1DvNt3p02MTQkBtpQsGw8xjrMNCQu/6GB3zH
         8wr5B8Z/IGdz5NnNDYd4XH+LPuaaWakyUEC7VdtS4I6adJDvT1y53gC7GB1q1vHaKIQx
         1kkULTNXKIR8PX1Ui3J7SD5aZePNGMg31VPEhkWlBTkF6277jXyxz3erhS68OH07aqpf
         40bz1qvaP8a2pPE1AjLry5P52ZZvQT/FpAQ9ZVxd+AwtM5UWyXluE5ylHJ7hj72mgnFs
         cg1xjHVEyIwuz8O0mm5OELDTB4gJ6xgTgNkEybvNypqRZJDiOU15iBYGleOLnfNglEqw
         gL9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWa77he2YAbLsRmDwkOMUY2d5r1HyNMK1+umlQ9APAsxZJ+E95Cj4Tzrwfo3XRRBc0itLj07NiAbwJ4Gw==@vger.kernel.org, AJvYcCX60PTzhABH4HCl69QYTJbdEvvCjnLRcB3/GvA4L35wQBxvZKJSnVcV4kbAau57jo51Bgp9ZyHdHkltQPuM@vger.kernel.org
X-Gm-Message-State: AOJu0YwnYTyEzmYwu5YrvQdKIjSxKY1abZA1MNNF/c40PhSOV3/5t9Lf
	IYgb3hq60o28NnQ+a0eHwGe/TjpsvvTvsfQwpKvN/qJBLewkPR1S
X-Google-Smtp-Source: AGHT+IFulnTOKSv16HDWOrAKdLTgTfBvU/wxmswCO5o+Dr8IHN5ycrX9m6F/8/FuigU+FR6P8iK27w==
X-Received: by 2002:a05:6300:44:b0:1d9:2a8:ce10 with SMTP id adf61e73a8af0-1d92c589082mr8798183637.34.1729349426098;
        Sat, 19 Oct 2024 07:50:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eacc20d2desm2605420a12.7.2024.10.19.07.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 07:50:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 19 Oct 2024 07:50:23 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Sarah Maedel <sarah.maedel@hetzner-cloud.de>
Cc: Jean Delvare <jdelvare@suse.com>,
	Tommy Giesler <tommy.giesler@hetzner.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (nct6775) update ASUS WMI monitoring list
 665-ACE/600M-CL
Message-ID: <cc353c75-8bda-4f28-8844-b1c9a006be93@roeck-us.net>
References: <20241018074611.358619-1-sarah.maedel@hetzner-cloud.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018074611.358619-1-sarah.maedel@hetzner-cloud.de>

On Fri, Oct 18, 2024 at 09:46:10AM +0200, Sarah Maedel wrote:
> Boards such as
> * Pro WS 665-ACE
> * Pro WS 600M-CL
> have got a nct6775 chip, but by default there's no use of it
> because of resource conflict with WMI method.
> 
> This commit adds such boards to the WMI monitoring list.

Use imperative mood:

"Add those boards ...".

or similar. No need to resend, I'll fix it up, but please keep it in mind
for future patch submissions.

Thanks,
Guenter

> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=204807
> Co-developed-by: Tommy Giesler <tommy.giesler@hetzner.com>
> Signed-off-by: Tommy Giesler <tommy.giesler@hetzner.com>
> Signed-off-by: Sarah Maedel <sarah.maedel@hetzner-cloud.de>
> ---
>  drivers/hwmon/nct6775-platform.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hwmon/nct6775-platform.c b/drivers/hwmon/nct6775-platform.c
> index 096f1daa8f2b..1218a3b449a8 100644
> --- a/drivers/hwmon/nct6775-platform.c
> +++ b/drivers/hwmon/nct6775-platform.c
> @@ -1350,6 +1350,8 @@ static const char * const asus_msi_boards[] = {
>  	"Pro H610M-CT D4",
>  	"Pro H610T D4",
>  	"Pro Q670M-C",
> +	"Pro WS 600M-CL",
> +	"Pro WS 665-ACE",
>  	"Pro WS W680-ACE",
>  	"Pro WS W680-ACE IPMI",
>  	"Pro WS W790-ACE",

