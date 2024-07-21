Return-Path: <linux-kernel+bounces-258083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F1D938344
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 04:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2112B20F7A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 02:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4420D1FAA;
	Sun, 21 Jul 2024 02:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZI82JKCG"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45CF17D2
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 02:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721529416; cv=none; b=JhCjnctdifXAxHKwZMFBztvp2cCSvzIPgoWAvwJn4sNvy4HDi7wjuBFzM9n1ZcsH3x7Ng0/fD3hkC9PNOtkYM7pr+uB5z1eOxX/w1qTd1pAwnFgW1C/2Ap3l96h4jcdFNWHY2CjOVdW3NoVOTdgyQ1qDekUcPqsmyoyH2v68/bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721529416; c=relaxed/simple;
	bh=Na4s6px+nYKJhZQCRLM1jeQhAQ5XqonBmmGdRkHLp+8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rc9FDWPkO8HJKE02WgVzwkiJe0eJbG6eagAO0wi9fnDu38mqkYeKC677gmmI2KzaLUJmnSPoZOkDUE0Nd84M6h6mWLkE9SVFa3fVseCW/baXdMqQBhpyAdwmMESIOxH4By7rHilajTyCCf0CLa4HYV5kHVKhAD0+wwlXizNS9H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZI82JKCG; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-398b599593eso217635ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 19:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721529414; x=1722134214; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=12ync0Lb4d2F1abrlWeB7dvBZQvc4tt3x/Yoqnt4ykM=;
        b=ZI82JKCGjVRO68rn/3qdX1nDUtsBhxbzPrgcELKIAJy1zSDehFiqsMydtP592CkkH8
         OHfgxvyjgMK6MpUvjXnT59NCFIr4cgFEZLpYUxRKu38/Fg6DS67MsEHFCT00VXy1Pp2/
         ph8fdDj5B5GeXdUg1obNBhIuXKERUYVtv07AmYn+OJTg01zFvSPYTzIXCDOU0t8EOyma
         dcVM20JW3Cmo9Fnk5Nxgu1Oo2yp6weXIhF1ftjz1BDId2enGzu4WIQj32QOZNlolM+1D
         PJyos8WUNooUf/TBR4Logc7Kgbj+qBUSVAOSNi3NFp1YFlfREBwQ6zMgeE0CMqzljlFT
         ROCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721529414; x=1722134214;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=12ync0Lb4d2F1abrlWeB7dvBZQvc4tt3x/Yoqnt4ykM=;
        b=F8vcOT5TVGUksGv0T+ye35b85hnWPD3uYe7Dzag+nqEGTzLA5KSp3BlvygwZ0fnwQ5
         J2clFr3vfl/vHpBXA8Z2vP3vnOPBIMVh3vJF7R1HHRV/0DMoUBg7X2PMYwjSJ6sRh8r/
         RgxeVf6fksPjEAzrWBSB3RJ0GwsaBFA9wFGbwXv5iYIh6e9BQt6PmJQCCcuHHtdqOyO9
         nCQBE5h759fht07LnItHn2aQtm8/ALlLLuyGT6FiCq9Way85/LZ7LQ4559bYW+BocNay
         qS6GgQHgjGaGninlczE8Z+L98f522KSyAMj07Tqpwkk68oUNGJ3SbymNqa81CJf7kDYD
         nh0Q==
X-Forwarded-Encrypted: i=1; AJvYcCX/7aYYdc7QtrNMtTCjyni8B0fr8+qdv5X9yr2YCLjCuVbr0oevgWYDJ3P18OCkwllxeqZCxlq5KxubS4m+zdvImiOVzXrwF2294CES
X-Gm-Message-State: AOJu0YxCyxd6Pyg0/cu1tGIg/WXf0Dl37ETGkzunGXF27nVPuCAGyhFG
	3VFb+HuKAExznyJG03onAZ6NzEgLY2NKicKicqzOJEa45dZ7X2NbRLiIQvsxZA==
X-Google-Smtp-Source: AGHT+IHaWyfLHZqQJJ7xwEP3Xb152xsS5cesG8Zsw5YEWHax6vO5+BwIjS72+uA9u8CaVnm9Uou72Q==
X-Received: by 2002:a05:6e02:1a4b:b0:397:98d7:5175 with SMTP id e9e14a558f8ab-3993470751amr2299655ab.12.1721529413262;
        Sat, 20 Jul 2024 19:36:53 -0700 (PDT)
Received: from [2620:0:1008:15:d155:1bfe:11e4:98f4] ([2620:0:1008:15:d155:1bfe:11e4:98f4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d1370c6a0sm1290154b3a.185.2024.07.20.19.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jul 2024 19:36:52 -0700 (PDT)
Date: Sat, 20 Jul 2024 19:36:51 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Vlastimil Babka <vbabka@suse.cz>
cc: "Paul E. McKenney" <paulmck@kernel.org>, 
    Joel Fernandes <joel@joelfernandes.org>, 
    Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>, 
    Christoph Lameter <cl@linux.com>, Steven Rostedt <rostedt@goodmis.org>, 
    Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
    Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>, 
    Julia Lawall <Julia.Lawall@inria.fr>, Jakub Kicinski <kuba@kernel.org>, 
    "Jason A. Donenfeld" <Jason@zx2c4.com>, 
    "Uladzislau Rezki (Sony)" <urezki@gmail.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH RFC 1/6] mm, slab: make caches with refcount of 0
 unmergeable
In-Reply-To: <20240715-b4-slab-kfree_rcu-destroy-v1-1-46b2984c2205@suse.cz>
Message-ID: <0862b091-d5bd-1492-b12f-19657604eb54@google.com>
References: <20240715-b4-slab-kfree_rcu-destroy-v1-0-46b2984c2205@suse.cz> <20240715-b4-slab-kfree_rcu-destroy-v1-1-46b2984c2205@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 15 Jul 2024, Vlastimil Babka wrote:

> Slab caches with refcount 0 are in the process of being destroyed so
> it's undesirable for new caches to attempt merging with them. A
> synchronous destruction happens under slab_mutex thus excluding
> concurrent cache creation and merging. Full destruction of
> SLAB_TYPESAFE_BY_RCU caches might be delayed, but the cache is still
> taken off the slab_caches list immediately, thus unreachable by cache
> creation.
> 
> However a cache where __kmem_cache_shutdown() fails because it contains
> objects that were not freed (due to a bug in the cache user) will be
> left on the slab_caches list and might be considered for merging.
> Also the following patches will introduce a possibility of a cache with
> refcount 0 being temporarily reachable on the slab_list even in case of
> no bugs, due to kfree_rcu() in flight.
> 
> For these reasons, prevent merging with caches that have zero refcount.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: David Rientjes <rientjes@google.com>

