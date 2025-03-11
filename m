Return-Path: <linux-kernel+bounces-555551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDFC1A5B96D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 07:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 104C816F925
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 06:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AFB1F4C96;
	Tue, 11 Mar 2025 06:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MWJGHhqY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02137156861
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 06:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741676085; cv=none; b=tjb1QyVG1YsSYneGEN4bcONh5DPgsik1nqwcqFrLjLadKlgujebvqnafNcmTlvHXnn32R58yBt94r3JFyiHfGfdNKAotG5UFGz2mr9p6I87r5ATlpsG0BN1y3NqeQPNKgbzygvbFSipfirC7lNSpfmdIhML3E9sCqiAE0VR3WmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741676085; c=relaxed/simple;
	bh=FSA66bKPNX+XgXRo0gTI4zWgQeT5+dIePxUTy4/Yf0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLGnRyBpK2vh0fmmUdRrg2T95C75OTOfkgKUPzs1Il3175zGCd8I3aotHPJ2bYOvsx1KU3C6WrH9XqvvAAOYfXfSgVgSIHfOoIVUB+Zl6bfdWifYZ3yCObSKthBz+l7FJ9p+DLN7GNyMRr8CwSJqEbH4f0FZVT5ReCzbXg5idmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MWJGHhqY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741676082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AjjBQ2K7stYkPu6dGjLjUXi7OpwSMLHIFMkRJ+GLa2w=;
	b=MWJGHhqYSZ9v5qeZ9N/4MR6GppR5VKi3XJ8G3O9KQszG85d6m7hCAJcZpuFhazGHXOPtWN
	JYUL0ABp6wXUUFQ4xQd6OKuWsHtYSCPy8dksu5FL647Ts+EyJXa3RrF62PzJXr8MPYzt4f
	bMgRKUqcXe/ew/T97mwjPfSJXtzn+pg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-p7eRvFPTNEysHss11VhTQw-1; Tue,
 11 Mar 2025 02:54:39 -0400
X-MC-Unique: p7eRvFPTNEysHss11VhTQw-1
X-Mimecast-MFC-AGG-ID: p7eRvFPTNEysHss11VhTQw_1741676078
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E78DC18004A9;
	Tue, 11 Mar 2025 06:54:37 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.22.90.58])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0CEF51801752;
	Tue, 11 Mar 2025 06:54:34 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 11 Mar 2025 07:54:06 +0100 (CET)
Date: Tue, 11 Mar 2025 07:54:02 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Hillf Danton <hdanton@sina.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
Message-ID: <20250311065401.GD26382@redhat.com>
References: <20250304233501.3019-1-hdanton@sina.com>
 <20250305045617.3038-1-hdanton@sina.com>
 <20250305224648.3058-1-hdanton@sina.com>
 <20250307060827.3083-1-hdanton@sina.com>
 <20250307104654.3100-1-hdanton@sina.com>
 <20250307112920.GB5963@redhat.com>
 <20250307235645.3117-1-hdanton@sina.com>
 <20250310104910.3232-1-hdanton@sina.com>
 <20250310113726.3266-1-hdanton@sina.com>
 <20250310233350.3301-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310233350.3301-1-hdanton@sina.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 03/11, Hillf Danton wrote:
>
> On Mon, 10 Mar 2025 13:43:42 +0100 Oleg Nesterov
> >
> > Hmm. I don't understand you, again.
> >
> > OK, once some writer writes at least one byte (this will make the
> > pipe_empty() condition false) and wakes this reader up.
> >
> > If you meant something else, say, if you referred to you previous
> > scenario, please clarify your question.
> >
> The step-03 in my scenario [1] shows a reader sleeps at line-370 after
> making the pipe empty, so after your change that cuts the chance for
> waking up writer,

We are circling.

Once again, in this case "wake_writer" can't be true when the reader does
wait_event(rd_wait), this code can be replaced with BUG_ON(wake_writer).
So that change cuts nothing. It simply has no effect in this case.

> who will wake up the sleeping reader? Nobody.
>
> Feel free to check my scenario again.
>
> step-03
> 	task-118766 new reader
> 	makes pipe empty
> 	sleeps
>
> [1] https://lore.kernel.org/lkml/20250307060827.3083-1-hdanton@sina.com/

First of all, task-118766 won't sleep unless it calls read() again.

From https://lore.kernel.org/all/20250307123442.GD5963@redhat.com/

	Note also that pipe_read() won't sleep if it has read even one byte.

but this doesn't really matter.

From https://lore.kernel.org/all/20250307112619.GA5963@redhat.com/

	> step-03
	> 	task-118766 new reader
	> 	makes pipe empty
	> 	sleeps

	but since the pipe was full, this reader should wake up the
	writer task-118768 once it updates the tail the 1st time during
	the read.

	> step-04
	> 	task-118740 reader
	> 	sleeps as pipe is empty

	this is fine.

	> [ Tasks 118740 and 118768 can then indefinitely wait on each other. ]

	118768 should be woken at step 3

Now, when the writer task-118768 does write() it will wake the reader,
task-118740.

Oleg.


