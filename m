Return-Path: <linux-kernel+bounces-409576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF9D9C902D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2840B3DF29
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C9A18CBFB;
	Thu, 14 Nov 2024 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hk2RmyJi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484EC18C93B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 15:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599008; cv=none; b=bKT1DLCTkR7Qg/TLWQBaRsa3puqQtAdaw/3q7M4CqeOQtffdm0OTNTMx8EZZQ6WIxLkl8XjqBtsjo6cvDoBsodPmvcWz5M1rFZwk2YAsqczR2Jcu4sTusnfCPuQxb5MbUs/dq/NSVuUciywt6q9Hey6lu7SgssT332F3b9Nz398=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599008; c=relaxed/simple;
	bh=cpkpvcI4nnZ6IoTG09tDrpa0CY5qnKUuAFVyTovamKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5Hq7jI8f6rjMLzG7L1GX0V/Pw6pys8BroMzsrjUJUIfaqSOOrVSQB2VJGGQeqphtyyv03GbcwTvlBTI2HzS8NYaonX5MDf7uzxMV4smfi47dLbexivDLtB+UzVJegdeM6t4hePnQW5R4J3CXH/4ZC0H/Z1lxiWaysXbzeGXyUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hk2RmyJi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731599005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KXhPhd6T64qopenKzDTr2VAsOd523bKkU/nV0+x9Uek=;
	b=hk2RmyJieVoXxBUN/MHMCH3CE+uJGtyjk7MJbvHjhY3Ao12y2yx+hW25cR80ceBtISPdlo
	j57s2qvHuk656ej4WsfvPU0c2TPx90ihequNau5sOWWPkuMFTFQVNCYWZVAhyn4bTpDOr9
	BeMhN6URCBjtVgvxTRJh7sdV52hImrE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-_uDreFciNMi67oky-dwXPQ-1; Thu, 14 Nov 2024 10:43:23 -0500
X-MC-Unique: _uDreFciNMi67oky-dwXPQ-1
X-Mimecast-MFC-AGG-ID: _uDreFciNMi67oky-dwXPQ
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38218576e86so469174f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:43:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731598998; x=1732203798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXhPhd6T64qopenKzDTr2VAsOd523bKkU/nV0+x9Uek=;
        b=HiwvpDYl88ViIYpVgO5aULSRqaA6K11PNRhhw4xiBqlIMR/x6wb8VMmMSC6+Zm/e8Q
         qUBOrNODfGPTINJ0iGZzBlMNAaqSRH/Kcf5+GGeFa/wE+cGjTG8JcoNDjiISV7Oh7Gr+
         XUhcozsmPQFfCwTewAabtTsHGFGcNVyvnfxVOfctLAF0vW6WhUp4b1+Q5rGKfpufDs9l
         4WfObvkCsn8Uvc1qN+RfpHSzQXmHKsQiR2jYpCKfi7BoC7J1Vyyn3HTwv3wsqf9a9l2u
         aNy6PMoOiBS+KBnNUm+Zrlz/ndhNu1p09JN6JpSzi0zQLc8B8o/hlBx6HGij+7S/qhC0
         hQOA==
X-Forwarded-Encrypted: i=1; AJvYcCUyeQVniXjGNWCABv90e3+qqCBF75ntiYntCopbZQZZqopY0wnPsPo9mW06g9o0ieeHvTF8dNEV7q6SuIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZfxCgvPVqA6blPjs5oEBPdhRL3w1cXuPZ0ywPo4ZMv6eI6CY5
	WHp8ZVb4JSN4/JlUpgLels6MFGr2e2Lo0KvAvSciJzH4TOS0RcD2xvaBFvb0ESn8EaV1KBvjAQD
	qhIVvOKO71Dk+1f/xdI5ZTzAyZpRlHIrH8j27u4QEUfsAeYEJKBm1HYV1DNRbaw==
X-Received: by 2002:a05:6000:184f:b0:381:e771:e6dc with SMTP id ffacd0b85a97d-382140752femr3138946f8f.28.1731598998152;
        Thu, 14 Nov 2024 07:43:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoMlXHEHIIIf/8vuBedCySo4LpdsmnKwwPgZlfZJLBlokpUPY1g/zGswFuAox/GMsDltKRSg==
X-Received: by 2002:a05:6000:184f:b0:381:e771:e6dc with SMTP id ffacd0b85a97d-382140752femr3138917f8f.28.1731598997736;
        Thu, 14 Nov 2024 07:43:17 -0800 (PST)
