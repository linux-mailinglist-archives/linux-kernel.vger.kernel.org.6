Return-Path: <linux-kernel+bounces-408143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDEF9C7BBF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8012B34C9E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AED5202638;
	Wed, 13 Nov 2024 18:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ECDy28lY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3263C20125C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 18:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731521982; cv=none; b=pKnD9jhz9SCAL0y8WrzST8BjS+LG5tMv+F5XPD00jeJ1XUmg2K91lEu56rTPYLQgmlMjW5NS4qwuhrFVl02vuEriYUwEZuNv0T5LqukcdAP+kmpjF1T9rQPocXJP/YIwMXl/qtbmB3z2UvmjITbZhrZLybqXNn2vliF5doY7GAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731521982; c=relaxed/simple;
	bh=he7PZ11vgkkKFwqChZr6a3LHZsCGCrxCQFWeyDR2zM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIxbhfn4lLGCf5/6zCPknROZBcteBbklygxVz1nyhRbW28qlXN9rz+csWnrPaw7KEev9Uuf0OPKotrF/MXgSW+rdImJjP9nmTYqJDAKo5rlmL3UZQh0C5V7VTDdzsc01jg/41NljX6KaTzueskPtntI8gj35y0ekgnX7yqL0n0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ECDy28lY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731521980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/XStPcwU28nRliHCrzV+elVqEzbDdwWRfdYSMPsom20=;
	b=ECDy28lYu8ytEoK2WhZHDrS6U4/kXabf4Ec3UMAJYsKSbkMIR1iEYX3aE2FkinYJGuTkxr
	89BbHTj5QlsFUC/BKx+QF685umooouLnhpt03AJ7h18LDVx/wFYDdftrfhbb2EWlV2HPP6
	wdmgEOqiXsz0aB4hDfHIVz51twxij9k=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-279-PBDdrrqZN1uNHPUkgNlkFA-1; Wed,
 13 Nov 2024 13:19:38 -0500
X-MC-Unique: PBDdrrqZN1uNHPUkgNlkFA-1
X-Mimecast-MFC-AGG-ID: PBDdrrqZN1uNHPUkgNlkFA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D91171955EE8;
	Wed, 13 Nov 2024 18:19:36 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.80.158])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5883019560A3;
	Wed, 13 Nov 2024 18:19:33 +0000 (UTC)
Date: Wed, 13 Nov 2024 13:19:30 -0500
From: Phil Auld <pauld@redhat.com>
To: Joseph Salisbury <joseph.salisbury@oracle.com>
Cc: peterz@infradead.org, mingo@kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	Steven Rostedt <rostedt@goodmis.org>, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] sched/fair: Add lag based placement
Message-ID: <20241113181930.GD402105@pauld.westford.csb>
References: <58289b1c-8a56-4607-8632-d36aef1fc5dd@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58289b1c-8a56-4607-8632-d36aef1fc5dd@oracle.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi,

On Wed, Nov 13, 2024 at 01:03:00PM -0500 Joseph Salisbury wrote:
> Hello,
> 
> During performance testing, we found a regression of ~9% performance with
> the TPCC benchmark.   This performance regression was introduced in
> v6.6-rc1.  After a bisect, the following commit was identified as the cause
> of the regression:
> 
> 86bfbb7ce4f6 ("sched/fair: Add lag based placement")
> 
> I was hoping to get some feedback from the scheduler folks.  Do you think
> gathering any additional data will help diagnose this issue?  Are there any
> tunable options that can changed to see how performance is affected?
> 

You can try turning off the PLACE_LAG sched feature:

    echo NO_PLACE_LAG > /sys/kernel/debug/sched/features

It's not what I'd call a tunable but it would allow you to test w/o it and
see what it does.  It should allow you to switch back and forth easily for
testing. 


Cheers,
Phil

> 
> Thanks,
> 
> Joe
> 
> 
> 
> 
> 
> 
> 
> 

-- 


