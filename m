Return-Path: <linux-kernel+bounces-530927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51178A43A42
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E6283B2A08
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F94262D1B;
	Tue, 25 Feb 2025 09:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="WkOHmzOu"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186A6261591
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476840; cv=none; b=LUQ1A3RjSocRKAljyHWb1uIm59+PoAhzTzZHrYw1BzyTSzt7QZO5L/rjNU2zBEhoVxdEtoXP7MNAsPALZs0XDvZb4fvpOIn2XSU+wInwwu6qW17XZugCvKfGsfw4YTBNcQonD0Ku8fFth/G0tiK0435RnVIqxTITy/TRC25EKTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476840; c=relaxed/simple;
	bh=1IHwqesQk08lufeZTBYIk2f7P1gwtjDf0lQkrtr/4QE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fg2oleUKTtpFvOIaJ+X2OA1EmKnKS3Pe2yYnCmUP4Rd/zM5mp87WilZ6ATjhtO5/uNRm/h0dqYSW8clRb0Z5cd++mRoFGQ9Q1bD/mTUDtbVKZ20KPdRAD7zWlPLBM6kLGVLLYvAZTpWm5pW1/5B+Lwj2G1manXMTKT76oOIMQ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=WkOHmzOu; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-439846bc7eeso33425145e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1740476837; x=1741081637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bU6pYEvOEizzQLjYkTI7JJD3Z+QYLCwitlQcIgyNBJQ=;
        b=WkOHmzOumY1waLkpjZw3tzL3PpXCVevPmR4kQrkd5p5vU/JgrqVMCrTBZYJMX0Nt8H
         8thHkM3Bq/e6U9llu74NZwYlZuBJQhb9y44XqMsXlGXWJt9FH0DFjX6PiD+UYThczyAB
         uJhizL991Q15oSU5f1BXEroqPXTdjg3OoOvZhH6zTy5ULmYXBFJK0iutp6KlBzba2iX/
         n/SOxo6jpikliu/BZaO4khcBuCEBV0rjOTIY8eKDUqKNkWL7JvFficEcwMXARJ18iNV+
         jQDxKq0GROiELff3l6ovzhG0WWdlfowseAbmxr+CuDLcroMnoEBCRRwZoSMVLT4eSdRh
         gjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740476837; x=1741081637;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bU6pYEvOEizzQLjYkTI7JJD3Z+QYLCwitlQcIgyNBJQ=;
        b=cCy5aE/XbULzEAHul6d9Zc8lzsmoW/3lyqJgczVb5nbZJR43SCzoyEuIpmO+GxlZXT
         /JMXVpb5kUT/i7kaHzUveqoAV+tH1Y5NdZgjGdorDf1Zc1DXycvALbClfFZPFXFAfIyN
         9CZNL1/k7+cHA1M5f01rZhhhNLvonDhmyk3C6801MO369zuGGhACad0+NakfQECxM52N
         B8PIL0zY7/DC16WwJtD4nd7hzSKpulL0rzAjbP+mpJKIYeFT78IECRDtRD22x+zcUP5z
         4wbRXnjrJjgUYy4VRHLOQ97xzngBjqZWdrSXzXkAhUcHi7gKGMJsQ245e5XJ+zOqa+fo
         1aqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIvraOTJAoI6+KQM6jnHu+CiWE4cZRT6BPb8XSCyD4UENSPV06/vGgXjZRbuFITcNe6KsQFIj2q//vwA0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Q8RdSs57XRDMaypba5/fa5uNT0uCR7oir+7y31Y0fphP6MDS
	Buo1lEJzpHvKvtPhGd4nRJVU6Vo+B+UlWFZ4jTH8EyGNpNv5qlPPF3/iA1tMHsU=
X-Gm-Gg: ASbGnctt5a5ZI68s85TyDjo+XFshe4SNiczROrvqlgeAybOExE+m7YtdU2yTParrnWC
	sv8yvj/LmXOJyTuC/J9CidRSPkbSD0fTBHLwgpbnc9cQpsD7GI55XphqgmRTF27mCKFRcoQifck
	Zgkzg15Xfaim22cH5YLRGqzDkZi2sB5u31mKrcPAdNwF7UnSTZEUL9cOxHOKEUD6UVnkjdU22Lz
	eLj+2nwBWmnsPrwzxoDNkdp2UcKrtM+PTuQQZcd377N6zoSpB4QeqziUuf4zBzKmEaatS3Ush+5
	hh0eN7S9N+10r2DyFx6oPRfHcXVKTuKCZe06UQJNhIzF6j5yv45kg6gJbA==
X-Google-Smtp-Source: AGHT+IEH9BuTR7e3cX9hlXLEtnZAxiSr3msyKmpW1dMtJNLMv3DVluSpKIXlP3IFKnIPJE4Vi+6X+w==
X-Received: by 2002:a05:600c:1c18:b0:439:96b2:e8f with SMTP id 5b1f17b1804b1-439ae21d19fmr131970375e9.28.1740476837202;
        Tue, 25 Feb 2025 01:47:17 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02ce740sm134182475e9.4.2025.02.25.01.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 01:47:16 -0800 (PST)
Message-ID: <2907ae61-5e67-4db7-89df-821da999fbf1@blackwall.org>
Date: Tue, 25 Feb 2025 11:47:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net-next] bonding: report duplicate MAC address in all
 situations
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org
References: <20250225033914.18617-1-liuhangbin@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250225033914.18617-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/25/25 05:39, Hangbin Liu wrote:
> Normally, a bond uses the MAC address of the first added slave as the bond’s
> MAC address. And the bond will set active slave’s MAC address to bond’s
> address if fail_over_mac is set to none (0) or follow (2).
> 
> When the first slave is removed, the bond will still use the removed slave’s
> MAC address, which can lead to a duplicate MAC address and potentially cause
> issues with the switch. To avoid confusion, let's warn the user in all
> situations, including when fail_over_mac is set to 2 or not in active-backup
> mode.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
> 
> v2: add fail_over_mac != BOND_FOM_ACTIVE to condition (Jakub Kicinski)
> 
> ---
>  drivers/net/bonding/bond_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 7d716e90a84c..7d98fee5a27f 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -2548,7 +2548,7 @@ static int __bond_release_one(struct net_device *bond_dev,
>  
>  	RCU_INIT_POINTER(bond->current_arp_slave, NULL);
>  
> -	if (!all && (!bond->params.fail_over_mac ||
> +	if (!all && (bond->params.fail_over_mac != BOND_FOM_ACTIVE ||
>  		     BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)) {
>  		if (ether_addr_equal_64bits(bond_dev->dev_addr, slave->perm_hwaddr) &&
>  		    bond_has_slaves(bond))

LGTM,
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


