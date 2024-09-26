Return-Path: <linux-kernel+bounces-340693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B0F9876BB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EE11B2745B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852AE155756;
	Thu, 26 Sep 2024 15:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="YEXEwj5s"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBBC14D71D
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 15:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727365358; cv=none; b=KXREEPM6MUEnfFSZJBIo7+rSiLfXr3w5Y2F5ZuEgW8o8K3y9Vf/6rILPglGgV6ayahZ3Cnwt2kGkRezXcrsfh8iG1DTvkahygXiJ+FLaxQdmD9lQ/zEaQCCEX9+7qYv6LaxCt4TJWgTURLNW+FtEyqrsLvpE1GqKyvF0JgnEy5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727365358; c=relaxed/simple;
	bh=YuuuYFG9J6VIce5wSFAppgfU6UAh20cdv9dMb/gRV8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtwBRleTHuu5NtaMnjeyP1UvR4OzvjZFEhqlDhjAF2+/WcSjpvYZZ10VpxXSm3eD4frycQUdZ7sJfts0A896/sN7xuGbjosdKBE0VkWDmVtYntrl4jVR8Jx74WpS2zu9F1rLAwSgI/vpsc2biBHebHlJqXKf+4nWM7h3/rhA3x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=YEXEwj5s; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e053f42932so892047a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727365357; x=1727970157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Mlojj9wGfJRRsMDZ0gQ5kDpNUAhG0uppHae6Ab1B3Y=;
        b=YEXEwj5sSkdReSdTFRYnpGAAUl4aIMuDl9WwhAV006NHTSFEomnjWRFx3cjZE4BhE3
         0HtJyVuWy6OkKRLdTHF/aVZgXC36jlzqTu4vy6IRmVDEPnKRDCb4WPwFpHqvWbAkInlN
         d/7YIxb9iR0HyQQHPIixJp55APwq9hF1F+70U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727365357; x=1727970157;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Mlojj9wGfJRRsMDZ0gQ5kDpNUAhG0uppHae6Ab1B3Y=;
        b=t+oc4y/u7vDdTkn66an01lSUex/NbRgPQDYE0YbJuQPxPBTFIX+vGBX0JRff1igrgC
         1kWHtqY+qzDy24XP6xAVCAaDnAAdTUDnOW7TMTgjNKUXMPIUTfogBhLFlIErX/GZsTwU
         pTCyHXQmQm9wCu3m251Khr63AKyxL+6rGqSXhMiAgOvXhNVIG1FVn3aU79hkzzKEm62F
         n3FBGwFgr4grCgOVWUK33ADv7DrJUK0TCxyhadqWBoa/VuUDHje96PyaMw/CtZ4mAq9J
         Tvn/DoQqc8ftgrOf12kVZRCVo8HHCROOOvZKiKOV+a/P62ZTW+A4IdlupSPLSwY0WrYa
         mSQA==
X-Forwarded-Encrypted: i=1; AJvYcCWmSD8ruUzPb9F5Ha4XtS4jO2OBBeRMj43IM0sPFUAHo1oqGW9gYPOSlTqsdTU26YzPBTp99HclEItIvxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVlHGxtXZ2V5PvvOp+zH0BapO7iHGdupmWfn5BZNnVC38oxPlY
	2y10R1FDOVPr45JAuimZJl+48csOwM20OcuyPWOq/dbc8TwiZpUUhdY97bjV52E=
X-Google-Smtp-Source: AGHT+IHV6GaKXHNCkoA4zPQtCf/BXs58H6nmWQupzcXJs+pFzHTxNVQD3FC8Qak4VmK6OdZr0R4qqg==
X-Received: by 2002:a17:90a:f989:b0:2d3:c976:dd80 with SMTP id 98e67ed59e1d1-2e0b8ee02admr111057a91.39.1727365356836;
        Thu, 26 Sep 2024 08:42:36 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1bb004sm3684740a91.19.2024.09.26.08.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 08:42:35 -0700 (PDT)
Date: Thu, 26 Sep 2024 08:42:32 -0700
From: Joe Damato <jdamato@fastly.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 1/1] hv_netvsc: Link queues to NAPIs
Message-ID: <ZvWA6BjwVfYXnDcA@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20240924234851.42348-1-jdamato@fastly.com>
 <20240924234851.42348-2-jdamato@fastly.com>
 <20240926151024.GE4029621@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926151024.GE4029621@kernel.org>

On Thu, Sep 26, 2024 at 04:10:24PM +0100, Simon Horman wrote:
> On Tue, Sep 24, 2024 at 11:48:51PM +0000, Joe Damato wrote:
> > Use netif_queue_set_napi to link queues to NAPI instances so that they
> > can be queried with netlink.
> > 
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> >  drivers/net/hyperv/netvsc.c       | 11 ++++++++++-
> >  drivers/net/hyperv/rndis_filter.c |  9 +++++++--
> >  2 files changed, 17 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> > index 2b6ec979a62f..ccaa4690dba0 100644
> > --- a/drivers/net/hyperv/netvsc.c
> > +++ b/drivers/net/hyperv/netvsc.c
> > @@ -712,8 +712,11 @@ void netvsc_device_remove(struct hv_device *device)
> >  	for (i = 0; i < net_device->num_chn; i++) {
> >  		/* See also vmbus_reset_channel_cb(). */
> >  		/* only disable enabled NAPI channel */
> > -		if (i < ndev->real_num_rx_queues)
> > +		if (i < ndev->real_num_rx_queues) {
> > +			netif_queue_set_napi(ndev, i, NETDEV_QUEUE_TYPE_TX, NULL);
> > +			netif_queue_set_napi(ndev, i, NETDEV_QUEUE_TYPE_RX, NULL);
> 
> Hi Joe,
> 
> When you post a non-RFC version of this patch, could you consider
> line-wrapping the above to 80 columns, as is still preferred for
> Networking code?
> 
> There is an option to checkpatch that will warn you about this.

Thanks for letting me know.

I run checkpatch.pl --strict and usually it seems to let me know if
I am over 80, but maybe there's another option I need?

