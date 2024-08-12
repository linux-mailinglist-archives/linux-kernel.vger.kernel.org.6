Return-Path: <linux-kernel+bounces-282802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7CE94E8CC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA9681C215FA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D66A16BE2A;
	Mon, 12 Aug 2024 08:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jP9cw5gt"
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC103165F07
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 08:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723452260; cv=none; b=J3f1zKaqTgJgBf7KFlloxp/f2dLuA9MutlWKTOlFoEKVbxnuq7tctbUCtt1KAjDv2+h6e1vZQ1F/riOutSmodT90MzjYORrUhenFGbGFQpB4iAnOJn9cvLMe6lWBAVgyBG+IkX+TgeJOLUoMNNYw4I4imnxLD+xXwoRVDXkzcTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723452260; c=relaxed/simple;
	bh=+MDz533arRQ4FiZnuLqG6SznrLjh6n5EpX/WXYQ9n6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a1JGP5BzBy0UwC7n2laoXYucqpSth3WZp8kJ9mFeIkxMJpkZeCcvSpYoilY12i4Fjot1rh8LK9PDEBXOXgmh7oh3LTQVbDeFXxVxynJd1q9eDqe1mt/2jXkjudtzvHG63NdGuu472SxhuoBx1iAk9a9E7+698q28RrJCrAW8Wak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jP9cw5gt; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-49296011b52so2784575137.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 01:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723452258; x=1724057058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knkrczQAhRb/IxHIPRJ3R7wY+Q/UorYUp4t6C9yZVAw=;
        b=jP9cw5gteyclEku5xRAI2jf92gLurcGFbIPAPsvd1NIGaPWwlbB7qFlt68ERANLnt5
         lGE67OV2ql8DXtoFWgIBMBIvNnDiPuhZWQftcoyJR0QDMcbVSnv+EXJPP+ph247zwrd9
         QfOnq9xTGgpSpKQ1guVbz2z2dO3VhbV4xxL+c8oJtD/aOEn/dXXyjz//xb2z8C7lWxqK
         iUZJWbYkmp4TrnvLBpFhov2Pk41scVqRrE5E5A8rTFVZVx2c9rjCiwvAiXyld0l4pI6q
         /m+yI9rMcKuFVkjpOFZQu0C8gx5eXyLLb/1gIjUW49iabMWQc39cP2kfHXmKuX77yXkZ
         5iaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723452258; x=1724057058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knkrczQAhRb/IxHIPRJ3R7wY+Q/UorYUp4t6C9yZVAw=;
        b=bOTEWQM5fjpzMVov/AtTRnUz316p1AzrURthXH/z8LauPhVU2Qhy9Y/Ge9b5bqYXv7
         e5zC2ZUmG7NDjUmA+SLYMZ3f9GHyfoZRu3/XALIS1CVW4W4jXhs8HlxwQds7ay27xi14
         o6bgGMty0711WmVJU06bMzCebvXziP6p+D49g7xOVpYI7BSfRV16c4BfRQOY+v8UDRNg
         tE+xjHSwcE0deEHsTKHTEif9QgRXA80oW0klk8xfk5ZpHHbUw1MCwpHH2J6gSRpCvxRs
         8YmPuw4b5JDSBsYLMUmYqibgT2qAGn2G8YsnIN338NQYh3bwM6pAxZrZuXYQnue0Ek21
         h+yg==
X-Forwarded-Encrypted: i=1; AJvYcCXgie2QgUf085NtOBaPCqsmW12R/3Ondi0k51xDjqn7bER93rp0+OVlN4GqKYr3m08XjXiO5K1BJY5ey4gUkH4YbW/GPvyq5CuJbSIW
X-Gm-Message-State: AOJu0YydQ5kHmA6jGoH7fPwrBk75hFKnnQDxr1EBY+wJx1uylXsQ56Tx
	XkZrDJWyLCf8SkqzBBukoYnJOX8QmFo3RT9VWARiPuYBVpBEiRtlGHiAQGrlSbPjiYDjeZWp/2v
	/R9BoZWhBF5q78hp62e1GK2Ss7Dg=
X-Google-Smtp-Source: AGHT+IHXcVJWsufgQu/YERKLpcZQ8yoTBJ6yZbXDYsNP2YUkdxsIKSp42+5n4mDwyD6UycltXNv3bjxEmMiv8pGCbxA=
X-Received: by 2002:a05:6102:32cc:b0:493:d940:2ab8 with SMTP id
 ada2fe7eead31-495d8e30a9emr4424042137.14.1723452257309; Mon, 12 Aug 2024
 01:44:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726094618.401593-1-21cnbao@gmail.com> <20240726094618.401593-5-21cnbao@gmail.com>
 <ZqcR_oZmVpi2TrHO@casper.infradead.org> <Zqe_Nab-Df1CN7iW@infradead.org>
 <CAGsJ_4wfWYGZVouK4JTj9DBDNPKTX_zrfU45iivaUy-Nq-P1bA@mail.gmail.com>
 <ZqkVMpbl5pH35uOq@infradead.org> <CACePvbV9DZJcYL17MyYrEjRehqfj1LQtj3TwrKuP913NAP4sZA@mail.gmail.com>
 <ZrnHerW7VV0YKZh1@infradead.org>
In-Reply-To: <ZrnHerW7VV0YKZh1@infradead.org>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 12 Aug 2024 20:44:06 +1200
Message-ID: <CAGsJ_4wr618sSA1dytqTXkpW-X8ujGhDUvsW5Xs=2uivhKB9cg@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] mm: Introduce per-thpsize swapin control policy
To: Christoph Hellwig <hch@infradead.org>
Cc: Chris Li <chrisl@kernel.org>, Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, ying.huang@intel.com, baolin.wang@linux.alibaba.com, 
	david@redhat.com, hannes@cmpxchg.org, hughd@google.com, 
	kaleshsingh@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org, 
	mhocko@suse.com, minchan@kernel.org, nphamcs@gmail.com, ryan.roberts@arm.com, 
	senozhatsky@chromium.org, shakeel.butt@linux.dev, shy828301@gmail.com, 
	surenb@google.com, v-songbaohua@oppo.com, xiang@kernel.org, 
	yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 8:27=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Thu, Aug 01, 2024 at 01:55:51PM -0700, Chris Li wrote:
> > Currently Android uses zram and it needs to be the Android team's
> > decision to move from zram to something else. I don't see that
> > happening any time soon. There are practical limitations.
>
> No one can tell anyone to stop using things.  But we can stop adding
> new hacks for this, and especially user facing controls.

Well, this user-facing control has absolutely nothing to do with zram-relat=
ed
hacks.  It's meant to address a general issue, mainly concerning slow-speed
swap devices like SSDs, as suggested in Ying's comment on v4.

Thanks
Barry

