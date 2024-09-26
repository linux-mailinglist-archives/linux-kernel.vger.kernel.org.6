Return-Path: <linux-kernel+bounces-340218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6002F987015
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 11:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258AA2854CB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 09:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAB01AAE15;
	Thu, 26 Sep 2024 09:27:14 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C801E146596
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 09:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727342834; cv=none; b=WV8sxuPhyuUmJHGyeECPV060XneE00Z6o7vwgTXNO/v3mkjwrYJEnfbhMcauxkp++vbsGj16ckccPLXyS+/m5zxcJCBNEhIj6X/61Ztlt3CoVaDNX0wIJb2HeF/w/401jlIQl94t3IfPjU3/fIXYkNdCIf3O3py2EHocCe7ik2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727342834; c=relaxed/simple;
	bh=2oJS0dqs3dzFGrMjrE2KNkacP8RMJBWZ1mFfNaWdjkI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=MH8jf8nx29choFeXLIeH+AdhnNShZCW1g9HnzE9CGOLYEWb/fCq91NObO2xPX7dLLVGajh/dZaEYfxNKm0vjU+kSQIOVkCWvKycGWC+RcQnHg1f6Wj6XCSYgwYBhXZNzIz3pS4QPzEOvP+Qbb7QxkyHHfqe14/7+mpSMDi5jbhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42cde6b5094so6983615e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 02:27:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727342831; x=1727947631;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RCYimulyplJ/QBbQZDyNZ6PC7/nIgszRvvPJOLK6CQQ=;
        b=hZXGD9cuUtc233f4CY1QTWoIcR+/p2HKZ9n2FQWn3HIqghogdjbe25Z8hMqCPoAGVS
         Yog3KaXHfPUHcTDGEzR5GYIwFnsMTpKzvVONi8XD+LmikNhp5vCvZw7QqbvaFEACQJiz
         l50ePgZ8qgzEY9zuj9UdJf3YtY/RgWdCDyVoHi4bG03maCTwjHsH2P+q1yPLSMoGiAPb
         VOm+le2x6BqrU3QAyJTGRJRNF3iiRti9UZMEtA5Lp88F/XndzpSjX+W+jhivrQMHbG28
         R25za8C0aAlEHLsAmkHAIBUzKi5cJVd/t8T1ky03NufisxXal6lQ6HYqIaka+AhJyvsI
         wX+w==
X-Forwarded-Encrypted: i=1; AJvYcCWX4z/eIvVy8CR6FNe1fsJ2FskO1HR0ubih5zd+ct3qkGsveG9CjNTjkgql1DN/QDSRsuxch4hkFEh21v4=@vger.kernel.org
X-Gm-Message-State: AOJu0YywtFxhZJ2eSWr3ZbSEuSjl9C2TwzUsuTixvVZmr1+sZfbyDkiv
	HzUQOjx6ocgPlp56JHH9HIxZMXHIUvNcdTwTE9n31GQf1sDb4XEl
X-Google-Smtp-Source: AGHT+IEQT+Ooa0Yhm5wcyTD5XpZt+dDp7YMYJ24i3C/+E8lwiSV5RucDIsttkrKOgzUYqqlOQF+FRQ==
X-Received: by 2002:adf:f1ca:0:b0:374:c8cc:1bb1 with SMTP id ffacd0b85a97d-37cc24b575bmr3660406f8f.39.1727342830761;
        Thu, 26 Sep 2024 02:27:10 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a041:e281:f300:ddd7:8878:b93d:7c0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cbc2cd263sm5938075f8f.48.2024.09.26.02.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 02:27:10 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Ming Lei <ming.lei@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] powerpc/xive: Use cpumask_intersects()
Date: Thu, 26 Sep 2024 12:26:22 +0300
Message-ID: <20240926092623.399577-2-costa.shul@redhat.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace `cpumask_any_and(a, b) >= nr_cpu_ids`
with the more readable `!cpumask_intersects(a, b)`.

Comparison between cpumask_any_and() and cpumask_intersects()

The cpumask_any_and() function expands using FIND_FIRST_BIT(),
resulting in a loop that iterates through each bit of the bitmask:

for (idx = 0; idx * BITS_PER_LONG < sz; idx++) {
	val = (FETCH);
	if (val) {
		sz = min(idx * BITS_PER_LONG + __ffs(MUNGE(val)), sz);
		break;
	}
}

The cpumask_intersects() function expands using __bitmap_intersects(),
resulting in that the first loop iterates through each long word of the bitmask,
and the second through each bit within a long word:

unsigned int k, lim = bits/BITS_PER_LONG;
for (k = 0; k < lim; ++k)
	if (bitmap1[k] & bitmap2[k])
		return true;

if (bits % BITS_PER_LONG)
	if ((bitmap1[k] & bitmap2[k]) & BITMAP_LAST_WORD_MASK(bits))
		return true;

Conclusion: cpumask_intersects() is at least as efficient as cpumask_any_and(),
if not more so, as it typically performs fewer loops and comparisons.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
Reviewed-by: Ming Lei <ming.lei@redhat.com>

---

v2: add comparison between cpumask_any_and() and cpumask_intersects()

---
 arch/powerpc/sysdev/xive/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index fa01818c1972c..a6c388bdf5d08 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -726,7 +726,7 @@ static int xive_irq_set_affinity(struct irq_data *d,
 	pr_debug("%s: irq %d/0x%x\n", __func__, d->irq, hw_irq);
 
 	/* Is this valid ? */
-	if (cpumask_any_and(cpumask, cpu_online_mask) >= nr_cpu_ids)
+	if (!cpumask_intersects(cpumask, cpu_online_mask))
 		return -EINVAL;
 
 	/*
-- 
2.45.0


