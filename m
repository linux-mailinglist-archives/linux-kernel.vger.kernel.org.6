Return-Path: <linux-kernel+bounces-409240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9C99C896B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E05B8B279C3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588F41779B8;
	Thu, 14 Nov 2024 12:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fznc+nOG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F095282EE
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731585778; cv=none; b=gkhmDchI/100WQYWRQAGq3fvUPGpAQdABADgjlB1mMrOdvnesRilpMypSAFb3ZO3yHsbHHreV1hy6fhFIEll4sXynpjNmm/rNIiEIW6lAQDmAfqPtzxpjzbOq4jJYt36jr0MYCvlfQzqIJdyNAhrRhBuSiqbk16ijo7kpRDw0dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731585778; c=relaxed/simple;
	bh=k8vvHLSi3/Ba27sZNaoHwLkf9qlD47v6sneOKR2gKYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwSzqyuFuE2CenT4WRLPdM2MN6WIl8/aLfSKfsNG7SrJA1XFUDj+88HsyA2JjhK8ROGr+OWniHlwA5LGw/+5+ychDZq9bX80fz9KuulrMZsK9vqrdemtndjFKfPc0gCi9Cgrmm5aovvbIO9E4vP6GsPKDaxjkJ35VErN1lUcAyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fznc+nOG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731585775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/zpQdMqKFFqaHRJ8M6WcgEvfRNF6AeI76vWq5L2MI+s=;
	b=Fznc+nOGaguHCQCc9mXTjW+lVWLTCJpI2Uq0LJgbLoPL/mcLadlXGvHbSvxYvKVTubXF/u
	ekIR2SKvcmjrA1fpUX9WEKnQh+49u0Lq2NGkuuTIbyqzPfdiHn+63fd4BS7SAIbYCtlb8w
	ErGQY9nvZzPIwFh0sB1awLatMYu1LQQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-WBKRkTFoNgu_H45VbjE2tg-1; Thu, 14 Nov 2024 07:02:54 -0500
X-MC-Unique: WBKRkTFoNgu_H45VbjE2tg-1
X-Mimecast-MFC-AGG-ID: WBKRkTFoNgu_H45VbjE2tg
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43154a0886bso4127505e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 04:02:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731585773; x=1732190573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/zpQdMqKFFqaHRJ8M6WcgEvfRNF6AeI76vWq5L2MI+s=;
        b=fHE7UEQxA3ZGfNN1U4ZMCgkqcV69unPq0DxVRFbYEyc3NWmgYPP9uMU92m3q29LX+v
         oaqrgenGwCUqUbTfkMnEgzoMb+20GUJxOT8NUH3XVEcA356YAUArQ2oGeBPkq1Rq2y2O
         Tc2Da0P9ls7fS9+cJB5FYN6cz2CiprskDAbJxrye07GXxy18EctARZTZbbi8vqsxo4Sw
         PUHwsEld2jZp76a+blxglR1D2yL0/lPx6ORclwGR/4ccOC8u+kJuhXuXRiq/i3jdhGTm
         OstleLM/jUnKI59Zcv/nZPeYy3nNoK88/0tU6aNAHElEhBnjwb4HurD/Axz5qJs44L4Q
         Ebeg==
X-Forwarded-Encrypted: i=1; AJvYcCW7jdSh4R2WFQ9k1+SaqwP7rSJwXc3R/3r2F0VDqVjPvl+HTStYedRt7FwjQZwqgNs7vYCClxlJ/bnC5tY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2lxlNHEv+ybaC3SXswnyTUfuPMzy1rHkyEdlemZZXQ1FKtSMv
	L0miJKQkGuFDxWbF3OeJ5k7sw7lQKpAaa8sd3dz7SXnSGWMX0e9veYN/emXbJlpRaFc2Jzgcw4F
	poCDn0jq59LBPF74hqXq4N2Q4TQcQ1iMo5+GZISEvtErZuoy2+5B8d3PSYwOCzQ==
X-Received: by 2002:a05:600c:4689:b0:431:57e5:b251 with SMTP id 5b1f17b1804b1-432da7dc45fmr14238835e9.28.1731585773171;
        Thu, 14 Nov 2024 04:02:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbgc10bxAJ/VIRFkaOi6IwkSPLAJX2D33rxzmsycb7616hQU5vNcmjB3rsRSBucznfT6zuWQ==
X-Received: by 2002:a05:600c:4689:b0:431:57e5:b251 with SMTP id 5b1f17b1804b1-432da7dc45fmr14238395e9.28.1731585772696;
        Thu, 14 Nov 2024 04:02:52 -0800 (PST)
