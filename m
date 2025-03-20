Return-Path: <linux-kernel+bounces-570235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E02DFA6ADFD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA6A0189506E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810B523C8D9;
	Thu, 20 Mar 2025 18:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XPosjr6l"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB45239584
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496836; cv=none; b=TZnhRubiNlX6z2IHYRPvfSSnFzApuDNBDJtZWb1NzNcPB+1HI2djutYJ0gUrsmJKz19/gUZsLBg0rzHx0+Qa6AKuYNEmhPcNd4ZHZgxQp5hpXnibbtGqW4KLUPYGsyMrYEQyOVnytOafWinGsTPXGWTBZeEm2RFCNu9IE+sTbB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496836; c=relaxed/simple;
	bh=nXayAqcdlEcp/73PzyITDbRkBO/uOMYZRgU9kmwREN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bYJ2IlfrjKWWvF2vuHoVDcK8jMt2pwhmEbOxosyXriXUEER/IHG0yq2sETmFSmZAJa9sgu/VCD8mwRLfQC6Be4rnXrHOKgI7aylRdmBSvUnXhusOxgO7o7Cxk00YKEsp5y69MWLsK091znZCSx/rnMhM8IdWMnpdchj1Wl24Kj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XPosjr6l; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-85afd2b9106so111078139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496834; x=1743101634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9QKot+Tk4Bgkz5Rby7fJAPuBANHR0qgjbLES/Oc8d8=;
        b=XPosjr6lJp2YZFu+fK6JPVrzOh8yrOmZNRMBYHfiUepSyx3W1M7fsyjlPBPkmObA/x
         nfwUD04XBJfIfztkhgvgoLSaPZ9Bnc1D1QnIh18AUZJkbt5HQQWjiV1yQV0XSFlWE6xi
         UgWWBNhgT4khDgef4sJiv+n+y0b0b3R8HZ73anzBipFa2wN7t1ysoKoIi7sZvVUGgQfW
         XUva2QZT42VwsBKNw/Nk4gXi/Dh/nSGs+48PX44opdU2+rbcn1D6DRJgpuityosqzP/Q
         m6bk/6BxIf5CidnaklxkceNRQBXWPN+txHXK0dFp1Ku/DU1zkfXB8Sa2zSyybq+m3IlY
         3NFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496834; x=1743101634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9QKot+Tk4Bgkz5Rby7fJAPuBANHR0qgjbLES/Oc8d8=;
        b=cNHvtx1PSXNo/9D2RL6Dbxyih+JecYIH/q6aDqxrp8q1hGWO627FgLlpb76kb6ctbo
         OLYHag8qeaZK1BZRQM4muQhfgyMp72jXdO1fWFlt+Lf/Gy6DQFtLPt0yltmYaWsI+3sk
         Lbty+vQhkgqD9ox7jawfExKqaOQeVRktrVquW576WHWP1GRuj7IZYZOgmhZiib/gFW33
         0WjGSxIrTHX1N9cU5YP0YSbITtBWT8ZVc3LiRV3xQt17Yz6FcGmCDvuQarCim28p+40h
         Hm9EdZGVGrhGJbu/SQYVeO82aQ8cBabLOaleKvywDH9u3YQLZNR6BMuD3ypbwu+qSQ9w
         7n9w==
X-Gm-Message-State: AOJu0Yxl3QhIVMrBzpbzy3hnU5qKZYCm5NXcIketpX2GWh8J49uzRV2S
	OIo+BSKe1qTtVabb6JJ/J4US88M9GCanwC5HVFWz+iYhl+c+4he6QUmpGchI
X-Gm-Gg: ASbGncu8c0ltNxhHl7/Y55lWH3FRoExxfS1Yl/BT6JJbDCIcovUUMWAHY86H/jf5ewT
	ltxr+mS7TykFUBDdgJdj73Aenc8cQLEe3n2d9aZ8ryYhTPL1iTFP6nDA4Xu1cQijHLdZm/Krsgm
	wuxoBSGDs2nDGmcxyxXRg+t7zDO7aTdEqkkDByZSVuen0dnHE5lkAmbET3EDBDinIMrLlE1K87M
	gzvbuIjxJEiYBFAaD/BXSWMY33C9BnCATSFRt0o38+lE/0/42BR7pqIPlYzwem7GbqTgM1Ah7FV
	vnDxZ+d5SmvOH6Aq+0sDnFPSQQPbXMJndJULFMksRGacyVeAypb5Seo5zRoKlVtbkt+48m21NxJ
	Thg==
X-Google-Smtp-Source: AGHT+IFfy+Zv4FYAC/PuIemcn5jp6axQXB+zw3jO+0pK/TsGPc1J6v/eMPg/pfYlNqXYocVPsCUG2Q==
X-Received: by 2002:a05:6602:2c15:b0:85b:577b:37da with SMTP id ca18e2360f4ac-85e2cc62797mr34378439f.9.1742496834340;
        Thu, 20 Mar 2025 11:53:54 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:53 -0700 (PDT)
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
Subject: [PATCH v2 44/59] drm-dyndbg: add DRM_CLASSMAP_USE to Xe driver
Date: Thu, 20 Mar 2025 12:52:22 -0600
Message-ID: <20250320185238.447458-45-jim.cromie@gmail.com>
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

Invoke DRM_CLASSMAP_USE from xe_drm_client.c.  When built with
CONFIG_DRM_USE_DYNAMIC_DEBUG=y, this tells dydnbg that Xe uses
has drm.debug calls.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/xe/xe_drm_client.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_drm_client.c b/drivers/gpu/drm/xe/xe_drm_client.c
index 2d4874d2b922..756dba5c88f8 100644
--- a/drivers/gpu/drm/xe/xe_drm_client.c
+++ b/drivers/gpu/drm/xe/xe_drm_client.c
@@ -21,6 +21,8 @@
 #include "xe_pm.h"
 #include "xe_trace.h"
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 /**
  * DOC: DRM Client usage stats
  *
-- 
2.49.0


