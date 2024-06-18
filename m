Return-Path: <linux-kernel+bounces-219499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2BE90D379
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21B5328490A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432A018E74C;
	Tue, 18 Jun 2024 13:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ojv6ZS4a"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B17158A2F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 13:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718718179; cv=none; b=fiF5dIoMZfwySnnL9zj5b5k4OZI9/7QPXwyru/kVwl7Yujh8bHYfv59pnNI3KT4eWcZTHsv+yZWE3l62fxXa/QzyTDcvPyWOXYfO7VvuM63nmNBi5RDHRZw3xTv35lYqamraR0k+CHwzHOxdXfvn1steOGojyA2Fxjp6iehdSTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718718179; c=relaxed/simple;
	bh=wgmy2onw829qz+4Uv8pd08kIiD5wyvr8mfP+Z0pXRGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rxpSvilYmuqQE50p6iqHtaM34grs6mfrm9YB13f3TNTwfaVh7j2gDHLhyTX65EsHKAFhye8TbS+6msaGn4aTfHh5sbhD4W3tq6f6u9xxV4o4DLlR/CP8gkwajeJr3bZpvX/LOZJ/DP7OTczZzCEi1WAIrQjc4hN6abcu/83+Pv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ojv6ZS4a; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52c815e8e9eso5416265e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 06:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718718176; x=1719322976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MyKbHIGiUrlL0z6PTCr0chCyy+szTmigFpVqeU5aaNI=;
        b=ojv6ZS4aQbi4vCuM5f7zNRINdiJuAVXKAwU0XZaP4RV9NlkoLnTBZyPYUF6fDSpvZk
         Z+ZTjOHsbRwdRpPFydjS3xufLrl5b3t1sd0IlNWiEChhzHY1xO85/iRUdV/i0uPTaVn1
         NIg1eQMscBW3I79qXdNhlLBTlSYJUiagz8R+XfsqjEmgx0kAXXhOSe38hnVjpAdOjDp3
         C8l9GMQEZdpk802rW23lrrInbHGEvtdlK5Jg9iBzAWOAMYZUIrBjKEUCoN9p/8MExSYV
         EFHpWIREl2P9bMsjytoWe2hE/rZLxDJEvtdgpDZrt70cb3+h1Hj4S394FWkH/g7RzOAv
         lOLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718718176; x=1719322976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MyKbHIGiUrlL0z6PTCr0chCyy+szTmigFpVqeU5aaNI=;
        b=lPUo19wTTdDoSW15x7iTPvbNs81dt6qO5/g5rnVT0b5ugLDY4DYuD7sVxJ5PCqvD2x
         lW+263k/h3a5ypQWZ91MGXOm6OQq2yFF0fehknbyCcgFpWXsFzDb8lBDakPO6efstC6e
         I12w7pBBCHPt03l3LWcspzceYY0JDRZTW2ZLhLq72MueDSNJoK18GWdBpDa0TAj52kxo
         Fx7SxJbTJBW2ZlNFXgng7QUaNR+GTZlX1B2Zvnf5x18bSbOb0sHdoB2IsP5nR++O9jsO
         pHl36+v+dfrk+eeprFYdAw7VuWwjgiU11R+som8xW0p4OVzOCy5wLVth/189po/KMeAm
         UgGw==
X-Forwarded-Encrypted: i=1; AJvYcCVQGC42u5F/zNEac+Y7S1TBkWMVhGd6x6sc3Sp3yGEo0OXrOZ/ekiYxliYZAKrZ2WkjmGwbnTu5Fxg6i+qoPV28kxTa8DqpCy1LODFb
X-Gm-Message-State: AOJu0YxsZ2fZ9ewg5sC94PUr/nGsCpLAxgXIIikq5Idfv4O/tSA2s+PO
	vlhucoGvk5q02McRcA4BHkuu4xXGbqjC8XuCjPFfzbG2wG5Epwj7ZzBxW7i7FTo=
X-Google-Smtp-Source: AGHT+IFbZaekvOAfpvKvP60byK6JENEdTAi8wmrKnde8Cg1ymJ2PhoUiqKQ6z2KvNDSiInKdsaG4dA==
X-Received: by 2002:a05:6512:1384:b0:52c:b456:a918 with SMTP id 2adb3069b0e04-52cb456adc7mr6829126e87.9.1718718175607;
        Tue, 18 Jun 2024 06:42:55 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-362822f53f6sm775635f8f.0.2024.06.18.06.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 06:42:55 -0700 (PDT)
Date: Tue, 18 Jun 2024 16:42:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Vladimir Oltean <olteanv@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Simon Horman <horms@kernel.org>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Casper Andersson <casper.casan@gmail.com>,
	linux-kernel@vger.kernel.org,
	Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v1 net-next] net: dsa: Allow only up to two HSR HW
 offloaded ports for KSZ9477
Message-ID: <339031f6-e732-43b4-9e83-0e2098df65ef@moroto.mountain>
References: <20240618130433.1111485-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618130433.1111485-1-lukma@denx.de>

On Tue, Jun 18, 2024 at 03:04:33PM +0200, Lukasz Majewski wrote:
> The KSZ9477 allows HSR in-HW offloading for any of two selected ports.
> This patch adds check if one tries to use more than two ports with
> HSR offloading enabled.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Is this a bug fix?  What is the impact for the user?  Fixes tag?  Add
this information to the commit message when you resend.

> ---
>  drivers/net/dsa/microchip/ksz_common.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index 2818e24e2a51..0d68f0a5bf19 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -3913,6 +3913,9 @@ static int ksz_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr,
>  	if (ret)
>  		return ret;
>  
> +	if (dev->chip_id == KSZ9477_CHIP_ID && hweight8(dev->hsr_ports) > 1)
> +		return -EOPNOTSUPP;

Put this condition before the ksz_switch_macaddr_get().  Otherwise we'd
need to do a ksz_switch_macaddr_put().

If dev->chip_id != KSZ9477_CHIP_ID then we would have already returned.
Really, that should be the first check in this function.  The
hsr_get_version() should be moved to right before we use the version.
(But that's a separate issue, not related to this patch so ignore it).

So do something like this but write a better error message.

regards,
dan carpenter

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 2818e24e2a51..181e81af3a78 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -3906,6 +3906,11 @@ static int ksz_hsr_join(struct dsa_switch *ds, int port, struct net_device *hsr,
 		return -EOPNOTSUPP;
 	}
 
+	if (hweight8(dev->hsr_ports) > 1) {
+		NL_SET_ERR_MSG_MOD(extack, "Cannot offload more than two ports (in use=0x%x)", dev->hsr_ports);
+		return -EOPNOTSUPP;
+	}
+
 	/* Self MAC address filtering, to avoid frames traversing
 	 * the HSR ring more than once.
 	 */



