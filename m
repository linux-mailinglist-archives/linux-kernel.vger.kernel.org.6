Return-Path: <linux-kernel+bounces-180046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D528B8C6940
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 905982840A6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 15:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925BF155A4D;
	Wed, 15 May 2024 15:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EPheoGjh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7107715575A
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 15:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715785652; cv=none; b=HgE5T3iEnzzf4qeVUp5JPOUxQDW2YKoORnI+Haiqmrphsm7QyFF+xak8MDCRt8J3eYfJfSQWKW0OfPNXKAemDExqSYem3tugY0phrwEzKf5fOxm862UV4fJjV8WQ3d3ZSSKYvV85ygfkvGEpDF0C+MavXQzHxREL/FKXAirEMDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715785652; c=relaxed/simple;
	bh=nB/Wx+bzRLvAZM9HJrayest7/Jl5WbZCbrJZngd9CQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQ0sPXv05FWsSgy/u8lX3q6uzWOnQvpGB1VEh9Grl8n392C4HVV2O/++5YMaH5g2bDQdfs9P72SKJVMo+5YEw2in5I+wkFhvUs8OC+XdtSMegDl4yqZ+PBz5Malr11Y+/1OczQVV67Q7pNGt8hOAog984FxwZ3ooHI3+faUiHQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EPheoGjh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715785649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dbrWi8lbFLyv72mKMlVkkmYPCKHUduDQsR6vbInAIJA=;
	b=EPheoGjhsoxt2GgmJ7fSQdoEdn+TY+HqDZU4zuaT+XZ0esVq1l8G7I4AN1Ghy1WXXUICXU
	ytMWhTzDM7KqXvjgsMW6LGcybbu/P/jdZTAGUMA6MoeAMmx568uBUtHDtt1kXKuyYtNHQi
	amOf1sRLb6tPhPMUnd2M5YKRRtRdIp0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-5uLGBt_aNpu_e5hE9NM4zA-1; Wed, 15 May 2024 11:07:17 -0400
X-MC-Unique: 5uLGBt_aNpu_e5hE9NM4zA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2e482d3d843so67359211fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 08:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715785635; x=1716390435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbrWi8lbFLyv72mKMlVkkmYPCKHUduDQsR6vbInAIJA=;
        b=geaUdL8OLL0xx6WYu4L2fvMQtJqyeTOGe1ffcKGaTyNqCZPvrqkBN90doB6wrvYmaH
         9ULDd3LxoyJPDmOUXumrwciYfZxGno/TxHGvYHW6MssbipP0lUpdnjrlleoBsSrTSgsr
         +eIuDhrUlITdnpIhUNZSAIB6XB9WfQGLb+3/umSCfEQ19+W8VY6KETU7HDyY9MooObaz
         /HiKm9QVJeOF7gWtjoh8OkVQRNPK8b9n6Q2WLpQ0pepXiEOAgpvpqLMFody4zGpm4A49
         EBHpXbWs+v0/GBgMrpHJrWmXb+SqnEbEOdlwXH6pZ080dJ3w1AWwPcQ7760ONAj3c8UE
         3aQw==
X-Forwarded-Encrypted: i=1; AJvYcCU5QVokOw1/kSQv8kO4cSS9VPWn4sMNnO/6eqka3ywNOaSQeN8d+9lHoDOvA/wqMb8GRefovjdVzIFZkTfXBHzhtiH5ohfCBFoqE50/
X-Gm-Message-State: AOJu0Yw+ihG5fbE2KDSNyMMC5pF2rOtLMlC02aLMyKEQ+c9nMEt3qEcJ
	pu5XCpcqNfCaBesHC2/okTOqk9DWjhXtDDTVc5BwQM2ragF/p1qqBPQ/zOeJlo7l1TiTDkmXpAr
	AKaiL3AJI2bdvzAPiqovvDS8AxTCbZjdMB7l3dJ3+Ajr408fbUb8ugDrxey2T2NYi792zCQ==
X-Received: by 2002:a2e:7c0d:0:b0:2e3:7121:aba6 with SMTP id 38308e7fff4ca-2e5205c61a3mr133092391fa.46.1715785635203;
        Wed, 15 May 2024 08:07:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA2MjU83PmPbl4SP+crO3lzmgqKP48+f4i5kvUwU7C8/1az1QdYe3lnvRKkMDiMLe7dIqRJw==
X-Received: by 2002:a2e:7c0d:0:b0:2e3:7121:aba6 with SMTP id 38308e7fff4ca-2e5205c61a3mr133092081fa.46.1715785634668;
        Wed, 15 May 2024 08:07:14 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:c01e:6df5:7e14:ad03:85bd])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bccesm16825319f8f.5.2024.05.15.08.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 08:07:13 -0700 (PDT)
Date: Wed, 15 May 2024 11:07:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] virtio_net: Fix error code in
 __virtnet_get_hw_stats()
Message-ID: <20240515110626-mutt-send-email-mst@kernel.org>
References: <3762ac53-5911-4792-b277-1f1ead2e90a3@moroto.mountain>
 <20240512115645-mutt-send-email-mst@kernel.org>
 <1682873e-eb14-48e4-9ac6-c0a69ea62959@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1682873e-eb14-48e4-9ac6-c0a69ea62959@suswa.mountain>

On Wed, May 15, 2024 at 04:50:48PM +0200, Dan Carpenter wrote:
> On Sun, May 12, 2024 at 12:01:55PM -0400, Michael S. Tsirkin wrote:
> > On Fri, May 10, 2024 at 03:50:45PM +0300, Dan Carpenter wrote:
> > > The virtnet_send_command_reply() function returns true on success or
> > > false on failure.  The "ok" variable is true/false depending on whether
> > > it succeeds or not.  It's up to the caller to translate the true/false
> > > into -EINVAL on failure or zero for success.
> > > 
> > > The bug is that __virtnet_get_hw_stats() returns false for both
> > > errors and success.  It's not a bug, but it is confusing that the caller
> > > virtnet_get_hw_stats() uses an "ok" variable to store negative error
> > > codes.
> > 
> > The bug is ... It's not a bug ....
> > 
> > I think what you are trying to say is that the error isn't
> > really handled anyway, except for printing a warning,
> > so it's not a big deal.
> > 
> > Right?
> > 
> 
> No, I'm sorry, that was confusing.  The change to __virtnet_get_hw_stats()
> is a bugfix but the change to virtnet_get_hw_stats() was not a bugfix.
> I viewed this all as really one thing, because it's cleaning up the
> error codes which happens to fix a bug.  It seems very related.  At the
> same time, I can also see how people would disagree.
> 
> I'm traveling until May 23.  I can resend this.  Probably as two patches
> for simpler review.
> 
> regards,
> dan carpenter
>  

Yea, no rush - bugfixes are fine after 23. And it's ok to combine into
one - we don't want inconsistent code - just please write a clear
commit log message.


-- 
MST


