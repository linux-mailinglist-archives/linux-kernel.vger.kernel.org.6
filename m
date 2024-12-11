Return-Path: <linux-kernel+bounces-442130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0626E9ED85A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ADD8282CE3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614DD1EC4C4;
	Wed, 11 Dec 2024 21:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pjLc36TE"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3341C1C5CDB
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 21:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733952036; cv=none; b=ahFaezWbEEPgrekixw1CsKiJKwpKgBhXU1tIBl5eU5renNQmYNXFHfvH+/JhQeA9yVg0M7wsFyvbnxqs+ugtLVD5DBBGGeJGOhUraG3bf6ohCB0tO3usLN9EFpJAcTuPZPh2MEe6ToEkKlSGn9KM7dWZBql93ek8Cf+4mSZA5tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733952036; c=relaxed/simple;
	bh=6T9WrpL4sqWT331e0Yh7xF8mqS2u1I1S/1pC0eC7IDs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kqndJgGuA9xIxo2srwC1xbppeXpV+DlyEjKoiTLm68SC68RlfLr0P1tIItU4IfOj/p5hOWY5up1j11Fri+HkRdVD/upNFbuD3i8IVl5ab0GvEJTKyyEdFn42YRycYoxls+lW8F5vDsqga7PlTSBNJFnNpeT1fV81+UlCFXJzUOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pjLc36TE; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2163a2a1ec2so61077785ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733952034; x=1734556834; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a0zEciK8O4GHG3RCZ1UR9AOhZgRfwuZKEj0A7rDFXoI=;
        b=pjLc36TEPLga+guztOmngHcrYVhpy6fekS/9ftqU5sXIJqIwuCqgD3UWkS6+dAIVUV
         IT0af5paGr0ygA77+2L8QlQ62xaO80HqURPKwxMSLKjqQQJXNEamHXPJxPFeGAAugXyh
         X90enqzNSevMTxgbbTZhWn432F2/q1PPepXTvnjxmgYbAHxEBPOSyc88MxZqJlFzRFfB
         bIqMIq9ttlZ09rNPKXibrXAgFgEqHj3+Cz4xGIEcwC24RQJunEtwUZZb3MPGh2HU6q8d
         SV6jKMyCQiUZMrttHKKgxm6Al4lgYNiITkaxvPIex20UvUi0CvC08Pdku0oNuAmny1BU
         QV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733952034; x=1734556834;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a0zEciK8O4GHG3RCZ1UR9AOhZgRfwuZKEj0A7rDFXoI=;
        b=ZsYHMS+T964kcBmOYciwxwyXhwSPqFfubwyp2bqaGplOIgszcu/AZRorTs6OMiNvIb
         CyfJbc0H5RsOtvrEJIHA5OBVmJ3B8xoH9TEqinYY68rBp06OehofSyJh+wJCmWRWBFbp
         OmcltvUxArOCB+rkXtozaSwUFNptMtY8FxQgZGDW0fPA4yd19AFw4J/NQl9ozWK99APf
         naNQy4cNy/TcEzY6FdSb41q2jP2BmRaFtR9PCEb4RNVBekPhZODRJWz81m9v6FN8I45K
         G0fKuHbG4PZ3tGmX4PqXEDtGMIRKlSkKbH8akCraGFOXA1BTtXODIl/b3QIIZa7i/e6K
         dZ7w==
X-Forwarded-Encrypted: i=1; AJvYcCW1D1pqlV01Eud8DGeoUtP7MSpog0wVr9JJWgNxrzRe2zbAqnUqSYAe0s/n9GUQetwsV9lmllLx0lyeOrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YztfOGqvvxgO9bmfRvnW+Ie401Gid8X0VI9r/fpkMc9ZVYhqoid
	nvHaRHyUck+/N+ENN+8qYQJkQ7wg+FfR/O3e4mKmMCxeYL8D5bt02YUCdpxr9SBZ3oaJ3i/tuqC
	bopFvyIh39vKns3ANz7d6Kg==
X-Google-Smtp-Source: AGHT+IEhZ4/EYttELWP5/7DRwp/CXzwOZCI+gW47lGqaelEIwVvcTRJAGh8rjR/entYUOVYt+EKxjcrjy2FJmMYXaQ==
X-Received: from plbme11.prod.google.com ([2002:a17:902:fc4b:b0:216:1543:196d])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:db05:b0:215:f1c2:fcc4 with SMTP id d9443c01a7336-2178aeefc4fmr18775445ad.41.1733952034481;
 Wed, 11 Dec 2024 13:20:34 -0800 (PST)
Date: Wed, 11 Dec 2024 21:20:27 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241211212033.1684197-1-almasrymina@google.com>
Subject: [PATCH net-next v4 0/5] devmem TCP fixes
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Couple unrelated devmem TCP fixes bundled in a series for some
convenience.

- fix naming and provide page_pool_alloc_netmem for fragged
netmem.

- fix issues with dma-buf dma addresses being potentially
passed to dma_sync_for_* helpers.

---

v3:
- Add documentation patch for memory providers. (Jakub)
- Drop netmem_prefetch helper (Jakub)

v2:
- Fork off the syzbot fixes to net tree, resubmit the rest here.


Mina Almasry (4):
  net: page_pool: rename page_pool_alloc_netmem to *_netmems
  net: page_pool: create page_pool_alloc_netmem
  page_pool: disable sync for cpu for dmabuf memory provider
  net: Document netmem driver support

Samiullah Khawaja (1):
  page_pool: Set `dma_sync` to false for devmem memory provider

 Documentation/networking/index.rst  |  1 +
 Documentation/networking/netmem.rst | 62 +++++++++++++++++++++++++++++
 include/net/page_pool/helpers.h     | 60 +++++++++++++++++++++-------
 include/net/page_pool/types.h       |  5 ++-
 net/core/devmem.c                   | 10 ++---
 net/core/page_pool.c                | 12 ++++--
 6 files changed, 125 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/networking/netmem.rst

-- 
2.47.0.338.g60cca15819-goog


