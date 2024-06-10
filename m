Return-Path: <linux-kernel+bounces-208654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A709027C8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 19:31:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E7B81C21634
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D1D145352;
	Mon, 10 Jun 2024 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="BI53CnhK"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694508F6D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 17:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718040696; cv=none; b=bue782HqJwNulfyzTrZHp+A1bQB28z9cG3R1RkMxC1tjTMhH8VOMaqMXJFVAlWoxhhHgR30/Zw+qw5AJmsr7mp9MEsFj6TCc55Zy88D2gvxSj0uPxwtgwT9m3HRq+XflKbXSfD3Tgog/IU9qyz+9GsAjALYuBsN+9f53pM+A28g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718040696; c=relaxed/simple;
	bh=WZzDraNl6RoPonM/1zyqOF3B7Wjw0fGAsj4wynKG8IY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=p69vOrGJjJA+Ct2sG9blNOoTsvSbg7iu4y+X3slOfpa3fMlHK6eZ9/pN5TAZuhYe9oVcpMY+RkTAxWPFqih5uSwPSRDqoIbPCKhUNTtyVpEfB9CldsMIVs0tKJlQYM7F9QlqJKF6SA5JJqpUPIOi3bgdJza5t0vLBrl7fzWCMmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=BI53CnhK; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1718039226;
	bh=WZzDraNl6RoPonM/1zyqOF3B7Wjw0fGAsj4wynKG8IY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=BI53CnhKy1X1kUJArUEq8in9DDpJ3nNOWM9O9tHoKXrsMORVVameIHPCQEEioNhN7
	 86Fcj8ZWnB/3RUWfkPFJzd/hLJ1wJcViftUadbNKio6bz6cMxXmGvpdD5k2fhdpIQ3
	 rPG734duE/Nu8+CM8eNdkucgkq84CgH9fd44IN/Y=
Received: by gentwo.org (Postfix, from userid 1003)
	id B676640B0F; Mon, 10 Jun 2024 10:07:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id B59954022C;
	Mon, 10 Jun 2024 10:07:06 -0700 (PDT)
Date: Mon, 10 Jun 2024 10:07:06 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Chengming Zhou <chengming.zhou@linux.dev>
cc: Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
    Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Vlastimil Babka <vbabka@suse.cz>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Hyeonggon Yoo <42.hyeyoo@gmail.com>, Feng Tang <feng.tang@intel.com>, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
    zhouchengming@bytedance.com
Subject: Re: [PATCH v3 1/3] slab: make check_object() more consistent
In-Reply-To: <20240607-b4-slab-debug-v3-1-bb2a326c4ceb@linux.dev>
Message-ID: <63da08b7-7aa3-3fad-55e6-9fc3928a49de@gentwo.org>
References: <20240607-b4-slab-debug-v3-0-bb2a326c4ceb@linux.dev> <20240607-b4-slab-debug-v3-1-bb2a326c4ceb@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Fri, 7 Jun 2024, Chengming Zhou wrote:

> There are two inconsistencies in check_object(), which are alignment
> padding checking and object padding checking. We only print the error
> messages but don't return 0 to tell callers that something is wrong
> and needs to be handled. Please see alloc_debug_processing() and
> free_debug_processing() for details.

If the error is in the padding and the redzones are ok then its likely 
that the objects are ok. So we can actually continue with this slab page 
instead of isolating it.

We isolate it in the case that the redzones have been violated because 
that suggests someone overwrote the end of the object f.e. In that case 
objects may be corrupted. Its best to isolate the slab and hope for the 
best.

If it was just the padding then the assumption is that this may be a 
scribble. So clean it up and continue.

