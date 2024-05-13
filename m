Return-Path: <linux-kernel+bounces-177912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC5A8C4623
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EFEA281D69
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E8822612;
	Mon, 13 May 2024 17:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EYHnu708"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9E520DF4
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715621648; cv=none; b=Mlc/prgd2xgPSzp53OV3Lcm8NemGzqaDYsIcf4tHsN+q5od891kReE8S7wBsJrq/gRTNDwW5eXTxcR1QA9nQznJYqCU9pRphe/xSeNyp//E4aF4hyct7v/SrQkUskUbZCIJKrvuHOd4sgQW2c/c2007U+VXWF/KzYzOZ8zdN5G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715621648; c=relaxed/simple;
	bh=LGyj4luFEwyxCJutXStC46wb2QnlMbg8i3ELpfd0ioo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SiOMMssJyD56xClBNdYL987xKnNiuxqOar0Zb/59lah5xsS0TBGNz22mlZPSDh47bNtxg/74bE3r/Ccw+JSgXwMJZAD94O/ds/Z2qTmvvj91d5//UhCjDZbg9Vssfhy8PssEPSZ1/9oTAd/gqx65LPjGWhlZQbZinVj8CNdZVeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EYHnu708; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59a8f0d941so1135522466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 10:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715621644; x=1716226444; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gF7u5KTdydtGb+C4u/lKHMX/r20FiXVK70KMr4rQijg=;
        b=EYHnu708blrHYqiCasfWEmHhSyyDZnDNseVnTvOjYMkmmNWCIVosphzkryeQRqVIf8
         hNYefOiTXVrMZWP7lLqmQmj79gsX85vmKg6vxv9ZipZgj6GJE6/hEsqDgXU0pJ0WEpu6
         ZQF7Ma53iDSG8NX5GHkvpNIhEskuMULhrpGHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715621644; x=1716226444;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gF7u5KTdydtGb+C4u/lKHMX/r20FiXVK70KMr4rQijg=;
        b=fTJ4YtHbUhFVfiWUOyAyiD7LP7C0DCxQO+I3bxu1JPzgK8ES4a2fzMA0iXhuw+hNOu
         mnnKvxKiFgnU38enFXNJIoU28UjuYkvteXiSXwflLzu1dzsiC8tzgFkcF15fqySn9bVu
         W2e0YFeKJ+CMBgSEkAtAg4UbLCB7/YAevhRJDrZvOrGHWnQvwH38rcZ9oaLpEHAHjgmC
         B/SScduW8aWdGyB1r0+l81EDCfMESQ5W6fWBXBhZf76AzVUE53uCrj68/5P69E7n8PmQ
         1lq4QJMwrTMcuyYqkdQmFDNN99vWZgcwpn1WvOjHLhZx4fRGEf+UoRpEjdioqMuslB5y
         P0pg==
X-Forwarded-Encrypted: i=1; AJvYcCWN3NnUW9+30o4jw5hDORBqqBL3gwJP94Q9oa4J8Shm4hAN5qEBj9FPSvoi/mkOI84kxPaR/4zx8hOlMfyQw092+jL2RsZKI3Pi0fLx
X-Gm-Message-State: AOJu0YzShoc9CpfjkTpLj4x+AtbIrSEKCZh4M8Gz2koqbGRvCBnkTCur
	8LVkNcRAx0BJFD1Vl2pCrhZOiFBmK7md/N70bP8l6JrxRKUboMccYR1nXNHh3GB2DoNORQ+aWww
	mrYn+pw==
X-Google-Smtp-Source: AGHT+IEw7N4kPiEMJOK0Yxp2x8PX+faIakoxUtUgYAbqB7khyrYqve9B/8vBFqUCkRYBixvMMQ9jBA==
X-Received: by 2002:a17:906:22cc:b0:a59:c319:f1e3 with SMTP id a640c23a62f3a-a5a2d53ae7emr678818866b.12.1715621644509;
        Mon, 13 May 2024 10:34:04 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1792228csm622585566b.92.2024.05.13.10.34.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 10:34:04 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59a8f0d941so1135511166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 10:34:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW9PCvhhM/7o1szigHyuCo9ifNM9kwsSeoZcgL6c/nSz0/aIWfm6LkAvuJ+HUZ5a0vJLLLQPyk3oFBC3zeGZN/Gd+9HH/Nj+yXh4/xy
X-Received: by 2002:a17:906:2298:b0:a5a:3579:b908 with SMTP id
 a640c23a62f3a-a5a3579bb63mr599168266b.38.1715621643624; Mon, 13 May 2024
 10:34:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <587f5e6b-d543-4028-85c8-93cc8f581d02@suse.cz>
In-Reply-To: <587f5e6b-d543-4028-85c8-93cc8f581d02@suse.cz>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 13 May 2024 10:33:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZpyWvC-nh4CPhKkPLMwWb_W00NDMopuxVNTnGB7fYeg@mail.gmail.com>
Message-ID: <CAHk-=wiZpyWvC-nh4CPhKkPLMwWb_W00NDMopuxVNTnGB7fYeg@mail.gmail.com>
Subject: Re: [GIT PULL] slab updates for 6.10
To: Vlastimil Babka <vbabka@suse.cz>
Cc: David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev, 
	Roman Gushchin <roman.gushchin@linux.dev>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 May 2024 at 07:25, Vlastimil Babka <vbabka@suse.cz> wrote:
>
>   To avoid affecting fast paths with another shared counter (attempted in the
>   past) or complex partial list traversal schemes that allow rescheduling, the
>   chosen solution resorts to approximation - when the partial list is over
>   10000 slabs long, we will only traverse first 5000 slabs from head and tail
>   each and use the average of those to estimate the whole list. Both head and
>   tail are used as the slabs near head to tend to have more free objects than
>   the slabs towards the tail.

I suspect you could have cut this down by an order of magnitude, and
made the limit be just 1k slabs rather than 10k slabs. Or even
_another_ order of magnitude smaller.

Somebody was being a bit too worried about approximations, methinks -
but I think the real worry goes the other way, where it's practically
so hard to even hit the approximation situation that it gets no
testing at all.

IOW, I suspect it's better to be explicit about approximations, and
have people aware of it, rather than be overly cautious and have it be
a special case that almost never triggers in any normal loads.

But pulled.

              Linus

