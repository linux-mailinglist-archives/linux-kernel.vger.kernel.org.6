Return-Path: <linux-kernel+bounces-169955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6835A8BCFCF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C0B91C2177E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A6E13D255;
	Mon,  6 May 2024 14:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="phcptJ2Q"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA53413BC04
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 14:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715004904; cv=none; b=cYP3giym3o3XejDgqja6joyYBb2KG4DNQ6nYYMcYIgH0bggY4OlNGc1Fqx3uouJhGOdoS/ve0k5oNbgj/uMKLLzU6rQE0IfvFzvS2uZmPNOPhfqsog4rHGnlvq8CoFVGQqMcBhIo8Zzcq4f2tMkeABevFWZfGbCEvIW5a4jF/s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715004904; c=relaxed/simple;
	bh=wcidanXZQTb3aE8biUO7m9uGWdjY9fC00+u5PTnfNfg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oXqLwEFg+LUAeOkbCtl5IS/bQRnZLJMqMJw1zcIMaI6qy/6LE9vGC2wkIvvcj+XV5ve0pC1cOcUjMG76I1TerILiPtwwQqDuwlDX/fAnadKGAVJkGOv+VtCQ9eSN1x24wMuNO82xqXN36vfcA0MRzbP0AU6ESHPp3sGPxOGT7Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=phcptJ2Q; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7F5723F298
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 14:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1715004894;
	bh=ZyaYKGnkDPnTk6rgEgUZ2eoc97Zq0+zWClbbP5jrG5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=phcptJ2QVN0G8jM8cNMMBXZ5gNfWBLDEoemhGjO0tdU90Nb3ykM8qrXT3sAjsxcpr
	 KREGP2NgUd6/12S7lw8jJCPz2dG2vx6r5sJdR4sr5UzGCFp7HCyzSNiPcSuWowiNiP
	 NkAXKTkYpHInv2dEAo1VPpGQYblhUWHpQIs/SoU3gSebJOSBbigY0CPFItPAPdE/R4
	 eFtGOVo4zZYzW4u7xhq/hAba2J2TS3M3aBGduEP9kw4VZ94PnHbwPnt4L1AFo7BcOx
	 RkIJ06U88vNhmFzum63uBDrQQrvJ6vlr9OuEoVsrqZqZdV0Q/FBULMxdJDiWtRqAfc
	 0DljOOaRMjI/A==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a59a17f35c8so123115066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 07:14:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715004894; x=1715609694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZyaYKGnkDPnTk6rgEgUZ2eoc97Zq0+zWClbbP5jrG5Y=;
        b=TP1Ah07zN3/1GhmtwaKKbAl2xRhU5r+rX+f2diZdOZUD3UvBKwaucdnMZDmctOQZ9s
         MlcIrdRZKwfuTD/xyJRWKDTWP8E/rNaE9mPp4GRVptb0lYVmrwnuUJUEidoH3nZezPZB
         Z3uW9nvTXnTV7aLWjmryxyk6wZeeYbgCreOaT6Dp6HAkMfSGH+DyEsTVBS+ycvSD8shE
         Eh6P1L7xkEgYcgxWqt9cpBsnYaVaggfGemOcQpVX7bhcVnlNp2SjcKF+6k88/N/Bm4mU
         uFw6JaeGJlMJ0E5RZhFyLEpvHXW1Sz2NdBaqPKmWXMYnGgELjyuwDvrIPsXAADabVUG+
         Hl3A==
X-Forwarded-Encrypted: i=1; AJvYcCV/u/9itigu8/d4GgjcexphRui2QwO1Qpoah7w2zAcdEnlWG1Lj9bWEU5XCbpY5KKCYhXS33CuY07sMhRh1iPcbMtTY/yu8AAqsN/iU
X-Gm-Message-State: AOJu0YzNybEV8Igap4noqrMkJ/IiJOfPxBl1k2vjw4s6K3ttb/xjY3VQ
	1halXnozrBvC1fzpruftA5IEb4XsvTjRY7s1hymkKIdawJRdHkBWYSF47cG3El0EnJFWilU5MAR
	9FOlMVmIMy+I362PPTrUf/SqdZiWSfYXGVXSO2Mxy97monaYWPc5Adf3vzlqs5wTSLq0TjJ+zWB
	0Pag==
