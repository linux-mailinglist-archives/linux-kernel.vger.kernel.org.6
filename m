Return-Path: <linux-kernel+bounces-519922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A565AA3A39D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D213F166EDC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FFC26FA5D;
	Tue, 18 Feb 2025 17:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVupZAFl"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5774326F464
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898499; cv=none; b=OStJ3art1eRqFX87iJyCUnGk+P6zmpOooqIWBoRmonXNA1m3Fv9ps+bhOd8kL4TyyDPcCevk06jpl9rFIiAQrUgqU1yGjlFDMxCNDSQRrACiWNQpnDHjskYIjQAexsIIRrXvMlEqBuDxsMYnhSNDC0XJxtGEvozXkyEVQKtFnPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898499; c=relaxed/simple;
	bh=Ahl+0Q/BXgttFJvc69RV+BRmdC6VjUNLeevamdi0Wi8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Cj/JTeqy3GLQF8crmKp8NBzfuAlZtDkskU4FnbkdgdncLkM/pFc3NMGMg6R2spQQSd+q+F2eNNz6yNIxLrPIjPa8qcagst3aRsBgVTCHYKH8iA2911CpPfwZT6PeUZnPpoeeyFfpWIY43iOzS0bT3WRnSb+6YI1OxNuGSdF6y10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVupZAFl; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4398738217aso21092585e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739898494; x=1740503294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RcINKfr4lNxFYF9r6nCx7oKwteN5FJxyS4A/b+jWADQ=;
        b=VVupZAFl67rAh9YUHAACVQPDA2EvIG++UfoduIA53rQAKiBTxAfWl53RiT8HwVDrnz
         dj3Z5sK2Ul+PvwWwGXqirtvCf6Mt13TmXcAezYIexvZQeTNAgY6nAsW0LUak1wdj+l1m
         S88F2CGaSZB8KdGr4uLzj5c/pcWaH/g3SARAy708bf0tigc+U0p+T41phen+oxGGA7qu
         0W7elxrbStjiuvKOoxiIXgbarE51B3lL3pIWaaGHtNe/T54vAsNp4v0uHRsEJ6LYjsbQ
         RaZ0Q+IHbZBa8DidTUXBS0ZLFuVJbgl4Y3U4YyZlDXpMWEuAzlXvEDuLrYVxim9AW3ic
         h5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739898494; x=1740503294;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RcINKfr4lNxFYF9r6nCx7oKwteN5FJxyS4A/b+jWADQ=;
        b=FkKQJkFzOGJJ4D7OCWp8s47T3avit2P8r69uoHzGQRYFY25J7GOg6LZYPdWqAZS9Vf
         hL5BnlJQMcBLq+fXRGDmQpWhXcHrT0ub8t31vZkkO6bFWvc6p2W2OpNGjzaiO9c4TPMp
         HS7tUG2NZuY24voMLRwtxPBDWjRNXmMTlNvEJ8CizSY37KV0RuDwybivWVwiikP0wPzc
         OPAY2UL3myHFYBw2LL7d5bXh/A/YwjLH+QuTAVfXcS3cOFqnSetasIomBTLWsVtTN53i
         JT7tFe3YpuySuHTt25Xy8RJbnNiL1NLY4V8zCQkDBc4nwJNgedBr/nTvCQ94OaHTiGGt
         SNEA==
X-Forwarded-Encrypted: i=1; AJvYcCVhSivX+M4hFR/Phf1SVT7aYP6ZOpykk/Pbro3urr+9vg+WjBXMpFZLxHgF5E4O/bUFeKCfZtqhW30LhIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIWSGvnrl5BiVt3n115bZzJLy0h6r4YyBrFKSLjiIu5eXL3PQc
	ZrpuXr//VAYa+SobLeDGCIky3y0Orb6RqLIij3tWas9OWf3r3jvB/abWc7y5
X-Gm-Gg: ASbGncvbdYgoakELALHsAVTtE/O8Y5U4CvVNul6opFFsM9Eez6F6JgUSkBAlfkuwdmj
	v2NN81f6icT9N0WWdDJ1RcdU36kOcuv2aK+STk98FI9zu5JcFDOZin5NSAJjz/3phMpGJpQ9Ui2
	owHzwyGq9u4yLl9Ts1uyGU37pvFsi12xJXyG2cf68KeiEaPzHiLaPI/wa1Mc+qwXGAiO1kuhnBo
	WAPZbCPKkSooQJ9RHcujXg7dtXEsywTyA/ky+qYO4c9oK2rLgOQloqh9/O7nrmVoIAwwvDxVVyo
	GNuzj/+hKmvG18ZV2Q==
X-Google-Smtp-Source: AGHT+IG9C3A51BmI5k+8FyoWsU577SQrMSbXBykQTnn69muiTH5WsxRqpQohcGqHEI+4n5L2FDAxAw==
X-Received: by 2002:a05:600c:5114:b0:439:89d1:30ec with SMTP id 5b1f17b1804b1-43999ddb366mr4539495e9.29.1739898492748;
        Tue, 18 Feb 2025 09:08:12 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439941bd54bsm24680135e9.11.2025.02.18.09.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 09:08:12 -0800 (PST)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: louis.chauvet@bootlin.com
