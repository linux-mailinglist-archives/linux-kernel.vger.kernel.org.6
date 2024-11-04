Return-Path: <linux-kernel+bounces-395322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B2E9BBC5A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 18:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07321F23277
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD1E1CC14C;
	Mon,  4 Nov 2024 17:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0Vybybq"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5554F1CACFD
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730742634; cv=none; b=ii1bKmoYsS1sFXIcf8J8FBB/Nh60C7fdnejqMllX9cq7ZBdmsYLx6wqu34/cdRweNBu5KfIok/5hYzaVnGtyTKU7eVEf66CtRMZ/oVjdqFJ1v0D/ohkNgkWuIfMFDIw8nRxWZbj/dnTSATt9Z0WAAcOZCC5h37B83V66MRglWpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730742634; c=relaxed/simple;
	bh=vQzpGg7deYclM9yBsT3wwI2mUpipEYQCDmwXV/+K5Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9bhCYsbhsvVjDq9zWMR9klzBwijuxCsFUdiHqrSa9RfqHd4L5fstIjgPL2T5tuevJns1E/CJBAosp1gAykykkJ9TTqpzg3t4Znrtc7UZCiGEAi+RPodKh+DepHd2GJEa3CS1/RTq7BnQT1+ByMSYO1zd5lyFpT1y9hM1pHVGBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0Vybybq; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d55f0cf85so2945640f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 09:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730742630; x=1731347430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DD8a3bEYVTRlBul1UBKXN/QyJ117Vbrsn/u7Gv5aRXI=;
        b=X0VybybqQwnp430YY6lTC5Xt+lMXtSuBL7OLFxOoMbjceJZZHfLqz0baXoVpmgT0qm
         FOcaUoWfUeYPJFkeZPZ9w+HQis+xx8M4Abgc7NP/AWb42HF8rfTY4bHZkcUdJS29hJRV
         EokGCVahXADdagDHg1KzrSRhQ7RZ8V0NcHXgX+fBYlxZidI2NT9auku4Sw7ZHdydS+iW
         UWeId+IdWOM9hNhbLjspQnIJK3Eaf2I5KS3ZQUUvkHIp7hPd1VbtXf0LY19coMmzgmbJ
         KafdtYAS1w8ssM11MqJibWEELinSbrMT7nUf1LxaDDUiuO1H+IcN2+1C9XSO0JQouanp
         0v2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730742630; x=1731347430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DD8a3bEYVTRlBul1UBKXN/QyJ117Vbrsn/u7Gv5aRXI=;
        b=i2N/Rw4LyxDNPuu8wqsLe446RZ4uJ06D3qixuamodoc0JRCYqw1PFhJTEdDi0OekvN
         w2OkPg95jz9Vj7exYsVyN3Q2B+XAk0iEI6cELaNSSXxxxGsuyc36s1CFKg+MEnEy3Bew
         az3Fj0pKqIcQ0lNBc6udQDJ0x3snbF81wvWWWLEWEDtVTUHP2D+3MyIeNcKTp6/kvNYy
         dde12vQjFOXys0W9rMBU1kDGaMlKUf4OB4ibpNhp3wj+Ulimvae3HCqHEulOrhs0BcYK
         ODCmHJf7kw9FGPutFNaAiopqlP3ohxF36KTkB40uC8tkswoYxutp2vHV+40GduIz9DLA
         +Kcg==
X-Forwarded-Encrypted: i=1; AJvYcCXRCPSuhd8OhY8tunOyFXn7wC41h5Kw9eFlgSGkgwXF99/CX96dh7wglP+uhwQYw0Z1Y9PfRLtPtRiDZsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWsIScDT03bkgBLXkDBdt3vQYKSAkBY31QgmAIz1q9zF29l6Kp
	n7m3duqwc2BvveJmsAGVE9EMCuwF2rGYPPw7EDBh/LVdxj9/5vUN
X-Google-Smtp-Source: AGHT+IGXOzZj3KlJpbXOL+v3I9GmYe6fkZ2MRZtotgWqVaFVvxrrJgRkPxCxh25tQacS3aOFS9nVSw==
X-Received: by 2002:a5d:64a8:0:b0:37d:46e3:4e88 with SMTP id ffacd0b85a97d-381be7654c6mr15656681f8f.9.1730742630403;
        Mon, 04 Nov 2024 09:50:30 -0800 (PST)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7f80sm13839821f8f.20.2024.11.04.09.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 09:50:29 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	arnd@arndb.de,
	dan.carpenter@linaro.org,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH v3 06/12] staging: gpib: Add comment for mutex define
Date: Mon,  4 Nov 2024 18:50:07 +0100
Message-ID: <20241104175014.12317-7-dpenkler@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241104175014.12317-1-dpenkler@gmail.com>
References: <20241104175014.12317-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle checkpatch CHECK message

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/agilent_82357a/agilent_82357a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gpib/agilent_82357a/agilent_82357a.c b/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
index 02c6ec9a42a0..a6b177d7f8a0 100644
--- a/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
+++ b/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
@@ -19,7 +19,7 @@ MODULE_DESCRIPTION("GPIB driver for Agilent 82357A/B usb adapters");
 
 #define MAX_NUM_82357A_INTERFACES 128
 static struct usb_interface *agilent_82357a_driver_interfaces[MAX_NUM_82357A_INTERFACES];
-DEFINE_MUTEX(agilent_82357a_hotplug_lock);
+DEFINE_MUTEX(agilent_82357a_hotplug_lock); // protect board insertion and removal
 
 static unsigned int agilent_82357a_update_status(gpib_board_t *board, unsigned int clear_mask);
 
-- 
2.46.2


