Return-Path: <linux-kernel+bounces-551536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A504A56DDA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2142B3B83BA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223F223C8CF;
	Fri,  7 Mar 2025 16:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFq+1D8l"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BCB1607A4
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 16:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365241; cv=none; b=ZGBSQzJTageXhDPV6zUcj5peonQ9NBOWNLMb+qRa71NsWvuuBPx+gB1bHsLGgt+EVGIKZWgtBSiQnmY++x08l1bMLb7UyP/1yu5kUhHInh9BbvO8GlNjWg1iqyxqPnr0k8N5A9LiEXVJ4WWq+x8nHz5OebJEHL4MJ9PUjUNrBk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365241; c=relaxed/simple;
	bh=iQlIzHtyCwlGcb7Er8PBgL0GFY310hseVnNldeydl7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QvHM80Ht051xWwYEBcfkU4d50VHGGYWqkfjxUDP29EYmbzfzzGt+XqAEONORVfHXuCecLyb8MYFCjhGE3ZJtbT15PkK8NxFEsCnqjV5gv7oBHycptqsQpFmG+VeaB45iQlfZzXtcy0euK++UX2hewn1RJNBRekRxdzhEvAqGQVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFq+1D8l; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-391342fc0b5so1261324f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 08:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741365238; x=1741970038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vm9Bfz6JbIJ378qC0it1HzTk3jXpGGODeE+NgRJA20A=;
        b=IFq+1D8lOXydXt4A1yRhriWWuwZJSrQu70sJ1dfmrMS7bu+CWbwH27wpkyXb3vnWM2
         bg+wQLO5uvt2/cwR0Yp/ddp1ywY+gGyqlvicFkb9ROKWQ3izVc3uqj6K2O3n191WRF/g
         T+0/PHKufGTyqBBxVxS9xZUdOIZBhqwlBvSMOQ9DcEZqcTzEpEfkY7+hF+dFWD/BMiTO
         QNTp+WF5koGbXuCOncwcTACWXJ1ARXoREjWPeAKEy3VA0A1pUGsSRZxLfwIBCI6jsTPH
         UqoE83sXkZpW4bVLLZ+5Uqc28AZ/3+hUl+lJ3HSUjgmpDRhpOTpLsS6vOL+a2E2scfol
         8GRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741365238; x=1741970038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vm9Bfz6JbIJ378qC0it1HzTk3jXpGGODeE+NgRJA20A=;
        b=GHLGGs9XtksL34ZpqvoO8AVN4sfhMcxTzKPju8zMJPxw32iTK+U9LwiF+9iXY0IEsH
         fps6/SsxfxValZ2zMjI0ToWcbtzL/yNJyqHAWruvtuQVDuQz0Ft+Aye34HwFXhi2uMiW
         7Zx/LjpCe9YSYJPednfGgLPFpLWV/SaFMtMgxpmfkFoGY0fCS9KgYlSFVkkkZX6HNvHS
         aS8OTyzhzLofFB+ZbusHCK2m0dLpXLNo/VS3c9YJmr//Kxlrn0CNfD0HbXvw/6RJFKWA
         mrJf8VFPxZV/Eymtpkxa7uSVlXbtIV+XpW2QPa7+xwk1VVRjtb6FsMliBBW+nzQXs/NF
         /wZg==
X-Forwarded-Encrypted: i=1; AJvYcCXEMeWMVLCXHJZNe2RwloR1qrM6JEAhVzcZEb0YXxbNF9JLq6IgLAKytFkF3R/ebykl+J6A1EPmN2RoxwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxflZZ4EcQ0Jq28jzrYm5O1yVAeAUw6IevNlxG4OwMGZ1Nd1Uxh
	1HXZRmOMkkNoMLImwyRSSHJ3xHtYWRWPYzmCTyKmTXzHrVUjE+NA