Received: from debian (2a01cb058d23d600b637ad91a758ba3f.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:b637:ad91:a758:ba3f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432dab7206csm24235755e9.7.2024.11.14.07.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 07:43:17 -0800 (PST)
Date: Thu, 14 Nov 2024 16:43:15 +0100
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
Subject: Re: [PATCH net-next v4 1/2] net: ethernet: ti: am65-cpsw: update
 pri_thread_map as per IEEE802.1Q-2014
Message-ID: <ZzYak49k8fQC76/+@debian>
References: <20241114-am65-cpsw-multi-rx-dscp-v4-0-93eaf6760759@kernel.org>
 <20241114-am65-cpsw-multi-rx-dscp-v4-1-93eaf6760759@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114-am65-cpsw-multi-rx-dscp-v4-1-93eaf6760759@kernel.org>

On Thu, Nov 14, 2024 at 03:36:52PM +0200, Roger Quadros wrote:
> IEEE802.1Q-2014 supersedes IEEE802.1D-2004. Now Priority Code Point (PCP)
> 2 is no longer at a lower priority than PCP 0. PCP 1 (Background) is still
> at a lower priority than PCP 0 (Best Effort).

Reviewed-by: Guillaume Nault <gnault@redhat.com>

> Reference:
> IEEE802.1Q-2014, Standard for Local and metropolitan area networks
>   Table I-2 - Traffic type acronyms
>   Table I-3 - Defining traffic types
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  drivers/net/ethernet/ti/cpsw_ale.c | 36 ++++++++++++++++++++++--------------
>  1 file changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/cpsw_ale.c b/drivers/net/ethernet/ti/cpsw_ale.c
> index 8d02d2b21429..9f79056b3f48 100644
> --- a/drivers/net/ethernet/ti/cpsw_ale.c
> +++ b/drivers/net/ethernet/ti/cpsw_ale.c
> @@ -1692,26 +1692,34 @@ static void cpsw_ale_policer_reset(struct cpsw_ale *ale)
>  void cpsw_ale_classifier_setup_default(struct cpsw_ale *ale, int num_rx_ch)
>  {
>  	int pri, idx;
> -	/* IEEE802.1D-2004, Standard for Local and metropolitan area networks
> -	 *    Table G-2 - Traffic type acronyms
> -	 *    Table G-3 - Defining traffic types
> -	 * User priority values 1 and 2 effectively communicate a lower
> -	 * priority than 0. In the below table 0 is assigned to higher priority
> -	 * thread than 1 and 2 wherever possible.
> -	 * The below table maps which thread the user priority needs to be
> +
> +	/* Reference:
> +	 * IEEE802.1Q-2014, Standard for Local and metropolitan area networks
> +	 *    Table I-2 - Traffic type acronyms
> +	 *    Table I-3 - Defining traffic types
> +	 * Section I.4 Traffic types and priority values, states:
> +	 * "0 is thus used both for default priority and for Best Effort, and
> +	 *  Background is associated with a priority value of 1. This means
> +	 * that the value 1 effectively communicates a lower priority than 0."
> +	 *
> +	 * In the table below, Priority Code Point (PCP) 0 is assigned
> +	 * to a higher priority thread than PCP 1 wherever possible.
> +	 * The table maps which thread the PCP traffic needs to be
>  	 * sent to for a given number of threads (RX channels). Upper threads
>  	 * have higher priority.
>  	 * e.g. if number of threads is 8 then user priority 0 will map to
> -	 * pri_thread_map[8-1][0] i.e. thread 2
> +	 * pri_thread_map[8-1][0] i.e. thread 1
>  	 */
> -	int pri_thread_map[8][8] = {	{ 0, 0, 0, 0, 0, 0, 0, 0, },
> +
> +	int pri_thread_map[8][8] = {   /* BK,BE,EE,CA,VI,VO,IC,NC */
> +					{ 0, 0, 0, 0, 0, 0, 0, 0, },
>  					{ 0, 0, 0, 0, 1, 1, 1, 1, },
>  					{ 0, 0, 0, 0, 1, 1, 2, 2, },
> -					{ 1, 0, 0, 1, 2, 2, 3, 3, },
> -					{ 1, 0, 0, 1, 2, 3, 4, 4, },
> -					{ 1, 0, 0, 2, 3, 4, 5, 5, },
> -					{ 1, 0, 0, 2, 3, 4, 5, 6, },
> -					{ 2, 0, 1, 3, 4, 5, 6, 7, } };
> +					{ 0, 0, 1, 1, 2, 2, 3, 3, },
> +					{ 0, 0, 1, 1, 2, 2, 3, 4, },
> +					{ 1, 0, 2, 2, 3, 3, 4, 5, },
> +					{ 1, 0, 2, 3, 4, 4, 5, 6, },
> +					{ 1, 0, 2, 3, 4, 5, 6, 7 } };
>  
>  	cpsw_ale_policer_reset(ale);
>  
> 
> -- 
> 2.34.1
> 


