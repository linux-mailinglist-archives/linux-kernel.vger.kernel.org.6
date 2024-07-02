Return-Path: <linux-kernel+bounces-238499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C02924B4F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD988B26397
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5423D1DA300;
	Tue,  2 Jul 2024 21:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKutTrbJ"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AB31D7036
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957581; cv=none; b=d3Dt0MrIAIbr4Zm+F9CKRhqOQLAS6LMdhkVtqyNHcZ1OczcQv20MWDchLiFUKw4qaSNuLdfEfe88CRPtabBUOQ3yN7VycLtpzzKcuvlQkwMJjAGyGrZXLuwOMHBhFni7oO9TMX12bl0ZwBilyRkVFvUziB/89n5yJraiK8LeoWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957581; c=relaxed/simple;
	bh=NrZTh+SVApVcDabxYuiZu5lzSzV3H/ZDPU+/aI7Ofs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQIczECiPr6wT/o7NMRDGygEsiN3L+EgaenfW0U5du5ALONY2WjYn0GeQigf2lQ2SMgt6wWtU0NGTaIIFtdYIFStnNSWDdj2OGMDk8cIk1H3acYnlKrEeDCzzm9GvoQ2CBGa2HmnBW3rIfevdyd0yeLj9WMOIl6MUVi1RZdo7Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKutTrbJ; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7f3c5af0a04so246317639f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957579; x=1720562379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ym+La6D/NLLhNjjl/GCbF3WdukVm3ek2K4bqw3UNhOo=;
        b=LKutTrbJ/rdYCmKym1NGbxk3QFipDqdro6jwousFvmzyZ9KEopBsMan1ui0JqYAdff
         2JZifakBNMPHEqfAgof6mCkt5pfTSyHZDt9GST5PloYf95xJ+jDVVncAaJ0QwUPvHkPH
         8AknhocYtTD4APmfihZ8MWgEGEqDps79k3wt8OUJgwgA9F6myvw3exk2jKrt7ZUUwyOD
         ZBZKYUdLZHneCp40ZhRIHED6pPUeBHaBrk177/MqYA6jkpgY2R+C4QjXlxikrTVNJEfl
         TUHaTeXuZyyHWueeb9nF2oH9ey/dBClAK9SuAMWCIDrgxiKxv1k+JOvR5M1AaxMQ/LyX
         kofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957579; x=1720562379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ym+La6D/NLLhNjjl/GCbF3WdukVm3ek2K4bqw3UNhOo=;
        b=uWKn1KNsemQEgYVBjWc8P3kGwlpxsswCf5NZ+RlIkx8GJa5qI9crO3SOdMUMtngHeG
         Yw8g2YeWj5osZf+z11WYBTnSqbT+lQC6FVCsSjeH4iYhciZjBZdhN3rMRtW9fIIZ6z7N
         rjErWohSf77LPKxPNNNxgznu8ZwSig4dYkuOJ96UVM3njoKW0OaL334JflqATfUxcr5e
         sGxssiqC/JSJbDkTIeJkRIJ6jcxKeIYpRVuskCG3IsmB2J6sRWQt+yPSWZUs/qZ2FMMn
         Y//wG3h/buHx/gKn+O2uHsJRD3+4mhzGTHhWNCKuyK0oghKmxMhWcXWxquxiRNNc+ArI
         fiBg==
X-Gm-Message-State: AOJu0YwajQH8Mveu3rZK73UfPOpXjxZ8QZVnzOxWqS9/Yx6QaouaHKt0
	4bWvw9U8wU7z+SpYP70jblB9jj10Ni4noZfDu3oGXhwf3PZ2kWUS
X-Google-Smtp-Source: AGHT+IHIRUIlmI3WUW2mIpy7hm5XHgMqtIZ7QkWlOh59CvhPr4UBjQt+AtFMIBoct5NjwYy95AHiIg==
X-Received: by 2002:a5e:d606:0:b0:7f6:1fcc:25c9 with SMTP id ca18e2360f4ac-7f62ee19639mr1076084139f.9.1719957579545;
        Tue, 02 Jul 2024 14:59:39 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:59:38 -0700 (PDT)
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
Subject: [PATCH v9 53/53] drm: restore CONFIG_DRM_USE_DYNAMIC_DEBUG un-BROKEN
Date: Tue,  2 Jul 2024 15:58:04 -0600
Message-ID: <20240702215804.2201271-75-jim.cromie@gmail.com>
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

end of official submission.

Time for some quality CI

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 5a0c476361c3..b2ea73ae48f0 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -54,8 +54,7 @@ config DRM_DEBUG_MM
 
 config DRM_USE_DYNAMIC_DEBUG
 	bool "use dynamic debug to implement drm.debug"
-	default n
-	depends on BROKEN
+	default y
 	depends on DRM
 	depends on DYNAMIC_DEBUG || DYNAMIC_DEBUG_CORE
 	depends on JUMP_LABEL
-- 
2.45.2


