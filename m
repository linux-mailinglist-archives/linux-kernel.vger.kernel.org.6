Return-Path: <linux-kernel+bounces-546585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEAFA4FC7D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 11:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49D5C3A84D4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 10:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BCC20AF69;
	Wed,  5 Mar 2025 10:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aODQPCWp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70CE20C46C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 10:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741171448; cv=none; b=EcQ13Q0LVGuaqHCiSnZvMX3wxBRzE5+mAGWhAAuECJPricps2CB/+YkIiqfl/HhbJpmy89THaPl7e+oSf9MGrKHiWUtYDRRg5OBcJDRatQHrQvoRRtU8Gb7qRbCuh6RtHNHHm5BQJ+cKAlp8ZKoEdYhBi+dcoPae0OVAZ6krHhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741171448; c=relaxed/simple;
	bh=pnb1XIoRVPvlKMtRz+d0FdZ4RSoph+8TZDhNZ6cm7q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByUL372tVYFU+XLvoYH4g/RHG3SLvTErNfd8s0UPqQ7Rr3ykHhd8x45kNWv2Sja4snQ7TuiocQvXvgI6LxksLoTXPnpsfaxhNZ5x21T/kH8zqMqP9UTU1ninRogmEcwWCP4deRltr5Yh3yTfHA7GVAeIX3bToMOmEbGB+3KPxYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aODQPCWp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741171445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d+3VZ7mTjx3GCM+QoBE9ZjOyMpVhYxq40Dj4O52FkRI=;
	b=aODQPCWpV/fqqICaEoQgkcMQ4lfH4FIU3wEl6IHubZS+X+al8+DFUPn+9iPKob6FyqbSlS
	9HOkzL8O8MedIR4hjJtw19KUeuzxY3A8CpKN47ak0/oVKHZC+gXae1nDfuPoe45AsLidas
	Y2aj6RWJlS5J3/C41tP2huQodnlPVRY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-55TctnptOq6h9ORIL89eBg-1; Wed, 05 Mar 2025 05:43:59 -0500
X-MC-Unique: 55TctnptOq6h9ORIL89eBg-1
X-Mimecast-MFC-AGG-ID: 55TctnptOq6h9ORIL89eBg_1741171439
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6e897598070so143623926d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 02:43:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741171439; x=1741776239;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d+3VZ7mTjx3GCM+QoBE9ZjOyMpVhYxq40Dj4O52FkRI=;
        b=ENLuXvCla+gsQ1aqqRKo6mex9DlW3RaHtGYvFkZq24QYvfUBB1BsUZxrmDgwhpPb2n
         1nLtYu2PAZIM474YcRJ4H5cYi73KWlerx/Zlfp3oGAPId1MCATfkTR2ALL1P3YJ3vhwZ
         3GiHevf4Lr/zaK8iVBOOzdU4jWJDMa45ybPGUqMK1EVYaBUQ4anmMXHlhQZs4xKsOni4
         muw3JH3OZzRTeene7VZ+gp/NOS+tOGW2vu57k+1Y1JkHf2GoZbHA/4Bwpdwrs4ulJWmI
         vKcbwF+G9Zs4kslWmzv6DV2/DUCNFStnDUOcpPdipq4q+ACzJ0A48vQ/trJ7G0BXhtFK
         n0zw==
X-Forwarded-Encrypted: i=1; AJvYcCUOnc+vlXrT7XFMkWBXGmoBJqAPFLcpNtD0+doJb5AMOiHI/5jI+2L432oqKIXAGrsPeqPD/tnUxoZ90+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkGpqK46KZzcpsvpSIlrQuVlhJMYq6eZJ94udyVdOU3B1pAKmd
	3rrtzreax0RUH6K5vzO5RPrCusZ9PAYGvlGU4gXNqrskwTvsqlijVaISu6U8prluyAYX8D/K3me
	r3hiMcNNrRr2gJyiAvOJ5v+0Muj+iKxUJ6ppdGXNGW6i+kaKwP+cezOihLiJJXw==