X-Gm-Gg: ASbGncv7sQ9EXT2x7aBuQrpwnnv+u4EG6GeBAZYgM3BnHClqPzvljwTmuBvhAXLJmlK
	Tjzx058UdqK+kmG7La07Kwn/30p7cktzxNX4Se2PmISzajbaQaNi0adhcTXH3S7Bf8SvN3MsnGi
	aOpOCjhh4rsCRof6M/28++PNxkrMcCyu+3RUWE3F+IIEeAItrj/7kaSt2eFQTHelbx4QdEcO3IC
	cpSIEr8Mrg43qbiBJ4eptUcLCKNgtBHLvB5iLJ7aSNGHhSHO8egCtpMYqfgg6JmH02+YLnJLjzF
	TmTbZPq2bsEkFJuzfk/svvKZhTZA+tGzVuVK3Ul0rfTUZNc=
X-Google-Smtp-Source: AGHT+IFbiYvKoYtgwvkhobPihEDJGuAH06BPac2DQev4T6RARv+m5Y3Ur1FW3BdPTHrqS2+nV6i5og==
X-Received: by 2002:a5d:64c7:0:b0:390:e2a3:cb7b with SMTP id ffacd0b85a97d-39132da28a0mr3850747f8f.34.1741365237661;
        Fri, 07 Mar 2025 08:33:57 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c019557sm6031436f8f.50.2025.03.07.08.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 08:33:56 -0800 (PST)
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
Subject: [PATCH v3 00/16] drm/vkms: Add configfs support
Date: Fri,  7 Mar 2025 17:33:37 +0100
Message-ID: <20250307163353.5896-1-jose.exposito89@gmail.com>
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

This series allow to configure one or more VKMS instances without having
to reload the driver using configfs.

The series is structured in 3 blocks:

  - Patches 1..11: Basic device configuration. For simplicity, I kept the
    available options as minimal as possible.

  - Patches 12 and 13: New option to skip the default device creation and to-do
    cleanup.

  - Patches 14, 15 and 16: Allow to hot-plug and unplug connectors. This is not
    part of the minimal set of options, but I included in this series so it can
    be used as a template/example of how new configurations can be added.

The process of configuring a VKMS device is documented in "vkms.rst".

Finally, the code is thoroughly tested by a collection of IGT tests [1].

Best wishes,
José Expósito

[1] https://lists.freedesktop.org/archives/igt-dev/2025-February/086071.html

Changes in v3:

  - Applied review comments by Louis Chauvet: (thanks!!)
    - Use scoped_guard() instead of guard(mutex)(...)
    - Fix a use-after-free error in the connector hot-plug code
  - Rebased on top of drm-misc-next
  - Link to v2: https://lore.kernel.org/all/20250225175936.7223-1-jose.exposito89@gmail.com/

Changes in v2:

  - Applied review comments by Louis Chauvet:
    - Use guard(mutex)(...) instead of lock/unlock
    - Return -EBUSY when trying to modify a enabled device
    - Move the connector hot-plug related patches to the end
  - Rebased on top of drm-misc-next
  - Link to v1: https://lore.kernel.org/dri-devel/20250218170808.9507-1-jose.exposito89@gmail.com/T/

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
  drm/vkms: Allow to configure the default device creation
  drm/vkms: Remove completed task from the TODO list
  drm/vkms: Allow to configure connector status
  drm/vkms: Allow to update the connector status
  drm/vkms: Allow to configure connector status via configfs

 Documentation/gpu/vkms.rst                    | 100 ++-
 drivers/gpu/drm/vkms/Kconfig                  |   1 +
 drivers/gpu/drm/vkms/Makefile                 |   3 +-
 drivers/gpu/drm/vkms/tests/vkms_config_test.c |  24 +
 drivers/gpu/drm/vkms/vkms_config.c            |   8 +-
 drivers/gpu/drm/vkms/vkms_config.h            |  26 +
 drivers/gpu/drm/vkms/vkms_configfs.c          | 833 ++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_configfs.h          |   8 +
 drivers/gpu/drm/vkms/vkms_connector.c         |  35 +
 drivers/gpu/drm/vkms/vkms_connector.h         |   9 +
 drivers/gpu/drm/vkms/vkms_drv.c               |  18 +-
 drivers/gpu/drm/vkms/vkms_drv.h               |  20 +
 12 files changed, 1072 insertions(+), 13 deletions(-)
 create mode 100644 drivers/gpu/drm/vkms/vkms_configfs.c
 create mode 100644 drivers/gpu/drm/vkms/vkms_configfs.h


base-commit: 2c7aafc05c8330be4c5f0092b79843507a5e1023
-- 
2.48.1


