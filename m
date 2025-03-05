Return-Path: <linux-kernel+bounces-547355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 549A2A50630
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 18:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF9DE188B8DB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 17:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA93248899;
	Wed,  5 Mar 2025 17:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D6buxw3T"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784111A316B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 17:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741194903; cv=none; b=Arq2pVzATbRh++CV8k85/zFIPz4d/NDWkCAaEcbtbk/qkkoaK98wxikyMjs4DFFaOS5O31E1qr04IIKHVYKjdniZJxgqCHkrKV+VEjFeKrlo7X++Rw9BE1mCEV8wHH9B36UTJJ5B5MtEUZ8I0QWduN9FBW6rU0KReLfjZJeR/FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741194903; c=relaxed/simple;
	bh=NRyIecO563t4ImdsW1jXI5+TuemGsKbjSkF61FbeBh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVhCgjlj1lyX1uRKs36sTMlV0r13GBP93/2JkNsd0emPtVA4bR9iYsqAcsBbTi8l5qeR2AsCPf033GNsw+u54kdvwzKZ3Fzod7UHYf88jKiOszbdXV7ILxP/4UQobff4lD9sxDDSFWo/lsY3Hoi5vwxqDCSLYUhKKE9kzzUtbs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D6buxw3T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741194900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fq/qFJHlaiGnCpFW2MwqaXdlBcGCWunAFoUN3TsxIqk=;
	b=D6buxw3Tl15ICdcGCCP8iNH13QLv1EFC2n0qIiIvlYy3BnTZ7MXJEB7SmGgwFfGmCaL819
	iSZuFUnXCaN/pUibvqlO8SSzLkQPnzK55SxGuPu1uEfsCKobDxaG4tm1URuBdH2nKJXTQU
	yAvLiZH0G++GDZsuIZhJG+GHhK7Sz7E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-RCaTDZ4vN1KprYPjCjOS4A-1; Wed,
 05 Mar 2025 12:14:47 -0500
X-MC-Unique: RCaTDZ4vN1KprYPjCjOS4A-1
X-Mimecast-MFC-AGG-ID: RCaTDZ4vN1KprYPjCjOS4A_1741194886
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A45EE180AF4E;
	Wed,  5 Mar 2025 17:14:45 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.65.55])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B6EE3300019E;
	Wed,  5 Mar 2025 17:14:43 +0000 (UTC)
Date: Wed, 5 Mar 2025 12:14:41 -0500
From: Phil Auld <pauld@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Vishal Chourasia <vishalc@linux.ibm.com>,
	Vineeth Reddy <vineethr@linux.ibm.com>
Subject: Re: [PATCH v2] sched/isolation: Make use of more than one
 housekeeping cpu
Message-ID: <20250305171441.GC51446@pauld.westford.csb>
References: <20250218184618.1331715-1-pauld@redhat.com>
 <Z8b_A4YnOcNzGcaU@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8b_A4YnOcNzGcaU@localhost.localdomain>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Mar 04, 2025 at 02:24:19PM +0100 Frederic Weisbecker wrote:
> Le Tue, Feb 18, 2025 at 06:46:18PM +0000, Phil Auld a écrit :
> > The exising code uses housekeeping_any_cpu() to select a cpu for
> > a given housekeeping task. However, this often ends up calling
> > cpumask_any_and() which is defined as cpumask_first_and() which has
> > the effect of alyways using the first cpu among those available.
> > 
> > The same applies when multiple NUMA nodes are involved. In that
> > case the first cpu in the local node is chosen which does provide
> > a bit of spreading but with multiple HK cpus per node the same
> > issues arise.
> > 
> > We have numerous cases where a single HK cpu just cannot keep up
> > and the remote_tick warning fires. It also can lead to the other
> > things (orchastration sw, HA keepalives etc) on the HK cpus getting
> > starved which leads to other issues.  In these cases we recommend
> > increasing the number of HK cpus.  But... that only helps the
> > userspace tasks somewhat. It does not help the actual housekeeping
> > part.
> > 
> > Spread the HK work out by having housekeeping_any_cpu() and
> > sched_numa_find_closest() use cpumask_any_and_distribute()
> > instead of cpumask_any_and().
> > 
> > Signed-off-by: Phil Auld <pauld@redhat.com>
> > Reviewed-by: Waiman Long <longman@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Waiman Long <longman@redhat.com>
> > Cc: linux-kernel@vger.kernel.org
> > Link: https://lore.kernel.org/lkml/20250211141437.GA349314@pauld.westford.csb/
> 
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
>

Thanks Frederic!

Anyone with commit powers willing to pick this up?

Thanks,
Phil

-- 


