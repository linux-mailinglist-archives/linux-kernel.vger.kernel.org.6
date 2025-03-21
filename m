Return-Path: <linux-kernel+bounces-570893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF89A6B5E4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 09:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BA2C7A86BB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6031EC009;
	Fri, 21 Mar 2025 08:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ceBZO+6g"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C8D79EA
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742544979; cv=none; b=E7g7wVDi6syLLzIZcArLkPAcbzmt2CMOlstNnqhDQnUOMs87HRB9A3wRFwqza2EI0b2cMb63+Pdmok9fNbSnzaJiyQMTt47tugNWfcdWdBePiR93ny5cgcCnatZIa9OtMXjTGLG5STtBSYMU4x3tU23eVoH/PaRY1/1SFgAGKh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742544979; c=relaxed/simple;
	bh=YLHOV03L7VuMVxa4EUpKAXdoaHrmKGwNEaOBF+8UflY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6LXMaLg1g3y6feZn9WYn8PKFxeqUsNnU4vEa+C0kZVtJ1sFhC5NtgIt5AFtC1YXx7LZiZ/DAUTrsIJocJ59q/RAzWl8DnM6FBfwyczxDpeS53yrEwzUdn8/XWtWPIy/Q2IwOvd+KD2JownaomhjDbEvfqA0dPvF1ZdSk+LQqRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ceBZO+6g; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742544976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nmO1kvLBJP1B2aKLuVg4GwQbIKEXPnUwaAJTPxGHvFk=;
	b=ceBZO+6g2fY1MjdY+8C4/MwlCfpb7/C2oTO6yfUQgh908bIcaf9U0AVguUk4J9LWSaxvna
	gk1zNZPXqLi19pRwGeaDMYxaGIwp0/zNkm0PdkL488pzfjbX6OZ/ZU92oviMJfx5pncvh8
	FKnUzvPTm3OOPjOWvCIzuf4TNOLcmok=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-ARr3YHa-PSWP8y_eqIY_Pg-1; Fri,
 21 Mar 2025 04:16:13 -0400
X-MC-Unique: ARr3YHa-PSWP8y_eqIY_Pg-1
X-Mimecast-MFC-AGG-ID: ARr3YHa-PSWP8y_eqIY_Pg_1742544972
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C4EB18DB8C5;
	Fri, 21 Mar 2025 08:16:12 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.45.225.99])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B94691800370;
	Fri, 21 Mar 2025 08:16:08 +0000 (UTC)
Date: Fri, 21 Mar 2025 09:16:04 +0100
From: Phil Auld <pauld@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <llong@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
	Vishal Chourasia <vishalc@linux.ibm.com>,
	Vineeth Reddy <vineethr@linux.ibm.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2] sched/isolation: Make use of more than one
 housekeeping cpu
Message-ID: <20250321081604.GA103187@pauld.westford.csb>
References: <20250218184618.1331715-1-pauld@redhat.com>
 <Z8b_A4YnOcNzGcaU@localhost.localdomain>
 <20250305171441.GC51446@pauld.westford.csb>
 <521d9ec6-9aab-46d9-82e6-dab9c52970af@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <521d9ec6-9aab-46d9-82e6-dab9c52970af@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi Peter,

On Fri, Mar 14, 2025 at 07:38:22PM -0400 Waiman Long wrote:
> On 3/5/25 12:14 PM, Phil Auld wrote:
> > On Tue, Mar 04, 2025 at 02:24:19PM +0100 Frederic Weisbecker wrote:
> > > Le Tue, Feb 18, 2025 at 06:46:18PM +0000, Phil Auld a écrit :
> > > > The exising code uses housekeeping_any_cpu() to select a cpu for
> > > > a given housekeeping task. However, this often ends up calling
> > > > cpumask_any_and() which is defined as cpumask_first_and() which has
> > > > the effect of alyways using the first cpu among those available.
> > > > 
> > > > The same applies when multiple NUMA nodes are involved. In that
> > > > case the first cpu in the local node is chosen which does provide
> > > > a bit of spreading but with multiple HK cpus per node the same
> > > > issues arise.
> > > > 
> > > > We have numerous cases where a single HK cpu just cannot keep up
> > > > and the remote_tick warning fires. It also can lead to the other
> > > > things (orchastration sw, HA keepalives etc) on the HK cpus getting
> > > > starved which leads to other issues.  In these cases we recommend
> > > > increasing the number of HK cpus.  But... that only helps the
> > > > userspace tasks somewhat. It does not help the actual housekeeping
> > > > part.
> > > > 
> > > > Spread the HK work out by having housekeeping_any_cpu() and
> > > > sched_numa_find_closest() use cpumask_any_and_distribute()
> > > > instead of cpumask_any_and().
> > > > 
> > > > Signed-off-by: Phil Auld <pauld@redhat.com>
> > > > Reviewed-by: Waiman Long <longman@redhat.com>
> > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > Cc: Juri Lelli <juri.lelli@redhat.com>
> > > > Cc: Frederic Weisbecker <frederic@kernel.org>
> > > > Cc: Waiman Long <longman@redhat.com>
> > > > Cc: linux-kernel@vger.kernel.org
> > > > Link: https://lore.kernel.org/lkml/20250211141437.GA349314@pauld.westford.csb/
> > > Acked-by: Frederic Weisbecker <frederic@kernel.org>
> > > 
> > Thanks Frederic!
> > 
> > Anyone with commit powers willing to pick this up?
> 
> Is this patch eligible to be merged into sched/core for the current cycle or
> will have to wait until the next one?
> 
> Thanks,
> Longman
> 

This is the patch (in this thread somewhere...) I mentioned the other
day at OSPM. 

Thanks!


Cheers,
Phil

-- 


