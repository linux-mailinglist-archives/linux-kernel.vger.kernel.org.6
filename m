Return-Path: <linux-kernel+bounces-349947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70ABE98FDB6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 885841C21CF3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 07:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6AA136664;
	Fri,  4 Oct 2024 07:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TptPJz7x"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB528C1A
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 07:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728026269; cv=none; b=MgfSzNEec+LAk8T/EFcF2+ynsGFL1s52KxePErL2eS7Wgmbe+R6sUyr73b7cBUmJfp+lz83ln6klFJ6wJsSvHOX309Ez0o7eYNeKwYxLAr+Z3mcm5aLBYEybXrs1vFNzJukU5kh7yoJxXLklFywB7y6GeXU7KyELKQ/9/rNbbaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728026269; c=relaxed/simple;
	bh=RvLQ3hgcxffhJ/7j4iwbdSErN0H5G+6+jvVLjwMWyhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=prgT6uWZmLANdSAhmRq5/487y8xi2NyQHmbp52aQowhVg5VZp8+/jB66kr3W/8IAtqjWpq0/+0JiCFXGhlPhKojkC4laWCnQfJ3gU3BShV5Va1ABxk+8Ih8xDIaVidbJULnnJfRkNJxlY4MtjrjkwW4ZbBjnxhrR1H/D+p1/OO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TptPJz7x; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2fabc9bc5dfso23156871fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 00:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1728026266; x=1728631066; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iuULKTHuresw0Zy6wICe+A8Q6rp+HpZuWrQucEn75pE=;
        b=TptPJz7xY+vSN6OspgJRFgjv2YZaKyoB1t7PyvqGg/8MgigbpgoLvQ/OmUTjbMrpkM
         ArQg5szag3tgzjRsGEXFF/GSbcYOEWsvFkYDw+q0y6OiLcb6ohDPfoPechI+lTzjFWNh
         T9TwN4O2t4OdCaz2AJA7GIDK5Lq7nnRGrvz6Q/eLq3HgH9U/yiX+oIlcNw/xl6dYFsOc
         YBV01junQ0SB6tJMoq3Vn0a2sy3Qc8ZVv0RaSio5b0H7amPndjLI1X5rvjyet2/ytiqZ
         mJnpceSiOd+HOQoB0RwMktnjEquc7IWKmCG7gAg/9h95+RxR3Nf2JgVGsXbxLNZVCKD1
         aahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728026266; x=1728631066;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iuULKTHuresw0Zy6wICe+A8Q6rp+HpZuWrQucEn75pE=;
        b=bOyXmLtNj0FMKPkNB9VG5nGlIA72qnZY9r1pDOfRY1l0PWjA/HMBWISV9wospXW6rh
         kMmeucIZ73hqOzykYX6MvaTrzPgJjCf/f4F4XGYV0WKznsw+wqSx5bFv3c/tropdfzGY
         JJf3W1k+PuMLMliRiYnh9J96SqdhBmtuJeaynYf7/mz+iIQnR4yKuHfCDaL1tdA+l6aO
         pMYOX6+WzCaf6k1cRBEZz845dFMxDwCxKnYFtFilqjloDHJEmgKux+4sP4eWi3HKP4W2
         N3bOu4AB/NOrLWlRNPhN1qQ8oLnJF9XVIAIH9Yhm4HMX2oj0mEZC4npUuv2rQQDddWjH
         gGSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuvABDc93gBDz3DjyO7TidHWaD1Q4qebSc4JDs3HAgv+iSNQH0tG4o9XPKY1aiWORoohM8FF1DTzFAKRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWNb5WAiZ3/UvMOK4NaDjrBbZkOhPzot+VguAPlGNwpYKlux2d
	xenbtLU3nJRITd6dKbzxe3bj4u0fFpKVTiCE/15r/nfv5md8xnuO80oxGoU7XV8=
X-Google-Smtp-Source: AGHT+IH3FPLJ9NczEQNZcKAcDolBttBYKumyjdxeNCDK5IlZy+i6GBGjeqGjF6YI6L6mnh9DGpCO9w==
X-Received: by 2002:a05:651c:19a3:b0:2f9:cf21:b9f with SMTP id 38308e7fff4ca-2faf3c41fb1mr7646541fa.22.1728026265293;
        Fri, 04 Oct 2024 00:17:45 -0700 (PDT)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e86ac41csm800085a91.55.2024.10.04.00.17.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2024 00:17:44 -0700 (PDT)
Date: Fri, 4 Oct 2024 15:17:40 +0800
From: joeyli <jlee@suse.com>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Chun-Yi Lee <joeyli.kernel@gmail.com>,
	Justin Sanders <justin@coraid.com>, Jens Axboe <axboe@kernel.dk>,
	Pavel Emelianov <xemul@openvz.org>,
	Kirill Korotaev <dev@openvz.org>,
	"David S . Miller" <davem@davemloft.net>,
	Nicolai Stange <nstange@suse.com>,
	Greg KH <gregkh@linuxfoundation.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] aoe: add reference count in aoeif for tracking
 the using of net_device
Message-ID: <20241004071740.GJ3296@linux-l9pv.suse>
References: <20241002040616.25193-1-jlee@suse.com>
 <20241002040616.25193-2-jlee@suse.com>
 <69292789-fb92-45de-8608-185849fdd543@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69292789-fb92-45de-8608-185849fdd543@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)

Hi Damien, 

Thanks for your review, first!

