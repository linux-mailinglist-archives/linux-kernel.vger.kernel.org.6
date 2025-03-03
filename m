Return-Path: <linux-kernel+bounces-542551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E758AA4CB08
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DED317575A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB6122FAC3;
	Mon,  3 Mar 2025 18:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="hIW8xu80"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54B42135B2
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 18:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741026797; cv=none; b=Cz8Xld4HFUSxB2AkgKsQFa6z1jiPgAW4LhQP+eN8N8zlNBmfr31gWsNuht017TKQ257aLXKgGINO98fetRMCqIIRjexMJAi3EcIzAIpgVc/SVTPKmkpN8S5lnSW277MDz9LCR5HB41l+lT+qxV022ecrdWXa9VziRpfQVrFAZPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741026797; c=relaxed/simple;
	bh=nLsZQWU52zNpjADgh0ICFnQQGW+rEKz5WdNIEuaOhHc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXkyL8Kb1gDT9kq54uF2+UjFX5i5cN4Wm4FpxVWSwlBFpIdNjD2CKSB47uG6FjzHlri0WziaAPtIjDx44cGSn3QxRrze9Kz6isTA/q7xjcoTTUX5Y5Y1QSq0Efp7sl7HFVd6MC/VfGy6MNiJhqeiYyOHSuzeBAwP3os9IqJivz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=hIW8xu80; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-474bc1aaf5fso63412721cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 10:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1741026793; x=1741631593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eue7H577BiYj6J1iAvYYX1Oj2dBdZtr+Y46C5Co92Q0=;
        b=hIW8xu80K46nAHjWLZS6ZdCCK+1hNH9zMOiOo8mbLRQ9+DggAri5K5OcNagElVmeLp
         ISRhJEc7mpikwYJOOiVfqJYJMveR0DAUSVBkbWgnl+sLmItFOD1uDw9HA3Gb7aYDdVdK
         ukOe2C0lJVykQUBlHTVosz+jqsdXc8bH32wKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741026793; x=1741631593;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eue7H577BiYj6J1iAvYYX1Oj2dBdZtr+Y46C5Co92Q0=;
        b=a5imBAfGsLYfFlOAu/gd3y6+D+pCv2QTxxZirvR2RgoR17S6nwMzjgwxVBbKheiFrO
         7m9e5dh5hpZGi/6kupvc1r/8Ifm00+6YLbKbe5WPhgnJwBwMKyG9sZkUj1/NPu7Qo4Oc
         v8dRwSwkXKMYWgDdoWF3F5C0uGTtRrljDEg8RM8bCiHfufGicb6f9J7WcDgXEQmQuRcL
         4Jl40NzHT25vw4Tb0rGgB8oWNih3RB/8HXM7MRPS0xyr32KHsN6CamXKksdvTSWqEAl4
         P283+PpOWE+mMCRDqCYtPZS8bb1Z+DE0zSWPEfBeqZ5KnaB/6qtDXinoa2xvGHyruUbj
         Z1EA==
X-Forwarded-Encrypted: i=1; AJvYcCVV3D0R6Q3gZzremr0ozNdrrNb0tC+rNUfRw1kFPBk+tQTVbbl5XN2uPbmy1585emnWZ8OPNuh/II4kT/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7IXX6nL0UsIs9xFUQ+vH7dqwu/wD1/r7LtBVj5SnoOPVZTx1z
	I8mURAvN2ra3aEicKPPw1jynaMcVjlZiXXa9KHXij6J/SWM3m/njePSv7j6qPIE=
X-Gm-Gg: ASbGncvhSz8bMZW38uTT5ddD134WaanYuQPR0xGargLTiyROCnAkKLcgx79OV/9OuqF
	ztvkfqjkcsqRS3INnvualkAadMQRYwkRDtPAmXK1XRRXfbAmkip+zaBZoBuvPl8UQZuNlpolqpL
	x+OO3YKjBJsG1PqB5JXcrHopiwNqFDLRTi9/5cJBgQlPghE28zLmErqjetGVzIDny1yRIwDJSFM
	4a8n9DTCvtQ9ohHufUCumuoAWCeWpJayAC81C9u2/VdRvgGqnetYtYQSArGKYLRhBHlZ72cGULW
	PTv7QgIsw0tzjEIsJi1sR5/MdfMEtYJaxSWh5hXph15TFKKXlVsQs7MnmewTioqSLdNCsMsyeVF
	CASRUCGs=
