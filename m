Return-Path: <linux-kernel+bounces-248829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4167892E27B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C83F0288C4B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99CA1598EE;
	Thu, 11 Jul 2024 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvjR1rlT"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE7A1591E3
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686795; cv=none; b=ILxMOStUDr3Zi45MmkvEZMIphQ359hQWqtaMTXKtZ308yrFGPuqZCX51IZvwsAiiYcNdNvw1lff8Brq6nWCzdMzElSe+LB/WAn4vD47tgub+9k5x3t6JVybcc8FGJaVSQwMSpqeyHpCbQXJpa3HROjCzAa4s5Mh94E9yHNmajts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686795; c=relaxed/simple;
	bh=vCOvyNzKA8bCtc0SbgBRetwo4tHTryBxKi0JZDvdgD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HK7CYk4CoZtZsykCgfMZMFmOlJCfTFhDhyYEvoAzS8JiuuMYcHV92WUyKQLNyCBVfAXu9a5huakqNqWGsbBpXbpbuTVPZStV4OcqnqdARV06iXPCjSJzVD0wjXYEYxWlnaE2qbgRz13OWakdjLk1T/WHvZLKtOy+mCjCnCM6KMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvjR1rlT; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-75c3afd7a50so392120a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 01:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720686793; x=1721291593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+0PQwW1AxmVF+MJISq1WtYnL1Jrp9uQlNNJlzSID7I=;
        b=TvjR1rlT5CTPkVavGFxwtHINKPlLpwicjV9tAmn8Fcw0jukDqz21T3nzbqacuJTmVk
         Y71WvXbxfk3SCsAS2QaroJw684CMrhUOYnLKvfA60qsQP0N2GQd9J5i88k0mv9ESh4GS
         ifNZ7Vff8IRjJ/7PcopZRUzZ4ZuzgaAARv1INWn+DFAuPaxJElou3XD5iqGN//X8eckx
         iGU9nDpCQJoRW71Xy4dFk6SBtG2Z6bzXcAvdaSYuw+KUfgLEzB4qT7KFLNFUujIEB38B
         hcD9Jfr+Xs6mfXkoYBLtC7gQvJkro3T6/v+FwBuxJLv5Bs8gzkw2Vffxqqc0OCK2oDD8
         hNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720686793; x=1721291593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+0PQwW1AxmVF+MJISq1WtYnL1Jrp9uQlNNJlzSID7I=;
        b=fsju0LhGS+831w+KqzDZKC7Rfv49d53dAy0HMBogdEVE8gsHdNopQNU4U2+/NmFg7N
         Jnp3nJ3I8RlE7vDI/1tN7YZjxbzg7/eBK6YYQfXDkYOyO/RBWWKW36bbZ5Xw9N/u3p+4
         6TgU6w80TLF2lcNq7zxIxA8DUe1Wt/iH9pbFV0fyB8c00T4tnJGa+152zAte1P0+0wd+
         P/Q8QgC5WtKlGP+cU55sujZdO1ioVksRadXLIeZcj6ZU6p9S1CmWAFhIVCsgQusl8XAz
         Lx/3sSc3Ysn8zsGCRR8joGMfNUsH0XApbQ1UqDk3KPCG/fEJ1BDO5RAjnwQ1DadYVUZF
         hZYA==
X-Gm-Message-State: AOJu0YzLINhjrjV5D774EvFVomlVdxa16QUO9HamjS3tOwfMwACx8Hb5
	gVPpFTJzeUDEp0NCOdWMcEsNYc6Y9MKGYpoVkcLN2R6CZ15YlL1lE4ikuA==
X-Google-Smtp-Source: AGHT+IG8hAJPGIC/WU9yx3qiosr2RJRlyhoox18PiRS1uw+U0/MzUu5tCtRznOzLFyCPwO3L4Ntz8A==
X-Received: by 2002:a05:6a20:729a:b0:1c0:ef24:4125 with SMTP id adf61e73a8af0-1c29821e49dmr8930873637.26.1720686792559;
        Thu, 11 Jul 2024 01:33:12 -0700 (PDT)
Received: from localhost ([198.11.176.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a123e0sm45443365ad.26.2024.07.11.01.33.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2024 01:33:12 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 4/7] workqueue: Remove the unneeded cpumask empty check in wq_calc_pod_cpumask()
Date: Thu, 11 Jul 2024 16:35:44 +0800
Message-Id: <20240711083547.3981-5-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240711083547.3981-1-jiangshanlai@gmail.com>
References: <20240711083547.3981-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

The cpumask empty check in wq_calc_pod_cpumask() has long been useless.
It just works purely as documents which states that the cpumask is not
possible empty after the function returns.

Now the code above is even more explicit that the cpumask is not empty,
so the document-only empty check can be removed.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 64876d391e7c..01d5ea1af60a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5160,10 +5160,6 @@ static void wq_calc_pod_cpumask(struct workqueue_attrs *attrs, int cpu,
 		cpumask_copy(attrs->__pod_cpumask, attrs->cpumask);
 		return;
 	}
-
-	if (cpumask_empty(attrs->__pod_cpumask))
-		pr_warn_once("WARNING: workqueue cpumask: online intersect > "
-				"possible intersect\n");
 }
 
 /* install @pwq into @wq and return the old pwq, @cpu < 0 for dfl_pwq */
-- 
2.19.1.6.gb485710b


