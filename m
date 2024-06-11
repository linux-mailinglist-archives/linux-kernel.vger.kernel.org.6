Return-Path: <linux-kernel+bounces-209451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 644289034FF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E767285FA1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 08:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8E917333F;
	Tue, 11 Jun 2024 08:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gpt57bH2"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647EF17279E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 08:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718093531; cv=none; b=NtsCJiwkFAqgAflFQZOTIWwNXV2ZwuEzdaexwk/BosZQyJZYGSxiMOEjCt8TdgftRR+l4lZllHk9v82vc/FwCg6LrXhE3+SrfOQnOrO25Zrj8TwCr9dyeLV0FgOurbgIY32GKmdbWQTKedY0LnFS1qlbZ3dtnW9Yg98VMHcDDkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718093531; c=relaxed/simple;
	bh=sw1AeVMPXWiADODhkeGl0lT1bOXV/I4K3T1Gys6tUAM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kJszYcLQxUAxQX4BetxI25wpFsIfFFHUT/VPk8FdQ0cRaXVPCHf14BUvLOLmSrtRvl0iYJwBp25TgfuPCDi+E6Hj1yvFn/80RYjwYuY8/IVITW22DZZlT5uu1gI718Fy492OKlAKqJErfw4wr/GVhgNe6KuluZjbIjakBWFZE+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gpt57bH2; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-795310c1698so61854585a.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 01:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718093528; x=1718698328; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HbJkh4UNuOL6n6R407RfEhP8cbJUCjZaQuIr//GYIlA=;
        b=gpt57bH2xlV1f7w6ofTeqktXMbsU8oKvFGtrHD2mobdwPhdOnCdXkQ+GNfEewCnLK7
         6eikkFa7I/t3dII0wtXcsCiieQvBEV3zCxobn/6XtmAYeoAmVWdvRxEAcPxUX9UWFJTN
         4mulDRmh7/CgD/OR3RDN5bUieS7NQ5yJk9bm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718093528; x=1718698328;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HbJkh4UNuOL6n6R407RfEhP8cbJUCjZaQuIr//GYIlA=;
        b=JpU74RHCbLlfHquOlSQsQPAkRJxzjvA8AfqAGS9ZXKLgH/IkkeGF57vvqakVD5hotF
         xWBmCZC6K7cLa02PmgQ9fyqd6toJXGIw+/K+HMkwg8GAOlnSzzHXnNKrkA1cw90mh/ip
         ZLMHi9oiWZvUTttGSvIQt5BDzZfJ+fBU8CcmsTEkRgi081kGb98N6m0nTl+FVRpYGo3j
         LpdruIBJGtSLFxcOg7tX08tHajtQ+t/XyozsK59Re6L3odK8M4w+Oo06v8bXekLZF/i6
         Qkhyj9HI3f4ky5f6hvQglFFNwROTu/UoPRg68NunISPN5c9V76Sy4fnaDqbaWdSEOxz6
         j9WQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRiGiF+i/0EIaHj4V77Bp3vMzPvJ8OJ+rRR1a/K1hGDt/busRaj5v/SHYJzXrZceP1xBHJI/g7Fsl31lj8w3LWBdCPYOSmZKMB1Hdg
X-Gm-Message-State: AOJu0Yxuq7QEzTZgwx+eFDayUPIZB866EvdxXmmtRMFqCChO3jp4J0mO
	ayj1UGLCeqgOhQhdvBKXgHOhTRnPxn1ZmPlKagwfPr6sExZcQeYkyukb2+U+6g==
X-Google-Smtp-Source: AGHT+IE6QpYXu8Qp3HvgP9E+/iYIQ8vEXQLkc7I0kxHJ8sMD4UO/y3gw0TvO5T6IAxz2bPI8FWDXBw==
X-Received: by 2002:a05:6214:3d09:b0:6b0:732f:b91e with SMTP id 6a1803df08f44-6b0732fbb29mr80106466d6.0.1718093528288;
        Tue, 11 Jun 2024 01:12:08 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b09039c2b9sm1548886d6.28.2024.06.11.01.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 01:12:07 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v5 0/4] uvcvideo: Attempt N to land UVC race conditions
 fixes