On Wed, Oct 02, 2024 at 02:35:33PM +0900, Damien Le Moal wrote:
> On 10/2/24 1:06 PM, Chun-Yi Lee wrote:
> > This is a patch for debugging. For tracking the reference count of using
> > net_device in aoeif, this patch adds a nd_pcpu_refcnt field in aoeif
> > structure. Two wrappers, nd_dev_hold() and nd_dev_put() are used to
> > call dev_hold(nd)/dev_put(nd) and maintain ifp->nd_pcpu_refcnt at the
> > same time.
> > 
> > Defined DEBUG to the top of the aoe.h can enable the tracking function.
> > The nd_pcpu_refcnt will be printed to debugfs:
> 
> Why not make that a config option ? That would avoid having to edit the code to
> enable debugging...
>

This debug patch is only for tracking the reference count of net_device but
no other debugging feature. I don't want to add one more config option for
this small feature. On the other hand, the tracking requirment of reference
count is more for developer but not for administrator. That's why I did not
add a new option.
 
> > 
> > rttavg: 249029 rttdev: 1781043
> > nskbpool: 0
> > kicked: 0
> > maxbcnt: 1024
> > ref: 0
> > falloc: 36
> > ffree: 0000000013c0033f
> > 52540054c48e:0:16:16
> >         ssthresh:8
> >         taint:0
> >         r:1270
> >         w:8
> >         enp1s0:1	<-- the aoeif->nd_pcpu_refcnt is behind nd->name
> > 
[...snip]
> > +	ifp = ifi? ifi:get_aoeif(nd);
> > +	if (ifp) {
> > +		this_cpu_inc(*ifp->nd_pcpu_refcnt);
> > +		pr_debug("aoe: %s dev_hold %s->refcnt: %d, aoeif->nd_refcnt: %d\n",
> > +			 str, nd->name, netdev_refcnt_read(nd),
> > +			 aoeif_nd_refcnt_read(ifp));
> > +	} else
> > +		pr_debug("aoe: %s dev_hold %s->refcnt: %d\n",
> > +			 str, nd->name, netdev_refcnt_read(nd));
> 
> Missing curly brackets around the else statement.
>

Thanks for your reminder! I will add it in next version.
 
> > +}
> > +#define nd_dev_hold(msg, ifi) __nd_dev_hold(__FUNCTION__, (msg), (ifi))
> > +
> > +static inline void __nd_dev_put(const char *str, struct net_device *nd, struct aoeif *ifi)
> > +{
> > +	struct aoeif *ifp;
> > +
> > +	if (!nd)
> > +		return;
> > +	dev_put(nd);
> > +	ifp = ifi? ifi:get_aoeif(nd);
> > +	if (ifp) {
> > +		this_cpu_dec(*ifp->nd_pcpu_refcnt);
> > +		pr_debug("aoe: %s dev_put %s->refcnt: %d, aoeif->nd_refcnt: %d\n",
> > +			 str, nd->name, netdev_refcnt_read(nd),
> > +			 aoeif_nd_refcnt_read(ifp));
> > +	} else
> > +		pr_debug("aoe: %s dev_put %s->refcnt: %d\n",
> > +			 str, nd->name, netdev_refcnt_read(nd));
> 
> Same here.
>

Thanks! I will add it.
 
> > +}
> > +#define nd_dev_put(msg, ifi) __nd_dev_put(__FUNCTION__, (msg), (ifi))
> > +#else
> > +static inline void nd_dev_put(struct net_device *nd, struct aoeif *ifi)
> > +{
> > +	dev_hold(nd);
> > +}
> > +static inline void nd_dev_hold(struct net_device *nd, struct aoeif *ifi)
> > +{
> > +       dev_put(nd);
> > +}
> > +static inline void aoeif_nd_refcnt_free(const struct aoeif *ifp) {}
> > +#endif // DEBUG
> > diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
> > index 2028795ec61c..19d62ccca1e9 100644
> > --- a/drivers/block/aoe/aoeblk.c
> > +++ b/drivers/block/aoe/aoeblk.c
> > @@ -142,7 +142,12 @@ static int aoe_debugfs_show(struct seq_file *s, void *ignored)
> >  		ifp = (*t)->ifs;
> >  		ife = ifp + ARRAY_SIZE((*t)->ifs);
> >  		for (; ifp->nd && ifp < ife; ifp++) {
> > +#ifdef DEBUG
> > +			seq_printf(s, "%c%s:%d", c, ifp->nd->name,
> > +					aoeif_nd_refcnt_read(ifp));
> 
> I personnally find it better looking to align the arguments instead of adding a
> random tab...
>

Thanks! I will modify the second line to align with the first argument.
 
> > +#else
> >  			seq_printf(s, "%c%s", c, ifp->nd->name);
> > +#endif
> >  			c = ',';
> >  		}
> >  		seq_puts(s, "\n");
> > diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
> > index 3523dd82d7a0..9781488b286b 100644
> > --- a/drivers/block/aoe/aoedev.c
> > +++ b/drivers/block/aoe/aoedev.c
> > @@ -529,3 +529,23 @@ aoedev_init(void)
> >  {
> >  	return 0;
> >  }
> > +
> > +struct aoeif *
> > +get_aoeif(struct net_device *nd)
> 
> Why the line split after "*" ?
> 

I followed the same coding style in aoedev.c:

/* find it or allocate it */
struct aoedev *
aoedev_by_aoeaddr(ulong maj, int min, int do_alloc)
{
        struct aoedev *d;
...

If kernel coding style does not specify this. I prefer follow the original
style in the same driver.

Let me know if I missed anything, please. Then I will change the style. 


Thanks a lot!
Joey Lee

