Return-Path: <linux-kernel+bounces-238482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DB9924B3E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3083E1C20C0F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CAC1D3078;
	Tue,  2 Jul 2024 21:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1gxJkUu"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471E01D1A05
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957561; cv=none; b=enORbDK4VrWIbuG/UH9vWhKQveuX7xvhTA3mpT4nCRYOhEOSaliAt/czi8AjiGqlCJGqJSpLGbw6yBjjAHZZJLQaQF+gZtv9adog0bp7o9EoQuUGaFeK93/er3jR+ZxyrPAaDxXtM4/W677KvdCdOlnH0s/IvfLuO4X75CndM3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957561; c=relaxed/simple;
	bh=iX3YPrehKsc8JYsY/MYFOXIO6YJ0coOili+oIW2ckmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YlTh4e83moPTdogjynr2AnAZvSwSnUjmvPQJurODS3z1tJV6N7XINIR61JBus3bFj56lZmwHS3LceAGFWjse2LWPLKrODqZuj0MVJP38IQp2CyIyxaRGwuNlVBL/2XFuEBGNVCBGC39MBmgI6Fl3et3Im3hFM1blSm2uTI9tL9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1gxJkUu; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7f5f7ecacc0so203298739f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957559; x=1720562359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+Eqreo55RWzciyFbwYCY+bKp2K8wKhzwrrhakb4uDM=;
        b=i1gxJkUuQLbmWihy0UR2M3MdIscIa0j6zCWsIS49pvVatdL/qeyMVim6Ar4KIWMZnQ
         cP/Fc2p0vReC4x9QTnfoxIb8Jq8MSG2tcDb5gUBQVp1Az7KKlU8qgjtGFHOcPb909V0S
         McSjQs9V3HvfxJdaGcwNLloasK62NW0Tk75un1g1jPwXSyicgLoKjuqXBiASrtu2j6WP
         QAWjWqaDnScrmfobL7is7nTiwhs1dHjnRUHhgjsdMlC5IVmfZkarzAJnJED7tov9DCfD
         0HLIuitwLZWDkB5w/hQugXVUuoBWb+ix4kb/DQnkggRa6g3erlK6qKo3vvhk9DbfDn1p
         c/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957559; x=1720562359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+Eqreo55RWzciyFbwYCY+bKp2K8wKhzwrrhakb4uDM=;
        b=vzpXviakhR1RILn0kg3zoxCDlF8zIuyTQKpV7e2jQGaqdwGQQkx2pGzYY+jg1GXBbM
         zz1PrqKHiXjW4mriS2Ol3iPPpiEnq+2gBOXqJ/xjpnrCiEM+UJFazZ3nQOyWh4EHAATz
         ZWmIa4iZJH208xDThMt1z/54KB1q3sIXlWbls8bNzUGzSTDAzUb64Fg10GinhQtQcMoQ
         DdQikSejfY2YZKj3yOozdbtRvNQwvRaR0tR0t6t6Q9KWU1jF9f+IeRio3k9bc7c6HRVL
         C+dAzyuwYmimYqMIlDEJ0Q2UDFRECYdWGziBrPWBMdmOVc74AHC3eQIsRzcrPlo5C/Sz
         FkLw==
X-Gm-Message-State: AOJu0YyV3bzj++BoeVuEGecSW8VavCZl4QuCZtL1TIJX0XWaOGdTS7PS
	13dwtiir1/4GmU8cSyB86XFQ6YFcihR8Oc88b2jsIzxlDdEKna0/
X-Google-Smtp-Source: AGHT+IGcyZCDZRZp6V6RnDZJi7b8GdP/ji76gbOaeQMp4gTOzKk8wvV+sE7C+kypGaK6A4D4KgsymQ==
X-Received: by 2002:a05:6602:600b:b0:7f6:4f7e:b87e with SMTP id ca18e2360f4ac-7f64f7eba13mr445715539f.21.1719957559493;
        Tue, 02 Jul 2024 14:59:19 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:59:19 -0700 (PDT)
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
Subject: [PATCH v9 44/52] drm-dyndbg: add DRM_CLASSMAP_USE to radeon
Date: Tue,  2 Jul 2024 15:57:47 -0600
Message-ID: <20240702215804.2201271-58-jim.cromie@gmail.com>
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

radeon has some DRM_UT_* debugs, make them controllable when
CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg about its use of
the class'd debugs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 7bf08164140e..d22308328c76 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -247,6 +247,8 @@ int radeon_cik_support = 1;
 MODULE_PARM_DESC(cik_support, "CIK support (1 = enabled (default), 0 = disabled)");
 module_param_named(cik_support, radeon_cik_support, int, 0444);
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 static struct pci_device_id pciidlist[] = {
 	radeon_PCI_IDS
 };
-- 
2.45.2


