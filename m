Return-Path: <linux-kernel+bounces-546090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41291A4F635
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 05:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47F8116F77D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 04:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F9B1C84C9;
	Wed,  5 Mar 2025 04:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EZtI/HiW"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6D017B401
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 04:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741150371; cv=none; b=pozHiGhDJt1eGV6wV5VWvoooHBfj8gK3MHUGbOYrsh30HNkPOrlSkWpVt9K0hWQanMY1gutt9ukTWr1W2Oi+47TKAPRP8kAw1uRgzHm+JmKciCOGxdnxauyWtGrf8Z3ejg3ViqsQUQ4ztmtuExjbcRn1khsSAfuDpQ3eYKJXvx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741150371; c=relaxed/simple;
	bh=ZT0l/nMPp2V7swoimX/51KJfcSbvKA/yFOWbk+826KQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tHqnoHhXnLzqPHZ6Jklc+gP0Saf90/Bj9BM9oQkKgDWv1fAOmK1aPKJha9C44aHcV5c8MzOrOU8qHqpbO1ZFMDWJg4BOeyf/0WAicMYhlFRJaWc/blTeSBEZzXLciEHA3J2aF+RMPcFP58eVW6AFFCMS8/3WShnBPpavMDNe8l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EZtI/HiW; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e4cbade42aso815755a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 20:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741150367; x=1741755167; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b/WCWHG9vDVmrx2Uuc4QQNowuOEGiOED3yZs8cjx2qg=;
        b=EZtI/HiWIUf5tLkKBA6Hdu50harzw4XV41FeBRaV1/+ojG9PBmCFMVkEKbmkdK8Cmj
         VmIwgPlJJ2A59Dj6+Pmw7e747WLap5JhPQ3EJ6RaHTwQN38NVyYKNGKEE31qAiguWFW2
         o1kwSUePabWAj3kXWBuQpCLrpYcppnBwwb6C4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741150367; x=1741755167;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b/WCWHG9vDVmrx2Uuc4QQNowuOEGiOED3yZs8cjx2qg=;
        b=IyMZwiePOs/fZpj9qEoeOdBIcdC8d5WrlL+K0FIgAnk0wJrDqt5JkDokhWqoeOPQUJ
         8ARuurMH/UTRVRUpKADFM1OPEYQoRviZMndH3Pq+abIBnNGvqlyhZn3eqO46vxVwi2Yp
         LMfXzWuc8DnAh36CQ2sKgS7POpAMHfj9EeSF1j9Rs730S8ldGNBnQ5yNkKHvmexJydVo
         5Qmd+qUXzB9I2O/Jv8X2Q6SQ0n/AWzbtYa+3pIHcTvP8UjRuR3nBPYIVKAqfwFsMsU/0
         T7s33i1IXRf0cSc6qraLcwY78Iz21LmzvyVu9sEFqAC4peEkC2p/Go5pnmQq2De8ev59
         +WBA==
X-Forwarded-Encrypted: i=1; AJvYcCVCQv3y7fEFbtxflTnFqwRVbNWjdU6xJJdA4sDTidtjk5QZTqo7M7Gvelh7Jo1dRzSSItjCcl1IbtBLp3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPVueyZgFIgkz/JMTELduJaGBK5gCPyYy/TDpIErXIWHVB7KRq
	qg04yYUPOJ3UBjah00cY4ip2yuTeoKL8kqePey3T0B1mzphvV8uzkXbYqp+iPOT0pQZmrBKQ0sF
	u9xUIOw==
X-Gm-Gg: ASbGnctalucJtiicWtYEO0sM/PvobgODeZMMMbE0YmDE7fuiXk9Lu0k9qroPbSfXuHt
	yxnA6KbAZtee+i98h8vMYAtubBp9doqDsqpa+ODA2PXRDSC5rrZL2R+lbUQz4eWStmmNsr/jnKI
	ocrL913oTSQe4eMTXhioZ0guLnI5b/hIi81v1BnByXocAwM8Cp99hLKHWlrSCPU4knnp4GwuR3U
	rX+wTUcs59Zq/Qy1bno8vA+gWm/5dFqjAVEv37Ii26z6xPFpti4tyP9WQ9Xm7vkhVfenihC4tN7
	YaUcMVRRbgXMXivtpsu2iXpip/FU8zz2p6qQh045XEtlGvvont/5kxzlo+rzUIN9SRnpBs3MnP9
	YRpe4o6+olqoIsFpXIy8=
