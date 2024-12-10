Return-Path: <linux-kernel+bounces-438720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CC39EA4C6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 03:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B66C0286D33
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 02:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD5D1A08B8;
	Tue, 10 Dec 2024 02:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERHu3fZA"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C071A00D1;
	Tue, 10 Dec 2024 02:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733796589; cv=none; b=XxBoCkgum9aCg/0KPosBPd8f9kQdToVKUoT+QgQwihG2KUMajhGT9m3aNppjCHIT4BnFJt0OQZ6Bt0EZYhdpmlwq4pUAt+li5mq0KG0YgXLJAiABI3e30cVqpVfVRZkcjZ8r0YgY5pt0m9ldJgeMwLR82LqmBpnjxRX32CyY9nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733796589; c=relaxed/simple;
	bh=qOvfYA759DPRe7GNwSB7MtUNXK8+AZGM1l2mHLcOCYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYSOUOCOC36pmWMavjrvkFcT7bRW4Q6oGulmqsTx3LoVd9F50qMah35gJw4af9KPvVpmWy08vy4CnaQrEDyBiuWuSWPxBC3pIRVMXw2lJ+wjkknMXgCrqwH8EvWW9gPZNcVIkxAnqe0Rcw1EyegPaaRVvbxdgcNNGOmdeoMIGLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERHu3fZA; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-725ee27e905so1804628b3a.2;
        Mon, 09 Dec 2024 18:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733796587; x=1734401387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=glTgr8+oUYA2O9O1whKQEqIJDaoSkhfnc84RuCSaXxo=;
        b=ERHu3fZAbBZkGnycDeeh5fH7W5N9AahqvIyo6u0N87pNvWxtBJzkquyPFwb4RHiiwy
         oyqCiTg0F5HweJ1Fh3qtkSHyL4yFDgsuxrAZ3+2kf7tbqGmV2SiDiZLoByawlIO6YfJ7
         rr6sBuTOqFZdbOqa3Szto1B8pWqXhkKWBabxDZzAFZU0VSxlVUYGSYyzN8rY1JsO/rgG
         KwbuzYKa7+erBpmRLdD2q1+DUsiYly0plCu/x3l3f90+1kkoQqTubMEIllmLZMyolB4A
         EgFtKB4BERnGMkxVDQz5bl9Ypt3CB7KFF15htKyyDNFs+BbFaz8kweKdOUGueXnCTn/0
         50jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733796587; x=1734401387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glTgr8+oUYA2O9O1whKQEqIJDaoSkhfnc84RuCSaXxo=;
        b=rJcRIYL40Vj5LDXV5GYPLDnSZwdzDZA1Ot5XNyn2snh30wynZw3kcoUyDPkOJWT7OH
         VlLhnz9/R9bg71WZ4VoxHofcmnWd3iaDmn+SUQR329jejT3UnSJOqyKugKEBzs/YJOQ7
         zGUxSI4lmbH2bfRQc9r295aO8tr93NLQrVGsgWzOGOIoGria98AnQF+PsaRTiPV1utBp
         jSIDu4IjE0iI8dwN5hWlvjq3rMogCs+nFH3MPwi5L1lAvfaf/OrnVxXLJ/5IevbEY9rF
         O4L3uZANm5hL7L6trwGtUc0nIhobBUFlgn1dmfNnVgMlboJBFSEeJBKjdvssfwXyJX0x
         YelQ==
X-Forwarded-Encrypted: i=1; AJvYcCVN4c18y3D9mAz91Z/R5aXk9CUSRhl4y1pNbcz124m7BVgl6bk/Sb8C9uilF2cOG1cM0eXk8KrBhqiznFqF8SrBZWP8qQ==@vger.kernel.org, AJvYcCVODwInM0KbbCjyJKzICCITYkoMHzS4dLE5UAAPt3aCEuAvT7Z+8Ih4Yk0oSRd3E+k67s4CMJpdSCy0h4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH5+h9HbK3mD3okUpQfj99Spu8JtUYqnyJnjxqnmr/cesmY/XG
	GwWRgwbgazg52i9++wu1/4JuyR4XFAEYubCTYQ4FDZ2EAiNxUBTX
