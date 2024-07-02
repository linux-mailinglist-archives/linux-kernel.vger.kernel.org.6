Return-Path: <linux-kernel+bounces-238477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B3D924B39
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA34D1C20896
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E881CD33B;
	Tue,  2 Jul 2024 21:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RB8yFdvk"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681F21CA2CC
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957556; cv=none; b=pWJYueQdfm02irIQgduMSMzgTKeH1OI8KPMg+lRpOqpan1Cx14gt7Du8ULcGSWHC2avB7QdoIvnYAlXOB3t10/xdHhOTOlv15+565a4XHn0wSxD8uBPMMk0CakkSWUi7tmzWEK7/oolaebj8jDKGsBIyJJSSDhYIIJ8FwwkgfUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957556; c=relaxed/simple;
	bh=tCPOUZzz1n3M3/Vbz4zH5Gffd4O1Gv0jydxTr8IfQGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VpqE1HdPBXEQStouha2bN+tGJLHQhc/T37fI0OHrCMPqR7s+0tDnD+1iB1eLm3cz/Qmr/KRIJGqjcX9qcZ7IsE78W0jn6T975r6+LjpTM21a+5eLSt4/Zf4tLghdleLFUYS5mRyhGgKWSSUd7PqVLCEUDTi5MTtcuPC9rqXdQB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RB8yFdvk; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7f61549406eso180475439f.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957554; x=1720562354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVVliFbCcRiwMu0SQpi190huBei8IpcPa+B6oudggrw=;
        b=RB8yFdvkcwspmHLNXfZeaky4yUA2W65nYaJqpIkgt0nVA9ZZGlDySgS8DbeYvcUEXB
         YHWJI1nIBGZ+PzhSCC0/WtWJSTYDZsIasD7aVQQQS68WarrDZvAp1KR7QgnDmcz+GdFG
         5P2yJFtpdtthXI9KHu87z6IHqzmkhfLCuySMq2pHUfqJG4Ch59hp4KZMEbM9scdw30oR
         Kk/N1V+t251NIuA3WS6yT/qXD646xDQc4tAfmHyJeiUs70pSP2oDk/owW9CI/MaeWQAh
         lmbSRr8y7WNb/d6ZER9kc8ayKr1LfO8vUHp18J/pmzByfDeRCSKYB20po1nai/xa53j0
         bwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957554; x=1720562354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVVliFbCcRiwMu0SQpi190huBei8IpcPa+B6oudggrw=;
        b=r7mvYc1PXe2prsaM2oSDmBjAPrzIPzDgW64I3ftg2y5WBhyb1J/lVqtlA/RFQr82aw
         2mj28imUXOTcvNwAQLZdz3F7Mmp0tY4L4r0VKOYDzMkcHdKlWtHixafo5B5+lhGiQULn
         PEHk0aazOZNyCSKCkizTSBZrSNFfnNjb+VbXKgupHr9qSvRnILfxhibqjm2GPpC9q4Cv
         TgmO5ukYcOlCQjLRetG9vwVyyIj3ObWHM6vhwMIuEPRIgC9i1xCBmC6H9dMU2JVxGiSI
         Q2ZtRLP32Rarr/Bxly61aaCKUfnNmk9b0zb8GMxeaEqSWAXevZImLuFvMPpzFr5xUaSD
         hBgQ==
X-Gm-Message-State: AOJu0YzjHoZ2YFpPSTJEjkeFBAkJnEhgvHeQ2azt1R+L61SdKv1+Ttp6
	IUdkVmP3G2bqFDzy4C0zwSQNkqcvyijenxT6r/9bTi8UjTn9CKBU
X-Google-Smtp-Source: AGHT+IFZ62yf97Gt7+RArnHZHhfQvkUmAT8LPZ/RRX0mXtYibWBEHGPj0AQZKFILtjlHvXFtoqdSew==
X-Received: by 2002:a5e:8c05:0:b0:7f6:2b2d:8ad4 with SMTP id ca18e2360f4ac-7f62edff929mr1067144439f.4.1719957554487;
        Tue, 02 Jul 2024 14:59:14 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:59:14 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org
Cc: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v9 42/53] drm-dyndbg: add DRM_CLASSMAP_USE to bochs
Date: Tue,  2 Jul 2024 15:57:42 -0600
Message-ID: <20240702215804.2201271-53-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702215804.2201271-1-jim.cromie@gmail.com>
References: <20240702215804.2201271-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tiny/bochs has 5 DRM_UT_* debugs, make them controllable when
CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg that the module has
class'd debugs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/tiny/bochs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index c23c9f0cf49c..ee98fab5597e 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -54,6 +54,8 @@ static int bochs_modeset = -1;
 static int defx = 1024;
 static int defy = 768;
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 module_param_named(modeset, bochs_modeset, int, 0444);
 MODULE_PARM_DESC(modeset, "enable/disable kernel modesetting");
 
-- 
2.45.2


