Return-Path: <linux-kernel+bounces-427685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF43D9E04C3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84D5D283D0F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920622040A3;
	Mon,  2 Dec 2024 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fIqY70pg"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FED1FECD5
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149480; cv=none; b=Z0YCrET3sZ4Qk8Pmd9dpHIxiBiRYaUeu3widIizCeukCfaOcfuYH982FyvZxAEwjyEkGluInxeoGDd9e1qUcCftEPVwuOUrKkrtCLMytTRUdy0sKRmy/O62u4diEytPfJfXXP58AaabRkyulgGk9d2iORx/sSbg9iX52/s34200=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149480; c=relaxed/simple;
	bh=oveab0x/X5lxQcctIhT1NPmDKwzpaRt5bfuaux7SDmM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jB9CG44buhr9h0gRLiS4muRwW6iCdqsmOgXHzAtCC2gYG81xPRJAw5PG5ZU5kNjROgqhpGZsiYXERwN+YEaHZCWozO6szGR3P8SeCKrjYIY8aPj2TixkIjbk40mgbYkPSaPFGKBIGdGs78qOQ3l4W9iIP+vYZanLmCQq3bLxKlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fIqY70pg; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b66d08d529so369481485a.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 06:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733149478; x=1733754278; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uR/f84OMp446oPhdoEj+ac1SLyhexTWGRvHwC4hhgxI=;
        b=fIqY70pgULraV5XU4IS5HDBAW1s066VE1fdWv97xerIgBcBEViSfy/ufTREbdrXEHR
         wopFCb6xx3+cJa4yfdPFtHwWNLM/ad4Q0cMI+vd4fY50zsqX5phvjnYdKCb1nm/UZfF6
         BeM0E8MgtO/tt+v0JJzrYrNafvZynw1RD2MtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733149478; x=1733754278;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uR/f84OMp446oPhdoEj+ac1SLyhexTWGRvHwC4hhgxI=;
        b=TQIqGUtWgQwC1aNvtY+lpGoseKxflib222Z2Rk02mcgOQm1VlTrFeM7R3I2UgYJKzu
         ylXSqAeI41+uww9nuz/DjZE6G/kipf8J3kj0M0jl5jjf8FCDUnemaFETAoHa/1LIonUg
         86nTtdCo1fuijD1QiN7suOnmbbWcCLDg34zj8/ijhaDa8y+O+nFotljKuWxIM6MVYzUl
         wr0lxpp9IMH3BcYGv+gWb14c8modksE0nTYYuwxE0wiVR37hILeS7G30cnB30Zldguaw
         03hgeQbVqALCClh71FSlnmsdOpRIcPLxjk2JUf9C2nLYhnc7Q2uUNnIVfX+09JgYRtwv
         7yZg==
X-Forwarded-Encrypted: i=1; AJvYcCUY73Gzoho9Dj8rSncwmYszPCAaE5fM4WQORgA1KWmpQB/urj7MUaYcIAnVHEshybLmQfnaoWCw3Hj7B+k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgw7VNRaq16WePE6vmF/C3/IS5+Zceu7Y/fCR3/UnAhS+PvH4/
	cxVAGjO5lOYk1jJNLhCRVISE5ZZGisNZmvO5Jy5Rf+dzL6pnaKc6cL36ut6viw==
X-Gm-Gg: ASbGnctXhE827PEheO3wKCSmLvatRh8bV1S87vqzbeV+FtnAAogeHC/DQnxpGNS5dBu
	2MB70jGUlh+W4gPEuuNPBe/945MsRdndIoeedNTsZ3m9XXC3alZdSWu/wBcB6Vcp3ylk0giicbl
	hJpvyXMcI41lhmuXrs6BV4GGv+XC2/Q5L6y9JfHULa8kHSJ6a3iA9jIAYIqmITGwK+fzXFBD8ni
	mQ1OKoBopGAsA+vHgasne5z+5ijHEc1Bdh/Ut8PeT7P1GjOuTEWO51D4D909BRlg7facsYxZgzx
	PRhxmKopcbdUwOQlvvPgdtIG
X-Google-Smtp-Source: AGHT+IGdnM12FG/mve/yBjS01j+lXu+XUWGzwYOjmdB0FCytOi8NRKrlt+bH6OQ9s4cPAmEC05Jx7A==
X-Received: by 2002:a05:620a:2782:b0:7a9:abdf:f517 with SMTP id af79cd13be357-7b683a58b3emr3038810285a.25.1733149478198;
        Mon, 02 Dec 2024 06:24:38 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-85be9087890sm179710241.25.2024.12.02.06.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 06:24:37 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v5 0/5] media: uvcvideo: Two +1 fixes for async controls
Date: Mon, 02 Dec 2024 14:24:34 +0000
Message-Id: <20241202-uvc-fix-async-v5-0-6658c1fe312b@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACLDTWcC/33MTQ7CIBCG4as0rMXAAIW68h7GBX9tWbQ1YInG9
 O7SrozRLt+ZfM8LJR+DT+hUvVD0OaQwjSXEoUK212PncXClERDglILEc7a4DQ+s03O0GGzjOOG
 UaadQ2dyiL8/Nu1xL9yHdp/jc+EzX6z8pU0ywN0oCCEaNsmfbx2kI83CcYodWLMMuAAUQlGhtG
 iGJcz8A9gk03wArgDa1FNbXtTPyB8B3AV6AFphU3BmtSPsFLMvyBt1q/z9wAQAA
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

This patchset fixes two +1 bugs with the async controls for the uvc driver.

They were found while implementing the granular PM, but I am sending
them as a separate patches, so they can be reviewed sooner. They fix
real issues in the driver that need to be taken care.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v5:
- Move set handle to the entity_commit
- Replace uvc_ctrl_set_handle with get/put_handle.
- Add a patch to flush the cache of async controls.
- Link to v4: https://lore.kernel.org/r/20241129-uvc-fix-async-v4-0-f23784dba80f@chromium.org

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
Ricardo Ribalda (5):
      media: uvcvideo: Only save async fh if success
      media: uvcvideo: Remove dangling pointers
      media: uvcvideo: Annotate lock requirements for uvc_ctrl_set
      media: uvcvideo: Remove redundant NULL assignment
      media: uvcvideo: Flush the control cache when we get an event

 drivers/media/usb/uvc/uvc_ctrl.c | 77 ++++++++++++++++++++++++++++++++++------
 drivers/media/usb/uvc/uvc_v4l2.c |  2 ++
 drivers/media/usb/uvc/uvcvideo.h |  9 ++++-
 3 files changed, 76 insertions(+), 12 deletions(-)
---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241127-uvc-fix-async-2c9d40413ad8

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


