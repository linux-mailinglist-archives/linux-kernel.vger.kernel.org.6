Return-Path: <linux-kernel+bounces-527909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE6FA41133
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 20:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D204B174080
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 19:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB6C20DD74;
	Sun, 23 Feb 2025 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cK1JYMk0"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA78820D519
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 18:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740337176; cv=none; b=S6KbgtYjaRJN3AM+nfWFEdsnJ82drLe7JGWOobmnwrVDACIdUmB6C/SQWwu2mdu4vKtEdTcHw00dY2/fJ/XT1hhpC1KTlwRx24WF7HoxxBJuvsZd8C/qU1nSWj/r7nHzzxLIOLTVN4abKQ09hqln/HnpXUB5S2kLfYuwIZz/liM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740337176; c=relaxed/simple;
	bh=lWWjDY2I/8kPY7a6V4ZbdxW4J2FNahz8aBfrPuD04k4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FjZoFOSc1vjT4xZi2a2WRSR/P+zfB2Sh+Hx+UQj5CSqJpFVnF3VSvo0jpfRa6WEPzm4kqPBSzR4Qhsn1/udfEphh6gwxZVNaGnV/rGKuNP0uFBLUr5F/yeF/X4EdfRNmBOl31yCLWJpQ7j2DDKQqBVzMf8kHI/ZLoQSv1xXt7KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cK1JYMk0; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c0ac2f439eso404862785a.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 10:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740337174; x=1740941974; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y9BY7E7vHC4YHTi+FAvg+DDleZXfy5R/P4AUAZGGpCU=;
        b=cK1JYMk09PrJTEtONWSosnmUSUqqpTW3w+tbk+yuC+1yYsFMJWb5dzRieytzUuuwwN
         wa1YdS081INLyZyycrT021sjmFP6VhYgt3qbLg6XtQLYcui0iigtEqZH36KCvHU0dDRr
         xz8kZPcP7O2RXprL910DlSg7K9MN+VYUptPE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740337174; x=1740941974;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9BY7E7vHC4YHTi+FAvg+DDleZXfy5R/P4AUAZGGpCU=;
        b=H42prqttVBI8a4JLZqKPkdQVXufMUKCoi42yO7Lp4w433Ont5VweXtYed8Dq+eft95
         ToNTGDqcCq6krz7BLSq2B7tF/mInoY9la6d24reh9wtDWuhTJUkLzYkTSyOOsM7m/qMf
         wY0ME5+Csmrvq/Z/q6U+BJj2jFzAbLKfrTO0BPD0tWFOxaum1ZecgIPqV6GwRSrrue0p
         M3zJHwYcMkLOqeXhE2EZ9QIBfCu7UaTbVEMNDtagJkHiQkUs1z6n6rOXH1VLiA5jZBe+
         Tmbx4M3WsM4XtVVSumhABpFC8wZLt/yXEGgbaw/+AQcTInvXvIAS4BzWUvsboiuYO8Z6
         m8hg==
X-Forwarded-Encrypted: i=1; AJvYcCXEvCkmnQlfNbE1J8okzMHjG1IoANEKt8GV1Od4jedT4sMVrVicvIcJzdkAd06+3YuDkn9TKJsxt9aac6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsO6+PUVMI4eiL/zOaDOpEIlP4C1O4VSMGa+79mJr78nzjyMbR
	dkKzry3P+3yzkfrUzmw5fktY6Y1LdAqGoWBMaraSWtN2MMwo1DojJ9Z5AGZkRA==
X-Gm-Gg: ASbGncv98hhcrDt69z+buIa9swsQhQ/YZ+4FfkeTFxYLbQF40kEJHQqPEjxH4y38HrR
	pCZMSmTah2H3f3T3N7BF81p217BMWP5zEPalmK0Q4hVj98lViJTeno/zpNdKjpzbNR6cZql5iOC
	Mt5mt35gDSCNfL73UiT898TOa7iHUaOtChlQsc1gxx+hsQpJuCyW27+k5Q7AXVs3tRykhKxX13F
	HwP02hcOjWo66y3qcMTcg/p2qUZwueka5jLsyAu7/54I5H7U0EtDY3l2u9jGX6xJcg5ZALxkakU
	bkIXc0B6Nd5A/bnv/iGkzBkrM4VH59yMGFa65ICsAaiIF4Fy3GeF7aId9rt7vRaIKybt6L+Rzxk
	FjDA=
X-Google-Smtp-Source: AGHT+IG41KzlGhpkWHI86/yfKt+dY9ha4b9ql5LXo9JQXG1jbyYnUpn/M+Qt6Q5FogdDhwrNVGX+Bg==
X-Received: by 2002:a05:620a:44c6:b0:7c0:c2d7:5f2d with SMTP id af79cd13be357-7c0cef0e576mr1229924085a.28.1740337173910;
        Sun, 23 Feb 2025 10:59:33 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c09bf81253sm894052885a.47.2025.02.23.10.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 10:59:32 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Sun, 23 Feb 2025 18:58:09 +0000
Subject: [PATCH v3 06/12] media: atomisp: Remove vidioc_g/s callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250223-queryctrl-v3-6-4292911cab6b@chromium.org>
References: <20250223-queryctrl-v3-0-4292911cab6b@chromium.org>
In-Reply-To: <20250223-queryctrl-v3-0-4292911cab6b@chromium.org>
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

The v4l2 ioctl framework can implement vidioc_g/s_ctrl with
vidioc_g/s_ext_ctrl() and we provide those.

These are the last references of vidioc_s/g_ctrl in the codebase. We can
attempt to remove them now.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/staging/media/atomisp/pci/atomisp_ioctl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
index 6b84bd8e6cf3..1fb2ba819de3 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
@@ -1565,8 +1565,6 @@ const struct v4l2_ioctl_ops atomisp_ioctl_ops = {
 	.vidioc_g_input = atomisp_g_input,
 	.vidioc_s_input = atomisp_s_input,
 	.vidioc_query_ext_ctrl = atomisp_query_ext_ctrl,
-	.vidioc_s_ctrl = atomisp_s_ctrl,
-	.vidioc_g_ctrl = atomisp_g_ctrl,
 	.vidioc_s_ext_ctrls = atomisp_s_ext_ctrls,
 	.vidioc_g_ext_ctrls = atomisp_g_ext_ctrls,
 	.vidioc_enum_framesizes   = atomisp_enum_framesizes,

-- 
2.48.1.601.g30ceb7b040-goog


