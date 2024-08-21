Return-Path: <linux-kernel+bounces-295518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9318959C14
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 609601F2306E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070A718FDC2;
	Wed, 21 Aug 2024 12:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bxv/P5bZ"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9027C18DF7B
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 12:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724244104; cv=none; b=AN/SSujrvLk/vwnWa3uwWjEfRe/K2xFeYmseqL74hZguWH+DYyop5IEFKbB0WOhUaWnCSLu0iJ+ooqjHiAbQKyuvsPAjHyjZ1ONQARe+bVP8dJCsqZLurYhhepZFYSWNMb5Av9lmjOqCWqhrHdbddtqILCY1oZaV+KN2hVEskiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724244104; c=relaxed/simple;
	bh=m16333NuJhUKjmerK+UI1er6zEkuRWI+HCGKrjtXjpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irm9ISrKNr3zzZXAk+MBh4PFT4WCdgPD2wr9u6xm+rrxSoLyMdjFapuRJ8gxU3+OfsbjAmuALDuGlgEuq6dhKrljZw2hMvyKYQVIw/zQZRAGniJGgXIwvOQgyahqwxZckfIENBYDEjXJcb3HIqiht6GaD9cZV/Z8XIBE4LkAxTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Bxv/P5bZ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-533488ffaebso840813e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 05:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724244100; x=1724848900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SzSNA3O6D+/pcx5BIDsspBVf4kVhsiP9gRRBtQXDenU=;
        b=Bxv/P5bZRSnHjsfe0M2F9EdOo5peRnbZI1gLa5w7wMIcXnGAS63802DG+HYpet1c+u
         WxpgpY0bTtngqGSsPlD/Umo8BrNANzHj+bFTa8CDEAl9qU1dwYpmMEdf099X/nhvf/07
         25HScXdQR9Usyj2I7Fm2Let5j5feZarKJVrz8HuEhVYNERbUqz9bJ3XG44gLQ1MbMe59
         1MdS4BaXXz8pWA9tf+Maz8l3g7qChF5mJeCfTjubmQCIuNtHw1j4LcCQxmb9BjrFZX8X
         6vecdTw98cJFCVMvEsfy6W6HcNt6sqydWMmLx2cxeFC4uhVgTVNOwGmgCcCdtdcMDkzT
         XLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724244100; x=1724848900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzSNA3O6D+/pcx5BIDsspBVf4kVhsiP9gRRBtQXDenU=;
        b=jYSnVgXkryqEIPLBnD2Pn4CNHdZHe2rOa3xJl1jlukxwUYzysDBGsX0Itovhcmgcdw
         dCOgtsDmYr4DIAjXP4izsiAP53gQ6VnlwNix1GtFZq+EI1UiO+biHJyvY/tC0hL8BhTj
         1JuaJslJH+4UYJdzkxs5YDwmWCcD/4hsQa+YzpvFRPL0URX8s7+vqpJoitBF6qh30tes
         cu22qdDshRsP45fQIP+3XvIK9n2jRLVaUoOzbFyxtjXAmeekr5eWDptw9JoAnwOuDcB5
         RXWC+YSS+lLzRKXzVW+hp/eLd/f3lY7DMqCRrwoqZvBuN4xMGEfbHiGBZEonMSR3oQhj
         HMng==
X-Forwarded-Encrypted: i=1; AJvYcCXA8fwu6zKjAPFtf3P4WLGDaSB+tjTLOVYjbgfSmwBWdyC0cW2iBo0RJ8aCH+LUvsy0wViEv41ZGHygPcU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh6AUyinrgkp5tD+aF1klQHgdvKWDAVCjWR4NTnzvkgz562M4A
	pfMtDezQCrNHAJysMHek/adKrho9U5Ew5nibfN8BSngR35h8s+D9sOj/uZGVFIFvIlG/a+sO2jZ
	v
X-Google-Smtp-Source: AGHT+IH/CV+hS9wZfJjWFZV+IAy/2IlRdv5hZPgV+hFkCpXcZ9iM7teRb2qcEyyJmrmoGnVcX1Jtmg==
X-Received: by 2002:a05:6512:114d:b0:52e:9f17:841a with SMTP id 2adb3069b0e04-5334857e1bdmr1477124e87.6.1724244099456;
        Wed, 21 Aug 2024 05:41:39 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a864083fe11sm261055166b.4.2024.08.21.05.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 05:41:38 -0700 (PDT)
Date: Wed, 21 Aug 2024 15:41:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Tree Davies <tdavies@darkphysics.net>
Cc: gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com, anjan@momi.ca,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] Staging: rtl8192e: Rename variable
 CmdID_WritePortUlong
Message-ID: <2f440b36-f771-46f6-90bf-9f0a6112d09a@stanley.mountain>
References: <20240821030856.57423-1-tdavies@darkphysics.net>
 <20240821030856.57423-5-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821030856.57423-5-tdavies@darkphysics.net>

On Tue, Aug 20, 2024 at 08:08:54PM -0700, Tree Davies wrote:
> Rename variable CmdID_WritePortUlong to cmd_id_write_port_ulong
> to fix checkpatch warning Avoid CamelCase.
> 
> Signed-off-by: Tree Davies <tdavies@darkphysics.net>
> ---
>  drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 2 +-
>  drivers/staging/rtl8192e/rtllib.h              | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
> index e82e992dd139..8a1aac7e10a2 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c
> @@ -616,7 +616,7 @@ static u8 _rtl92e_phy_switch_channel_step(struct net_device *dev, u8 channel,
>  					_rtl92e_set_tx_power_level(dev,
>  								   channel);
>  				break;
> -			case CmdID_WritePortUlong:
> +			case cmd_id_write_port_ulong:
>  				rtl92e_writel(dev, CurrentCmd->Para1,
>  					      CurrentCmd->Para2);

I'm not a historian.  I know that writel() writes a u32 value for historical
reasons.  But I feel like it's unexpected to create a write ulong which writes
a u32.

regards,
dan carpenter

