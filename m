Return-Path: <linux-kernel+bounces-346121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7B798BFE0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D600C1F26438
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 14:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05D819D06E;
	Tue,  1 Oct 2024 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="b4kZGcJO"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641B81C4619
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727792914; cv=none; b=l6EhSXtvAVeXxBM2mB522D+ILfCgOXAkfxOoAtA4GX/KV2oRGv9z6cGKnhqVLdhRlXI7ypsWfVptuo9wi/2B0jJWFUhdRYb2vgmyHwaqpL1DoFtew2o+S/kvjVbVVdRYustcgOywJXN9xcRKDgRS+ASQXPJYghFXIsvgu3tF02w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727792914; c=relaxed/simple;
	bh=fjOy2zZ3GK1y+nU2yQ3naJCNXt7vEPXcel6WkVrmH9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BrDOjl1ZDFtmok1gTqmGUPiWfFJ9a6zgXHF7toX3wqtnyfXyOXq/tMdWWs/l2Jg0ZUvU1NXNsAzltjCLNRnuqpXXqJuFYkAOK3XWkNYSnd4ouRlTYFfxBIJGdL1I2Lsz6JviUAPu6a2oxmhArE4ZYBWux4BMznzF40zVIBOzk9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=b4kZGcJO; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20b7eb9e81eso25405315ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 07:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727792911; x=1728397711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AOF0GWvnEPqrZ0H2jwx7NQt72HcvOEJ5C0SLw3lM530=;
        b=b4kZGcJOPsO6g1J0YTNFclk3TTlgt9Nx99cd3lGk1Uqvx/PI/vvjkE/cUaSejWWtRV
         Ys8LwtBQ78xTVmLCNm7VvZQ9+tZGUrkg2fAqYuBSm5tpq2HOOPzoY4aQR4cn48in5Xxh
         Oj1orv7OCFU79+FAGjwIv3E5gy3WCRq8u42lY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727792911; x=1728397711;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AOF0GWvnEPqrZ0H2jwx7NQt72HcvOEJ5C0SLw3lM530=;
        b=pkI/tlqXiy4j1My94FiCYkQzo9yUOTKUEwu1KkV6nOCxcBMBzbngmSQ0cIrwbsoI/f
         m3fXj4aZJ5uKgDlPO+DyuIil9zS6XB/JdfMSoi0408+8WkHTogl/17S8DbLXP2TokHJk
         LebTA2CvXLnhn8Vau71tJVd6Dnv9FmJyVORO5H8l8C4OLpOJTwYH1p1Hej1syBbti/pK
         76lmzUDR93EpIrF1K9JK6Gvi4d1GJ1rn60i2j0tXj/QLkEW93WrLKQCCXTB2K52Dop4Q
         MYPBBXPG1ZW/jZKeNV021H1wFzwf1a81vck6MN21Nh+chJE7QNnW1BO3IZSdpEKm5UHh
         6rWg==
X-Forwarded-Encrypted: i=1; AJvYcCXOaZlZP+SuCtya1wAhyw0gL+3tG3gHlsc8Xmzy3S1p4dUFdC0VivncRbh2M4RcawQYYKh2dQcc9suQU7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW7VtdFEb4pBc4Lez438ySKuKIWIxeT8zZXwgVv8WzFL8FSM7d
	WyIwMHduqGIaWYawlOwsMkgMDr/WD6Nd6YVD9lIitOSXkwoxEz+ZorQdrTJaB60=
X-Google-Smtp-Source: AGHT+IF7K2L2iuJ/fe+OrSotNCP+yQ3syTvOPGEn34rUCZ4jrEPGmpEr4GjHzNCnor5AXoUb2l/aig==
X-Received: by 2002:a17:902:f691:b0:20b:90ab:67de with SMTP id d9443c01a7336-20b90ab6d1bmr92688855ad.8.1727792910630;
        Tue, 01 Oct 2024 07:28:30 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e0d65asm69507325ad.123.2024.10.01.07.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 07:28:30 -0700 (PDT)
Date: Tue, 1 Oct 2024 07:28:27 -0700
From: Joe Damato <jdamato@fastly.com>
To: "Arinzon, David" <darinzon@amazon.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Agroskin, Shay" <shayagr@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Bshara, Saeed" <saeedb@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kamal Heib <kheib@redhat.com>,
	open list <linux-kernel@vger.kernel.org>,
	"Bernstein, Amit" <amitbern@amazon.com>
Subject: Re: [net-next 2/2] ena: Link queues to NAPIs
Message-ID: <ZvwHC6VLihXevnPo@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	"Arinzon, David" <darinzon@amazon.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Agroskin, Shay" <shayagr@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Bshara, Saeed" <saeedb@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kamal Heib <kheib@redhat.com>,
	open list <linux-kernel@vger.kernel.org>,
	"Bernstein, Amit" <amitbern@amazon.com>
References: <20240930195617.37369-1-jdamato@fastly.com>
 <20240930195617.37369-3-jdamato@fastly.com>
 <eb828dd9f65847a49eb64763740c84ff@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb828dd9f65847a49eb64763740c84ff@amazon.com>

