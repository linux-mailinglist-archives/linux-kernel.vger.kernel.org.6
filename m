Return-Path: <linux-kernel+bounces-340708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A43719876EB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 640F12818B2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA028156C74;
	Thu, 26 Sep 2024 15:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="qCMQJyI1"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB93A14B086
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 15:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727365848; cv=none; b=IPpz/qW9Rbdf6Eq4WY/nwd0NCCQ2kQDPVLEt2TDxZZY4Gs+q12PBdjfAhNANWEqYh8PPxbrwoeoxXJURN30PZh1aW9ip0Ii6C3/iO7CjDX1Y4BKk9GDkKhZEIMyBYuwsgsxvies58I4mSW7MkqF6wJj5sZceFhhMLUp9xh135yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727365848; c=relaxed/simple;
	bh=IX0EuvDMjTW+YNQmUoVlvdmyaeGBf+T2lnX/5x4GabA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcRIyhyjFk+Chqa8/YD1mHEX2fJu3Mb6eAjUQthH7h126uz60Ebi3gVlIurtd9yObIrCnH60ibTsKokzsX665ncl28xJnPA2F1UYIThshC2HeeKz4f5GkAxU5+/MSBxq33NFO7kz58mcQgb/bYg2uPO3XgjEK824AZOLHIcrGEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=qCMQJyI1; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7191fb54147so868224b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727365846; x=1727970646; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4497cyjKPRI1PPIEvp39I++CetYP4FngtyziYodhtfk=;
        b=qCMQJyI1GDf0SH3eEx37kOU3qJBk233wTdGaXJkCCahOpjB5jTy7dH24xjtojwdACV
         rcYSw4DpcB8CLxk8u0Za/YQDHIWqjTq/lAmCGj7WFK/2orfC+z7nkEZGw2dAwtohOKop
         2E2sAQiK4VaUwtx+GYb/D69D2KiIovJdCKz6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727365846; x=1727970646;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4497cyjKPRI1PPIEvp39I++CetYP4FngtyziYodhtfk=;
        b=NZlE0xQydTwvS9jBS4RxmqYigO1Zegky+B+2/VMni9QjbTtJDkBysD1hmSM9fxP57J
         Bc+52CnRA3oCt9+fkifXQ2CfRPBmkKwgzc+id4Z8yrCpwfuxqPbgHTN5FSiioPhSu4H7
         RxBTvy7PXj1KpPG6Day8he8byXmCKi54i0BlVWQ8RU0Fpe/OFVzSJk1MnGN3LgfCFI7z
         PSMJCOjjNu2Xv7BjFVKyZr6QpyPdrWKL1GXeHnML/DSWMBafWwTftt/YirjyZjeuQwWV
         zAU1lpWot+Ii2TZLJgUW2MlWXn6VfIzmOb39oBCQS9HoZ+PcYk4R+uvT6Gw0sf9ihbCD
         ofJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZYbL/S1xyHUUUpRlOMu8Z/xqfjTrYzKzCZHaQ/kyAl3bLuTLXrifkdkZhSLhlTY693zBCNn1wVTb8edY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdezmJE2R9VhYXZWCKpj5EoideiOAnzHIg89cBxOwumVbBXDWU
	eh2J2ABevIvieJn4zpgfY0T+fZAtP57cgvHeZzxZGWuf3iJz8TUvDEfdwzHRD+k=
X-Google-Smtp-Source: AGHT+IEkQhkhz8M9XhbdcUG2MNIeKwnGlhXroclU7cIvREbDFN+d/Ne8bE0fjVwVOeH3tYuVP+gwkg==
X-Received: by 2002:a05:6a00:10d5:b0:717:8deb:c195 with SMTP id d2e1a72fcca58-71b2604937emr366312b3a.21.1727365845970;
        Thu, 26 Sep 2024 08:50:45 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2653717esm40742b3a.204.2024.09.26.08.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 08:50:45 -0700 (PDT)
Date: Thu, 26 Sep 2024 08:50:42 -0700
From: Joe Damato <jdamato@fastly.com>
To: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 1/1] hv_netvsc: Link queues to NAPIs
Message-ID: <ZvWC0mhTW-y--X3a@LQ3V64L9R2>
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
 <ZvWA6BjwVfYXnDcA@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvWA6BjwVfYXnDcA@LQ3V64L9R2>

On Thu, Sep 26, 2024 at 08:42:32AM -0700, Joe Damato wrote:
> On Thu, Sep 26, 2024 at 04:10:24PM +0100, Simon Horman wrote:
> > On Tue, Sep 24, 2024 at 11:48:51PM +0000, Joe Damato wrote:
> > > Use netif_queue_set_napi to link queues to NAPI instances so that they
> > > can be queried with netlink.
> > > 
> > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > > ---
> > >  drivers/net/hyperv/netvsc.c       | 11 ++++++++++-
> > >  drivers/net/hyperv/rndis_filter.c |  9 +++++++--
> > >  2 files changed, 17 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> > > index 2b6ec979a62f..ccaa4690dba0 100644
> > > --- a/drivers/net/hyperv/netvsc.c
> > > +++ b/drivers/net/hyperv/netvsc.c
> > > @@ -712,8 +712,11 @@ void netvsc_device_remove(struct hv_device *device)
> > >  	for (i = 0; i < net_device->num_chn; i++) {
> > >  		/* See also vmbus_reset_channel_cb(). */
> > >  		/* only disable enabled NAPI channel */
> > > -		if (i < ndev->real_num_rx_queues)
> > > +		if (i < ndev->real_num_rx_queues) {
> > > +			netif_queue_set_napi(ndev, i, NETDEV_QUEUE_TYPE_TX, NULL);
> > > +			netif_queue_set_napi(ndev, i, NETDEV_QUEUE_TYPE_RX, NULL);
> > 
> > Hi Joe,
> > 
> > When you post a non-RFC version of this patch, could you consider
> > line-wrapping the above to 80 columns, as is still preferred for
> > Networking code?
> > 
> > There is an option to checkpatch that will warn you about this.
> 
> Thanks for letting me know.
> 
> I run checkpatch.pl --strict and usually it seems to let me know if
> I am over 80, but maybe there's another option I need?

Ah, I see:

--max-line-length=n set the maximum line length, (default 100)

I didn't realize the checkpatch default was 100. Sorry about that,
will make sure to pass that flag in the future; thanks for letting
me know.

