Return-Path: <linux-kernel+bounces-425953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E0D9DECEA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 22:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72D0CB215BE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 21:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE181A3AB1;
	Fri, 29 Nov 2024 21:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J62llk9P"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4482B42AA1
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 21:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732915829; cv=none; b=aJpsAH/bEP2b2oxI/lS0teUTs3p5YSl8zvoRDK8ZwY27eqI0UQ2Tt1nCk2DNutqvISAFzUVdW2ZAnFQ5WX3+1EzLk74ZIawqHTdsPxA5hZeKVSgQHiHrgAa6UDBNwOf79MkQweqJMffb8fHzpN2qy3ysXuq9GWLbNDyRQySGOC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732915829; c=relaxed/simple;
	bh=nYkHkRvpkNdvIZJn2YLIhlMUISS+4WYqIuvfld/m/PI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aCOb5dRu+m9V+92PePkVlpK7ySxODpSMvCzUVJu698fi1aa6er5/KH/YjZvB1TXR+pGoglYlFWANE+qeByKyatjEZ2jI3gET0BRk2nlXcQTz6UFZrdwpNzQK9HhnyYTVg+zYIBD+KDfv8RflwuI/rz3TS1NAGuRiKnzDGxHy3C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=J62llk9P; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-51532deb8a4so582840e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 13:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732915826; x=1733520626; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zEtOYUhTm1yMl8PMnYbRP1+IklxVsjQpfdhOS7bdpKM=;
        b=J62llk9PlZKsdAkyP+lqGQ5De0sfnsBUWFhobFwV5uUn5E0IFZUoelz3V/4IgWs/jV
         HTreuBCfqDR2hgt9U90Q2Av0RWZAJPm5Y+MxLo81PfDziaSBKFzdoDkj8+5BnaHGKjiX
         Sae32WCzC0rI/DbKZ+1KdmyBhYZPbZxM/K3+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732915826; x=1733520626;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zEtOYUhTm1yMl8PMnYbRP1+IklxVsjQpfdhOS7bdpKM=;
        b=iCSxtb50FZXyPyVLZQbzgP4N29NPXBCk9sWglMMj7lQAYkYq8PvKSTmsjTQu4UmLll
         +JeT79/APuhRXd6snMRtU+FP2d1NSkCEOq8ydsfvhnWw/b4hi84aLw7+IaP+FZu47ZaU
         bXZ41G3VePkLRrOY53n1oOcfOmFc2nVxuHl29MloSVOMc9bB5usuDQNC7MzIodNWywC9
         /3XvKazZXTnEAb1E6AKRwqHn/vH3ygET+S9HUWGZO25uDIK6+JaSc80lnKe90hpbSaKc
         h9lIZW4sbdHxXynto+Tyt7YOqWTODD1T6XOkSrSXaiMJsWvEnvO6enILClQo18K3/HDA
         TjUA==
X-Forwarded-Encrypted: i=1; AJvYcCX4qWSIBQ4+S+JrjhLe243LT7wWI+1Uw8MKvwcQBJnM2wWYmwYodcxiZ6bzA0E1Uz/pxLx+ul0deCBViBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX5LHQt3oPKz2rRKvFDyyf+lNo3k1o/c+sZnttWtIJRrVzOqeV
	+af7tWRlxS6kKC9AE6KXnCJ54uduMzzry2FlzeYwt4qSFMM53tsTlkgmR6tYBg==
X-Gm-Gg: ASbGnctr49tCZG2/rxpJ9yEXt8P5dOW4jZ3WBRG3a+eM9fP+k+avLpD2R6NUUYX1mTs
	hmfhl12IjGESK/GHSgU7R4Lr9gkd/6NNBoEfaOtVRsYgXwSL4Y66oDYeiT0wVx6fqdRAqBqKptd
	YrN5vN8LuXsMO9pEfZMMGWcYAI4N4GrWtXRjWMiHK3srNVJ10DZGuM0MUroQGDqYJ58r5DqKdr7
	6qkoKHxPaUaYk1lyOy4tjCKEby8tksN7EvvGOI/PYCei72GXY3M/eyGGEDZK8bOoGyAmY5W9wrU
	gHDPrSsWV1MgpunuqwtiLdGx
X-Google-Smtp-Source: AGHT+IGNpp6QJ5chVFfuFB5iPzglq9eZ6jrKyiQH4gSZcL34SNi57YCR7FzR3uBuvx5B9lJaPSfVYg==
X-Received: by 2002:a05:6122:2002:b0:514:e4b9:7605 with SMTP id 71dfb90a1353d-515569dda9amr17740611e0c.8.1732915826133;
        Fri, 29 Nov 2024 13:30:26 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5156d0c1b7asm607254e0c.36.2024.11.29.13.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 13:30:25 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v4 0/4] media: uvcvideo: Two fixes for async controls
Date: Fri, 29 Nov 2024 21:30:14 +0000
Message-Id: <20241129-uvc-fix-async-v4-0-f23784dba80f@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGcySmcC/33MTQ7CIBCG4as0rMXAAKV15T2MC/5sWVgMWGLT9
 O7SrkyjLt+ZfM+MkoveJXSqZhRd9smHoQQ/VMj0augc9rY0AgKcUpB4zAbf/AurNA0Gg2ktJ5w
 yZRtUNo/oynPzLtfSvU/PEKeNz3S9/pIyxQQ73UgAwahuzNn0Mdz9eD+G2KEVy/AXgAIISpTSr
 ZDE2i8A+wTaPcAKoHQthXF1bbXcAcuyvAGaqKXOLwEAAA==
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

This patchset fixes two bugs with the async controls for the uvc driver.

They were found while implementing the granular PM, but I am sending
them as a separate patches, so they can be reviewed sooner. They fix
real issues in the driver that need to be taken care.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v4:
- Fix implementation of uvc_ctrl_set_handle.
- Link to v3: https://lore.kernel.org/r/20241129-uvc-fix-async-v3-0-ab675ce66db7@chromium.org

Changes in v3:
- change again! order of patches.
- Introduce uvc_ctrl_set_handle.
- Do not change ctrl->handle if it is not NULL.

Changes in v2:
- Annotate lockdep
- ctrl->handle != handle
- Change order of patches
- Move documentation of mutex
- Link to v1: https://lore.kernel.org/r/20241127-uvc-fix-async-v1-0-eb8722531b8c@chromium.org

---
Ricardo Ribalda (4):
      media: uvcvideo: Do not replace the handler of an async ctrl
      media: uvcvideo: Remove dangling pointers
      media: uvcvideo: Annotate lock requirements for uvc_ctrl_set
      media: uvcvideo: Remove redundant NULL assignment

 drivers/media/usb/uvc/uvc_ctrl.c | 62 ++++++++++++++++++++++++++++++++++++----
 drivers/media/usb/uvc/uvc_v4l2.c |  2 ++
 drivers/media/usb/uvc/uvcvideo.h | 14 +++++++--
 3 files changed, 70 insertions(+), 8 deletions(-)
---
base-commit: 72ad4ff638047bbbdf3232178fea4bec1f429319
change-id: 20241127-uvc-fix-async-2c9d40413ad8

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


