Return-Path: <linux-kernel+bounces-574531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8838BA6E677
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 687C716C70A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DE21EEA34;
	Mon, 24 Mar 2025 22:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jUG+VDmU"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7376319066D
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 22:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742854551; cv=none; b=sVeMLdIwI1P6Fwa5wzebSlpphd1wjO8lX004Pq5LOqvsEfSvm+0k5jJg9DAJ8g14sFFrWwSWDHRkxsG7b0ohLEzRC8xptuZzuYamIgNGzuQvqZoDuPs79pgcyrhjRqKqLU07+m3YBDtR8vLWMvCGGhaMjOGKURjZhuUh4SMXztA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742854551; c=relaxed/simple;
	bh=e/r4Zlp/KHSwdvwEkIA042d1FAjKutPhBALAVYylnJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XKMO2WWYWCMkqzjsaOIowtoNGtGYykynjaWX5C/LfIqxBEvI7OuqmaHHh00aARH7bgpUewVfd8tl/9Xpyy0IH279kNeaq1X9n6lNHnEI+1YoWwI6pnR1HNVkXfpl1HdhbPoIxxZL7Ons4MvQVyQ4az73sgKJCcdQNNSlxKSTu5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jUG+VDmU; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e8fd49b85eso78175426d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 15:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742854547; x=1743459347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LqCK4xrieYy8rHSMdxk0HMnzbYnnEsVe7CVfVt5N210=;
        b=jUG+VDmUNoV0CH8XZxglb+ZpiOmq6NTrnjn+9mGZk00XjGehUgWMMLN+rYUWvYx6NP
         l1kPyDiDtgYgjAW4sUcyJ3caT0rHiDGn8RnmDz1dUvUqqP5ju7kFmVHCstGnWI3FmmKT
         NMFuXGPjwDhRL6/+YQ4cMEQkFghCjC9vpI1kY7omXtgKRck8SuW52gdq/wydMlsyJBJs
         6LM6SMGIXqKJjJGCosKlBwNNTBHM9fSw91zKT0V6Rl+wpnTzal9Cz0xfpB+T7RLG76+Q
         Q5bUxTO1kDqkIuXYubFDC8b20zipg2RXfzctIMfshfQJ9bPxJKdKfm5tAw/UsykCwE3I
         2Ikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742854547; x=1743459347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LqCK4xrieYy8rHSMdxk0HMnzbYnnEsVe7CVfVt5N210=;
        b=Shp+DZcTe2jvvFkJy15mML+ogI022m0bUfK0xRjq1pIXU/vC+MlrHtXaaSf7/Ve/px
         WIwfo1GV169TF+e9+xCjTnha5z8fJ6/aLnna2CGUaq3XhauxupYTKpYjeDRMEcDXf9m6
         Yyl225ULGlOuLKfgq6ZIl3YSEgktZuuwYP8sTqlq5ivLlbCxVsVLSZ4+pkLfZwN0EaQs
         oCnw8DjR8sFiFmlXRShwJ+zrjBlOd0XY7OsU2tn157nwJP+0N022RiqP1o0ocQQ10q3J
         FBqsjYvSme9jbNUQDpYnlImpwDin4rCJ2Gy6MyP6tSipGrFINUCkUh6EzccAFeYKXR+G
         83fw==
X-Forwarded-Encrypted: i=1; AJvYcCXVJUPAJZegUZ0AAB1fulQb1VxtCGf37Eby92K0pzjF9jWR8S7fakEqnaIJLDwMpLSu8ARRcvw8a2b/16c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVs37cjcqu4CzErn/zxZG+YxMwz4PCwKLZb0Sqh66i5yifkwZ8
	fa/0BqMegn9h5qBh5xQ4097ePaFtiBhBxiOj5rGOXpP8nYQTW8yOW/BBnodd3JA=
X-Gm-Gg: ASbGncuICFhl7qzCZQhuY+XsIkLKrpLIAmueNbRoUH8NGaa08nlCKaQGELE5y3VvjkW
	D6wmMvi1TrD83lur2fc8qX33LynXknUrFRI05oplBnSu9nM4TMDaoRzCquybwSHiwe6MrnWPdMV
	clbObmGHhUyWocVS5voAIG1bQsZ1kQw/X1fIxr+x4bJqg64LNXWvVUQuRxjqUtzRqqVmBCJk3aj
	DIUUCihBcXjT5M4zgbFuNB9nWzE7fmVmphGMVK0B3jiz6K4VddlXFsb8c/C2fleKES3OydHer7e
	vl0w7004rWG7ZgVZGel6EmdO3wAd8H4twwVRFXkthUJPDAWToQ==
X-Google-Smtp-Source: AGHT+IEQMqkj+FtpcZxgGtU488+dXoq+VgOKiN+59B24M1O2EfiLKvd38B84Qx7Els7TCQbDEjBbUQ==
X-Received: by 2002:a05:6214:f65:b0:6ea:face:e33f with SMTP id 6a1803df08f44-6eb3f2bad2emr231217546d6.3.1742854547178;
        Mon, 24 Mar 2025 15:15:47 -0700 (PDT)
Received: from [172.20.6.96] ([99.209.85.25])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eb3ef1f51esm49592736d6.26.2025.03.24.15.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Mar 2025 15:15:46 -0700 (PDT)
Message-ID: <fc0f1f19-f7e6-45d8-abff-a98305ce5bb7@kernel.dk>
Date: Mon, 24 Mar 2025 16:15:45 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH vfs/for-next 1/3] pipe: Move pipe wakeup helpers out of
 splice
To: Joe Damato <jdamato@fastly.com>, linux-fsdevel@vger.kernel.org
Cc: netdev@vger.kernel.org, brauner@kernel.org, asml.silence@gmail.com,
 hch@infradead.org, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, open list <linux-kernel@vger.kernel.org>
References: <20250322203558.206411-1-jdamato@fastly.com>
 <20250322203558.206411-2-jdamato@fastly.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250322203558.206411-2-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/22/25 2:35 PM, Joe Damato wrote:
> Splice code has helpers to wakeup pipe readers and writers. Move these
> helpers out of splice, rename them from "wakeup_pipe_*" to
> "pipe_wakeup_*" and update call sites in splice.

This looks good to me, as it's moving the code to where it belongs.
One minor note:

> +void pipe_wakeup_readers(struct pipe_inode_info *pipe)
> +{
> +	smp_mb();
> +	if (waitqueue_active(&pipe->rd_wait))
> +		wake_up_interruptible(&pipe->rd_wait);
> +	kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
> +}
> +
> +void pipe_wakeup_writers(struct pipe_inode_info *pipe)
> +{
> +	smp_mb();
> +	if (waitqueue_active(&pipe->wr_wait))
> +		wake_up_interruptible(&pipe->wr_wait);
> +	kill_fasync(&pipe->fasync_writers, SIGIO, POLL_OUT);
> +}

Both of these really should use wq_has_sleeper() - not related to your
change, as it makes more sense to keep the code while moving it. But
just spotted it while looking at it, just a note for the future... In
any case:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