Received: from debian (2a01cb058d23d600b637ad91a758ba3f.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:b637:ad91:a758:ba3f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da298a41sm21695655e9.38.2024.11.14.04.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 04:02:52 -0800 (PST)
Date: Thu, 14 Nov 2024 13:02:49 +0100
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
Message-ID: <ZzXm6SHjRfbaOX14@debian>
References: <20241109-am65-cpsw-multi-rx-dscp-v3-0-1cfb76928490@kernel.org>
 <20241109-am65-cpsw-multi-rx-dscp-v3-2-1cfb76928490@kernel.org>
 <ZzVBS1zXIy31pnaf@debian>
 <76dd6141-5852-43ae-af98-f0edf0bc10f5@kernel.org>
 <8bfe8acc-9514-4ba8-9498-2427ddb0bb78@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bfe8acc-9514-4ba8-9498-2427ddb0bb78@kernel.org>

On Thu, Nov 14, 2024 at 12:12:47PM +0200, Roger Quadros wrote:
> On 14/11/2024 11:41, Roger Quadros wrote:
> > On 14/11/2024 02:16, Guillaume Nault wrote:
> >> So what about following the IETF mapping found in section 4.3?
> >> https://datatracker.ietf.org/doc/html/rfc8325#section-4.3
> > 
> > Thanks for this tip.
> > I will update this patch to have the default DSCP to UP mapping as per
> > above link and map all unused DSCP to UP 0.
> 
> How does the below code look in this regard?

Looks generally good to me. A few comments inline though.

> static void am65_cpsw_port_enable_dscp_map(struct am65_cpsw_port *slave)
> {
> 	int dscp, pri;
> 	u32 val;
> 
> 	/* Default DSCP to User Priority mapping as per:
> 	 * https://datatracker.ietf.org/doc/html/rfc8325#section-4.3

Maybe also add a link to
https://datatracker.ietf.org/doc/html/rfc8622#section-11
which defines the LE PHB (Low Effort) and updates RFC 8325 accordingly.

> 	 */
> 	for (dscp = 0; dscp <= AM65_CPSW_DSCP_MAX; dscp++) {
> 		switch (dscp) {
> 		case 56:	/* CS7 */
> 		case 48:	/* CS6 */
> 			pri = 7;
> 			break;
> 		case 46:	/* EF */
> 		case 44:	/* VA */
> 			pri = 6;
> 			break;
> 		case 40:	/* CS5 */
> 			pri = 5;
> 			break;
> 		case 32:	/* CS4 */
> 		case 34:	/* AF41 */
> 		case 36:	/* AF42 */
> 		case 38:	/* AF43 */
> 		case 24:	/* CS3 */
> 		case 26:	/* AF31 */
> 		case 28:	/* AF32 */
> 		case 30:	/* AF33 */

Until case 32 (CS4) you've kept the order of RFC 8325, table 1.
It'd make life easier for reviewers if you could keep this order
here. That is, moving CS4 after AF43 and CS3 after AF33.

> 			pri = 4;
> 			break;
> 		case 17:	/* AF21 */

AF21 is 18, not 17.

> 		case 20:	/* AF22 */
> 		case 22:	/* AF23 */
> 			pri = 3;
> 			break;
> 		case 8:		/* CS1 */

Let's be complete and add the case for LE (RFC 8622), which also
maps to 1.

> 			pri = 1;
> 			break;
> 		default:
> 			pri = 0;
> 			break;
> 		}
> 
> 		am65_cpsw_port_set_dscp_map(slave, dscp, pri);
> 	}
> 
> 	/* enable port IPV4 and IPV6 DSCP for this port */
> 	val = readl(slave->port_base + AM65_CPSW_PORTN_REG_CTL);
> 	val |= AM65_CPSW_PN_REG_CTL_DSCP_IPV4_EN |
> 		AM65_CPSW_PN_REG_CTL_DSCP_IPV6_EN;
> 	writel(val, slave->port_base + AM65_CPSW_PORTN_REG_CTL);
> }
> 
> > 
> > Is there any mechanism/API for network administrator to change this
> > default mapping in the network drivers?
> > 
> >>
> >>>  static void am65_cpsw_sl_ctl_reset(struct am65_cpsw_port *port)
> >>>  {
> >>>  	cpsw_sl_reset(port->slave.mac_sl, 100);
> >>> @@ -921,6 +974,7 @@ static int am65_cpsw_nuss_ndo_slave_open(struct net_device *ndev)
> >>>  	common->usage_count++;
> >>>  
> >>>  	am65_cpsw_port_set_sl_mac(port, ndev->dev_addr);
> >>> +	am65_cpsw_port_enable_dscp_map(port);
> >>>  
> >>>  	if (common->is_emac_mode)
> >>>  		am65_cpsw_init_port_emac_ale(port);
> >>>
> >>> -- 
> >>> 2.34.1
> >>>
> >>>
> >>
> > 
> 
> -- 
> cheers,
> -roger
> 


