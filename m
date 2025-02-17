Return-Path: <linux-kernel+bounces-517312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB46EA37F44
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C802E16314D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A70216608;
	Mon, 17 Feb 2025 10:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vf/taaTH"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7256E215F72
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786488; cv=none; b=rxPY+xn7Nr/p/lSdfhIZhDyQI3hSdV+x1v9iUmLzpc5zew93FQ2nm7QUDKI/P9fkML3mfnmSfSt2lSZpshZ2jj+JF4XZ058rsPClzBnlAVBqDXAcB7DIfMktlvRDUXHL/8xpkSlmcJ1FlVlAAEF3vq8T0jJPoNU1cwJHGvhwhns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786488; c=relaxed/simple;
	bh=pfWP0fIUW48p1mRaC7gRqbzzBiL/uO51yiD7skLN8Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kaoL9YQ2sEpA3psdL6Liu4t6EdFzjuevOuoHEPPF94bpWZbel6gwN9T4PdqisT8rQpx7G+gDwcbQkSWQ/mJcVlqcCGUfWvaP911OWj8YJLXlxLju2VUYM8APjLjcf/KdyclqwbzGkr9Kd4SONY6XCuK5FlV2PgFZkVcDElTDQc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vf/taaTH; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4395dddb07dso43337615e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739786485; x=1740391285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mIy5lDsJ49MxGRQnm+gwxhCdPR/hJ20QsVDEZbE4FZI=;
        b=Vf/taaTHih5KDS8PHLOBFz6fjO7ryTgbktM8giNJo/aSjgTWXcqOuXNIm7ZLMoQOx6
         deQcrBf9sUNmDxBOCCLKIKyV5p7plGFaAPF/oeHYVEw0vbzzk1WfsiWlRzGiaBPcwk2h
         2b1IFtX6ckiKn11e6nGjWM9HHnoF3vhv9b1R03hbtOMC7CnOurlEZg2IjWtqOgS77Zf1
         JpIlcrfEH/xjEJ0Zoku1QdenEvSKSpyVYhd/nbOhLdaiLP0e1BXaMNeMULHyjEWIbswf
         /CZYU++aCFnmOs3OZfVE9+jAFhemfscoLQ6Q//RGFFeSrRM2MwJukcgnDERqwpsoi38O
         563w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739786485; x=1740391285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mIy5lDsJ49MxGRQnm+gwxhCdPR/hJ20QsVDEZbE4FZI=;
        b=OSn0jOIDl4DRIgIvJPk1NWB43tTTk1KmqtFWZKRzgyoniO39rV/YaVFswO/ov0YoN9
         ybBQ76nvyp3z8oTWZwnT7OL06qmS3vidwKHfv4yRhCIsSXM0HCre0YAlAlXkek7iSK8K
         +T+7oEejRn5jvd/Od8MWIl0TSP/a2Te+R1hJWIsjsYYaC46orzgfM3NwOxifSxO43N6a
         xP6Cws9A5dEiFgpw4j89PSROxYduW2PCtVSy+mCCC+C862Az/g5PvHn/+Tme2m4wYU7Q
         nuxL1O2oK+bRlY/+w0p07zPmkD0iY3Tia/8au/Lm5rd3xPpvf3Mx1DXxbY7VeJ9vih8b
         193A==
X-Forwarded-Encrypted: i=1; AJvYcCVH05sl2UfFZr6u6w3dkYIjvgP56rL6Xhhgg+/3OGvRbipWAd0I6mPmjjWtRT2oMz9z30eAagu1H1E2iYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJuOADqSVlmpV1Bz7i3wKx8imIJibkBCHFrc+no6X548rB0tL8
	Kp1O0J+VSPFx0AYNKio2un1aiCcXsnCeuKaEchl28snw8Yvno4ZSEuHA8TY5
X-Gm-Gg: ASbGncsxOcaubLjcKrB2AgCkM57wovERFJScqXKlLTa+XBORLXv+BElm+GKvn3Ss8X+
	XKc5pey972M6kaNT5a11OgCvbEqCsB6/6x2fLjmY1F/4wJAMluYiPzWs0Jxwbf2HvFkQsiwj8cx
	840NDlrJPo1FztTVs9sSoEvNnP5K1K0UJJ8gTjCUwlcAcBNFcLAQjwckSfSljiBff+6qjG7Rrgh
	uuY4WqZ7mWDb5yhPqquUf1or0FdMrUmvMuaEFPwCoX2qJ27geslSDQgBKVjNqUISGKSmaBRCIMi
	wz29z2CzUlQXrzYbwQ==
X-Google-Smtp-Source: AGHT+IGkI0U59QLl1U4yAS+TXnjcW96MHpa8eWRfc6SU7r5dzzmyd315X3nv4Dr2VwmqAo5onTfdsA==
X-Received: by 2002:a05:600c:5254:b0:439:38a1:e49 with SMTP id 5b1f17b1804b1-4396e6d7c38mr87603515e9.6.1739786484372;
        Mon, 17 Feb 2025 02:01:24 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259f7fe6sm11591901f8f.86.2025.02.17.02.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:01:23 -0800 (PST)
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
Subject: [PATCH v3 00/14] drm/vkms: Allow to configure device
Date: Mon, 17 Feb 2025 11:01:06 +0100
Message-ID: <20250217100120.7620-1-jose.exposito89@gmail.com>
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

