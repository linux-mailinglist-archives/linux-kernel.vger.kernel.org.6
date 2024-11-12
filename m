Return-Path: <linux-kernel+bounces-406254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D04AF9C5CA5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B21B1F2191F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A810C2038B0;
	Tue, 12 Nov 2024 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVS5gYWw"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6005D203713;
	Tue, 12 Nov 2024 15:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427110; cv=none; b=OnrjooKWmGso8MHBbqUMI71+pEc8Ln+h1BzmsyM53Mml1b6jwNJVIGQJNc14m3/QIoSSXbFVds8+15VDNpDxqeRNG0d95HE4r85iQw3p3e7b9MSpf2vlS921GDTh2y6pmyK8gsN0FJ4HaBXfcod6jsCFuw3Q7g0TvexaS+EsIGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427110; c=relaxed/simple;
	bh=Wk29+QyBe2z3l3f7+Mpt9+b85LMwjK3ZL8cZ5FYsIuM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o4JZ1wQ1v2etMquZX9sU+PL0K4rtAEefHdtsDUNbKk05eEWfCQzb7JPQKO9ntT2WDA7T/B7FvoXrfGLpoe8uafXCME6xKZm1lFrLrg16LizepEgNYB4Sa46JB7wFxn0cADOHRqV+Wn7ny2vR5O/LblYtKAaR+5va+SgmNd0qv8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVS5gYWw; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-431688d5127so46516475e9.0;
        Tue, 12 Nov 2024 07:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731427105; x=1732031905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/qVENU9+N/71Xr2X4szHCr6pk0/5uELMhfDCvBqSqQ=;
        b=QVS5gYWwBrZL2JNxHxessaebchRBAYfpwdn0VXAHrusCNLa/4ZQQy3CJuZ9DgKY5q7
         jQ51LKiIqmbzDQS2ID30ygPkiEYac/QagXaE4iD2yzKdQrmFAwaOOeVyvEYjRFSvRjwY
         Iag0Ynek/kQEEVWYyomXD5KLO4UA3h8oy2mtNX9LR0Q5b+3U26cQq6YbeSOk5WS7OECk
         4EMb5y3fmCV++MjVXmJZGln0b4Io8fBSSK9oV3R3mbaxZOwEvtHdOf4bWVJi2/lxkP32
         BJo03haWin9aT3Qjtf+hVh66jfUEo3CILUbQbWyRmWDDpTn+5tVg6R5ancy/l6BYxVhb
         rAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731427105; x=1732031905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/qVENU9+N/71Xr2X4szHCr6pk0/5uELMhfDCvBqSqQ=;
        b=AggCkUiKN9tspSosAa1Sic8lSy6etBqjDH0c3xhRyG27KiOK/BBViRUCJgbhCPOxWk
         E7xXwsMQ5XvREHJW5OFo0ktQQCKrpGESlhAOd8Kq1dsviNG/3Bm5PuJ3bX1WF+lKPU6v
         EBXRqFbqQdp6Rl218QL1g2S9JH/u9KaLQFphn5wsAD3o9LD7c+iNkjutqnZaDXsNs88X
         dKCxfSPE8XKM3ynbyjnkHwkBTPWVv+lCTPP2bGAbzduMbAoHrVCJijNOVvvQFl4WP+V6
         aXHk7ncPu4Gi2FltYfuNO5P2b8xkA5rCv7kli0amtxZYPmHzLT6K9ToGPezKb0IN4iH5
         Y/ng==
X-Forwarded-Encrypted: i=1; AJvYcCVnl60Dz/oLNKwxP/5zM8zwiUbybTrHFAIFNwoIbxiEFGhATiEXPEM//dKWcmzFHGHfcHQHnGohNmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3v0sma75wNRkc9K7pzTLdbH9Lcke/jbRoxfkOrP+Ll5wHQHew
	urKD6Zu0lqG0AzlogbBjMuvYB1c486kZF88g1CyFpwRTzE5OhD5I
