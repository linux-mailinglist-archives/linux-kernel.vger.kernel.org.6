Return-Path: <linux-kernel+bounces-335548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422C397E74D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 738591C20D90
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 08:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF53974070;
	Mon, 23 Sep 2024 08:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ioPB8iUO"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03801A269
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 08:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727079127; cv=none; b=Ngi+/6kliU5D/lTOGsQXT2JaI8CngMlViUVBy8isyDwqzr27rblfujlngBgKtWNZ33DxcZrP9QQWU3cWfMRhyLbr3Bl4QZaD4ybD1+rKzZ2Jgzx+y47fQ8c5YOGsG/0s9NH/JwnuWgfTVrpoDyQQ4SNBVtIjYGXQZmynCRZgmfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727079127; c=relaxed/simple;
	bh=AiGF/8OSi083BWf/+PHyVvxx5NeIHzd+1QlsFeZZvwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSLsc62fCaWko9vDAd8hzd8qyqWcFTfVp2NScd1T1bJ/VXm7FiUHYxeosq/O+0x4sFJ7DVruKwdxUwEHVyYa4UerV651zlmDiGG0hdHbpLi1Q890tXeOtXltu6i1RNqZkYQdif7WlUYk2HBIGHE2Jlk6LF7h0eV+d819RKEhnvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ioPB8iUO; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42e748f78d6so31703015e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 01:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1727079123; x=1727683923; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3gjbHPJoKqedubSBXHd39Fm+ElqRQN46xlLk23QoYic=;
        b=ioPB8iUO4+ltjiuEUiU59nNxVhEFomooLfMRRmMh0+v07ULSd36wE0TGwAtF1IRRD7
         c4vPodGddYbPGFMckuhGmsBDgFWh8Ka0lbnk+6pPqZPhK7H7qyjxkK3W1ApLOR/BJwMs
         ReqmqCfKQjCjwsWOCX82fNsbm/y6NC3Z0MIs3dSEh86ppU2NQDXcVzMhtqxpouksJiEk
         gcFYd6hbYPX5gYlxR3hY9iWNjVhlRYsf+f2G3m07dEfw7Hg3kcb3XaTRQtTXSbei3XWQ
         His4TZnKjq7ayRtS/LvSfF3Sr2MyO+R4Wk95Vs+Vbvnxq8zId28sKaJo5m6lR++DpqSJ
         /LAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727079123; x=1727683923;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3gjbHPJoKqedubSBXHd39Fm+ElqRQN46xlLk23QoYic=;
        b=YX8w9c9S06SdP0swOj1NQ20FD9VYbOFXD1agNeHMSb3PjiPEZ509fcOSrZAKeJd8jG
         q8/zdNyzujAzbmjqYbMfA/+Ahks/e9K+HCWY9DVVvVOdqoNA3GoJIWH/Es2y4umECKPE
         vDPAEQaO6RM7f6hjoUcCvxpb396bswkLIoLxfTzEmP74yk4RbciHwXtYkYQnM/xteFqJ
         e5RKTAKbeM9dhbtErhtcPsa/deh3ui6iz8qva2txyn2v2nAWSL0D8vsPq4fuSQOxv2Id
         JnbxlhdVT97JUBAjDN5KgLQ67goVxL3gmW1i/GdiU5whuwvigkQSy31KQrpRRX8EEAjM
         OY1w==
X-Forwarded-Encrypted: i=1; AJvYcCW4rWIDGU4GTQB0nT+pEmnqoZDcqZm2FIdqDvbDBSBn2UZmIlVYMdxno4q55dfaakEM7gDwA9bKDx37wnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRZYwSClSM6UQSgD4xUUj8bCsskL/EZrplwWrZNcBMaH9bLYon
	kIuF7FS/1sU1dZyxciV12nF1Q7+Xj/8dnYR9hyQph0WbrBc19hGdYNxkUn/ZOsM=
X-Google-Smtp-Source: AGHT+IFCTMzSYCRN9wyg4jJGEvRCfYk8ba3b68pLdJTZ5C4ZJFE06ZrWNcTI6lqNc3I+z/+RmQf/lA==
X-Received: by 2002:a05:600c:1c95:b0:42c:de2f:da27 with SMTP id 5b1f17b1804b1-42e7c15b393mr79858795e9.2.1727079122928;
        Mon, 23 Sep 2024 01:12:02 -0700 (PDT)
Received: from blmsp ([2001:4091:a245:8155:f78b:11e0:5100:a478])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e71f06a4sm23718726f8f.23.2024.09.23.01.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 01:12:02 -0700 (PDT)
Date: Mon, 23 Sep 2024 10:12:01 +0200
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
Subject: Re: [PATCH v2 1/2] can: m_can: set init flag earlier in probe
Message-ID: <zqk3dsg6qdr7nvul34cv5qygtrcq3h2kpwojr7e4nsbgvo2i6a@xbmfcgtb3uad>
References: <ac8c49fffac582176ba1899a85db84e0f5d5c7a6.1726745009.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac8c49fffac582176ba1899a85db84e0f5d5c7a6.1726745009.git.matthias.schiffer@ew.tq-group.com>

On Thu, Sep 19, 2024 at 01:27:27PM GMT, Matthias Schiffer wrote:
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
> ---
> 
> v2: no changes
> 
>  drivers/net/can/m_can/m_can.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 012c3d22b01dd..47481afb9add3 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1681,6 +1681,14 @@ static int m_can_dev_setup(struct m_can_classdev *cdev)
>  		return -EINVAL;
>  	}
>  
> +	/* Forcing standby mode should be redundant, as the chip should be in
> +	 * standby after a reset. Write the INIT bit anyways, should the chip
> +	 * be configured by previous stage.
> +	 */

Could you please update the comment to reflect your findings?

Best
Markus

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
> 

