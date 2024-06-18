Return-Path: <linux-kernel+bounces-219587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C6690D502
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCFB81C24B3B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F6F13C80B;
	Tue, 18 Jun 2024 14:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yuFHRFhu"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8C817966F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719588; cv=none; b=ESOl44xy5Vo79/Y5Xq6mJ9nz1a5I9QLrp+MVqp0rFYiQ2ZkBjMzwRUAdJAUnKURxcbuqrNOInBjJlAf6fOKAIB4GVH+cYrNxUFbQ3YzMq2elqP2wu9rAsMOgsdxnqS+dvpAGPScObCiBd3tqR6qWNVSC1+Zk+QDQ4GGvKEXRcYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719588; c=relaxed/simple;
	bh=IW28aZm+iZqULt5fWzI98gNVHRNFF3UQPxz10FVpx44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDaY+OLqlF3nqfzk6H7r1G+94XlCAbJRYFOSZ/C3Wd/ySERley7LhcWNM+ScCK9Ch6ALpXqWq65US7csBIZVYQqYUF3+yROD9FvXG2M4U2vLKWDjF2RQ1iFFyEalk5KRJ8lV3GsK8Iu1ovTfoIZDtZWvv4q9C6VaPHp7sAqaz2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yuFHRFhu; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4217d451f69so44670005e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718719584; x=1719324384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uHCIp0mqAd4INL+D+JDPsyc4u2o37mgVjl2wvM2bkNQ=;
        b=yuFHRFhuqLvBilpwZ5/nWfRtx9Q+fconHSDZXb6dALVIaPz4o3a+NzkBTJn81e08je
         ZE9gKR18iImaFNZx5XviPJofMWYeN15tJ9I7UbFzmgkX8rABjMcPZ5myH6UnfP71J+Su
         QmFpTGXr95GuOwIE09x+1WZjYYCqQWgI9dlioTeogry/LOs68p5mlXHM52TVTD8FqFbP
         hKSWbF1gNlzY0a6H3ugq2tpXTGw3MKK3DZVmKqNzp81ZmiFccYLtfZH7T25ZYlbPfY+O
         bAPQowwTY8qfBUanwYb6lLWq6pJ2BA30qFfpBf8OpoNTOyq8eCNlQQzHJHn3FZCqzEPo
         S8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719584; x=1719324384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHCIp0mqAd4INL+D+JDPsyc4u2o37mgVjl2wvM2bkNQ=;
        b=viOBm2GFgxHtFwup6AhlKzsWxuF25c8AsPmTRXI57+I91YOGZDFernduL27JsXOKEa
         VArNBDdTkboSTbppRtN79rxl/FqYI7aF9CD4XQ8QUsRgn+wDi/MeH4867fVemdvzjSMC
         eldzE4Dk7zQR0a6OYCwoP25gl/5H5ScXt/2IsMgCN9pSshMf6LEdoWQaF/3cwalOdHy7
         Nrl5mTXhJWJY7K4XfoYGkilD86gl1qg1pEbodAPjG0lPGKX2GehoyclqdmrtYea5mEMg
         PZRb08aoCGlFGBD0vvlReEV9kn13I0ACahmw0VyIscWjWqZcE1f/rcWa5ni7jhpdRkBg
         hHuQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7BZ0ic0pSOnyt2vHkYd7VkqURhau6Ra53Slox8DdrNp1SoOCMHylLtoZtXzlfpwFcUa8+1yyHL0mT1S2eIsrSoq77hmyxhN70lOqv
X-Gm-Message-State: AOJu0YwtUycNOQIeuxA6ynkopzr69GzaEiBIyrZQcbI8TbvO7TYF1FSR
	el4MTPZ6mGb4lKhxFmxI1k94FHTaPjDbmULCWeOH8cD2tJhhBOclchx4GQXY9Bw=
X-Google-Smtp-Source: AGHT+IFKjvqZ/QgQLGa1tSbzPra7Zl+qeL2qLD06C0X+aa3rqVch9Z/Yi7ZIfeugjgmnZnNJG3ex6w==
X-Received: by 2002:a05:600c:1818:b0:421:4786:eb0c with SMTP id 5b1f17b1804b1-4230485a6acmr107353135e9.33.1718719584403;
        Tue, 18 Jun 2024 07:06:24 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f641a5b4sm189275015e9.41.2024.06.18.07.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 07:06:24 -0700 (PDT)
Date: Tue, 18 Jun 2024 17:06:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Lukasz Majewski <lukma@denx.de>, Vladimir Oltean <olteanv@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Simon Horman <horms@kernel.org>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Casper Andersson <casper.casan@gmail.com>,
	linux-kernel@vger.kernel.org,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v1 net-next] net: dsa: Allow only up to two HSR HW
 offloaded ports for KSZ9477
Message-ID: <1e2529b4-41f2-4483-9b17-50c6410d8eab@moroto.mountain>
References: <20240618130433.1111485-1-lukma@denx.de>
 <339031f6-e732-43b4-9e83-0e2098df65ef@moroto.mountain>
 <24b69bf0-03c9-414a-ac5d-ef82c2eed8f6@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24b69bf0-03c9-414a-ac5d-ef82c2eed8f6@lunn.ch>

On Tue, Jun 18, 2024 at 03:52:23PM +0200, Andrew Lunn wrote:
> > diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> > index 2818e24e2a51..181e81af3a78 100644
> > --- a/drivers/net/dsa/microchip/ksz_common.c
> > +++ b/drivers/net/dsa/microchip/ksz_common.c
> > @@ -3906,6 +3906,11 @@ static int ksz_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr,
> >  		return -EOPNOTSUPP;
> >  	}
> >  
> > +	if (hweight8(dev->hsr_ports) > 1) {
> > +		NL_SET_ERR_MSG_MOD(extack, "Cannot offload more than two ports (in use=0x%x)", dev->hsr_ports);
> > +		return -EOPNOTSUPP;
> > +	}
> 
> Hi Dan
> 
> I don't know HSR to well, but this is offloading to hardware, to
> accelerate what Linux is already doing in software. It should be, if
> the hardware says it cannot do it, software will continue to do the
> job. So the extack message should never be seen.

Ah.  Okay.  However the rest of the function prints similar messages
and so probably we could remove those error messages as well.  To be
honest, I just wanted something which functioned as a comment and
mentioned "two ports".  Perhaps the condition would be more clear as
>= 2 instead of > 1?

regards,
dan carpenter


