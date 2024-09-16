Return-Path: <linux-kernel+bounces-330535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F73979FDC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 13:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97B95282D43
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 11:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4435914F11E;
	Mon, 16 Sep 2024 11:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BcL53nK+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1788E85628
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 11:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726484459; cv=none; b=rHqPq3Sji2rnxQUj4Q9jNI/fpgMwVseMOULrDQymgnXnTtKgvhRf2pkoz0mJmihgu5owKyUHmqp3h5Du0tCJk/nFekaXOhQlDzzNmb6YwuOptKGF/fcsX2J94HMpGU1GnXGx4BHF/sI/OEo7L9Q+x/PH+lE144edNwVVITZuQvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726484459; c=relaxed/simple;
	bh=uPAoAp3jdhLurNPHVpZWvvplChtReKJvXxSCc+SLpr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MJyH+2+bwij7yEASL9PmetyRgeERaph0XpWAmhIVYzO70W4ABSWA3h5hz4h1kh+KPW6daDF01BoMQc3qg/0S2V7zxS7B4WGZDQpyWmuGfvXIPCXoWQKwmXEGyY2jA6rGbfifQi2G6zJjmRLi/3muVVI8pXfaI2ntTPmg7chCgvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BcL53nK+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726484457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6WU8wjEM5waBEtcNYw4l2YQcbb7TE6+vCphAyrZI7KM=;
	b=BcL53nK+NfQm/4sjdJlIWBNy2G1zsIW+72dNllgFADq2a/8s0qqvTdpBGGoSfdbBG0Oe5q
	BbUMrmTiQ9axuBnuNCeyw2NWb8pqrZc95NdoCE6naUslZu0WOGZURicnLO0Da7lKBHfWqO
	2j70g48bZF+aCUriK1mCAKrBQiBi4fs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-aUAW5GvTPbCpXDg7zxG-mQ-1; Mon, 16 Sep 2024 07:00:55 -0400
X-MC-Unique: aUAW5GvTPbCpXDg7zxG-mQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42cb5f6708aso19005045e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 04:00:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726484454; x=1727089254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6WU8wjEM5waBEtcNYw4l2YQcbb7TE6+vCphAyrZI7KM=;
        b=KNejo0pWV+/B5Z+coDMuILs5SfJqAW4ajJSVLfvMbXZjgxc79EOnMtnryP4Zt3uDtK
         f6snqDznDgRkXUopK/724COshJxr8CoahTtpGGqeD3IMj4tX0bineMoap+lX8KldEw7A
         4pmRPLBvBouM8PGBGLAFf4uUK7vFY5A8PF1wGqkvqT3YdVLZRbHGT0JrIC5+ZcDBDetP
         C5onppr73QFvcN8uV4nsA2gyHEPHL3htUplNogdeHd56cXcbWrxBXditwhZZFi2kP/AX
         yU+cYebDf/s6XjxRAIHo+HA44pyAq8+xGEPaPmQdcWLpuJbi6Rkl7zuMaPYQnS545KDP
         SCmg==
X-Gm-Message-State: AOJu0YzPa6NvYOvGt7qyil/fLogyUF3U2j1OrZliJptjvgeVLdSRcW2r
	GYUrv1Wu6nB7teLWpLznqAC1mPM3KLIWDD5naHjQcIB8YYeuzTfUkp292XWHnPYi52DcTiaRI4n
	SBCSgNq9p9EdY5sTM5XMh2VqLCZqdkGW3Gy2AguVm8ojw/9RW2NmvbrQVB+PDaUXZx6jN+s+Qh4
	PLi7Eb4MpcdSpAryLO/Qy3NUy8JTBq1KHyhxPDRkq7i54QESk=
X-Received: by 2002:a5d:5f56:0:b0:374:ca16:e09b with SMTP id ffacd0b85a97d-378d61d5073mr7098354f8f.9.1726484454349;
        Mon, 16 Sep 2024 04:00:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHL0bDYkRLWR54cWHoQ6srXlo7gK64jJb064BDuwwm746fvy1r250h1Ko4v03+pz4HMLbwFTg==
X-Received: by 2002:a5d:5f56:0:b0:374:ca16:e09b with SMTP id ffacd0b85a97d-378d61d5073mr7098298f8f.9.1726484453789;
        Mon, 16 Sep 2024 04:00:53 -0700 (PDT)
Received: from localhost ([195.166.127.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42da24274dfsm74035955e9.45.2024.09.16.04.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 04:00:53 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Brian Norris <briannorris@chromium.org>,
	dri-devel@lists.freedesktop.org,
	Borislav Petkov <bp@alien8.de>,
	Julius Werner <jwerner@chromium.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	chrome-platform@lists.linux.dev,
	intel-gfx@lists.freedesktop.org,
	Hugues Bruant <hugues.bruant@gmail.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Helge Deller <deller@gmx.de>,
	Jani Nikula <jani.nikula@intel.com>,
	Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH v4 0/2] firmware: Avoid coreboot and sysfb to register a pdev for same framebuffer
Date: Mon, 16 Sep 2024 13:00:24 +0200
Message-ID: <20240916110040.1688511-1-javierm@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is v4 of a fix to prevent both coreboot and sysfb drivers to register
a platform device to setup a system framebuffer. It has been converted to
a series since contains changes for both drivers, to prevent build issues
on architectures that don't define a global struct screen_info.

Patch #1 adds a sysfb_handles_screen_info() helper that can be used by
drivers to check whether sysfb can use the data set in screen_info or not.

Patch #2 makes the framebuffer_coreboot driver to use that helper to know
if has to setup the system framebuffer or delegate that action to sysfb.

I haven't dropped the collected tags from patch #2 due the logic being
basically the same than in v3.

The patches have only been compiled tested because I don't have access to
a coreboot machine. Please let me know if you plan to merge both patches
through the chrome-platforms tree or if you prefer to get merged through
the drm-misc tree.

Best regards,
Javier

Changes in v4:
- New patch to add sysfb_handles_screen_info() helper (Thomas Zimmermann).
- Use a sysfb_handles_screen_info() helper instead of screen_info_video_type()
  to fix build errors on platforms that don't define a struct screen_info
  (Thomas Zimmermann).

Changes in v3:
- Fix coreboot spelling to be all in lowercase (Julius Werner).

Changes in v2:
- Declare the struct screen_info as constant variable (Thomas Zimmermann).
- Use screen_info_video_type() instead of checking the screen_info video
  types directly (Thomas Zimmermann).
- Fix missing "device" word in a comment (Brian Norris).
- Fix some mispellings in a comment (Brian Norris).
- Change error code returned from -EINVAL to -ENODEV (Brian Norris).

Javier Martinez Canillas (2):
  firmware: sysfb: Add a sysfb_handles_screen_info() helper function
  firmware: coreboot: Don't register a pdev if screen_info data is
    present

 .../firmware/google/framebuffer-coreboot.c    | 14 ++++++++++++++
 drivers/firmware/sysfb.c                      | 19 +++++++++++++++++++
 include/linux/sysfb.h                         |  7 +++++++
 3 files changed, 40 insertions(+)

-- 
2.46.0