X-Google-Smtp-Source: AGHT+IF6Vz0gCa5XLjA6WsMMc9U4S/ofS/vlbDvCV4hoA9DNJ2ex3Jp7A+0DKEqmWTWUFP8908I9Cw==
X-Received: by 2002:a05:622a:1a9d:b0:471:f9e7:5042 with SMTP id d75a77b69052e-474bc083cc3mr236149171cf.14.1741026793293;
        Mon, 03 Mar 2025 10:33:13 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-474721bf582sm61201591cf.37.2025.03.03.10.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 10:33:12 -0800 (PST)
Date: Mon, 3 Mar 2025 13:33:10 -0500
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, gerhard@engleder-embedded.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, mst@redhat.com,
	leiyang@redhat.com,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 3/4] virtio-net: Map NAPIs to queues
Message-ID: <Z8X15hxz8t-vXpPU@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, gerhard@engleder-embedded.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, mst@redhat.com,
	leiyang@redhat.com,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	open list <linux-kernel@vger.kernel.org>
References: <20250227185017.206785-1-jdamato@fastly.com>
 <20250227185017.206785-4-jdamato@fastly.com>
 <20250228182759.74de5bec@kernel.org>
 <Z8Xc0muOV8jtHBkX@LQ3V64L9R2>
 <Z8XgGrToAD7Bak-I@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8XgGrToAD7Bak-I@LQ3V64L9R2>

On Mon, Mar 03, 2025 at 12:00:10PM -0500, Joe Damato wrote:
> On Mon, Mar 03, 2025 at 11:46:10AM -0500, Joe Damato wrote:
> > On Fri, Feb 28, 2025 at 06:27:59PM -0800, Jakub Kicinski wrote:
> > > On Thu, 27 Feb 2025 18:50:13 +0000 Joe Damato wrote:
> > > > @@ -2870,9 +2883,15 @@ static void refill_work(struct work_struct *work)
> > > >  	for (i = 0; i < vi->curr_queue_pairs; i++) {
> > > >  		struct receive_queue *rq = &vi->rq[i];
> > > >  
> > > > +		rtnl_lock();
> > > >  		virtnet_napi_disable(rq);
> > > > +		rtnl_unlock();
> > > > +
> > > >  		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
> > > > +
> > > > +		rtnl_lock();
> > > >  		virtnet_napi_enable(rq);
> > > > +		rtnl_unlock();
> > > 
> > > Looks to me like refill_work is cancelled _sync while holding rtnl_lock
> > > from the close path. I think this could deadlock?
> > 
> > Good catch, thank you!
> > 
> > It looks like this is also the case in the failure path on
> > virtnet_open.
> > 
> > Jason: do you have any suggestions?
> > 
> > It looks like in both open and close disable_delayed_refill is
> > called first, before the cancel_delayed_work_sync.
> > 
> > Would something like this solve the problem?
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 76dcd65ec0f2..457115300f05 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2880,6 +2880,13 @@ static void refill_work(struct work_struct *work)
> >         bool still_empty;
> >         int i;
> > 
> > +       spin_lock(&vi->refill_lock);
> > +       if (!vi->refill_enabled) {
> > +               spin_unlock(&vi->refill_lock);
> > +               return;
> > +       }
> > +       spin_unlock(&vi->refill_lock);
> > +
> >         for (i = 0; i < vi->curr_queue_pairs; i++) {
> >                 struct receive_queue *rq = &vi->rq[i];
> >
> 
> Err, I suppose this also doesn't work because:
> 
> CPU0                       CPU1
> rtnl_lock                  (before CPU0 calls disable_delayed_refill) 
>   virtnet_close            refill_work
>                              rtnl_lock()
>   cancel_sync <= deadlock
> 
> Need to give this a bit more thought.

How about we don't use the API at all from refill_work?

Patch 4 adds consistent NAPI config state and refill_work isn't a
queue resize maybe we don't need to call the netif_queue_set_napi at
all since the NAPI IDs are persisted in the NAPI config state and
refill_work shouldn't change that?

In which case, we could go back to what refill_work was doing
before and avoid the problem entirely.

What do you think ?

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 76dcd65ec0f2..d6c8fe670005 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2883,15 +2883,9 @@ static void refill_work(struct work_struct *work)
        for (i = 0; i < vi->curr_queue_pairs; i++) {
                struct receive_queue *rq = &vi->rq[i];

-               rtnl_lock();
-               virtnet_napi_disable(rq);
-               rtnl_unlock();
-
+               napi_disable(&rq->napi);
                still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
-
-               rtnl_lock();
-               virtnet_napi_enable(rq);
-               rtnl_unlock();
+               virtnet_napi_do_enable(rq->vq, &rq->napi);

                /* In theory, this can happen: if we don't get any buffers in
                 * we will *never* try to fill again.

