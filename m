Return-Path: <linux-kernel+bounces-423913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9D29DAE37
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 21:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC5F2818BF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 20:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF1213D518;
	Wed, 27 Nov 2024 20:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="GRP0zwAB"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83972036E0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 20:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732737609; cv=none; b=YXKZz3MER7+aNeSkjzpxyTh9+oX318IzehraeAsHQeoM1V0Rk6/lXS014tn5QpUw59KbXN0cSOQAAFaADncFRRyjW7BCEBj8S4Xl2LGJ7OC38FeoWtpZ+C9jZwvmEy0wpNGTrHlYMOnOzOvRQa8dZF9hoVpZfL//72kQMTrYDLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732737609; c=relaxed/simple;
	bh=4kulIdpUkClMnW3bgQTIh+M2+GGa09Ku28XupppGLXw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWOsvxvNCcPrQrxlxE84Zum7uTvOSvLr2QitvrNvSaoxa3ToazUE6V/fBrv4CpcQRJpRG3yfAV4EiAz/vfQ9Dzi4pcQUddS1cvgtTwXQ8JSTeD7RRYkzntdPB5fMYfkV8tirqXpdDfVRx8O94dWnGG8/P+Lnqif1mDK4oOU4J9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=GRP0zwAB; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ea6f821decso129828a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 12:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1732737606; x=1733342406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SjUTXgm+hjNlrlkeiDpx8ILNw62xTbjnMxBRwDCdfK0=;
        b=GRP0zwABVmUxP6EqpcKwcyw63nZa/Qo55iElKFAEHlti9kzOicKkAuHviL5bODN9yP
         sXmHyeKSWzzAVOSEMrYTztiITE237f7sLwu6ZWcAVJL2/rR7lF1r2MrWihtaSdce2D69
         8FiChVUjy0oYX/FIQLtnCIVzXRkTgxYygejUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732737606; x=1733342406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjUTXgm+hjNlrlkeiDpx8ILNw62xTbjnMxBRwDCdfK0=;
        b=mMewYZ/kxXYTDX0sQXoM4nSzXBLpohS2N5IA3bzKy0UCjQLLDsJf/10DcAOB09wdQj
         nr96SpozBNDQN8jw6n2Zi7c6lHlJe1wAwRa9Nxr4QXV5Dar6aJ+taQYqRxpmdLPQQROi
         h257AaBEZIKA9limqHFXdmgCRit+B/TQK61RcSkEaJ+zghYrobF8CVKWgPMwFIY60u0X
         B4281Mk2FwXiZWG2vuHHvzWBpNwM5fJ7b5/w+KF7IjURSkueGMu5+pNtItptF7UB91L0
         lceI8n8rnj2s0M32C+qBIa+NFw/4bevneh2sKu6/Yb85TmLTh/FzZoMnGv8mnvkVpHwm
         hjhw==
X-Forwarded-Encrypted: i=1; AJvYcCUAl3K8AuLjjhUbONKDQupqSpWbGWgxHGJd4OeTbx+YOsfEXIUV/iIrqg3ZOBneHf2SeMpCxk3zpGeTsc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRwl8SjylSlXWDt8CPLNz4RUK1vQktJ2cIDAxiq1y7m0LhKLhJ
	b274X4SvdiQj9Kq9SXWM2yNBYrcMEbJsA8Ol8nDVaYrgDt4SUowYs8vwNc2lMCI=
X-Gm-Gg: ASbGncsBcL9OW77++2zGxwBsg47pxkGPna7MUlXpTw8XXVSvkkTuwWUOVoQOY2Rwd9p
	ErF6Pj7KK0BYN3416KCp+W9v0h2hdJrxZ3iZxk+VrWH9iD7zhNko7yGxq7FJLZux3AYvsXFZhAv
	nhwvrM/0VSmGyiOUQ3WLSmZS72Khnd4rULGKqbyPL4F2l4QtIpi7vE9M/Ued+Fs2A3eQWJrgdcK
	jqyqDNqihet//9qPcCwM2LXq8t3g4JckdO8swqoKzg9tqs3KK5EHglLAJMVmcGxD2XdN8zEKwR2
	8/i0o7rPym/9pdOC
X-Google-Smtp-Source: AGHT+IHJ3VPgCBxfCXsFev5RlCwsdAg0ojCe3Aj++64ttxbNqdV4DbkkvxPl6aCAVgmuLHmfyQyUcg==
X-Received: by 2002:a17:90b:3c12:b0:2e0:7b2b:f76 with SMTP id 98e67ed59e1d1-2ee08ecf438mr5493334a91.19.1732737605988;
        Wed, 27 Nov 2024 12:00:05 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee0fa995d7sm1989300a91.35.2024.11.27.12.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 12:00:05 -0800 (PST)
