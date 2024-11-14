Return-Path: <linux-kernel+bounces-409259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A62979C899F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519A81F23ABC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730CB1F9EAE;
	Thu, 14 Nov 2024 12:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IcDFA5f+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBA41F8901
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731586417; cv=none; b=ude6QisoxzmjVM3FCJZ3Vpm8QpaFVZGeL0X5SpXGn06sT7TBEtwxQH6U1vDEpRvMU4Syz8X5R1/S5BMXbpQM5uYdUIFB6JxGP3OoDTCtcFhO4TQb5N4CvA7pxd9WF82Yg0RBvfN8KMVB6/fq9XAnFmsBs8LL70WxIRD2Mkckvgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731586417; c=relaxed/simple;
	bh=CbxVdzYrFN0Rc6HX6DJygzhjMpNgmZS2CQx01qtzLks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZh0a8Dh9xdPlFEe92dDBavnMqjpD4sGOkh4pvy8M6F8K3v5iwqsea0hrIHSHweAuowTPj6q5nPkOoih4CNT/sVnIVW4YSptw6I8t3As0eQYGf1kN/Ek/aiir4FpA0zwBo7snct4EPCD8lan5ovUBv70D3WJSt0VoiFUCN0rCcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IcDFA5f+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731586414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cly6bVWd8F14UabEVcpsy5I4VZ1zPdkEsEJB7rN/meQ=;
	b=IcDFA5f+K62MGNNNbMw2WoJIJDk/m7USRTHJ6S1I/DF6T7PK+ri64LPMAehie1NwsRwTXk
	t3NwQXwG+90+F32F14NmLJXboOiGq6ocDY3A1Jrb5rYCkefYi/XBr1sBqzgyQGNdiNMGk9
	A0FlG9jn7OxCM0t9TI3wZ1d6SewPEBo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-yoNoo7j_MuKq_XhGTwFIoA-1; Thu, 14 Nov 2024 07:13:32 -0500
X-MC-Unique: yoNoo7j_MuKq_XhGTwFIoA-1
X-Mimecast-MFC-AGG-ID: yoNoo7j_MuKq_XhGTwFIoA
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4315eaa3189so5587185e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 04:13:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731586411; x=1732191211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cly6bVWd8F14UabEVcpsy5I4VZ1zPdkEsEJB7rN/meQ=;
        b=b52N0oHyzhYEioBpRc93hjYjl9Jtb3YCg8smdSem+rTFXzMrxc4mkkKLhBZOdcomUv
         w6b2Sy1iOkua0iMDlKB12Wjj5kECF5gP8P1kIpB9tLlo+elrQMcnNvWlhLASWuWI0h94
         vhsAcB+E5hjDiMr35RaJH7A6tNhd5bxRBXOpkNWh8SC4ouqbw8COTWiHdvw2WiuvVt9l
         G2ydp1qpY1gD7Q65fXp1IEGncydX2FeGPL51cPy2wi63uitcY5Q/brVc3Tj/heoHmu1I
         lEGKyglFBri400XzTuc9yvD8ZX6K52Jrj0R5Z+WycRp2dIiXP7JM3ll/EXn/QXAu54tN
         67kQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvjw8lkzMGGrfjWYBVB92M9wk9/RsFdVZOob4syhob7JIYZY0n4qODC+RlK69upwlCB5+jVoffIDor4A8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtQpTfjAbx3/g2gmRGKsV4tf8HXDxKUcYT71Br+FXqrGzi8kXd
	/Vd8IFWV0NxXmASkQij251WOIgtpqt9IccIP7xK8g31jwtvIRb4mkt2xHXvXMddptylJlJuoGkT
	DB3X5wEq/4cv/3jsnJEQBvYsYxmMXGy84mCZCAlVeLCqucHkuSktqLqpNtOpFmQ==
X-Received: by 2002:a05:600c:314c:b0:431:9a26:3cf6 with SMTP id 5b1f17b1804b1-432da7a050fmr21849545e9.4.1731586411551;
        Thu, 14 Nov 2024 04:13:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEelpsYsAMJEhvqChDBQAHMLVQDVU/v0XCvhnfuE1ZX64VQE6EmoBwwBHx+3SP7UFRTyvl+5g==
X-Received: by 2002:a05:600c:314c:b0:431:9a26:3cf6 with SMTP id 5b1f17b1804b1-432da7a050fmr21849185e9.4.1731586411150;
        Thu, 14 Nov 2024 04:13:31 -0800 (PST)
Received: from debian (2a01cb058d23d600b637ad91a758ba3f.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:b637:ad91:a758:ba3f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da29ffe9sm22060855e9.44.2024.11.14.04.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 04:13:30 -0800 (PST)
Date: Thu, 14 Nov 2024 13:13:28 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-omap@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, srk@ti.com,
	Pekka Varis <p-varis@ti.com>
Subject: Re: [PATCH net-next v3 2/2] net: ethernet: ti: am65-cpsw: enable
 DSCP to priority map for RX
Message-ID: <ZzXpaC7X2UBt77+2@debian>
References: <20241109-am65-cpsw-multi-rx-dscp-v3-0-1cfb76928490@kernel.org>
 <20241109-am65-cpsw-multi-rx-dscp-v3-2-1cfb76928490@kernel.org>
 <ZzVBS1zXIy31pnaf@debian>
 <76dd6141-5852-43ae-af98-f0edf0bc10f5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76dd6141-5852-43ae-af98-f0edf0bc10f5@kernel.org>

On Thu, Nov 14, 2024 at 11:41:06AM +0200, Roger Quadros wrote:
> On 14/11/2024 02:16, Guillaume Nault wrote:
> > So what about following the IETF mapping found in section 4.3?
> > https://datatracker.ietf.org/doc/html/rfc8325#section-4.3
> 
> Thanks for this tip.
> I will update this patch to have the default DSCP to UP mapping as per
> above link and map all unused DSCP to UP 0.
> 
> Is there any mechanism/API for network administrator to change this
> default mapping in the network drivers?

I'm not aware of any (appart from manual update with tc), but I could
have missed something. It'd probably make sense to have such a
mechanism though.

> >>  static void am65_cpsw_sl_ctl_reset(struct am65_cpsw_port *port)
> >>  {
> >>  	cpsw_sl_reset(port->slave.mac_sl, 100);
> >> @@ -921,6 +974,7 @@ static int am65_cpsw_nuss_ndo_slave_open(struct net_device *ndev)
> >>  	common->usage_count++;
> >>  
> >>  	am65_cpsw_port_set_sl_mac(port, ndev->dev_addr);
> >> +	am65_cpsw_port_enable_dscp_map(port);
> >>  
> >>  	if (common->is_emac_mode)
> >>  		am65_cpsw_init_port_emac_ale(port);
> >>
> >> -- 
> >> 2.34.1
> >>
> >>
> > 
> 
> -- 
> cheers,
> -roger
> 


