Return-Path: <linux-kernel+bounces-319290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B82596FA25
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E44601F21F7F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A27E1D86ED;
	Fri,  6 Sep 2024 17:50:25 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ADA1D86E7
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 17:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725645024; cv=none; b=jPU7DLClH42VVbNBnnJkX1ZL22KycWhTYXnsajo5oHvOQf6IaSF5RFN7M9bIcdMQYodJnNJ+PdYq/qdLj0qtfM++v9M4Om+5KsHxuvbSBWukHPusXArGgtW7Vu/qfUOL2QlvrQP9MfYZ5S12udFexBH/B5Jf8ePHK7Qh6raHff0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725645024; c=relaxed/simple;
	bh=6lSlcXGV24RJcClyF67i2c6U2rxfSUCrSDPpUpZmPXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q2AtIvup8mLwKKu5NCo8Wn7rFoul/1sHTKzVARR6Erekl7biv9AvCzQ5OC+w+FEQWNFGShwMHrObeAhICG5GQd7Ebhn9bZhsAOUOivPillz3f6VtblKMfw2Pim1PpHNsL84Dr7+fBTMzjD95pE6NuW2csG1TAZTAP2Sb0SGIJgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42bbe809b06so17442965e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 10:50:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725645022; x=1726249822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cBwPrXfQENKYJlILGnwqxaMS8yZZIqO6Bs9phkuiKJY=;
        b=aoVE7nhs2iJgk7ZiSLHkhcFXYgAlR/dmDh45y7Krbk207QoqG81zVdNT+MZHO+IMNT
         T6lXbjiR5KFYCy2gOSkB5EoPexU7omxxtOcKKoSd6qu2nxNZW5mg2x9q5iCdL7Nm5zfJ
         QhmSvYBpo1BaQ+TBNLez0zTw/UcTwoEx1tqxzYUotV1TZxge58OhgO/ZuuOImk2iMYtA
         ea0dcbl5fXm1bKUSw2abYRaxbb+jNAwSwpbVEjP1o02ijpUfRrJPRggYkK5I2SvfpnBS
         RHsUdk8xz/FxWdsSLUm5qWzjLexx6SgaAXZ1KQ+SAXMfNqwuIXSqrUx/xhpXuMX3OM89
         3DUw==
X-Forwarded-Encrypted: i=1; AJvYcCVB7hr5LVbN4wYPYa4ugORFYAbogxpkyktpw4LPs8FsPpYnYq5mSZnDQMoFqehl0GOV+IOGVXHUpnfTrHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIwJemq6WnXddwGaJq9fogp3wiaol2IG9NhZvVU52p7svNmbcu
	T2Trrv6opfgl6UTR0u775YETu1uhGWYKNjRMwQs3DhRd3jVlddfr
X-Google-Smtp-Source: AGHT+IFCFQDCipGqICeFJ8E8CGwuoBP8ciZam2q+rs25bUZzeBwA8DyQ8K8CRJvgWbUp8Cr0GJh8vw==
X-Received: by 2002:a05:6000:10e:b0:376:df1f:1245 with SMTP id ffacd0b85a97d-37892703f37mr11604f8f.39.1725645021469;
        Fri, 06 Sep 2024 10:50:21 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a041:e281:f300:ddd7:8878:b93d:7c0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37891607ccdsm443827f8f.4.2024.09.06.10.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 10:50:20 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: ming.lei@redhat.com
Subject: [PATCH] powerpc/xive: Use cpumask_intersects()
Date: Fri,  6 Sep 2024 20:49:36 +0300
Message-ID: <20240906174941.1147197-2-costa.shul@redhat.com>
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

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
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


