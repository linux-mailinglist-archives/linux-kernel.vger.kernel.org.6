Return-Path: <linux-kernel+bounces-423959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 881BF9DAEC0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 22:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7EFAB214EA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 21:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3982614AD29;
	Wed, 27 Nov 2024 21:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="POdWqnXe"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9FB154BF5
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 21:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732741506; cv=none; b=aoHwqx5EgP5RRVGAHTDRoJuYqUptNwQWrsFgry59P1uz+gSXrPs3VwPsLxYaT7BjKK8Y9NCYHY3uYk/CABM2l1BwiKs0s0fFHlugdO8SHi8xRw4GGtxZ2tqWlvSJCAlkS1eFPxFQa9XUQ85mjClk1THMzzbRfotaNY0nFiAhnIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732741506; c=relaxed/simple;
	bh=6biYp+6ZfGUjL/SgAvSogDVcmG5MlG7Zq/OJYvvtXBw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=I2z6nFwHdaKa18WstyBdnwCK2lQK7DVZRN7oPcX5LmJK+1SP7FdkTkBAE1k+KkUn6ozqAC0cmU984i6T2U0ItHGTTsliIleGo3mhpoBg1UY8E1eTgc9KnKgNH2BgZodzCr3HypO/i9uL8i0s56ssye7aBh7nEjUZt6EEocNqplM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=POdWqnXe; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3824709ee03so117248f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 13:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732741503; x=1733346303; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6biYp+6ZfGUjL/SgAvSogDVcmG5MlG7Zq/OJYvvtXBw=;
        b=POdWqnXeKGMNU4VUevAKmKUJEXYyfv7sqNVyGKgLJw7TPjfcTZSULBQ7zI5cxjslbK
         +ogbHh69w09Yc0tKzCw4hhg6KCPLVmokbVvVKFfQTy9LKSU8XBSHbZIFB/i9DkvLvYh6
         XyM6QbusuSVUrzRjlxRjJm4AyGQogjLqGIDqPlh4bPi+QDn3neGzV4de9suFr/SL3t1r
         gPX8ADI3VznXsg+IXdSZ1PDEQFjNZMZLOE3LskM+Lu2YehD8YcnQ5r1laVXlwPtne3pG
         JujDq/iie3FLtUxuLSyEY8LOWxDNyeIXyvJf3La+WvukyjXS+sD2NT6IfZwAEVwD0gao
         Xahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732741503; x=1733346303;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6biYp+6ZfGUjL/SgAvSogDVcmG5MlG7Zq/OJYvvtXBw=;
        b=WeExitsVhTUe+9VoY0gSoruEZYWwFpoV75Qor8ACq8KWBFnRzAuz2h2UGYkjDkOEda
         fnnylKT1euwhUrmW/yp1n0nlb/RFMnYNxAAG9D94PPrHerazl3gIp6jUJrewAn900fwD
         VO8aWWLrKugMb+eZM6M0hzfYnqPMHFM78VBGXAeOCAJgimHB+ykUSOUshRuY8hEhAI7g
         RRLnxsUQ4jDyUUx3wY2GlEVqxl2KPH4wC9AsbmDuIgB/MXhOSqYgKZ27rXnlK6sRYq6b
         XqYwtcv7ti1+XV7hk+f+G80UW56lbml2vTFeAiRht3LXBNz3RnGp8jo9QzE7849rjnQn
         xVYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhRQ6skEDi2ifsfa4D9BSbgyHJk0J72enn26pAI1bzOXBiJ5hktIHKsnItwR3ulRjmiMlNwITuCW5QwWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIE3o0LjUB6HRkiGL9nzeXQ/jxGZkKNqk+Te/gd5qfQ/AWBmSl
	HGpEmVhshxHgaE+IwU3jTfuvnm1vpj65lrp7iiYyaKJk2U49HwD8jbYCuB+uG8YC/lhdf3LCteN
	bJTuyPcNd5E/+KrnRing/RdIl/yX3oROm6UJL
X-Gm-Gg: ASbGncuMSzVk+d+yyJiIDHT7n4MTh939nZi+lxbj+dPRBrsRl4joN2rw5x/vX85N+K8
	bSaNQyCy6aOAJkUN9DsitdQzND+tHQlZu
X-Google-Smtp-Source: AGHT+IGdFse4RAD6QkqDKI9fg4urdam3vMe+wtZk8AzXAJMsg+euTEP9GHYvdmww+9BiM+6zarTRyeFOqpLdC56Zyyk=
X-Received: by 2002:a5d:6481:0:b0:382:415e:a139 with SMTP id
 ffacd0b85a97d-385c6cca2a1mr2970566f8f.7.1732741503292; Wed, 27 Nov 2024
 13:05:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 27 Nov 2024 22:04:51 +0100
Message-ID: <CAH5fLghFWi=xbTgaG7oFNJo_7B7zoMRLCzeJLXd_U5ODVGaAUA@mail.gmail.com>
Subject: [QUESTION] What memcg lifetime is required by list_lru_add?
To: Dave Chinner <david@fromorbit.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>
Cc: Qi Zheng <zhengqi.arch@bytedance.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Linux Memory Management List <linux-mm@kvack.org>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, cgroups@vger.kernel.org, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Dear SHRINKER and MEMCG experts,

When using list_lru_add() and list_lru_del(), it seems to be required
that you pass the same value of nid and memcg to both calls, since
list_lru_del() might otherwise try to delete it from the wrong list /
delete it while holding the wrong spinlock. I'm trying to understand
the implications of this requirement on the lifetime of the memcg.

Now, looking at list_lru_add_obj() I noticed that it uses rcu locking
to keep the memcg object alive for the duration of list_lru_add().
That rcu locking is used here seems to imply that without it, the
memcg could be deallocated during the list_lru_add() call, which is of
course bad. But rcu is not enough on its own to keep the memcg alive
all the way until the list_lru_del_obj() call, so how does it ensure
that the memcg stays valid for that long? And if there is a mechanism
to keep the memcg alive for the entire duration between add and del,
why is rcu locking needed? I don't see any refcounts being taken on
the memcg.

Is it because the memcg could be replaced by another memcg that has
the same value of memcg_kmem_id(memcg)?

tl;dr: what does list_lru_add actually require from the memcg
pointer's lifetime?

Alice