X-Gm-Gg: ASbGncukSOtO2fYkM0ZD03IWpScsP7j2diYNtvUVArArn44eKkZS72khS7x/+CM6nGb
	cj9KjWvlBiQNf0kxhUlQhOa83ufE9ZOxkUQtoQ1tpLryQPhtY5aMD56BaqHFMjO1geoL2lgybgh
	qmFKGsfgZ6UZn6lDfnKHLUfCMQViQywwcjjZPNlpVbjb6HJ6R0cJlJU2SBZBbNCr//QTc/jtPjH
	L0JZPpg/ZfqqYgK/9F1ws0HHCzWTJHirwDwxWGmR9hhlddnR4brEHcgjHjuRY7PGdCC5YlhixVK
	PYOz85g/DXGU
X-Google-Smtp-Source: AGHT+IGtpFNPc+Kwcdqcxh831JZ5M1yxD0yNP8kp7tjDVoTZhzi2r+GlPAa7VLqtINu8UMrpCQKpag==
X-Received: by 2002:a05:6a00:4b50:b0:725:df1a:282 with SMTP id d2e1a72fcca58-725df1a17c6mr12089172b3a.10.1733796587538;
        Mon, 09 Dec 2024 18:09:47 -0800 (PST)
Received: from alphacentauri (host111.181-10-101.telecom.net.ar. [181.10.101.111])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725ede70e4dsm2599555b3a.93.2024.12.09.18.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 18:09:47 -0800 (PST)
Date: Mon, 9 Dec 2024 23:09:43 -0300
From: Kurt Borja <kuurtb@gmail.com>
To: Armin Wolf <W_Armin@gmx.de>
Cc: jlee@suse.com, farhan.anwar8@gmail.com, rayanmargham4@gmail.com, 
	hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] platform/x86: acer-wmi: Add support for Acer
 PH14-51
Message-ID: <zwqjtobvlqhvnfv6xf3cjhq5c3xab7aoyx2fuitmhkxfyjl6ro@p7zsqrim3ad7>
References: <20241210001657.3362-1-W_Armin@gmx.de>
 <20241210001657.3362-2-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210001657.3362-2-W_Armin@gmx.de>

On Tue, Dec 10, 2024 at 01:16:53AM +0100, Armin Wolf wrote:
> Add the Acer Predator PT14-51 to acer_quirks to provide support
> for the turbo button and predator_v4 hwmon interface.

Reviewed-by: Kurt Borja <kuurtb@gmail.com>

> 
> Reported-by: Rayan Margham <rayanmargham4@gmail.com>
> Closes: https://lore.kernel.org/platform-driver-x86/CACzB==6tUsCnr5musVMz-EymjTUCJfNtKzhMFYqMRU_h=kydXA@mail.gmail.com
> Tested-by: Rayan Margham <rayanmargham4@gmail.com>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/acer-wmi.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index d09baa3d3d90..5cff538ee67f 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -393,6 +393,13 @@ static struct quirk_entry quirk_acer_predator_ph315_53 = {
>  	.gpu_fans = 1,
>  };
> 
> +static struct quirk_entry quirk_acer_predator_pt14_51 = {
> +	.turbo = 1,
> +	.cpu_fans = 1,
> +	.gpu_fans = 1,
> +	.predator_v4 = 1,
> +};
> +
>  static struct quirk_entry quirk_acer_predator_v4 = {
>  	.predator_v4 = 1,
>  };
> @@ -600,6 +607,15 @@ static const struct dmi_system_id acer_quirks[] __initconst = {
>  		},
>  		.driver_data = &quirk_acer_predator_v4,
>  	},
> +	{
> +		.callback = dmi_matched,
> +		.ident = "Acer Predator PT14-51",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Predator PT14-51"),
> +		},
> +		.driver_data = &quirk_acer_predator_pt14_51,
> +	},
>  	{
>  		.callback = set_force_caps,
>  		.ident = "Acer Aspire Switch 10E SW3-016",
> --
> 2.39.5
> 

