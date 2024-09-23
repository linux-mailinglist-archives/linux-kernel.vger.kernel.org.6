Return-Path: <linux-kernel+bounces-335748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DB597EA14
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7655B217C8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 10:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD4641C77;
	Mon, 23 Sep 2024 10:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Il0z/u3U"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7CD5475C
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 10:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727088360; cv=none; b=bZsVXhyiZOx7+gNuRN30DSghc2o2v7paAlHhTlGm/37a9VvHOOzojfMn7BsRP45Tyx34aSWzjIzYIJxMvmwhIlLzcpAlTcustYjC/2RSPuQgcVjRH2SOSbkh0QCcIfkTCOWCSAdsvABte0hn1JNYTvDmE8x5C3wupDNDoj26KzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727088360; c=relaxed/simple;
	bh=fMOdZPgrXj5kqX/IGsWsDzpa9PANUTMBvtsSNh3cfV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3/whaSYoDS0aRaFLVP9W1J3BwZ4984XmLpZV6Yhue8f5xg2NhRPIpi/93oy9UY8rSRkik2sTa/pO94215wrc9TyF81gMZBDlYAS5fEV7T1D5/+cXwxRhfZ85RNSImuDDlyRlS4v2rGmz/PHxHTdmAQeQ12XGFQSBDFSAwGLHPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Il0z/u3U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727088357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u1iahnWeoKQXKamAWbB/71kg6S6t9VFu9zGNvZPjo2A=;
	b=Il0z/u3UHjHyegHNGiQ+HMDOi1g3YOFuxn4j9am8jeBBiw+ssr67YcslOPIIPbeff7I7d6
	mkY/XJC0juojBM0l6LtmwKVnt+rx2TMs9oG67TV2SiMhFpklVs+CxjW+3Ci07d4ENx8f6Q
	IyPtxLhIZExotofEGKeEAjpGGYVuCEY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-IY9xwYCdNM-YIUO3DyUIcA-1; Mon,
 23 Sep 2024 06:45:53 -0400
X-MC-Unique: IY9xwYCdNM-YIUO3DyUIcA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F466190DE23;
	Mon, 23 Sep 2024 10:45:52 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.32.86])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 83F3619560AA;
	Mon, 23 Sep 2024 10:45:50 +0000 (UTC)
Date: Mon, 23 Sep 2024 12:45:48 +0200
From: Phil Auld <pauld@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: andrea.righi@linux.dev, David Vernet <void@manifault.com>,
	Giovanni Gherdovich <giovanni.gherdovich@suse.com>,
	Kleber Sacilotto de Souza <kleber.souza@canonical.com>,
	Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Provide a sysfs enable_seq counter
Message-ID: <20240923104548.GA308802@pauld.westford.csb>
References: <20240921193921.75594-1-andrea.righi@linux.dev>
 <ZvCKPkwwC9-o2dsQ@mtj.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvCKPkwwC9-o2dsQ@mtj.duckdns.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


Hi Tejun,

On Sun, Sep 22, 2024 at 11:21:02AM -1000 Tejun Heo wrote:
> Hello, Andrea.
> 
> On Sat, Sep 21, 2024 at 09:39:21PM +0200, andrea.righi@linux.dev wrote:
> >  static struct attribute *scx_global_attrs[] = {
> >  	&scx_attr_state.attr,
> >  	&scx_attr_switch_all.attr,
> >  	&scx_attr_nr_rejected.attr,
> >  	&scx_attr_hotplug_seq.attr,
> > +	&scx_attr_enable_seq.attr,
> >  	NULL,
> >  };
> 
> Can you put this in scx_sched_attrs instead as it probably would make sense
> to track this per-scheduler in the future when we support stacked
> schedulers.

It's not a per scheduler counter, though. It's global. We want to know
that a (any) scx scheduler has been loaded at some time in the past. It's
really only interesting when 0 or > 0. The actual non-zero number and which
scheduler(s) don't matter that much.

And it needs to persist when the scheduler is unloaded (I didn't look but
I uspect the per scheduler attrs come and go?).


Cheers,
Phil

> 
> Thanks.
> 
> -- 
> tejun
> 

-- 


