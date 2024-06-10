Return-Path: <linux-kernel+bounces-208860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B17A39029F5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 22:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300161F24DB1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A971B481C2;
	Mon, 10 Jun 2024 20:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TW9YPEZd"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8656647F60
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 20:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718051350; cv=none; b=g3cW5Zg0o7EEkPFww/J2tqyuZlJdaPXMkPJ5tXltYeMqERmryN0qNPLUcnJnHyuONp8o6c9sp0oj0sFvBIQbbuv1yeGOf04segO9wUDqZ+jRCuQ9aY5edCGQ4es5TxkHFgF7w/1en8HrZrd6xacr5Wt4NiUvha7Lm+TP/dvF5Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718051350; c=relaxed/simple;
	bh=hPVBKt3/v27lAiUusdtbufboqmF3TMISJapOIar1710=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFKtdHqbE1iuz4rjQAwpLygQfirpiJJiJqRqxmt8SRV5BrK2hq/BOoNnuBEvCQmlNZiN5TKZ+Y1ic84i3jdwJ/FesF/BEaCDX+glcwmXrKQpGBQIBRkONvwyO+l8tTwxh2p5OMU06RIwTHbGQjqnC+39SyGDXbzn2cyraaHgZ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TW9YPEZd; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso3980081a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 13:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718051348; x=1718656148; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ngN09hSH9uH9nb33rm52llYZqWz1e9JgVD3FdkPohek=;
        b=TW9YPEZdNZEIcFnhxAMIcP1cE+8hGZrAROxSd4UtGPSoFX4mDxu5y7PEBstvqjTSju
         ys2P6xkAhabURpwF6FPvrPx8ODGNOY2EM36y+mz552gAMnsp+EjrW3pVfSovd+x+Qtet
         4pN9JFmSpqqwbVsXzus5eSbdYIWFzCe8H6g5CEpE2S2MzYWFM0Q9kXrePRJepT26fCxj
         wnneb0uKnOVrQSY1vWlbyNSCmDAtWPBAoBp3SQ0Om4tMGwv/rQbRYRnW/2vlCuXfRWCU
         LUJmzbmWLo4nbpUa6/RSido/sGsc8ooUQqzKsKFU6/Ep5aweH8mjHBymqTxPyEm86kXK
         sT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718051348; x=1718656148;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ngN09hSH9uH9nb33rm52llYZqWz1e9JgVD3FdkPohek=;
        b=iuJ+5QBIez1F9QJ5i62JnHWQYIV9kgckkAnID8pLoJTqw+U5nY1w8xWytxeQlr0/dL
         k6D1XXlZzKtJJZN+ShHK+ZrOw5bbbQWghqw8olEXClU84ZMbFYb4UiDFCSD4kAt5h0eE
         QMni922h+rUEmJEw1dZ5wwvafgVT70S9+AaDVLjuckjFCtip5r+xEeVmdNJm4dmM5Ym5
         Uul5fj9/sYMg1ICVbFtBYrUkOLlil1qxvEYY6nvmhf37wGPRfi0zZI/9fYGDOYXruDog
         tKPc7z9rp1LU0IDprZg/LUTm+sIZhL+WfAU4lBXckl+E08oYA9xgPGhNJfJG4oDHSjWP
         KgBw==
X-Gm-Message-State: AOJu0YwRHvXwsim3QHcfXL7qHBCbxjnaND+0lb3Ks4J2Jo2fhV/kqVeO
	06IArXoXvHTcZBChFJHA7uvGIM2PGUdSywUE7DaATsYzeGtqj9VMcZ2+aw==
X-Google-Smtp-Source: AGHT+IEt+dwtc5t4rdaU+QCaywZXmLjUKNakP/N01VndkN1DBY2v3sb2DqoiycHR81dF24LFNo+FAQ==
X-Received: by 2002:a17:902:bb85:b0:1f7:17b4:edf8 with SMTP id d9443c01a7336-1f717b4fbbfmr27505195ad.33.1718051347745;
        Mon, 10 Jun 2024 13:29:07 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f72110e4b5sm12092045ad.125.2024.06.10.13.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 13:29:07 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 10 Jun 2024 10:29:06 -1000
From: Tejun Heo <tj@kernel.org>
To: Tim Van Patten <timvp@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, druth@chromium.org,
	Tim Van Patten <timvp@google.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] workqueue: Prevent delayed work UAF kernel panic
Message-ID: <ZmdiEh9ck8Fffy4L@slm.duckdns.org>
References: <20240607104610.1.I6c23f4fdb786f7200f6f1255af57b4e9621bcc66@changeid>
 <ZmM7FovMyez71TcC@slm.duckdns.org>
 <CAMaBtwHrprN1Ev8kJPggggVcVZCxsxMQJ=NBQ2AC_Tr1jqHoCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMaBtwHrprN1Ev8kJPggggVcVZCxsxMQJ=NBQ2AC_Tr1jqHoCw@mail.gmail.com>

Hello,

On Fri, Jun 07, 2024 at 11:33:43AM -0600, Tim Van Patten wrote:
> > Nothing guarantees that they'd stay NULL after wq destruction, right?
> 
> It doesn't appear it's possible to re-use a wq once it's been
> destroyed, so I don't

Hmm... how not? It can be freed and then reallocated for whatever, right?

> think they can be re-initialized once they're NULL (nor the __WQ_DESTROYING
> flag cleared). I could certainly be wrong here though.
> 
> > > Discarding all work once __WQ_DESTROYING has been set (including from
> > > the same workqueue) causes breakage, so we must check the pointers
> > > directly.
> >
> > There's only so much protection we can offer for buggy code and I'd much
> > prefer an approach where the overhead is in the destruction path rather than
> > the queueing path.
> 
> That's a good point about avoiding the overhead I hadn't given enough
> consideration.
> 
> A fix in the destruction path would presumably require draining the work
> in drain_workqueue() or discarding it in destroy_workqueue(). My naive
> interpretation of things would be to discard it, so the work isn't
> executed preemptively, but I don't know what the expectations are for
> delayed work regarding which is better: do it early or don't do it at all.
> As you've pointed out, since this is buggy code to begin with, I don't
> think there's any contract that needs to be adhered to super-closely,
> which is why I'm leaning towards the discard path.

Probably the safest thing to do would be letting destroy_workqueue() skip
destroying if it detects that the workqueue can't be drained correctly.
Obviously, there's no way to protect against queueing after destruction is
complete tho.

> Regardless, it doesn't appear we have a list of those delayed work items
> available today. Adding one should be possible, but that would include
> removing the work in delayed_work_timer_fn() in the normal path, which
> would also add overhead (and likely more than the pointer checks, due to
> searching the list, etc.).
> 
> I think a better approach here would be to update delayed_work_timer_fn()
> to check __WQ_DESTROYING and discard all attempts to queue to a destroyed
> wq. I haven't given this as much testing (I just kicked off a round of
> testing), but it should help reduce the overhead impact.

I don't know. Isn't that really partial? The workqueue struct may have been
freed and reallocated for something else long ago. What does checking a flag
on the struct mean?

If you really want to add protection against delayed queueing, one possible
way is adding per-CPU counters which track the number of work items which
are being delayed and check that from destroy path and error out there.
However, ultimately, there's only so much we can do about use-after-free
bugs. It's C after all.

Thanks.

-- 
tejun