Date: Tue, 11 Jun 2024 08:12:05 +0000
Message-Id: <20240611-guenter-mini-v5-0-047b6fe5d08b@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANYGaGYC/33PTQrCMBAF4KtI1kYmvzauvIe4aJNpG7ApJLYg0
 rs7CIKU6mp4A98b5skK5oiFnXZPlnGOJY6JgtnvmO/r1CGPgTKTIBUocLybMN0x8yGmyCtXWdF
 ApbEVjEhTF+RNrpPvCaXpdqNlH8t9zI/3iVnQuPxomwUHbuUxCPCtRWfPvs/jEKfhMOaOXalrl
 v+8JI9WCwjGQdBqw6uP16CkWXlF3uvGWxHoJdjy+tsfV16T184Z44WrsMaVX5blBWERQUlwAQA
 A
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Tomasz Figa <tfiga@chromium.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Alan Stern <stern@rowland.harvard.edu>, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sean Paul <seanpaul@chromium.org>, 
 Ricardo Ribalda <ribalda@chromium.org>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
X-Mailer: b4 0.13.0

Back in 2020 Guenter published a set of patches to fix some race
conditions in UVC:
https://lore.kernel.org/all/20200917022547.198090-5-linux@roeck-us.net/

That kind of race conditions are not only seen in UVC, but are a common
seen in almost all the kernel, so this is what it was decided back then
that we should try to fix them at higher levels.

After that. A lot of video_is_registered() were added to the core:

```
ribalda@alco:~/work/linux$ git grep is_registered drivers/media/v4l2-core/
drivers/media/v4l2-core/v4l2-compat-ioctl32.c:  if (!video_is_registered(vdev))
drivers/media/v4l2-core/v4l2-dev.c:     if (video_is_registered(vdev))
drivers/media/v4l2-core/v4l2-dev.c:     if (video_is_registered(vdev))
drivers/media/v4l2-core/v4l2-dev.c:     if (video_is_registered(vdev)) {
drivers/media/v4l2-core/v4l2-dev.c:             if (video_is_registered(vdev))
drivers/media/v4l2-core/v4l2-dev.c:     if (!video_is_registered(vdev))
drivers/media/v4l2-core/v4l2-dev.c:     if (video_is_registered(vdev))
drivers/media/v4l2-core/v4l2-dev.c:     if (vdev == NULL || !video_is_registered(vdev)) {
drivers/media/v4l2-core/v4l2-dev.c:             if (video_is_registered(vdev))
drivers/media/v4l2-core/v4l2-dev.c:     if (!vdev || !video_is_registered(vdev))
drivers/media/v4l2-core/v4l2-ioctl.c:   if (!video_is_registered(vfd)) {
drivers/media/v4l2-core/v4l2-subdev.c:  if (video_is_registered(vdev)) {
```

And recently Sakari is trying to land:
https://lore.kernel.org/linux-media/20230201214535.347075-1-sakari.ailus@linux.intel.com/

Which will make obsolete a lot off (all?) of the video_is_registered() checks in
Guenter's patches.

Besides those checks, there were some other valid races fixed in his
patches.

This patchset tries to fix the races still present in our code.

Thanks!

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v5: Thanks Hans!
- Refactor unregister as vb2_video_unregister_device
- I have tested the first patch independently from the others, so it
  could be merged in two steps if needed.
- Link to v4: https://lore.kernel.org/r/20240327-guenter-mini-v4-0-49955c198eae@chromium.org

Changes in v4: Thanks Sergey and Guenter
- Fix typos
- Move location of mutex_init
- Split patch to make the suspend change explicit
- Link to v3: https://lore.kernel.org/r/20240325-guenter-mini-v3-0-c4bc61d84e03@chromium.org

Changes in v3: Thanks Hans!
- Stop streaming during uvc_unregister()
- Refactor the uvc_status code
- Link to v2: https://lore.kernel.org/r/20230309-guenter-mini-v2-0-e6410d590d43@chromium.org

Changes in v2:
- Actually send the series to the ML an not only to individuals.
- Link to v1: https://lore.kernel.org/r/20230309-guenter-mini-v1-0-627d10cf6e96@chromium.org

---
Ricardo Ribalda (4):
      media: uvcvideo: stop stream during unregister
      media: uvcvideo: Refactor the status irq API
      media: uvcvideo: Avoid race condition during unregister
      media: uvcvideo: Exit early if there is not int_urb

 drivers/media/usb/uvc/uvc_driver.c | 45 +++++++++++++++++++--------
 drivers/media/usb/uvc/uvc_status.c | 62 +++++++++++++++++++++++++++++++++++---
 drivers/media/usb/uvc/uvc_v4l2.c   | 22 ++++----------
 drivers/media/usb/uvc/uvcvideo.h   | 10 +++---
 4 files changed, 103 insertions(+), 36 deletions(-)
---
base-commit: b14257abe7057def6127f6fb2f14f9adc8acabdb
change-id: 20230309-guenter-mini-89861b084ef1

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


