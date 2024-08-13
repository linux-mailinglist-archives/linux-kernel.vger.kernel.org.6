Return-Path: <linux-kernel+bounces-284587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AE39502DD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EA7F1C21F26
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F85E19AA68;
	Tue, 13 Aug 2024 10:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BAYg4h7C"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970A019A296
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546302; cv=none; b=LiuZ3YHlLhEsqEVzJY7A0txfyqCbQOwcifnxUhYp5qLFNlT+g69/joSJGQgZmKHa5IMSwuNjVFKp5xDeEoby/9loUJRlouNGKPxlfjrWCBWRlhIzkETw1t+tQo4twY4IyxHKYUkk2cPoAwx4t3M1+sjceULeJdsUIh7cIoE6Gw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546302; c=relaxed/simple;
	bh=EoJRlenB7iqAvO7smcyNSrvCBvBkGgM6pUKJ8SVGxIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pf6uVGYkM/QQ9689bIqnN9h/mmqe8cN7Al0qLEJ6QupwQkjpv/8YfG73nL2VqfgmZlu7OabfpkXlZTDMgchurgrByTNd7BuAWf07SbrJTxUWV0fPZr2nurb9GkvpfW4IjWiZ6Ejy0hrFbg3bWOV86oQegl9fJdkQsj+qDbs8ZzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BAYg4h7C; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso39366165e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 03:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723546299; x=1724151099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FGWIzU9UBPty+CKLYhL1tn5nT2Ew9UDERtQrqlN+ZGk=;
        b=BAYg4h7CqAfRD/zxzjAknfVtMcQ6Q1C8rzlO9vsLC++Mp4z6TfT9OnQij35lfeMm7S
         WvFUkYhDlVD3vpsz+5ha35AZOnyo3PJlTRuCMwEC2rrpBnwirxIBVbBg6bu5Zu2PZicq
         a52xQHyPMCD7X7SjuCE96XZiqz4MHQ8bJKJjFPwLc6krDhs06m/EWAMDtsKVqcu7H15U
         45Nl8AC7kZ7V2/K3BcoTTJ6VqkU/+EJofv/lTcPoZEjLMF0GVrxEXUfjRTr7SF6zIioM
         MXbsWsICRLXx6X4cRVgGv3PPLemdSoFYWRVmFioG07/5lzd5tAm66aOQZNFbK9hYn0hK
         p+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723546299; x=1724151099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FGWIzU9UBPty+CKLYhL1tn5nT2Ew9UDERtQrqlN+ZGk=;
        b=Rh/jwEGIa1eFlYAxac/PPugu7aZCh6FkU2xo3DdPF0+WdB58kXHqgyrgq7wMUTYhtr
         kmsu3fJiDXENe4JbNxOxOYszlspqXfMTDlrC0gzxpZFTxfb+LowcHPGFTX/Dxr8mOK4s
         oNbBmMo7+Xna6pRuCz38bOpXVtd+k1q3GPOh9JsIEOYdNF5NurBKW8H/iKwTMyeyubGA
         NrziCnKulcKyTDiuR/CdiBeyAYZghQvLwC0K495Nr68m+1nhdrFF0Ph8ZrzjFfcku2MW
         A+Th++EZfE5WW8o3rNW1Ncn9MKvrrQMA1VWnjOmdjigTNkuZlb4M4UF44Sbd1tkcDsDO
         fpTA==
X-Forwarded-Encrypted: i=1; AJvYcCVtndisiBpP4A3B7Td/9HYKhJP/sZXuSEpPmTMi8HYxprNnN3J15wdqLASGmgJG7aQj9URogYnVDbfeepHXPJM4kH/6WdExk0Z9o1+w
X-Gm-Message-State: AOJu0YxKCw0UDWYlSF7BnGoIR6OFYcemUGg6Ev6Z8RH3pTkVt7mIMjYg
	4Pb0gBoNSbAidS+REgbe7+mKhYQrQ33KWFEoBRtLwCihQWmYkurt
X-Google-Smtp-Source: AGHT+IGWbgy0PBVcisK1FtGfSWK7HffrMzfzFzEI9qfsm2AIfwJhmohkWStvEIZf+7CLpQ6y4FsSEQ==
X-Received: by 2002:a05:600c:4593:b0:428:2502:75b5 with SMTP id 5b1f17b1804b1-429d480e44emr22261135e9.11.1723546298640;
        Tue, 13 Aug 2024 03:51:38 -0700 (PDT)
