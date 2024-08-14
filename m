Return-Path: <linux-kernel+bounces-286682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFE6951DC7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936EA286997
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DDE1B3F00;
	Wed, 14 Aug 2024 14:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cR2babAB"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF431B1417
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723647190; cv=none; b=MTjM8/EpkpwwWujtV1/8UEre6UudJv4+EvaRVXC+Lr46phcNF6FklLlCmIFybbw4wjK4J8s/nS0RNSb2JxGS9fRQcpF1f/kRhiP1aqZhmB1hK/O+AEpiMeTU8FOXvJqgJ/o/ZxvrQzIIoflpuebG3BF1op52p0w4DrEIvo3+j9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723647190; c=relaxed/simple;
	bh=f/oHoC9VpN5nx1mUCbmuS6hMWVT9zH2JfixxV6pSWCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d3/RENrxDd9Re0Xa8f/Jge/JizNKr2Bzd8PKzhzqLgYux4qQncaZVrm+3biyLvhMWgTXgaWeom/15DEkAYk3hTE5+2zirQZFTBuuZLQ7xJZo/WOOlSw3mQwqcraSiHKCXUPPwR2CKee3nGefMrCC0+sXOa1RZblbHHshtmyPXSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cR2babAB; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4280bbdad3dso49851805e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 07:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723647187; x=1724251987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lonJxsA8Fw6wOOZai80Q9J+BZK2m7M/vz+HKB4hoGGA=;
        b=cR2babAB9UllUXoZNt9yb7bLYiVgW3RTm9qBBs8o7UAzgsT6WqNdbJyPoeBHGnKEyJ
         xBkbUwPv7+XcxtiAZvSIQIus9vdQyNvWOJqDNF25mydb0mAon2Sy4PgP5twruehs5wxj
         QUIngfYzZNroFFbmP9iVv3/6LZWi2RSl83VFAMafXpjcpk0hFdzIc14h6XmJH1/svF+3
         vwzY6pDXFtf4DxVsPgsJwUAIgOxTFT00aiwhmPrgo3R8oygzGshi/Zv7YH58EVfvaagI
         DyLqQCob2KzBzwD79IChaelABsVmoAQdNprMq4wuWitjcfd51iPxSCYRpjCJDLDg1U1V
         sRMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723647187; x=1724251987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lonJxsA8Fw6wOOZai80Q9J+BZK2m7M/vz+HKB4hoGGA=;
        b=gdZpXiPiy7oeFdfQiuw6m/CvKwEF0Y9w5gxWYFLOU2a/n/4xlx4hzP8s7aQ0AR22bF
         0Cs7i8fYe43e6QYIRYK6cu4+KUUwhhJyB2KpLTGhHL5pOHqLjkssHs5XmoLWoYb5XFm0
         gTFOUlSNvz8Bo3+erFZw3W1Kp6OAtq649TR6M7XB2QXnGip5bkrv5vA2/TdkaXTZ/VxK
         G+k5/OtuDcwg0QpB4nbSxMkPyOOzzp2q2ZsHqI+Jo0CVdMHjaNIKo9YGhZlmthqYqa2/
         T3XRk86jfPRoc1L1eGoEI1XxrI81gigQTFunQDIFg+SRMHYamNc79rm1miqP/rWuEtjU
         Vi+g==
X-Forwarded-Encrypted: i=1; AJvYcCWVstNQs4laGWwyAiIyIW/4lJ+QgrhJmtGLTGa83YC+tRUWR6pbJSDC0hrAAXZYSheLiiaYnRfMghDk4lvcmCG0zJMrTI05mdHuqa88
X-Gm-Message-State: AOJu0Yyc47tYg7AcjSdEOrGuB0lKgSoMZ8Gk+cpJIHhW24QUzwaISfZ4
	GvIVGHrKMKjDM1Bzk9NDTTXBf0vGtpJ7HoTk8QJnZ1cgSvxLXtGuqnaWPK2Z
X-Google-Smtp-Source: AGHT+IEoJbkP+hVe6+RzMKd+SJql/ELhAn+tPz0Gyw1HW0cOooFceTJ11Wl9zFZCSz+VoMQDguNnNQ==
X-Received: by 2002:adf:e546:0:b0:368:77f9:fb34 with SMTP id ffacd0b85a97d-37177763876mr2346397f8f.15.1723647186881;
        Wed, 14 Aug 2024 07:53:06 -0700 (PDT)
Received: from f.. (cst-prg-76-86.cust.vodafone.cz. [46.135.76.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4e51ebefsm13003576f8f.89.2024.08.14.07.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 07:53:05 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: akpm@linux-foundation.org,
	npiggin@gmail.com
Cc: david@redhat.com,
	willy@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] mm: whack now bogus comment in pmd_install() concerning a fence
Date: Wed, 14 Aug 2024 16:52:56 +0200
Message-ID: <20240814145256.1683498-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 362a61ad6119 ("fix SMP data race in pagetable setup vs walking")
added the following:

+       smp_wmb(); /* Could be smp_wmb__xxx(before|after)_spin_lock */
+
        spin_lock(&mm->page_table_lock);

However, over the years the fence along with the comment got moved
around the file, eventually landing in a spot where it is *NOT* followed
by a lock acquire (or any other operation which might happen to provide
any fence on a given arch), rendering the comment stale.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

./scripts/get_maintainer.pl only showed akpm@ and the lists, adding the
--git switch showed more names, but I only picked some of them. I don't
know who makes the most sense to add here.

I fully concede I could not be arsed to check if the fence is still
needed to begin with, I ran into this while looking at something else.
The comment puzzled me for a minute suggesting pmd_populate has an
immediate lock acquire inside.

 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 34f8402d2046..0a6893833fac 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -436,7 +436,7 @@ void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
 		 * seen in-order. See the alpha page table accessors for the
 		 * smp_rmb() barriers in page table walking code.
 		 */
-		smp_wmb(); /* Could be smp_wmb__xxx(before|after)_spin_lock */
+		smp_wmb();
 		pmd_populate(mm, pmd, *pte);
 		*pte = NULL;
 	}
-- 
2.43.0


