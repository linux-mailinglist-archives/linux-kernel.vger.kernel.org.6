Return-Path: <linux-kernel+bounces-311708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F00A968C8B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 19:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAEE9283A91
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DA61A265D;
	Mon,  2 Sep 2024 17:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiL1AmQY"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC28823A0
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 17:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725296451; cv=none; b=f2WwaccaEg+ng7fYBe4iFw17hrTp2M4skUfaIiX0utn4rpRQ/06AigwYghbYfkiQ47NSGxQiLPEQnp52FHJZlene7gUDeiHShHEEhZXiqqk+BzzjDE3f3sfhKpDQl3m4TN9zd7YEHNXMO+R9rT27d9KphBzpW3MKXNbE4+0QftU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725296451; c=relaxed/simple;
	bh=oSpNDNfOhmT1qqQjvl4S7vUCpctklbjt+iArQs5YIos=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fplW88qPmoORKHdKgllFqpJQMmaDjBylwow+3LBrqjj7nIYPmEAjzgALwbTW2GJnZcNOeattX1NCnHuhCPeNwaQcPC7s0PsEsJyOy9ZydsKG21TZA2QMmEzPUAHgiNpMlS376jTUp+zCz9eExsSu+H/h1oTgvnpRmGbEqG77B6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MiL1AmQY; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f50966c478so46332841fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 10:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725296448; x=1725901248; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J9+V/kbhLj5ujl3zbVoImDUD1XrjW3PQicqV6baThDk=;
        b=MiL1AmQYEzEMA3rIGmSZtLXJ2o+dz1ch8FvNeHYngfoWxBgLMwgfSttsNQTlNrvOoy
         1QSMHtoqzLBOAsCDl5kPfmUb2glj4hIkhhk9RbYXD9rt38d/pAnBlMkNsRNL+nPej76y
         QaA+R+45GExjFClCQZ/bTEkSqaFcDtZgrWbz5bhmnAFTIyBwWyeY6j8HL2dAelOxh/5y
         XktJN7nvCCgoF8qvjlky21irE88srH4NJoRmvGLg/ERDq0maY02QQUNtkucHhuun7i8U
         YiWfydtKp9QBBLzdRlxti00ajU44TsI/EpHIGQ+kE8/MHZdkkDY4fRwOQPHw/FH3K/ba
         XyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725296448; x=1725901248;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J9+V/kbhLj5ujl3zbVoImDUD1XrjW3PQicqV6baThDk=;
        b=ZJ+eaD2jhdnDANovjiDjiIUmEnZKohfi9molRo9vHVOYrO5S+wHaxwdvx5BfbESuzJ
         FJmS83Y2Avk6ZGmK4CdzoeVNbEUIuef/qvAlFZfKieGVzNLtMN1KU1i73yxN3nt2UqaP
         Gc2WHs1qDsJlxtojzo3Wx7CLhVGuquUF8JsSj7LgH0FOh+vep9zuS9/nG3zvYmnxdJeQ
         inMU65cy2P4iv9lf3/joqEeHezKtvrDdDURmrBmW4L2JdXsUHmituH0Dq1JIY3hq6AB6
         hfczc7CubtMUK8yaJ/SvrPGVV4B5BYNBVq2R3rXwbJ+u5MRrnFM5pDXGYGHVmabAejJt
         /xIw==
X-Forwarded-Encrypted: i=1; AJvYcCW50do/wdTcMwxkGfAmpocqg41tpQrwyuDaMOzELV5soyJf51KSRDaJaCyYdZ6gnNtN0JILfFbE9B+/l9s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0R5XHalw6+48xmZ66ICKkDKkRZbVucVmsEcgDt3qO3WXxMH6I
	bEDdcy++moj3Hc2CiUKGyrnOnuOIyEF0ZXyQsXmVs3AAcpRDFzS/
X-Google-Smtp-Source: AGHT+IGrCsmJj7R1rux4b9vaIuGUMo9LKgogBWBVQ6KAtjZhu5ho54eoZE1kk2wngGuHCXxiW9L+og==
X-Received: by 2002:a05:651c:1548:b0:2f3:f193:d2d0 with SMTP id 38308e7fff4ca-2f61e0a5a5cmr73946381fa.33.1725296446821;
        Mon, 02 Sep 2024 10:00:46 -0700 (PDT)