Cc: hamohammed.sa@gmail.com,
	simona@ffwll.ch,
	melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 00/16] drm/vkms: Add configfs support
Date: Tue, 18 Feb 2025 18:07:52 +0100
Message-ID: <20250218170808.9507-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi everyone,

This series, to be applied on top of [1], allow to configure one or more VKMS
instances without having to reload the driver using configfs.

The series is structured in 3 blocks:

  - Patches 1..11: Basic device configuration. For simplicity, I kept the
    available options as minimal as possible.

  - Patches 12, 13 and 14: Allow to hot-plug and unplug connectors. This is not
    part of the minimal set of options, but I included in this series so it can
    be used as a template/example of how new configurations can be added.

  - Patches 15 and 16: New option to skip the default device creation and to-do
    cleanup.

The process of configuring a VKMS device is documented in "vkms.rst".

Finally, the code is thoroughly tested by a collection of IGT tests [2].

Best wishes,
José Expósito

[1] https://lore.kernel.org/all/20250218101214.5790-1-jose.exposito89@gmail.com/
[2] It is not in patchwork yet, but it'll appear here eventually:
    https://patchwork.freedesktop.org/project/igt/patches/?submitter=19782&state=*&q=&archive=both&delegate=

José Expósito (16):
  drm/vkms: Expose device creation and destruction
  drm/vkms: Add and remove VKMS instances via configfs
  drm/vkms: Allow to configure multiple planes via configfs
  drm/vkms: Allow to configure the plane type via configfs
  drm/vkms: Allow to configure multiple CRTCs via configfs
  drm/vkms: Allow to configure CRTC writeback support via configfs
  drm/vkms: Allow to attach planes and CRTCs via configfs
  drm/vkms: Allow to configure multiple encoders via configfs
  drm/vkms: Allow to attach encoders and CRTCs via configfs
  drm/vkms: Allow to configure multiple connectors via configfs
  drm/vkms: Allow to attach connectors and encoders via configfs
  drm/vkms: Allow to configure connector status
  drm/vkms: Allow to update the connector status
  drm/vkms: Allow to configure connector status via configfs
  drm/vkms: Allow to configure the default device creation
  drm/vkms: Remove completed task from the TODO list

 Documentation/gpu/vkms.rst                    |  98 +-
 drivers/gpu/drm/vkms/Kconfig                  |   1 +
 drivers/gpu/drm/vkms/Makefile                 |   3 +-
 drivers/gpu/drm/vkms/tests/vkms_config_test.c |  24 +
 drivers/gpu/drm/vkms/vkms_config.c            |   8 +-
 drivers/gpu/drm/vkms/vkms_config.h            |  26 +
 drivers/gpu/drm/vkms/vkms_configfs.c          | 918 ++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_configfs.h          |   8 +
 drivers/gpu/drm/vkms/vkms_connector.c         |  26 +-
 drivers/gpu/drm/vkms/vkms_connector.h         |  18 +-
 drivers/gpu/drm/vkms/vkms_drv.c               |  18 +-
 drivers/gpu/drm/vkms/vkms_drv.h               |   4 +
 drivers/gpu/drm/vkms/vkms_output.c            |   2 +-
 13 files changed, 1138 insertions(+), 16 deletions(-)
 create mode 100644 drivers/gpu/drm/vkms/vkms_configfs.c
 create mode 100644 drivers/gpu/drm/vkms/vkms_configfs.h


base-commit: 9b6c03cb96b9e19bce2c2764d2c6dd4ccbd06c5d
prerequisite-patch-id: 1bff7bbc4ef0e29266265ac3dc009011c046f745
prerequisite-patch-id: 74a284d40a426a0038a7054068192238f7658187
prerequisite-patch-id: c3e34e88ad6a0acf7d9ded0cdb4745a87cf6fd82
prerequisite-patch-id: 9cd0dfaf8e21a811edbe5a2da7185b6f9055d42d
prerequisite-patch-id: f50c41578b639370a5d610af6f25c2077321a886
prerequisite-patch-id: 5a7219a51e42de002b8dbf94ec8af96320043489
prerequisite-patch-id: 67ea5d4e21b4ce4acbd6fc3ce83017f55811c49b
prerequisite-patch-id: 37a7fab113a32581f053c09f45efb137afd75a1b
prerequisite-patch-id: 475bcdc6267f4b02fb1bb2379145529c33684e4f
prerequisite-patch-id: d3114f0b3da3d8b5ad64692df761f1cf42fbdf12
prerequisite-patch-id: d1d9280fb056130df2050a09b7ea7e7ddde007c5
prerequisite-patch-id: 2c370f3de6d227fa8881212207978cce7bbb18ba
prerequisite-patch-id: 938b8fe5437e5f7bc22bffc55ae249a27d399d66
prerequisite-patch-id: ab0a510994fbe9985dc46a3d35e6d0574ddbb633
-- 
2.48.1


