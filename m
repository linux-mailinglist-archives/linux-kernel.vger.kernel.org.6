Return-Path: <linux-kernel+bounces-337492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E37FB984ABA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 20:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10CB71C21209
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411FD1AC45F;
	Tue, 24 Sep 2024 18:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I7N4cS3I"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76881B85F5
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 18:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727201557; cv=none; b=uzJcmtW9V8azr6tx0ueO5Rx3yrYUma7GLCBbLV8JSmeposmHM6m095lEqh1yv7+q3NPD+YV0H4pkEmoPKYKH0zYqo10bS4k2UbtdLggfDs++t/ksArgYcKhZlNcU4CTbmeeAxl1cAJRSSgKl9PLlI8VfHSLSS1KfFtQuGGMUpTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727201557; c=relaxed/simple;
	bh=oRQWMeRREUmkruQQLCQCbuq5fYdSoiJS4QDlXW4YwzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m84VGc9+LNWn7A0+YyywrQPQZ/OBqLayNtyMYOJAaihpWfMT6Bdo5SFTOtxpKFKFlneKiGaOE0aPkL+NpR54RahiKLNybLzj3sGBeCkfba5zvbBLMs7DUflvxV9ogFAtwPXpcO+lKmD/qdG+zZJTBSG0hDFwNS+UN6cX3+v7OjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I7N4cS3I; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a93a1cda54dso24266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 11:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727201543; x=1727806343; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+qB1t1K4I7ZeMGtdl1ixYAWu/UtPcYu5Rsyq5zbhgsc=;
        b=I7N4cS3IEhj7TVqEnbBAAhcRvestR8SF3SEtV9hYUlmCbI4RCtDvUnJ4Dbfj9fhuDg
         qUANjbqaYje/CxD7eNI77mO6WadqC7v8grmHI3Y0OIOXa9u1+C04UgvwFXpbENVChS0N
         1pzkkV1RwjCcQguRmdh2IBT8g3R87HN/81VlHBlZ2nuhRum/1w2wyRlRSiNNCo7PfhrO
         aDZoopcd/5uVcqEk8VMEoDm8nj7bMT0v71UcqV5EjImpdEhnhkNq21zqDESA9KACs23h
         10a3iBm1kXFs/IjCXb4P7Z9BwA2LCa4RBrpKyIDCmGJkL3YOidMAzGQ0hZ7o2+HmTcso
         l1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727201543; x=1727806343;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+qB1t1K4I7ZeMGtdl1ixYAWu/UtPcYu5Rsyq5zbhgsc=;
        b=o//bm4lNxy70fWqLTAP7rbzd2o3pPtaL3JCEcjWNziaKiwtf4BTk8YYeU3ToAS2Dh1
         rTXMSlzHTNk+R/Mdh4tvi48VIsX/mGpqtH/3Ue/6o1W8IHLEXioemqe8iXb2vDH/ngsE
         mF5i7QX0MxuKGy22hvwSU9Aqk2eUKnSHxLXpg5YedSi5NZCQY7YxTTRZEFlau2adyJrC
         CeStg/AL1ayBNIZRV1CDjbGMX9UGlfUxr/FknHTHwVfO2jqqSYxAgxkanGYurvxCrRsj
         Vp8pPqZvHXzhnieNI0GzWsDN7wYyyY2R+w2xWuxUuP9BWp+BW4uDhJNJz47JvGW7q1xW
         beDw==
X-Forwarded-Encrypted: i=1; AJvYcCWpm82rjwWnesqn+ZOek1COsYaoG98tZJk50aRB4NBikpl5dey3XCjSFBT+rrUN8ZrlewB4TqEfS8V10/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkfCyEPNJ1rYCDiZFeATLqlNmQhIWyAvxIdeFdZsMkcceNmna6
	VnG0BmEJxB95ielAkdDsLAyninTBjdbCFFSjllez9P28DGhgYfJedGdQFCVzuX8GTL3IP+xUl5Z
	AZK1AeUcjmmpipRTKBtkFst4hSUPunQc6Nmnr
X-Google-Smtp-Source: AGHT+IE9Ekz7xYrCGBs7cxBQBO3hTmkiDjymkALmjwUg918MsPF80cAQc1DNmeOrdr7cncncnBc7E8NYe+6tgHkQYHU=
X-Received: by 2002:a17:906:4789:b0:a8a:58c5:78f1 with SMTP id
 a640c23a62f3a-a93a031d511mr16315866b.11.1727201542642; Tue, 24 Sep 2024
 11:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923231142.4155415-1-nphamcs@gmail.com> <4d38c65d-760c-43a5-bb47-8e0235c13a51@linux.alibaba.com>
 <CAJD7tkamKcaqHR5V+4+9ixmFc3dC2NnGcu7YzdXqxqNEe8FqqA@mail.gmail.com>
 <9a110f20-42ad-468b-96c6-683e162452a9@linux.alibaba.com> <CAKEwX=PiOdrR7Ad5XoT8pRZDLB=q6B_fmwQ3ScgWFPNptBuHPw@mail.gmail.com>
 <CAJD7tkZFu3DbovTwyRdQmEG=7nQtmzrjQVgyhE4mNzbCtZxFZA@mail.gmail.com> <CAKEwX=ML4+iW+WkyjezaqipZU=N=DeB561M4XzOqQMD6drk9dA@mail.gmail.com>