Received: from pc636 (host-90-233-206-146.mobileonline.telia.com. [90.233.206.146])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f615183134sm19368931fa.122.2024.09.02.10.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 10:00:46 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 2 Sep 2024 19:00:44 +0200
To: Adrian Huang <adrianhuang0701@gmail.com>
Cc: urezki@gmail.com, ahuang12@lenovo.com, akpm@linux-foundation.org,
	hch@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] mm: vmalloc: Optimize vmap_lazy_nr arithmetic when
 purging each vmap_area
Message-ID: <ZtXvPAoAo7UooJoV@pc636>
References: <ZtDFQHGHMq6TfbKA@pc636>
 <20240902120046.26478-1-ahuang12@lenovo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240902120046.26478-1-ahuang12@lenovo.com>

On Mon, Sep 02, 2024 at 08:00:46PM +0800, Adrian Huang wrote:
> On Fri, Aug 30, 2024 at 3:00 AM Uladzislau Rezki <urezki@gmail.com> wrote:
> > atomic_long_add_return() might also introduce a high contention. We can
> > optimize by splitting into more light atomics. Can you check it on your
> > 448-cores system?
> 
> Interestingly, the following result shows the latency of
> free_vmap_area_noflush() is just 26 usecs (The worst case is 16ms-32ms).
> 
> /home/git-repo/bcc/tools/funclatency.py -u free_vmap_area_noflush & pid1=$! && sleep 8 && modprobe test_vmalloc nr_threads=$(nproc) run_test_mask=0x7; kill -SIGINT $pid1
> 
>          usecs       : count     distribution
>          0 -> 1      : 18166     |                                        |
>          2 -> 3      : 41929818  |**                                      |
>          4 -> 7      : 181203439 |***********                             |
>          8 -> 15     : 464242836 |*****************************           |
>         16 -> 31     : 620077545 |****************************************|
>         32 -> 63     : 442133041 |****************************            |
>         64 -> 127    : 111432597 |*******                                 |
>        128 -> 255    : 3441649   |                                        |
>        256 -> 511    : 302655    |                                        |
>        512 -> 1023   : 738       |                                        |
>       1024 -> 2047   : 73        |                                        |
>       2048 -> 4095   : 0         |                                        |
>       4096 -> 8191   : 0         |                                        |
>       8192 -> 16383  : 0         |                                        |
>      16384 -> 32767  : 196       |                                        |
> 
>    avg = 26 usecs, total: 49415657269 usecs, count: 1864782753
> 
> 
> free_vmap_area_noflush() just executes the lock prefix one time, so the
> wrost case might be just about a hundred clock cycles.
> 
> The problem of purge_vmap_node() is that some cores are busy on purging
> each vmap_area of the *long* purge_list and executing atomic_long_sub()
> for each vmap_area, while other cores free vmalloc allocations and execute
> atomic_long_add_return() in free_vmap_area_noflush(). The following crash
> log shows the 22 cores are busy on purging vmap_area structs [1]:
> 
>   crash> bt -a | grep "purge_vmap_node+291" | wc -l
>   22
> 
> So, the latency of purge_vmap_node() dramatically increases becase it
> excutes the lock prefix over 600,0000 times. The issue can be easier
> to reproduce if more cores execute purge_vmap_node() simultaneously.
> 
Right. This is clear to me. Under heavy stressing in a tight loop we
invoke atomic_long_sub() per one freed VA. Having 448-cores and one
stress job per-cpu we end up with a high-contention spot when access
to an atomic which requires a cache-line lock.

> 
> 
> Tested the following patch with the light atomics. However, nothing improved 
> (But, the worst case is improved):
> 
>          usecs        : count     distribution
>          0 -> 1       : 7146      |                                        |
>          2 -> 3       : 31734187  |**                                      |
>          4 -> 7       : 161408609 |***********                             |
>          8 -> 15      : 461411377 |*********************************       |
>         16 -> 31      : 557005293 |****************************************|
>         32 -> 63      : 435518485 |*******************************         |
>         64 -> 127     : 175033097 |************                            |
>        128 -> 255     : 42265379  |***                                     |
>        256 -> 511     : 399112    |                                        |
>        512 -> 1023    : 734       |                                        |
>       1024 -> 2047    : 72        |                                        |
> 
> avg = 32 usecs, total: 59952713176 usecs, count: 1864783491
> 
Thank you for checking this! So there is no difference. As for worst
case, it might be an error of measurements. The problem is that we/you
measure the time which includes a context switch because a context which
triggers the free_vmap_area_noflush() function can easily be preempted.

--
Uladzislau Rezki

