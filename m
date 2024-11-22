Return-Path: <linux-kernel+bounces-417948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DC09D5B26
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 09:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00080283253
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 08:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504C0189B97;
	Fri, 22 Nov 2024 08:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="PD6FVlLl"
Received: from mail-wm1-f98.google.com (mail-wm1-f98.google.com [209.85.128.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81856176AB6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 08:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732264927; cv=none; b=GEG4HYeeSuevPLtm8FsaSdVYFjInY+mTAe7xEKikurnhSnd/cUyy0GOFG7xg36J46afZYyCCzzRuXlM3zFLK47IbDorXYWW6+U1a1jLqx/xCMXNGlMu9I9Texm1huFTaX743ccFnwGNJKTZFl5k8ELumn3QNI8f/wnbSV4QE+O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732264927; c=relaxed/simple;
	bh=gyfCG79XiYVSu5E2XxIFQwPy9Pgyq7hGjGVSKc8+UQA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SKSZigVwnqfvs7+G0KPubg/zbUW1lbWi7O5ZPC0KwexWuG3DnCbPT6qMm73/YObDpLPxIKFzgjm9kkBhGhz3+lz9/gJzx3cCf9Nq5meXOC2AUuCS8to+GsBvg8P0I+mGTmrulnnKEVcXmEpXskf/Ont2cJiV2opjs/f2FToTnds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=PD6FVlLl; arc=none smtp.client-ip=209.85.128.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f98.google.com with SMTP id 5b1f17b1804b1-431688d5127so15020295e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 00:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1732264924; x=1732869724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rEi9zewFPs0DWCsnyF4sCjmoP2vBLTY2BvhGWxJf1X8=;
        b=PD6FVlLlpDMKA3JYfpaFQOWx2ie5mow/nf+9S8XyPrezi4ds/1zJ30ULstdtTkREFm
         gQhQp3pHDZCaaLshdyyGXR/IKepkeEUCKsafXiRuSaQzmTo11dl8jFj4cVTdoLSfyTY9
         Y/CEBwM4O2YGhqTTxAE/oLjM17amsoWObcF2J7Jt463SkW0ZWMzeS/xF2Je1+IBHNGYg
         a0BjpkPvQRgJHwt2M4RfbmRzxIEnl+pca0Kck4214l4q6NfTmNyl1DcWEDLqQepHUic4
         PPEq6KdJjqvfiRlXHUr7MVeaORvxNjZ1sRC1x3LyKPOSig25r+1QHVeYjTuJ+DB27Ath
         qd9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732264924; x=1732869724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rEi9zewFPs0DWCsnyF4sCjmoP2vBLTY2BvhGWxJf1X8=;
        b=UVBBvO+QvF0VEPWO6knoZCvuhjFkZq7h0U1L+UxK2D4G4BAj05dJ0gVk8M8OiwSc6v
         U5ReAemoNemqQv+v1G2hwqJ0toYLPphdHm12ezD9RVXXYAM+8fgu7l+aRveYwoVCzXk/
         erEv/1hsEbgIFK6uaUCeMnc3V7dkyU1mPDyipzRmW1+HEVx25FpGEOBoH6cszt2MCOuR
         3B5o4l1XnCLZpHDeY5DVm2felUMNVInjzjBCUQ3NsSjks4XkZ82wtFfR0hwDYcB3l04n
         YVBuE+NdRLv2eeRlillWGcfSbQDYAcdc/mQxZI5uP0ieFzdSTX5knZXDzI8EpL5cL39K
         QMPg==
X-Forwarded-Encrypted: i=1; AJvYcCWsF5HcfcIIp8eGQ13lRu8kBIGDEWcSxGCZKG5h2nuO99GmsoJqdcFdL0kDYJ/OhI+kUTP8fSscUZAtrLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV9tRDmIUV4pLeC2oSjEjIFtlu0cnprF9K8VL7Cyj5BHzgaXif
	fZFsD9OqaoSBHVvvQqF9QaBH0unDbsWKx3rlmYRgRBD1eBzK5CZJx7JwhQEy3KNci4cTirZRe7V
	U8Gypqu4QbkNtDTtgDioZGFG63fBoXTBo
X-Gm-Gg: ASbGncvVDi0sKlBJoh1OFlheDYnK32UK6MuD8BV7plvix35Bo4ebaJFSaSvMNa6chyE
	kyZZjToRwEdmKf0jaqhrNAhYZozWwrw763Ka8wuKLKvpRY+u+S9/nN6lkr3i/fVy5zXMcm8KHfd
	zmca8ri0ATpc+lVAKMB97JcWZ+9ODVMAfgB2ebE2fHHnKRezxVzCDbugFWSFJwLtgLzBUZmsTQo
	149BHm9B8BP15guqDy+WVXC272UbAg6ZD+v6lbNLNx5w8MZTulTWkNJ6E86FfB+eg==
X-Google-Smtp-Source: AGHT+IHt2eHtin+KC/mW/m8nqn+k/IAFYJnYIBAS+qecAInjN1Uz6Zv5ysJMIl9yTRvi3sUILxl9g73+D7Yd
X-Received: by 2002:a05:600c:3547:b0:431:6052:48c3 with SMTP id 5b1f17b1804b1-433ce434edbmr17674015e9.16.1732264923575;
        Fri, 22 Nov 2024 00:42:03 -0800 (PST)
Received: from raspberrypi.com ([93.93.133.154])
        by smtp-relay.gmail.com with ESMTPS id 5b1f17b1804b1-433b464119csm3900725e9.47.2024.11.22.00.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 00:42:03 -0800 (PST)
X-Relaying-Domain: raspberrypi.com
From: Naushir Patuck <naush@raspberrypi.com>
To: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>
Cc: linux-media@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jacopo.mondi@ideasonboard.com,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Naushir Patuck <naush@raspberrypi.com>
Subject: [PATCH v1 0/5] media: bcm2835-unicam: Upstreaming various improvements
Date: Fri, 22 Nov 2024 08:41:47 +0000
Message-Id: <20241122084152.1841419-1-naush@raspberrypi.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patch series contain backports of several fixes/improvements taken from the
donwstream Raspberry Pi kernel tree:

Patch 1/5 improves the handling of frame sequence numbering.
Patch 2/5 allows userland clients to return CSI-2 unpacked formats from Unicam.
Patch 3/5 fixes an intermitent HW bug where the first frame shows corruption.
Patch 4/5 fixes a possibly HW overflow when using the dummy buffer.
Patch 5/5 improves the robustness of the interrupt handling, particulary during
fast framerate operation.

All these patches have been present in the downstream RPi tree for some time now
and have been validated by our users.

Thanks,
Naush

Naushir Patuck (5):
  drivers: media: bcm2835-unicam: Improve frame sequence count handling
  drivers: media: bcm2835-unicam: Allow setting of unpacked formats
  drivers: media: bcm2835-unicam: Disable trigger mode operation
  drivers: media: bcm2835-unicam: Fix for possible dummy buffer overrun
  drivers: media: bcm2835-unicam: Correctly handle FS + FE ISR condition

 .../media/platform/broadcom/bcm2835-unicam.c  | 81 +++++++++++++++----
 1 file changed, 66 insertions(+), 15 deletions(-)

-- 
2.34.1


