Return-Path: <linux-kernel+bounces-193039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 141D38D25DC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:31:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBCA7290F99
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904DD178CEE;
	Tue, 28 May 2024 20:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Ys3Vy5tY"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AF81BDC8
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 20:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716928306; cv=none; b=lDTrTHwyxdzvB39Y9BHDHpVllhMa9JpMoqty5NzWfjGnc0iWfFy4cYcyby3IYsAfADsorV9KL1q/SWdhgonpohdIXICZEee1bBIlJZbgQ4iHiSALevBWl2HCKlTEyWYsKE1TDscyIM2Wt4/ni+OULUnNmY3+gSVvgvWuIE68owk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716928306; c=relaxed/simple;
	bh=oblZ/JTQxlj5nkQ5Ex2QlXb1XgfBCE8NUSpuu3Lenlo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=KIorr+393IKAbSDc1xomHHswWYnkHGbnd7fU65qUS5IRpTQf14ZEOD3XS1DWcxd5W65kg2OKcxtf+0D0ozync6SMWcyn1Uhsof0DPA1IjH0VykOFREM1u0WJG1vMA6wr1ElQDe2heI1P63B55hlnA6s7nh5wPO+ihjGi6tarDwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Ys3Vy5tY; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8B2013FE59
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 20:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1716928293;
	bh=IC8F1IBDMNj4lM1onkGOFqfxQKQc7xGwIx33j3RwCWg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
	b=Ys3Vy5tYH+Cwm4hVvGV8t5NtY3PEjAbjCOlbwo3MAV/FLncCnru+xUXRRvNWxzrnb
	 5v+b71a/UCMeuvH1M8fNZxbcdTFa/g2hWuO/YpTr+Z+3Iax/E/8+b2kIsTdRKt6Rdw
	 PxJri5ejrjCK+LjmnL5Xi/prHxU2M31wZHJuf/ImfMZTcgFvP0mnffqGNStxioc5uZ
	 EdVjyoEk3EP0gFujjKNjoBes+G+ixZTqOXU4uEV2WfqSJgHRF5u4Sx2I9E4db6/S7M
	 2CTpduq/dRH60DtobWR/tXZq9fIzRQaQ0AGWeJ0SB7zK1221EMEW9WaXxcX04y97FG
	 8Xf8xoomAmEyA==
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4212283a4caso1153125e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 13:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716928290; x=1717533090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IC8F1IBDMNj4lM1onkGOFqfxQKQc7xGwIx33j3RwCWg=;
        b=E9baRoGGrN6pX1EnvdXlzNotcc6DmFkWQtpsy+W9gprlLFWNi60BJI/EUrKzcSmUm2
         YQJ6NmEGpAo9KIsyXCcDk1LmcrUh9MkLGDYSmu3ItdanhNnHhCSK6RBm8lUPpb2jpfRH
         rfWMFLWXhLwxDNtnoQ7fiTwkXNo81OM/9B4l4bS4H59Gk7zuA/yeI1TCXZvXaYLNAoyu
         KSEsEZ8uXQqFFyjqVloMmDGQbIxPRLCarvWFpsEQAnwam/Jh8TcR23nrZJp/egmTVxh/
         xcM+J+ky3oXC1jz+M9J6AEWtjQHCqTRE0OW7F+Hge/kpHIBc1Xv4KCW/Emgh+EQ/SfSe
         bsnA==
X-Forwarded-Encrypted: i=1; AJvYcCUw3JXQrRtL8M2gP1K3CHgzlHUikll50qvL+9mdcNXtxyqtWrPAr1s+GbE391aPqvSYBhACJbyWEYWExAxFeXAlfqyEyEf5Jhe9qKDT
X-Gm-Message-State: AOJu0YyNgHm/X4Svbqbb8AEhBHm0Ng2xDgnkMc9gljZZSmGSYOrMQelD
	QiTtdgVnuGCABZAk6BvRRHZM6DekxBz1e/4pQ5VMVRIS3Ym91VjeYeMbdv2YMpCuxWR3tGrGMmu
	THgmVaLOvqBTrNph5tfXVJByWI5GwAHQ3s4kZtVnfWVf5z0PDPkOEw5/7ym+q8tymW+a6tosHkL
	TLxQ==
X-Received: by 2002:a5d:584d:0:b0:35b:6448:a540 with SMTP id ffacd0b85a97d-35b6448aa06mr2143208f8f.50.1716928289853;
        Tue, 28 May 2024 13:31:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyKEMlOnAEOn4VkWAIqpyfXQeqsB342zb3Gbu1S19iY7Y1uwm7u8SfWwlN1fOGq0t2YwHXlQ==
X-Received: by 2002:a5d:584d:0:b0:35b:6448:a540 with SMTP id ffacd0b85a97d-35b6448aa06mr2143177f8f.50.1716928289370;
        Tue, 28 May 2024 13:31:29 -0700 (PDT)
Received: from amikhalitsyn.lan ([2001:470:6d:781:68d:934c:3a6e:3fcd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6331034f82sm142199966b.142.2024.05.28.13.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 13:31:28 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: edumazet@google.com
Cc: kuba@kernel.org,
	dsahern@kernel.org,
	pabeni@redhat.com,
	stgraber@stgraber.org,
	brauner@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: [PATCH net] ipv4: correctly iterate over the target netns in inet_dump_ifaddr()
Date: Tue, 28 May 2024 22:30:30 +0200
Message-Id: <20240528203030.10839-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A recent change to inet_dump_ifaddr had the function incorrectly iterate
over net rather than tgt_net, resulting in the data coming for the
incorrect network namespace.

Fixes: cdb2f80f1c10 ("inet: use xa_array iterator to implement inet_dump_ifaddr()")
Reported-by: Stéphane Graber <stgraber@stgraber.org>
Closes: https://github.com/lxc/incus/issues/892
Bisected-by: Stéphane Graber <stgraber@stgraber.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Tested-by: Stéphane Graber <stgraber@stgraber.org>
---
 net/ipv4/devinet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index e827da128c5f..f3892ee9dfb3 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -1903,7 +1903,7 @@ static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
 
 	cb->seq = inet_base_seq(tgt_net);
 
-	for_each_netdev_dump(net, dev, ctx->ifindex) {
+	for_each_netdev_dump(tgt_net, dev, ctx->ifindex) {
 		in_dev = __in_dev_get_rcu(dev);
 		if (!in_dev)
 			continue;
-- 
2.34.1


