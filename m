Return-Path: <linux-kernel+bounces-261681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B397693BAC1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 04:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E43671C23C49
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 02:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A33E101D4;
	Thu, 25 Jul 2024 02:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eYnaT24d"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E880E33CA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 02:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721874148; cv=none; b=skrasI1HY1o4qOZZLeEvIyY+WMr4qacBEQsSTT/pwe47KCfVo5CtnD7uvSxXNnsSHKw6FEFCibAvI/PyFW6c2sKlDNYBPyFiR9/iN574uxF1s1Mq+q4b6KdMTTBpFSRU0w7WVw/vRipa9pzzJHIQrOlQMWvfHuaUHcxto25WQ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721874148; c=relaxed/simple;
	bh=+MDDO5uES2QZNBYARbv0BJZlSSXziqFQDsrqrRNISpY=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mtKg7qrtbUOWdmTJcaCeIFBlEudg7nn/5BKm6D/TVEy6PHh8oRlSo+ppF7VpYZkn5nqfx3A1KD1upCALbt3Et6HrkF09d8AANUg7OwmXA5NoeLQlVcK3lZtzwl+5QS7upZdhOjfXhLQkwZsCNewKUJPaqlSSGbyQwO/xcrapBxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eYnaT24d; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721874145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oNGM3lA0lOrAeTXmmJtr9qZWns5lRzfinKRsjPGxJf0=;
	b=eYnaT24dAA/r2FiU91ZS0mfo1E+7zACLz9s7S4xT2blpZhrb09JCf9GKmtGOcWm8YpwndJ
	AeXGzC2XISJSv8Xh4TqNbXlRzRjre3ieJ9vCWSvQdogZ03T3N5/J7xcRDRg8YxiSpnUH49
	k6nYyGNnLvydinBgZPy/AxNDSyQituM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-w6BvB5X6PQ2GXNouzuwA3A-1; Wed, 24 Jul 2024 22:22:23 -0400
X-MC-Unique: w6BvB5X6PQ2GXNouzuwA3A-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2cb576921b6so524684a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 19:22:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721874143; x=1722478943;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oNGM3lA0lOrAeTXmmJtr9qZWns5lRzfinKRsjPGxJf0=;
        b=lPCjM78G3P32qz9p/O5bcFgkU4JgYXodGQnKsXv9ZT0334lJabHoxigpC/oCECyOJu
         7GsBipgeseoM6cFGgvaR8VZlsmluv9wVU58bGoCkpevy02SuqvFtG5IUd/GCaia79t8C
         RpB9ovndvJgAecbvhXDzDi5QAKJuvwtYHYr5Na/3MEDAjey8OPhdiUsJ49ru5F4OFvO9
         9V3LWAq7XO306GFNiZ6iT+r811R+HRp5U8fmFwik57hHzJqRBxg3cxIbQG2OJykB44qD
         Zulq5BKlh5OBXaoITe7USVDddvSoL3gGjkz0LOqO0ukoEnunydaWUp/sdEwKGIPJa9WX
         mvEw==
X-Forwarded-Encrypted: i=1; AJvYcCWeuvNwkgfO71Dvo5SuxBr86Vgkn6RVzLbaU0zzqZeXuS8dnA9EY2C7gf8QnzeD315py3jBEUrjUiXmWjdVElyvBpUOtEkctBSrY1Sd
X-Gm-Message-State: AOJu0YzFAw2AGxLU+Zuf91+60xXSeXO6497gdZknQZ8hawPHYhLDqrkJ
	39/hzPhqyULe0siVeuIjNfmn0tBXaIQQqdwfJ/3Vrf0klSnXFf+n+IqgpAmoJsRukUSTuGnxZ8W
	N7lS3WmZf6bSSzWwVzC9lecFLB0ph/CCWbW9j9FYfzBmy+fHu0eOiw/vct1Hgcg==
X-Received: by 2002:a17:90b:4b09:b0:2c4:ee14:94a2 with SMTP id 98e67ed59e1d1-2cf238ccadamr1769633a91.27.1721874142827;
        Wed, 24 Jul 2024 19:22:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU3inEA58dMWZvp16vrFg6KsKyTCzUVY/BbC397dqXMKNKyo3Sp/h85bina8DwsWLcGEL5qw==
X-Received: by 2002:a17:90b:4b09:b0:2c4:ee14:94a2 with SMTP id 98e67ed59e1d1-2cf238ccadamr1769620a91.27.1721874142482;
        Wed, 24 Jul 2024 19:22:22 -0700 (PDT)
Received: from localhost ([126.143.164.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c8bdb4sm2688555ad.21.2024.07.24.19.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 19:22:22 -0700 (PDT)
Date: Thu, 25 Jul 2024 11:22:17 +0900 (JST)
Message-Id: <20240725.112217.1430301118501739414.syoshida@redhat.com>
To: jamie.bainbridge@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, johannes.berg@intel.com,
 jiri@resnulli.us, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/4] net-sysfs: check device is present when
 showing carrier
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <066463d84fa14d5f61247b95340fca12d4d3bf34.1721784184.git.jamie.bainbridge@gmail.com>
References: <cover.1721784184.git.jamie.bainbridge@gmail.com>
	<066463d84fa14d5f61247b95340fca12d4d3bf34.1721784184.git.jamie.bainbridge@gmail.com>
X-Mailer: Mew version 6.9 on Emacs 29.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Jamie,

On Wed, 24 Jul 2024 11:46:50 +1000, Jamie Bainbridge wrote:
> A sysfs reader can race with a device reset or removal.
> 
> This was fixed for speed_show with commit 4224cfd7fb65 ("net-sysfs: add
> check for netdevice being present to speed_show") so add the same check
> to carrier_show.
> 
> Fixes: facd15dfd691 ("net: core: synchronize link-watch when carrier is queried")
> 
> Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>

nit: When resubmitting your fix, there is no need for a blank line
     between the Fixes and SOB tags.

Thanks,
Shigeru

> ---
>  net/core/net-sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index 0e2084ce7b7572bff458ed7e02358d9258c74628..7fabe5afa3012ecad6551e12f478b755952933b8 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -206,7 +206,7 @@ static ssize_t carrier_show(struct device *dev,
>  	if (!rtnl_trylock())
>  		return restart_syscall();
>  
> -	if (netif_running(netdev)) {
> +	if (netif_running(netdev) && netif_device_present(netdev)) {
>  		/* Synchronize carrier state with link watch,
>  		 * see also rtnl_getlink().
>  		 */
> -- 
> 2.39.2
> 
> 


