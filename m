Return-Path: <linux-kernel+bounces-231022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0147391850C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 248BF1C21507
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 267DC1862B9;
	Wed, 26 Jun 2024 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hqVCury/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08AE1836F9
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719413912; cv=none; b=PzZVse7fSSPnGui0uPZyRJnnbh17kWmtK8Xe4etjFP7Qhr2z4mjs57wRS4iUOW9Y+GzJhEBgK7tH6C5XNe5ueGVzFJv1zDclc7h+w9+SsTl8rZ16Nd0zrE1qqKKj9MDNIHVnbKF57SA4j4ZZmyBMXQwpqivlClshZPIpOruBklI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719413912; c=relaxed/simple;
	bh=I0D6e6Fg9mEuPCvMsSlvOuOX5/XCzgzm4K0nMEj8N7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUhpoHV0s+CaASmtU17/gs0OI8xVcsxqrrY1cMJkGXuiu4cA01zY0HHh5CRMEGHFOi+yKVSLX3BPMISOgEoBP97m+h3mRbnPetLiMV7SJUN9THDdx7BFIPJ/oj9ZgGAlOMrUjeYw+bDx9MIZ4EkmEzZLVJfwXFq6DWylZ2i9hhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hqVCury/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719413910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Aya9QIUU1dceOpRSHwLiYWRs5fBhpIvpFHsqd9ObPGw=;
	b=hqVCury/LQW1aL/8KmtaUXBsFDVQnQ8vlQQhQzgF8hcEE2clW4InEuFa5NsEvwaZc+FcNq
	FPpJ1VXIc+0IMqMBeXX1tfgyFMnT6E3RAJZRjv1Kr5RNCQZD1R0ydvnENKypYMWgb7HE+n
	w75JcN7Okr4H9IIXB4U0ndLI4OBZ8DU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-RbLOp8cQNyy_TKwdhhG3UA-1; Wed, 26 Jun 2024 10:58:28 -0400
X-MC-Unique: RbLOp8cQNyy_TKwdhhG3UA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6b500743a3fso102416456d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719413908; x=1720018708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aya9QIUU1dceOpRSHwLiYWRs5fBhpIvpFHsqd9ObPGw=;
        b=MVJ8tHfpyPDld7RDnnB/z+k78K8e81TTZf1X5f7gmG/LInc7b0Ug3Bs1nQS5hHN70D
         aE5eYh2G03wSpYWreK7bCSRMOslEwukKvFKqnOOrTJwO2cmNVkBeEEHTQ9OEV3YSoqCf
         wdQBE/q6YulBS/sw04NZcCPV0AsIpLpVLyISvNN2Ph7DFjC/szm08r7vponR19NW1UZq
         gMc+DYchW2wlEvv/gAb8NQ+CEo12MewmwD24i0Vutoejw8VhoDeclplYCxXasDiR7fW6
         zqNbrmPfnWS9IIxz50lHe200lu+mCeHTw0gDnwt4HSKBGHUL/qXXrLha7zpvSBjm6v84
         bM8w==
X-Forwarded-Encrypted: i=1; AJvYcCVA7rpiOrYMiFVxj94pqGy27absHBICbRADm2EmjrYoD7ssf5x4pTEN5CyzlCqpTZx1PYAqcrYX0VGUWI14aw6f0yWf0nI3+57/lul2
X-Gm-Message-State: AOJu0YwmOFyStxKdqvI9t19MAdZqZC/gjan6zCVR4s7kM2X0bLW8lf+T
	X0boi0al6w46rnU6EpkLdhrvnYvRMSFEDlLQNf9p8CWO70BpcLNTelMfSaaSB25ikqKsz18s9Mr
	0/RF4nadlFwJRVF7hUNMdbWhT0bRpn9LLiidz2HPpMed6MtzTKY0d0QqI4RHb+Q==
X-Received: by 2002:ad4:424e:0:b0:6b4:fe0c:1a92 with SMTP id 6a1803df08f44-6b53bff41abmr121545876d6.43.1719413908144;
        Wed, 26 Jun 2024 07:58:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6nPLCGa2C50EKUtysGXYh0LMEa5egqmh4lDlG99IlgJl3jje0UqDxnnZntsdaxpPxTw2dxA==
X-Received: by 2002:ad4:424e:0:b0:6b4:fe0c:1a92 with SMTP id 6a1803df08f44-6b53bff41abmr121545616d6.43.1719413907762;
        Wed, 26 Jun 2024 07:58:27 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::f])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b531673e6esm42461056d6.85.2024.06.26.07.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 07:58:27 -0700 (PDT)
Date: Wed, 26 Jun 2024 09:58:24 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Sagar Cheluvegowda <quic_scheluve@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bhupesh Sharma <bhupesh.sharma@linaro.org>, kernel@quicinc.com, 
	Andrew Lunn <andrew@lunn.ch>, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] net: stmmac: Bring down the clocks to lower
 frequencies when mac link goes down
Message-ID: <qf4zl7qupkzbrb6ik4v4nkjct7tsh34cmoufy23zozcht5gch6@kvymsd2ue6cd>
References: <20240625-icc_bw_voting_from_ethqos-v2-0-eaa7cf9060f0@quicinc.com>
 <20240625-icc_bw_voting_from_ethqos-v2-3-eaa7cf9060f0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625-icc_bw_voting_from_ethqos-v2-3-eaa7cf9060f0@quicinc.com>

On Tue, Jun 25, 2024 at 04:49:30PM GMT, Sagar Cheluvegowda wrote:
> When mac link goes down we don't need to mainitain the clocks to operate
> at higher frequencies, as an optimized solution to save power when
> the link goes down we are trying to bring down the clocks to the
> frequencies corresponding to the lowest speed possible.
> 
> Signed-off-by: Sagar Cheluvegowda <quic_scheluve@quicinc.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index ec7c61ee44d4..f0166f0bc25f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -996,6 +996,9 @@ static void stmmac_mac_link_down(struct phylink_config *config,
>  {
>  	struct stmmac_priv *priv = netdev_priv(to_net_dev(config->dev));
>  
> +	if (priv->plat->fix_mac_speed)
> +		priv->plat->fix_mac_speed(priv->plat->bsp_priv, SPEED_10, mode);
> +
>  	stmmac_mac_set(priv, priv->ioaddr, false);
>  	priv->eee_active = false;
>  	priv->tx_lpi_enabled = false;
> @@ -1004,6 +1007,11 @@ static void stmmac_mac_link_down(struct phylink_config *config,
>  
>  	if (priv->dma_cap.fpesel)
>  		stmmac_fpe_link_state_handle(priv, false);
> +
> +	stmmac_set_icc_bw(priv, SPEED_10);
> +
> +	if (priv->plat->fix_mac_speed)
> +		priv->plat->fix_mac_speed(priv->plat->bsp_priv, SPEED_10, mode);


I think you're doing this at the beginning and end of
stmmac_mac_link_down(), is that intentional?

I'm still curious if any of the netdev folks have any opinion on scaling
things down like this on link down.


