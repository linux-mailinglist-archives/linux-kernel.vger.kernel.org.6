Return-Path: <linux-kernel+bounces-423454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7905F9DA7C4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEE9AB2B0AF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542721FBCB6;
	Wed, 27 Nov 2024 12:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FLlPEqIk"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3434A1FBC99
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 12:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732709698; cv=none; b=Qvf9r2LpaqAByldo3yWYYOpvsOgaNdJJE/02cj1VEd5AVn4G7aJredm2FPi2xZbcwOs1fOxLvjCfohMutzMrwmUt0LpW4wKMdYYPwNMfn+787LgNK1bdt0gV3jBdMdPL3MHFiw1BQRN+3QDAZHB7+8L4dGEeMtjdlaQwplVxMqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732709698; c=relaxed/simple;
	bh=HDmorQEfW2XPixchfeHjntv/qaXLNSwyu9JUTNt1sAk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=l0xmu0o4h5hSmKpXY9KkaYxf/empbMJZizw/Wv294ZecBzVmKSmNxi/lV51JLN+aIeHW4FBP5fm7xdSdGzFi+G+TFaSynNRd08T7EBwaeu73+O1nkbkWmnfIJuisr7yj706e76i4UR4H6W3tLV5sqBVrA0JBXMC1Z7nCy5RuBIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FLlPEqIk; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7b6662bc408so278457085a.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 04:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732709696; x=1733314496; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NHAqR0O4B/h7tBHgfojqr74MrYVPUr3J/E8o3WW29Xo=;
        b=FLlPEqIkivYBHd6FEI3ngEE5PDPBACdYrSe+xB8M/TxZuVu/79TovxslNmXEf/sy99
         Ig58yyREH2Mq2711WhYrojHEXCJ8jJCI0lRvqBO2q+KsTpZ7Wo2Lho20LdpSgjJDzTLT
         ggk6kyt+YUsmD5l1x1TORJqrC3OOSWJ6EQTGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732709696; x=1733314496;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NHAqR0O4B/h7tBHgfojqr74MrYVPUr3J/E8o3WW29Xo=;
        b=DdPdLFwvd/93BqltZTMhtF44bR3wT+oUGCJm1H/uRcEo5Js0UEHNr6IRJr4TamX42U
         McCgQ+A/u0LHdX2HQqdg0+C6JeFeBUoOeRKo8uuyDvWsVvPt1jXBWRC4Y/Pl4Da5BqPc
         qYLw15wq8uQsDw8cV08yGwc6R8I9qWLi1xipMdBRCfyz6+Pjd4i4c/6E8O3/8xgLpyyq
         ujIqEMRAM7DWShvKRul8zFqwzpt1XM7kkUF3bWxbvxJ5d+D07HdyHdO0AB3UoIaNspIe
         P/FWvf9x28rKCK6uAD3iDILrSkq3rQzuU4Co1WfItSaYdYy8Tm83cWicHQGxWNymMyeJ
         kpgA==
X-Forwarded-Encrypted: i=1; AJvYcCUan3PYCfp2+BYG58V0uEbuw622PTtwj/r1y6ci+yNQ0/MBItiz3v6KnHKQZ9MdGBpaUfnGBTDWupI3ZEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTyyn9VlXI5aP+cXYg8ySiCub111dXxjKygJtRSS1VOWmneUEd
	XPXpwebX1aor/28VziWMb3cYDtvmXhU/MjjE4c7gJr6yBBwVui+Cq63vYv0Gqw==
X-Gm-Gg: ASbGncvV1LVCM4iMYNXb/axybrT9YGY8gNS0z2auDiihbuIOwSEq7+qAiGCCN6rr4sl
	9DF6S/BKDisvBpJHL9Ga1f9FX0oevnCTfsEvj6/XO/Cmn7asCTYeE9BERvNkgXKUAxgS2mRJ/i1
	wtK8JWYF3yPr8AP+v36YQFVmhf3Gk/Tuc3SUEnV1T5Y7cMk1xthHzZtcqdR3KywqNHxLgpO9gnw
	vXBJFTLL8TFQbUG0+YrCtPPfyZKqV/f1ltSwNyfYVIUgzZ9vkxBtO1obs0v00D+rwpo1wyskdwr
	WkGjlWoXOOMW7yAXt/0Yokkj
X-Google-Smtp-Source: AGHT+IH4+uKa+77UNQwZcJatFS4vQ1w4uV2b74frXTYxzqW4RQUwyV/UPMqAQ5OxPsxv6kOhvWcsRg==
X-Received: by 2002:a05:620a:394f:b0:7b6:6c3b:64ba with SMTP id af79cd13be357-7b67c4aac3fmr465478585a.62.1732709696175;
        Wed, 27 Nov 2024 04:14:56 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466be77cf7bsm371171cf.89.2024.11.27.04.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 04:14:55 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 0/4] media: uvcvideo: Two fixes for async controls
Date: Wed, 27 Nov 2024 12:14:48 +0000
Message-Id: <20241127-uvc-fix-async-v2-0-510aab9570dd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADgNR2cC/3WMQQ6CMBBFr0Jm7ZjOUEN15T0MCyiVzgJqWmkkh
 Ltb2bt8/+e9DZKL4hLcqg2iy5IkzAX4VIH13Tw6lKEwsGJNxA0u2eJTPtildbbI9jpopanuBgP
 FeUVXzqP3aAt7Se8Q1yOf6bf+K2VCha43DfOlpt7Yu/UxTLJM5xBHaPd9/wJfwnk1rQAAAA==
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

This patchset fixes two bugs with the async controls for the uvc driver.

They were found while implementing the granular PM, but I am sending
them as a separate patches, so they can be reviewed sooner. They fix
real issues in the driver that need to be taken care.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v2:
- Annotate lockdep
- ctrl->handle != handle
- Change order of patches
- Move documentation of mutex
- Link to v1: https://lore.kernel.org/r/20241127-uvc-fix-async-v1-0-eb8722531b8c@chromium.org

---
Ricardo Ribalda (4):
      media: uvcvideo: Remove dangling pointers
      media: uvcvideo: Do not set an async control owned by other fh
      media: uvcvideo: Annotate lock requirements for uvc_ctrl_set
      media: uvcvideo: Remove redundant NULL assignment

 drivers/media/usb/uvc/uvc_ctrl.c | 48 +++++++++++++++++++++++++++++++++++-----
 drivers/media/usb/uvc/uvc_v4l2.c |  2 ++
 drivers/media/usb/uvc/uvcvideo.h |  8 ++++++-
 3 files changed, 52 insertions(+), 6 deletions(-)
---
base-commit: 72ad4ff638047bbbdf3232178fea4bec1f429319
change-id: 20241127-uvc-fix-async-2c9d40413ad8

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