In preparation for ConfigFS support, a flexible way to configure VKMS device(s)
is required.
This series adds the required APIs to create a configuration, the code changes
required to apply it and KUnit test validating the changes.

Louis Chauvet and I are working on ConfigFS support. In this series I tried to
merge his changes [1] with mine [2].
I kept his Signed-off-by to reflect that, even if I show up as the author of
some/most of the patches, this was a joint effort.

I'll send the ConfigFS code [3] and its IGT tests [4] code this week.
Meanwhile, the IGT tests also exercise this series and can be used for
additional test coverage.

Best wishes,
José Expósito

[1] https://patchwork.kernel.org/project/dri-devel/cover/20250121-google-remove-crtc-index-from-parameter-v3-0-cac00a3c3544@bootlin.com/
[2] https://patchwork.kernel.org/project/dri-devel/cover/20240813105134.17439-1-jose.exposito89@gmail.com/
[3] https://github.com/JoseExposito/linux/commits/patch-vkms-configfs/
[4] https://gitlab.freedesktop.org/jexposit/igt-gpu-tools/-/commits/vkms-configfs

Changes in v3:

  - Applied review comments by Louis Chauvet: (thanks!!)
    - Moved drm_vblank_init(..., vkms_config_get_num_crtcs()) to a different patch
    - Improved error handling in vkms_config_*_attach_*() functions
    - Fixed compilation errors when CONFIG_DRM_VKMS_KUNIT_TEST=m
    - Used for_each iterators in vkms_config_test_default_config(). A leftover
      from the removed connector hot-add code
    - Validated that vkms_config.dev wasn't NULL before calling drm_info()
    - Kept vkms_device.config as a const pointer (at the cost of casting in
      list_count_nodes())
  - Renamed "CONFIG_DRM_VKMS_KUNIT_TESTS" to "CONFIG_DRM_VKMS_KUNIT_TEST" for
    consistency with other options 
  - Rebased on top of drm-misc-next
  - Link to v2: https://lore.kernel.org/all/20250211110912.15409-1-jose.exposito89@gmail.com/

Changes in v2:

  - Applied review comments by Louis Chauvet:
    - Added Co-developped-by tags where required
    - Split the first patch in 2: vkms_connector.h/c creation and struct
      vkms_connector creation
    - Fixes a user after free/double free bug. The bug is already present
      in drm-misc-next and the fix could be merged independently
    - Implemented for_each macros for the config
    - Other naming fixes
  - Link to v1: https://lore.kernel.org/all/20250129110059.12199-1-jose.exposito89@gmail.com/

José Expósito (13):
  drm/vkms: Extract vkms_connector header
  drm/vkms: Create vkms_connector struct
  drm/vkms: Add KUnit test scaffolding
  drm/vkms: Extract vkms_config header
  drm/vkms: Move default_config creation to its own function
  drm/vkms: Set device name from vkms_config
  drm/vkms: Allow to configure multiple planes
  drm/vkms: Allow to configure multiple CRTCs
  drm/vkms: Allow to attach planes and CRTCs
  drm/vkms: Allow to configure multiple encoders
  drm/vkms: Allow to attach encoders and CRTCs
  drm/vkms: Allow to configure multiple connectors
  drm/vkms: Allow to attach connectors and encoders

Louis Chauvet (1):
  drm/vkms: Add a validation function for VKMS configuration

 .clang-format                                 |   7 +
 drivers/gpu/drm/vkms/Kconfig                  |  15 +
 drivers/gpu/drm/vkms/Makefile                 |   5 +-
 drivers/gpu/drm/vkms/tests/.kunitconfig       |   4 +
 drivers/gpu/drm/vkms/tests/Makefile           |   3 +
 drivers/gpu/drm/vkms/tests/vkms_config_test.c | 880 ++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_config.c            | 640 +++++++++++++
 drivers/gpu/drm/vkms/vkms_config.h            | 437 +++++++++
 drivers/gpu/drm/vkms/vkms_connector.c         |  61 ++
 drivers/gpu/drm/vkms/vkms_connector.h         |  26 +
 drivers/gpu/drm/vkms/vkms_drv.c               |  45 +-
 drivers/gpu/drm/vkms/vkms_drv.h               |  17 +-
 drivers/gpu/drm/vkms/vkms_output.c            | 176 ++--
 13 files changed, 2175 insertions(+), 141 deletions(-)
 create mode 100644 drivers/gpu/drm/vkms/tests/.kunitconfig
 create mode 100644 drivers/gpu/drm/vkms/tests/Makefile
 create mode 100644 drivers/gpu/drm/vkms/tests/vkms_config_test.c
 create mode 100644 drivers/gpu/drm/vkms/vkms_config.c
 create mode 100644 drivers/gpu/drm/vkms/vkms_config.h
 create mode 100644 drivers/gpu/drm/vkms/vkms_connector.c
 create mode 100644 drivers/gpu/drm/vkms/vkms_connector.h

-- 
2.48.1


