Return-Path: <linux-kernel+bounces-387666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79B39B5453
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 21:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04DF01C227F2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 20:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0412A207A25;
	Tue, 29 Oct 2024 20:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oXp6Lyc1"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829B5207210
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 20:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234746; cv=none; b=fl9ELODIH9durR2fXHeLxp3KCKxdLHf/+7bA5YXNmZiKuAbFh1/H/jdxQKqs1G+Kw2FzI50nA0Yp61kMDUjr5VzO5Tn/yOLL2u47VRiy2FA2pFOAyEwJiiQZeQzqWHq5K/Z3CLJWv3NpkpPCOQ0P12QSA2ylAvFm9HuKb3j8fcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234746; c=relaxed/simple;
	bh=UnbV6MuNFExLfF8+2aKHw1foBqeANBQ10VftomuflNY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mQ1XQOTE0ZSReUh7xnPy3mzgr1IO6KzgEX3MnSyyZAnqHYALCpnA9Xu9aVUPcJX89Sal1A9GsWk3SaAyMQ4cFZ/h1ci+sH5lHKufoov47DVnV25MLtI9XBKLt4MJ7OTEdh8FngjcqxHWGL/cFac8cgyZqRhM7h7sikyThSh0O+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oXp6Lyc1; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e1fbe2a6b1so117769887b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730234743; x=1730839543; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JQEUQwPobw3Oiu4hV9Gh16GwH7ZLjOLSQQhkjXKL0tQ=;
        b=oXp6Lyc1xtxCOdZXqJoUcVwbACrVZBTTAo0IlhJ3fS9JpILBnTPoaMaULhVNhqH9cc
         70ZIxLQFAKrUFDL+Z+bMLwmmdK8gkOYTpB9udVgjKevw7+/cIsMGKEkuafR6sQnTEsFA
         2b1vKo9OailTt+iPtpbGJ95o5a/j3oHaT0Acf99Eg/eW2UJLwQc+BOx4gtDA/enG3TiW
         fC9cxas7ltiEKDatmzXcIsIVjjjMmV/ZcDYwxV+X0+zixXy2KvEw3GcByK8piPWOLn+X
         cXbGaDmxQ1wznVKYUxmLidR2mmOQONM3JjZKiGWRG2GqXOVdFB1Lk1QO0EUwu0sKX0Q/
         CQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730234743; x=1730839543;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JQEUQwPobw3Oiu4hV9Gh16GwH7ZLjOLSQQhkjXKL0tQ=;
        b=G/Eqdh32oX6nHAThEkxFTN3mBdWIQLkqSALcovvmAJdYPC8MHM1q71SRuhsS0930Pb
         H6FVMy7vBmISPPrKglOaecV/qwcW/39HCaNYk/pnckph6gv58Na7pvGVyPMaWw7Bv0QS
         iDNDbnYtL8I+PSFYlIFODDWyaycOXte5Uf3R9FXGNkXNKS4Jf7n9Ov/n0rDl3Jh1MlUt
         q9Wlsw5dkcGi7dg5opk4k08ospiQ3x5xtS6lvN0ktq+BtORe6nn9pJIrHGdU9T3PIJmg
         YMEX8tIN8GQptTCr/2CHL+mMP6teRUwuT9uApgEpo7MU35koQ9qyhnFXIyZ6+zmMhuJG
         ByMA==
X-Forwarded-Encrypted: i=1; AJvYcCW11QXgTzx//NvUaR4JWNDp5kuLc2ygCVvHIJlLUJ0gh8P2mxPLYLGTR/SzFVGJKMYzJaTvkGALCaBodvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+z9goV08lmnpgNb9y/waL3gt/B1OJLrnXAmK0h/410CiO2h05
	viUqzhUqENtYIkY2Kh0T6upDRe7XN557vpB0I/CJ8Bn4W0x0rOsE2NYFdBAxRnJTSJjyUvU1DXx
	QCRZ78LmWNVYd4v5Ez7osZQ==
X-Google-Smtp-Source: AGHT+IGrCicaNsIac7OAa7RKi54mxGcZhpjM7/v5kaVOQvujs4N2Ri/8i1wyq8Q6f5dhrmpQkbFHQ18QLGt8TO/39Q==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a05:690c:7449:b0:6db:bd8f:2c59 with
 SMTP id 00721157ae682-6e9d8b8f13cmr5280167b3.4.1730234743615; Tue, 29 Oct
 2024 13:45:43 -0700 (PDT)
Date: Tue, 29 Oct 2024 20:45:34 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241029204541.1301203-1-almasrymina@google.com>
Subject: [PATCH net-next v1 0/7] devmem TCP fixes
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"

A few unrelated devmem TCP fixes bundled in a series for some
convenience (if that's ok).

Patch 1-2: fix naming and provide page_pool_alloc_netmem for fragged
netmem.

Patch 3-4: fix issues with dma-buf dma addresses being potentially
passed to dma_sync_for_* helpers.

Patch 5-6: fix syzbot SO_DEVMEM_DONTNEED issue and add test for this
case.


Mina Almasry (6):
  net: page_pool: rename page_pool_alloc_netmem to *_netmems
  net: page_pool: create page_pool_alloc_netmem
  page_pool: disable sync for cpu for dmabuf memory provider
  netmem: add netmem_prefetch
  net: fix SO_DEVMEM_DONTNEED looping too long
  ncdevmem: add test for too many token_count

Samiullah Khawaja (1):
  page_pool: Set `dma_sync` to false for devmem memory provider

 include/net/netmem.h                   |  7 ++++
 include/net/page_pool/helpers.h        | 50 ++++++++++++++++++--------
 include/net/page_pool/types.h          |  2 +-
 net/core/devmem.c                      |  9 +++--
 net/core/page_pool.c                   | 11 +++---
 net/core/sock.c                        | 46 ++++++++++++++----------
 tools/testing/selftests/net/ncdevmem.c | 11 ++++++
 7 files changed, 93 insertions(+), 43 deletions(-)

-- 
2.47.0.163.g1226f6d8fa-goog