X-Gm-Gg: ASbGncucZq1LWXRKWvTLfAtKKKcTQ7OTBNHtCXpdztm81K5F/Tr8mTvSKTCoNc8Z2tG
	OZdXn9cMoptvWspSpDUwt/Vb4+A0HtwKiG+qtbXlf97OoAWsI4KKMj9thIQH/+g/hwdVERRjaJ9
	9rmamxP0uJdyaVNGH3TXLhrt41mTovhm6/D8Za4Lg1DeEb45oXUI8IEytx8kpM76azpUsMEXTho
	RhfqnoE5/3an6VmcTKI+jzZMzogPCdR7Q08STc9OfMe3grXHwX1DBNUAOpcp6fiO3RnQ7zAg2AT
	EplxmAqj5by/4iydMu55gR8wGosp+C+8/+esrvlFOOJdZmrILGgwDE+YDb2GTDon6DnLXqOxWHv
	hFqX6
X-Received: by 2002:a05:6214:2122:b0:6e8:9b55:b0ab with SMTP id 6a1803df08f44-6e8e6cc7655mr37526316d6.4.1741171438988;
        Wed, 05 Mar 2025 02:43:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdlHjzz7+7wDbWNIybVn4Volb3Dg5cZdQXTOpT7OoT7JX+QAw9eiw2fXX/FzYzQ1jmLHgwkQ==
X-Received: by 2002:a05:6214:2122:b0:6e8:9b55:b0ab with SMTP id 6a1803df08f44-6e8e6cc7655mr37526166d6.4.1741171438699;
        Wed, 05 Mar 2025 02:43:58 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8976d9fb8sm77893696d6.94.2025.03.05.02.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:43:57 -0800 (PST)
Date: Wed, 5 Mar 2025 10:43:53 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Harshit Agarwal <harshit@nutanix.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jon Kohler <jon@nutanix.com>,
	Gauri Patwardhan <gauri.patwardhan@nutanix.com>,
	Rahul Chunduru <rahul.chunduru@nutanix.com>,
	Will Ton <william.ton@nutanix.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v3] sched/rt: Fix race in push_rt_task
Message-ID: <Z8gq6bWNPDtnUYsW@jlelli-thinkpadt14gen4.remote.csb>
References: <20250225180553.167995-1-harshit@nutanix.com>
 <Z8bEyxZCf8Y_JReR@jlelli-thinkpadt14gen4.remote.csb>
 <20250304103001.0f89e953@gandalf.local.home>
 <Z8cnwcHxDxz1TmfL@jlelli-thinkpadt14gen4.remote.csb>
 <9688E172-585C-423B-ACF6-8E8DEAE3AB59@nutanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9688E172-585C-423B-ACF6-8E8DEAE3AB59@nutanix.com>

On 04/03/25 18:37, Harshit Agarwal wrote:
> Thanks Juri for pointing this out.
> I can send the fix for deadline as well. 
> Is it okay if I do it in a separate patch?

Yes, we would need a separate patch.

> From taking a quick look at the code, I can see that the same fix won’t 
> apply as is in case of deadline since it has two different callers for
> find_lock_later_rq.

Right, indeed.

> One is push_dl_task for which we can call pick_next_pushable_dl_task
> and make sure it is at the head. This is where we have the bug.

OK.

> Another one is dl_task_offline_migration which gets the task from
> dl_task_timer which in turn gets it from sched_dl_entity.
> I haven’t gone through the deadline code thoroughly but I think this race
> shouldn’t exist for the offline task (2nd) case. If that is true then the fix
> could be to check in push_dl_task if the task returned by find_lock_later_rq
> is still at the head of the queue or not.

I believe that won't work as dl_task_offline_migration() gets called in
case the replenishment timer for a task fires (to unthrottle it) and it
finds the old rq the task was running on has been offlined in the
meantime. The task is still throttled at this point and so it is not
enqueued in the dl_rq nor in the pushable task list/tree, so the check
you are adding won't work I am afraid. Maybe we can use dl_se->dl_throttled
to differentiate this different case.

Thanks,
Juri


