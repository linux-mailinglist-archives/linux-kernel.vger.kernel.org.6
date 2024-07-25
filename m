Return-Path: <linux-kernel+bounces-262631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 077D993C9CA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 22:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC16528515C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 20:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A260F13C814;
	Thu, 25 Jul 2024 20:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="zkLpusn7"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37B146522
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 20:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721940235; cv=none; b=XIC0Pyel3gzW7LRWthbbf2AyPOUhprb/IXk5fnyo7Ly4/MMQOkbwWClhswA4KibDG73ExgWFIG0DlwzKVObt33iQlCKjLPkuXdSMljpEyHt58ciQHMcpFOI2SHHU61Co6kvh89aYPaD7xi+zOsGsJjMJ6s3exc5vXn79eDewnv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721940235; c=relaxed/simple;
	bh=DBochEcUvC5Di1GgzDbptJzdJQ2SRM5Y9xWstJf+j5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqjatjgM79zQgy8Dz303tqZxfr8bjlPZCD3IAVDWdsfB3G59976KpjHuZ0V57ID3NjnFoBYiu+PTBwkjGD1cTULOEmDAd2FGwVrygpY9b64iMB78rxv90LIgEPnwtn9BmGXvcs9nqq6BHGJxmLsc4K5nrslkaP//KU3Uhbw+FcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=zkLpusn7; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6b7a36f26f3so22003976d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 13:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1721940231; x=1722545031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2w2v02MhUvqMkE9xn0dmWvuBpH6aLQWzCh6dyW2ZZMo=;
        b=zkLpusn76JZtEbd1hO6PvpN2mNHGBb9t8BDMVCZM6zg0CfXWdIKndB1vkrW18cY9sg
         a3H9ZuFxrQDJDd7uEfo+r6r+Ezn8r3KbMZ9/Kv7ZwUTUcEUkcRdsqDQGVTnK7yPF2LQe
         kq7/FAMllUmAb0Q73Exdiqdlo/Yk6wib/VA8zwZ7EhTulknq63jZE7TN1lnPF4mqn20F
         8zVnL0i10sOdBxgOPo5FguDJljeIPFTo00NJfBbKnoh5KSh5VJmxwDTwNyMaGPHxXk51
         vHc3a835r70JsStY8d54UCPu4sQWAeNp0WElwAux8W7c+Xd/JaOuMPX7f+NjSiMNt9gQ
         FmlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721940231; x=1722545031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2w2v02MhUvqMkE9xn0dmWvuBpH6aLQWzCh6dyW2ZZMo=;
        b=YusNXwDf1fCoSJ3AJ+PT53DnKwk9LQ2W0TodjvQiBE2+0hssVC2Dpvq6J7IusUtkrx
         KR0vDY3rCeLaK2H1zGAy7WNRY3OYMLmjiAATzlszjk5XXkP0qksXa9V0p/4zrlWxqfSU
         Wsi4DXlHWzrHHV2z8J95rVaji8jQHJBGlRxAFcUtCsMCkywrgwmEzbXu6D0TDzi0O6YE
         SYvWi7zuQxEYqi/yOPueXa22T0zo8vNOEh38cYbkkIBoLYqQbIP7uCurHzbrThWoK6B1
         FjXbZW0t8A+oV/mzGIxAef4sdnEGvlm81uF373yMFlaXkWP3IlLrDd0A4U7INN6K+XBb
         eQLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgWEbgc8eJsXMXkGjfensDu1KpsLMtysjMtGU4O5XAk7bTkE0Wo24qVPy8PhlyXX+yirEKd19iZgCpfefOILKrn3OC5B295BLm83+E
X-Gm-Message-State: AOJu0YwPqhHicGK3vyYLPnKw9zPFAUtHi8viIdcvX+/fJiH4JF4qnTcz
	J/6v2x2kh+ziAZYTnrXOoTcPCtJPfv1chUcY7IzDHYUa0RuHjptfQAjwZwzkNrI=
X-Google-Smtp-Source: AGHT+IERJ81gjGSRBt5y2E9uPDUsfZSzqJ4Abn/XUhM4sJZEb9wAV2KXHsy5WREqkXIX5ZxEFnRbsA==
X-Received: by 2002:a05:6214:124e:b0:6b5:8015:d72d with SMTP id 6a1803df08f44-6bb3c8aefa5mr91122286d6.8.1721940231501;
        Thu, 25 Jul 2024 13:43:51 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f8fb75esm10526736d6.37.2024.07.25.13.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 13:43:50 -0700 (PDT)
Date: Thu, 25 Jul 2024 16:43:46 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Kinsey Ho <kinseyho@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Yosry Ahmed <yosryahmed@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH mm-unstable v1 1/4] mm: don't hold css->refcnt during
 traversal
Message-ID: <20240725204346.GA1702603@cmpxchg.org>
References: <20240724190214.1108049-1-kinseyho@google.com>
 <20240724190214.1108049-2-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724190214.1108049-2-kinseyho@google.com>

On Wed, Jul 24, 2024 at 07:02:11PM +0000, Kinsey Ho wrote:
> To obtain the pointer to the saved memcg position, mem_cgroup_iter()
> currently holds css->refcnt during memcg traversal only to put
> css->refcnt at the end of the routine. This isn't necessary as an
> rcu_read_lock is already held throughout the function.
> 
> Remove css->refcnt usage during traversal by leveraging RCU.

Eh, I don't know about this.

RCU ensures that the css memory isn't freed.

The tryget ensures that the css is still alive and valid.

In this case, it just so happens that the sibling linkage is also rcu
protected. But accessing random css members when the refcount is 0 is
kind of sketchy. On the other hand, the refcount is guaranteed to be
valid, and rcu + tryget is a common pattern.

What does this buy us? The tryget is cheap.

