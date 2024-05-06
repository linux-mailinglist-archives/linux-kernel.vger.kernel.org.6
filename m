Return-Path: <linux-kernel+bounces-170335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 724448BD55E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 21:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0384A281018
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 19:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0326815920A;
	Mon,  6 May 2024 19:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DDvXz6fr"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4983158DDB
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 19:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715023490; cv=none; b=Z+CxIa53x1YqChn4tD9+7LXhRGbqJ3rA8FqfzOgv7qJ6e+dGw0KLiwY4x0uOtcMSwOzvbg9w/Hf79caf1e4z/+ZHynPhglmZXPbkbZ6ugOFdGhR0/+uTK6CSEBtyvbhkwbvgxVwHHBncG5yPRua8wmJ4jc0T5dyhFRxRTOSf0/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715023490; c=relaxed/simple;
	bh=zYQt3qI8XJ6OrpFv0IMRqdOFJF4KoM/Pb6Vxm24ZDw0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HJe9ObO5DFrOB6Wsi5TyTmp951wOb+45PE50O+VfKcG0nwAgUiIUf73FqUsdB+/o0mIqs2DWH76JvKNe2q0EGFbr/mUUQvfzv+BqUK2E4MC4M10JSbplCiVdPkjRYnNoDAvAcBbhKvqLKfMR9OG6WRrZOnHXrp3h5XGJMum4qBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DDvXz6fr; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-de45dba157cso1836151276.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 12:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715023488; x=1715628288; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=62kWvReLX/MoSE8YfO5lP7Yd06Z/Ka4KHCr15yccf+k=;
        b=DDvXz6fr/orRvcpyTP3J7rcKlD+yrt/zWzjwldVNeZhxQ42kEep7NxIphzhJxU/anx
         fTA0VYUvMDRPaJ6v7pxan9IH4Rxi53Za04ZNvBx3PSCiHQIn+wqoAvFiplN4N75+5Il6
         Z4JNe6pfBmA6NvPQ8OWgYVZBFfo0oUU9SunSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715023488; x=1715628288;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=62kWvReLX/MoSE8YfO5lP7Yd06Z/Ka4KHCr15yccf+k=;
        b=W4qjpZ7XgCObnuA7f6HuqOm1hT+HWQzSvzlzQ+KHWwJKWSIaA6u8W5ZG9dtb2LpMAB
         UMWaj/7fY7TxV8O+VcnAI+xn0YhjhoDK14U5OSL//6gCXihaGEGDxTh1vsAIWyDfWSi1
         AQYtJ3ANJTWLwDr0fls0ebk+PlVc4DjCmLf4F3EqsLrxpfi4dRK0C3qTc17K4KIhj00m
         +3pa9s4KBv8DiHS+zQAVOQKXEXotjSWWexjVjMvJ+xZ1SRBWViCJ6CUBhskucAh2s9h7
         JT8TUIgSzz8PK3G3vftA1KfBax7Me6Gp1FN+uoAZ2frbMEf1XgOwA9M7PHvhbuEscb2X
         LYPA==
X-Forwarded-Encrypted: i=1; AJvYcCUT1BTDm1pwHfthRW3QiOxnLrOQ5NxJHPWouC8eHwo9rZDEM6cwgBoNfUfJSPCaaVEblDl+pJg5NQgKQ0K96ECf+jK2JDMNNXLX3Uz0
X-Gm-Message-State: AOJu0Yw5E+DOqIY2AQNhIL8KWDNDL2MDvBlazXeq7/OXbacVAx0NgXz7
	P7zxD4h2OL4YskNVrDRrp5bvF6hemjspStn6Limei/fDRXVO3Y7pwy0dcIXQIQ==
X-Google-Smtp-Source: AGHT+IHcWb5E9ASAPUj9u23aIXpNd71I/CHj/yN0+WqkyFpwUUf+ilovhGe30lBMZ89taFLE6XUZVg==
X-Received: by 2002:a25:80cd:0:b0:dcf:411f:e78 with SMTP id c13-20020a2580cd000000b00dcf411f0e78mr10894973ybm.25.1715023487747;
        Mon, 06 May 2024 12:24:47 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id ch9-20020a05622a40c900b00436e193f408sm5439870qtb.28.2024.05.06.12.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 12:24:47 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 0/2] media: bcm2835-unicam: Improve error handling
 during probe
Date: Mon, 06 May 2024 19:24:45 +0000
Message-Id: <20240506-fix-broad-v2-0-e6a2a5c0d609@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH0uOWYC/22Myw7CIBBFf6WZtRheptZV/8N0ARTKLFrMoETT8
 O9i1y7PvSdnh+wJfYZbtwP5ghnT1kCeOnDRbItnODcGyaXmWnEW8M0sJTMzPXBvhVFDf9HQ/Af
 5dh6t+9Q4Yn4m+hzpIn7rv0oRjDMXlL0KG4Y+hNFFSiu+1nOiBaZa6xcduODmpQAAAA==
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: linux-media@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Hans Verkuil <hverkuil@xs4all.nl>, Ricardo Ribalda <ribalda@chromium.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
X-Mailer: b4 0.12.4

Improve the error handling of the irq errors. I am not sure why the
retcode was replaced always with -EINVAL, so I have returned the errcode
upwards.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v2: Thanks Laurent
- Squash 3/3 in 1/3
- Link to v1: https://lore.kernel.org/r/20240430-fix-broad-v1-0-cf3b81bf97ff@chromium.org

---
Ricardo Ribalda (2):
      media: bcm2835-unicam: Do not replace IRQ retcode during probe
      media: bcm2835-unicam: Do not print error when irq not found

 drivers/media/platform/broadcom/bcm2835-unicam.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)
---
base-commit: 1c73d0b29d04bf4082e7beb6a508895e118ee30d
change-id: 20240430-fix-broad-490eb1a39754

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


