Return-Path: <linux-kernel+bounces-385386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F286A9B368D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7636B1F23256
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4251DEFD7;
	Mon, 28 Oct 2024 16:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkbJr0n/"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0691DED59
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730133207; cv=none; b=SPzLb4QAF1i8kjKzaeIxXfUSox8NxYKQQH1RACfmiHbe9gSH7fde5XFOZALMDBzFgM25c9VR9tz4gqNj6o4Wo9gzV9dSmFYhw9Z4IGBrgQf0OWRsMukM/x1LxFkkgLfzNYwM9D08aHKwKPH4wS09iEtx77jbcj4nYrCuignk6vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730133207; c=relaxed/simple;
	bh=2ZfZjSCAWP9ZXz6uYSpe7KSiByIBqtwjG5huOvmkf6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=go2afWS6e8lr+ysEzDdc+3pTvySCrhZSH7YSKlxMoypWY28JuIO4gaya/JKa8F2xrFKxFjLAtgRSrpg485CWjRWefeSsF6Z9CaFabJowNGMQ8Z876UjzgLgIiB+zrvFK1bgj382MPcknoKfhEXTV8BZXYzhEePUY+LPZpDGHaN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkbJr0n/; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6cbe3ea8e3fso31491626d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 09:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730133204; x=1730738004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ZfZjSCAWP9ZXz6uYSpe7KSiByIBqtwjG5huOvmkf6o=;
        b=YkbJr0n/rHa6U29U9ibZz5YTJRV/K7OPrd/YY6n4VZXh+fLoIM02vffzNlHqq89NGz
         xWOTfFHF1kNxR/1k1WkOhy5StiuqayiLi/GW+ZGsR4IteCYsIsSt4ZHprFcDvWxNq8u6
         aFpp+/hzqGF5TqENkp5QFiXrAOr0I2RGtrSq1cAfqp1q3MPss8QlUoPq/Q0ji1J6+uCA
         22o7NRulDvx7Co5bxlHZDcIWFgaX35P5nLgw8qaN8kKVudplEsbKx5w2xKCTt0yqAPEL
         XKz1KeFwu7XpDOI4Ymr66U1wp3df8n12iO+DueuJjybnDbu8SA/D9iPcDPmPOkAQ0p4P
         58RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730133204; x=1730738004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ZfZjSCAWP9ZXz6uYSpe7KSiByIBqtwjG5huOvmkf6o=;
        b=vLQgZvvTTK2YuKARVr7wrV0iO9ehRMEqJ0HaK76r/z8lfNTMi7b3he4/PWaEtWzUE2
         dzhLdEI5C3obqu6/ZpFxwp+V5aHKTUgpIRO0p+72AWU2oC1QQX4w5lmsfic02f5BdHwn
         RNhEYevNc14iECAvO67jBzEM4OpmUa4MBh9MLrFyLjBJ1f5qMBqdJDXn/Uow5aHsEyWf
         q/HRw2I3613+2o5iuEUnWgaZFpw9X/y+ohhkOllW1fthyKtbF607un2o6oTfRyigmvb2
         5X/HKxojesN5KXro/sgRbtj5eaFsTLjSE9M4kLGdpGL+M4m5kBgi7+OdrE5EcvcZbsXv
         PgxA==
X-Forwarded-Encrypted: i=1; AJvYcCXGVdosz9V4hY9fdCYeR9fPvhqZpSnHGspTY3n+mCN32apyd8D7Inp7x4VDLrUUFtmLdBmrcrl8Vrdq9Tw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiDB4Zv3FiUGlevgLavUuSDAyguelSwKAH1kO0x5fVZ3/Bxc06
	7t0jYekcsxMocMhJV75ORhN6LYkdkrjedciccuIkx/Np6B80Cl0TZER/mE6Qa38rj9t/P9jCsfv
	EodWtZtu8lTrhMa1KkTlWapXHSDU=
X-Google-Smtp-Source: AGHT+IE6KuA9hX9cuGFxAg10exsTgpHnLr4uoSkhocTMYWkpFRiyqcAJnXVhz3E01lnR4gxT7YgmQVHssnm/1H0uPks=
X-Received: by 2002:a05:6214:3d86:b0:6cb:c70e:4e9 with SMTP id
 6a1803df08f44-6d185675955mr174266846d6.10.1730133204627; Mon, 28 Oct 2024
 09:33:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241027011959.9226-1-21cnbao@gmail.com> <CAKEwX=NFtcoiqiLa2ov-AR1coYnJE-gXVf32DihJcTYTOJcQdQ@mail.gmail.com>
 <CAGsJ_4yfcfFWpy3hYan6ggntVJmR0i-hH-0TUK_1-7sL9zBgDQ@mail.gmail.com> <678a1e30-4962-48de-b5cb-03a1b4b9db1b@gmail.com>
In-Reply-To: <678a1e30-4962-48de-b5cb-03a1b4b9db1b@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 28 Oct 2024 09:33:11 -0700
Message-ID: <CAKEwX=P2EKkbAgoUJ_RTRwv0DS18HfnEG2gRFmCYyb2R+LsrvA@mail.gmail.com>
Subject: Re: [PATCH RFC] mm: count zeromap read and set for swapout and swapin
To: Usama Arif <usamaarif642@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Yosry Ahmed <yosryahmed@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Andi Kleen <ak@linux.intel.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, "Huang, Ying" <ying.huang@intel.com>, 
	Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>, joshua.hahnjy@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 28, 2024 at 5:23=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
> I wonder if instead of having counters, it might be better to keep track
> of the number of zeropages currently stored in zeromap, similar to how
> zswap_same_filled_pages did it. It will be more complicated then this
> patch, but would give more insight of the current state of the system.
>
> Joshua (in CC) was going to have a look at that.

I don't think one can substitute for the other.

The "current zeromapped page" counter gives you a breakdown of where
memory resides, whereas the in/out counters explain past performance
based on events that have happened. That's why you have zswap,
zswapped, zswpout, zswpin.

