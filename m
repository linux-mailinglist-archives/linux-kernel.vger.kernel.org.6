Return-Path: <linux-kernel+bounces-322837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE334973040
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0B191C24222
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A7318C000;
	Tue, 10 Sep 2024 09:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dwWsWYAW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6A8188CB3
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962345; cv=none; b=he3Dy1THtd4jSJ5QiG6ujZTqMSOzEL451ruSnFDSEwVnxd4oaqIT/8QapjkJzNYJmjtK82bhL4KjmxauxVlg8CKkmZiUFxHcgRhO/Zio9eLqty6EA6K54gvXTxKiS3WBwyAaSLnIW2JruC9REC6ZbHKghhKSt5dErksvREoWlPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962345; c=relaxed/simple;
	bh=bQLe2pUIEEyUZE+/EAglMsUr+F12sN/BLUBijDrXSac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Edm8PuLhPW51UhCtboq1nSTm9bvkuZoUVhcA5QVQ8mfieJZt/y+aYpa8hWXrOXXbwVpisCxPhFgafFgdQaGNmY5jQk2JPuoaeIat1auWIlb4X9kQiEbf5Po2PcsmqpxBwkkWDr9DIVxHxZog1+zurs2mnI2rDLTgBaJki8H7qXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dwWsWYAW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725962342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jiUkwL8jiwz5bb5LLszsrQRqvrS9SIKe3P1nTjcI9RU=;
	b=dwWsWYAWI/uWKosgUnEVQj3alAgbhDX8IzmuB/v7r4TuiF9tZaQXwUkrlfOfL1C6N1t5H4
	GsCHCa/o7ldPtApcIbMHzwyooOO6OrXSOCux99ZTDSvuF46vwsb9i+zYKNqYpobLGGWX6f
	1b9JMEO7mjwZk8jle4DOmYdhLFk8VPQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-w56vGDLjNeisjoNAllrTrQ-1; Tue, 10 Sep 2024 05:59:01 -0400
X-MC-Unique: w56vGDLjNeisjoNAllrTrQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a8a877c1d22so253861866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 02:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725962340; x=1726567140;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jiUkwL8jiwz5bb5LLszsrQRqvrS9SIKe3P1nTjcI9RU=;
        b=EVcWLMur00zefPcWs28cI/E4sa3mMK44uWRVqm8rZWrDSroSpyCPViijccbpizqTA8
         DJz8bqN8py4t2TKSlmvAgspo2+BA7nBCkjJnctwqVjuRwmgQDxPMcrDPZmjMdITJTiM5
         PKJoZEa06fPYFdddo2TLr7204JsyZSG6ihZqEUfiQy71kA4NcaenBj7UlcjxVCrtkWee
         rKHdcOHxQyTNpnTdd5ZHRPdna9m6J1uoAFThXH1jfiDjQ36+WSc2rYn6XgN/NsZZ6RaU
         CQOyVTWA+BF+k6/Gu4BjZTKJuLXMjrtCOBFbblkT5tokzX4oesQfYg89arTfAdAMEj2E
         OGTA==
X-Forwarded-Encrypted: i=1; AJvYcCVaQ+2VfiOsH3/iN1ZokX8Pi1UKaKV/zfatvE2/ZIp3sw7Uruu02XTS0W81aM4rH/bhZfLA2RjZ6Smofqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZGdzO8f9dIQIoki/rMjzgAKEOv/E126NPKfc1gIJxTJEEsPyX
	hIxTjRzexT9McUKJVvLZgqUnUfn9owejLcdG6DzSzWeHKG90nPlfF9nEGqcapkqCJXQpxhioSCD
	3BezwcQBu2RfdfWeZsTfjQ6V7taxii6eQTqCEmXS7jPjcecZzcOgKi2x720Jl2Q==
X-Received: by 2002:a17:907:268e:b0:a86:8953:e1fe with SMTP id a640c23a62f3a-a8ffadf3c37mr21982766b.47.1725962339866;
        Tue, 10 Sep 2024 02:58:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERbuGqTbebYxtwPp+Ofxmyy5JzHR+T4dmVYSq8mepeZfuhvqFtrdMXLyJgC2KYWCtRG3tCIA==
