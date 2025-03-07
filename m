Return-Path: <linux-kernel+bounces-550791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A754A5642D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 10:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96AD51892584
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD2C1E1DEE;
	Fri,  7 Mar 2025 09:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VM/8RCV+"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0151E1E04
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 09:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741340718; cv=none; b=gNiSi/3SEE7iB+oMorvovEcAc4C5XCXDUaK7cIwwaeb5ondz17/rKrqJUom3JP362pssHfM3XkfHWzTd2AYajOTlAivPO/mv9pkkgWLTeL65po+xdVx3g+nQSkqlfKxK6DL2utLA7AfsByzmDI4Mb7bISXFyq+GbF1eS1CCY3Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741340718; c=relaxed/simple;
	bh=LgETdORplFuf5k5ZwoeGPwHsLIExzbInj1MLRN3nQ3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3Pss0qx2u2TJEjdaiLzWEZvTT4EnSUpH68Y7LZaMGYJGLZ1XlAbTN9s/njrluJYXND5Pfc9AtB2bs5xnoP+elbr0WEYIVVoyZuQYRjZvOUeRV5nb4FE9BmtQNSm4wmdg7aj2CHkGqB2YQS73Ul6Jjj+71RFVIyN2vRdmAAdI9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VM/8RCV+; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43bdcd0d97dso9159005e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 01:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741340715; x=1741945515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HRkqGPwhP//aPW7BEk/ysV2uJJntAYyCBQb2J1lFSM0=;
        b=VM/8RCV+Zw3rtZq0fxE1EJ/m14wLlwh1mC+phWW/UBVCBBU2FPm8xHHEqvJoQdwmV7
         HDpzxg1ljuKSRXTDU3S6KI8knJBk0Op1kggdCXX6FRS4UcOnSbFuXeooULbTp2Ny2fnk
         VbxEm+8ULBUxAwMLyqRlSUxfeUPBjglKp0DRdPN1+Aot6WgJF2P7mi90Wg3D0Pr3rhXt
         zK0h3lwLvY8Dc3McETNHIXD/zBFD9VZb09CBrU3nbLNfc9uPya7ZgBfr5GykX3PKzaAG
         ZLEKJPf37GxFB4nkV3520dwpjCMSB7iuHKsgnZrOaP7aoWRV9NgrzyYOK/zPrNBF/AKr
         atuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741340715; x=1741945515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRkqGPwhP//aPW7BEk/ysV2uJJntAYyCBQb2J1lFSM0=;
        b=HD8RaS0mT4aFLCCZw/9shnkrfKai9DcCKDePqQJwrT88R+3OEmuNMe2uwvr32Ko6Ys
         Za3Xmou5c5TeP+xOZ5vyTU5X/Div6d2xvgkgRFsH7KN/5+BAL263g7Sjjd2+aar302tC
         B2exGH742jA2Pw0oSdm/C0hl3UVpg0aEOQ125AligoVsQnaW0H1SFmka4PDuUfjgPIVX
         /N+nR+gv1OslwwngnwuLwq5N9/gpnLpBXnWA8U23gv4G5CaipzoQFpEvFryB9NrAZrtQ
         NXqRuvC67YjCAqhsGhKtqbZOGhIN5OnsM8W01ZOrSqgYUrGHzZV8OWh9Et3z3nUVWB8d
         Syig==
X-Forwarded-Encrypted: i=1; AJvYcCXX24IOgyBSFc6yITLKnk/r4C7nr5xaMZzIq3S5Ilig1C5hmwcBxoZxh5SfH36CYRCyOSV0D6N5IQT+P8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw49vEP+hL6qm80FplEwk/LJgge1FmUAT5lVDEpQyTzEXcQZA6y
	PHDAD4NWGv+yZCGc25TWB8E8xUgvNTTPNa9nV1WoDwizO0j0BctIrdeVmNy77yw=
X-Gm-Gg: ASbGncsl95DBkDLLI4eWVwtIsttEG3K4NHcFB+f9bDemGpMrMptbQ/PCCoxUCAahzRo
	5xPVo/PHxf3Jta78VPZEWAafGy/7qwJ7IsHwsLaHk57MrAPK1gtQH9YE3vOvRgQ69xe9byb47Y6
	lEx8BX9czLm5n+v8mV6V4niYpzH3mWwJChr8edtFkLRn1gncTL2HisoQYdWaPQJebLzDyAVS2Ja
	w6No6/oporFijT44C3G5jRhjKrWtG84qAMG7h7Mys1PJ5JGrubLoTYQPlK7i3spExwb//RMr2fC
	aygvfhTmB22Es7lgDLq7JM/lhEuP8eDz0jQAcfRa4wJ8/hjRJQ==
X-Google-Smtp-Source: AGHT+IGg8GvzE5Z/w3SPJ6HUWguNYWIga1jjbNiYACDEbFNuFPDlZsOtxem0jVkPwhDdthxVtoTDMw==
X-Received: by 2002:a05:600c:1d01:b0:439:a138:1d with SMTP id 5b1f17b1804b1-43c635d4fdamr16521205e9.22.1741340715159;
        Fri, 07 Mar 2025 01:45:15 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43bdd9470e2sm45894145e9.33.2025.03.07.01.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 01:45:14 -0800 (PST)
Date: Fri, 7 Mar 2025 12:45:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Shreeya Patel <shreeya.patel@collabora.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Dingxian Wen <shawn.wen@rock-chips.com>,
	linux-media@vger.kernel.org, kernel@collabora.com,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] media: synopsys: hdmirx: Fix signedness bug in
 hdmirx_parse_dt()
Message-ID: <4a50949d-e472-4942-9152-3e5a54c6b076@stanley.mountain>
References: <7ec94789-305c-4de4-b477-c0eb839170e5@stanley.mountain>
 <54d5eef8-66a9-44aa-9e9b-0324d6fee46d@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54d5eef8-66a9-44aa-9e9b-0324d6fee46d@collabora.com>

On Fri, Mar 07, 2025 at 12:36:47PM +0300, Dmitry Osipenko wrote:
> On 3/7/25 12:30, Dan Carpenter wrote:
> > diff --git a/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c b/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
> > index 4ffc86ad6c35..e0d3fed87a92 100644
> > --- a/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
> > +++ b/drivers/media/platform/synopsys/hdmirx/snps_hdmirx.c
> > @@ -154,7 +154,7 @@ struct snps_hdmirx_dev {
> >  	bool hpd_trigger_level_high;
> >  	bool tmds_clk_ratio;
> >  	bool plugged;
> > -	u32 num_clks;
> > +	int num_clks;
> >  	u32 edid_blocks_written;
> >  	u32 cur_fmt_fourcc;
> >  	u32 color_depth;
> 
> Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> 
> Would be also good to return the original error code. There is no need
> to check for the < 1 clock, it should be the < 0 check. Can be done in a
> separate patch later. Thanks for the fix!

I'm not very familiar with th edevm_clk_bulk_get_all() function and it's
not documented.  But clk_bulk_get_all() does return zero, so I can see why
people would be confused.

regards,
dan carpenter


