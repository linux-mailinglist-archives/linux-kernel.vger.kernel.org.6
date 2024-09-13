Return-Path: <linux-kernel+bounces-327544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 516B197775A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 05:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4BFF1F2564C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 03:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D4C1AED49;
	Fri, 13 Sep 2024 03:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JdVhp7j9"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9A87E782
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 03:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726198118; cv=none; b=GRMRjNajUyU2M+VgM1/f2nEZHERiPXGZObBueGEpltkoCnZgp3BJyBtdslR4OoOZBMr+P6RP6B+/01Zjz5KQEinDGyw7GZuOYqgMqToyXAbbz/JbFTsUhK0vD/Ckj07tc2J9it1Zjo7NaR9wFh6Pc1enAjql+J2q+cEYqS2LRb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726198118; c=relaxed/simple;
	bh=tXIZGGwOAe5zgTwiSn9fDaGoaLFWMTwvFPcHOj5kL3U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UlsrCGuohqNic24nCanQiQYDZmx6zvfPjYfZLfHoACf7G3U+2qEc+H3IuN3UivDKMZTfMYPeBKmR071uNV/xw249wXfIz/JYkHudqunJ8HN2dtNsHdEPe+WMYBQ0fQmJCieI/Jcu8rHPVsUtp/cSPCQKAZwDidIurqrN/o8XsBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JdVhp7j9; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1a7ef9eb78so2869727276.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 20:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726198116; x=1726802916; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b3YOB4wcPo05ff7ziEmXI37nLmZ1RxeYVhodrn8b1/4=;
        b=JdVhp7j9IErM2XyTk5NIBXzgrDyXvoge+D0FUXedaqjfOHlmLl/GhcL9ry45wR8Q3i
         UcpAcT/DIdoWvOlnBfViQ4ptlfDtY5NKWl6m60p79aykcPAOyvD3uNCxFV2pcRubqoxu
         7dE1FCcNFnEhWqOGbQA977s94ieBQ9OxJhrPXYRaSBokbiK6aZtc6WWD0czwi+SbCBkt
         gUyk4ibjXSX3RPwmPg5m0gVgF/emSzC4CL29KuuSUfeX4+mHLOXQU5j8C0BndFOameBz
         qzs0olT1Z5kzXxBQJ68OWDSVEal8Xfn6TLrvHE8quJ0foAmj3lk0Qun/ZKIfH8zUHw0e
         fRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726198116; x=1726802916;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b3YOB4wcPo05ff7ziEmXI37nLmZ1RxeYVhodrn8b1/4=;
        b=Fj8uKRr0MqCUk49SDuigq9JZrgSeL4e8S17uVQfk+U4S4WirgN5JTrfY6YDLKJcoSI
         KSnwEFoTin0CFZ2Vomc/IK+q9ogAxDfZOMKJ8x5bNmyZzOPzMVRaO+OXaWOGeWBQEan7
         zNzmXeuAnwd+as/bteJ4m4/JGguF8q+tpz6NY1LZccTE4dd9rB02KiSYFqj9t0+1FWJF
         vqER70RGGqbcpBhC8EisGEQwPyNiJ0o3I436Ix6q2fFaU2yLw+bqRZQRFpJ/5YxaQoRK
         os3Vu//ghDls20zN7KqUI+Xctrfarcxcv6SS0vmgm/06e1l+Ua4hIeEGhUD/SoyQwK8U
         YL8w==
X-Forwarded-Encrypted: i=1; AJvYcCWssS8wgDp1yyj+MT5SXJfLOHTlin/Kzx5CwUTXhHPWos5cM0I/RinGgZtV8XrdDM5G4pb5MsVfVo4ngmo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2dyUYPm72pHtv5lY5VoBhCB+ct1lbNQzDm+ofo0uvKMuneM4B
	0omyZX2g65G6t8PXnuV/qhmCr4Fl98hd16lgeLJXO3HXP33f6l6rrVhRJvb8uaWnb6Rv1zDoxw5
	6bj3U7ck1wPBdsfOyNHtbdA==
X-Google-Smtp-Source: AGHT+IGv+5TvG476u+LirlfcJi6YSkhfRkMcokm6Ese/NoGd2WPBzbHbdaBVEcQNv5+2fD/ru+B02CLKZxwhvkLkCA==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a25:8747:0:b0:dfa:8ed1:8f1b with SMTP
 id 3f1490d57ef6-e1d9db8d00cmr14365276.1.1726198115993; Thu, 12 Sep 2024
 20:28:35 -0700 (PDT)
Date: Fri, 13 Sep 2024 03:28:24 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240913032824.2117095-1-almasrymina@google.com>
Subject: [PATCH net-next v2] memory-provider: fix compilation issue without SYSFS
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Content-Type: text/plain; charset="UTF-8"

When CONFIG_SYSFS is not set, the kernel fails to compile:

     net/core/page_pool_user.c:368:45: error: implicit declaration of function 'get_netdev_rx_queue_index' [-Werror=implicit-function-declaration]
      368 |                 if (pool->slow.queue_idx == get_netdev_rx_queue_index(rxq)) {
          |                                             ^~~~~~~~~~~~~~~~~~~~~~~~~

When CONFIG_SYSFS is not set, get_netdev_rx_queue_index() is not defined
as well.

Fix by removing the ifdef around get_netdev_rx_queue_index(). It is not
needed anymore after commit e817f85652c1 ("xdp: generic XDP handling of
xdp_rxq_info") removed most of the CONFIG_SYSFS ifdefs.

Fixes: 0f9214046893 ("memory-provider: dmabuf devmem memory provider")
Cc: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Mina Almasry <almasrymina@google.com>

---

v2:

- I (mina) sent v2 of Matthieu's fix.
- Remove the ifdef around the function definition. It's not needed
  anymore (Jakub)
---
 include/net/netdev_rx_queue.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
index ac34f5fb4f71..596836abf7bf 100644
--- a/include/net/netdev_rx_queue.h
+++ b/include/net/netdev_rx_queue.h
@@ -45,7 +45,6 @@ __netif_get_rx_queue(struct net_device *dev, unsigned int rxq)
 	return dev->_rx + rxq;
 }
 
-#ifdef CONFIG_SYSFS
 static inline unsigned int
 get_netdev_rx_queue_index(struct netdev_rx_queue *queue)
 {
@@ -55,7 +54,6 @@ get_netdev_rx_queue_index(struct netdev_rx_queue *queue)
 	BUG_ON(index >= dev->num_rx_queues);
 	return index;
 }
-#endif
 
 int netdev_rx_queue_restart(struct net_device *dev, unsigned int rxq);
 
-- 
2.46.0.662.g92d0881bb0-goog


