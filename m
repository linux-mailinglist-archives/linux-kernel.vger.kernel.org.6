Return-Path: <linux-kernel+bounces-536854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB7BA484F1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E602D3B3CF9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1661B0420;
	Thu, 27 Feb 2025 16:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LS+e0/dV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494251A3178
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740673526; cv=none; b=iqenmRSgWNjS1Kaj2b+U7o2TZ28nDAknBNC5C8KETj/emnoUnC8MF1o3hsfEXtCqF3uX1xGpGVHD0qnRrC/q7eAnGccWaOKGyHGZBVly7cTnAn5h+DKLsm6I/tfpX+3VjkBhggm3O6pgrhsosPG0tFHTgDfnAnKAe8crozSI8Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740673526; c=relaxed/simple;
	bh=Y3Svy5k5B+ADYKeS4CvYilWZguABB/CMFmv+WYjzgwk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AdG4iUIyvdajiU7eRvl2kjRv697MW7A80RR6J0MKL+DRJWPqRCRgTVFp7B6WfzaAC/VqjAR54Fl1Sv7R6fN0rdA0bL942DT08xZ6e1GDXdDX51fUAvhsc4dLbXA6IqKOTZLV4hjdAxTJ/8D/A6Fhe4X4mmQJVI6IymaAiF7BcMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LS+e0/dV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740673524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y3Svy5k5B+ADYKeS4CvYilWZguABB/CMFmv+WYjzgwk=;
	b=LS+e0/dV8dJmxwNng1hUzBu5KVJZFRM8qi049XNDOeUlYgUw6TIPxZBpk1QIxf1mhF/pAT
	BaoXG7AvvETi44hGtwi9qcbDXtYwt+9qxgHkDYUb9kD8PJ7Ro9JUGkjZmzuUNPFYofG2np
	//MReuzBlnHSxCNDS/mJi6MsLWiwB6A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-n7veetYsOiijxJZiELwI4Q-1; Thu, 27 Feb 2025 11:25:22 -0500
X-MC-Unique: n7veetYsOiijxJZiELwI4Q-1
X-Mimecast-MFC-AGG-ID: n7veetYsOiijxJZiELwI4Q_1740673522
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43ab456333aso10553465e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:25:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740673521; x=1741278321;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3Svy5k5B+ADYKeS4CvYilWZguABB/CMFmv+WYjzgwk=;
        b=wTQ4r7VHltsvcKm7M4UkpElbvPZtL6M1zGYPnMw7eSXHfNYLtRAmnBC25WHBzRz/Oi
         xWFhsNJCFljEQL4Ere4A9D7bRp2ot4ysV2t/qQQNpm1CyvTk/LNQC7/HlJD77iRJM2lj
         7/N2Anyv9sYt218h+g+JXYFvhWOth2VlUeCtUeu3UXEUtuma6SkhhEq2Dq9wnzsgS2T1
         SHcAR5kn0JoL/w8CkGd7ohKKHVZG8XAWpoW6HW96Y4HYjeXeIhZei/05K1sehcN78Ixn
         kOrwbuxtI2BiN3Oz2RAAGaX6lZNFMQ6rfJkgHgafqBa0f3va14JtkaKhJYNhyOYV0kGn
         iaaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1aqC2W4U8QH7brafxx4o/qODu56uwPiZosYItjFpIoGBJLLIRFl4H6p2Fb0Hprp3V4KlxpOhrihJLK3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO+kd1E5dt94sgdURMXRbl7dAIoKvsFrfNUlgvduQuKYk1FjTA
	nEUg3P2NRVuiQZ+is5e5aMSWBBE5MWPQwoGAtsP5pBrFiCS8kfTAL0Om9zHbRk4P9jlD9Gnbq2/
	631mu2uz6sJlORRLlYaGsD6oN33eQikwyZn3OHIuGJnnTkLYTQfq7XHxy3UFuqQ==
X-Gm-Gg: ASbGncseIgOZt3eCp3/BfAK/caSQOsVyts1ZNxEafAjlQBoyE0UO6lwktHWnQQ8wmLb
	MqcOwL36cXbtlx0pAJllH7WETrvgUahmKYRp4nIwhM/HOLe0/NG53Iun8Plevi2SQ25eDnLpiC+
	OaO9UeyS2a18HOEi2IQV9JSKFSQxYsw1s3zXQh65bNC9g9/HNKuVsQlE+UE75MapeWLaeSAJgEa
	i2Be3vUJm9YX/Pk4/kFNBmcsjSYqKLDEVWs7o19i+ZFMm8/EL1b7qANJOjs3ZbYQ8eBCyiXDq/F
	tCQkqf/2ir/E9ftdhWAcYTAukjgESQO2kMVXHt8go+feByBbRM5saULDHBs5qmfdR2HSanwYNT6
	B
X-Received: by 2002:a05:600c:154e:b0:439:a0a3:a15 with SMTP id 5b1f17b1804b1-43ab0f3c907mr156209955e9.14.1740673521673;
        Thu, 27 Feb 2025 08:25:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHD2Cn5GyipbzqIO/zWJ4uoL86tZ//w/o6AfHqsI8TaVoCHQqRNsvksdhDS8k6lRaKq48oMcg==
X-Received: by 2002:a05:600c:154e:b0:439:a0a3:a15 with SMTP id 5b1f17b1804b1-43ab0f3c907mr156209815e9.14.1740673521401;
        Thu, 27 Feb 2025 08:25:21 -0800 (PST)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b7a27aa85sm27660515e9.28.2025.02.27.08.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 08:25:20 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton
 <akpm@linux-foundation.org>, Michal Hocko <mhocko@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Oleg Nesterov <oleg@redhat.com>,
 linux-mm@kvack.org
Subject: Re: [PATCH 2/6 v2] sched/fair: Use task_work_queued() on numa_work
In-Reply-To: <20250209223005.11519-3-frederic@kernel.org>
References: <20250209223005.11519-1-frederic@kernel.org>
 <20250209223005.11519-3-frederic@kernel.org>
Date: Thu, 27 Feb 2025 17:25:20 +0100
Message-ID: <xhsmh7c5bl5hr.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 09/02/25 23:30, Frederic Weisbecker wrote:
> Remove the ad-hoc implementation of task_work_queued().
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>


