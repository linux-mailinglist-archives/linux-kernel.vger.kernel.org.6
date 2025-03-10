Return-Path: <linux-kernel+bounces-553600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDAAA58C44
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 07:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E012C188C021
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 06:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D978C1CAA7D;
	Mon, 10 Mar 2025 06:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzEc50kY"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB09B29406
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 06:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741589450; cv=none; b=lS8lt2By8/7gbIWlS4SmVaKfsLMZmNeX9qyYLEBwizrZuNXsNNoJYSRvHZY+y37t7NiffUJ8F4BLyp1WdKGgAh67Y8fZ/maUcXWthDuxzQLEZnC8opRftFm/BbAxxg1gaZpruy0bQW7ErsmOpSrwRTBFFdBSdNhKPlnObe56saE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741589450; c=relaxed/simple;
	bh=38wSvJfbPMDm5Ih4uCxj9fGsANdJFTtswkCMsEWX/SY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sfoNLdGrOgGL8WUDeDjq/t8j4QLum4XnM50/eJiy0YjE1ILU6NfPQjqQ6A/5NVzaqYVKFoDQ3iq7kTxZOLeBTxgKGPFs+KkQ3IE7wEJKiEEPE8rzgCnHQdKktKaSjW+iJ2GRSJazTy9bRLcElE7ugjRTwhABmO5AP+nD7+hKiHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XzEc50kY; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso787317766b.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 23:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741589447; x=1742194247; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bch64WYOWFJlz+luxvd6kXaBo4L8z7b63LRQYJMGmxc=;
        b=XzEc50kYFCRdNlG7N5e88qtnca96/Hub5RfiEGg4x/6xUlAs/mYe4NJmefBt2yAjyS
         KFjZ+5wcqiBD/6N8eh8LYYTTucbMegOgyhUuB9AR9rDFqzR1oIHkwOIMWxortwDtX1QO
         HBJn/bdiESI/OEdtAvHXifzm3mWCnJ1MxeahgFwpQqwQvPTYPLoXi7Qn//kLwDjTWFtK
         nBB6eIbrKGUooDmSrEBDhYa4SenHftjXFpj508m6DQjkUKr06449G1T561/XEcZgCIDr
         7+cWtlPraum6HKD+mfKu3M+tbvZuP1k5blIUWg/gSZn0PeMxwF8HYTmh7tNE08nyMEtO
         kptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741589447; x=1742194247;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bch64WYOWFJlz+luxvd6kXaBo4L8z7b63LRQYJMGmxc=;
        b=nZBv2UccD5fur22wN/H88x1k6gx7J0rHUwBjtWzK4lcejxiBluBsKRec/O5VkNSYmI
         lLg+KooXNNGsaPauLKj5a3T7dam4vqCM4ewHvtSInV3E9WVddUGI6qj7n5QFw2eBuU4j
         KexfyIxrtW+v0PuYkZRn530Hx6+8vn3x3UKl/CJl/krrX4VvqGsz5xqokjYReuUIzmUq
         3bYcoenIth++AhfvKYd7UglOZ5PfHe0V2Dv0RN+ZD5i9mmHgTUtaS+L5u6KYLJQNzLAc
         yAQRThHQneVA7mIdKrm87adbDMyeMb6Ob3v5Q7O7PfMlxtvaMWSXo3VfM+bbRbXkmjbC
         kFwQ==
X-Gm-Message-State: AOJu0YwcWXw23PG5AzSxQvWuZglyH6ayrHeMLJKmYuJy1DDRuIGIMttS
	rq5pZT89AgSNNy6EoGgJ5jS7ZftYKG76S+OS0R/M5xw7o+y6gx8=
X-Gm-Gg: ASbGncv3XREj/oSFUX6xbVi7rsf27kHyEZEB7VAfo+A8YbOJalzpZVRAN2Rt1debLVq
	XO7uy7NX1cckQSuMbvZPiqAgkQmgFlPKsjvRYgB3qdkkKdtBNl9C3XK7rc0g6JzWapvRoWPsGM9
	WQqMRyM921V4Zh5bXfW35qwn4D83INtkWYechf4BW5DG7lo/pBCf8kHhyQqGGNSMlX/Ra6BXdqB
	uF7U9YFi6moME1V8TTvJr0FC1KGtmHQmb3zDgTlojjfzFIx/4OoyOhmw8CgmO7gi90h8MPckjQo
	isY3UJS4hx7tTYGZvtegxJIMToLyqtYxOg==
X-Google-Smtp-Source: AGHT+IGWUmHBIDJE9Vva5ci1FYgFzRibO91pr+Q9q79uieSvBC25bGiIXXTiApUsISKfYiIulllpaA==
X-Received: by 2002:a17:907:61a2:b0:ac1:e332:b1f5 with SMTP id a640c23a62f3a-ac252e9cd4bmr1127045166b.37.1741589446699;
        Sun, 09 Mar 2025 23:50:46 -0700 (PDT)
Received: from p183 ([178.172.147.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac289a79b33sm262962566b.65.2025.03.09.23.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 23:50:46 -0700 (PDT)
Date: Mon, 10 Mar 2025 09:50:43 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Benjamin Segall <bsegall@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrey Vagin <avagin@openvz.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Cyrill Gorcunov <gorcunov@gmail.com>
Subject: Re: [patch V3 06/18] posix-timers: Remove SLAB_PANIC from kmem cache
Message-ID: <fc20e54b-08b5-49c1-99b9-3cc499edb680@p183>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

> -	posix_timers_cache = kmem_cache_create("posix_timers_cache",
> -					sizeof(struct k_itimer), 0,
> -					SLAB_PANIC | SLAB_ACCOUNT, NULL);
> +	posix_timers_cache = kmem_cache_create("posix_timers_cache", sizeof(struct k_itimer), 0,
> +					       SLAB_ACCOUNT, NULL);

> There is no need to panic when the posix-timer kmem_cache can't be
> created. timer_create() will fail with -ENOMEM and that's it.

Of course there is a reason to panic.

Where did the  memory go, so there is not enough for a tiny
"kmem_cache" instance?

You've taken the branch from __init code which is discarded
and made it a branch which can not be.

More or less every __init allocation should panic not the other way
around.

