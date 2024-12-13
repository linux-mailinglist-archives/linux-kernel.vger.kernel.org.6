Return-Path: <linux-kernel+bounces-445035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B90759F1030
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB153188DC9C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2F51EF081;
	Fri, 13 Dec 2024 14:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="md09I8Cw"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CA61EE007
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101906; cv=none; b=n3asCyrMelookYjYHqPrcnXTYPVilFyZp/e4cZJqd5fbbO04vwVlNFmBfzGEQgZJMNrKiofw40OaCQRjhGtFXL67zBds8yd09JMWgfYijM261aIM6JzUhmlOeRRlmd6mdTazA2BR8UkIhmv0XkBnfwHjk3GkwHgsA5TTk2cxlis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101906; c=relaxed/simple;
	bh=hW2x83jQhydXVuyRaNAVfliRssGPsVWJxnzSeknKQLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDj1oqGHP03UG0Ek+wrghABTqZqyyaYpjwJaHvpZmC7UIXKzFTrC1i60gqh3H+1vpnA45g9npKAiz2lYPHPyH/jh8rpsikYThgttggyb9rKcwPrmOqWNXNBYHGjdZKWyR1pkTUt/eqdqBxk+bF2hkjRlcKCFHMOnQKnHXQ1wsU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=md09I8Cw; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d414b8af7bso3812132a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734101903; x=1734706703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTU9/5MK0HAWBhEVM0w6Se/hTXoo9yj/PJnWYE15UAo=;
        b=md09I8CwyN93sDaE4c2BkFiIloZmB6qMA2rxE74DpdQ4/d7ck5qELvlYA46hsTqzm/
         wYSB3CZc8hn/gMab5QJaw9gDKd+uTnR4R8MzRiB3U9oDsghvy+alOq8ZzOAlSVFTfqxX
         /CBKaKgcJbPiF5UNzPxTCKw2q2oG4kl3sv1UEJCk/35ENLhlL4xn8ac6IrxLPTX+Arro
         N/5yTz6vRRMMxJtG87VZNt288qLhvjp4NLQise6ncQ9p5ITINUewQLAH4IgvL2x4VgOT
         fIFiGfFNsqfldbipm7gPe+F69R7dSHyhou5Awf1qVfEk6QEcIanAK+TBiqVYlkdZcn7/
         YINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734101903; x=1734706703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZTU9/5MK0HAWBhEVM0w6Se/hTXoo9yj/PJnWYE15UAo=;
        b=U9NLkYqvA5c4Nyu9jT6mkYAzjwvRFEbUQqM9aF5xZyRhkjN+QrZYZLfkrgeemb9lHm
         96l32TyyJcE84QBFE1a8so+22lEi86QLx4zl68XCyB///Yr0UDzml+tRgc6WT+0xJCPz
         eUXpnL8Xu8rbFIJZb+ZqIoStuAsZp10JPqYok4xMyRO9ZsQQ6M15Zv1KULbmphy3KVhU
         LE21uh8cEpkpY3r+SLJKWZ4z0/vkzF5XF1txiQIL9ATTU7TxV0m1UHZABFn9mUg0V9cM
         wLsYDmznWMdRc7X12hrcqdEwxmFGzkobTOEKDy43NzYM7Jw/jf9MCV04UcXidXCpZ11R
         IKwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX60KpYvZf7ukhmaMJWVLTCs4IjDwhq0NZt1yQUHxGLC56DG7b7Qum0Qa87d3lxEdi5+stt+tXjvvz6eM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlpi8dTi1VG76Dk3udakNr77FSEjq+V+ayekraxprhBALnOO0e
	Oc/y8DUK5FfT8GysGFdEzNwwlD4zc2kvK/PKSC4P9Lnqzgz7OHjU
X-Gm-Gg: ASbGncsB8tJNmlx6uN4Yco4D6gzMgLL8MZ9K6lft74ygy95Atnx2LbGirDHUghZlTIv
	POJy0nT30sYTUdTQ9NDZLuc4p1k8lG1juIR3XU7DjWZ83jdbhgzGz2V0KWnv7+yyt/Wd+9IU554
	s1ApvP6LXs5HqjVfYDryRXlegHwqZLPNecVVYKD5VJnvycVnm6OgOVu1b+pMkyUjPUvL1hNMsVU
	bcY2dyBRxbsMhcQPez/WRpsbowoqyg8tacnSnexxg2qwtjG5I8FJEaD9To37N5pQA==
X-Google-Smtp-Source: AGHT+IHAHdTmbS5FyHmI5caY2pFFoYj7IVic+V5ZxnRs/MLkIBNo1DY2zUzOg9k/TR+vdwTA1hoLjA==
X-Received: by 2002:a05:6402:3808:b0:5d2:7270:611f with SMTP id 4fb4d7f45d1cf-5d63c3ecb3amr2620066a12.22.1734101903219;
        Fri, 13 Dec 2024 06:58:23 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3cedbb8fesm10048424a12.22.2024.12.13.06.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 06:58:22 -0800 (PST)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Michal Simek <michal.simek@amd.com>
Subject: [PATCH 3/3] mailbox: zynqmp: Remove invalid __percpu annotation in zynqmp_ipi_probe()
Date: Fri, 13 Dec 2024 15:57:54 +0100
Message-ID: <20241213145809.2918-3-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241213145809.2918-1-ubizjak@gmail.com>
References: <20241213145809.2918-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct zynqmp_ipi_pdata __percpu *pdata is not a per-cpu variable,
so it shoul not be annotated with __percpu annotation.

Remove invalid __percpu annotation to fix several

zynqmp-ipi-mailbox.c:920:15: warning: incorrect type in assignment (different address spaces)
zynqmp-ipi-mailbox.c:920:15:    expected struct zynqmp_ipi_pdata [noderef] __percpu *pdata
zynqmp-ipi-mailbox.c:920:15:    got void *
zynqmp-ipi-mailbox.c:927:56: warning: incorrect type in argument 3 (different address spaces)
zynqmp-ipi-mailbox.c:927:56:    expected unsigned int [usertype] *out_value
zynqmp-ipi-mailbox.c:927:56:    got unsigned int [noderef] __percpu *
...

and several

drivers/mailbox/zynqmp-ipi-mailbox.c:924:9: warning: dereference of noderef expression
...

sparse warnings.

There were no changes in the resulting object files.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Michal Simek <michal.simek@amd.com>
---
 drivers/mailbox/zynqmp-ipi-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index aa5249da59b2..0c143beaafda 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -905,7 +905,7 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *nc, *np = pdev->dev.of_node;
-	struct zynqmp_ipi_pdata __percpu *pdata;
+	struct zynqmp_ipi_pdata *pdata;
 	struct of_phandle_args out_irq;
 	struct zynqmp_ipi_mbox *mbox;
 	int num_mboxes, ret = -EINVAL;
-- 
2.42.0


