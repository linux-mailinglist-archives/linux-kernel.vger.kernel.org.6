Return-Path: <linux-kernel+bounces-556574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C64DA5CBDA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39D3C1896385
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D335C261587;
	Tue, 11 Mar 2025 17:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4dJB+Ex"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF9E184F;
	Tue, 11 Mar 2025 17:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741713398; cv=none; b=cDV3OoShfISIKIf1+fuHTiBoJ3nhieyXJkp4LlN46YAPDCNSGQT7zpVVZpuU9TIlW8+vUj+eJgCwSMxW7ejmuJIvulepGIN+jDBkGoftT4e03ynRkRztjN5SeToT4lqxpoNCKAhWTiYgQ08+LCH7+AzsYvaOS/Mc4ujFFGDWVOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741713398; c=relaxed/simple;
	bh=6VtpIaZAThOf4OSwD0QtCsTDKIARmF8cER4Japn3miM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZtmaBfvmiAzkIdcNk0jU9TIETLrIJcR6jSQ91UmitoIACUaRZYFWf59PAosqyFckaCmcs+Uo43eMZY1shtVsfdE77qC4vRjrIHrqrWWgMT0IOhTwtErBj/ly8Zj69PMFAwizS/LhUh0SdrZfdF+z/y4F7nLHZBK5/ORA2+nvnAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4dJB+Ex; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22548a28d0cso22021615ad.3;
        Tue, 11 Mar 2025 10:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741713396; x=1742318196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lT6HbYuunsljXKwEKEIlzgVY1rUKGqX9qGYC4t06fpU=;
        b=m4dJB+Ex2JhuqG6EXq9QoLq6tOBSTWdfi/1fHjSAiN8hL+VfjthQKMMuDqOUAjGg/M
         e9WzCL4V05dHJdjbqxcOK7ZPRQDwEh4e4TcpwWlESNw4dXcEX1ifK2AFlqo5arjYf5L6
         Ca3Q16C4AXTj0B9uU/AcRsVzclPU6eJ1jK8uX08CGQ6UfUEO0jHwhAfMk5Q4LC7XLtFA
         XleQS/fVULlUeDJij7MUzdCo3VIaaKqTvSXaogZIDjQJ59aKcG/CeGVbZTn+3/KQ/1xO
         0zzerRkWxfqt+RpQayeZgSHY43B+lXLV9wuhYvB7QJV7ZOZ7n7zxfGIw48KAH3Lr7/0v
         Y2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741713396; x=1742318196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lT6HbYuunsljXKwEKEIlzgVY1rUKGqX9qGYC4t06fpU=;
        b=wqDF9ZzfKrE1TKmm9GGgezVNJoD+99sisX2RNvNNgzkXVGfRAFipVwNlqSOLwr3GNf
         H08MKWRGKVbazkpHMKsLvNBwg/wqHfdXXaVGbrmJ+ZHCZurx/cr6b4mSKn4iqobcwY2W
         w5A2CKH9Ll06zbRZ1pQPJYGT7fonzGyY/kQABRUYeP0iB7SH5bMOz+GpF9usxKleVAvX
         vu1cWvFVfHIduFIaFat6bvfeN8VvcW3V2CG+AtzUkki08uouv6MjTjBJFO1/7vFwWkjJ
         IQv0cw2nnWoW9zO9XG3qVivqOFdSsa4u/7k//oTexDppSE1hntylt9qvnCSowHvFREgI
         T6pw==
X-Forwarded-Encrypted: i=1; AJvYcCVprFmiOllQJPv2BFxpDPeRyySiBW3Jzwllf+GFBkTf3mYU4ZXC3AKVjNcVOuavkUN4CG0lkeZborXctWo=@vger.kernel.org, AJvYcCWdIayAQLXlb8KZf+7OLFY567+qyv6rrFB2eM9yMGgUAPcs56VxYDYtS8wPAUUPdcsOw2zpFHh6ht3Z@vger.kernel.org
X-Gm-Message-State: AOJu0YzB5kttqWXQn3sQDQPcuAjbJkD+t+GkscsG5nG+RoerVJGpVMj7
	RwAUIGhfGqu1epE6fwWI0Z63I0sO7EQM9q6YeXlxyydIYqpuQxzgqkAeuQjRv40=
X-Gm-Gg: ASbGncv03DxGeWg4W0b7DV/z2niGvo8X46sptTK+XEMDWBza6bIXSBps9wfm+Ab3E45
	w3ha0TD1I688vNaoWJoRononDT5AdDr1tPkoQnccKZ7BiyZuidMmxDoVVmjOecXQRVr1JEj3q0e
	sTfSPjeXBmC2pGxWzDFoOH/JAf1tgTKOwT2Z+Y2L8iQYGwPEp0fj6DKopkD3efE/Rwg1wiC5D09
	ZLiRmfudw5G28wMCaNcV45exw+347gVhiuD6aoys4eyz7EHSAodCmx0u0C9rREdD6kY9wPvDn5T
	avwPgi4yOf6TgZua0c+/dLZG6q0zmHqSGYMvt9ln5yCgd3nxtDK84AIokVgDqvUXefBMMOHqdA6
	s0Eo/Kg1P6eSRYgxJnLlHYAnZQpXZE8yNR0a9ZA==
X-Google-Smtp-Source: AGHT+IH1OUso3CipiM8A7ut3LZdOM7zcTJ9rSxITsNl+2lH6MYI4WmDS3FW35rPKJqyjVMP6JZHB9Q==
X-Received: by 2002:a17:903:1a0d:b0:223:4bd6:3869 with SMTP id d9443c01a7336-2242889524fmr291812325ad.15.1741713396076;
        Tue, 11 Mar 2025 10:16:36 -0700 (PDT)
Received: from test-suraj.qjz2hk5f2gku1a3adsvczrat5c.xx.internal.cloudapp.net ([20.9.134.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109e974fsm100697625ad.78.2025.03.11.10.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 10:16:35 -0700 (PDT)
From: Suraj Patil <surajpatil522@gmail.com>
To: gregkh@linuxfoundation.org
Cc: oneukum@suse.com,
	stern@rowland.harvard.edu,
	viro@zeniv.linux.org.uk,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Suraj Patil <surajpatil522@gmail.com>
Subject: [PATCH] usb: cdc-wdm: Fix typo in comment
Date: Tue, 11 Mar 2025 17:16:33 +0000
Message-ID: <20250311171633.469024-1-surajpatil522@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cdc-wdm: Fix typo in comment

Corrected 'interferring' to 'interfering' in a comment
to improve readability and maintain code quality.
No functional changes.

Signed-off-by: Suraj Patil <surajpatil522@gmail.com>
---
 drivers/usb/class/cdc-wdm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/class/cdc-wdm.c b/drivers/usb/class/cdc-wdm.c
index 86ee39db013f..c5123db416fa 100644
--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -1181,7 +1181,7 @@ static int wdm_probe(struct usb_interface *intf, const struct usb_device_id *id)
  *
  * The subdriver will manage the given interrupt endpoint exclusively
  * and will issue control requests referring to the given intf. It
- * will otherwise avoid interferring, and in particular not do
+ * will otherwise avoid interfering, and in particular not do
  * usb_set_intfdata/usb_get_intfdata on intf.
  *
  * The return value is a pointer to the subdriver's struct usb_driver.
-- 
2.43.0