In-Reply-To: <CAKEwX=ML4+iW+WkyjezaqipZU=N=DeB561M4XzOqQMD6drk9dA@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 24 Sep 2024 11:11:45 -0700
Message-ID: <CAJD7tkaZwkBbMPaL0mUNyftOUxOgMsAk1KDupZqPq0SO-zeZcg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] remove SWAP_MAP_SHMEM
To: Nhat Pham <nphamcs@gmail.com>, Barry Song <21cnbao@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, akpm@linux-foundation.org, 
	hannes@cmpxchg.org, hughd@google.com, shakeel.butt@linux.dev, 
	ryan.roberts@arm.com, ying.huang@intel.com, chrisl@kernel.org, 
	david@redhat.com, kasong@tencent.com, willy@infradead.org, 
	viro@zeniv.linux.org.uk, baohua@kernel.org, chengming.zhou@linux.dev, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[..]
> > > > > Apparently __swap_duplicate() does not currently handle increasing the
> > > > > swap count for multiple swap entries by 1 (i.e. usage == 1) because it
> > > > > does not handle rolling back count increases when
> > > > > swap_count_continued() fails.
> > > > >
> > > > > I guess this voids my Reviewed-by until we sort this out. Technically
> > > > > swap_count_continued() won't ever be called for shmem because we only
> > > > > ever increment the count by 1, but there is no way to know this in
> > > > > __swap_duplicate() without SWAP_HAS_SHMEM.
> > >
> > > Ah this is my bad. I compiled with CONFIG_THP_SWAP, but forgot to
> > > remove the swapfile check (that's another can of worms, but I need
> > > data before submitting the patch to remove it...)
> > >
> > > One thing we can do is instead of warning here, we can handle it in
> > > the for loop check, where we have access to count - that's the point
> > > of having that for-loop check anyway? :)
> > >
> > > There's a couple of ways to go about it:
> > >
> > > 1. VM_WARN_ON(usage == 1 && nr > 1 && count != 0 );
> >
> > Hmm that should work, although it's a bit complicated tbh.
> >
> > > (or more accurately, (count & ~COUNT_CONTINUED) >= SWAP_MAP_MAX))
> >
> > I think this will make the warning very hard to hit if there's a
> > misuse of __swap_duplicate(). It will only be hit when an entry needs
> > count continuation, which I am not sure is very common. If there's a
> > bug, the warning will potentially catch it too late, if ever.
> >
> > The side effect here is failing to decrement the swap count of some
> > swap entries which will lead to them never being freed, essentially
> > leaking swap capacity slowly over time. I am not sure if there are
> > more detrimental effects.
> >
> > >
> > > 2. Alternatively, instead of warning here, we can simply return
> > > -ENOMEM. Then, at shmem callsite, have a VM_WARN_ON/VM_BUG_ON(), since
> > > this MUST succeed.
> >
> > We still fail to rollback incremented counts though when we return
> > -ENOMEM, right? Maybe I didn't get what you mean.
>
> My understanding now is that there are two for loops. One for loop
> that checks the entry's states, and one for loop that does the actual
> incrementing work (or state modification).
>
> We can check in the first for loop, if it is safe to proceed:
>
> if (!count && !has_cache) {
>     err = -ENOENT;
> } else if (usage == SWAP_HAS_CACHE) {
> if (has_cache)
>     err = -EEXIST;
> } else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX) {
>     err = -EINVAL;
> } else if (usage == 1 && nr > 1 && (count & ~COUNT_CONTINUED) >=
> SWAP_MAP_MAX)) {
>     /* the batched variants currently do not support rollback */
>     err = -ENOMEM;
> }

Hmm yeah I think something like this should work and is arguably
better than just warning, although this needs cleaning up:
- We already know usage != SWAP_HAS_CACHE, so no need to check if usage == 1.
- We already know (count & ~COUNT_CONTINUED) is larger than
SWAP_MAP_MAX, so we should check if it's equal to SWAP_MAP_MAX.
- We should probably just calculate count & ~COUNT_CONTINUED above the
if conditions at this point.

I would also like to hear what Barry thinks since he added this (and I
just realized he is not CC'd).

