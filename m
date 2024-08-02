Return-Path: <linux-kernel+bounces-273142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 755099464EB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 23:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0642B220ED
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 21:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7F88248D;
	Fri,  2 Aug 2024 21:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Soc88ApB"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE9358ABF
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 21:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722633537; cv=none; b=aBc0jP9N0ROi6KHvbNQZLp06E6PU3l5e0goDNqCPHQR304pcJTuJdZMI2Kq+G+X6T7weUWIwgSZsuFoQu2XSWUB30IugzYan3jxXxgjrBuy2cVQJ7eZDUGk/lab7ev3anHOZsQWKqOctLSdPr16fPMtwvQ2K3T9YcGqgBSBU8vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722633537; c=relaxed/simple;
	bh=jR9JLCIpPBTxrA2g1tnT2Z4SJYvdWa9inAiy4X6ICh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/UJpkslyTyZK5Vvf7OskXFVnDu5346ymyAcph6IHIn+Fmn7QlFc4RNpm6nrDQAi2iQeaZb750GwEDOIpWv7JR3nsMlGv5ynpnTVh3/tZrQZo1LVQfeAeTXBj1xh+mechE/id8ukF8KHdUVCKmIoRezLZMbc3zDp5/9wFrQCt04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Soc88ApB; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7a115c427f1so5481664a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 14:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722633536; x=1723238336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzD7yuzRgyiFMTNCfy2NddFgKoL5Zn+f0nhxpE7pTaE=;
        b=Soc88ApBAfJ2mC/Fe9pQjaQ23rk9t4kczTJRUhDwZWFUh5CzsEvQ4MWUczUEf0eeTi
         beGqV79fgoEWIpOJSmfo/R7AspxZv33X534WidR+i4WpNo55XYQKGE5ngOxGgL7EEpNG
         JaI5AgFtNqCNZTrzwW4orc74FP95NzrxWVxcnvyXrQ54BTQ0cOLt7kOOYF5Q0HniDUeV
         AkM/Vv/9xG4OUdSy0jAii9IjVq0X92pRGPFvggHDaCv0N8s6MnEaqxu9h5adyNmlsKzt
         RNt65877yQKZTOKqkhjzuI9ZCKxAU/COnBmRvCqHOENEY/riGtc+Tt/CAUR0JT3elsuB
         gvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722633536; x=1723238336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bzD7yuzRgyiFMTNCfy2NddFgKoL5Zn+f0nhxpE7pTaE=;
        b=pCdwaXCuEfaYmfrTqckuKNn9ZCZDJuas/QoewfTLqodG7+u/fsW9gWCbu4kyVbpMrE
         0Rs7h7VtkrkJe+/cF3lPr2n19qp4GpF+1e/081nZj0S5WbnQH6yjRdRYQQMNsNvyozPC
         QXQlSx+KCotqNK1+bkZ2sc1c1dVQs1z6dCvzoL/NGpwSj4CySj6nP3YsvaSQ/Nn7NkbS
         gwR3sf9sR3jTkG0R0i6cE8SphuUQzZiUNP23iJjqbnWYtwmH/A4WV2u7d2hued3jq4vq
         qXY/9p2PtQYgPBO9/3h0UXNXwL3GPf8oSAOeaBlbxpiOdZL/62R+W++eXRHhpuG71f7b
         UxQA==
X-Gm-Message-State: AOJu0YyCIE/4638sFoUpvZyYZJtNzyUKhzLg4zawn0GbUfqV1l3pg4Wl
	kcRHnxku/jGbNqWqHEuVZ2MBqha2hU7+uYB8xsDW5to63Q6btQFm
X-Google-Smtp-Source: AGHT+IFUosaRpMGuihCuriSb0a7c403iQsRbPFHtJ3BAb8Xai6Kfnr3wYvqw2tpHQ/xsvTVVa04ucw==
X-Received: by 2002:a05:6a20:9191:b0:1c4:8293:76d0 with SMTP id adf61e73a8af0-1c69953c7camr6516653637.4.1722633535722;
        Fri, 02 Aug 2024 14:18:55 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc432b16sm5633905a91.21.2024.08.02.14.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 14:18:55 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/4] workqueue: Make wq_affn_dfl_set() use wq_online_cpumask
Date: Fri,  2 Aug 2024 11:18:17 -1000
Message-ID: <20240802211850.1211737-2-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802211850.1211737-1-tj@kernel.org>
References: <20240802211850.1211737-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Other unbound pwq update paths are already using wq_online_cpumask which is
protected by wq_pool_mutex. Make wq_affn_dfl_set() to use wq_online_cpumask
too for synchronization and consistency.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index d56bd2277e58..6571e1f3c835 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -6909,18 +6909,16 @@ static int wq_affn_dfl_set(const char *val, const struct kernel_param *kp)
 	if (affn == WQ_AFFN_DFL)
 		return -EINVAL;
 
-	cpus_read_lock();
 	mutex_lock(&wq_pool_mutex);
 
 	wq_affn_dfl = affn;
 
 	list_for_each_entry(wq, &workqueues, list) {
-		for_each_online_cpu(cpu)
+		for_each_cpu(cpu, wq_online_cpumask)
 			unbound_wq_update_pwq(wq, cpu);
 	}
 
 	mutex_unlock(&wq_pool_mutex);
-	cpus_read_unlock();
 
 	return 0;
 }
-- 
2.45.2


