Return-Path: <linux-kernel+bounces-179379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF798C5F74
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 05:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DCCB1C2324A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 03:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE72381BA;
	Wed, 15 May 2024 03:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWzbBhHw"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6689E23D2;
	Wed, 15 May 2024 03:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715744471; cv=none; b=ZQwurQMowG31gJFF3eT4dVIOPcptHNphvZa4smP3YSdLpBjZzfzOISSNhtqtOn8RF54ru++CZQdbbgoJksaUbQrB+J0zPsI7dBaHZXV9PrFyZN0TsIl5iDk2i4x2objOse0NoHgJvmnSiAKUIHB9f7OkzdJwHhPrWT4o+uSM3hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715744471; c=relaxed/simple;
	bh=30ejuqqg74CByVsfymr5UlzA1k2xqaHdOpLBkreoCiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ixfDIuU67pg/gt88dlZOxAI5h2QdnPd14jRfv3UIMqYGrnPK5bixGmqRz2ffXrxQJ9ntqLIjk1cjMAsY2zLbhAU5OcOjIi56lDrbs6zQ+BmG3O26L+rlWS+xAww15rjHpWKPQBYirrUjN8zoVXhRLFF+ZWGVOp0Wwugtk+4hXd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWzbBhHw; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6f0794fdb95so4133836a34.2;
        Tue, 14 May 2024 20:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715744468; x=1716349268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pk8viOFL6C+sK7eq/9J60NY+qoMRQ1PpNHQeo8AS9yE=;
        b=eWzbBhHwGGYUYg2xdCZzfRmNdJhotFCXlwpdvFHpKNRAZWAnvHoWr6F2dTwP67udMF
         eAeMgenOIAARvfu8pgD4ndZhdxew4vCr4+xFvqoq11nkEmOZSaPjIGsiVfgyST+D1oLd
         bq/PV9fn23uwO294XqTCf3rbOkQ2mb8Sc3Fo5x2ud7BIxcQMFUThsCAfLzIQKo2o94K1
         UTTjEoZu4tAucz/C9vPDhvQI4VeY2N60vlBmhC/zpQ/va6sObO8YUj++fURMttV5e5xu
         IDHLqW7rKUxajkuBi1GJhe3ufQV8VfyGUhA5ENKo5BeIcMQPCMM+BbD+avUCDRywXMAb
         HIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715744468; x=1716349268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pk8viOFL6C+sK7eq/9J60NY+qoMRQ1PpNHQeo8AS9yE=;
        b=MP84XkttXTWQKsQVBMK4FR4nz1fksbou8U9IVtJIFo5SGx5fTYn7doIUaOQ4+aXy38
         o/PY3YjHJPDUZBVouqJiCABTKTqzW/nnI0m39XHCcXKzxcAY6LOnCB2FX4fAckrjxMoN
         BX403JmzR04nIyM9+UmeIJmgt9bQNjnNKVFzCpVyowAk38nllxmYqtifs44wzHfjUL3K
         S6eXZf3HJyEltlYDNBa2ja31FylTo5LbNSGt2YPJ7wqEVB97scnajhluUd4bfWUUMSWp
         pXuuHpY2Wv30ycaUvPivIXQwYW2LwDKg58cqFwKseJazfQsvvuA8ovBuuibwVRfI8phc
         a1Cw==
X-Forwarded-Encrypted: i=1; AJvYcCWEaAHT93J1i4aMdkbnEx1LXbGhYKwGqN0Dgc4odgDuwRdp9jT+lspbyIjviYpDAckdme9myCkA7/OXq5qO9WBYU66Zc6CMMddg4kWBo0eMHSTsxQBOatpeAtCRsfCoPdOST4i1IsII
X-Gm-Message-State: AOJu0YxeM1bHyag4lxXB2xgUM923VbIeGdgyqz/lRu4iK5VQOmGV5WfJ
	z+IjnGm/E3e1HtJreLDYboydG1fbD+rwseBXMNekKGDIocqafFKb1vEmWIgp04c=
X-Google-Smtp-Source: AGHT+IHREkbPPtr1cWc0eEfPNy/X/TRQD+JLvpBFAPQPZT/3dUYk0pvTBWyj7xS1Z+Gcdj+kxMN8XQ==
X-Received: by 2002:a05:6870:b612:b0:23e:7764:7795 with SMTP id 586e51a60fabf-24172bd313amr18039761fac.28.1715744468508;
        Tue, 14 May 2024 20:41:08 -0700 (PDT)
