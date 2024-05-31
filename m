Return-Path: <linux-kernel+bounces-196427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 657018D5BCA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 09:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51ED41C20E0D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 07:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA7E7407A;
	Fri, 31 May 2024 07:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SHY82Che"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D658F187567
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 07:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717141677; cv=none; b=eKvXWnMxjiIx7J1+wZifoT26wwTOITZOgph8enoBsafbaed1OgAVyYfX4x7o2SQgUlT4mt0Cnl46GAU/Pmbc/NFsLjCEOaLGtN0OZNliEqWOeSbM5a/QECqyUGWm0i8QfbehiqAp3DI2aHzIx6pW+65B2VMRW57L2z2J8HmlweE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717141677; c=relaxed/simple;
	bh=Tu16eDOVCigfYW8Pz4VFPcNphxmr5sYpfmyZz/1SfQs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=YmSpCg8E7cjEZq8p88UdKDwgzSCy2/YXGCRKFClxKEfsiYFryeOXmQH4+sWgoqwNfyOzyoDT3n4QXj1Zg1f0tAqqa6rGHVfWjQPBoZa/mnXxmePCdxexHTIGofuLIOKLeSRjOZe5DN/ubrhweB+M7ID+n1qKTsrb3uCuvN9z/gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SHY82Che; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717141676; x=1748677676;
  h=from:to:cc:subject:date:message-id;
  bh=Tu16eDOVCigfYW8Pz4VFPcNphxmr5sYpfmyZz/1SfQs=;
  b=SHY82Che2tqjU++MtTJLlC49JYKqpjIoij2p/YbE3LFB/iIxjJl7eXQb
   zo19oeJlsWUNESPY2AeI41coLbXhHPRRJjAO2LODdNAn/rT53mkHaYb3+
   z/AHnnPxxXGhnr+VwSdmZ84NVpMtLcxixu4Ix0eEjWEDDGgPKX+kueU0C
   sjE9yyiG2OuzSn4yaDAz1r+AEvz98PijwLgbYUN2ZQXUOaFdSI9UBYb7V
   8/gtq68XeFyGsiVKoWNiPN6cirNnI9TnuWeZgs0yUyTXHqpmjy8LZL5MZ
   hzIrbbavcdSFUkMiujGfA4N7LwH2vg01UDJRqOi2OzDAZUiazzIcHQO/j
   Q==;
X-CSE-ConnectionGUID: 9fSflpo2S/Cv1ZeYRiFKrw==
X-CSE-MsgGUID: Vn2y5sITSzeYevxig+T/9A==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13520038"
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="13520038"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 00:47:55 -0700
X-CSE-ConnectionGUID: CzEIJVuXTHuCo7DPY+hBFA==
X-CSE-MsgGUID: vTWwWsuWRqiBcImIGrihwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,203,1712646000"; 
   d="scan'208";a="73567522"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.109])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2024 00:47:53 -0700
From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	tony.luck@intel.com,
	qiuxu.zhuo@intel.com,
	yudong.wang@intel.com
Subject: [PATCH 1/1] drm/fb-helper: Don't schedule_work() to flush frame buffer during panic()
Date: Fri, 31 May 2024 15:45:21 +0800
Message-Id: <20240531074521.30406-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Sometimes the system [1] hangs on x86 I/O machine checks. However, the
expected behavior is to reboot the system, as the machine check handler
ultimately triggers a panic(), initiating a reboot in the last step.

The root cause is that sometimes the panic() is blocked when
drm_fb_helper_damage() invoking schedule_work() to flush the frame buffer.
This occurs during the process of flushing all messages to the frame
buffer driver as shown in the following call trace:

  Machine check occurs [2]:
    panic()
      console_flush_on_panic()
        console_flush_all()
          console_emit_next_record()
            con->write()
              vt_console_print()
                hide_cursor()
                  vc->vc_sw->con_cursor()
                    fbcon_cursor()
                      ops->cursor()
                        bit_cursor()
                          soft_cursor()
                            info->fbops->fb_imageblit()
                              drm_fbdev_generic_defio_imageblit()
                                drm_fb_helper_damage_area()
                                  drm_fb_helper_damage()
                                    schedule_work() // <--- blocked here
    ...
    emergency_restart()  // wasn't invoked, so no reboot.

During panic(), except the panic CPU, all the other CPUs are stopped.
In schedule_work(), the panic CPU requires the lock of worker_pool to
queue the work on that pool, while the lock may have been token by some
other stopped CPU. So schedule_work() is blocked.

Additionally, during a panic(), since there is no opportunity to execute
any scheduled work, it's safe to fix this issue by skipping schedule_work()
on 'oops_in_progress' in drm_fb_helper_damage().

[1] Enable the kernel option CONFIG_FRAMEBUFFER_CONSOLE,
    CONFIG_DRM_FBDEV_EMULATION, and boot with the 'console=tty0'
    kernel command line parameter.

[2] Set 'panic_timeout' to a non-zero value before calling panic().

Reported-by: Yudong Wang <yudong.wang@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/gpu/drm/drm_fb_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index d612133e2cf7..6d7b6f038821 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -628,6 +628,9 @@ static void drm_fb_helper_add_damage_clip(struct drm_fb_helper *helper, u32 x, u
 static void drm_fb_helper_damage(struct drm_fb_helper *helper, u32 x, u32 y,
 				 u32 width, u32 height)
 {
+	if (oops_in_progress)
+		return;
+
 	drm_fb_helper_add_damage_clip(helper, x, y, width, height);
 
 	schedule_work(&helper->damage_work);
-- 
2.17.1


