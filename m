Return-Path: <linux-kernel+bounces-400679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 160F89C10E0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483F61C216EE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5426221833C;
	Thu,  7 Nov 2024 21:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="221scneS"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42546194C92
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 21:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731014596; cv=none; b=UqNPE5Sh2bmdiCT4c+/6aiWG4D8AKMy6RkhNGx8AxHmkb55uibqlHdKPA1jhZ3Q5v7TBatoDr1rznmWcOfg1tMfwPIrlR7TNv4Q88+Zf9v/OurP1GKTJwel72rF8BAccoFnsB06Y4raa59R2Xms8o5/nXBk2kB5O8aTSAJl+amQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731014596; c=relaxed/simple;
	bh=B8lXU5/GjCAU9MbV/zhOPpH/Pl5WyZX8uw4PpD/WDcs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=APs1Zzr1VKJuLX5fK7lHFkuaLJBbZY+jjSDeAcITAPgvmLclxmd+2iK5l58Eo4DReS3yx0K6mKWM//qG9kGZzFLSJSk6vsIaP40AcavORuMX6/2Lt+dMTsthI6btkqWGcNFvz0I3c5TzCPsxzQj2mTEZDkRi2B6TAxMyp6zvrPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=221scneS; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea33140094so26364377b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 13:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731014594; x=1731619394; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U0hBZkKcHVOYvuhh4Gtl3CCQegEWym6RvcOQyQxM+FY=;
        b=221scneSF5tvGID6TYUz4NpPlBe2+jjdN0SRcATWtmxnoDTPi+88q0XEr6+uqGwG+6
         TfZ9xYnFOHa9VNcPt4pUZUqCqZquIIXaYdcNuPvwgPMkDnP5znXktYjKUG6lnktCHeYH
         9JlYn477XooWxUhM4PQ6FSKjTMB4Wk5k4M0bkwy2harXD9/z5cOWErASpmIWij/Lengq
         gX+DiSGXJX+zF1mqDHHpixnUoFgKEHBgCpES7ir4wDLT+DKTcCu+zXk0tLJxMnoYuCYQ
         00lt56fh/FBlVxB+EWlgXtkvYxl0vrxYj8FANVvxiw5ZXK2ZLVBJpZ42H37AG6utrGmm
         WUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731014594; x=1731619394;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U0hBZkKcHVOYvuhh4Gtl3CCQegEWym6RvcOQyQxM+FY=;
        b=g5dlQkyRsb7GN2jpzC49d3kJO/krRb4mcKI6dtTi4bO7QAoCP7sP8H6x9s5cjTYEYz
         QZoQfx6FTitKz8QIFTBi0HQQVZJSOLOyMgKlKxMb4w1MOSKmJyz0D9rthWU8F0yDcj5z
         Mdef6yd8q31wo/KBI2yY9LIDkTn2exbEaLWCXxhcp4vPIJ38hrsRlxJ51ag78AN41oe4
         dsP7a2m2nIsapPSnjvne17ABWwDZ1KZVh3SKIu7cDmTDyRqd4BC4N6PZsH3rb0vB0Jtt
         SDQP1HXtN9gbHUYw1l7X/J66fviXOnpaizE3j63fPP/er4B1543pXIdbyQrkIbdAmZ7+
         G8xw==
X-Forwarded-Encrypted: i=1; AJvYcCUlBsR4QBzCTKD/sA8vGv/vEtKQs7LJuVa3BiBDgjPbUJ7qh8zjfEHjaBidZ9Pw+BDuGo8KxBd4bs/PGW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6t1/CPBKRQ/dFsfr8HMskUfI8IZIXNxUWNEEXLn9Ye5E9ix7I
	zABSSbUonluf0xu1VUQuUKe5fS4Gd3Ubdlw9xAxZlyhaP1wEViMHaTTgHBRPTXj1QooQUOHpUYW
	tpMRvB/j7UsHBfZwNSycIWA==
X-Google-Smtp-Source: AGHT+IH6MBIMxvNn6nOxRZPgCps/6+Mob5Qm+rnJ3UqtunnR2PDSvtiNhe/pAknsYrvPgW6ow9HA/O+dXBqqid5UWQ==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a81:d10a:0:b0:6e6:c8b:4afa with SMTP
 id 00721157ae682-6eaddf9599dmr25307b3.5.1731014594162; Thu, 07 Nov 2024
 13:23:14 -0800 (PST)
Date: Thu,  7 Nov 2024 21:23:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107212309.3097362-1-almasrymina@google.com>
Subject: [PATCH net-next v2 0/5] devmem TCP fixes
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Couple unrelated devmem TCP fixes bundled in a series for some
convenience.

- fix naming and provide page_pool_alloc_netmem for fragged
netmem.

- fix issues with dma-buf dma addresses being potentially
passed to dma_sync_for_* helpers.

- add netmem_prefetch helper.

---

v2:
- Fork off the syzbot fixes to net tree, resubmit the rest here.


Mina Almasry (4):
  net: page_pool: rename page_pool_alloc_netmem to *_netmems
  net: page_pool: create page_pool_alloc_netmem
  page_pool: disable sync for cpu for dmabuf memory provider
  netmem: add netmem_prefetch

Samiullah Khawaja (1):
  page_pool: Set `dma_sync` to false for devmem memory provider

 include/net/netmem.h            |  7 +++++
 include/net/page_pool/helpers.h | 50 +++++++++++++++++++++++----------
 include/net/page_pool/types.h   |  2 +-
 net/core/devmem.c               |  9 +++---
 net/core/page_pool.c            | 11 +++++---
 5 files changed, 54 insertions(+), 25 deletions(-)

-- 
2.47.0.277.g8800431eea-goog


