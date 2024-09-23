Return-Path: <linux-kernel+bounces-336142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5549797EFAB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D516BB20F7A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3048019F11F;
	Mon, 23 Sep 2024 16:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ve/WO6GI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A46198830
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 16:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727110680; cv=none; b=QqlWOFnKYSx4Y31u9U2VZ3OBQFvCnbzfmeWgfGFkeC2m0n5CwWAJYeGdYa1VLGnjzRb3wK5WOBVc+T3HdF2b3y47nGL4EEEcMDunQyX8H5JIkvjLROCXTKasNantRnTVQpUDfgEpTS3fYTae8J0bk0NeiKVops2auyxi892sAKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727110680; c=relaxed/simple;
	bh=WtVP21g6JJmatc4LaT02Ju5K3VKCi+3DA7lAM7ObEKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmbJGU2bTvFmZ/UrX59VJHbacg2zLhjoa2rtu4WZPDWzqCX7fPIR2M9RV+vl6Wof9DrEdFAATfTVd47jxGpf29ayOMRhCkFqoqKJHld3YES27TMrvFxtzK8Hmws8htz6qIMHivwCm0eNKB7NoVJQj+k6en/8kU0RehlbLleav1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ve/WO6GI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727110677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=waZyJs7zHwvyC418q8DHDv4yjSSF9zTU3TIcK/nru3Q=;
	b=Ve/WO6GIGgyvjtukj2a4J3nYXNpb0aic5eRG1f6ZwyipUfBsaHgVMnFlqzmetMRTEJrMbP
	RcR7TWW+u7v7mxNkr6LebLZTEbJ6uaEX2l8LX2RYdBPb1y+wLywQXHJ1VIidlDinfw803w
	9O1YTElYmgIsHLZUOWXH1IC6tvEInjQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-RwjcbyxMNoed2sAjNPlYZA-1; Mon,
 23 Sep 2024 12:57:54 -0400
X-MC-Unique: RwjcbyxMNoed2sAjNPlYZA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 35798195FE2F;
	Mon, 23 Sep 2024 16:57:53 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.32.189])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 619D919560A3;
	Mon, 23 Sep 2024 16:57:51 +0000 (UTC)
Date: Mon, 23 Sep 2024 12:57:49 -0400
From: Phil Auld <pauld@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Andrea Righi <andrea.righi@linux.dev>,
	David Vernet <void@manifault.com>,
	Giovanni Gherdovich <giovanni.gherdovich@suse.com>,
	Kleber Sacilotto de Souza <kleber.souza@canonical.com>,
	Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Provide a sysfs enable_seq counter
Message-ID: <20240923165749.GB313849@pauld.westford.csb>
References: <20240921193921.75594-1-andrea.righi@linux.dev>
 <ZvCKPkwwC9-o2dsQ@mtj.duckdns.org>
 <20240923104548.GA308802@pauld.westford.csb>
 <ZvGJ_xT2LhYJHQbZ@slm.duckdns.org>
 <20240923160007.GA313849@pauld.westford.csb>
 <ZvGYjKAB07VJW7jq@gpd3>
 <ZvGbkCWR7AbgA6ug@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvGbkCWR7AbgA6ug@slm.duckdns.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Sep 23, 2024 at 06:47:12AM -1000 Tejun Heo wrote:
> Hello,
> 
> On Mon, Sep 23, 2024 at 06:34:20PM +0200, Andrea Righi wrote:
> ...
> > > > Yes, the load sequence number should stay persistent across all schedulers,
> > > > but each scheduler should report the sequence number at which *it* was
> > > > loaded. Note that this doesn't really change anything now. If you only care
> > > > whether any SCX scheduler has ever been loaded, you'd always look under
> > > > root.
> > > >
> > > 
> > > In my testing root is not there is nothing is loaded. 
> 
> Ah, right.
> 
> > Right, there's no root if no sched_ext scheduler is loaded. Maybe we
> > should always keep root present, or have a global counter and one
> > per-sched?
> 
> I'll apply as-is. Let's add per-scheduler load seq separately.

Thanks! I was thinking that per-scheduler you could just snapshot the
global counter (either before or after increment) on load. Then you
could easily tell when each was loaded relative to each other etc.

Especially while "per-scheduler" is defined by string comparison I'd
prefer not to rely on that for this use case. 


Cheers,
Phil

> 
> Thanks.
> 
> -- 
> tejun
> 

-- 


