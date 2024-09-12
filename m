Return-Path: <linux-kernel+bounces-327323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 022E097742E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 00:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBF9C28658F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 22:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C541C32F8;
	Thu, 12 Sep 2024 22:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIL+Mu8e"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D28192B73;
	Thu, 12 Sep 2024 22:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726179436; cv=none; b=CnL5/ZmltHp4c53jaGb3ogn9JKDQdwkDUKF/Env6FdQxmo7t38QmcoB6ex50GdtyR6cPPFs6dS8TYIbt07YGbogrV4WZ1nMxP1SG895RJ53YwEZd/+PC9IMeFS2xLTiPvTe/vEWb4l8w4pLCSwF77z+zwtDW5UU7SXTLvrD8CZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726179436; c=relaxed/simple;
	bh=Bij5/YhURVVDCaKqUBDPkxrf248AzybvHLaiNQ5X3pw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=axaMgIJ7hzlulsOtbsS7TYGAiQJCAdui/NjvxMWmB8GYNd5IFSaEBexHcWv77kTdjJXsHNElbrL+0of+P+2ak96iKGVw1K4CzYQ+lV6RCuDUQWNbwq8XxAcyzTt2Ao1/NMbxQAUM/CYDyEUHitnQGfGRvS/v7Ks7e0GmpNUQ9eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIL+Mu8e; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9018103214so205604666b.3;
        Thu, 12 Sep 2024 15:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726179433; x=1726784233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KHvYLzv1YYt/E3AO0hUXv6+oKZv7r4AbD6O8nGGAPr8=;
        b=iIL+Mu8ep2Vu+VbynjbqDSoajlXM26up1if3HfAQ4Q9QiBWnKiRkDZvuwYZtZt/ViR
         6BzUDCMFLZctVf67/sy2wDZr8A1K05ep7QuUeGoUpDS2fY6H7dayQmA8VDsRa6t5PKFb
         CShe3ULrjdw+I4BUmnqzqD0/i45irxcY4z/IcR/I2TRpdkSi/sddGQP85pNGJ0hZYYBc
         tPWoowKg3EzlhtNQpB77JXIbEcvxkR4TiG/61N+8/EQp05hXypdDRARxAwJp4uO13d6M
         sWzN/FInv1Ou6/pm5tHJof1G0Lhw0Oc2ZdZRtE2jiSQeZoKC770vQpb68aTSea1S4Oa+
         a/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726179433; x=1726784233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHvYLzv1YYt/E3AO0hUXv6+oKZv7r4AbD6O8nGGAPr8=;
        b=bLQCpEvibeC1/sJg/RY1hNATOGhEBiX9oODPX9E9mNlVSlwenSUd03EwjSQR2AIJl+
         eGpRV2QIlgnJ/QSvSebmmxKvfU4ySTUm38MD3zcTsTf4v1qpQLe2g3sBj7x6mCo/BA96
         lylke1BVujGvfm08MjPOPERRxp47+oH+WRd9pjFxfTJZ9QLzag3D4oAS6LvF4wlc1VjE
         gfhVE2KUoMXA7ngEJkrDoo/xXyK5BUOhG2KKAKxye6EnPKCZRcFkhJDRqjmpsSbpjmmV
         YpBwc0SmUavYMbDCtwOHi07T7hKRoleNLjtLyNIFyI/eZ9D044Q4PBY+inhClLzvBLN1
         uM9A==
X-Forwarded-Encrypted: i=1; AJvYcCV+GqLcy/tnzb/FS2zSMqLzdBtCKh1ksHYcOyOtU7v3AhFNVuf/O41Kd0lj7KWo2QFBaM/mD5IjvWgZ@vger.kernel.org, AJvYcCWybAM3xXrBu+LeJsekYcHcOnFjvW8qNmYpdZQMkwuCJrh4DzWGgt5g9t6DDp5o+hdk4uIcJ6dGbOVZRVMr@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo76apXmYbZq3Kim4mBVw8lc34p9cwo04AStLbYIb3uwn2q7XS
	tksqiAdnKX8DwCnvc3GA0RomCp1uOQKQXDivyWHT3aIXQGDKKZNk
X-Google-Smtp-Source: AGHT+IHYsb6nZJSW+yUye7pU19s6likRvHKq1P+J4ytwPXabDlMcIieFPgak75d1IeC3LVi9mtFucQ==
X-Received: by 2002:a17:907:7ea1:b0:a86:ae95:eba3 with SMTP id a640c23a62f3a-a9029690d69mr357904266b.62.1726179432387;
        Thu, 12 Sep 2024 15:17:12 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:85e4:cf41:16db:65d5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d5491asm792195066b.198.2024.09.12.15.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 15:17:12 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: robh@kernel.org,
	saravanak@google.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/2] of/irq: Make use of irq_get_trigger_type()
Date: Fri, 13 Sep 2024 00:16:04 +0200
Message-Id: <20240912221605.27089-2-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240912221605.27089-1-vassilisamir@gmail.com>
References: <20240912221605.27089-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert irqd_get_trigger_type(irq_get_irq_data(irq)) cases to the more
simple irq_get_trigger_type(irq).

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
 drivers/of/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 36351ad6115e..5d27b20634d3 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -430,7 +430,7 @@ int of_irq_to_resource(struct device_node *dev, int index, struct resource *r)
 					      &name);
 
 		r->start = r->end = irq;
-		r->flags = IORESOURCE_IRQ | irqd_get_trigger_type(irq_get_irq_data(irq));
+		r->flags = IORESOURCE_IRQ | irq_get_trigger_type(irq);
 		r->name = name ? name : of_node_full_name(dev);
 	}
 

base-commit: 32ffa5373540a8d1c06619f52d019c6cdc948bb4
-- 
2.25.1


