Return-Path: <linux-kernel+bounces-570237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66380A6AE0A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC1D39A0170
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CE823F368;
	Thu, 20 Mar 2025 18:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgM4uSmO"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C621C23E242
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496839; cv=none; b=Z9QD0LwTSIa5f4PAGwPC4H/JXu6LdnN55yuCYl0Co6RHrBVFhfQXB6KxSU1RfjX3wqUa9fUoOj+YaMteq4j+JRofnx+yUd3KtOc7h99WdXXeAISmOfMBxfH8s5ev3bwWpXs/cRUGDKNlCKENjqk+6tkBvZRQmgTuhrUdElBl9ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496839; c=relaxed/simple;
	bh=9NtscGLERKvma6MVRefJ14MqvdE12lJjU+jsKPBV/DE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fnQ+VVSSPvi2BaeUFIDbZP2rf5qLyL6p1vzgFDGB0FAG2leJ2FPY/0TSMSSMdCaJC3bSTGf8KO20B4agMUW3nSMCR4rcRyD2WSKmTKWNfI/zyfTaLpqZLGhjNYu3p/OG7SYya08vHi6dIgbCvm0OkN7bXBTpX0EE3FjZmEb0Spk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgM4uSmO; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-85b41281b50so31037339f.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496837; x=1743101637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3ieg6OYf20TvXEjKUEioS2vPpvBZB2Yv38SKV0x07E=;
        b=MgM4uSmO1bBvAshBR/qu2ZNIsxEbgPbqrK2hz/PoZ/7repDMXsglxUle+Mc1dcO4yU
         7WJ6afNfs5ZsAgL+lvTVO0pLXupAMAsuno2XyQRm2K2ycnYpx13RR0J8F5eTv4BqHtiK
         jjtrzeyOH7RcJrGA3ovkJUQ1ccK9+xO6FSl7QoTCaOMEFx/noekw9gF9cQtH5m5gYodv
         Kc3ZgxLN/6EtCyjy1b5rw2Qo7deDRpZYcGkRM2fval5S7TEBNnz4sH2yv7OfGzkJ6ndF
         OC9BuHrzBBKPopx0MvuG8sO6Fz1AB2MPd8fLN9K7xTjFE2w0d0qQabfr7fKNS2gL+BXd
         Hx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496837; x=1743101637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/3ieg6OYf20TvXEjKUEioS2vPpvBZB2Yv38SKV0x07E=;
        b=VU96ZnYeSzT1RXSi6CA2DxkYJ52bTeu7uy3cHYEzK1hcQteLcCR87kEa88Z13ZLKeQ
         +3LaPL3AUk8ilSv7K6DRSZWC+kM54MwfjvSNh3Bn6kb4E3HDqME2AllGTv4mY7pQNmtd
         uEZdOklDdqKI38mGUxCQaiUgjsMYwxq5Eyj9SpzpgVm2PSgfV3mc6jm0RtS32F3SxUWT
         TRDc08gJBwVG0FovtckywYjoMZv265xYAJeZPQC+SxYw7CMgfy71dAysSbw5hrZjxC/3
         Tmz/1d+jfRe7TkDoYAW6FtPAcSo0jtAeZiMohopBo7Csrze1dUSK0s3v8B1rSDSu94rG
         VXAA==
X-Gm-Message-State: AOJu0YxQOUyj1k/LZ1Se2jOhNGIsMf5CBwlHHfRB5DgFe0uM5rrj849D
	UczYWgixBoXw7vDnx7bmBjvHyoG7jlCqMAwsqC9O48TTs6MwzfgMscmIVO2u
X-Gm-Gg: ASbGncs9D43XmuNK2ElwzAVC5mtjJD7xjUu/whrlhtDRY/+1dasMNIC6Wu3fPv1wQvv
	+UN/gukvoZTi8OJdqHty70OC6gRo1IkDI9bOPKz32t/IvtDjMSmrn7BnD+xz3/qV8pyn9rjoQCk
	099b4VpLO67ayferfkyUoKmOWh/wNX29tLkqosHVCrHHS4zYTumsDGX/UwzKQZTWvQkPR4nugZC
	jPejw8Lp723GNFpc+4DEVctRXD0KrTe4VT81FDoHrCgbpf/mv8ahwNNs81dEOsyOR6ow+je7YZK
	eYaDI160e70/LdaC4CcN44IqANOq+xF+C1a86MRmB5n5ruKHhkky+388PkUzZI6DRq/SGQcSaC0
	BYKNvM59ugrlh
X-Google-Smtp-Source: AGHT+IEV5S9iAZ4P4kAl5psRQa2kOypMVf8ugJ/2bScFr4uYQKD/pc1j30FSkS+FGYaEZcWCdvjtbQ==
X-Received: by 2002:a05:6602:488b:b0:85e:1879:c708 with SMTP id ca18e2360f4ac-85e2ca388bbmr48761539f.1.1742496836822;
        Thu, 20 Mar 2025 11:53:56 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:56 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-gfx-trybot@lists.freedesktop.org
Cc: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 46/59] drm-dyndbg: add DRM_CLASSMAP_USE to simpledrm
Date: Thu, 20 Mar 2025 12:52:24 -0600
Message-ID: <20250320185238.447458-47-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320185238.447458-1-jim.cromie@gmail.com>
References: <20250320185238.447458-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tiny/simpledrm has 3 DRM_UT_DRIVER debugs, make them controllable when
CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg that the module has
class'd debugs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/tiny/simpledrm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index 5d9ab8adf800..bcf2cccac0ec 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -34,6 +34,8 @@
 #define DRIVER_MAJOR	1
 #define DRIVER_MINOR	0
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 /*
  * Helpers for simplefb
  */
-- 
2.49.0


