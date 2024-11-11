Return-Path: <linux-kernel+bounces-403847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 041A09C3BB0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 11:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58B3AB20B19
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 10:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE825176FB6;
	Mon, 11 Nov 2024 10:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emlbnqrB"
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42E8156256
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 10:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731319699; cv=none; b=C2dXu54OUINb24Abk8XsoUDqYe7DuXXfxq2+kwqwhAXQA3vym7I3jtt714urNQ5H6sGrMp5jOUYyuGO9JpfHJE36ug9YURxREcUWQrbqGuzOc/QUgP+ULUNgVIi82JXesY6xGeJyBydPPWxs17zk+vfmZKuQbBGTsINM+9IQvZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731319699; c=relaxed/simple;
	bh=KaYJXT5HyrEgJW3XO9SZFqE6hQ84mjr09lyKOCGdyic=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OvsdzP3CNOEGn+4xaC/06NWDD/XMrrXMlnUYwZBQqkiUCujkJD+Br2yQGRVPaH4MenocMOOfW3KPtjNtHTSb5pL9/wUYbkWHbYybTzoIAZ/yIAczWAkKlYlsERVuq2eSbaLcX4H28lFBh5d/AoioZQUyaDp2Nn9at2ukXp4XMkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emlbnqrB; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3e5f968230bso1726787b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 02:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731319697; x=1731924497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVV67UX8szQopArKm82MAjjGixRj07cehfuIHdEYCD4=;
        b=emlbnqrBOwKzTZpnsjmTxwUuB7mDmm9lQP8sOqBexsCoiFhNPeeVkV6TasEkWST7FY
         vK5rr9ztUGUmipsNrJl2lD2x5qx24df0qp8F+T7yarnNHt2CWBHszB4JysZQWM36MKAe
         CC8fT6e0KG8zsHl4d283CFc9yHfzUaeShY61QniUAvVh5Y4aBrInGaEtwaPRS1hx5PT9
         wLPyAM1k0DKuCAyAxxf7QzXc/iJVzr7fqBY5d1+gEAg9wq/C4XhCKWkvbdqNxkDlXYm2
         pWWLv9uo3kYk3ou0KnTIlB+tH0nMvRIAbzDlB8t0vbUb7E+ERyYNi1vQ9ZWWwKMGqdrE
         jYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731319697; x=1731924497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVV67UX8szQopArKm82MAjjGixRj07cehfuIHdEYCD4=;
        b=X5+kJZX0/40aZIdM4NV3uo7TujUAOqeZe2lgKmeUb4yWffsEub/r3Ua5xnUdRtkc31
         h8H8CoYsoOIDnx7AsgT2FsnQXJBkhWXSna7HKJti1gP2qv8333zEir4CFcHAQ99h/KrU
         +R/rp+6XYJk30HTCM2UrGvM60m4zF4KswXFoRmFj6tsSPYuOWSQd4a3Pll/O4fXEf80B
         /a/hPqVCN3yrMkPnOukslxr171eVaBBY3KtzIdAiqGGddnmY2CWkCxP0GNTh0PFEjKGC
         950K/JK8N4ccSk16L0mrNrN/EFk8WmSF6n4QEI7JWp5Cisl8O1p8Y1RsBrs5pdJaGSvQ
         nhDA==
X-Forwarded-Encrypted: i=1; AJvYcCUMLZmUX6zsCw9n83o+WTaktJxrkjdFAVytOov0XCm5E1D7A7HnqYwQeiVvrnhNuw8J8gOgJcIFAQNG380=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKoy2s2g/BC+MWlnVcJ4bZ+QxE2oBUCCLjQR+eO4r3PE+PPDB9
	RWOWs5TJkFtequMoI34jRauYnjmtuGluX1rnp2NF/oMhgLRJ/mQT
X-Google-Smtp-Source: AGHT+IHdS0HHCkNkWJvTtC1XmxF9ix+W4f0GEUid4prXEQ56YfoEMyaS1O59/E/pcK+xPrwGu/RjtA==
X-Received: by 2002:a05:6808:144c:b0:3e6:5908:1745 with SMTP id 5614622812f47-3e7946ae3ecmr9723453b6e.21.1731319696639;
        Mon, 11 Nov 2024 02:08:16 -0800 (PST)
Received: from AHUANG12-3ZHH9X.lenovo.com (111-254-34-70.dynamic-ip.hinet.net. [111.254.34.70])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f41f5ba191sm8097063a12.22.2024.11.11.02.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 02:08:16 -0800 (PST)
From: Adrian Huang <adrianhuang0701@gmail.com>
X-Google-Original-From: Adrian Huang <ahuang12@lenovo.com>
To: raghavendra.kt@amd.com
Cc: adrianhuang0701@gmail.com,
	ahuang12@lenovo.com,
	akpm@linux-foundation.org,
	bsegall@google.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	sunjw10@lenovo.com,
	vincent.guittot@linaro.org,
	vschneid@redhat.com
Subject: Re: [PATCH 1/1] sched/numa: Fix memory leak due to the overwritten vma->numab_state
Date: Mon, 11 Nov 2024 18:08:09 +0800
Message-Id: <20241111100809.20527-1-ahuang12@lenovo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1794be3c-358c-4cdc-a43d-a1f841d91ef7@amd.com>
References: <1794be3c-358c-4cdc-a43d-a1f841d91ef7@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

<snip>
>However since there are 800 threads, I see there might be an opportunity
>for another thread to enter in the next 'numa_scan_period' while
>we have not gotten till numab_state allocation.
>
>There should be simpler ways to overcome like Vlastimil already pointed
>in the other thread, and having lock is an overkill.
>
>for e.g.,
>numab_state = kzalloc(..)
>
>if we see that some other thread able to successfully assign
>vma->numab_state with their allocation (with cmpxchg), simply
>free your allocation.
>
>Can you please check if my understanding is correct?

Thanks for Vlastimil's and Raghu's reviews and comments.

Yes, your understanding is correct. Before submitting this patch,
I had two internal proposals: lock and cmpxchg. Here is the my cmpxchg
version (Test passed). If you're ok with this cmpxchg version, may I have
your reviewed-by? I'll send a v2 then.

---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3356315d7e64..7f99df294583 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3399,10 +3399,16 @@ static void task_numa_work(struct callback_head *work)
 
 		/* Initialise new per-VMA NUMAB state. */
 		if (!vma->numab_state) {
-			vma->numab_state = kzalloc(sizeof(struct vma_numab_state),
-				GFP_KERNEL);
-			if (!vma->numab_state)
+			struct vma_numab_state *ptr;
+
+			ptr = kzalloc(sizeof(*ptr), GFP_KERNEL);
+			if (!ptr)
+				continue;
+
+			if (cmpxchg(&vma->numab_state, NULL, ptr)) {
+				kfree(ptr);
 				continue;
+			}
 
 			vma->numab_state->start_scan_seq = mm->numa_scan_seq;


