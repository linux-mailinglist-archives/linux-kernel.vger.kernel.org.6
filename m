Return-Path: <linux-kernel+bounces-438293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7209E9F73
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294D516646E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 19:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E0E198A08;
	Mon,  9 Dec 2024 19:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HqTj7231"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF38197556
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 19:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733772337; cv=none; b=LYSDiz8C26SrpB9+PGtwxOJaLoZKW+oxowJH5zWvq93bc95x7mAAZELJSaAUa//Rpyn4eK0DmOMsRvOdb5z/yTJLQpA9SKyKxARKeXtVPKbEaWwgXdbwHZW//jPAxLGRAPTQGwIuSbDlK7POw60LppG7FS2UHdep+onV2heJRF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733772337; c=relaxed/simple;
	bh=1YPD5dfhPPSSjjJMM8/8DpsgemLtu5hAhcvsO4anuRk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=k4FrQDBXoWJJFBg2jncgPj5z7mQTB92bDSSMIkRRHTRlpeGZK/lmf+oW0jlBfTgu7barXrjzeDfIi3+0kRaI9qsRu/cGvvGoNdxOR3e7y3Tv9AawkMmBsel9LM9OGK1LA/KvHOhGhmlWLJFlmturC6aK/rZtHfkAE4hzdRUhiYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HqTj7231; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b6d07c7d84so131695385a.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 11:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733772335; x=1734377135; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T5w/djmSfwnx1UtWBiBpykCG/spzcgrBqm/dY5n0vUQ=;
        b=HqTj72310htkJRFlrtpTqUkgUCfA4LNQzhsA2kUD/UklmnGGO1Jyz0lpyT1aocfqZC
         IktwMeFP7obTYx97bwnPh4O2oPuCMxPopRS3XKfreTOc+K/40p1HIlO4LUEhhbV7Bf+i
         LKYdV9oRotdF45wX0Mv2oaKftw7ssCR0aW8Gw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733772335; x=1734377135;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T5w/djmSfwnx1UtWBiBpykCG/spzcgrBqm/dY5n0vUQ=;
        b=qsl1nHUr+iZKTu+s6czNsvVHajCcUSome+alYvEbGBCEZFy5Oj17BPfajFriwRJdhp
         Vz3P6alzio+UiuJRbsnqY4UhMrZKSSTJwkTdVVkSX0PdmtU5bvbXrb0VPDqV7Yj1CajA
         dS0Te71eX1ypzril5NJ/N/u60eKhyfE5UtZtQm54QEmEXKOIkCi0iPtSs/hCZ81Hi2+e
         2fJPchks6AjT02NmInEDmsTEVNMDuBxqrG+GBU4AX2uxZS52HghnAuWNoJisG6k/BWNz
         FO9rEG5ac7fAEC9GHqvEcCGtrU0t+NqLm+4F5vyBAYxWSDefT2MaAgpLWbjsj7jGK19y
         Hfbg==
X-Forwarded-Encrypted: i=1; AJvYcCWUD2s2ocB2zRP4VUG6IFo9M5oCpv/n5wYfCjtQngRHDvIbSkaPekS1nFTK92WimJEbS3bk9PmyzKlEUnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgCtSUG8bvINicDl+d4ahrKCO68dOXMiLwJYm7Tkwe5RTxJwdg
	et/EHqq7i/inSSptiIfAiQ9QzXBjGWj42OYDdiqNNBTuu5NmealG58jpBkJs/A==
X-Gm-Gg: ASbGnct4snBIQNhDNWbZRL9IXwveBIL2CyanWA5DGkH0alABoL2uTqDiX6fvpT2i/RQ
	5q5/wX+Eej7g2RdchBTFOlhSZx7kLRMyC+derw1OGYr8JxlFmdHwi30DZoIjiE+z25JX6s4UnlB
	3R56TucddIDt7Ta1263INJg0dhioJDkd+4IrZfLnURBd5bQzYPRiQVKBGaM3Ri2BZGwoNucuSgr
	lIU4h0tyEswGTLoVO0rMyRm2p2L9WrENnDKk+svDUKg4vnt/8K2qlZlN62N/IG7Sx/nGI7StXJY
	8pA/RMlzJ0FfHP9czT6L7EOU
X-Google-Smtp-Source: AGHT+IHTy8N14hX6y10Y/KkG5JUIcGqpVcCeWrjq1oZqk0Lx9TuMCx/Mta50Hbm2uF+mXX752TqB8w==
X-Received: by 2002:a05:620a:260d:b0:79f:18d4:d613 with SMTP id af79cd13be357-7b6dce86c6dmr235351285a.38.1733772334831;
        Mon, 09 Dec 2024 11:25:34 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6cc1cf6fesm217433385a.102.2024.12.09.11.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 11:25:34 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 00/10] media: Remove vidioc_g/s_ctrl and vidioc_queryctrl
 callbacks
Date: Mon, 09 Dec 2024 19:25:31 +0000
Message-Id: <20241209-queryctrl-v1-0-deff7acfcdcb@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACtEV2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDIwNL3cLS1KLK5JKiHF3TZGMzY6Mk82QLU3MloPqCotS0zAqwWdGxtbU
 AgCzU6lsAAAA=
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Mike Isely <isely@pobox.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hans Verkuil <hverkuil@xs4all.nl>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-staging@lists.linux.dev, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Most of the drivers use the control framework or can use the superset
version of these callbacks: vidioc_g/s_ext_ctrl and
vidioc_query_ext_ctrl.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Ricardo Ribalda (10):
      media: ioctl: Simulate v4l2_queryctrl with v4l2_query_ext_ctrl
      media: pvrusb2: Convert queryctrl to query_ext_ctrl
      media: pvrusb2: Remove g/s_ctrl callbacks
      media: uvcvideo: Remove vidioc_queryctrl
      media: atomisp: Replace queryctrl with query_ext_ctrl
      media: atomisp: Remove vidioc_g/s callback
      media: v4l2: Remove vidioc_queryctrl callback
      media: v4l2: Remove vidioc_g_ctrl callback
      media: cx231xx: Replace s_ctrl with s_ext_ctrls
      media: v4l2: Remove vidioc_s_ctrl callback

 drivers/media/usb/cx231xx/cx231xx-417.c           | 21 ++++++++----
 drivers/media/usb/pvrusb2/pvrusb2-v4l2.c          | 40 +++++------------------
 drivers/media/usb/uvc/uvc_v4l2.c                  | 10 ------
 drivers/media/v4l2-core/v4l2-dev.c                |  6 ++--
 drivers/media/v4l2-core/v4l2-ioctl.c              | 28 ++++++++++++----
 drivers/staging/media/atomisp/pci/atomisp_ioctl.c | 36 ++++++++++----------
 include/media/v4l2-ioctl.h                        | 12 -------
 7 files changed, 65 insertions(+), 88 deletions(-)
---
base-commit: 6c10d1adae82e1c8da16e7ebd2320e69f20b9d6f
change-id: 20241209-queryctrl-5c3632b7c857

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