Received: from server.ucalgary.ca (S0106f85e42401d5e.cg.shawcable.net. [174.0.240.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f66b76d54dsm1976745b3a.214.2024.05.14.20.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 20:41:08 -0700 (PDT)
From: Abhinav Saxena <xandfury@gmail.com>
To: linux-sound@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Abhinav Saxena <xandfury@gmail.com>
Subject: [PATCH] Documentation: sound: Fix trailing whitespaces
Date: Wed, 15 May 2024 03:41:03 +0000
Message-Id: <20240515034103.1010269-1-xandfury@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove trailing whitespace from sound/hd-audio/notes as reported by
checkpatch. Removing trailing spaces improves consistency, and
prevents Preventing potential merge conflicts due to whitespace
differences. maintain a cleaner and more professional codebase.

Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
---
 Documentation/sound/hd-audio/notes.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/sound/hd-audio/notes.rst b/Documentation/sound/hd-audio/notes.rst
index a9e35b1f87bd..ef6a4513cce7 100644
--- a/Documentation/sound/hd-audio/notes.rst
+++ b/Documentation/sound/hd-audio/notes.rst
@@ -15,7 +15,7 @@ problem is broken BIOS, and the rest is the driver implementation.
 This document explains the brief trouble-shooting and debugging
 methods for the	HD-audio hardware.
 
-The HD-audio component consists of two parts: the controller chip and 
+The HD-audio component consists of two parts: the controller chip and
 the codec chips on the HD-audio bus.  Linux provides a single driver
 for all controllers, snd-hda-intel.  Although the driver name contains
 a word of a well-known hardware vendor, it's not specific to it but for
@@ -81,7 +81,7 @@ the wake-up timing.  It wakes up a few samples before actually
 processing the data on the buffer.  This caused a lot of problems, for
 example, with ALSA dmix or JACK.  Since 2.6.27 kernel, the driver puts
 an artificial delay to the wake up timing.  This delay is controlled
-via ``bdl_pos_adj`` option. 
+via ``bdl_pos_adj`` option.
 
 When ``bdl_pos_adj`` is a negative value (as default), it's assigned to
 an appropriate value depending on the controller chip.  For Intel
@@ -144,7 +144,7 @@ see a regression wrt the sound quality (stuttering, etc) or a lock-up
 in the recent kernel, try to pass ``enable_msi=0`` option to disable
 MSI.  If it works, you can add the known bad device to the blacklist
 defined in hda_intel.c.  In such a case, please report and give the
-patch back to the upstream developer. 
+patch back to the upstream developer.
 
 
 HD-Audio Codec
@@ -375,7 +375,7 @@ HD-Audio Reconfiguration
 ------------------------
 This is an experimental feature to allow you re-configure the HD-audio
 codec dynamically without reloading the driver.  The following sysfs
-files are available under each codec-hwdep device directory (e.g. 
+files are available under each codec-hwdep device directory (e.g.
 /sys/class/sound/hwC0D0):
 
 vendor_id
@@ -433,7 +433,7 @@ re-configure based on that state, run like below:
 ::
 
     # echo 0x14 0x9993013f > /sys/class/sound/hwC0D0/user_pin_configs
-    # echo 1 > /sys/class/sound/hwC0D0/reconfig  
+    # echo 1 > /sys/class/sound/hwC0D0/reconfig
 
 
 Hint Strings
@@ -494,7 +494,7 @@ indep_hp (bool)
     mixer control, if available
 add_stereo_mix_input (bool)
     add the stereo mix (analog-loopback mix) to the input mux if
-    available 
+    available
 add_jack_modes (bool)
     add "xxx Jack Mode" enum controls to each I/O jack for allowing to
     change the headphone amp and mic bias VREF capabilities
@@ -504,7 +504,7 @@ power_save_node (bool)
     stream states
 power_down_unused (bool)
     power down the unused widgets, a subset of power_save_node, and
-    will be dropped in future 
+    will be dropped in future
 add_hp_mic (bool)
     add the headphone to capture source if possible
 hp_mic_detect (bool)
@@ -603,7 +603,7 @@ present.
 
 The patch module option is specific to each card instance, and you
 need to give one file name for each instance, separated by commas.
-For example, if you have two cards, one for an on-board analog and one 
+For example, if you have two cards, one for an on-board analog and one
 for an HDMI video board, you may pass patch option like below:
 ::
 
-- 
2.34.1


