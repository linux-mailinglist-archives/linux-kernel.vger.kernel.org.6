Return-Path: <linux-kernel+bounces-341121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EC2987B8F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 01:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98D0EB22A50
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 23:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C031B0112;
	Thu, 26 Sep 2024 23:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="eBoBInP2"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00D418595C
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 23:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727392629; cv=none; b=Xfr5Lntm61zwnclcw+UlDS1+hacWBuOfAgEMebUw1zveSk/AM27jFu2HaYBh5UTh6F+spg//kvSjrkSn9LzFMn4/qTkUO0SpR1cPgsxQoHlJKIAo1sQSw8kthQW0p8rooA5q6uovH9Wi8eOP2emEUOEo+HstCIOmyhVgjcpOYkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727392629; c=relaxed/simple;
	bh=a7MI9KiIKidxw9pZ4VUV1FeyoQptTtyii6FSdZH1sY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGYNsd/cxZuqTA5qXrmWxeTWdWpBvEnL6LXKrWgJqTcgC2063EnMoNocbQ98KI138nxFQcXLn3xt/qbE/aLzzc2rLoYQxjKYtqrvr2fhlfxuZP4XrzSzZBii0bC861XxNQXy0w81SwW6euLNoge58EWmdld5UTbcc+vtMvk2x2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=eBoBInP2; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7db238d07b3so1160992a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 16:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727392627; x=1727997427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hoZQeXQpdVv1ClfssWmLJ5mlRbM3gmJO70OqTgXM0oU=;
        b=eBoBInP24OWRfkUUKk/zwZUxhXqaCWxn4LZxH1HGXi9tcGoEM8W5/S0RQSQTqhe9Wo
         S+/FPk+wQvR4167RjRzZlIjPEl14QvlNTo4Dc+0B9xbTyCa8yNtyMS/jC2Iq2rGwMZo2
         RU52Nlz/zSOuiUaapUO5nAp+V/PmsNoCZm3Y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727392627; x=1727997427;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hoZQeXQpdVv1ClfssWmLJ5mlRbM3gmJO70OqTgXM0oU=;
        b=iAjMvxT5H0PSr2OuHdQJ3OakL3n9+tp59xYboSW9y1Y7Gcrbfwdjv1aqeNVNPGEKnA
         h+lZysH7wFMqTcTBCi4QfV5fqmbx28TEo0+o3878G9kYZ/GeD1k8zI2JipUfNOlK0sRz
         nnO6oh0aU/myzWJKy4LhFf8cMZCqUxCQ/skk/aUY38fXL7aoMJFIKJsigzQ7zbj/qFIS
         IbbPV7SPv6GNFu+1Ytv2n+pQCtGu3eBYPXUyDLyk+3bixZMWNhxpG3QyBcbC6f3RuMJq
         REYutrfZvDXnayY68X4+mMZ6igY1Rr/wJxoG/gfv/EX3+wTWsOk6n1AKRQSCbihiBKkp
         hi2w==
X-Forwarded-Encrypted: i=1; AJvYcCWMEtoCOCabbVPrdyYkjIGeYemuSkdEpKrJdjwkw1H/UXa9JWuMlc8DfhlPhp39cPHPTgvkhlCDNQlRcWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUfUTvEUrHI5PYquEGY+0b1s001vVUAMZIlbJDOCgwYrGiru1c
	KUkyNZrOWyLDPgrpX/61cJjTCafzuKnVA2lHEn0hBuBMYLcQL+6SsA200iP8uu8=
X-Google-Smtp-Source: AGHT+IHuO4Ejf4QeXQ3Q0Bn1MZQSUX0Pl3sC3pt0ykL3dDFq5UHiVkjqbiYIK0e/M1GziGUwOsvaLA==
X-Received: by 2002:a05:6a21:6e4a:b0:1cf:50ce:58d7 with SMTP id adf61e73a8af0-1d4fa6c7bc4mr1810104637.29.1727392627081;
        Thu, 26 Sep 2024 16:17:07 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26515db1sm427410b3a.102.2024.09.26.16.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 16:17:06 -0700 (PDT)
Date: Thu, 26 Sep 2024 16:17:03 -0700
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v2 2/2] tg3: Link queues to NAPIs
Message-ID: <ZvXrbylj0Qt1ycio@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20240925162048.16208-1-jdamato@fastly.com>
 <20240925162048.16208-3-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925162048.16208-3-jdamato@fastly.com>

On Wed, Sep 25, 2024 at 04:20:48PM +0000, Joe Damato wrote:
> Link queues to NAPIs using the netdev-genl API so this information is
> queryable.
> 
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
>                          --dump queue-get --json='{"ifindex": 2}'
> 
> [{'id': 0, 'ifindex': 2, 'type': 'rx'},
>  {'id': 1, 'ifindex': 2, 'napi-id': 146, 'type': 'rx'},
>  {'id': 2, 'ifindex': 2, 'napi-id': 147, 'type': 'rx'},
>  {'id': 3, 'ifindex': 2, 'napi-id': 148, 'type': 'rx'},
>  {'id': 0, 'ifindex': 2, 'napi-id': 145, 'type': 'tx'}]
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  drivers/net/ethernet/broadcom/tg3.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
> index ddf0bb65c929..f78d7e8c40b2 100644
> --- a/drivers/net/ethernet/broadcom/tg3.c
> +++ b/drivers/net/ethernet/broadcom/tg3.c
> @@ -7395,18 +7395,34 @@ static int tg3_poll(struct napi_struct *napi, int budget)
>  
>  static void tg3_napi_disable(struct tg3 *tp)
>  {
> +	struct tg3_napi *tnapi;
>  	int i;
>  
> -	for (i = tp->irq_cnt - 1; i >= 0; i--)
> -		napi_disable(&tp->napi[i].napi);
> +	ASSERT_RTNL();
> +	for (i = tp->irq_cnt - 1; i >= 0; i--) {
> +		tnapi = &tp->napi[i];
> +		if (tnapi->tx_buffers)
> +			netif_queue_set_napi(tp->dev, i, NETDEV_QUEUE_TYPE_TX, NULL);

It looks like the ASSERT_RTNL is unnecessary; netif_queue_set_napi
will call it internally, so I'll remove it before sending this to
the list (barring any other feedback).

>  static void tg3_napi_enable(struct tg3 *tp)
>  {
> +	struct tg3_napi *tnapi;
>  	int i;
>  
> -	for (i = 0; i < tp->irq_cnt; i++)
> -		napi_enable(&tp->napi[i].napi);
> +	ASSERT_RTNL();
> +	for (i = 0; i < tp->irq_cnt; i++) {
> +		tnapi = &tp->napi[i];
> +		napi_enable(&tnapi->napi);
> +		if (tnapi->tx_buffers)
> +			netif_queue_set_napi(tp->dev, i, NETDEV_QUEUE_TYPE_TX, &tnapi->napi);

Same as above.

