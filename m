Return-Path: <linux-kernel+bounces-341520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A72988116
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 11:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 211B01C24803
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 09:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0C618A6C6;
	Fri, 27 Sep 2024 09:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gYhsXVi4"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EE518A6B5
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 09:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727428062; cv=none; b=OJln9DuWwVkh6bNcXsnmJ+78LHdPUqek3bVb1Ua3tK1LZezEBoKoviRWOQuwE4k7FoaZsAsa/Gg31JNeno/k7NKdzvT/28Fe9KcUQmcc1mRZp8v8Xs3oPfeOKBH0ItHE2FjaxdY/2hhtp0wp8Ozakn8NJUWUpH7KW64YyYfVkPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727428062; c=relaxed/simple;
	bh=n9K+M/M4rIeKAh1/1h57NW9b2sVRQ7AIdfsOF6GuIRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4rJ7ud2zjmORoSW2OzeCpoIwuYxQLZRjK5c7+OHXG72CY6IZbQb7cKr6MBkJia+6PE3la1VcdgL01CDT0G3Dfmz1iCZFVfDD41Vss3GkhALtpooPBm5k/NPA9kwyvX3RWWfSvbvRvtN3gVvB7YZL8kLHPpWM+sJuu4lEiU+xGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gYhsXVi4; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5365cc68efaso1753776e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 02:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727428059; x=1728032859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zV6HJXNQV5T8CuQJ/tUTNkNzYTYxFtQgwRH9nbfuoYI=;
        b=gYhsXVi4X0zAj6CxwJKRYi39MZYkwexDHIuWz5ED9JZ6JGlTbvqNRSefxLpxf0Gqje
         mnDiHC32MCk/WK140qYna73tH9uZO9ryG44jtwNF+IfssoFUMybURHdBKr8WLSU08IHm
         ZHbt4KJLbG9wgYwm9+4Gn6ELLs2zP7dxz/h80Zs6sJgkAypd2HcXF0Png2+33vFDJZgx
         lTzBKZ2lDirtxLRz7dJOdXtFYKwQEPJBYx8a2wse/exR751ZXUNkNKH8YAkq0s4gAy9h
         kx0ITRVtkyqxhldPLk5lJ5DZxG7sJtX5XC4VqlrvCAa1ZFb7B+duIv5XVrPXCeyGDbm6
         QEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727428059; x=1728032859;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zV6HJXNQV5T8CuQJ/tUTNkNzYTYxFtQgwRH9nbfuoYI=;
        b=Ezn+F2hJPoeX1JCNJwNVEUdia+BI2zh5EZ3/ttWo/AFvldOTx+wPmf+G2WX3rxX2SB
         PCQ7rdXjFD8Jwi/ixor3zYSI33/g2RS6q8rgtuJSrKtDbaVrupvwkcn0pKYdJCM81akr
         xWr1QtG3O3Lg1VcJteQZCu06QmoamkU3HhgVfobaRm+dusGIlF7ikrUex5paMao7qlvE
         Ke6azgzFwfccqdCu9kl2A9fRyyZq6gnCom7OU6LrxH1oDt9QAvQDgrKJzVUUyFuO5u8p
         9U0ew27fhY2clgdypeFnbVE3tnXxR1uvkR4sv18+UnUUcr3rBMRPJpP4aN33LGy7zFzO
         x5zw==
X-Forwarded-Encrypted: i=1; AJvYcCV7FFKZd2DWXNzHb77NYDZdEVcsSm8G8NMCLJsT8WQOtjvqK9R9N/oaoR8mfPkxrpPgyNCEAIuaiGydkxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUmS2A+p88PFSsf/iEKzm0GX0W+LgDWMAf3TiEvrxVPrjg8Bqr
	aHztBx7unQ/1Jxj9a2MwIcjTLoAMNF6XVTtEH0b4rPDPkL88OOqsMgivI7ba1RM=
X-Google-Smtp-Source: AGHT+IFkcv299YnvolWkIC1E1HkuCwx2dv/Up573YO3Yhdrr3UgZ8MGnRH7kuRz896USQfoNddYuEQ==
X-Received: by 2002:a05:6512:b90:b0:52c:9383:4c16 with SMTP id 2adb3069b0e04-5389fc3afc7mr1245883e87.22.1727428058948;
        Fri, 27 Sep 2024 02:07:38 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5389fd548a4sm237693e87.42.2024.09.27.02.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 02:07:37 -0700 (PDT)
Date: Fri, 27 Sep 2024 12:07:35 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: heikki.krogerus@linux.intel.com, tzungbi@kernel.org, jthies@google.com, 
	pmalani@chromium.org, akuchynski@google.com, Benson Leung <bleung@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] platform/chrome: cros_ec_typec: Displayport support
Message-ID: <m3wg4vkohfueeilcqjd6ulmga2xacrr3jhveyhn7d2lnxuqrvs@pwteuldtp5p3>
References: <20240925162513.435177-1-abhishekpandit@chromium.org>
 <20240925092505.6.I142fc0c09df58689b98f0cebf1c5e48b9d4fa800@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925092505.6.I142fc0c09df58689b98f0cebf1c5e48b9d4fa800@changeid>

On Wed, Sep 25, 2024 at 09:25:07AM GMT, Abhishek Pandit-Subedi wrote:
> Add support for entering and exiting displayport alt-mode on systems
> using AP driven alt-mode.
> 
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> 
>  MAINTAINERS                                   |   5 +-
>  drivers/platform/chrome/Makefile              |   2 +
>  drivers/platform/chrome/cros_ec_typec.c       |  13 +-
>  drivers/platform/chrome/cros_ec_typec.h       |   1 +
>  drivers/platform/chrome/cros_typec_altmode.h  |  34 +++
>  .../platform/chrome/cros_typec_displayport.c  | 247 ++++++++++++++++++
>  6 files changed, 299 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/platform/chrome/cros_typec_altmode.h
>  create mode 100644 drivers/platform/chrome/cros_typec_displayport.c
> 
> diff --git a/drivers/platform/chrome/cros_typec_altmode.h b/drivers/platform/chrome/cros_typec_altmode.h
> new file mode 100644
> index 000000000000..a8b37a18c83a
> --- /dev/null
> +++ b/drivers/platform/chrome/cros_typec_altmode.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __CROS_TYPEC_ALTMODE_H__
> +#define __CROS_TYPEC_ALTMODE_H__
> +
> +struct cros_typec_port;
> +struct typec_altmode;
> +struct typec_altmode_desc;
> +struct typec_displayport_data;
> +
> +#if IS_ENABLED(CONFIG_TYPEC_DP_ALTMODE)
> +struct typec_altmode *
> +cros_typec_register_displayport(struct cros_typec_port *port,
> +				struct typec_altmode_desc *desc,
> +				bool ap_mode_entry);
> +
> +int cros_typec_displayport_status_update(struct typec_altmode *altmode,
> +					 struct typec_displayport_data *data);
> +#else

As pointed out by the robot, the stubs should be 'static inline'

> +struct typec_altmode *
> +cros_typec_register_displayport(struct cros_typec_port *port,
> +				struct typec_altmode_desc *desc,
> +				bool ap_mode_entry)
> +{
> +	return typec_port_register_altmode(port->port, desc);
> +}
> +
> +int cros_typec_displayport_status_update(struct typec_altmode *altmode,
> +					 struct typec_displayport_data *data)
> +{
> +	return 0;
> +}
> +#endif
> +#endif /* __CROS_TYPEC_ALTMODE_H__ */

-- 
With best wishes
Dmitry

