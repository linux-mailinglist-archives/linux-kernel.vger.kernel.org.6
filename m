Return-Path: <linux-kernel+bounces-303654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FC3961316
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 264821C22406
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A312A1C7B61;
	Tue, 27 Aug 2024 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gP658GyN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CEA1C6F40
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 15:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724773321; cv=none; b=qzPVlI9g2B/mCgsdhLTr4w8UIOWT5LwNZ9VAcAg09vqRCRGU45RxyWz5G5JACJmleRyau6NPAxrd8IBB+smWBqBoUgoCTj/MYOXr+dlduMZy+T3Bn+4WxvprJ+41HZtjlAWGAGlFe/SzbVqdyV48XoHZdz6kQ1tx5fRR7wwsqUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724773321; c=relaxed/simple;
	bh=ZAWhcKduUxTafb6/Wx9uvfL0qKweULJ0YIrs2j6Xqe0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j1hlAvXTX8PzG1IewfCDz5gMHORX8iumAHQ8+PcczU3hHzlHj2KXB7+m18p0VlHGCHYSimjjC2QmgB2iy0FwOmwUop4m/EMmC17RbxtqCqD/9oGhZgCLpq1ptEvAGCn6EIgg5DNTtCfeo8ro/2qqlvH09E6DWCt6igE7qTli2Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gP658GyN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724773318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u6Px/4/l19JcNl/fwMiblMY++s/BJTa8xB5nFkqhBcc=;
	b=gP658GyNtruYxlIZqw3AfNRPdujZa01P6R50j+1Ljv82xDZ5miSI3nqf5Y3TSKFTBuH9Fb
	8RzGcRut8IKmWx9psSDX87HQin1kyYfV5WOiiBGwdxyHvrCpuxnD9V/if/Ab1NlPvaSvFF
	XpI4r5zdxl1XwYyRUtec2XxVOgvP74w=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-q2013YTsPxe73m1zh14SxQ-1; Tue, 27 Aug 2024 11:41:56 -0400
X-MC-Unique: q2013YTsPxe73m1zh14SxQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-534398200ffso5363201e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 08:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724773314; x=1725378114;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u6Px/4/l19JcNl/fwMiblMY++s/BJTa8xB5nFkqhBcc=;
        b=kAziARRH1Hu4ZvyO2HY/7GoBjLDxkyCZCQU4hp5SndXhoRuwW83k2jiiTKaj++CzjT
         FMDjrkThAW+JgiwyxjSBr90hFQEclycWOVjNj2dirdyKSGl6WufrkW+bObw/2T4eBDl8
         Ypr49jt7xvmfgC+9oU+/COzIBTHI0BPryIdBXdmy70IlFHvIYVJghSorNxK7eaKF3z0S
         /LR3LQV8PaFMCDiF7tYiYhVzbjSyRA60fE6Hm3Y6aJtJlXJUGBVSWh5YXUvFMNLXWbwE
         9Xzpe3IZw6lzAgmZhJFwqoPQmyqHHAwGzr2lDltIqmpDoPzfffrzT7m1c9/TAepAicwn
         D56g==
X-Forwarded-Encrypted: i=1; AJvYcCUd4AX0Yx8MwG88fFCHi567AiJJeb4hvB3wE8U3w3GJOMa2Hdio0CuVqna2DpVrEQVpgtgMD1lXFwSsyUs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs+01KDI1kSYbCZ8pjvK3WhCoqRYRu0YVQys6mBfSxbQSPIc9f
	ZW3H+qjof0qphfXxJNpXbKq7YO8twLr28IvnB426GhSWZFeUZzmAr94e2wlCTSQY0RFAKWACj2O
	venQrdqlITi8bqY1VOiz/KY7hN81pzF2qGPqjzIIBv/pv7M/tvxHHHKuNvpMdZg==
X-Received: by 2002:a05:6512:1111:b0:530:e0fd:4a97 with SMTP id 2adb3069b0e04-534387e89d7mr10671847e87.0.1724773314272;
        Tue, 27 Aug 2024 08:41:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGya5Cog7WzH/edbQ2/bZc/cQt4hmmJzKjOW3d0Qk6T3JTXf/LNCy4sxIbNx60ZPcbIN9Vw2w==
X-Received: by 2002:a05:6512:1111:b0:530:e0fd:4a97 with SMTP id 2adb3069b0e04-534387e89d7mr10671806e87.0.1724773313471;
        Tue, 27 Aug 2024 08:41:53 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e549cd4esm123171166b.55.2024.08.27.08.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 08:41:53 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: paulmck@kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 sfr@canb.auug.org.au, linux-next@vger.kernel.org, kernel-team@meta.com
Subject: Re: [BUG almost bisected] Splat in dequeue_rt_stack() and build error
In-Reply-To: <xhsmhle0inuze.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
References: <c28dbc65-7499-41a5-84d0-991843153b1a@paulmck-laptop>
 <20240823074705.GB12053@noisy.programming.kicks-ass.net>
 <xhsmho75fo6e4.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <b1824f4a-f5cc-4011-876f-8a73cf752067@paulmck-laptop>
 <xhsmhle0inuze.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Date: Tue, 27 Aug 2024 17:41:52 +0200
Message-ID: <xhsmhikvmnfb3.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 27/08/24 12:03, Valentin Schneider wrote:
> On 26/08/24 09:31, Paul E. McKenney wrote:
>> On Mon, Aug 26, 2024 at 01:44:35PM +0200, Valentin Schneider wrote:
>>>
>>> Woops...
>>
>> On the other hand, removing that dequeue_task() makes next-20240823
>> pass light testing.
>>
>> I have to ask...
>>
>> Does it make sense for Valentin to rearrange those commits to fix
>> the two build bugs and remove that dequeue_task(), all in the name of
>> bisectability.  Or is there something subtle here so that only Peter
>> can do this work, shoulder and all?
>>
>
> I suppose at the very least another pair of eyes on this can't hurt, let me
> get untangled from some other things first and I'll take a jab at it.

I've taken tip/sched/core and shuffled hunks around; I didn't re-order any
commit. I've also taken out the dequeue from switched_from_fair() and put
it at the very top of the branch which should hopefully help bisection.

The final delta between that branch and tip/sched/core is empty, so it
really is just shuffling inbetween commits.

Please find the branch at:

https://gitlab.com/vschneid/linux.git -b mainline/sched/eevdf-complete-builderr

I'll go stare at the BUG itself now.


