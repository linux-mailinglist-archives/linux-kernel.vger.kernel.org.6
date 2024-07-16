Return-Path: <linux-kernel+bounces-254283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5122793316F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEA8F1F21501
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1591A990E;
	Tue, 16 Jul 2024 18:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JDeOKjtR"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77821A98E5;
	Tue, 16 Jul 2024 18:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156345; cv=none; b=ZDfmzjgsVAab+AkdqLB6n/LJnjC+0qS+OXi095p8WHCpvdbdj1orTuXh7AVKYFwIIlYSre+MrP3di1DzuF0eKprG8GlRGTTk7Ij+N/Takerf7mSb6Dyh/suxxguHfYvuVm8IIlxqbk3RR8/yaoF1ZRRczyERJVTMn7dSUo9PYAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156345; c=relaxed/simple;
	bh=3nsGd1yvcHQVmgJMnEfsgLWbvRxble523gz448yN+Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=koEYt03N0N1QozxL3b6GAn/VeedLt0jdUZ0iiCxnCuVdFS6I9SJQzCsEff5cTd0XAomUm2gqYtlKrxlXNjiK8npn2cGxz7upGX9J3JbPFdGqT36N2lvNfbe4oDIdoG6MnfE7AJiUadg+uOKytRmgoXXXxDNDQLRDba8G1O9novo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JDeOKjtR; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-816d9285ebdso1245739f.0;
        Tue, 16 Jul 2024 11:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721156343; x=1721761143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BKKrQEnQvZmCWcaogVUFAqXRidWX9wMTYH0GRy1A0go=;
        b=JDeOKjtRqygnvKRvwyiuF4gptLyNr0b4fh67GDKI/DnxibF/bEAJ9O2ZSinSJfjdgu
         uPFte9YyUGRR3UqBn+1zUtoABAIbBd4rI/dpkhEKu6zHtFxnNyVOLl67h+mCsYD+hBNv
         ZsuaP8QPnzKF/QgHelndiwaV2tk6GOCYkhqQYe+D7eVYFEz8jVj9SeudhSBpcp1A6lRu
         m2Xob5Z4lSMm3KzaP5sk2ohAH7gVfAGEbRBIJHBGlXJe5zqL/W1SVq3cPHwZ8LCUFiJ9
         CAHRZKHF9JkS9VYYut3JmcqWK6VisWoU4GOxyMh8crMFyegqLXOjGLvepC6QUkawehmN
         r4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156343; x=1721761143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BKKrQEnQvZmCWcaogVUFAqXRidWX9wMTYH0GRy1A0go=;
        b=nr0IkVkMdCbEYOzPEBlkn0Iez+zO6ELcEP9+k/QAdoO+10nAFCNIPeR4kVXvWNdOkO
         kSTNzLBUR/5LApvYY9D+D31h/uiOQZ8wwcxyWb3CeVXM9IjS/Q38+H/SF0/GLGtq6XqF
         nebghvX1Tqd+ezPDVmUTANHj97nFae48bchcsPt9MGqBsz8ca7WV1yYYIgn9upE2SxoL
         s9LKD46GnPfhdkdd2OlUVcF59iN7znB6sR+cmjyFr0aK9OBm6ISOVvT9TlJ7iurWgxB3
         YQ0W3NnO/cYFqehIyVN3XYmv5Rgq4kyfMop1dfrF/5O+PSIyHyqzgqAe5KMSwowpZhW2
         dNUA==
X-Forwarded-Encrypted: i=1; AJvYcCVelUsVY9k50to6SI4OsL0abXpCfbP/OrP2u5V9vMe3UaacDrfBOvkTLS5yP+FaxXqYHXs90IKj69mI7NbT0nEN5D+rc+q/ZSGF
X-Gm-Message-State: AOJu0Yza/Zp/6vLN8gfJ4QDxre0nXOtLPmysmu/TYES31A4KambCqtmL
	D29eeZVgZF7iTksxWtIgHF/taW6fPkrqHVjT6oEHWN7B2a3tfCSWxcouSTOa
X-Google-Smtp-Source: AGHT+IFR9EqMqI1TrHKs8IZsHfJ5cpqX4KLoCBbhGhwmA4IXulbHvDMqbNpb4AouVkB3s3rT9DekFw==
X-Received: by 2002:a05:6602:1602:b0:807:aebc:3bdd with SMTP id ca18e2360f4ac-816c2fe92e3mr41453439f.5.1721156342762;
        Tue, 16 Jul 2024 11:59:02 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4c210f23f1csm75301173.102.2024.07.16.11.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 11:59:02 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com
Cc: ukaszb@chromium.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	linux-doc@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	kernelnewbies@kernelnewbies.org,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v9-resend 29/54] drm: use correct ccflags-y spelling
Date: Tue, 16 Jul 2024 12:57:41 -0600
Message-ID: <20240716185806.1572048-30-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716185806.1572048-1-jim.cromie@gmail.com>
References: <20240716185806.1572048-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Incorrectly spelled CFLAGS- failed to add -DDYNAMIC_DEBUG_MODULE,
which broke builds with:

CONFIG_DRM_USE_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y
CONFIG_DYNAMIC_DEBUG=n

Also add subdir-ccflags so that all drivers pick up the addition.

Fixes: 84ec67288c10 ("drm_print: wrap drm_*_dbg in dyndbg descriptor factory macro")
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index f9ca4f8fa6c5..78b464cd4348 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -3,7 +3,8 @@
 # Makefile for the drm device driver.  This driver provides support for the
 # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
 
-CFLAGS-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)	+= -DDYNAMIC_DEBUG_MODULE
+ccflags-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)		+= -DDYNAMIC_DEBUG_MODULE
+subdir-ccflags-$(CONFIG_DRM_USE_DYNAMIC_DEBUG)	+= -DDYNAMIC_DEBUG_MODULE
 
 # Unconditionally enable W=1 warnings locally
 # --- begin copy-paste W=1 warnings from scripts/Makefile.extrawarn
-- 
2.45.2


