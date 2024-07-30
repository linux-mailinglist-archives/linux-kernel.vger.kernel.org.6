Return-Path: <linux-kernel+bounces-268119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCEB942099
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3147B241B5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 19:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DA418C916;
	Tue, 30 Jul 2024 19:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TP8bFrAD"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615A61AA3C5
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 19:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722367736; cv=none; b=T6ji3sXYz31stycP5heJ6X/QXgpJb2IyOq6bBROEiKOd016JIfyaiZNP0S54+M7kMWYTNVt17JvT5mxLsUMeRgmGbrAwzuNTyu4pttObzsVPWBHo0zubgVALKgNh9cNwYuYwDZKv0T2ccNj9RV3ry9QOsajH9BsT6PjbzOqeP10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722367736; c=relaxed/simple;
	bh=CufrURPsE5gwxAL+6WgAlp2lSMGDxdqu9yXy0QuY55A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gBjldx2JZ8tqekeCjGdIu62HXm1itPzlgqDgEhiYJskIjmS3hOuGuxySPXW5mmwaIS68bIc0fbdaFuZFOxa8T4Vly0DQp7TOt9PQEXCxp3N7vD6HO7UYhiL6d2D2PFZ0IwObODZLVo1lCLBSPAg5cMwTPaGyWEoy5sNuosR4A30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TP8bFrAD; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6b7acf213a3so26030276d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722367734; x=1722972534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xS6ru8ScdFhbZFzDx0X4t57s58hjeLhWtmO1pRP7Ink=;
        b=TP8bFrADhbmjyJHnR1nFOa5235FDFLBcTCzSN66vfiZW/7wcoOvNlpr/2bSaiHbjvo
         3rNQvRRVPdNC8664UVgmL6As64nPS+qv197MuK+EkJEqchjguiII106co3ugLjfOUfgB
         rD1LEADJh/5c0oIOsRWOp2pGCrduRbUBG80Z31WKNuVhBfHzl4jdF9R4UmmCuY3Gn97+
         JODeBp/6qiUYH7ymDPvB9m8WyT9sS3Y+RFnDnhWutnfMW0hG6V1+r9mRJIGeZsRaVo6e
         6jWXSGmPnV+XNBB0QF/u1/0mpjTJAT0NedliQuUIkKQY3EtHgcC3U1LSKpA0cVRouz7+
         TyEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722367734; x=1722972534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xS6ru8ScdFhbZFzDx0X4t57s58hjeLhWtmO1pRP7Ink=;
        b=Az/RdqWBGioC+gnmYU2fk37sDuWE5MQGzRBy+XuR6nJfXDvXc5k2cmgcXfDciX8WR5
         Oak3f83QWzYbDU9rrAGAHOs4YR6fMjml7KrA3fS+Pl6E9UoBY+T/f9bI2jdYYC6GbZ6Y
         R/DPMPDfsivkU5tW7Qn6yPyE+y2ErRApOzp/KklQbCskXc9AUAczFg6wGe4j5ULbkaZz
         GSeRfO1R28cpX5rE45HMoi6dxigdMFxxFGZFFcfWJiy2RNvEP6PJ6MAEORmBg/VTr4Gw
         olLF0coYc7krLQQYxT50D3+SvuDzb/XDo6YUK262WdnZNsYZp3GHQq+3MY3u2B3/uo0E
         MiWw==
X-Forwarded-Encrypted: i=1; AJvYcCU6TEoIBZatU9DTfWNpNW65fXIPAmlR04R5+eCACJWfLb8bTPc8U22q1YwiU1B0TeRsdc89gNswDczmPR7sQZnLGT04LRwh1EO35g6Z
X-Gm-Message-State: AOJu0YwHTCHdKDpyfh17PBNp1CrzyaTePsAIP04ZmALzJfiDVQunNgoD
	D6FBlW/xuh8Upk3wJU/7A9MatQ+IJSRNKgQYICaPUnC3TLjHojJDvVH6425DeIhif+dkzg2xvk6
	mM6Z2/rPNkzqjZLRW+owJl3ghyME=
X-Google-Smtp-Source: AGHT+IHvdzR9AozSVVcmiQnk5x4y4P+7Mq0S4lIBOMzALU/1+3glPBlEGWPSbsgc0/4CHv5UItAyXrL2cDBjy2tXP/k=
X-Received: by 2002:a05:6214:21a5:b0:6b5:4a2:79a2 with SMTP id
 6a1803df08f44-6bb55a7682emr141211566d6.28.1722367734192; Tue, 30 Jul 2024
 12:28:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726094618.401593-1-21cnbao@gmail.com> <20240726094618.401593-5-21cnbao@gmail.com>
 <ZqcR_oZmVpi2TrHO@casper.infradead.org> <Zqe_Nab-Df1CN7iW@infradead.org>
 <CAGsJ_4wfWYGZVouK4JTj9DBDNPKTX_zrfU45iivaUy-Nq-P1bA@mail.gmail.com> <ZqkVMpbl5pH35uOq@infradead.org>
In-Reply-To: <ZqkVMpbl5pH35uOq@infradead.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 30 Jul 2024 12:28:43 -0700
Message-ID: <CAKEwX=PETirC4P3CXW1uvoHW4H-ozEYpXUGCoi-LnN=jAzMKLQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] mm: Introduce per-thpsize swapin control policy
To: Christoph Hellwig <hch@infradead.org>
Cc: Barry Song <21cnbao@gmail.com>, Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, ying.huang@intel.com, baolin.wang@linux.alibaba.com, 
	chrisl@kernel.org, david@redhat.com, hannes@cmpxchg.org, hughd@google.com, 
	kaleshsingh@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org, 
	mhocko@suse.com, minchan@kernel.org, ryan.roberts@arm.com, 
	senozhatsky@chromium.org, shakeel.butt@linux.dev, shy828301@gmail.com, 
	surenb@google.com, v-songbaohua@oppo.com, xiang@kernel.org, 
	yosryahmed@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 9:30=E2=80=AFAM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
>
> Well, that is the point.  zram is a horrible hack that abuses a block
> device to implement a feature missing the VM layer.  Right now people
> have a reason for it because zswap requires a "real" backing device
> and that's fine for them and for now.  But instead of building VM

I completely agree with this assessment.

> infrastructure around these kinds of hacks we need to fix the VM
> infrastructure.  Chris Li has been talking about and working towards
> a proper swap abstraction and that needs to happen.

I'm also working towards something along this line. My design would
add a "virtual" swap ID that will be stored in the page table, and can
refer to either a real, storage-backed swap entry, or a zswap entry.
zswap can then exist without any backing swap device.

There are several additional benefits of this approach:

1. We can optimize swapoff as well - the page table can still refer to
the swap ID, but the ID now points to a physical page frame. swapoff
code just needs to sever the link from the swap ID to the physical
swap entry (which either just requires a swap ID mapping walk, or even
faster if we have a reverse mapping mechanism), and update the link to
the page frame instead.

2. We can take this opportunity to clean up the swap count code.

I'd be happy to collaborate/compare notes :)

