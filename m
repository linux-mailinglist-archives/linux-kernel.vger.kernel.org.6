Return-Path: <linux-kernel+bounces-177833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F3E8C451E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 18:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D904281FF8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 16:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB08915E89;
	Mon, 13 May 2024 16:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZjckHrhJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8303139E
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715617832; cv=none; b=MXYwu7aMqVaZjmz2f/dB+SDFkysRLA0JznNqrFFZ6tRTyN/UectzJ2O26GYYiNduD94nhioArjMN46grINUvJcHihNEdZ2sSvcMx01en7yocjogreGtAwGFCMRxYs3NM54wrW4OYVH81JSLRdCJyuRyQFwRTFC4Sv1IsDr4w628=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715617832; c=relaxed/simple;
	bh=mqkpP5V4QVSA4anpQiHTHwlb/AKm98IPiclk2+ATzrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2ZOxHtwFYt9U6N0S4OFPk4Z6d4aPsvVicrfuNf9o5HV3qWM91dsj/AuLqdsWvqAJ6x//Mmv1h/l+l5uChP9waHpRmMwxAnHAriGmq+zWkUp0hCoi6S9NGXlPCWWkY2COhwlGyDfxUijhwJtMCPgDmCi59JYQoPGJZyjBm/PQ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZjckHrhJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715617829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v7uExH1cJ0oWpPOfrUmnPVpCEdXUh777q3puoMHm6fI=;
	b=ZjckHrhJ3a/psZtPbH6gBKX0ZCg32aE4wUbnUrpDd/qBKpDu4X1z7wMjwPrdsoNWtzuLf2
	JZjt1CzMfb8EqioBR0yCRJx/8LKDjsFmwaq9gMoOGBOESc4K5Yaj35jMMvIIvqgqhHoFHd
	YKNxoKCfTUEHMRrcyS/JshMrZ2WT+ak=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-Q0iLV-uLPSO10HkIST7lFg-1; Mon,
 13 May 2024 12:25:28 -0400
X-MC-Unique: Q0iLV-uLPSO10HkIST7lFg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D9AFA1C05122;
	Mon, 13 May 2024 16:25:27 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.39.193.86])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5563451BF;
	Mon, 13 May 2024 16:25:22 +0000 (UTC)
Date: Mon, 13 May 2024 12:25:19 -0400
From: Phil Auld <pauld@redhat.com>
To: Paul Sherwood <paul.sherwood@codethink.co.uk>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/deadline: Fix grammar and typos in comments
Message-ID: <20240513162519.GC9998@lorien.usersys.redhat.com>
References: <20240511082644.44757-1-paul.sherwood@codethink.co.uk>
 <20240513135812.GA9998@lorien.usersys.redhat.com>
 <ef7021835015a5bdd5bf5404ee712853@codethink.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef7021835015a5bdd5bf5404ee712853@codethink.co.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

On Mon, May 13, 2024 at 04:19:10PM +0100 Paul Sherwood wrote:
> On 2024-05-13 14:58, Phil Auld wrote:
> > On Sat, May 11, 2024 at 09:26:44AM +0100 Paul Sherwood wrote:
> > > - conjugate verb to match subject of sentence
> > > - s/a entity/an entity/g
> > > - s/this misbehave/this misbehaviour/
> > > - a few typos
> > > 
> >   - not starting all the lines of a commit message with "-", priceless.
> > 
> > Plus, you're just repeating what's in the actual patch.
> > 
> > Otherwise, these changes themselves look good to me.
> 
> Thanks for the feedback - would you like me to re-submit without the
> bullet-points, or without the text entirely?
>

Personally I'd rather a sentence or two saying something like
"Fix some types and grammar issues in sched deadline comments."
Or something.  I know that's basically same as the title, but
that gets lost in the subject line, so maybe worded a little
differently? For this it probably doesn't need much but does
need something. 

I'm not the one to merge it though so I don't know if the
maintainer wanted to just fix it up at the time.   Just my
opinion...


For the changes themselves, fwiw,

Reviewed-by: Phil Auld <pauld@redhat.com>



Cheers,
Phil

> br
> Paul
> 

-- 
 


