Return-Path: <linux-kernel+bounces-197294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8CE8D68E9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 20:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B9061F254E9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E899817D363;
	Fri, 31 May 2024 18:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHdDJuHc"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A59717D346
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 18:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717179526; cv=none; b=BTzoMePyzlXeohGujQM2jRBewpvDcBtT1h0vhEzRU+IgRAfYp7pqhWH9ldUqwlz+qZMBQi0oGEt0HjfD7VljPJdMUQ13OaTMavUTin75udvs3suc+Bdlwp/PiROCCoeEu0yU63gDpWRGm6XWLy9Nt36E9Vsxcay1Sf7iD0H53uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717179526; c=relaxed/simple;
	bh=lrmleTlHpVoaFd7vm1A8oODnAhLS38a+SRERWUfogRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d20QkFofn1U46iLtTngCQqhUnI9Fukagi12md/6tGbxUD95YurpIR4XSUbeuT5Fq4rvXjeQHUBqAuAItdi4TOC1i3mJM+0NQK359VBEk1mQ7vCn6cQ7nF3KLZ9xmGS4Q+2uZRp9XP4JQEk99WSqF81AQj0DgymN48WSrzczcDws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHdDJuHc; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e95a60dfcdso28612721fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 11:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717179523; x=1717784323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=za1v+8+s5jbY5MfR5OYN0EWZPcoPWUFnJZSnKGdP8/Y=;
        b=nHdDJuHcrpB8Rz2mHFpWByZ6qL92q0E4H41vJzc0jHwtSkweeKco0XGb+ZnNs/weMO
         hqj0S2J4KIG2xVx5DAOUrQEBSH11l1AhZoFxKClnV6VTqX/fRuunqx4kPyMKn2MGLH4W
         1IGkb93d4kqwTJZ9LYv77AH6wEzhk5LXQ0ugDDuL/C5YAqV3XIv9/Y6MHBAkQk5Npchu
         P5uMS/UXqQIRioa6cyL6OY/UDwJGAFYjZQb4u5QFNypyorKc/vNsAWXVG3q+1XzpQtYr
         8OxtUi2b4qtkSQYpd/jhA2Vo+IEN7H2fR8IGhPaWkv9s9b/aI+n4bQ992Uwor5bHJxVr
         9f2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717179523; x=1717784323;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=za1v+8+s5jbY5MfR5OYN0EWZPcoPWUFnJZSnKGdP8/Y=;
        b=JUtKhoEaa24u2ZZZETWx/8U3XCPnBEAM227YXzi3is4TXO+y95B87WelKnQe36jlDF
         2C8+AzwddT9rgp0bFqFLvMGvAwvQR/TmyBnrMZn2qR3bqu1ye5fdPsVlSs6BUxoE5HEU
         WTvvI5lsUMMB+u91kCiqng+RN5ouBllc1RMl2nQiZniCHYq1Xwbj8Oo0cNcuP0Mv/pgj
         b53RCMM60nFMZk2QTos4X04jpXu6PC7maRWM86+n6Z2QWTHOCwie692tQUWnnIdIdxrL
         JdXU5j8xnP7sfodghrWoMr+ZtlhY1O3w8LflMYGiMLIYLAbMHHWQJWTt13WWuOBtZdBb
         ikgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgp+0AUheSUS4XitSPecxwck3QnYvqSEVzM7cTzPxea3SKSnx1KWrwvo/sma6VQvGcho1d2L3uNvqh/NenHGJ8drl2Sw22Ck7D/zm6
X-Gm-Message-State: AOJu0Yxz59CSbIO6DnW54vyilQID14NgSfEeKjY5RYTMVvKOEkCE9tFo
	NuUQ0WbUlXXqK92qBXKI1w3F+aWISvbA24g3dPuPi7hTwvb04l6aEJsq7NuC
X-Google-Smtp-Source: AGHT+IElgPkF3MIk2LjETPhOiV9iqohIKUJI3pe7iNHqhjauokyz4F0DsOsCDTIFa+9sMTATM0m8VA==
X-Received: by 2002:a2e:a583:0:b0:2d9:f68a:d82c with SMTP id 38308e7fff4ca-2ea951e02aemr23245951fa.41.1717179522263;
        Fri, 31 May 2024 11:18:42 -0700 (PDT)
Received: from ?IPV6:2a02:6b6a:b75d:0:64:3301:4710:ec21? ([2a02:6b6a:b75d:0:64:3301:4710:ec21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b8a4f98sm32798995e9.32.2024.05.31.11.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 11:18:41 -0700 (PDT)
Message-ID: <434aacbe-e32d-468f-8135-bd550847c267@gmail.com>
Date: Fri, 31 May 2024 19:18:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: store zero pages to be swapped out in a bitmap
To: Matthew Wilcox <willy@infradead.org>, Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, akpm@linux-foundation.org,
 nphamcs@gmail.com, chengming.zhou@linux.dev, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com,
 Hugh Dickins <hughd@google.com>, Huang Ying <ying.huang@intel.com>
References: <20240530102126.357438-1-usamaarif642@gmail.com>
 <20240530102126.357438-2-usamaarif642@gmail.com>
 <20240530122715.GB1222079@cmpxchg.org>
 <CAJD7tkYcTV_GOZV3qR6uxgFEvYXw1rP-h7WQjDnsdwM=g9cpAw@mail.gmail.com>
 <ZljbwMj-FNw9TqDV@casper.infradead.org>
Content-Language: en-US
From: Usama Arif <usamaarif642@gmail.com>
In-Reply-To: <ZljbwMj-FNw9TqDV@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 30/05/2024 21:04, Matthew Wilcox wrote:
> On Thu, May 30, 2024 at 09:24:20AM -0700, Yosry Ahmed wrote:
>> I am wondering if it's even possible to take this one step further and
>> avoid reclaiming zero-filled pages in the first place. Can we just
>> unmap them and let the first read fault allocate a zero'd page like
>> uninitialized memory, or point them at the zero page and make them
>> read-only, or something? Then we could free them directly without
>> going into the swap code to begin with.
> I was having similar thoughts.  You can see in do_anonymous_page() that
> we simply map the shared zero page when we take a read fault on
> unallocated anon memory.

Thanks Yosry and Matthew. Currently trying to prototype and see how this 
might look. Hopefully should have an update next week.

> So my question is where are all these zero pages coming from in the Meta
> fleet?  Obviously we never try to swap out the shared zero page (it's
> not on any LRU list).  So I see three possibilities:
>
>   - Userspace wrote to it, but it wrote zeroes.  Then we did a memcmp(),
>     discovered it was zeroes and fall into this path.  It would be safe
>     to just discard this page.
>   - We allocated it as part of a THP.  We never wrote to this particular
>     page of the THP, so it's zero-filled.  While it's safe to just
>     discard this page, we might want to write it for better swap-in
>     performance.

Its mostly THP. Alex presented the numbers well in his THP series 
https://lore.kernel.org/lkml/cover.1661461643.git.alexlzhu@fb.com/


>   - Userspace wrote non-zeroes to it, then wrote zeroes to it before
>     abandoning use of this page, and so it eventually got swapped out.
>     Perhaps we could teach userspace to MADV_DONTNEED the page instead?
>
> Has any data been gathered on this?  Maybe there are other sources of
> zeroed pages that I'm missing.  I do remember a presentation at LSFMM
> in 2022 from Google about very sparsely used THPs.

