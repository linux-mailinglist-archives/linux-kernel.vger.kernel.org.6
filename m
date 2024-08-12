Return-Path: <linux-kernel+bounces-283333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6360994F0F5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 16:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAB50B23D67
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D586187332;
	Mon, 12 Aug 2024 14:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="PIv5ZcAE"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AF0186E5B
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 14:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474633; cv=none; b=RxhjhWATy/LLirznqEduLbdZFUfC4mNa+0bg2GNfpjmgGIXLwVO4pY467Lh/gdVFM1HN559xchUa3QTbLrw0eHzTtkczom4vM8OwHEx5YFzbTEk10sM9ZilsZuqXSJHiDjByxvjYtkIJa5jfq0zre6/IVqEJVsuF5JYlEHSYFKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474633; c=relaxed/simple;
	bh=engWj6aKpokwgpyXiw7CBwh7X6sCJ2Bs/kMc9vpl9io=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u8K16pyocLtsLgoYhCEkBK7hoTBf4jY/nCiArLXj4mNkEBf/QXT1QdEk3mRGJRjrNi/qiOlplXhRForaL3SfAURqnPoH9NUOSgkDdB8DRaCqLG7mPCS15HUU34YPuDeQyIQtD8GdLH+lj5q3jdv932zyJVGXcrIFxCIwyNG1Q/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=PIv5ZcAE; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fd65aaac27so36642385ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 07:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723474632; x=1724079432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNdFpdWlE48RXxg9UImVWM9Gm44fXtqN26asQqpjAN8=;
        b=PIv5ZcAE+hzMIwUzA76X/OHZY8HzfWCiIq9iBnpFgI/SNroekB8X9Rw/SfA87SzQOK
         drfw+D2fu6AU7+7SskYbrLFARhsPnPHvhEG2ZOJ/kvacg+u0lrgkEmHSW/mYWRSx7c4Q
         bcGxYS+FH98OM+ohoQ0sNKlky1sqmDoGH4Inw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723474632; x=1724079432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNdFpdWlE48RXxg9UImVWM9Gm44fXtqN26asQqpjAN8=;
        b=Pj9hZfs7Z/LgQdWJ+8/43lFK6FTb0f6ftfKwGLqk/ZX7VKB+l3eJVqqwhK28CGX0rW
         p41aw5R6REkhpJ5sGcx+ayURtoMBq3roycPkXwcFF4O8KkSRLsxj/Rtx41VaXyxkDyXE
         pC3dOLJ1/2mhL5YP6Avh2F9t4jrRuKYGmSSrmjirGVZ1Tf5BUXjdtX4L+pb+FnZ4BBHT
         sFv0abSyzRvREm046LbtVdO2pGpH3JtynD0ImADgn4WdrUR9o7n6ERuW2KNSwpv/5T7V
         jQxYRDrSbvSgobypO86wq0VND1MnHaDHvTzzPB7bLxFFJmdG+eY8yisF7GGeE10khyHS
         6meQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsavrqWdWvNG7cOKy5xbaCz9AIhG8VjRYTNzpOZ3Z3Al/ZTUDabHQrCvl3FzznqHZTvqDgJHveJJnb388XFzLZyrm1qvCAe/Ffll/W
X-Gm-Message-State: AOJu0YxHREdo2o48AaHGDKLzV1WVT16emvIe7xQhRINvsFwmp6IMueJr
	TxVlslOY1I8L0cu0POsxEnTgSoQrydveF2QXKBcnpdzIicttWX7azuvmPeZqYCo=
X-Google-Smtp-Source: AGHT+IGFUCfRefG7wAmf5ZDyJMJag39OJ6iIfluMa7A4Bgkrj1RT59JVL+xgUytd9tdtjDfEBNrsIw==
X-Received: by 2002:a17:903:41c8:b0:1fd:74ac:e6b8 with SMTP id d9443c01a7336-201ca90ec88mr5485365ad.7.1723474631777;
        Mon, 12 Aug 2024 07:57:11 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-200bb8fd835sm39006955ad.89.2024.08.12.07.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 07:57:11 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Shailend Chand <shailend@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Ziwei Xiao <ziweixiao@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next 3/6] gve: Use napi_affinity_no_change
Date: Mon, 12 Aug 2024 14:56:24 +0000
Message-Id: <20240812145633.52911-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240812145633.52911-1-jdamato@fastly.com>
References: <20240812145633.52911-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use napi_affinity_no_change instead of gve's internal implementation,
simplifying and centralizing the logic.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 661566db68c8..ad5e85b8c6a5 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -298,18 +298,6 @@ static irqreturn_t gve_intr_dqo(int irq, void *arg)
 	return IRQ_HANDLED;
 }
 
-static int gve_is_napi_on_home_cpu(struct gve_priv *priv, u32 irq)
-{
-	int cpu_curr = smp_processor_id();
-	const struct cpumask *aff_mask;
-
-	aff_mask = irq_get_effective_affinity_mask(irq);
-	if (unlikely(!aff_mask))
-		return 1;
-
-	return cpumask_test_cpu(cpu_curr, aff_mask);
-}
-
 int gve_napi_poll(struct napi_struct *napi, int budget)
 {
 	struct gve_notify_block *block;
@@ -383,7 +371,7 @@ int gve_napi_poll_dqo(struct napi_struct *napi, int budget)
 		/* Reschedule by returning budget only if already on the correct
 		 * cpu.
 		 */
-		if (likely(gve_is_napi_on_home_cpu(priv, block->irq)))
+		if (likely(napi_affinity_no_change(block->irq)))
 			return budget;
 
 		/* If not on the cpu with which this queue's irq has affinity
-- 
2.25.1


