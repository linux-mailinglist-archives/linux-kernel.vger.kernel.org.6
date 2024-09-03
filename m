Return-Path: <linux-kernel+bounces-312856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC9D969C80
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C05F1B23044
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655CA1C7687;
	Tue,  3 Sep 2024 11:53:43 +0000 (UTC)
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF8119F41F
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 11:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725364423; cv=none; b=uKYwqd+znsaplD2G1gkGWZPpuGpCARp13qShcuMz9+NOsa9koLTbLCQp/nB/gTYnF++OiRyotjQhqNwg5NVLorFOb63tGDkAEl/AwvcSg4ohMpe76KrgtMavuQk+IjSNGgIkTxJQ5qUVeWwEx/p0eaYTh8BVz4h3nl9fM3IBb7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725364423; c=relaxed/simple;
	bh=urnj9GuG27DNI5xlR5nPfuJ6Tc7CunmKqS6unquM+Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XL4cjXOxNEdImuGdko36AYMHXKgSCnW9AT+eIWWU0I00vxs9bmZiqg+pWQy2BqhzpqExJ0cfjmNwES0+oClS4PILuJpV9rz9h6LHMYPXDAk08lY9TXAYQsZ5V8gHwnsbVmRVLPcXy0CMDAF7zhwIfWIIUQh9D/8p1Ra+a3HsIKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-43-iJenz3_vNcCMNekDt8McKQ-1; Tue,
 03 Sep 2024 07:53:34 -0400
X-MC-Unique: iJenz3_vNcCMNekDt8McKQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1956E1955BD0;
	Tue,  3 Sep 2024 11:53:32 +0000 (UTC)
Received: from hog (unknown [10.39.192.5])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6BCBD1955F1B;
	Tue,  3 Sep 2024 11:53:26 +0000 (UTC)
Date: Tue, 3 Sep 2024 13:53:23 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Bharat Bhushan <bharatb.linux@gmail.com>
Cc: Bharat Bhushan <bbhushan2@marvell.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, sgoutham@marvell.com,
	gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jerinj@marvell.com, lcherian@marvell.com,
	richardcochran@gmail.com
Subject: Re: [net-next PATCH v8 5/8] cn10k-ipsec: Add SA add/del support for
 outb ipsec crypto offload
Message-ID: <Ztb4sx49J46VLBFh@hog>
References: <20240903045937.1759543-1-bbhushan2@marvell.com>
 <20240903045937.1759543-6-bbhushan2@marvell.com>
 <ZtbY9AF1fjUCcBOH@hog>
 <CAAeCc_=Uox_JkD2WMs1ZqC-XFHfBnHWALEZC6iWhb0BNWB9Uow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAeCc_=Uox_JkD2WMs1ZqC-XFHfBnHWALEZC6iWhb0BNWB9Uow@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

2024-09-03, 16:03:06 +0530, Bharat Bhushan wrote:
> On Tue, Sep 3, 2024 at 3:08 PM Sabrina Dubroca <sd@queasysnail.net> wrote:
> > 2024-09-03, 10:29:34 +0530, Bharat Bhushan wrote:
> > > +static void cn10k_ipsec_del_state(struct xfrm_state *x)
> > > +{
> > > +     struct net_device *netdev = x->xso.dev;
> > > +     struct cn10k_tx_sa_s *sa_entry;
> > > +     struct cpt_ctx_info_s *sa_info;
> > > +     struct otx2_nic *pf;
> > > +     int sa_index;
> > > +
> > > +     if (x->xso.dir == XFRM_DEV_OFFLOAD_IN)
> > > +             return;
> > > +
> > > +     pf = netdev_priv(netdev);
> > > +     if (!mutex_trylock(&pf->ipsec.lock)) {
> > > +             netdev_err(netdev, "IPSEC device is busy\n");
> > > +             return;
> >
> > If we can't take the lock, we leave the state installed on the device
> > and leak some memory? That's not good. I assume we're going to reach
> > HW limits if this happens a bunch of times, and then we can't offload
> > ipsec at all anymore?
> >
> > I think it would be better to wait until we can take the lock.
> 
> This is atomic context (in_atomic() is true). So we need to call the
> trylock variant.

Ok. Then I think this should be a spinlock instead of mutex.

-- 
Sabrina


