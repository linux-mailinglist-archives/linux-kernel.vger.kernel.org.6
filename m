Return-Path: <linux-kernel+bounces-271712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B23094525F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 19:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324F91F23721
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC16D1BB68A;
	Thu,  1 Aug 2024 17:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iiYKyfvG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969251BA889
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 17:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722534974; cv=none; b=tfgZid4BJ2CP1C3kFE7Ky5I3Y8shXTGhhGdfqZQuopKY95ezeEeaFqSlaGbucytD4L9HwEw3RcuqKs4BdJI2axfbenoAylg5ZYZdHlPCOxfg0IAZHIyqpwp5fCgpGU0QQ9/vvZBMtyibojyfTGcLENkXo6wATY5o0EkoY4zcqec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722534974; c=relaxed/simple;
	bh=RuMDuPIyTfHh9y+AmyefSxAA9N7VfDDvvbHO50ATeI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FJ7ajNjEqX/5E6kCnoRKf5a6gdVLD4tPVmeML6gR2vdeQlI2jw471zjpPkOCe6nxhevklHUUQw1hDu/yj0z00aJcxJ2+GOdFsgNbsfktcIO4i20dSdFZ/16iwFn11wSNvnP/YZCwc4MweE40Gfa3HYIiw1uztBI9HePmSztm+9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iiYKyfvG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722534971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MuSsWoFff78J8yjVq4pT+k5ugpCaxGaJf6GePdVC2I4=;
	b=iiYKyfvGZozzO8Yolfy3bkWSCfcmlXM2yoge7XO5ivEXeiZQLtlhKJCl/o9lqxq3as//6J
	HI5Fv2WKN42aO0i7OmFcEBJFmbts7yyZvNxssOzIBB6cJXimBHYWS1oUK3bMaTeCdmUfXv
	TNgWNoL3L97f8GNbQMV+WHo8fcbKgxc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-ZQqU1FvXO8mOUFtERRacBA-1; Thu, 01 Aug 2024 13:56:10 -0400
X-MC-Unique: ZQqU1FvXO8mOUFtERRacBA-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5a0d7d02a8aso1130943a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 10:56:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722534969; x=1723139769;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MuSsWoFff78J8yjVq4pT+k5ugpCaxGaJf6GePdVC2I4=;
        b=qpKJTzfFS1tpBRmoh7h+5HTJE5JjxfK8s1YpnViLHS47e+vPji2pUP/eWBrYDcXMGQ
         7a4gfEN3SNdtf2hMDpbT4r3rWuOBZaTKgbsiP9PiWZmekD1HLh7+5pqGAc4LG1UMjkww
         HJvneFO3EfU7xcTz3HbW1FAUm+K9oDrlszb2l3HmdnkUFUzrafBkgXWNn4h90pFw0fAx
         6WZyzU8ZvhJXQh0XYIdk78g1H/hNVM6BoCNPF/tOPEy394FRccImYd7S5ozoYLQpdCJA
         /f285ybpDpolftBTttOaTwrfu3EU/aAslDmY5CLGhUHOFEo+EtyvTAET7Df2idW5XExz
         54kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUwnbn6CR318bAXiekAwadGE2IrxTv11dmJ9RPi2tzXayU+Zc/Cnvdl1lqkkjkksMAPW0eGMdNmrl/jk8HMNTetM8tXYHqLKIZE5QA
X-Gm-Message-State: AOJu0Ywd9pzJGveT08wBASSnZVI7VshTk1x7pPdr2m2oc8L5m+szeMVH
	XyuNTflVynZfyczxddX99b32zRDs3mW76HEdfnSo7DXwNrrW8ES2cLduD632XAbo6lMq+UFp3G2
	R5YlKo3Ee0Y3t9BVdB+A254sPChP3yAHAJ0ITxu3bIQjFUf7ihWw4RwiF/0JjEA==
X-Received: by 2002:a17:906:478f:b0:a7a:9f78:fe4 with SMTP id a640c23a62f3a-a7dc4dfb4c2mr32475366b.3.1722534968947;
        Thu, 01 Aug 2024 10:56:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3YNYmcksNDsheMu0uIi0ecbeWrwb+5Hhu4U7CjUo9vDsR9fcD6yt49amTbFO0Q3Np4TeStw==
X-Received: by 2002:a17:906:478f:b0:a7a:9f78:fe4 with SMTP id a640c23a62f3a-a7dc4dfb4c2mr32474366b.3.1722534968454;
        Thu, 01 Aug 2024 10:56:08 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3d4b:3000:1a1d:18ca:1d82:9859])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c61575sm6510666b.92.2024.08.01.10.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 10:56:08 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Philipp Stanner <pstanner@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: devres: fix error about PCI devres
Date: Thu,  1 Aug 2024 19:55:34 +0200
Message-ID: <20240801175533.51885-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation states that pcim_enable_device() will make "all PCI
ops" managed. This is totally false, only a small subset of PCI
functions become managed that way. Implicating otherwise has caused at
least one bug so far, namely in commit 8558de401b5f ("drm/vboxvideo: use
managed pci functions").

Change the function summary so the function's dangerous behavior becomes
visible.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 Documentation/driver-api/driver-model/devres.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index ac9ee7441887..5f2ee8d717b1 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -391,7 +391,7 @@ PCI
   devm_pci_remap_cfgspace()	: ioremap PCI configuration space
   devm_pci_remap_cfg_resource()	: ioremap PCI configuration space resource
 
-  pcim_enable_device()		: after success, all PCI ops become managed
+  pcim_enable_device()		: after success, some PCI ops become managed
   pcim_iomap()			: do iomap() on a single BAR
   pcim_iomap_regions()		: do request_region() and iomap() on multiple BARs
   pcim_iomap_regions_request_all() : do request_region() on all and iomap() on multiple BARs
-- 
2.45.2


