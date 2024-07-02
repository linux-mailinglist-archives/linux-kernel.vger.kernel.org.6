Return-Path: <linux-kernel+bounces-238498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7058D924B4E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 00:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A289D1C22735
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 22:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A931E1D703F;
	Tue,  2 Jul 2024 21:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhcSgRzQ"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A519E1D6934
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 21:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719957580; cv=none; b=kiNS44+fSdz3Bzu5fzKWd8PJahi5MMEk91pfhQH8es+AAI9oOGP6xmJO6cIJk41ypMtYy3VO/oGZ63cYKXz1nmfvLHfAINZPN+YfGbB3BJQ9UFEOoya+UT2LZ7J5IKVLesjA/YM9eIgGrsNvMzHhIAMntXxfcILGsg2evAhlqUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719957580; c=relaxed/simple;
	bh=NrZTh+SVApVcDabxYuiZu5lzSzV3H/ZDPU+/aI7Ofs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EEbeTfDZQGnXXTbydJ4BPX7tqndHRTis31SL+lmatrl4afCNquuvolWdOCUrOShjUfU9vMNj8uJhwkx28dIMSQjTcLpY8LJKpC7daWivXfD4XTmemADimHSJdABt9BCXYfhyOl6foeUnNF7WWdtufNN8/tSuZsWV8YqweBbs5ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhcSgRzQ; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7f64942fc54so88584739f.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 14:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719957578; x=1720562378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ym+La6D/NLLhNjjl/GCbF3WdukVm3ek2K4bqw3UNhOo=;
        b=IhcSgRzQJUx8dQFCk/xD9IGqfmk9BuINIFscBzSVNx9h4uzWC1LURywCVbzLai7Jgc
         LpRB63Xcwa2J8C/4XY3BtQFbqyV1z/W2dz5zira8cXCmNW/IQV2MdqA3j1mnkgP36njO
         v/nlLx09NmMBQbLQZW9kZAJCzjo3U7VaO04EQ50w+QyiwREO14pRq6GXggwyFMzQoR0D
         cQqvamCFVCwcWxBIs+Pp4jVs/MRrft4dOYL5xQk+X66l+H0J7dzq2Za7m6Ddz6mrqFnv
         MxoBtiPqQmpN4CxNelJ5Cgqfh/dvxegOJDQfcwu1iW5yq3YORsH/YdwmIZ0xK/su7DRB
         hQqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719957578; x=1720562378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ym+La6D/NLLhNjjl/GCbF3WdukVm3ek2K4bqw3UNhOo=;
        b=fsF+PucGpca+7D3OmwC9g4pQks6qqamxlcIkoea2WC4VAGCOmDf8xP1+UYsKQuju5n
         j2Q0o7jscJkNqho7hjkew7QwCKXc2FfyxHVEOQqi7XI08QRBVxJ7U/ZmekO9fPz+yIUA
         8UUQjj2Fxz7yj6wgdu6UpnbCXv+WgxEx2SYnWFegD0tQFFoszCHr4Ml4+wuAc5fAlf1V
         PcgspmBRSg4nLnw3CjBgSPXzXjINfAR5YBantDUdwc9v3dgiBogDM+mWeenq5mx+J+qm
         mdt09TOYjoVh+KLPxwrlg5y5lcif66+I6VVLX3mmu3/8NPGwV8/UE46P5H+aDJVyPOPl
         60wA==
X-Gm-Message-State: AOJu0Yzqw736OgOxfJBMzfJYykSVzyGvcAr3gvn/7xYlRH8R6D3nnttG
	WlAXLs3UCKL4E24d7IhpERjpZ3ZOk4hQGbxWIeHfic7i7bnwTlqW
X-Google-Smtp-Source: AGHT+IEx2Gyrde0A2uOqS8y+YjAXzajqP8cUSrab+Dm1ugLLW9FFgCd4CeSHn5fLmUCcTWDUd94ipw==
X-Received: by 2002:a6b:e01a:0:b0:7f6:1fcc:25c5 with SMTP id ca18e2360f4ac-7f62ee9b593mr1304401439f.19.1719957578034;
        Tue, 02 Jul 2024 14:59:38 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-7f61d207fcesm279944739f.51.2024.07.02.14.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 14:59:37 -0700 (PDT)
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
Subject: [PATCH v9 52/52] drm: restore CONFIG_DRM_USE_DYNAMIC_DEBUG un-BROKEN
Date: Tue,  2 Jul 2024 15:58:03 -0600
Message-ID: <20240702215804.2201271-74-jim.cromie@gmail.com>
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


