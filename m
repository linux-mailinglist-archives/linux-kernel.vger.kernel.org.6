Return-Path: <linux-kernel+bounces-568742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2299EA69A01
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935F619C428F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEAF214A74;
	Wed, 19 Mar 2025 20:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="A/YtrUwG"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2305620AF7D
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 20:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742415032; cv=none; b=oKuiy3U/RNSs0j1kCdh5Y1hB3Q9R7Vfjt5VVYrFrrWyCi5CeUM4OOwgrUeK8lgJ8H4/C5W6hSMgeL2N1JRUpBnbQTNzziPUYRXsgNrsbTuKgoMBcPlAWnx0jJFI7B0s+Dv130lFsqHZRdjeUdFyQiVAxWGdikRrFMEhCfQcCS3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742415032; c=relaxed/simple;
	bh=vVZNcEldGhErQzhychdSjKJkRDHaf5oXhzK5hCpX2Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOdB/ZpDw5HORkrjLxmg22wBf0YlOaDnRqyY/+BlO8YZke13YrX+xa7+k6YpVyYvCha8kbAHitiFyxxHe8dHJ0x6rUclmaP+YTnj/R/2FxnBLTTzVI/J5/1XxUSTgkmSmneH05mquRH2yI2FaBv81rb97IO+0PHKFGVgoZMa2/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=A/YtrUwG; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-30185d00446so84687a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 13:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742415030; x=1743019830; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEtyN/8iItZX0k96FPtUzWxAFcWBC5d55M1vhm8J8RY=;
        b=A/YtrUwGjIJsIK0FJ8JcNF1C0K6vgEzwuVqjRkMsH8HsUvYz/KvDG+ylAE67DGS8cS
         VcHH5YIDuwYiw+Yj1s5lxFB4xYokSsuUGR47VRIAIczqmBf10WtUoICPYVi/qre6P/RW
         W8oZgJrp53w/Gs3YHdTzvoCuL8DhliOei387Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742415030; x=1743019830;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DEtyN/8iItZX0k96FPtUzWxAFcWBC5d55M1vhm8J8RY=;
        b=rhbCu3c4BSaIiwRypCGmcC7kRHagrnaeQIhoSbx2+GBKj2Q/5UJGMfj0VRrmcYIBn7
         MJnNcZAurWJnOl2VujSjBrtbQa1+6gtK8jnrj876BPpgDrqLMfYgdpM/R8rhq4wLs1Ms
         xxSE/fW8QW5mcwis/uxVsLoDqRMt7ojFHN4J5ViRKBoHrpb9sQzSDYrTX1Yizsp0ZXMo
         REuJYbPXH30RSAOoqrR0PiHWwdULxUY165k1Jljj79QoQhPs2isyT5ynM41HK+NKbcbO
         TQFqsoJb7Sc6TfVAC622zDoGH5/aRMJTgGsbTegcnzCsQ30wdu5KVfw8PUa0VShuPmaC
         QvlA==
X-Forwarded-Encrypted: i=1; AJvYcCWfn0yyju145ekEx3vcFrqo573lVFDbxP19ibllWFOLSzMxOVfZnHGC1Vf3zFsuyD0tJVmZZEWmUlIipQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj1LPPp774ZB31SFpx5nthA/yt6F/2CnthsSW4fKilhwug5yAr
	/8KJGdtBoGwRe8fUI40NCW5ge9TogDhEEp/bcAOi/XYZ2rizSGGv6jLlz9ciqFo=
X-Gm-Gg: ASbGncvarUuJKcWGuBf1cuMNdImJ/thypOnheMM1PNSC15DADYaj5Riex3voJfhZJN5
	PEQ0slpSbamZcJTQZigkutyKgfQnBGWV1tXR3TZ4wcqoD+LbOOt3hLpoasqsuCGpOVdHnaeDUxb
	HhafsmKP25HZsqNn4wXekWqOy6ozmvQVi5Bxqps/r2UtuBmCLSeDxt4okKQxL65BHY1NerGPBY9
	T3hFE58o7gOxeNbUgbDbylunYPeWS6CgdTh8+pyCU2b9cEO4OeutfegJwa9sBeymF/UdpvdRoWr
	iKXBsoyLREFHqmLn/NOBDXnEFGgWpYIORRT372I6e9ok1SujrU1K1uK1PUBrSoS5QTPIfqV/9Lq
	1vqUOoXIK53wR1rYloFJ7Bkn8Hzo=
X-Google-Smtp-Source: AGHT+IFYLxVyUqkLnV2m1VRjw9PzOMK+Xq+FeIEXzbiMp8R0mTZXmDwpyjpsyHGwLtXhjq0xg5cazA==
X-Received: by 2002:a17:90b:528f:b0:2ee:8cbb:de28 with SMTP id 98e67ed59e1d1-301d42e4d3dmr1380853a91.8.1742415030368;
        Wed, 19 Mar 2025 13:10:30 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbffc2sm119374975ad.162.2025.03.19.13.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 13:10:29 -0700 (PDT)
Date: Wed, 19 Mar 2025 13:10:27 -0700
From: Joe Damato <jdamato@fastly.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] netpoll: Eliminate redundant assignment
Message-ID: <Z9sks79ntumxlsjP@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Breno Leitao <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20250319-netpoll_nit-v1-1-a7faac5cbd92@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319-netpoll_nit-v1-1-a7faac5cbd92@debian.org>

On Wed, Mar 19, 2025 at 10:02:44AM -0700, Breno Leitao wrote:
> The assignment of zero to udph->check is unnecessary as it is
> immediately overwritten in the subsequent line. Remove the redundant
> assignment.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/core/netpoll.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/net/core/netpoll.c b/net/core/netpoll.c
> index 3cc3eae9def30..4e1dba572f5ac 100644
> --- a/net/core/netpoll.c
> +++ b/net/core/netpoll.c
> @@ -433,7 +433,6 @@ int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
>  	udph->len = htons(udp_len);
>  
>  	if (np->ipv6) {
> -		udph->check = 0;
>  		udph->check = csum_ipv6_magic(&np->local_ip.in6,
>  					      &np->remote_ip.in6,
>  					      udp_len, IPPROTO_UDP,
> 
> ---
> base-commit: 23c9ff659140f97d44bf6fb59f89526a168f2b86
> change-id: 20250319-netpoll_nit-6390753708bc

Reviewed-by: Joe Damato <jdamato@fastly.com>