On Tue, Oct 01, 2024 at 09:06:16AM +0000, Arinzon, David wrote:
> > Link queues to NAPIs using the netdev-genl API so this information is
> > queryable.
> > 
> > $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
> >                          --dump queue-get --json='{"ifindex": 2}'
> > 
> > [{'id': 0, 'ifindex': 2, 'napi-id': 8201, 'type': 'rx'},
> >  {'id': 1, 'ifindex': 2, 'napi-id': 8202, 'type': 'rx'},
> >  {'id': 2, 'ifindex': 2, 'napi-id': 8203, 'type': 'rx'},
> >  {'id': 3, 'ifindex': 2, 'napi-id': 8204, 'type': 'rx'},
> >  {'id': 4, 'ifindex': 2, 'napi-id': 8205, 'type': 'rx'},
> >  {'id': 5, 'ifindex': 2, 'napi-id': 8206, 'type': 'rx'},
> >  {'id': 6, 'ifindex': 2, 'napi-id': 8207, 'type': 'rx'},
> >  {'id': 7, 'ifindex': 2, 'napi-id': 8208, 'type': 'rx'},
> >  {'id': 0, 'ifindex': 2, 'napi-id': 8201, 'type': 'tx'},
> >  {'id': 1, 'ifindex': 2, 'napi-id': 8202, 'type': 'tx'},
> >  {'id': 2, 'ifindex': 2, 'napi-id': 8203, 'type': 'tx'},
> >  {'id': 3, 'ifindex': 2, 'napi-id': 8204, 'type': 'tx'},
> >  {'id': 4, 'ifindex': 2, 'napi-id': 8205, 'type': 'tx'},
> >  {'id': 5, 'ifindex': 2, 'napi-id': 8206, 'type': 'tx'},
> >  {'id': 6, 'ifindex': 2, 'napi-id': 8207, 'type': 'tx'},
> >  {'id': 7, 'ifindex': 2, 'napi-id': 8208, 'type': 'tx'}]
> > 
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> >  drivers/net/ethernet/amazon/ena/ena_netdev.c | 26
> > +++++++++++++++++---
> >  1 file changed, 22 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> > b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> > index e88de5e426ef..1c59aedaa5d5 100644
> > --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> > +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> > @@ -1821,20 +1821,38 @@ static void ena_napi_disable_in_range(struct
> > ena_adapter *adapter,
> >                                       int first_index,
> >                                       int count)  {
> > +       struct napi_struct *napi;
> 
> Is this variable necessary? It has been defined in the enable function because
> it is needed in netif_queue_set_napi() API as well as in napi_enable(),
> and it makes sense in order to avoid long lines
> In here, the variable is only used in a call to napi_disable(), can the code
> be kept as it is? don't see a need to shorten the napi_disable() call line.

It is true that its only used to call napi_disable so if you prefer
to have it removed let me know?

I think it looks nicer with the variable, but it's your driver.

> >         int i;
> > 
> > -       for (i = first_index; i < first_index + count; i++)
> > -               napi_disable(&adapter->ena_napi[i].napi);
> > +       for (i = first_index; i < first_index + count; i++) {
> > +               napi = &adapter->ena_napi[i].napi;
> > +               if (!ENA_IS_XDP_INDEX(adapter, i)) {
> > +                       netif_queue_set_napi(adapter->netdev, i,
> > +                                            NETDEV_QUEUE_TYPE_TX, NULL);
> > +                       netif_queue_set_napi(adapter->netdev, i,
> > +                                            NETDEV_QUEUE_TYPE_RX, NULL);
> > +               }
> > +               napi_disable(napi);
> > +       }
> >  }
> > 
> >  static void ena_napi_enable_in_range(struct ena_adapter *adapter,
> >                                      int first_index,
> >                                      int count)  {
> > +       struct napi_struct *napi;
> >         int i;
> > 
> > -       for (i = first_index; i < first_index + count; i++)
> > -               napi_enable(&adapter->ena_napi[i].napi);
> > +       for (i = first_index; i < first_index + count; i++) {
> > +               napi = &adapter->ena_napi[i].napi;
> > +               napi_enable(napi);
> > +               if (!ENA_IS_XDP_INDEX(adapter, i)) {
> 
> Can you share some info on why you decided to set the queue to napi association
> only in non-xdp case?
> In XDP, there's a napi poll function that's executed and it runs on the TX queue.
> I am assuming that it's because XDP is not yet supported in the framework? If so,
> there's a need to add an explicit comment above if (!ENA_IS_XDP_INDEX(adapter, i)) {
> explaining this in order to avoid confusion with the rest of the code.

Yes; it is skipped for XDP queues, but they could be supported in
the future.

Other drivers that support this API work similarly (see also: bnxt,
ice, mlx4, etc).

> > +                       netif_queue_set_napi(adapter->netdev, i,
> > +                                            NETDEV_QUEUE_TYPE_RX, napi);
> > +                       netif_queue_set_napi(adapter->netdev, i,
> > +                                            NETDEV_QUEUE_TYPE_TX, napi);
> > +               }
> > +       }
> >  }
> > 
> >  /* Configure the Rx forwarding */
> > --
> > 2.43.0
> 
> Thank you for uploading this patch.

Can you please let me know (explicitly) if you want me to send a
second revision (when net-next allows for it) to remove the 'struct
napi_struct' and add a comment as described above?

