Return-Path: <linux-kernel+bounces-261863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6CD93BD1B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDD1EB21428
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 07:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7CD16F8E8;
	Thu, 25 Jul 2024 07:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GrjrbXOj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6041CA8A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 07:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721892579; cv=none; b=Lbr7rLZu1wR6nwfEEjr6XAM1mstURvjLu0tw/QFKWdlMosgsoFIMmE8rqouqYQY3o6RKOWfDow4g+nagR3lH1WAVX6VJBEAIpBpKazybpjO9I6Mtka0bQD+/orq/e1K/7eOC2AbnA9fLd/VoxrnDcIPrgFA1C9xsxLMvvUA6v2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721892579; c=relaxed/simple;
	bh=d0JcjQ7PzPhrX7UMVBBk4qqjq91f9QiBucj6SkIpuN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcBLx6o6nYtmrWEwUPASikVibeW38vMqVAODEOjp26PBWK8OWFofEDolP1dBDxu6BIKJlgwrnCCUk7ct8GHvuWAi90qFNNiWYpZ0dvXi3Iu7D0uxUnvSm5yXkfpjVUfk03Pbc0rXIIC0rCGFhAFwMrFtahC/B9MtXU8Z6vVCAfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GrjrbXOj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721892576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1pH7HnZMt21wFJEYp8Fh9822e+D5ZPDqcBqi6IuUnUM=;
	b=GrjrbXOjigr9shVF/KTrD9cRKgE+puN4XLxUGZFyeVT4Ojdlgw4yCSo++57RYwE7Hq3yGK
	W36ZL2e5Z0IDRdsnFRYdMhbq7yphhIEdNv2nig6Tzw6BFJGEa/Ho4+oUgb8tuqxMpzaTco
	HdeM/a+gs72l72csf1Z7k/CiuNxKRFE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-bbzqnDg3MgqRt5YqX8971g-1; Thu, 25 Jul 2024 03:29:32 -0400
X-MC-Unique: bbzqnDg3MgqRt5YqX8971g-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b5de421bc6so8891606d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 00:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721892572; x=1722497372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1pH7HnZMt21wFJEYp8Fh9822e+D5ZPDqcBqi6IuUnUM=;
        b=syCmcIQf/fE9MWFSlaSQQJdtxlizJUbqqTaafYMQHCz8J9BZbiBSW7JM5t2mt3sHGY
         meVDj7KbFqKGhZma56DlOQ7TdaP2WKVTToc+3/mUV6WlKBjIGhCU2esM4d1NB7pkv1yn
         4PkUQczNRVRlZiYZyt8bFl12wQdiZKgdDq21P3sJbJx+K6dgL3HJeIHbocAd25csLkKb
         zFXHWiBzCXAx+MygYmHbUjevt5tIdtYjXojBhOn9tn0mhfiUJABUQ3O+3T8r1Pk1KsjR
         jSqWBKz7cI6BPwmLGBwjNtD1ot5vIy7/PiEKYd4hOcCHkffFRK11pCKmTPZT2qFViWUd
         V9DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWjrf5uzb4NE3YmmTxjzKFtAgVBwptivzqZ3BWa2rXc93hUx6oJ5zgCgHlS0fBN2UAUrnOjiIO70VeRWpXHh5WVu7ZzF8up7Nmkd30
X-Gm-Message-State: AOJu0YyTrq87olW/9/sRH6mXJxVzCeUiYlXzcijScEJk8O9ZwkLMgIJO
	dalfKC6bxlZuCTAxmHxtk/T4RISJDqqtx4L7mjFT3OxK7OyCEUOT/2Gz0mZ2kxl6NvHC4WJmZn4
	IEN4RcBIh9c4OvKmOUZ+lj5TVtOcs1zjMeGRYyk1Hw9dy23SQxfMo3d5feQ57bQ==
X-Received: by 2002:a05:6214:2029:b0:6b7:a7ff:7b4a with SMTP id 6a1803df08f44-6bb3cad5a71mr26072346d6.46.1721892572097;
        Thu, 25 Jul 2024 00:29:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwO8oiY53pBHmyd+hR5FHYIgHgSd27hC0p5tTZUSBOIdG0bNK75vJYrjlZQ0rISZGwv8KfpQ==
X-Received: by 2002:a05:6214:2029:b0:6b7:a7ff:7b4a with SMTP id 6a1803df08f44-6bb3cad5a71mr26072246d6.46.1721892571860;
        Thu, 25 Jul 2024 00:29:31 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.147.11])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f8f63e7sm4352566d6.30.2024.07.25.00.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 00:29:31 -0700 (PDT)
Date: Thu, 25 Jul 2024 09:29:26 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"open list:SCHEDULER" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] sched/deadline: fixes and improvements
Message-ID: <ZqH-1o9pc062F-hG@jlelli-thinkpadt14gen4.remote.csb>
References: <20240724142253.27145-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724142253.27145-1-wander@redhat.com>

Hi Wander,

On 24/07/24 11:22, Wander Lairson Costa wrote:
> Hello,
> 
> This patch series addresses specific issues and improvements within
> the scheduler's deadline (DL) class. The patches aim to fix warnings,
> remove redundant checks, and consolidate timer cancellation logic for
> better consistency and code quality.
> 
> Patch 1: Fix warning in migrate_enable for boosted tasks
> 
> Fix a warning caused by unnecessary calls to setup_new_dl_entity for
> boosted tasks during CPU migate_enable calls.
> 
> Patch 2: sched/deadline: Consolidate Timer Cancellation
> 
> Consolidate timer cancellation logic into dedicated functions,
> ensuring consistent behavior and reducing code duplication.
> 
> Changelog
> ---------
> 
> v2:
> * Drop patch to remove the redundant WARN_ON call.
> * Change the "Fixes" tag in the patch 1.
> * Change function names in the patch 2.
> 
> Wander Lairson Costa (2):
>   sched/deadline: Fix warning in migrate_enable for boosted tasks
>   sched/deadline: Consolidate Timer Cancellation
> 
>  kernel/sched/deadline.c | 45 ++++++++++++++++++++++++++---------------
>  1 file changed, 29 insertions(+), 16 deletions(-)

Looks good to me now.

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Thanks!
Juri