Date: Wed, 27 Nov 2024 12:00:02 -0800
From: Joe Damato <jdamato@fastly.com>
To: Guenter Roeck <linux@roeck-us.net>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
	bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	edumazet@google.com, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, pcnet32@frontier.com
Subject: Re: [net-next v6 5/9] net: napi: Add napi_config
Message-ID: <Z0d6QlrRUig5eD_I@LQ3V64L9R2>
References: <20241011184527.16393-1-jdamato@fastly.com>
 <20241011184527.16393-6-jdamato@fastly.com>
 <85dd4590-ea6b-427d-876a-1d8559c7ad82@roeck-us.net>
 <Z0dqJNnlcIrvLuV6@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0dqJNnlcIrvLuV6@LQ3V64L9R2>

On Wed, Nov 27, 2024 at 10:51:16AM -0800, Joe Damato wrote:
> On Wed, Nov 27, 2024 at 09:43:54AM -0800, Guenter Roeck wrote:
> > Hi,
> > 
> > On Fri, Oct 11, 2024 at 06:45:00PM +0000, Joe Damato wrote:
> > > Add a persistent NAPI config area for NAPI configuration to the core.
> > > Drivers opt-in to setting the persistent config for a NAPI by passing an
> > > index when calling netif_napi_add_config.
> > > 
> > > napi_config is allocated in alloc_netdev_mqs, freed in free_netdev
> > > (after the NAPIs are deleted).
> > > 
> > > Drivers which call netif_napi_add_config will have persistent per-NAPI
> > > settings: NAPI IDs, gro_flush_timeout, and defer_hard_irq settings.
> > > 
> > > Per-NAPI settings are saved in napi_disable and restored in napi_enable.
> > > 
> > > Co-developed-by: Martin Karsten <mkarsten@uwaterloo.ca>
> > > Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
> > > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > > Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> > 
> > This patch triggers a lock inversion message on pcnet Ethernet adapters.
> 
> Thanks for the report. I am not familiar with the pcnet driver, but
> took some time now to read the report below and the driver code.
> 
> I could definitely be reading the output incorrectly (if so please
> let me know), but it seems like the issue can be triggered in this
> case:

Sorry, my apologies, I both:
  - read the report incorrectly, and
  - proposed a bad patch that would result in a deadlock :)

After re-reading it and running this by Martin (who is CC'd), the
inversion is actually:

CPU 0:
pcnet32_open
   lock(lp->lock)
     napi_enable
       napi_hash_add <- before this executes, CPU 1 proceeds
         lock(napi_hash_lock)
CPU 1:
  pcnet32_close
    napi_disable
      napi_hash_del
        lock(napi_hash_lock)
         < INTERRUPT >
            pcnet32_interrupt
              lock(lp->lock)

This is now an inversion because:

CPU 0: holds lp->lock and is about to take napi_hash_lock
CPU 1: holds napi_hashlock and an IRQ firing on CPU 1 tries to take
       lp->lock (which CPU 0 already holds)

Neither side can proceed:
  - CPU 0 is stuck waiting for napi_hash_lock
  - CPU 1 is stuck waiting for lp->lock

I think the below explanation is still correct as to why the
identified commit causes the issue:

> It seems this was triggered because before the identified commit,
> napi_enable did not call napi_hash_add (and thus did not take the
> napi_hash_lock).

However, the previous patch I proposed for pcnet32 would also cause
a deadlock as the watchdog timer's function also needs lp->lock.

A corrected patch for pcnet32 can be found below.

Guenter: Sorry, would you mind testing the below instead of the
previous patch?

Don: Let me know what you think about the below?

Netdev maintainers, there is an alternate locking solution I can
propose as an RFC that might avoid this class of problem if this
sort of issue is more widespread than just pcnet32:
  - add the NAPI to the hash in netif_napi_add_weight (instead of napi_enable)
  - remove the NAPI from the hash in __netif_napi_del (instead of
    napi_disable)

If changing the locking order in core is the desired route, than the
patch below should be unnecessary, but:

diff --git a/drivers/net/ethernet/amd/pcnet32.c b/drivers/net/ethernet/amd/pcnet32.c
index 72db9f9e7bee..2e0077e68883 100644
--- a/drivers/net/ethernet/amd/pcnet32.c
+++ b/drivers/net/ethernet/amd/pcnet32.c
@@ -2625,11 +2625,10 @@ static int pcnet32_close(struct net_device *dev)

        del_timer_sync(&lp->watchdog_timer);

+       spin_lock_irqsave(&lp->lock, flags);
        netif_stop_queue(dev);
        napi_disable(&lp->napi);

-       spin_lock_irqsave(&lp->lock, flags);
-
        dev->stats.rx_missed_errors = lp->a->read_csr(ioaddr, 112);

        netif_printk(lp, ifdown, KERN_DEBUG, dev,

