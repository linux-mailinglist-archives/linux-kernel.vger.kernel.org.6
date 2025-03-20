Return-Path: <linux-kernel+bounces-570246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB773A6AE14
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0426817E5F6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082FE24BBE1;
	Thu, 20 Mar 2025 18:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUZg8BgK"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0361A248894
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496849; cv=none; b=hqzf8g4bNxCPPYOxYyQtcI0YihU34zXPhcbySrtGmENHdFr0Km9fRi/V7OixkSG3X/uFAUeqN725WoAkBapmq6bk4lcUm4A1IzY6d9O2Y/HTDQQES8CYjP852SE33iiodoHfdLuCv9lBIG2Tk1SuD2EtukoiR4j3m66X5ZC2ccI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496849; c=relaxed/simple;
	bh=HYMxLPoXW6Y1QIruiib9Zo9L+bclQU5xJEqbXk6UmFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n0AwABIxIhDAIgOpYVu4isSblyYhVuOERqjlMZVMpmWs3mG9dVIjJgNnwPYodJ7jHjC/QQl5vhAP6kVOwumRiMh8g4qyq0bym9ca1NQE8TGxIaWd6jmO36XJUSc16v/koeJQTX30LESEh9CtUs8oUKwH6DsEElqDik2VM4AH3Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUZg8BgK; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-85b42db7b69so12880239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496847; x=1743101647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NT2KOV5clgY+fvBVb0kMabH8vqyg2O7PfGhDz8vOzc=;
        b=dUZg8BgKh6j/4qhhAdC7a9IZ0LYrJK8PrIfx27AnUVSQDdUBCTB5t6KPJFpheBDeST
         LTjnUUiC3qZI3xwBJUgSQnqPDqfRmeOqTKlUKfunJyqL0o6stI09p0NnVPmgsiArHdiU
         KggvfVBW1ef/MEo2pBmNXlIRo9Wy8lR8GNqFXwM0eDL7crxfZkVQDltGSi+DY+ZhoVVl
         pdTYwnVJtnbgNosvGHF2lVk1jyNz3IdljsX+9VV0waFm9FX4tJfGcGd78tt3cRhMW9NV
         UppkeI0p/lx9dd5x3FUtG/IFXB/I241fFNSwPkUE+26NptSyESV9Zm3VxAhOEo2ks+Ne
         T92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496847; x=1743101647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/NT2KOV5clgY+fvBVb0kMabH8vqyg2O7PfGhDz8vOzc=;
        b=fiNg2A8ToonjdRwxVXX5qNntHjNsZqKdQSl245p2x7G5RbTZ8AZVqQ/liVBO7N9aNo
         4Lrw101kVFJ7H3kQTxAnafbjSTu99MeOiOHq+mzt2h4flVeUMjd7Uo2tjLxpImPgpLW3
         CljQEBuFteCSsKcY47jLV7zsorgbwWTRG9jUMFnIDUzcDhME8TKP7Lx0hCLqF9Cxa1Di
         6lecmRPqkAb4M4z4uedsszOzWAUkJ8pkGMSozNyHj47B0C/eChk0B0I/lFyAVvmFvbC7
         VYOlOcaIJFvbI+C4Cf7wKKVYlsmQhckH8kbuIsWpXg017+v2k7OV1cOUh7ZnjmDbKbH2
         N9xw==
X-Gm-Message-State: AOJu0YyW6zCoTEfQYC9RtWl/7QtTkxp2uuaFA6OahX+OlZcy5kFRdX3M
	s7El7i5UYsfoRRFrEzq09EzSo7xlzE8jB177JgrVWDcTtyoaOMI6kPKSdBcy
X-Gm-Gg: ASbGncug4pHvT3kVg1RF3PCi5g+oZjKlC/bZyix+lA43OzB8kAGE4SEaVS+03qVAxx+
	4tFn8M+DORK92tL8Bpvr5tSeKLXmxzX5oN2Wev11gj5Z/ZQ4AzihywyHrtydVz654wgdfTVD0eh
	Kh1S0Dn93lcTU6BZ/x80zykEk5pycwrppSuYqMJnwylN92Z7qjcAklQa9VVjmtDQvJ/14kyvAop
	53LN1VjvQ+aaQNoE6cueqHK5ffY1+gkUXKMT7BDWo58V6ExBr+IFGTr76uCiO2clby9SlvRDfy0
	hosa7Sqsnna5SM8pfryhvTiT8J9ehH/RX0XgLRuZkeCm5e/wr7rA8fH8lMxuiIeZYlx+NZexgjz
	Aks6Ik9sQaSee
X-Google-Smtp-Source: AGHT+IEOoWWyXvNdTlGTPuLwOnrnKkh3QWCuBEv1RJzjp71NeU4mRZKpFk54KaxFPetJO0ADitvIXw==
X-Received: by 2002:a05:6602:360b:b0:85b:538e:1fad with SMTP id ca18e2360f4ac-85e2ca335ffmr49889339f.6.1742496846919;
        Thu, 20 Mar 2025 11:54:06 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:54:06 -0700 (PDT)
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
Subject: [PATCH v2 55/59] drm-dyndbg: add DRM_CLASSMAP_USE to the gud driver
Date: Thu, 20 Mar 2025 12:52:33 -0600
Message-ID: <20250320185238.447458-56-jim.cromie@gmail.com>
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

The gud driver has a number of DRM_UT_* debugs, make them
controllable when CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg
that the module uses them.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/gud/gud_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/gud/gud_drv.c b/drivers/gpu/drm/gud/gud_drv.c
index cb405771d6e2..3843c0e47169 100644
--- a/drivers/gpu/drm/gud/gud_drv.c
+++ b/drivers/gpu/drm/gud/gud_drv.c
@@ -32,6 +32,8 @@
 
 #include "gud_internal.h"
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 /* Only used internally */
 static const struct drm_format_info gud_drm_format_r1 = {
 	.format = GUD_DRM_FORMAT_R1,
-- 
2.49.0


