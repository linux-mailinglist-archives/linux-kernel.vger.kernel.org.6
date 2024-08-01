Return-Path: <linux-kernel+bounces-271723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA81945296
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 20:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C28285AEA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 18:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3AE144D00;
	Thu,  1 Aug 2024 18:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FaShq5mO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEB813D897
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 18:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722535908; cv=none; b=s2sVQMbuNEUuF5XXAFHZMbu2hVC8o1Oe6R63NCCR1Fx2z4URltHfkeQJmWjxgVVyeyUnappUBe9huxEjbezsD5gA/JdOkIblLlvbRkEib5GVmYRbTDfUXqvpAztgUAvLVOgJKNWLVXOhCEt2RAr2Ky+hlf6gkaS9GjjRoKeThmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722535908; c=relaxed/simple;
	bh=MctUscgZWmB5L+QXzpP5rWOe/KjG8fcdYoZaNSy7iJI=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZrCbZM/HZ9WTeZg8SGz9A8/YBJ5/Q4jnzg36Z4i2D1fQ0bBzHu/GN7knAYl6p6nb7JvYL+m70TitXjDvzFJVRXqaoS/i3clw7e1LMAH4zVBvWL4iVdPtVrDt9sD8ytMWyUNT+96j5J6sxUoP+y5uRIhcL7wuW4gUjSSRtrLFGgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FaShq5mO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722535905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UFs6DZGB6pa5VGRBLXia2jk3EgSScNVHH/OnIjPEjP0=;
	b=FaShq5mO7dYCFBZF8KAheUARR7i1516oJ91fHGZEGfwIBSqDny2rfqCeH0abv/RIoGUiqn
	hu1K+1AcDOdzUbi7AR5HO08PZ3pFxxcA+xeaCxCT8fno98AAPe/n8ezTnHXxFZlTCz57yY
	ogqCIeOuG6penPr/lmSbMQ6yyLZPNnc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-wmeMDPYJMKeLPAZtBNo8kA-1; Thu, 01 Aug 2024 14:11:44 -0400
X-MC-Unique: wmeMDPYJMKeLPAZtBNo8kA-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1fc60ef3076so67595435ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 11:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722535903; x=1723140703;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UFs6DZGB6pa5VGRBLXia2jk3EgSScNVHH/OnIjPEjP0=;
        b=GKetAIWalfBSX4vavpCKyxAGOF/dGAkEKZtUqqTQpcpud1SZiuRrF2Nboka9qY7IKJ
         jVfERC21FShP3imR283JfIf/7F7IeWeGQZtDn8lgpLHH+17hROaEJCaa3H2ioGtQOdML
         Ga/tMXAQp0RuIQtbNcdNtwzzyut7fA3axDpDF0cee5HIGVtbvfhj5anobpbmM7zArkPN
         nNTH6ry8T4qPZIIQ+hKzgT6wz2BI9Xd42IJqJyOdAXM5dIoeRcNBLxXNnO7nmIzZYDXj
         KMws4VOeAKTcyN0NQaHaYoDq0IxsPBoIVcoKo5RgE1C3JzP2KWl/HKyUoa/4QcfGVp8f
         MNcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjpWTGUAQRmE+yiaSAFPDC+eYLYav6FDANh3s8iTX0A4+GTxX4zLmwl1+jDk/B/80ms9lbXnDizEuNTb/yuG7TwYd/0lI9KHONUy27
X-Gm-Message-State: AOJu0Yx9G0ufnTopQZRioesU86JsQuplz0pKuGdQXxoTUTTpqFJW/RFV
	/wZHYW1KmJvvxKnTk2dR1dHrEnMiwUqltGrGmWoyGfB59XZUUHNY1xO9cV/Duci9W2dEo579ta7
	36QZxODHUE3tGvVONyQxgL+soH4t8JnJ/fgHbfxTibQ5fUgrpR+jrNSq6kUsCJg==
X-Received: by 2002:a17:902:d4c5:b0:1ff:44db:7c4e with SMTP id d9443c01a7336-1ff57281a17mr15563645ad.24.1722535903085;
        Thu, 01 Aug 2024 11:11:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfKVbXRm2S06NcWKgBVNcZOtjfJCo2UBIRZRezjmZFUEZsJecWswaHXXqJkZXYLrp4O4H4zQ==
