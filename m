Return-Path: <linux-kernel+bounces-327425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA069775D7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 01:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1BB928329F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 23:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6FE1C331F;
	Thu, 12 Sep 2024 23:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aomNv8uG"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87AF1C2DCF
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 23:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726185573; cv=none; b=Yhxtmj+uN0RUFEMeRNlNTGFI9cPZ77AYB4rLlz1lBIq6fI8JA9+BIGu/HkwOmQV4kcAJnbqtd8s5R1zg95ZxSwbSOQ7XzOuGAbXWH2SSJwA4eOoXVFqFNwYGAC8XeIyHh/dfQkQ7H5G7HTWZkYC/XrdsPrVEhhwywNggJP/yP+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726185573; c=relaxed/simple;
	bh=jPZchWM2ui1wxwnw3sWqP7GpKlXUfuqgyYQH4D1wvR4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pinQWVLT3X0qE/CykWQAEXhManQbuV9Xd5xJ9DFMp6pWjzIk+WPP47D6/uwe3zYj0zR0Wgm2RrxiTW8vs9Tengaul7nPNpKog7zKIllBna3yl4sXmjCfLo9Bng8wm8p99Vu0+Aw9nu9V0TZ4IL+p5JjY39py6kedthx4NS4sz04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aomNv8uG; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cc43454d5so2614145e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 16:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726185570; x=1726790370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T6m3eSibUK3LY1K2+PoC30jZxHrsKoFzi/HGGT6W7Jk=;
        b=aomNv8uG2lR9ouJoAYKLpUnqJe6NOQw5klknCWbDPlx9QsMBEZWMswCQCYX/834yBx
         K+6Bdu2/F0t6vqu+T5ieDI8FjXOsNxb85UUI/wxfZeNCGPm9CzeyTphdnOPsj+WufiOd
         9nS+1ynodiqMKxopKWB7oqHuVtB7hP/zf0Fcd6C504TGBXqDqFNC8c6UUvSzUrkWZ8wU
         X/QlbvCwxvT/A1n7y5/2qmZ3Fwkv7n4ZoG+k3DorPEIo9kV5Z4iTkXopF1z6mT/XtsdY
         MGqS4FR5YXwWgAdRL9EDhurUcBCnYomH2yoWFrL4NZ8bLLJn3Y7hTHbnl5H8KfTJa+nz
         B8GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726185570; x=1726790370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T6m3eSibUK3LY1K2+PoC30jZxHrsKoFzi/HGGT6W7Jk=;
        b=S3ZGVpWao3q7NRkKf1zwIsGoZtsdXV79zHff3awuU7xbrHPh1nP3r3FyXbF/jMQDmF
         WTKIAzZFXyk5BVEmnRVcbBUpxn2wgVc71bU2S7t9IP8FZWKp91n8cdoMpY/u8tjo5Ta9
         JYMoE6eSMTb2weHzcff/aauQeGN7FLc4sZf+ItL+d6mh0f0vHHmJz+3Kayvjqsn3Mkst
         v1ffUaoviQltZhDjIFF2cr/hH6XO/skznCea73AAzdgruFBDJCFhtVPQoyBu4UGMjWZu
         xq9jIb+fQ3XWIdyKdsoOBIxFDd2YY0CNB3EQ0F2NxOKbQ+z6MdSZF0wEZnWw2AmBzRPW
         /msg==
X-Gm-Message-State: AOJu0YyHwi6iaRdJeA/DTWZSGC4HxEkkuHjR1QKjrwixJhKTohiB0A2q
	iQrJu2G7UOy6/0vK3AoRteWPq+Swa2ojp15alk9a8y+7Q6sOZBNP
X-Google-Smtp-Source: AGHT+IGveCIpyeI7JfMf20IVD1+Vr0TKhebyZ0wy+4r545E5y09EUl2pHQeCtVBh6Bo/+JHaGTgplQ==
X-Received: by 2002:a05:600c:1ca8:b0:425:80d5:b8b2 with SMTP id 5b1f17b1804b1-42d9082a676mr8372765e9.16.1726185569580;
        Thu, 12 Sep 2024 16:59:29 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:82:7577:85e4:cf41:16db:65d5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b054f97sm6025175e9.4.2024.09.12.16.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 16:59:29 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	andriy.shevchenko@linux.intel.com,
	Vasileios Amoiridis <vassilisamir@gmail.com>
Subject: [PATCH v1 0/2] Use functionality of irq_get_trigger_type()
Date: Fri, 13 Sep 2024 01:59:23 +0200
Message-Id: <20240912235925.54465-1-vassilisamir@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the irq_get_trigger_type() function which internally calls the
irq_get_trigger_data(), to remove check and remove the irqd_get_trigger_type().

The series is compile tested.

Vasileios Amoiridis (2):
  uio: uio_dmem_genirq: Make use of irq_get_trigger_type()
  uio: uio_pdrv_genirq: Make use of irq_get_trigger_type()

 drivers/uio/uio_dmem_genirq.c | 5 +----
 drivers/uio/uio_pdrv_genirq.c | 5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)


base-commit: 57f962b956f1d116cd64d5c406776c4975de549d
-- 
2.25.1