X-Google-Smtp-Source: AGHT+IGO3/vuDDJ4H4f6a6haro6yBAPDQ6iCJ8a7YVYi0Ko+23UCWCW/9hec8hYZz3NTyfDqhqGpGA==
X-Received: by 2002:a05:6402:51c9:b0:5db:68bd:ab78 with SMTP id 4fb4d7f45d1cf-5e59f191b7cmr1596924a12.10.1741150367473;
        Tue, 04 Mar 2025 20:52:47 -0800 (PST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b6d252sm9137735a12.26.2025.03.04.20.52.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 20:52:45 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab771575040so76303066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 20:52:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUUlpIVsB+xnNQhQjXi3PkV+7+WhO2DJv/GBGtSa109h3YxcxUXOXXoI6Mk1jhffkvEODM+K8gkP5Bslzw=@vger.kernel.org
X-Received: by 2002:a17:907:9702:b0:abf:48df:bf07 with SMTP id
 a640c23a62f3a-ac1f105c0fcmr649829666b.15.1741150363877; Tue, 04 Mar 2025
 20:52:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <03a1f4af-47e0-459d-b2bf-9f65536fc2ab@amd.com> <CAGudoHHA7uAVUmBWMy4L50DXb4uhi72iU+nHad=Soy17Xvf8yw@mail.gmail.com>
 <CAGudoHE_M2MUOpqhYXHtGvvWAL4Z7=u36dcs0jh3PxCDwqMf+w@mail.gmail.com>
 <741fe214-d534-4484-9cf3-122aabe6281e@amd.com> <3jnnhipk2at3f7r23qb7fvznqg6dqw4rfrhajc7h6j2nu7twi2@wc3g5sdlfewt>
 <CAHk-=whuLzj37umjCN9CEgOrZkOL=bQPFWA36cpb24Mnm3mgBw@mail.gmail.com>
 <CAGudoHG2PuhHte91BqrnZi0VbhLBfZVsrFYmYDVrmx4gaLUX3A@mail.gmail.com>
 <CAHk-=whVfFhEq=Hw4boXXqpnKxPz96TguTU5OfnKtCXo0hWgVw@mail.gmail.com>
 <20250303202735.GD9870@redhat.com> <CAHk-=wiA-7pdaQm2nV0iv-fihyhWX-=KjZwQTHNKoDqid46F0w@mail.gmail.com>
 <20250304125416.GA26141@redhat.com> <CAHk-=wgvyahW4QemhmD_xD9DVTzkPnhTNid7m2jgwJvjKL+u5g@mail.gmail.com>
 <8fe7d7c2-e63e-4037-8350-9abeeee3a209@amd.com>
In-Reply-To: <8fe7d7c2-e63e-4037-8350-9abeeee3a209@amd.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 4 Mar 2025 18:52:27 -1000
X-Gmail-Original-Message-ID: <CAHk-=whydHy48QDorhGeRLdxdL_1iNt=TJkaJ4rO1xF0WS+iTg@mail.gmail.com>
X-Gm-Features: AQ5f1JqKxqW5NIhKa7sKOCenQyWXH8O4R45njMY_gV-Bb9HHGkSc64y0bI_wRSU
Message-ID: <CAHk-=whydHy48QDorhGeRLdxdL_1iNt=TJkaJ4rO1xF0WS+iTg@mail.gmail.com>
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	"Sapkal, Swapnil" <swapnil.sapkal@amd.com>, Manfred Spraul <manfred@colorfullife.com>, 
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>, 
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, Neeraj.Upadhyay@amd.com, Ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Mar 2025 at 18:41, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>
> >          spin_lock_irq(&pipe->rd_wait.lock);
> >           ...
> >          pipe->tail = ++tail;
> >          ...
> >          spin_unlock_irq(&pipe->rd_wait.lock);
>
>  From my understanding, this is still done with "pipe->mutex" held. Both
> anon_pipe_read() and pipe_resize_ring() will lock "pipe->mutex" first
> and then take the "pipe->rd_wait.lock" when updating "pipe->tail".
> "pipe->head" is always updated with "pipe->mutex" held.

No, see the actual watch_queue code: post_one_notification() in
fs/watch_queue.c.

It's isn't the exact sequence I posted, it looks like

        smp_store_release(&pipe->head, head + 1); /* vs pipe_read() */

instead, and it's pipe->head there vs pipe->tail in pipe_read().

And I do think we end up having exclusion thanks to pipe_update_tail()
taking that spinlock if the pipe is actually a watchqueue thing, so it
might all be ok on alpha too.

So *maybe* we can just make it all be two 16-bit words in a 32-bit
thing, but somebody needs to walk through it all to make sure.

              Linus

