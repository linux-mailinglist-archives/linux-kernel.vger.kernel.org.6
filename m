Return-Path: <linux-kernel+bounces-410991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 074779CF161
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCE0C293E29
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC1F1D5146;
	Fri, 15 Nov 2024 16:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="oSHjg56A"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C001CEADF
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 16:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731687694; cv=none; b=bzOnrL7E+/5ZnOwNs47YW1lWvTx4lSUixD0L3X5D5bJZvEEEnDMefaxhVN08stViJWVOtmifl8BNLNnj53FJCAFJypOvEFfYQYgcx0+Sqo4xSED433GpyJpJyQ+07vwzXEXgefn3ujNvusioTFLumtiGFP3Gs9U/0QKhAPOWUBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731687694; c=relaxed/simple;
	bh=BzURog2WR1lvzdpQjIEB5UrUcLKtSO92TVEom4p7DnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XiG+AZs0IWJVcqyPY7u/J3ZnrosOvxrl/fi8J4DhJBkBR2CfYU8/WRk0hZ1URMVDBm0avZtRk/EobXa2fFG8nkOSY9rqs4EhNaaytQvjj68m3i/UfXyo7jmc4JPqBuzS3grDR7KVHB+pxvKxpa7lRZGp4U5O8b6Y8GU+Wg4yrKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=oSHjg56A; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53da5a27771so2324418e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 08:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1731687690; x=1732292490; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PBb8OTHxpga1dUPSRILcj6Z6qMT16617s30DMNtiCJM=;
        b=oSHjg56AwqYsLc6tBvazhdnfBBicJZisFupl3u1o3tJv0tFNh/tvDUojtw03v/k28/
         Bpg8ecLwBOZB7aZcBfpVw7od7KaIaudiTr4V1Qkqpt/J1jBkMenJkZzfJ5YZOsE4tPmd
         hKj27CDvoKDWsvYdB1Ms9BA0Vxrh+Rb4iSdNqyGZ9EjVHdGDHf8UrUFMG1aPtJp3g3VR
         HEZIPbrHiDkbO+pCXhhBkL94CnlO8tJ25F+wkqgJYiI3KrlHm5oDWLGY+hMia0j5/YXW
         fP0WNVo7ao/+gEH333Hap3edpI4F3VY/XfnwNKmrxkZEC8+NZeOnuzRc3MddM7oUm2Xj
         d6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731687690; x=1732292490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBb8OTHxpga1dUPSRILcj6Z6qMT16617s30DMNtiCJM=;
        b=WT/i4+K8sN7J+eYVsaQcTVM9UyHQwjU3bT6UB7kdRsAFgGqk+qsECdotZfHa8PElnm
         AHTW0PM/851uXoquyIh11VudkOUB/bOrDZ+HJZhaesJXmA/QYC3ak/FwNpB4DGBvqJCc
         UL2pH60YSsVdq1LGM0ndb3tTawSYAWXHSNhfFizv228jCap69UpJOOKCx96nnUj6NX8A
         beF/nA+FGkIEx/qMjFI6YlXvD8kgeYG8pQtSW9l6Fsmt656Y258IYM7NYon6Ctc26ZWO
         40LmBmUoUJ2vddAz1leqDWEmnbF7CspYqoldmwuXNktwOsUGn3uXjhCyqNv+1dapLDaC
         8DHA==
X-Forwarded-Encrypted: i=1; AJvYcCUh+uM3xVBmEDvsGNk+3Pl3Qh6xnKVtLZthZtn9+WRYAH155/UeINJVaGxD6ss1Wr5PskGJhuehQRDFq4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiuYUYH/Pj+tPdmAJx+CIXJ3W81vYNUfCOlYJ/Ze/PF5lFn2sD
	7mvq1xIKNDYleKd8J6kN0JX+PK6HiN5BHlqlXvTZreDBLse7TQ22HK0KXZSJO3k=
X-Google-Smtp-Source: AGHT+IGQaeefNvej67769wOg5MhvFAQbO92cQ4eqXqJpyq2omxsheBuQJGiQ0mULBdiTPTaNS+ivHw==
X-Received: by 2002:a05:6512:28a:b0:53d:ac13:795 with SMTP id 2adb3069b0e04-53dac130809mr1256281e87.0.1731687689697;
        Fri, 15 Nov 2024 08:21:29 -0800 (PST)
Received: from localhost ([62.205.150.185])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da6548876sm617971e87.230.2024.11.15.08.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 08:21:29 -0800 (PST)
Date: Fri, 15 Nov 2024 18:21:28 +0200
From: Nikolay Aleksandrov <razor@blackwall.org>
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: roopa@nvidia.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: bridge: Fix the wrong format specifier
Message-ID: <Zzd1CPHRIXAx8Vpk@penguin>
References: <20241114025820.37632-1-zhangjiao2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114025820.37632-1-zhangjiao2@cmss.chinamobile.com>

On Thu, Nov 14, 2024 at 10:58:20AM +0800, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> The format specifier of "unsigned long" in sprintf()
> should be "%lu", not "%ld".
> 
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---
>  net/bridge/br_sysfs_br.c | 8 ++++----
>  net/bridge/br_sysfs_if.c | 6 +++---
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 