X-Received: by 2002:a17:902:d4c5:b0:1ff:44db:7c4e with SMTP id d9443c01a7336-1ff57281a17mr15563415ad.24.1722535902701;
        Thu, 01 Aug 2024 11:11:42 -0700 (PDT)
Received: from localhost ([240d:1a:c0d:9f00:523b:c871:32d4:ccd0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f2a138sm1889685ad.21.2024.08.01.11.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 11:11:42 -0700 (PDT)
Date: Fri, 02 Aug 2024 03:11:36 +0900 (JST)
Message-Id: <20240802.031136.1808840011597478143.syoshida@redhat.com>
To: jamie.bainbridge@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, johannes@sipsolutions.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net-sysfs: check device is present when showing
 duplex
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <52e9404d1ef3b11b1b5675b20242d3dc98a3e4bb.1722478820.git.jamie.bainbridge@gmail.com>
References: <52e9404d1ef3b11b1b5675b20242d3dc98a3e4bb.1722478820.git.jamie.bainbridge@gmail.com>
X-Mailer: Mew version 6.9 on Emacs 29.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Thu,  1 Aug 2024 12:22:50 +1000, Jamie Bainbridge wrote:
> A sysfs reader can race with a device reset or removal, attempting to
> read device state when the device is not actuall present.
> 
> This is the same sort of panic as observed in commit 4224cfd7fb65
> ("net-sysfs: add check for netdevice being present to speed_show"):
> 
>      [exception RIP: qed_get_current_link+17]
>   #8 [ffffb9e4f2907c48] qede_get_link_ksettings at ffffffffc07a994a [qede]
>   #9 [ffffb9e4f2907cd8] __rh_call_get_link_ksettings at ffffffff992b01a3
>  #10 [ffffb9e4f2907d38] __ethtool_get_link_ksettings at ffffffff992b04e4
>  #11 [ffffb9e4f2907d90] duplex_show at ffffffff99260300
>  #12 [ffffb9e4f2907e38] dev_attr_show at ffffffff9905a01c
>  #13 [ffffb9e4f2907e50] sysfs_kf_seq_show at ffffffff98e0145b
>  #14 [ffffb9e4f2907e68] seq_read at ffffffff98d902e3
>  #15 [ffffb9e4f2907ec8] vfs_read at ffffffff98d657d1
>  #16 [ffffb9e4f2907f00] ksys_read at ffffffff98d65c3f
>  #17 [ffffb9e4f2907f38] do_syscall_64 at ffffffff98a052fb
> 
>  crash> struct net_device.state ffff9a9d21336000
>    state = 5,
> 
> state 5 is __LINK_STATE_START (0b1) and __LINK_STATE_NOCARRIER (0b100).
> The device is not present, note lack of __LINK_STATE_PRESENT (0b10).
> 
> Resolve by adding the same netif_device_present() check to duplex_show.
> 
> Fixes: d519e17e2d01 ("net: export device speed and duplex via sysfs")
> Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>

Reviewed-by: Shigeru Yoshida <syoshida@redhat.com>

> ---
> v2: Restrict patch to just required path and describe problem in more
>     detail as suggested by Johannes Berg. Improve commit message format
>     as suggested by Shigeru Yoshida.
> v3: Use earlier Fixes commit as suggested by Paolo Abeni.
> ---
>  net/core/net-sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index 0e2084ce7b7572bff458ed7e02358d9258c74628..22801d165d852a6578ca625b9674090519937be5 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -261,7 +261,7 @@ static ssize_t duplex_show(struct device *dev,
>  	if (!rtnl_trylock())
>  		return restart_syscall();
>  
> -	if (netif_running(netdev)) {
> +	if (netif_running(netdev) && netif_device_present(netdev)) {
>  		struct ethtool_link_ksettings cmd;
>  
>  		if (!__ethtool_get_link_ksettings(netdev, &cmd)) {
> -- 
> 2.39.2
> 


