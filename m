Return-Path: <linux-kernel+bounces-434696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4EE9E69E1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 10:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DD58281D70
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C241DFE0C;
	Fri,  6 Dec 2024 09:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="viGSQJi4"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7C218FDAA
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 09:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733476519; cv=none; b=QR36n2Nys5EopZkhJoiuOJfZlNi6CkOkNG/NbX9eSE5WQVeF/E15nEQ6e1nFvbNy+4F6xPry8Ea08fSK+B+y/RwlyP9Hrvta5lsyl14IuhCywXkQQJWieG5IDy3T5jKFA+jxDJ7Y9j9kYm+G0QwzuNfHXNfviIyU1ARaTxEBo04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733476519; c=relaxed/simple;
	bh=kwLQ94HldbNV+zoGi96XcRdLo7pMGV6re88/hBpXZLc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kank5RVE9o7I3w4Pj2KzZBe06wAN+IxieAXhO0xcoWPGnzAMs3vlqrJv8jWOnkYILwJxs8/xopxOUCEiZRqkzV3zKaIs9g0K7vIVeFRohECmZlyFc4xvyN3iU4IHtjSt0XdBG/lhpHo7lNNchb1qj67ld87essszAdEIyRXzFLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dawidn.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=viGSQJi4; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dawidn.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-434a27c9044so11198185e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 01:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733476516; x=1734081316; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jsoePWe67thrZkp/6OayojgRdEJ0C3zRr215WDhkRnY=;
        b=viGSQJi4spAbGwk2mYQ7mk1vjktJOGKK+IfpLK967vAy/yBed7mOFS1HZZjpPkCcBx
         y42H0VBI0ztm0i7vMVYZrUKef7wnTKZN96CnbKC2Z0U4tJjbq3q9uRsHR7P3btfIyRIP
         kJOrknxfi79gebsgxqSLGAGLfStWDW0kkIro7Je+69x4PCvw6liUd50UeuoCODfOXEsU
         iBJ+MiuNc/PMPGwbSHjPq5lFHvi/tm4wJ4yMy3wlyivEkbjh49AN06S0fCDQMqgzzTRa
         k4jM4tBtP4Ombw446sfrlGnXFUFc6mG5Axo9nqb7k3Df/5iIYhqiu1JVIyNVciykE3Qv
         sp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733476516; x=1734081316;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jsoePWe67thrZkp/6OayojgRdEJ0C3zRr215WDhkRnY=;
        b=XLhEhiZ8kV6Nz/1/X2OOz9PLzCQWsrC+jSe/XYgugT4kleu7wZrZgjG85/wlrAFYvs
         xnUN6rLyMOF+ARzQYUfmJPz55FkvHtl3D0qrMC5mQRWqLdCNjkJO+L8f04QBxccpEgyN
         9E09eOXJujAJtjzzHIMuQhij1r4n+E5MPb4yJfFzWLhrHddVgC+VWYYHYAfxTtqwqc36
         mTiaSEFlmDjDv6QAik/5bGtk/uzpiFsNi38Su/H8cGzKFOZZpSSCZbguvDckx1eTHZ4z
         Bx3Ycp2fQSRdyMHoXGr/UJdiTlRLVMFrTxHu4/EpjYdprh8yD+PotxDKkXZz5lGm/UuW
         Kugw==
X-Forwarded-Encrypted: i=1; AJvYcCWFgFvUKXTNBKx23RayRnruW2CAvw/1bho2YfbhRS2PiJnungLXeI3/lDoYcJheppAWf7vk97YobL7pd34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9h69SES2QfW+v/KXMUzkooZAxdWWIoavCHGuAADq3XvIeVID1
	IKpR2I8Igtkc0OrGOzyC96Pt+C/4wg1HW3+Gn2GDCo3QNTnu/zpmfm/Qaif361WsKR5+Q7tQcGk
	4XQ==
X-Google-Smtp-Source: AGHT+IFCqv27QWLPM8WTuZZN1s5jBLpaR3DtkRQJGbaid+28O3WxtjoIsfDdFZ897dBjYG2yg8zLySTJhQU=
X-Received: from wmsm5.prod.google.com ([2002:a05:600c:3b05:b0:432:1c3:8b30])
 (user=dawidn job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:5799:b0:434:a4b3:5ebe
 with SMTP id 5b1f17b1804b1-434dded7708mr16924935e9.24.1733476516366; Fri, 06
 Dec 2024 01:15:16 -0800 (PST)
Date: Fri,  6 Dec 2024 09:15:12 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241206091514.2538350-1-dawidn@google.com>
Subject: [PATCH v3 0/2] platform/chrome: cros_ec: improve probing for RWSIG
From: Dawid Niedzwiecki <dawidn@google.com>
To: Tzung-Bi Shih <tzungbi@kernel.org>, Benson Leung <bleung@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	chromeos-krk-upstreaming@google.com, Dawid Niedzwiecki <dawidn@google.com>
Content-Type: text/plain; charset="UTF-8"

V2 -> V3:
- Move exiting from `cros_ec_rwsig_continue` if `error_count` exceeds
  `RWSIG_CONTINUE_MAX_ERRORS_IN_ROW` to the `if (rev < 0)` statement when
  `error_count` is incremented.

V1 -> V2:
- Use dev_info instead of dev_warn when cros_ec_rwsig_continue returns
  an error.
- Return immediately from cros_ec_rwsig_continue, if the RWSIG_ACTION
  command fails itself, not SPI transaction.

Dawid Niedzwiecki (2):
  platform/chrome: cros_ec: jump to RW before probing
  platform/chrome: cros_ec_proto: remove unnecessary retries

 drivers/platform/chrome/cros_ec.c           |  5 ++
 drivers/platform/chrome/cros_ec_i2c.c       |  3 +-
 drivers/platform/chrome/cros_ec_ishtp.c     |  2 +-
 drivers/platform/chrome/cros_ec_lpc.c       |  2 +-
 drivers/platform/chrome/cros_ec_proto.c     | 69 ++++++++++++++++++---
 drivers/platform/chrome/cros_ec_rpmsg.c     |  2 +-
 drivers/platform/chrome/cros_ec_spi.c       |  2 +-
 drivers/platform/chrome/cros_ec_uart.c      |  2 +-
 include/linux/platform_data/cros_ec_proto.h |  2 +
 9 files changed, 74 insertions(+), 15 deletions(-)

-- 
2.47.0.338.g60cca15819-goog


