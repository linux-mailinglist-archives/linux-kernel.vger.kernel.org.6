Return-Path: <linux-kernel+bounces-255192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C24933D49
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5FC6B20D10
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 13:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA771CAB1;
	Wed, 17 Jul 2024 13:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RvBEaYnU"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD65B17F370
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 13:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721221277; cv=none; b=ldqLawzS5uUQAbDQc0i3+AfmmGv9vlWkM/WeD+Fe8GxXv6VGzycAgOTbDzy0kZIQsQczTHXvOErvjktCKvNXx9IHTwwFLbc33ryM/TLOF9JxlnWbqIi1DMsTdDioHJl+RfmxDQHNwYuWY5nMDlutY4exTJoQLofXIf/ccyHaDoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721221277; c=relaxed/simple;
	bh=fLhTCCTCqkKEab/Ae+WSAXikuLC4YB5ZLVuZgq8J8WU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tedILU8j58ZnbZxpMhxOySSUoNuARYBmRalq2YblAzJeuCTUn/qPn3ZUDN0VXK1J2PKSCrZAYo/xVAhANtHhL8ax1ylG8aBm+dZJbdwfOrinSvej5+nKIhoMxstMGNgYkomtd/zuBWWgMzMH6PCAklk2T+3VK/5/JxHbkmXqaj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RvBEaYnU; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52ea1a69624so7228116e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 06:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721221273; x=1721826073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OGyaDFq9jA9jHz+MRvSEUhN76EbY0QzaCYY7LY4g8qA=;
        b=RvBEaYnUAc0oVAlQeAGnWnYmRqTUhEbWYWcKN9+5DJvLBkjCVchgqNVjarv6YxmrOe
         8OvCPpCcLeZz+1sWZHS5JalV7p6lkCqYhjbEq5rGg+J7EPyQ7LnR6Jz1RB7MsjihDmvl
         sFoC9GNXH0WtoBw/zyCne1jb8flA9kvoA7+7LhwzpF5PuraxVmUYA3L3ISLSFSwzjZST
         2eE7Gy42v86XfTO3zpfzMslA5L2V7wPytok8wA9QFe72SXEnk56Hpltc6StDp47izEwo
         B/Kb8n06pxAts9NFypal/oVnuL1FUGkgDJsAAn+9CPLGxOcGeda4uPVC2nHgVvu1x1bZ
         Vmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721221273; x=1721826073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OGyaDFq9jA9jHz+MRvSEUhN76EbY0QzaCYY7LY4g8qA=;
        b=HF3SNbVOx1hlGcaWwsjw/aH8ysBrzbxGCiCKHMqp5lrlzXJ0SvC5K98Sm/JtbRFIdU
         APfL1cA6XxoX/gYWECqE8GNBqcjm7B5e3iiEntIG+rlyGVo5M5SXCVkUOUuso9WSLtU6
         7FwFXibc6bHttgMe+3Pay8Sj+SU1l54Xv7HIA8SgrPSvcVCvFVl11wSvL6MncLHg/jk/
         7wWUOWUzoRRDsY0OfyeH0yOMTcTgK7gieEa8R1mXtfzuL+9oEN2yDMcMKGIIUVotU39c
         vJRhF73MHzK0uRmvx0zeWH62/A9hM1HURjTqwSuEgEAS+wU/yOVeD9XAx+6yNo5In9sA
         bp9A==
X-Forwarded-Encrypted: i=1; AJvYcCWOXe8x9Hnpt7UCNpy8NS6wfae5LtEb9IRsP8w7suYKhpYgSf0sWpv978ZWkt0xiLmH54qF5S99gMbvwFKaArYNAsgNYt3e4gDXliF5
X-Gm-Message-State: AOJu0YzhogvTELAXSGdwdri8ARfr+m54vIB87jKWj4VvoS5Fy93afx7K
	uKPctk6kYQ//56xIAAEz0kI4v0/XtwXj+0ZQnu4vET0f2pjtkX06NL2HQOuv21E=