X-Google-Smtp-Source: AGHT+IH8rG7r+w6v7PiScq7laBsY6abFHvictPV12TRigvPRHmoKnFczKr7jaE8XylK+PpxauJSN9A==
X-Received: by 2002:a05:600c:6987:b0:426:8884:2c58 with SMTP id 5b1f17b1804b1-432bcafd113mr118177695e9.4.1731427104394;
        Tue, 12 Nov 2024 07:58:24 -0800 (PST)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381edc1104asm15991136f8f.88.2024.11.12.07.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 07:58:23 -0800 (PST)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: gregkh@linuxfoundation.org,
	andreyknvl@gmail.com,
	b-liu@ti.com,
	johan@kernel.org,
	oneukum@suse.com,
	stern@rowland.harvard.edu
Cc: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	snovitoll@gmail.com,
	usb-storage@lists.one-eyed-alien.net
Subject: [PATCH v2 0/8] drivers/usb: refactor min/max with min_t/max_t
Date: Tue, 12 Nov 2024 20:58:09 +0500
Message-Id: <20241112155817.3512577-1-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024111251-spill-hatchback-72da@gregkh>
References: <2024111251-spill-hatchback-72da@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series improves type safety in the drivers/usb/*
by using `min_t()` and `max_t()` instead of min(), max()
with the casting inside. It should address potential type promotion issues.

Scanned the current drivers/usb code with `max\(.*\(` and `min\(.*\(`
regexp queries to find casting inside of min() and max() which
may lead to subtle bugs or even security vulnerabilities,
especially if negative values are involved.

Let's refactor to min_t() and max_t() specifying the data type
to ensure it's applicable for the both compareable arguments.

Changes v1 -> v2:
  - split a single patch into a patch series
	  per each drivers/usb/* subdirectory (Greg).

Sabyrzhan Tasbolatov (8):
  drivers/usb/gadget: refactor min with min_t
  drivers/usb/core: refactor max with max_t
  drivers/usb/host: refactor min/max with min_t/max_t
  drivers/usb/misc: refactor min with min_t
  drivers/usb/mon: refactor min with min_t
  drivers/usb/musb: refactor min/max with min_t/max_t
  drivers/usb/serial: refactor min with min_t
  drivers/usb/storage: refactor min with min_t

 drivers/usb/core/config.c                    |  2 +-
 drivers/usb/gadget/composite.c               | 12 ++++++------
 drivers/usb/gadget/configfs.c                |  2 +-
 drivers/usb/gadget/function/f_fs.c           |  6 +++---
 drivers/usb/gadget/function/f_mass_storage.c |  8 ++++----
 drivers/usb/gadget/function/uvc_video.c      |  4 ++--
 drivers/usb/gadget/legacy/raw_gadget.c       |  4 ++--
 drivers/usb/gadget/udc/omap_udc.c            |  4 ++--
 drivers/usb/gadget/usbstring.c               |  2 +-
 drivers/usb/host/ehci-hcd.c                  |  2 +-
 drivers/usb/host/oxu210hp-hcd.c              |  4 ++--
 drivers/usb/host/r8a66597-hcd.c              |  2 +-
 drivers/usb/misc/usbtest.c                   |  3 ++-
 drivers/usb/mon/mon_bin.c                    |  2 +-
 drivers/usb/musb/musb_core.c                 |  2 +-
 drivers/usb/musb/musb_gadget_ep0.c           |  2 +-
 drivers/usb/musb/musb_host.c                 |  5 ++---
 drivers/usb/serial/io_edgeport.c             |  2 +-
 drivers/usb/serial/sierra.c                  |  2 +-
 drivers/usb/storage/sddr09.c                 |  4 ++--
 drivers/usb/storage/sddr55.c                 |  8 ++++----
 21 files changed, 41 insertions(+), 41 deletions(-)

-- 
2.34.1


