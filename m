Return-Path: <linux-kernel+bounces-570238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08415A6AE0B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6257298560E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEC823F417;
	Thu, 20 Mar 2025 18:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+H53GVN"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A2823BD12
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496840; cv=none; b=ZZ3u2UQPJRUIkNP44Urgaq0deNZtcjNDaYFtevED98eCG7sT+VHF0XTnGpMErB5d7O6WDr9SnPaYdXA6RTdwWz74xdLmIFzGlPmI8Kccwbi9yL0MO4lUGDOBRmmYWv9WVwSu6fo9SJjfSd+ZhMPnG67Mh+H3u9oIxAnxEYc6mTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496840; c=relaxed/simple;
	bh=KCHO3lLH7dI4RY8+BKa/OQC7CPvk4Z4wABHEVsW8A4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=adHXHtm7kBfGfBJ/MofTss7nQdczibrQgU/RNSEsS8YhCRgVWo994E3MAcylvm9XHENw6yQ2fOhruxh5WfpIZIfoJ9BpGd36SzYysDrOgAHtZXn0rjDm62eNDvD26Ny89JtMnGhe91aTiUJYSChaQf/QWZJY3YtA1RFTMi+vGPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+H53GVN; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-85b4170f1f5so31711139f.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496838; x=1743101638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ck+/k2kUl1gxvAy57O83XENj4jmXSLh8yxG6/aZ/GV4=;
        b=h+H53GVN+0blphq7ZTsZ7TVu3BAbRTX8A8DetvOXq9rG3RUblozL1gGIAGQe/f9NVN
         zwk6gTPBio89So3q+AJSx7dVfXiteFKDi8SNG5prC4ogAhqkqk0EPV9t3C1ZbNRIeqiU
         FZVMOL9hWASO6CO3lXpd6cfEm/tWFHiGWxlF0+Ag2gR69Z6icokUQjfLcuxd1TXoeCBo
         D34vJojPWoTUi8WL+b0qzO7goCHOs5xJE8R11GbLed4fTdv10klTzNo2JCr82KplOhme
         VK+2de9XsHxSogMdzrCpEjQmeM+nFZ1doOiAaapvTVMCMqOv0Iwp7Qn1vvlsY2diSsW2
         qlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496838; x=1743101638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ck+/k2kUl1gxvAy57O83XENj4jmXSLh8yxG6/aZ/GV4=;
        b=ruBpilKGwPCz23xSygxMhse6OTUC6D5Jc0fWNDAgGaRMeFL0lQObZOuY73Vmz0fCGt
         l/pRzymLtekj8jMoco0FL7NSy5cWQej6TiV1awvOB8W9kxlTqHe956BPvlPOwsWwVef3
         vs3Lv/L9G9hQrueZV1gvxZybVuO+vLoxSsb8JK8BCDdI74LNEu0qJuPkQhVt4bivWTMe
         gaTxUeJ9ejE5vG2bf/m3WOuwsZKCh67EDbKYGRv6/xZicRDITN5cQF58NQ7C8ys1TpSr
         1Qw6tiI5dXX089SGXh3psgs9VCFAwDNkG2kpqaVEvmLCcwG8FWrUZJLa6NkqP+Eh1cuM
         nowQ==
X-Gm-Message-State: AOJu0Ywk5TQlJkF37+zpMJBb2v09aml+msqqiFslut/5T1EuKbdV6mg2
	+irI3bXUGGH/smidj5ULZvZv1DB88EqYxjJXw2bFfHgEEiFNNCjw9F+lLDO5
X-Gm-Gg: ASbGncsVBLJ7GKrg7fHrr1dG4TGj0D4lmNViWrbAQDkUvJpR65P/RhYdQ4lmjxC/scJ
	KCny791QDX8Bz3BUClv8ASmce9LnXYnOEM0c2woKmX1gylTod4x7eVilJqKPEuCeIeuPwWGvvCM
	J8tlaq2PyQlscrFJoOtFY8IG4jyNeXzxmOkrEwC6HD+vx3Fmwu9xhJW7Zm9p7C8MYPPcpRGZ6n4
	HCrSbp8tEoRrfjbmaqNLYx8XM+KHr7R4/HOCGfu57HqkxOo4fTJm9kDGziWoyiVPTwiYMUctqNz
	ujiuV9uvJepH0L+Btb89wcdxa0hP4SEI6bD9cOhlB8QwjENKgtyeVR1Q8TH++3+gelX3nv54FoG
	/bA==
X-Google-Smtp-Source: AGHT+IGUEti7ctdmH6bFLDYmAxNDQnvD0h8GxVJRFPAW11NDjRFBr4OYo/0+VvPBBTOSLXboR9af1g==
X-Received: by 2002:a05:6602:3607:b0:85d:f74b:f8a8 with SMTP id ca18e2360f4ac-85e2ca19fa0mr39028039f.2.1742496837861;
        Thu, 20 Mar 2025 11:53:57 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:57 -0700 (PDT)
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
Subject: [PATCH v2 47/59] drm-dyndbg: add DRM_CLASSMAP_USE to bochs
Date: Thu, 20 Mar 2025 12:52:25 -0600
Message-ID: <20250320185238.447458-48-jim.cromie@gmail.com>
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

tiny/bochs has 5 DRM_UT_* debugs, make them controllable when
CONFIG_DRM_USE_DYNAMIC_DEBUG=y by telling dyndbg that the module has
class'd debugs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/tiny/bochs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index 8706763af8fb..dbcc8ba70dfa 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -59,6 +59,8 @@ static int bochs_modeset = -1;
 static int defx = 1024;
 static int defy = 768;
 
+DRM_CLASSMAP_USE(drm_debug_classes);
+
 module_param_named(modeset, bochs_modeset, int, 0444);
 MODULE_PARM_DESC(modeset, "enable/disable kernel modesetting");
 
-- 
2.49.0


