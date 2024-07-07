Return-Path: <linux-kernel+bounces-243475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA0B9296BC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 07:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E15251C20D5F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 05:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406428480;
	Sun,  7 Jul 2024 05:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jP/YIf2G"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B32F6AB9
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 05:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720331639; cv=none; b=scIqUvoA8bOGM7kUWcBYhqTb4wSCWncELuDSgMgjrIsOdotJE0EYk4r8e/iveGpqwr12m49wSv+OV7J2OJMhlmBkErnYaq4bGlJp1wEoPm114SUqj81u1jRF2zSLrhff6Bpj9VmVH2AZRrnB/XRiSQZbzr44ve0JNBYfM8n94yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720331639; c=relaxed/simple;
	bh=oB0qz98CkLjU5SPz9XStXQV+zFbEJRTt7gY3fomOlcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cHHjMYnASYxX/P/QdbgZ/vABF2oi6FJ1TVsST7pMSp8zlm8031oxntmFiX6MIAUGpRJsM3REoiu0JBh+uEaA6wqYu9HgjtiYtQzfsEyHSQyWvtSaSHE8YsysOIAIUwyLmZckMAC+x4ft2jN+PqU5rEB8yVIljRjCaTX075+yqxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jP/YIf2G; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3d6301e7279so2021793b6e.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 22:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720331637; x=1720936437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lf5eB5gQe+ugDPVo5OexhK1yFoWg+Ll1LkaVKdwFPUs=;
        b=jP/YIf2GGCk41g9svnZ0+lposD8Oc+9FxdW3amVtznZAG/yVwpxH5oUeA/FECEWmtX
         bJ/JHZCQZrDa1O/nhxAL4vlH+2jLMtDFfnbOv0BQ7NxuqrtzpVAB7OqvQxZtDfGutDGU
         2MRPT6kPzn0kOyKJP223oGtqwTkBVsUUgqfZd0tq+BqVyaq76m8L06hhEPqLnF1Yjx+j
         eJAQcgpwc76f9y0mKA+bWumlNv3qFMwy4pKxYTpTya6FmrdSaGfyDeBGum8b4OaxMZjf
         0lHuX+s0APiol2oLGjd2fAbTM3D+hWJ8bRdjg6REFCNwXjcngRjnoU5JZo9IpRldCVlp
         EKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720331637; x=1720936437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lf5eB5gQe+ugDPVo5OexhK1yFoWg+Ll1LkaVKdwFPUs=;
        b=X3jAvXHYiOsmNOva6ro8zI1OXqi2JRbm0wsFXXpwqbOLTEr9pifvZDyYXJIL0zzhaG
         NlLg/P8uGJlG8BFe8YP6uol1DSs6VZj+gXYqHzl17owvoec/2zCZkVBvN37xE+ieLCnu
         i6/weprnitD2UvB4iYN/1sZhXXU7adWJFsjzGJ1MTmsQL0bUsqTFeWizhLX75/VaDCzi
         kuwvVhPDQzXMnTWULTRd/YsImDApWcVqSxj0bnZZvkcSrpSqKPtkd3jrh75umgOna+2a
         vrzsZ9yuwPK/cf5/Z1MylnbAno4pY7no4PjpU1bShuaPBXtCojh62qX7nyQxvl7v6lPi
         8cXQ==
X-Forwarded-Encrypted: i=1; AJvYcCURfm/LCqtvs+1vu3lbiZPAHKw7VznfMkvTfCoCI1U4ynLBb2LquMDeg19LAXcMci14Y/8e1hG4fw+QVPstbSkgLeFgDd14T2gTplug
X-Gm-Message-State: AOJu0YxTsItiYGnON4aqp3qsKPS+Orp+poAoV7mMVZ/YY/tTwS5uF/u5
	gPdBTv2KXY00QdzM7swCiBaNOJUx4SD14AmOo+VAysNyg1Bf0Shs
X-Google-Smtp-Source: AGHT+IHtZmtvjyz1tctc81zBzknJCbRvgfLGu2vyxfT+krGwYhRqYnmkSx5OeON3Ld5M3jLa0B0/9Q==
X-Received: by 2002:a05:6808:2386:b0:3d5:5c77:fc1b with SMTP id 5614622812f47-3d914c8282bmr12832641b6e.26.1720331637100;
        Sat, 06 Jul 2024 22:53:57 -0700 (PDT)
Received: from kousik.local ([2405:201:c006:312d:252d:94b8:b79c:d7bb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b2e5fe3dfsm94429b3a.97.2024.07.06.22.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 22:53:56 -0700 (PDT)
From: Kousik Sanagavarapu <five231003@gmail.com>
To: Nishanth Menon <nm@ti.com>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Julia Lawall <julia.lawall@inria.fr>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Kousik Sanagavarapu <five231003@gmail.com>
Subject: [PATCH v3 0/4] Do device node auto cleanup in drivers/soc/ti/
Date: Sun,  7 Jul 2024 10:44:15 +0530
Message-ID: <20240707055341.3656-1-five231003@gmail.com>
X-Mailer: git-send-email 2.45.2.561.g66ac6e4bcd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do "struct device_node" auto cleanup in soc/ti/.  This patch series takes
care of all the cases where this is possible.

Thanks Jonathan for the review on the previous round.

v2:

	https://lore.kernel.org/linux-arm-kernel/20240703065710.13786-1-five231003@gmail.com/

Changes since v2:
- Split v2 1/3 into v3 1/4 and v3 2/4.  The memory setup code is
  seperated out of the pruss_probe() function and put into 1/4 and the
  actual conversion to auto cleanup is done in 2/4.
- Replace dev_err() with dev_err_probe() in the code paths touched.

v1:

	https://lore.kernel.org/linux-arm-kernel/20240510071432.62913-1-five231003@gmail.com/

Changes since v1:
- Refactor code so that it the scope of the pointers touched is reduced,
  making the code look more clean.
- The above also the side-effect of fixing the errors that clang emitted
  (but my local version of gcc didn't) for PATCH 2/3 during v1.

Kousik Sanagavarapu (4):
  soc: ti: pruss: factor out memories setup
  soc: ti: pruss: do device_node auto cleanup
  soc: ti: knav_qmss_queue: do device_node auto cleanup
  soc: ti: pm33xx: do device_node auto cleanup

 drivers/soc/ti/knav_qmss_queue.c | 100 +++++++++---------
 drivers/soc/ti/pm33xx.c          |  52 ++++-----
 drivers/soc/ti/pruss.c           | 176 ++++++++++++++-----------------
 3 files changed, 155 insertions(+), 173 deletions(-)

-- 
2.45.2.561.g66ac6e4bcd


