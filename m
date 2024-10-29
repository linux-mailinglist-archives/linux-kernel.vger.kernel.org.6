Return-Path: <linux-kernel+bounces-387671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6103C9B5466
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 21:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9279F1C219B4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 20:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626B020A5D4;
	Tue, 29 Oct 2024 20:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pd8bUOpU"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1DA209F22
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 20:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730234755; cv=none; b=Hp6a9giDW50TsCNGm0m7bSEb/9qairBrwac88C7beT52xz0dMmJDlHDkn5J7RKBAKDAkLJhYqM7SM80MitkT1O9RVpIesDIE3WkCU3D7xZTS8pdSxD8CeLR2TU4OjQQw77mF0hqO057TYScHmIZP7RYlKjmR3VqHlzkYS170IK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730234755; c=relaxed/simple;
	bh=oxvcO/ZaB/lL61u8pEJ51NobI8qaVVYlrPTrDOUpHPQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eGc0+QD4pldzVA+C+JCfKkPKTwEZGjzpWkBom1758R1K2wwuYAAN6nt2pWarlJ3NtxFvLJUgBTBq7VqtIRftzFU40eUxpdUW9n7NHjvn2kgxtzCadq3LmyIPy/44RMw4w4DgcvZvAdnWu5jtpT5lhNqkJ+V4EjPQ9zip3gr9b+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pd8bUOpU; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e315a5b199so107896497b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 13:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730234753; x=1730839553; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pKjGAeVoY4GHFtcwq5banhGcJjKwOgTAegNaQaox++w=;
        b=pd8bUOpUpARD3tcU0bwU12p3PxGCDqoDAszXIIqwYhYs7Bqc7QY1iLPZUnZw2yGNyo
         liUPo980BUweJNRqeACnmtcMMkhI6WvV9VP+qzzEKJt/gfBBmJ9AaXnXowunn2QLiyXO
         /d5HBm+pX0YsX7sobJsvzOB8/fl1NsB3RUMeBol5EpE8V+EGt1GhvZors7y/0L2qSAje
         T3XGtUKjuUwqN2rucag9C0dQDTqWV5tvLCQH8Qu3mrnLUjylW3xO/GWqT1WNtZU9dCQC
         czSVTbLpIVvC7GOlMHnTgn/y2AXD6Hj1CABV3sjpA/6dnJoa1R9aq+fUSZnR0DAiAEPW
         EwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730234753; x=1730839553;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pKjGAeVoY4GHFtcwq5banhGcJjKwOgTAegNaQaox++w=;
        b=lQAmy2HUKK1DLfkWWRWim4xJJdZP6T4+ZX5p8Zy/Z29i2T8qDcZOkGQKfTmH3gNNY4
         ao9XfcLHf0NxHVE0Qyk5mGNEQfN8yBBX703p46q74eXtfAhpt9fxbMcKnF7BICu2vn1m
         7/OcmVXE/ZkSSZeGXpAWCdEolbUt9z64OHS/0zwGSOI4GSCQsznkS2le0bb7AKqBesvB
         vKW8M4EZZO6OB4f3f9xqtrxWrArdzLV7j35wZFGEH2ilY8lRJzu0SFql8Lwzzx7YQ/a1
         xXPTSdB2QMvC9k5PlqI9SmV7p9vIch745gIiGWaJbzVxBbaxvcsReiVW7TO9cgM51UDi
         ZKUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOIGEQSsAfPq/kmMIafR7V4DboSy4mhFRme/BYQsAvB8OF1dxIbsEveL4N4dKX+V9+pCPjahHfuQUUOg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuHNTDK+Cbum9c8V4B9H+LRizd9AGDtNYFgqjGHk4K/T3p5Lyf
	ZDcRUajeLVIdZlWXw/ytMzQw8B/3yBJpKvQYAwbbqDXoUj+GkcqTM+EQlbxAHu6aiIKdbB1/L3H
	o31CW3sjAaW7Z+NSJvyMoyw==
X-Google-Smtp-Source: AGHT+IFriD3g24XyT1jM0DrGKfcuWZDYLvFnWpLS3cNOCFhL6xGL+ZOplvsxqtm8XLZC9n/DUx7QNPgLv1gz7vx1pw==
X-Received: from almasrymina.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4bc5])
 (user=almasrymina job=sendgmr) by 2002:a05:690c:2c85:b0:6e3:14c3:379a with
 SMTP id 00721157ae682-6e9d87a71camr2100287b3.0.1730234753049; Tue, 29 Oct
 2024 13:45:53 -0700 (PDT)
Date: Tue, 29 Oct 2024 20:45:39 +0000
In-Reply-To: <20241029204541.1301203-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241029204541.1301203-1-almasrymina@google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241029204541.1301203-6-almasrymina@google.com>
Subject: [PATCH net-next v1 5/7] netmem: add netmem_prefetch
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Shuah Khan <shuah@kernel.org>
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
2.47.0.163.g1226f6d8fa-goog


