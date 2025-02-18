Return-Path: <linux-kernel+bounces-519144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F46A3986D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A1817A2D3C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 10:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5292376E2;
	Tue, 18 Feb 2025 10:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlV0pknR"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B330235340
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 10:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739873544; cv=none; b=WNCfeOEZ1uylplHD/9nHWw45GOyRTRPRhG/X+zckXhtJsQ1QJBrNMKMEwQ94v8QKvoQU7oQ0T/USCGXNqZQpiVHd7UTE1WKGUVBFEL1ZB1yfDoLfN4nECa7wyR3tcJz3RRFqGX0/TohxSpSDn7C9LFDwxJkQepP95XuxgK6RTtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739873544; c=relaxed/simple;
	bh=iJ1wF22gtGKFy8IPO7jTVxUD6V4MSpuqCY/dxF6QSW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V6ZS4hbAZJwF1u3Snwt4Iml5h1oZUpHAfp7GUDGoGD2siI5yep6xEts4SwcypHf5e3A3RTxv5PazNJnSKYubajfjOMUAPhrE4VRcXG3J3oE//EPnFs1ekFbF73n0CvDJtSZNLmxlE9/5DeXslLM0Dpflzdz/s6NisSeWr9nqoNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlV0pknR; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-38f488f3161so822887f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 02:12:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739873541; x=1740478341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KzaKelF6ewY20dvSvB6oxOqjssEbsRd1FkO3vSloUVY=;
        b=XlV0pknRoGuyIhPL0QiWfVxAe8q+PMmSADBmfPPnTlXXkFjkPwexK6T9RRIQCxHxxL
         tnscLVDf1ESePeEe2qO5UIQq7bWIvHNPi1dHWLuHv7UK9b1S3whpylLmHZGEW83YeLDi
         Nq9C9vhN2PnD2oQd/chsl3LLxUEUPbrq3dD7UL9M9dyk3n8wPOn8X4e0OZqgMZbTERAP
         mGVbwXQ6spmN7Z8QmgWA/AyXl931jqQeAg/GvARttA8fOs+5QpbpI/ibbz8M8euLDglm
         JiZe8XtuQI6o+6TyWXbw5gfhdPGssVh6lEzlLgst8vijEeRhXiWvusTRfEbfxYSe4Hio
         IMew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739873541; x=1740478341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KzaKelF6ewY20dvSvB6oxOqjssEbsRd1FkO3vSloUVY=;
        b=NV5ONS+jmSIIxGST9zNBvPXTyNILESmD2rdzWWFyyrKx9kZjl3jXQLuboStwv3h+V9
         A2EHqcTLLjh9rfBQqcXjPZ66+tmDJfbrGYdrxIJyx1eAZyaY+F7rSSuqKtd8kTcn0iZs
         ahS6znbQKAPkilXZ1VtJJ1BZ0lGhsXazsbskI9/SZkUJVT8PYv2dY7bALnmI62Scl7NX
         In35icdB4hghF9lExwDV69+0sHLhoWUoOXu46YEJd46H3o7MHprzijg4H13SCuoPmHJC
         dLHrk4dhzoUYnSNSo3Q1FVbTxA5otlknnQgj8ggqymlyt7lBfl5b5Pn2OYPp9VCbjKAi
         kA4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXqI5+iUHSHKHG81xZXcums2ajFAl+Bo4JnQPlOS7PwcTCdZBTAhdZ52SwTXM22V/lJ80hswJUONzZTLEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIcAf1D95fgRVmCdXT9zzkR9VYLD05i53+UVD1Pr052TB1e6sM
	23CtfokABsTxS4gFuIVYC+BIqzZBCDuUBtD9vKhWLELikghpmN172e4Nfp08
X-Gm-Gg: ASbGncs9zxTG+jupnFIzkEI0s6jv/PFFVyQOF7idTZnOQZs/+RKqxBKuz1H9fmoXUx6
	BPXq6QHRVVfPNvwXFd7LPN/Q77B1vH/HPJxjl3uwgeIEAtT8PmHGRDoEIlrArrqievQ+lwQOJCg
	wMEyREIZC6smym5at0k8RYLOwd2kQ8J0T8bzanjVP+CZA89dk6HpZChrEvJzPYNNFxcEioZW1hw
	5qSfDu4lzSewfZnvKYlapyzIcG76Df5yuC90lZitS6G2WP82Ldt6P/aDFtrjQGGGXsLhgoKXCLO
	7FJ9XHpnimajO/n6Lw==
X-Google-Smtp-Source: AGHT+IFJqmlOPYv2whyB9uTyDtXAvBkom7xqtQiVURYwPLVKMA7Zw2zRcC9D9kSP1CEZrAymwwKzqg==
X-Received: by 2002:a5d:64e6:0:b0:38d:d946:db15 with SMTP id ffacd0b85a97d-38f33f1186cmr13193513f8f.5.1739873540759;
        Tue, 18 Feb 2025 02:12:20 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5e92sm14749720f8f.66.2025.02.18.02.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 02:12:20 -0800 (PST)
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
Subject: [PATCH v4 00/14] drm/vkms: Allow to configure device
Date: Tue, 18 Feb 2025 11:12:00 +0100
Message-ID: <20250218101214.5790-1-jose.exposito89@gmail.com>
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

Changes in v4:

  - Applied review comments by Louis Chauvet: (thanks!!)
    - Do not access "private" struct fields in tests
    - Reviewed-by in all patches
  - Rebased on top of drm-misc-next
  - Link to v3: https://lore.kernel.org/dri-devel/20250217100120.7620-1-jose.exposito89@gmail.com/T/

Changes in v3:

  - Applied review comments by Louis Chauvet:
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
 drivers/gpu/drm/vkms/tests/vkms_config_test.c | 951 ++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_config.c            | 640 ++++++++++++
 drivers/gpu/drm/vkms/vkms_config.h            | 437 ++++++++
 drivers/gpu/drm/vkms/vkms_connector.c         |  61 ++
 drivers/gpu/drm/vkms/vkms_connector.h         |  26 +
 drivers/gpu/drm/vkms/vkms_drv.c               |  45 +-
 drivers/gpu/drm/vkms/vkms_drv.h               |  17 +-
 drivers/gpu/drm/vkms/vkms_output.c            | 176 ++--
 13 files changed, 2246 insertions(+), 141 deletions(-)
 create mode 100644 drivers/gpu/drm/vkms/tests/.kunitconfig
 create mode 100644 drivers/gpu/drm/vkms/tests/Makefile
 create mode 100644 drivers/gpu/drm/vkms/tests/vkms_config_test.c
 create mode 100644 drivers/gpu/drm/vkms/vkms_config.c
 create mode 100644 drivers/gpu/drm/vkms/vkms_config.h
 create mode 100644 drivers/gpu/drm/vkms/vkms_connector.c
 create mode 100644 drivers/gpu/drm/vkms/vkms_connector.h

-- 
2.48.1


