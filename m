Return-Path: <linux-kernel+bounces-336132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE2B97EF8B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11CE31C21625
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC2319F134;
	Mon, 23 Sep 2024 16:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="cgLqrp2A"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D801219F47E
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727110150; cv=none; b=DqxpG0vLVkntWg/R8Stahnt12M1Lso4aM5ADX1usyW7qWjJG/wayryySDfcVO7gwMaOEnIM9/dxOX+RKSRMOZowccixAF3hwTv4i2OciYOFSqvrbNGayfL+dce7QQrFXHpbIAghCO8j3BS+ry0itnrIyVTq9UMB8BDzpE4WmqPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727110150; c=relaxed/simple;
	bh=/VdJex1P9IliBcCN+TkYQfmH1H3CS3D8mmJxjjTrXbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owIeufEoY1vErGD29It2IpwCATu2o/P3hJYbObLDy9kVonnREIOdBkTU/I4sLEDdD+oi0pAg/Cx22t3a5pQRJN82EAEQMVE/hFthIx2n3VmTzgG0v7TLJJGoKuKkHnIJJdOdPaUSRSIIp1bxXzQcUXU2iYnUUkNFNzyDSJlkniM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=cgLqrp2A; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-374c4c6cb29so4565230f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727110146; x=1727714946; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RUIFbzEfhQorQBTWHhIvW39H3JHGIgV0/QXmgzM9Dx8=;
        b=cgLqrp2AP8c1y7xcdxAgq9tvlxeHR9jsH0HbwpsLrCVhMp0X/l/DI/HBujwkNkoNJM
         Ti9LH57NjzXcwyahEdV1EbDl270rbSzz9QzFzyv7djKd/TvfQwqF09qvF1lIu5S9Mgn4
         4893HpRZN8K4/gI7YyBuf09+/qyY4bAS0uNyQoYdOc+xNBC8h3+1VnqEvwXhDLNohd9C
         pEw41MVwtdohknfXxrnMZp/d/ZsjdDmQJIED7kkGO/E/ms65j29hl2yYCT9OXWgUppjA
         bDmWE5JK+OBb4LaNjbp/eafo+75GeafHXZZdxs5zYUipOlB6SdYv7i+SCM6Bpp3A6Ivu
         MJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727110146; x=1727714946;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RUIFbzEfhQorQBTWHhIvW39H3JHGIgV0/QXmgzM9Dx8=;
        b=jIp2HFwMvpZGKqozKmYIcTod2BiTZ8hpxLhKjgmYJ+8tLgyxVkCDaLjOqwoMY9jl+q
         5/Uhlsrw4lBoOrHIGE7/XvFvWS6n4WVv9tPoZ711mqsk8nomxUWZNEyzoHtgGxSzAqy/
         dorWulUEiZHFXPw6tpMvd3WSESuRr3yE36PWS6TipsZucnIqqcDKcgLJt1Ml0utrTeqi
         AMCMCv4HE9IPEJUP7LA9vtz3XFlLVqj9ZkduuCcjyHaUUzBP0D44Yv+Gbhj6ITc+CdZA
         9lI+tddBc/FFThrKO7aTrPzuRcRF75FnOSP2Ji4Qq8rCxLvY2I6D1R/17HuAEDC9Bj1A
         O/Vg==
X-Forwarded-Encrypted: i=1; AJvYcCXRD8wpVi6cjNBLGvjZoGfbqjgsnOOz9pCTdPcaRLNOtUXu8o667uZgqYwRW1jzer6zvozeM7dWQ7cGslc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6drZUutFk7yx5pOjz4KA5i0E+ZZviZcfbyB9Icjin4JcEKKaJ
	wGNO/ZgjtURE99tkuI7TEnF8At5lEhxISS0waz8rEm02LqOQQhwi+/fHkS74QuU=
X-Google-Smtp-Source: AGHT+IELSIvIxna+JU2Zb53geG4pmwxSBpoAmhau4NlTM9exycA4PonR7J7kD5qss+As9Ce1d1GcaA==
X-Received: by 2002:a5d:4fc5:0:b0:374:c8eb:9b18 with SMTP id ffacd0b85a97d-37a422c63acmr9722969f8f.24.1727110146164;
        Mon, 23 Sep 2024 09:49:06 -0700 (PDT)
Received: from blmsp ([2001:4091:a245:8155:f78b:11e0:5100:a478])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e7800374sm25016372f8f.79.2024.09.23.09.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 09:49:05 -0700 (PDT)
Date: Mon, 23 Sep 2024 18:49:04 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>, "Felipe Balbi (Intel)" <balbi@kernel.org>, 
	Raymond Tan <raymond.tan@intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@ew.tq-group.com
Subject: Re: [PATCH v3 1/2] can: m_can: set init flag earlier in probe
Message-ID: <2s4w5jrrg32zy33xlxidv37437ehcs7xzm7qynhwpfkom2ckpz@lmvnlcdrfbzs>
References: <ed86ab0d7d2b295dc894fc3e929beb69bdc921f6.1727092909.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed86ab0d7d2b295dc894fc3e929beb69bdc921f6.1727092909.git.matthias.schiffer@ew.tq-group.com>

On Mon, Sep 23, 2024 at 05:32:15PM GMT, Matthias Schiffer wrote:
> While an m_can controller usually already has the init flag from a
> hardware reset, no such reset happens on the integrated m_can_pci of the
> Intel Elkhart Lake. If the CAN controller is found in an active state,
> m_can_dev_setup() would fail because m_can_niso_supported() calls
> m_can_cccr_update_bits(), which refuses to modify any other configuration
> bits when CCCR_INIT is not set.
> 
> To avoid this issue, set CCCR_INIT before attempting to modify any other
> configuration flags.
> 
> Fixes: cd5a46ce6fa6 ("can: m_can: don't enable transceiver when probing")
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

Best
Markus

> ---
> 
> v2: no changes
> v3: updated comment to mention Elkhart Lake
> 
>  drivers/net/can/m_can/m_can.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 012c3d22b01dd..c85ac1b15f723 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1681,6 +1681,14 @@ static int m_can_dev_setup(struct m_can_classdev *cdev)
>  		return -EINVAL;
>  	}
>  
> +	/* Write the INIT bit, in case no hardware reset has happened before
> +	 * the probe (for example, it was observed that the Intel Elkhart Lake
> +	 * SoCs do not properly reset the CAN controllers on reboot)
> +	 */
> +	err = m_can_cccr_update_bits(cdev, CCCR_INIT, CCCR_INIT);
> +	if (err)
> +		return err;
> +
>  	if (!cdev->is_peripheral)
>  		netif_napi_add(dev, &cdev->napi, m_can_poll);
>  
> @@ -1732,11 +1740,7 @@ static int m_can_dev_setup(struct m_can_classdev *cdev)
>  		return -EINVAL;
>  	}
>  
> -	/* Forcing standby mode should be redundant, as the chip should be in
> -	 * standby after a reset. Write the INIT bit anyways, should the chip
> -	 * be configured by previous stage.
> -	 */
> -	return m_can_cccr_update_bits(cdev, CCCR_INIT, CCCR_INIT);
> +	return 0;
>  }
>  
>  static void m_can_stop(struct net_device *dev)
> -- 
> TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
> Amtsgericht München, HRB 105018
> Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
> https://www.tq-group.com/

