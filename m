Return-Path: <linux-kernel+bounces-400684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F609C10EA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 22:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 983AA1C223BB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C99521A4C7;
	Thu,  7 Nov 2024 21:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iAUL81ln"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A88219CA7
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 21:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731014604; cv=none; b=OIadBprgvRyu1SqoFp2olnUxqjAILG1Sn96Z/pWnIj/HSn61/PKmYUkJShRvoG6Dj6b2smIulPmCz1yH15nK39j8edLYhGeVLgyBfey7tMMg2AYAQ1xRYhJ9PSDl+c1rvUvcQVF+c07QgO3gSZfDffCE14VTwYQFmZfbfR7IzOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731014604; c=relaxed/simple;
	bh=hiLF67ZB3WMU8hX4LaHsXxF0Pkp+AKd2y1OkKzs23ts=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IKVKHHSViq30T/LToPVZfOv+95BoYiVkoW6zDBLHaVBFXv2vjWIaLrYQs6bEov/stKsIHpchNhc3HNEChgMbagOnXeK/N6FKoYjYe0xD22/EWsfEAV/Pcj5kvVSqRgFB3CTfFBzzxVHQQMX+dIHhWxXDydhUeM9oCgcMkZx7b+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iAUL81ln; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea8794f354so27175857b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 13:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731014602; x=1731619402; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6k+P4diOLJqi5qBWB1cI5BvWrqmmxwXAHcITy5id4XU=;
        b=iAUL81ln8pM5B/FpetkpXP7yfwpV3Haj3NMDZKBKfsNes4br2SmhJcnBuV33kxVdq6
         PAb9/at7Bj1ODme+aUzxyztWdOmT0JE2GgLhYIiZFmiHqp2Btq6wFcMuKD2/n2D7krXO
         5RCrKEfyOjiB6Y0xw6NT5t2GIsSJF913G/iAvhOl9jMSahkmz3UXynFnit0GfEigNz5/
         Alvmov51R5qLT2fu7TKBwZzPkxaL6zYJdjYqpgV4mn4TOWrZ4DCTx7TlRRjBNMnDCZ4g
         OUhk2tVlmdfkBdO9MwZNE8VLUHNzVuFeYjqUKxw8p79YADGOkCyuk0y34tqhf3HCpp0P
         Tclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731014602; x=1731619402;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6k+P4diOLJqi5qBWB1cI5BvWrqmmxwXAHcITy5id4XU=;
        b=kwEh/RV+DGTTwpLB8PagVV7yzWOXmMPV7Rg54qWqXXVHV6/8Hu9lHu+yvQKk1FWXus
         TJWcyYGQxojux0Y7zc1+HTytvkn6j2vuYamSmElxTz7tgQCcVqFlVeP5MHfxffJmdfZ9
         Z695145vV7AERXAj0qN6TWof/2nzCdeEu4OkNq62HN32poCawCmhoVlgMmx2CXmff15Y
         u2TpzMdrxjySl7bzAuMxACl52yUuiz1bcnX18q0bZLWjG16OAQzqGivves2k3dQ0at3R
         oS0uI1EEXO5Re7YHT8rTo3Ho9qfRCZmnt2Lgtra4T2C4ipbmjjvKsOKHJQEbOLjjz37n
         CIrw==
X-Forwarded-Encrypted: i=1; AJvYcCWq7s4UEX8YQFoOj12hzTaAK5WjzpxS71wp1p1y13Hi/VO3YbALmCwpq+3e/bl3JR0ZIrXvV7GLoOC44hY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqVukhrG2B8Mh+vfn/kaEYsIMt88OTTFl21YMcjyNyanwGZCRv
	DEQ2ELYFNbo++qqR5+ZhLai/4ZNhENgUPe1ysogvMd4isKI4qVOE78RJcT7r/epzsA49Kio7BJk
	dLmk4Socy1Qk20bNoj7RX2g==
X-Google-Smtp-Source: AGHT+IF7xrqtzpYezRtSKaHI3uuKF4iJovh+7+L3DoGZk9NlkYM7SwDne1PSukpRNI4o5wYpQPfuw2lzr3HDcb/9AQ==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a0d:f4c5:0:b0:6e3:2693:ca6b with SMTP
 id 00721157ae682-6eaddd64226mr13067b3.2.1731014602472; Thu, 07 Nov 2024
 13:23:22 -0800 (PST)
Date: Thu,  7 Nov 2024 21:23:09 +0000
In-Reply-To: <20241107212309.3097362-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241107212309.3097362-1-almasrymina@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107212309.3097362-6-almasrymina@google.com>
Subject: [PATCH net-next v2 5/5] netmem: add netmem_prefetch
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Mina Almasry <almasrymina@google.com>, Pavel Begunkov <asml.silence@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"

prefect(page) is a common thing to be called from drivers. Add
netmem_prefetch that can be called on generic netmem. Skips the prefetch
for net_iovs.

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
 include/net/netmem.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/net/netmem.h b/include/net/netmem.h
index 8a6e20be4b9d..923c47147aa8 100644
--- a/include/net/netmem.h
+++ b/include/net/netmem.h
@@ -171,4 +171,11 @@ static inline unsigned long netmem_get_dma_addr(netmem_ref netmem)
 	return __netmem_clear_lsb(netmem)->dma_addr;
 }
 
+static inline void netmem_prefetch(netmem_ref netmem)
+{
+	if (netmem_is_net_iov(netmem))
+		return;
+
+	prefetch(netmem_to_page(netmem));
+}
 #endif /* _NET_NETMEM_H */
-- 
2.47.0.277.g8800431eea-goog


