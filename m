Return-Path: <linux-kernel+bounces-577012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73070A71748
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30A1616D3B2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38E52A1B2;
	Wed, 26 Mar 2025 13:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gU7JodmN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E211E5B6C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742995117; cv=none; b=hD+fM9Zng3c5/uBAzooPCA9+t8dpFjgyBK2St8DfE5/LZSyhujKM50fTsh6Udn/ml9AQRz/mAJ5W/5tO34hM8GZsJbtL9aoB199pEzQGL8lmAlOuyH8dgZngyYjtXPIs9ipcHynnKM8MYF/pLY9XXTV86MOEe7FxiGpfdk4h7dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742995117; c=relaxed/simple;
	bh=QLuJch2ERBqlv87gIUZKCCRf5Bhm6d2MbEPzKoCKVYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZyyiFu3oxFiup+4GVB7Q6PU9LkXR1Gxe4fFBL2Gd9WDBae617uy00B4I4blExzcMY+/V2CIsmq0bo/eeO71JKEnUOu1TIPW6U8QUgyChwC77ohCyirghVOfVz9EuSeAu6zommHejkl0vPm+okLIIqrynzcIBUfdGUuNT6/LKFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gU7JodmN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742995114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E8DVK2qL5FgbCY/uCKHMn6ye/SpMLqPirFZ8FryqEe8=;
	b=gU7JodmNMIkXEWDZXQlxpwzlkFh3F1Jq3aD7d5tsiHmK44lW2DH0aZ3s4xUGvZobKpl+y2
	y09+XK+k31zxlKVbSjG3W8GTGOBBVEdHmFFCIDnHU3NsAPXrQfKmRScozdTByXc9ukxRij
	lxs8EUv3p6nS5Q89IJrKlHfcIK/PRcw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-4onCRed-MtuYlvOKWRoB1A-1; Wed,
 26 Mar 2025 09:18:30 -0400
X-MC-Unique: 4onCRed-MtuYlvOKWRoB1A-1
X-Mimecast-MFC-AGG-ID: 4onCRed-MtuYlvOKWRoB1A_1742995108
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 065BE1933B50;
	Wed, 26 Mar 2025 13:18:28 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.88.205])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6BE10180A803;
	Wed, 26 Mar 2025 13:18:24 +0000 (UTC)
Date: Wed, 26 Mar 2025 09:18:21 -0400
From: Phil Auld <pauld@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Harshit Agarwal <harshit@nutanix.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jon Kohler <jon@nutanix.com>,
	Gauri Patwardhan <gauri.patwardhan@nutanix.com>,
	Rahul Chunduru <rahul.chunduru@nutanix.com>,
	Will Ton <william.ton@nutanix.com>
Subject: Re: [PATCH v2] sched/rt: Fix race in push_rt_task
Message-ID: <20250326131821.GA144611@pauld.westford.csb>
References: <20250214170844.201692-1-harshit@nutanix.com>
 <20250217115409.05599bd2@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217115409.05599bd2@gandalf.local.home>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Feb 17, 2025 at 11:54:09AM -0500 Steven Rostedt wrote:
> On Fri, 14 Feb 2025 17:08:44 +0000
> Harshit Agarwal <harshit@nutanix.com> wrote:
> 
> > Co-developed-by: Jon Kohler <jon@nutanix.com>
> > Signed-off-by: Jon Kohler <jon@nutanix.com>
> > Co-developed-by: Gauri Patwardhan <gauri.patwardhan@nutanix.com>
> > Signed-off-by: Gauri Patwardhan <gauri.patwardhan@nutanix.com>
> > Co-developed-by: Rahul Chunduru <rahul.chunduru@nutanix.com>
> > Signed-off-by: Rahul Chunduru <rahul.chunduru@nutanix.com>
> > Signed-off-by: Harshit Agarwal <harshit@nutanix.com>
> > Tested-by: Will Ton <william.ton@nutanix.com>
> > ---
> > Changes in v2:
> > - As per Steve's suggestion, removed some checks that are done after
> >   obtaining the lock that are no longer needed with the addition of new
> >   check.
> > - Moved up is_migration_disabled check.
> > - Link to v1:
> >   https://lore.kernel.org/lkml/20250211054646.23987-1-harshit@nutanix.com/
> > ---
> >  kernel/sched/rt.c | 54 +++++++++++++++++++++++------------------------
> >  1 file changed, 26 insertions(+), 28 deletions(-)
> 
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>

We've got some cases that look to be hitting this as well.

I'm a little concerned about turning some runtime checks into
BUG_ON()s but in this case I think we are really just going to
trap out on !has_pushable_tasks() check first and if not, pick
a different task and don't drop the lock so it should pass the
BUG_ON()s and fail to match the original task.  So...

Reviewed-by: Phil Auld <pauld@redhat.com>



Cheers,
Phil

> Peter or Ingo,
> 
> Care to take his patch
> 
> Thanks,
> 
> -- Steve
> 

-- 