X-Received: by 2002:a17:906:4899:b0:a59:bfd3:2b27 with SMTP id v25-20020a170906489900b00a59bfd32b27mr2701618ejq.70.1715004894083;
        Mon, 06 May 2024 07:14:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEk/9m6RYfEf0M6hlNPk6/CFatHUn4Rb6d03W4Hp+pLLGOwdF9b9V1H4mNBZdkFpbMX/boBAw==
X-Received: by 2002:a17:906:4899:b0:a59:bfd3:2b27 with SMTP id v25-20020a170906489900b00a59bfd32b27mr2701599ejq.70.1715004893754;
        Mon, 06 May 2024 07:14:53 -0700 (PDT)
Received: from amikhalitsyn.lan ([2001:470:6d:781:4703:a034:4f89:f1de])
        by smtp.gmail.com with ESMTPSA id xh9-20020a170906da8900b00a597ff2fc0dsm4663754ejb.69.2024.05.06.07.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 07:14:53 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: horms@verge.net.au
Cc: netdev@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Julian Anastasov <ja@ssi.bg>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>
Subject: [PATCH v4 1/2] ipvs: add READ_ONCE barrier for ipvs->sysctl_amemthresh
Date: Mon,  6 May 2024 16:14:43 +0200
Message-Id: <20240506141444.145946-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cc: Julian Anastasov <ja@ssi.bg>
Cc: Simon Horman <horms@verge.net.au>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>
Suggested-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 net/netfilter/ipvs/ip_vs_ctl.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 50b5dbe40eb8..e122fa367b81 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -94,6 +94,7 @@ static void update_defense_level(struct netns_ipvs *ipvs)
 {
 	struct sysinfo i;
 	int availmem;
+	int amemthresh;
 	int nomem;
 	int to_change = -1;
 
@@ -105,7 +106,8 @@ static void update_defense_level(struct netns_ipvs *ipvs)
 	/* si_swapinfo(&i); */
 	/* availmem = availmem - (i.totalswap - i.freeswap); */
 
-	nomem = (availmem < ipvs->sysctl_amemthresh);
+	amemthresh = max(READ_ONCE(ipvs->sysctl_amemthresh), 0);
+	nomem = (availmem < amemthresh);
 
 	local_bh_disable();
 
@@ -145,9 +147,8 @@ static void update_defense_level(struct netns_ipvs *ipvs)
 		break;
 	case 1:
 		if (nomem) {
-			ipvs->drop_rate = ipvs->drop_counter
-				= ipvs->sysctl_amemthresh /
-				(ipvs->sysctl_amemthresh-availmem);
+			ipvs->drop_counter = amemthresh / (amemthresh - availmem);
+			ipvs->drop_rate = ipvs->drop_counter;
 			ipvs->sysctl_drop_packet = 2;
 		} else {
 			ipvs->drop_rate = 0;
@@ -155,9 +156,8 @@ static void update_defense_level(struct netns_ipvs *ipvs)
 		break;
 	case 2:
 		if (nomem) {
-			ipvs->drop_rate = ipvs->drop_counter
-				= ipvs->sysctl_amemthresh /
-				(ipvs->sysctl_amemthresh-availmem);
+			ipvs->drop_counter = amemthresh / (amemthresh - availmem);
+			ipvs->drop_rate = ipvs->drop_counter;
 		} else {
 			ipvs->drop_rate = 0;
 			ipvs->sysctl_drop_packet = 1;
-- 
2.34.1


