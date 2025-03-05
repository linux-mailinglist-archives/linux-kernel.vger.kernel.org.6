Return-Path: <linux-kernel+bounces-547509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9763AA50A47
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EE5717288F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA0B253333;
	Wed,  5 Mar 2025 18:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YdKISRre"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236F12512EB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 18:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741200659; cv=none; b=ctp4qCG9oZkr+jlb+VUompub0S+5oKJ4783teXfja8/+oqIRVrGqsgzuNrlQmdT2ZfQRnI232MRsy2V1wkRf8gEFvjFtG2D6MSQnJk8bs4+VOl60JsVPogM9wMsTJU3VYu/fgEmB6cw3chQ/NAhzi4k4aDVJOVwJeh4giN47jdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741200659; c=relaxed/simple;
	bh=QbaAYVsuHtR4sFbwYlItPyeMtj1+0TldiW7il+PRxZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4nv2jahyUC8VnynXKPvhbessRDO5GSVMFyAZxImjcrb77cNm84uP4xHSYlmLqbaihfkor4jU0fMo8op1iJqxnw3ApWYJjnJ+Z85wgB+rQormBRi9F6npLqeLG7m5zO6ZCfKzEjDjVrYEDl3k9RN5c6KgJR+LCNVPtvSAj1sRYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YdKISRre; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-471fe5e0a80so64131431cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 10:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741200654; x=1741805454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7/tB8dYiu5A38nEKy58/W/Pt5oX/QvBFHO/wQ46XSc=;
        b=YdKISRre2vQzP5L91LnjrMPLlIWIMUyv0FCKNrb8H8ZEwRFG3hWoxi3tw6UQImAN8P
         dC2T8/fDqHcn71EDd95kew5KAHCLbRwWCmexzmO8KLYbo76tEQX/rL+/kFE13HKznSXJ
         VPIvClo7wJ+3I28B+lVMxtM19Ei0Rhm8tDZojPF9tqbMc+e8OOrMiHTNSgHxNPlw5Rxr
         Vy16yI2bw8ut1ptKtqydSYdWwQSjMtnzG3m6YpR914NO6TEEAmife16dDa1QUsA40Exw
         D+fz4MvGGySafE1nvAuaB1u0tWCggL2iFCW27B0Lh86hakThRBKcKgstH3wz4mk1Bz2X
         HM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741200654; x=1741805454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z7/tB8dYiu5A38nEKy58/W/Pt5oX/QvBFHO/wQ46XSc=;
        b=WWCTm6uV/aUMZz1DRxwLIKXMP/3CryyuF8o9WLBzkizW7S8bhRW73Wjemi9d/14qh5
         p/GIvtiM0CKPAaIDrskUKgGAQveVmRQneiBS+HOMst5BvfP9Apx+7+hQknBVSbjEnsWu
         jgDsIVKWybMnIZCc7mZm65t+tzWW6G8yJ4jNiiH6jkP67CvtVF1XbTfqQ9a7JOb5+GGz
         m69DdxfRCTPSVeerFwHxaA7v18YO6O7EF64090v+vS0BMINbiRV/rHDn/iuvnsSWY9vT
         St4FlBkE/TN0ZqjI7PPyryNtZ+nIsuqBKSnGpHhpAFXnaQwY4fwGwe11V4SWEAOZvBbj
         NpMg==
X-Forwarded-Encrypted: i=1; AJvYcCVacIOFAsECkMap8fiHvcQ8HmhaoDl0unIB5qSeJZxO1VOZiQ8MslgyagflLhgLbPLywhWy2QlnkgwVBB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1lCUTejgGScWRCGBEEjJ5JH6iKSR9QC4q27kCIVDNj/bMC2ea
	6N/yT0mBUDLo9bzqtjKPmjL6ajwlQSjuvOv2dZ/ZzOMSs6AD3pfZ56vVmYsEFtE=
X-Gm-Gg: ASbGncuw7PWNxMTN49UGAASN6D6zE+77jblDN+Aaavgblnimsb7b7PTodIpuuO4bCfO
	MdPLACJr1+ZV3rZjhI1Rrd6D38RBGFyaiy/Wx4FD2tRgYKB4Z2e52ayTo+8Wphoe/o7iC2aKfcS
	XeMWsUFGeg8DzUNrJvPv5rZ0HgeEMKpYkvCAtKYNOpmInZmCQ5HFpdoohrkNvz0+5+lRor/5r1k
	fGTa9fKapUy6ZzoByg/0H2P0m4OpcmWhLCSKAyAaHOZnogqj4XFP07cG2Ip42XW5j7IfQMfMejh
	60D6I2/yDpkq0tqORjuuywyl6k8cZ+LptIkC8mnL1m4uBHyvjrhT0ovdJxCwRBQ8LpC5bnGOd/3
	T02rFtkdI5B4s8PGPQg==
X-Google-Smtp-Source: AGHT+IHBfk4VjAwwmewmwy7/cD04QxrX3NO7CkQZxs6uiHniAKBSHBOE/omselhSlxfJQQW6JbT7mg==
X-Received: by 2002:a05:6214:518b:b0:6e6:60f6:56cf with SMTP id 6a1803df08f44-6e8e6cfffa9mr54007756d6.5.1741200653911;
        Wed, 05 Mar 2025 10:50:53 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8e8f52086sm10432506d6.63.2025.03.05.10.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 10:50:53 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tptpU-00000001UT9-2uWT;
	Wed, 05 Mar 2025 14:50:52 -0400
Date: Wed, 5 Mar 2025 14:50:52 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: longli@linuxonhyperv.com
Cc: Leon Romanovsky <leon@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	Long Li <longli@microsoft.com>
Subject: Re: [patch rdma-next v3 1/2] net: mana: Change the function
 signature of mana_get_primary_netdev_rcu
Message-ID: <20250305185052.GA354403@ziepe.ca>
References: <1741132802-26795-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1741132802-26795-1-git-send-email-longli@linuxonhyperv.com>

On Tue, Mar 04, 2025 at 04:00:01PM -0800, longli@linuxonhyperv.com wrote:
>  
> -struct net_device *mana_get_primary_netdev_rcu(struct mana_context *ac, u32 port_index)
> +struct net_device *mana_get_primary_netdev(struct mana_context *ac, u32 port_index)
>  {
>  	struct net_device *ndev;
>  
> -	RCU_LOCKDEP_WARN(!rcu_read_lock_held(),
> -			 "Taking primary netdev without holding the RCU read lock");
>  	if (port_index >= ac->num_ports)
>  		return NULL;
>  
> +	rcu_read_lock();
> +
>  	/* When mana is used in netvsc, the upper netdevice should be returned. */
>  	if (ac->ports[port_index]->flags & IFF_SLAVE)
>  		ndev = netdev_master_upper_dev_get_rcu(ac->ports[port_index]);
>  	else
>  		ndev = ac->ports[port_index];
>  
> +	dev_hold(ndev);
> +	rcu_read_unlock();

That's much better, yes

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