Hi,
I think this patch is unnecessary (also should be targeted at net-next).
We may change the return value of br_timer_value to clock_t to be
consistent with jiffies_delta_to_clock_t(). It cannot return more than
a long, so %ld is fine here.

A simple patch like [1] can be considered to better show what is
being returned.

Thanks,
 Nik

[1]
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index f317d8295bf4..fbdadef68854 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1986,7 +1986,7 @@ void br_stp_rcv(const struct stp_proto *proto, struct sk_buff *skb,
 /* br_stp_timer.c */
 void br_stp_timer_init(struct net_bridge *br);
 void br_stp_port_timer_init(struct net_bridge_port *p);
-unsigned long br_timer_value(const struct timer_list *timer);
+clock_t br_timer_value(const struct timer_list *timer);
 
 /* br.c */
 #if IS_ENABLED(CONFIG_ATM_LANE)
diff --git a/net/bridge/br_stp_timer.c b/net/bridge/br_stp_timer.c
index 27bf1979b909..7b09fe3abd22 100644
--- a/net/bridge/br_stp_timer.c
+++ b/net/bridge/br_stp_timer.c
@@ -154,7 +154,7 @@ void br_stp_port_timer_init(struct net_bridge_port *p)
 }
 
 /* Report ticks left (in USER_HZ) used for API */
-unsigned long br_timer_value(const struct timer_list *timer)
+clock_t br_timer_value(const struct timer_list *timer)
 {
 	return timer_pending(timer)
 		? jiffies_delta_to_clock_t(timer->expires - jiffies) : 0;

> diff --git a/net/bridge/br_sysfs_br.c b/net/bridge/br_sysfs_br.c
> index ea733542244c..0edab3910d46 100644
> --- a/net/bridge/br_sysfs_br.c
> +++ b/net/bridge/br_sysfs_br.c
> @@ -266,7 +266,7 @@ static ssize_t hello_timer_show(struct device *d,
>  				struct device_attribute *attr, char *buf)
>  {
>  	struct net_bridge *br = to_bridge(d);
> -	return sprintf(buf, "%ld\n", br_timer_value(&br->hello_timer));
> +	return sprintf(buf, "%lu\n", br_timer_value(&br->hello_timer));
>  }
>  static DEVICE_ATTR_RO(hello_timer);
>  
> @@ -274,7 +274,7 @@ static ssize_t tcn_timer_show(struct device *d, struct device_attribute *attr,
>  			      char *buf)
>  {
>  	struct net_bridge *br = to_bridge(d);
> -	return sprintf(buf, "%ld\n", br_timer_value(&br->tcn_timer));
> +	return sprintf(buf, "%lu\n", br_timer_value(&br->tcn_timer));
>  }
>  static DEVICE_ATTR_RO(tcn_timer);
>  
> @@ -283,7 +283,7 @@ static ssize_t topology_change_timer_show(struct device *d,
>  					  char *buf)
>  {
>  	struct net_bridge *br = to_bridge(d);
> -	return sprintf(buf, "%ld\n", br_timer_value(&br->topology_change_timer));
> +	return sprintf(buf, "%lu\n", br_timer_value(&br->topology_change_timer));
>  }
>  static DEVICE_ATTR_RO(topology_change_timer);
>  
> @@ -291,7 +291,7 @@ static ssize_t gc_timer_show(struct device *d, struct device_attribute *attr,
>  			     char *buf)
>  {
>  	struct net_bridge *br = to_bridge(d);
> -	return sprintf(buf, "%ld\n", br_timer_value(&br->gc_work.timer));
> +	return sprintf(buf, "%lu\n", br_timer_value(&br->gc_work.timer));
>  }
>  static DEVICE_ATTR_RO(gc_timer);
>  
> diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
> index 74fdd8105dca..08ad4580e645 100644
> --- a/net/bridge/br_sysfs_if.c
> +++ b/net/bridge/br_sysfs_if.c
> @@ -155,21 +155,21 @@ static BRPORT_ATTR(state, 0444, show_port_state, NULL);
>  static ssize_t show_message_age_timer(struct net_bridge_port *p,
>  					    char *buf)
>  {
> -	return sprintf(buf, "%ld\n", br_timer_value(&p->message_age_timer));
> +	return sprintf(buf, "%lu\n", br_timer_value(&p->message_age_timer));
>  }
>  static BRPORT_ATTR(message_age_timer, 0444, show_message_age_timer, NULL);
>  
>  static ssize_t show_forward_delay_timer(struct net_bridge_port *p,
>  					    char *buf)
>  {
> -	return sprintf(buf, "%ld\n", br_timer_value(&p->forward_delay_timer));
> +	return sprintf(buf, "%lu\n", br_timer_value(&p->forward_delay_timer));
>  }
>  static BRPORT_ATTR(forward_delay_timer, 0444, show_forward_delay_timer, NULL);
>  
>  static ssize_t show_hold_timer(struct net_bridge_port *p,
>  					    char *buf)
>  {
> -	return sprintf(buf, "%ld\n", br_timer_value(&p->hold_timer));
> +	return sprintf(buf, "%lu\n", br_timer_value(&p->hold_timer));
>  }
>  static BRPORT_ATTR(hold_timer, 0444, show_hold_timer, NULL);
>  
> -- 
> 2.33.0
> 
> 
> 

