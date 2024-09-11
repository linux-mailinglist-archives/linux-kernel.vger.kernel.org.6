Return-Path: <linux-kernel+bounces-325325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F29789757DC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 18:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA1371F257B6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57921AC8B4;
	Wed, 11 Sep 2024 16:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zn9EZBjk"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BEF18661D;
	Wed, 11 Sep 2024 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726070595; cv=none; b=X5zfi6lz1OgSEAfXgK2pW6uaRJ6GLdClkC9x615b738Jod2w1MUAaqf+HNy42p+94ubBsZHy60ymbE2JfkHPu2XkRK14LVQYHKvnoaRLgecT1+l86AydPRyyV3xk0nYruaxNwungSfMHC8yNwmeF6NMXUGHlRehLLctprMWBaQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726070595; c=relaxed/simple;
	bh=xbRcATivjgm/sE1YudVstshOSkLYRy/eY634b9h8ErM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ESKzApfebXk0cecBIw7MV8ONu0Ev2Gx8T0YJYeClyZx1YmGRWJs1ty6AKQvYNqg+jsobX60E0PTQl9z2XjTlSspo806sq0BeyQJi0Kuz//6oCpsk+NFNI6gmEqITmC8tDukHoqBEEeBKMgY6nxaWkolJEO4NxqmUjamEuXN56+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zn9EZBjk; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8d6ac24a3bso212900766b.1;
        Wed, 11 Sep 2024 09:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726070592; x=1726675392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tDdL8pJJUF8mC/Yn8I6KTQHoYYF8JO7wN7QCrHyb0Xw=;
        b=Zn9EZBjk1Uxdxo5AgHkBA/TWrp1whoiSK4qdj103o7N9kvjHFMfgZTCBdBLtUBzZQY
         MvtAlqrEkXX3IxXT8py4dZx+f/fSxIz3Gq5hLyHmS+jfaAQNmCNccbDXZ62V5dmJYdpZ
         uswAz/7UIvmkgNJORXFuiDpw3DXXH4RCF0YsZbMhlXnTWCjRqLHkeBDWqssaUYVbiC8j
         snTqMiW5bfFaNb9yXNgUNII2L1yDyX7qkT+duuRrWlz+wXnjq5s5HYBi20XHS+AJNvgZ
         CPzPfNRSOTD7HPLYakdljs3+kozWE//C3hAjlwtI3J016upGfB1Xlynz8aK/KKnSNKiv
         YiPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726070592; x=1726675392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tDdL8pJJUF8mC/Yn8I6KTQHoYYF8JO7wN7QCrHyb0Xw=;
        b=PmmgL/Zz8yCw3iZc+inF2/9OQ2KvtWMVLn8c8GyQDAfl4F8zcfu+BFidxVw1FVp1p+
         /yLlgDvYyKpTcCQ7u1gXNVsXfnuW95rovFm5JQcyOoXG1W7Tg0XWEnBtuzGpsvNmyZIA
         bqifFeAyZslGb99KcLpF9R8ZvntbDmp4Rje8vNZFCGGphoxP/EEfx2fa+BLO+Z1kXJ9y
         okqBlYC/5TGgHB6doyYrsRIKz0+HQTHYy5TR65cV/K4dgkiAYqOHrv+nDMYeSB4jyEWl
         0X5mDJU1P/Thx/0w6ivBNqmzlaw7mHn19ptIT1P4bArFSdG71kL6r/f7B2vyuBp27eO3
         PaxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8UXMRCZO7vfMSJz8ZDEJY2L9kn2LgVdpBTdv1eCG+OBvgYZIgLQfKtuwkp/kM/snZVp/RD8IbNwzqL14p@vger.kernel.org, AJvYcCVF+c5tbZ9TxhxF3vdCEd7OqTkwWwTad0OQAii/6eSc4BYotzTc36kylmSeWNesh8TFGfpk4ywRRl0o@vger.kernel.org
X-Gm-Message-State: AOJu0YycJkJh00G0xSdEYgb7oJWpI/mFXgDdZvthd9GE/+et2SwmgHZX
	h2YikdvCFnJgLKfqATroKsViEFrRwockR9ViaV5drvvLTov8I/YL
X-Google-Smtp-Source: AGHT+IF2bCQ3GBaU3z1lFHs0ASPoYsp3Vcro1/OHMCCSBZXa4+V+FstZubhztKjZAwea7o79zjNwWQ==
X-Received: by 2002:a17:907:2ce1:b0:a8d:41d8:14ad with SMTP id a640c23a62f3a-a8ffae3fd9fmr611868666b.29.1726070591163;
        Wed, 11 Sep 2024 09:03:11 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:797a:1b45:332e:77c1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d64880sm621635466b.219.2024.09.11.09.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 09:03:10 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: robh@kernel.org,
	saravanak@google.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: andriy.shevchenko@linux.intel.com,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v3 0/2] Use functionality of irq_get_trigger_type() and DEFINE_*
Date: Wed, 11 Sep 2024 18:02:51 +0200
Message-Id: <20240911160253.37221-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The series is compile tested.

Changes in v3:
	- Fix syntax error in patch no.2

---
v2: https://lore.kernel.org/linux-devicetree/20240904160239.121301-1-vassilisamir@gmail.com/

Changes in v2:
        - Split patches to subsystems
        - Use DEFINE_* helpers to define resources

---
v1: https://lore.kernel.org/all/20240902225534.130383-1-vassilisamir@gmail.com/

Vasileios Amoiridis (2):
  of/irq: Make use of irq_get_trigger_type()
  of/irq: Use helper to define resources

 drivers/of/irq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)


base-commit: ecc768a84f0b8e631986f9ade3118fa37852fef0
-- 
2.25.1


