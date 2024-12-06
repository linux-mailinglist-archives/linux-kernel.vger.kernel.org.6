Return-Path: <linux-kernel+bounces-435600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0369E79FF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 21:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91EC21887B3D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD4C1D5CC1;
	Fri,  6 Dec 2024 20:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xb3bbHeN"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122B883A17
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 20:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733516804; cv=none; b=BD2l1qWnPmfKfN27j1tP7bRcaCNoRkAxSDHFN8+3jOFyJMdXBvx8xh3nmGVUrRXwDAfUOPu2UXjL3l8K03GNyHpNE3Q9cnC35LlTw5zyf4FWFGW3kWYaO62seEpe2CyvHYXIp5fm1zU0oNhLSsMc0Yt3DahtkEf9FR2kEKFQSDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733516804; c=relaxed/simple;
	bh=8oc8EwI0AnmhUu+nV0YrX6Le/d762O1AmGoD9ZK9eyE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XMEKBt5BUrjmUr0T6n9ZHUyirRZ7J88sO8o6/fuyAoHm349orn8JhnFTI9LDOq6Q1tZDU9+L/cbkQUJJzK4IUiOWdKzvXpJiEx9pD+m7IeZIyorfPRl4qL2v8Rv8B6devZryDf6i6TV4Q0D7xpYGGQn80+2AlZtc5Wo6esGKTMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Xb3bbHeN; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-385eed29d17so1947550f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 12:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733516800; x=1734121600; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OjkawNe/zvVX+h0jYqx9NDeU0TKqmCFwHGIOk1udH/c=;
        b=Xb3bbHeNRj935sMdCVaZvMa9huwcWZ8KE4WrASzuz+BFZVai1eu3hQ2hfCzHci+fFT
         J+XoHZshCQHghv0VQWEr9UYUb/muDl3XaSyZtHXCsdNa4OdqpwfvoRWHgmufj1q/k8Un
         DPdMl0hxdpnt1OWubs3l7PQoF+4AyJ2k8YKjREXRe305zAAJCEV8SAHcfvFhioktSmtb
         ZbpC2lqF1P2b3CeplRRWATjp5u7UJ49o53Jw70Sd9QM8IU8fAlZ3myUVBnmUuid9Jzyu
         VxqJFx790KVz/pMMjd+20MbohS27KN7OendRJ8uhKgjjFlIBEDhm7VLSQ+RPt4nISDYw
         ClJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733516800; x=1734121600;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OjkawNe/zvVX+h0jYqx9NDeU0TKqmCFwHGIOk1udH/c=;
        b=SBJpdNp1ZDvt+H+o9DyJ/41lKW1lTH0r5cNHNzrwRibSiixWbWgURqDKiS7FqmNT9G
         CyKCYkefp9ED9w5aa0WWy9uB9eHku8OWTRGHR1TY/rLgRrTOs8eLm+wUmjZFJ8Z4xfDE
         VmbDAotrWO/JysXJ1Cy3pk9XY/TGJzOKoHO9SPNTMrkzMzr/iQbMzPh5O/z6TIp1taDh
         wXdaPZQvn92waZooyrh4lFd8kuf8sA/b2D7VmilU8GeV6O/tH97d6RYFCGlpIGlRvhe/
         JY39cOIRPRax72/Ai2FCyv4sVpR2D5Z38GhtVi9wl/sGollt1jrXbuk0ejfDEDL4ZcCw
         5eyA==
X-Forwarded-Encrypted: i=1; AJvYcCXmke8AbyXXLshSHU8Sqr7aG49D9Ho6LXIOCmndMZ/YTHxP9RrNY69Ls+fn6ctFZKgr9eyF4RDNquE9e6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqDEJHy/9RCZaB4Y8AuPGXQeWGKwi4iJtgyRi61D10rw1Dcrj1
	Ik/aDempCCtZJctHfpzIM3wtepnGKJ37vXuhS0/pD2zlCsB8EZejLhYGIKM1ggk=
X-Gm-Gg: ASbGncu0j96LVsasN/V3CfC9zQH221NAGW5qWVjSD+L1o7vX+CZ5fObhAFi8Z/CMV/K
	DDxWj8tl+u8g7gTrJZE8lMd5E0kTqZUIgViUIIdCGCra6Ln3zjgsKNlJRiPdZQaqKb2/ZRow0y3
	cVKUES4+Dpgcl4XyjNVV0KTHygpNHh4oHgVdq0JJ9IWmgceWissVIWj5R6Xg+JHCCbN8f0ajhBL
	BaJli5IKu6uNLd9ZPwfBIW0vdwFZa/V5/F+7nltJj8nslz73ADmtik=
X-Google-Smtp-Source: AGHT+IHuuNn8PhPAm12rBVa+8Uo5b1NeCY06qOcGgQGqX87r5PhjVJ2tEF0YYVoSm7KTEvHFh633VQ==
X-Received: by 2002:adf:e19e:0:b0:385:ed1e:2105 with SMTP id ffacd0b85a97d-3862b36cb56mr3597056f8f.26.1733516800528;
        Fri, 06 Dec 2024 12:26:40 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d5280497sm102052885e9.23.2024.12.06.12.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 12:26:39 -0800 (PST)
Date: Fri, 6 Dec 2024 23:26:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] mtdchar: fix integer overflow in read/write ioctls
Message-ID: <020f98d2-eee1-434e-8236-775cca9fd157@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "req.start" and "req.len" variables are u64 values that come from the
user at the start of the function.  We mask away the high 32 bits of
"req.len" so that's capped at U32_MAX but the "req.start" variable can go
up to U64_MAX.

Use check_add_overflow() to fix this bug.

Fixes: 6420ac0af95d ("mtdchar: prevent unbounded allocation in MEMWRITE ioctl")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/mtd/mtdchar.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index 8dc4f5c493fc..335c702633ff 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -599,6 +599,7 @@ mtdchar_write_ioctl(struct mtd_info *mtd, struct mtd_write_req __user *argp)
 	uint8_t *datbuf = NULL, *oobbuf = NULL;
 	size_t datbuf_len, oobbuf_len;
 	int ret = 0;
+	u64 end;
 
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
@@ -618,7 +619,7 @@ mtdchar_write_ioctl(struct mtd_info *mtd, struct mtd_write_req __user *argp)
 	req.len &= 0xffffffff;
 	req.ooblen &= 0xffffffff;
 
-	if (req.start + req.len > mtd->size)
+	if (check_add_overflow(req.start, req.len, &end) || end > mtd->size)
 		return -EINVAL;
 
 	datbuf_len = min_t(size_t, req.len, mtd->erasesize);
@@ -698,6 +699,7 @@ mtdchar_read_ioctl(struct mtd_info *mtd, struct mtd_read_req __user *argp)
 	size_t datbuf_len, oobbuf_len;
 	size_t orig_len, orig_ooblen;
 	int ret = 0;
+	u64 end;
 
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
@@ -724,7 +726,7 @@ mtdchar_read_ioctl(struct mtd_info *mtd, struct mtd_read_req __user *argp)
 	req.len &= 0xffffffff;
 	req.ooblen &= 0xffffffff;
 
-	if (req.start + req.len > mtd->size) {
+	if (check_add_overflow(req.start, req.len, &end) || end > mtd->size) {
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.45.2