X-Received: by 2002:a17:907:268e:b0:a86:8953:e1fe with SMTP id a640c23a62f3a-a8ffadf3c37mr21979466b.47.1725962339290;
        Tue, 10 Sep 2024 02:58:59 -0700 (PDT)
Received: from [192.168.88.27] (146-241-69-130.dyn.eolo.it. [146.241.69.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25830efdsm459314066b.41.2024.09.10.02.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 02:58:58 -0700 (PDT)
Message-ID: <ff23bcb5-d2e8-4b1b-a669-feab4a97994a@redhat.com>
Date: Tue, 10 Sep 2024 11:58:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net] usbnet: fix cyclical race on disconnect with work
 queue
To: Oliver Neukum <oneukum@suse.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20240905134811.35963-1-oneukum@suse.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240905134811.35963-1-oneukum@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/5/24 15:46, Oliver Neukum wrote:
> The work can submit URBs and the URBs can schedule the work.
> This cycle needs to be broken, when a device is to be stopped.
> Use a flag to do so.
> This is a design issue as old as the driver.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> CC: stable@vger.kernel.org
> ---
> 
> v2: fix PM reference issue
> 
>   drivers/net/usb/usbnet.c   | 37 ++++++++++++++++++++++++++++---------
>   include/linux/usb/usbnet.h | 17 +++++++++++++++++
>   2 files changed, 45 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> index 18eb5ba436df..2506aa8c603e 100644
> --- a/drivers/net/usb/usbnet.c
> +++ b/drivers/net/usb/usbnet.c
> @@ -464,10 +464,15 @@ static enum skb_state defer_bh(struct usbnet *dev, struct sk_buff *skb,
>   void usbnet_defer_kevent (struct usbnet *dev, int work)
>   {
>   	set_bit (work, &dev->flags);
> -	if (!schedule_work (&dev->kevent))
> -		netdev_dbg(dev->net, "kevent %s may have been dropped\n", usbnet_event_names[work]);
> -	else
> -		netdev_dbg(dev->net, "kevent %s scheduled\n", usbnet_event_names[work]);
> +	if (!usbnet_going_away(dev)) {
> +		if (!schedule_work(&dev->kevent))
> +			netdev_dbg(dev->net,
> +				   "kevent %s may have been dropped\n",
> +				   usbnet_event_names[work]);
> +		else
> +			netdev_dbg(dev->net,
> +				   "kevent %s scheduled\n", usbnet_event_names[work]);
> +	}
>   }
>   EXPORT_SYMBOL_GPL(usbnet_defer_kevent);
>   
> @@ -535,7 +540,8 @@ static int rx_submit (struct usbnet *dev, struct urb *urb, gfp_t flags)
>   			tasklet_schedule (&dev->bh);
>   			break;
>   		case 0:
> -			__usbnet_queue_skb(&dev->rxq, skb, rx_start);
> +			if (!usbnet_going_away(dev))
> +				__usbnet_queue_skb(&dev->rxq, skb, rx_start);
>   		}
>   	} else {
>   		netif_dbg(dev, ifdown, dev->net, "rx: stopped\n");
> @@ -843,9 +849,18 @@ int usbnet_stop (struct net_device *net)
>   
>   	/* deferred work (timer, softirq, task) must also stop */
>   	dev->flags = 0;
> -	del_timer_sync (&dev->delay);
> -	tasklet_kill (&dev->bh);
> +	del_timer_sync(&dev->delay);
> +	tasklet_kill(&dev->bh);
>   	cancel_work_sync(&dev->kevent);
> +
> +	/* We have cyclic dependencies. Those calls are needed
> +	 * to break a cycle. We cannot fall into the gaps because
> +	 * we have a flag
> +	 */
> +	tasklet_kill(&dev->bh);
> +	del_timer_sync(&dev->delay);
> +	cancel_work_sync(&dev->kevent);

I guess you do the shutdown twice because a running tasklet or timer 
could re-schedule the others? If so, what prevent the rescheduling to 
happen in the 2nd iteration? why can't you add usbnet_going_away() 
checks on tasklet and timer reschedule point?

Thanks,

Paolo


