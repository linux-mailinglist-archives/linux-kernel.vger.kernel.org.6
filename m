Return-Path: <linux-kernel+bounces-223280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C55939110A6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 813C128D977
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB84A1B29B1;
	Thu, 20 Jun 2024 18:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v9QoiZzN"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F84376E9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 18:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718907462; cv=none; b=WT5HkEOXceCwu8/qyf4zYfdMC51Jud9X0aotUHd5nawJjoDHUrKZKgC6b2x0oPWq7kF7hBuAU4h4PUGJx5UlNWGRI7VFt4PIAlPgWFfZPQWPpm555ywe233gFMHp/+pxp+f0lKD0CkmPJ7KoqOd14o5phzb3b3ydgywSKL7Cvl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718907462; c=relaxed/simple;
	bh=iY15znjKwXj/mYMfmF3+a0bhsiOgCwhdhV8LAVnf6/I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kgrX1d2usQbXE1PzmdAo+NGclXcpd6CxRKqHuWyJ9HAJ1BqD6Z7xWw1IqG2jmzdouKRR7wJGTCEXPye8DowocsHnGYI/Ag/nYch7F5KhvD9l8/Qv2IZRqhqFP2lPiss8YTlK5QS3lP/NRk89WZ0KbxxPeKPGRMsRDCwDzYg6EE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v9QoiZzN; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yabinc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62a3dec382eso14204947b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 11:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718907459; x=1719512259; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=txPbdh0UwgPW6j6zme2yNhfuJXXQO0kUOBEsBGdoZYA=;
        b=v9QoiZzN57lzQJCCCfz0AOWbSagaDStYUvrR1H4TY4PoItcKCswu7i0v82fFrV+AwM
         KmxP9NcCkIrXh+S7BkKvZKoefo7YXjYb3TSmdo6tXCPYJAOYxfYUMxwJMbuBsXq6ubi8
         T8cGcabCqejs4nwlevAMGsMC0DQ3ublsil0RQnBPuYkloi9GKLSBCvI2YjFz+rUHxkLJ
         HvNueihGWB9nI8OOOe3M+M/XTKHwVBxZWgYDS/XbrRPhVA5Ji/ji6T5omniT3Ql5D7o3
         S+5tmlQVcSM6FiFN7/q1k++sqtenTSgEPJUY75I+p2RmIOzsxUN7jbRTD3fe3zXa4IIz
         DjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718907459; x=1719512259;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=txPbdh0UwgPW6j6zme2yNhfuJXXQO0kUOBEsBGdoZYA=;
        b=sGjPnn/ghZfFC3VKd574dRQw9NjyZXqVE0eda4leV9P94X9WQdNPBQ+MGAF2ilI49N
         OuK1VjYT9MLEs7Bpbeluau8dn7IupFC7VOQMl89VHrQVnds87o7NdjZ4vK+ZhfkcFS30
         EQtJh0yCUywIu6resNNeVQx+wR/eFteV+T4xbyiZJtjWTphF/AfSZIy+i5Whdk3r2AKP
         3gaL+oXCIhFXhr5Mscqh0bJuHWyg5lWjXwbkN7be1uU3/tKIUlqJRONSlpt56w7XPlyX
         LspUvMRJKHo9+daWjWbEbUoALvpQM4QTqJYBhx4qtP014bkH3mKO8XmoS9PI99o/dMSL
         JqdA==
X-Forwarded-Encrypted: i=1; AJvYcCWk10xhQddE63lIqZtvuYephac3pO1lKpd3C1PtTvXQ0fN6oWXr6Klj3KtZWFwW0gntvt/qdvi5zv3KtMGhqP+GjmdUuTFwMvzloY9V
X-Gm-Message-State: AOJu0Yz7hbDCYjij2Ym9qpEY5kOqtwsL49iMDAsrPcof4GdWYJaumkhX
	Be+Wsi2sWpCPnnDNfSsmLHSC5hOihfYgORGvzsI583JNIKF3HCyuGbMXPE+k9j1iNR7Iv9dYscz
	R
X-Google-Smtp-Source: AGHT+IF8GVDMyvGZpRp4boOIOSvfLSv3xxNhz/7qXqDIgZdXB8RVhwD0g/1O17E1anqM5aheujLEfMzdr1M=
X-Received: from yabinc-desktop.mtv.corp.google.com ([2620:15c:211:202:6cd4:2b82:abfb:6e47])
 (user=yabinc job=sendgmr) by 2002:a05:690c:30a:b0:620:32ea:e1d4 with SMTP id
 00721157ae682-63a84340c6dmr12853057b3.0.1718907459308; Thu, 20 Jun 2024
 11:17:39 -0700 (PDT)
Date: Thu, 20 Jun 2024 11:17:36 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240620181736.1270455-1-yabinc@google.com>
Subject: [PATCH] Fix initializing a static union variable
From: Yabin Cui <yabinc@google.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Yabin Cui <yabinc@google.com>
Content-Type: text/plain; charset="UTF-8"

saddr_wildcard is a static union variable initialized with {}.
But c11 standard doesn't guarantee initializing all fields as
zero for this case. As in https://godbolt.org/z/rWvdv6aEx,
clang only initializes the first field as zero, but the bits
corresponding to other (larger) members are undefined.

Signed-off-by: Yabin Cui <yabinc@google.com>
---
 net/xfrm/xfrm_state.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 649bb739df0d..9bc69d703e5c 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -1139,7 +1139,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
 		struct xfrm_policy *pol, int *err,
 		unsigned short family, u32 if_id)
 {
-	static xfrm_address_t saddr_wildcard = { };
+	static const xfrm_address_t saddr_wildcard;
 	struct net *net = xp_net(pol);
 	unsigned int h, h_wildcard;
 	struct xfrm_state *x, *x0, *to_put;
-- 
2.45.2.741.gdbec12cfda-goog


