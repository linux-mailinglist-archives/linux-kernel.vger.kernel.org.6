Return-Path: <linux-kernel+bounces-438108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEAE99E9CE1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 18:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B8D0280CF9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 17:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F391547D2;
	Mon,  9 Dec 2024 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VIi/dOMg"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2B2146D57
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 17:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733764992; cv=none; b=uYtxvDL+vGUNTvU2jzPeOyDOFMrvs6gBFuM13DYGLS3Lp8GvlvxBoKBJ/j5lrwdzC8mla9pDelojrZbreZcCVQp+VZXp2pdix0pAvCrqBtnGMrWoB/rElCTFypIrjWTksmKokuAqMFWtdB1/IEWPlBPwb6NZ5pig9UapEV5wM34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733764992; c=relaxed/simple;
	bh=6WuUUwH3gHhkqL6Geg5HTcFT90fV2BNuVfb02BCAuMU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nm/Nb4Q/WpcdlASyXqsLUnguImKqlmbeLFw5cayj6BptZHVf3Zx12ZvJ9/jmqtYIggapstyp5HxCKgAJxKPxBNORMkewPsh9D/2grrO5oxT+gnsbYs6cK/bMSu6jQmcKbNBAEj0SdQb2jptZo1CoZSzhhEaaKkufgdPva1uKAkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VIi/dOMg; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef9dbeb848so1558445a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 09:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733764990; x=1734369790; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vcu7R+0hVbbFouwgTRPW+Y/QQCHn4WyI0pgnS95JVB4=;
        b=VIi/dOMggdouhd7pSoAH5rVjV2sIeBUP2niuZUI6fqERAK6cT2sA153eE3+YHneIdY
         VIU24VyxVzNq/zipsfMYNIZMm7VOFk5kySBsbZi1eF4Rwz6O2Njm9NL51iZIiPw6RxXR
         j8V1KPaiJWUOdgeq68/PAgem9g+MZrDIpue0ctdx4jlbFAJzaFCr3SH4WkCFrMGbL1rM
         Aacpsp2EbnySCueoABjn6Qmn2OpkXTrV4sUItjI1Ap8li5eXrzKPoNwTFHSPloUYuncT
         yk7/beYLGG/3JFx4zygwTppxlB9H5ocnkq4u88TmgZT+SkAPwL/uu6BMHuIwnLANAkFW
         Fogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733764990; x=1734369790;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vcu7R+0hVbbFouwgTRPW+Y/QQCHn4WyI0pgnS95JVB4=;
        b=fbB0X/o+NL4ko/Q7bJRv0dHHFeakVrT1+wm09sHHPE3DDPdvwRUM1l2Wo6y5IhJRQ1
         HFvCWF/lH0ea6gZhV5Gw/c7v1QXDxKZWPUpXPlCal781X92vXMpjjO3jepAxounKiC69
         5FDAFsODJO8w2pjR7NSsx+M7+utbv6wPe73tJUUqO81gEJz+AJ00Sg6gX18Wh/JI3Zoj
         aFWvDIbH2iJdFZlwBttq3pouckjZLfbZbjz1OG5eCxcLggr2QChVowtaJ23jn5iawBz1
         0McNzX3K1Iuj3Q3Q8nSQSH9suagQloSpCrnssMwER2YL+xjkByBIF/ciF3NwToLTe0Um
         QBkg==
X-Forwarded-Encrypted: i=1; AJvYcCV5edNsDHzZdJgvuDdeULQli2GP8Onkruv2+GXqjDEE4WFeOJfGD5l6rGVymJQ4ZncsnSxkNpctoLfnBeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIXJKAvwaDvYx7pQSNvHDQsfOTjCUGoTeFQjsC3DoaQGfpBxNb
	1rW083mY6dvvNOB8sU7fquDXCn3MTu4k0F5OEILjReqTgepFzakbV582du1fy5el1S0hYUcaj+b
	N/olSIQH9wK2zMDynhNOycQ==
X-Google-Smtp-Source: AGHT+IHwFdgtaA5CQfgLnW5VETq5BsceGrsp8a1IVqplrBkmkNvV7iaPoDLphNxXb40d3+EXo1QIWhIXC3RmqoXH/w==
X-Received: from pjb16.prod.google.com ([2002:a17:90b:2f10:b0:2e5:8726:a956])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:380c:b0:2ee:4b8f:a5ac with SMTP id 98e67ed59e1d1-2ef6aad12b5mr17501893a91.26.1733764990550;
 Mon, 09 Dec 2024 09:23:10 -0800 (PST)
Date: Mon,  9 Dec 2024 17:23:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241209172308.1212819-1-almasrymina@google.com>
Subject: [PATCH net-next v3 0/5] devmem TCP fixes
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Willem de Bruijn <willemb@google.com>, 
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
  net: Document memory provider driver support

Samiullah Khawaja (1):
  page_pool: Set `dma_sync` to false for devmem memory provider

 Documentation/networking/index.rst           |  1 +
 Documentation/networking/memory-provider.rst | 52 ++++++++++++++++++++
 include/net/page_pool/helpers.h              | 50 +++++++++++++------
 include/net/page_pool/types.h                |  2 +-
 net/core/devmem.c                            |  9 ++--
 net/core/page_pool.c                         | 11 +++--
 6 files changed, 100 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/networking/memory-provider.rst

-- 
2.47.0.338.g60cca15819-goog


