Return-Path: <linux-kernel+bounces-414461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F12E9D284B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EA16282DAA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BB11CDFC3;
	Tue, 19 Nov 2024 14:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TY9AsjTy"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F041C68BE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 14:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732026963; cv=none; b=BUzbjQHFMo4DzkCwzy9IwwOtEcHy06jt/noL8Z1YjLoXeym/OZXkXKUHRw1m+NLbB8VksRxgxOO9PURiTb5jeAUkz8hV9Nlr6vMlnbexn5fvq0sQeADBz1jEYNyphxpOaBGFTfHqyQsS+Ty07fTA+CX23HB2W1V5c06eVjGBhNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732026963; c=relaxed/simple;
	bh=6PzimaT2ZzcfReTyS7STbVhcn8YFHF2LqCOyy+Kiepw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cePtTwnZUKucymKeDcAKMsBZ1WMbLBnHs4Zk3wj/zwI1fS44/wpYUfwMXnD/NPmtBiqhem0smtJeX03Ej9Fd5s/ezfNxS0Ev1NzIpXfnZU9XwBz9ZXpa9lMCd5MOtNoHYR3UV/w0qsm8lVJym1mZ0+WkZpt149MVWhIem50uo4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TY9AsjTy; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa3a79d4d59so169398266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 06:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732026960; x=1732631760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w7idQQg4D7BUihd8OeXq3fOBVuvuiTlbrkZ9vzYLBbg=;
        b=TY9AsjTyFLk8qOfzNYT+YcutN5LbJTnThHA8YwfpWHP6oiNITl+3KnYDVTmlOaTALV
         HCX0bfNFxwmNXpmC5OAIRIK5CSq8MS6Esioacc/NnczR0V7p74jAg+pnbz/qkozIZBXy
         jJrjAZtZPDGQGMQeByJRSJNFDbjcVl3wEbJRo2oKdbqjkSbRB/KTGbSdn7o1gao3np8Q
         3+z/DLCt4ze4dZLHXWAMQ7DM3HJ1UvmmjF9UC1wrdpKhMAdGlF/ogNvHBuAQSeWmT2Tk
         KHdGeEKj9paw1sZbp2+nJ6w4F2qxo2IRiAtJt4q1ynKlw2+4t892lqrxsuRDYeSRgCUz
         gUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732026960; x=1732631760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w7idQQg4D7BUihd8OeXq3fOBVuvuiTlbrkZ9vzYLBbg=;
        b=O7yA5P8j0f7jJPyl/lLo3rRxP/obKVbBJ90MbxPqOYypb+F5DwvzSEK7GiecVz2OEJ
         4Yq5R9haBMN1YAAXM7aXWMAM2FkpbWNIojNlWIfwCZiElXQmKGeX0GNZTElt5WZirzC2
         0x/Of1DX7T+Sxl0SwcFJKkU4bIiSohXc0E90rMB+TPJXz8C8tzwgiUG5tCtFHBpk2koS
         MSnW7h96kzC2DWwgOd2pLYXyCPxHGK6a83f6m4hd/i0HtUtQJWfLh+p64qmPNY9p2mZ7
         OT6fM/HZt5xC9nhOAwxSTHUzU9xrnMBuqqGR6npeSVI+h7ZrWrC9QkuVqvmoJyF1W6Rt
         /VEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlPz9aaibsGlAJJJilXlnYfpLVMXVWC5VWm/AtzS8Q6/+Z/Kho99CUG5L735p0rFhDBJpM1vzm7LGw2Ok=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNftGIxKuo8hM3En6QSsm88pnZaPefcqbrpEicHe252LVb//1n
	jB6pnbZJan85yQFwm9zmLbZ/ovQ5wbr3nrEo/JG6Uf3YBeo69YZQ
X-Google-Smtp-Source: AGHT+IHReRAFCSlFt07494EKzoaTxnNoyKNt5Mh49aj3loZLTEjmsPWJYANZyG00j56l7UT+F/tSmg==
X-Received: by 2002:a17:907:9309:b0:a9a:1585:dd3b with SMTP id a640c23a62f3a-aa483421c7emr1483333566b.21.1732026959694;
        Tue, 19 Nov 2024 06:35:59 -0800 (PST)
Received: from f.. (cst-prg-93-87.cust.vodafone.cz. [46.135.93.87])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df570ddsm654296966b.74.2024.11.19.06.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 06:35:59 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: akpm@linux-foundation.org
Cc: oleg@redhat.com,
	linux-kernel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] get_task_exe_file: check PF_KTHREAD locklessly
Date: Tue, 19 Nov 2024 15:35:26 +0100
Message-ID: <20241119143526.704986-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Same thing as 8ac5dc66599c ("get_task_mm: check PF_KTHREAD lockless")

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 kernel/fork.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 22f43721d031..759902828e13 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1500,12 +1500,13 @@ struct file *get_task_exe_file(struct task_struct *task)
 	struct file *exe_file = NULL;
 	struct mm_struct *mm;
 
+	if (task->flags & PF_KTHREAD)
+		return NULL;
+
 	task_lock(task);
 	mm = task->mm;
-	if (mm) {
-		if (!(task->flags & PF_KTHREAD))
-			exe_file = get_mm_exe_file(mm);
-	}
+	if (mm)
+		exe_file = get_mm_exe_file(mm);
 	task_unlock(task);
 	return exe_file;
 }
-- 
2.43.0


