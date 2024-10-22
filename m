Return-Path: <linux-kernel+bounces-376957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4995D9AB815
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A58ADB228C9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 20:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BE61CCEC7;
	Tue, 22 Oct 2024 20:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="fpteXuUi"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F08A1BDA80
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 20:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729630699; cv=none; b=tzVhiIgi81ld0NQlQcv7VqeghjIWdyTFk17XLOD27j4CUwtQ7AZhOAp4Ki/GtXXNUBfDZvXfgLi90kt6nc+6/sM3GoGVO1blBi30ztM9CUOx7Tkj9/eMt4oU2tn2oVhtG5ZRC+7xs99vupNXxqBCx89EKuIKXsTTQPODWD/5ZAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729630699; c=relaxed/simple;
	bh=7hzlzcDJF61b3VZz2dUBczTx99A3veaBxsjRp4sbxpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iN/FSm7Bkczacv44s0LvlUIV4SATyDFjr9DNhcHDbvNTyMZGwjVxfGtSitz+n43WQV3RdxtnHi5sdIGOXqEVxa+78LGkJQhsGRvZS/mbXAdoSlKVLDWBjq5bumW9HkZ+D5bE9GecmyWAxkjhfVKcVf2GIXb/xG0Qw/eM3tz6Yys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=fpteXuUi; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c693b68f5so65458615ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 13:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1729630697; x=1730235497; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3nOwD9lkrUDYYUOOp26VYiqs0pM6VysutcI+Z8NYNEQ=;
        b=fpteXuUi2bscVpMSEIS8812/oPNnz3bQdAnvauc/s2dTGUKm5Ga9mKM/2NdgDuYDjK
         AHrvwO8V363VcZYzpQ9+pbLh0aTeEscaZwyOOxS2MADFRLAmePr3C/929iLFQiYSannX
         mtCSZKBTfwJM/Og8K2isx8YxIgFY4bQLLAUns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729630697; x=1730235497;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3nOwD9lkrUDYYUOOp26VYiqs0pM6VysutcI+Z8NYNEQ=;
        b=IpkUqLjbdIgG+p57BYhPaE/AFWFksUUXavO/nHfwxDGEJA1IVihDXjnfa/6sslvAX4
         LQsaxlJRp7N/IRDzFBZ/ucW9Cw+lbMy//IrZ6ni4eD95JNhExNMqLpps9jKTYLRdnuAx
         6zpX2hU5+Px8YoCdpDDsmBUnbFPnVchrDUockCtrnVD6HQSjmB51sBV5hnon4YE0+fMU
         caEv/zxJJyhQwNtL/7WsmE4oVBzPBwRa5t1fcEPfv0ah1EH3BYiCh9BTt+y7pwaerfjZ
         DT1nYxDPldEwDmqUtNgpxPbSt6f6BCCIe0lPypa5yLry8HnyM5Wkv6pts3zewn5d1em6
         Q6gA==
X-Forwarded-Encrypted: i=1; AJvYcCVA3rIiXt1p0xfHJqL5Ak5NNi58k7T0PFkC/c8kUiRd37/ZbszEBV9aFzAqkJ3ftmQs8raLxUbKQpaBKmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZgj2HoM/qcIORpjm7DrkD+tDDI2ZpSojwBXg4QvBqlTA1cYk8
	KnUAoYxoerO3Nb3qlYHXMkuLvi9wR7+1zzhA/ow6hwCO9fkMvemiYR7/EsCyQNc=
X-Google-Smtp-Source: AGHT+IFuaj5b71S0NIUeGmZ8xwvs7H0mLx+yYas133Ktloz7vz9pqp0kb0p5RyugJCulagxpYtuotQ==
X-Received: by 2002:a17:90a:e502:b0:2e2:ddfa:24d5 with SMTP id 98e67ed59e1d1-2e76b5e2442mr247700a91.15.1729630696853;
        Tue, 22 Oct 2024 13:58:16 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad510771sm6687535a91.50.2024.10.22.13.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 13:58:16 -0700 (PDT)
Date: Tue, 22 Oct 2024 13:58:13 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, kurt@linutronix.de, vinicius.gomes@intel.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Subject: Re: [net-next v3 2/2] igc: Link queues to NAPI instances
Message-ID: <ZxgR5XP-YE4adYz3@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org,
	kurt@linutronix.de, vinicius.gomes@intel.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
References: <20241018171343.314835-1-jdamato@fastly.com>
 <20241018171343.314835-3-jdamato@fastly.com>
 <ZxgK5jsCn5VmKKrH@LQ3V64L9R2>
 <40242f59-139a-4b45-8949-1210039f881b@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40242f59-139a-4b45-8949-1210039f881b@intel.com>

On Tue, Oct 22, 2024 at 01:53:01PM -0700, Jacob Keller wrote:
> 
> 
> On 10/22/2024 1:28 PM, Joe Damato wrote:
> > I took another look at this to make sure that RTNL is held when
> > igc_set_queue_napi is called after the e1000 bug report came in [1],
> > and there may be two locations I've missed:
> > 
> > 1. igc_resume, which calls __igc_open
> > 2. igc_io_error_detected, which calls igc_down
> > 
> > In both cases, I think the code can be modified to hold rtnl around
> > calls to __igc_open and igc_down.
> > 
> > Let me know what you think ?
> > 
> > If you agree that I should hold rtnl in both of those cases, what is
> > the best way to proceed:
> >   - send a v4, or
> >   - wait for this to get merged (since I got the notification it was
> >     pulled into intel-next) and send a fixes ?
> > 
> 
> Intel-next uses a stacked set of patches which we then send in batches
> via PRs as they pass our internal testing.
> 
> We can drop the v3 and await v4.

OK, thanks for the info. I will prepare, test locally, and send a
v4 shortly.

> > Here's the full analysis I came up with; I tried to be thorough, but
> > it is certainly possible I missed a call site:
> > 
> > For the up case:
> > 
> > - igc_up:
> >   - called from igc_reinit_locked, which is called via:
> >     - igc_reset_task (rtnl is held)
> >     - igc_set_features (ndo_set_features, which itself has an ASSERT_RTNL)
> >     - various places in igc_ethtool (set_priv_flags, nway_reset,
> >       ethtool_set_eee) all of which have RTNL held
> >   - igc_change_mtu which also has RTNL held
> > - __igc_open
> >   - called from igc_resume, which may need an rtnl_lock ?
> >   - igc_open
> >     - called from igc_io_resume, rtnl is held
> >     - called from igc_reinit_queues, only via ethool set_channels,
> >       where rtnl is held
> >     - ndo_open where rtnl is held
> > 
> > For the down case:
> > 
> > - igc_down:
> >   - called from various ethtool locations (set_ringparam,
> >     set_pauseparam, set_link_ksettings) all of which hold rtnl
> >   - called from igc_io_error_detected, which may need an rtnl_lock
> >   - igc_reinit_locked which is fine, as described above
> >   - igc_change_mtu which is fine, as described above
> >   - called from __igc_close
> >     - called from __igc_shutdown which holds rtnl
> >     - called from igc_reinit_queues which is fine as described above
> >     - called from igc_close which is ndo_close
> 
> This analysis looks complete to me.

Thanks; I'd appreciate your comments on the e1000 RFC I posted, if
you have a moment. I'm going to update that thread with more data
now that I have analysed igc as there are some parallels:

https://lore.kernel.org/netdev/20241022172153.217890-1-jdamato@fastly.com/

