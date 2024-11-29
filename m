Return-Path: <linux-kernel+bounces-425896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9826D9DEC55
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 20:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FD16163A81
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 19:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A064A1A2550;
	Fri, 29 Nov 2024 19:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nVj/79Bh"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A3719F423
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 19:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732908311; cv=none; b=mcBSPFAwKcNblwBukC5oIvjICbt/29w5aRxQWjnX1rqhFSmHhB/fFS+rCkxKL7oFKFtWyhv1dJKZcFEC8vc2i82OYDV3U3NEsoBOKLrvyaBsq+cN56rZoFUQbW8CoGWaoE2sCdUqxAmxq0rFvx8VOq/wMHG7ahY6hURhZMlIbLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732908311; c=relaxed/simple;
	bh=d3jo76PXC/T9EhC8p7wrOR6nkhpDa7Ba6c51n5/cPbw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WMipEF/L3b46ifhDPBsyJgScJeCk9GYDYPA7vWO+o8NCX8QsHRmd1D+4aK4F5Qs91nDX20Ho/8Rrz3aIvws7WL38c0luC46OJgR805Zh3GcVEL7Cvh34qu4Ywqy1xOJRo7ZI/jpP+wvICLsHZd44h0UyJuFASJa12/Lu09Ud774=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nVj/79Bh; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d87d82622fso11645176d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 11:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732908308; x=1733513108; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2P6kqxYG7hM9Q3T51ND+biicoWpc9nKwaL2ZX51qqtU=;
        b=nVj/79BhZOAjgaa9mcN9C/0rhbTz0TIk+YETGTCxjMf0R9dBzVoiyZ11Au2COMWwz/
         PCASjnVS9bZa3r90jbdV/3/Kl0zSGzlyddCbS8mzQEw7h/tsW8TtcubWnVk93X/Y8mL4
         Wws60iMpMF+j+1mDoLwfMbZmB6VCpTgFz8MTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732908308; x=1733513108;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2P6kqxYG7hM9Q3T51ND+biicoWpc9nKwaL2ZX51qqtU=;
        b=QqxBBTP1sAyDee4jjYSoejlFp+aN3Si3EYuCKu55Vtc9cabdeSSvcEqXiy9tvCHlC6
         UsDAhnfj2E8d6F+Rafbqz8DBxXJkMviY758XmuhRbeMH252cCbHGEPPhdTr1GNZE3eL1
         N1LxckmmVtL7nxJrADctp2GNNO3fsIOFLoMRBdAd+a0L0B+zWA/VkJN0LHLtjDSBideC
         a6OAIIKa4mPrfe7siPMVH5S/2KfdI61UiE/RJvSJ4jgmuUiKkO2jQmyn6ea17+gyrVP7
         G6D6d4oXuzoGxeY0+UxrodLz/gx+8em2ELubkbesQR7w9raJMZcQEujgS99Cg0y8Ad+6
         5p3g==
X-Forwarded-Encrypted: i=1; AJvYcCU638lMObdijWui8dIAeiKklg4u6NBDYRD8lJvuTPEt2rRI+1UHJwZqweP/lJZTJswQ52zmVc66sYJEqZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIJ4njztbCUi7lQe/dOr/puvAWYWlUI9SvQlAeyT3lIY5fBtpI
	EtFcM+vYyF5KwJhivpB3t6D7hNFEucsHw9s+meYyWqMOQQ7iI4LezFdm74NKpA==
X-Gm-Gg: ASbGncujRaON6eZHzbVxwOObdAJIALdUSm0nyiYb1yxX5At0pZ5zYqUNXuLfLQECixA
	vdfK3AoGqkCnNST6Ukh385/FUj5Th4qZlVqdRLdmzuaN0/zGFqBjpsD8cWYe6Dyrh5WtEoTG8CR
	yVkm33y+nDL4ffNMCNuInZnhTtzj9Tq1yxOcw8nXnN6zugtFqKIN9nRpJ7MUcHPgDB/1Pg4Aq7k
	fr8fhFW4sgNPXalv+ruw5SdQ1SuFHleM7VmK4LX5ZIPVzNOLwkZCN43gu0X1nPDL1p88LaubTeW
	+fF8dxKstS5nkOvCfibtFSTk
X-Google-Smtp-Source: AGHT+IF3hgYG3FdIyAGfBcYlUz8j+jglg5M77s2kJmvE8nmaEsoixoMlG1D63xrZAR1waGtasuM8rw==
X-Received: by 2002:a05:6214:20c6:b0:6d4:1dc0:2623 with SMTP id 6a1803df08f44-6d864dd30a1mr191445156d6.32.1732908308478;
        Fri, 29 Nov 2024 11:25:08 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d87d899ec2sm14462146d6.50.2024.11.29.11.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 11:25:07 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 0/4] media: uvcvideo: Two fixes for async controls
Date: Fri, 29 Nov 2024 19:25:01 +0000
Message-Id: <20241129-uvc-fix-async-v3-0-ab675ce66db7@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA4VSmcC/33MQQ6CMBCF4auQWTumM4UArryHcVHaCl1ATSuNh
 HB3C0sTXf4zed8K0QZnI1yKFYJNLjo/5ZCnAvSgpt6iM7mBBZdEXOOcND7cG1VcJo2sW1OKkqQ
 yDeTNM9j8PLzbPffg4suH5eAT7ddfUiIUaLumZq4kdY2+6iH40c3j2YcedizxX4AzUJFQqmurW
 hjzBWzb9gF5L88m7gAAAA==
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

 drivers/media/usb/uvc/uvc_ctrl.c | 52 +++++++++++++++++++++++++++++++++++-----
 drivers/media/usb/uvc/uvc_v4l2.c |  2 ++
 drivers/media/usb/uvc/uvcvideo.h | 14 +++++++++--
 3 files changed, 60 insertions(+), 8 deletions(-)
---
base-commit: 72ad4ff638047bbbdf3232178fea4bec1f429319
change-id: 20241127-uvc-fix-async-2c9d40413ad8

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