X-Google-Smtp-Source: AGHT+IFT/gnVm7+TpSUk/TD1YcnnxpUbPqafzGNpHFUNKGF85vLE/dSL1DN4N5BTkWqwYODpwa0iug==
X-Received: by 2002:a05:6512:280c:b0:52e:764b:b20d with SMTP id 2adb3069b0e04-52ee53dbc96mr1263786e87.28.1721221271895;
        Wed, 17 Jul 2024 06:01:11 -0700 (PDT)
Received: from dhcp161.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7f1e5asm442596966b.109.2024.07.17.06.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 06:01:11 -0700 (PDT)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Kees Cook <kees@kernel.org>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH] refcount: Report UAF for refcount_sub_and_test(0) when counter==0
Date: Wed, 17 Jul 2024 15:00:23 +0200
Message-Id: <20240717130023.5675-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a reference counter is at zero and refcount_sub_and_test() is invoked
to subtract zero, the function accepts this request without any warning and
returns true. This behavior does not seem ideal because the counter being
already at zero indicates a use-after-free. Furthermore, returning true by
refcount_sub_and_test() in this case potentially results in a double-free
done by its caller.

Modify the underlying function __refcount_sub_and_test() to warn about this
case as a use-after-free and have it return false to avoid the potential
double-free.

Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---

Motivation for this patch is an earlier kretprobe problem described at:
https://lore.kernel.org/linux-trace-kernel/92cff289-facb-4e42-b761-6fd2515d6018@suse.com/

 drivers/misc/lkdtm/refcount.c | 16 ++++++++++++++++
 include/linux/refcount.h      |  4 ++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/lkdtm/refcount.c b/drivers/misc/lkdtm/refcount.c
index 5cd488f54cfa..8f744bee6fbd 100644
--- a/drivers/misc/lkdtm/refcount.c
+++ b/drivers/misc/lkdtm/refcount.c
@@ -182,6 +182,21 @@ static void lkdtm_REFCOUNT_SUB_AND_TEST_NEGATIVE(void)
 	check_negative(&neg, 3);
 }
 
+/*
+ * A refcount_sub_and_test() by zero when the counter is at zero should act like
+ * refcount_sub_and_test() above when going negative.
+ */
+static void lkdtm_REFCOUNT_SUB_AND_TEST_ZERO(void)
+{
+	refcount_t neg = REFCOUNT_INIT(0);
+
+	pr_info("attempting bad refcount_sub_and_test() at zero\n");
+	if (refcount_sub_and_test(0, &neg))
+		pr_warn("Weird: refcount_sub_and_test() reported zero\n");
+
+	check_negative(&neg, 0);
+}
+
 static void check_from_zero(refcount_t *ref)
 {
 	switch (refcount_read(ref)) {
@@ -400,6 +415,7 @@ static struct crashtype crashtypes[] = {
 	CRASHTYPE(REFCOUNT_DEC_NEGATIVE),
 	CRASHTYPE(REFCOUNT_DEC_AND_TEST_NEGATIVE),
 	CRASHTYPE(REFCOUNT_SUB_AND_TEST_NEGATIVE),
+	CRASHTYPE(REFCOUNT_SUB_AND_TEST_ZERO),
 	CRASHTYPE(REFCOUNT_INC_ZERO),
 	CRASHTYPE(REFCOUNT_ADD_ZERO),
 	CRASHTYPE(REFCOUNT_INC_SATURATED),
diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index 59b3b752394d..35f039ecb272 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -266,12 +266,12 @@ bool __refcount_sub_and_test(int i, refcount_t *r, int *oldp)
 	if (oldp)
 		*oldp = old;
 
-	if (old == i) {
+	if (old > 0 && old == i) {
 		smp_acquire__after_ctrl_dep();
 		return true;
 	}
 
-	if (unlikely(old < 0 || old - i < 0))
+	if (unlikely(old <= 0 || old - i < 0))
 		refcount_warn_saturate(r, REFCOUNT_SUB_UAF);
 
 	return false;

base-commit: 2df0193e62cf887f373995fb8a91068562784adc
-- 
2.35.3