Received: from fedora.. ([213.94.26.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429d877e066sm17290785e9.1.2024.08.13.03.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 03:51:38 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: rodrigosiqueiramelo@gmail.com
Cc: melissa.srw@gmail.com,
	mairacanal@riseup.net,
	hamohammed.sa@gmail.com,
	daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	louis.chauvet@bootlin.com,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [RFC PATCH 00/17] VKMS: Add configfs support
Date: Tue, 13 Aug 2024 12:44:11 +0200
Message-ID: <20240813105134.17439-1-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi everyone,

This RFC implements support to configure VKMS using configfs.
It allows to:

 - Create multiple devices
 - Configure multiple overlay planes, CRTCs, encoders and
   connectors
 - Enable or disable cursor plane and writeback connector for
   each CRTC
 - Hot-plug/unplug connectors after device creation
 - Disable the creation of the default VKMS instance to be
   able to use only the configfs ones

This work is based on a previous attempt to implement configfs
support by Jim Shargo and Brandon Pollack [1].
I tried to keep the changes as minimal and simple as possible
and addressed Sima's comments on [1].

Currently, there is another RFC by Louis Chauvet [2]. As I
mentioned on his RFC, I'm not trying to push my implementation.
Instead, I think that having 2 implementations will make code
review way easier and I don't mind which implementation is used
as long as we get the feature implemented :)

I'm looking forward to analyzing Louis's implementation, seeing
what the differences are and finding a common solution.

What's missing?

 - DebugFS only works for the default VKMS instance.
   If we want to support it on instances created with configfs
   I'll need to implement it.

Known bugs:

 - When a CRTC is added and removed before device creation, there
   is a vblank warning.
   The issue is caused because vblanks are referenced using the
   CRTC index but, because one of the CRTCs is removed, the
   indices are not consecutives and drm_crtc_vblank_crtc() tries to
   access and invalid index
   I'm not sure if CRTC's indices *must* start at 0 and be
   consecutives or if this is a bug in the drm_crtc_vblank_crtc()
   implementation.

Best wishes,
José Expósito

[1] https://patchwork.kernel.org/project/dri-devel/list/?series=780110&archive=both
[2] https://lore.kernel.org/dri-devel/ZrZZFQW5RiG12ApN@louis-chauvet-laptop/T/#u

José Expósito (17):
  drm/vkms: Extract vkms_config header
  drm/vkms: Move default_config creation to its own function
  drm/vkms: Set device name from vkms_config
  drm/vkms: Allow to configure multiple CRTCs
  drm/vkms: Use managed memory to create encoders
  drm/vkms: Allow to configure multiple encoders
  drm/vkms: Use managed memory to create connectors
  drm/vkms: Allow to configure multiple connectors
  drm/vkms: Allow to configure multiple overlay planes
  drm/vkms: Allow to change connector status
  drm/vkms: Add and remove VKMS instances via configfs
  drm/vkms: Allow to configure multiple CRTCs via configfs
  drm/vkms: Allow to configure multiple encoders via configfs
  drm/vkms: Allow to configure multiple encoders
  drm/vkms: Allow to configure multiple planes via configfs
  drm/vkms: Allow to configure the default device creation
  drm/vkms: Remove completed task from the TODO list

 Documentation/gpu/vkms.rst            | 102 +++-
 drivers/gpu/drm/vkms/Kconfig          |   1 +
 drivers/gpu/drm/vkms/Makefile         |   4 +-
 drivers/gpu/drm/vkms/vkms_composer.c  |  30 +-
 drivers/gpu/drm/vkms/vkms_config.c    | 265 ++++++++++
 drivers/gpu/drm/vkms/vkms_config.h    | 101 ++++
 drivers/gpu/drm/vkms/vkms_configfs.c  | 721 ++++++++++++++++++++++++++
 drivers/gpu/drm/vkms/vkms_configfs.h  |   9 +
 drivers/gpu/drm/vkms/vkms_crtc.c      |  99 ++--
 drivers/gpu/drm/vkms/vkms_drv.c       |  75 ++-
 drivers/gpu/drm/vkms/vkms_drv.h       |  52 +-
 drivers/gpu/drm/vkms/vkms_output.c    | 187 ++++---
 drivers/gpu/drm/vkms/vkms_plane.c     |   6 +-
 drivers/gpu/drm/vkms/vkms_writeback.c |  27 +-
 14 files changed, 1464 insertions(+), 215 deletions(-)
 create mode 100644 drivers/gpu/drm/vkms/vkms_config.c
 create mode 100644 drivers/gpu/drm/vkms/vkms_config.h
 create mode 100644 drivers/gpu/drm/vkms/vkms_configfs.c
 create mode 100644 drivers/gpu/drm/vkms/vkms_configfs.h

-- 
2.46.0


