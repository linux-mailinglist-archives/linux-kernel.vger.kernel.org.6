Return-Path: <linux-kernel+bounces-438299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDD69E9F7F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 516BF1656A9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 19:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633D219D890;
	Mon,  9 Dec 2024 19:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yv7Vyq7p"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D07D19AD86
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 19:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733772344; cv=none; b=Q5ku/jXeskTBwzHwxeMhk8f5AwWeHNAITbHa4CXmeOMIY5r4mWTfUtJ+9MCCsiEVXeE8NZMFEic7uC9iZTx+SD+OT8/W4JU1qpFq4DeVomyh2GUMaOd3eRDud2pXoFCJn0ieQ1t4zmv0GGO3E8RhSnWrLvmrWMaKGkpYrvF31cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733772344; c=relaxed/simple;
	bh=qjgx+2RW+2qA3Kpo1t21oiWuDE038T0YMMKuiv+Fi0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BgZ5jRnx4/Wqdik5CpWwK6ze0tltfoZ7MHQBsZmmoiIw9FBnQ/f6oi4UCl8XMbrsrPgczZ9I+fU6Wut2MPFDgVgKFixkypUxuXLH5qlKw6bmdCqoLlMlWzaBB/8U3YgrtWhgSOJK7mnx3Svmvif39+apoMOUPFaBodIPZfuSqEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Yv7Vyq7p; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b6cade6e1fso156027785a.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 11:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733772340; x=1734377140; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bD/oB3rKRX6sl1z5Slf9ygtbR1yaEO5qPjqhHmqcVUs=;
        b=Yv7Vyq7pfI/rSU/66IqVKgaPy9znhSKlSLsEz3dmnOaCHgdhDvFdwQwv9QLe8U3RYg
         wch3e0i+OCftccYTws+9JMFKiVxEXs9KtO5wfDBN4FT5hE9hahFRhwP3NtvGv39DoXag
         6eqyGunRRyf/kdrOw52x+MOo0hlA/uVqrEaRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733772340; x=1734377140;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bD/oB3rKRX6sl1z5Slf9ygtbR1yaEO5qPjqhHmqcVUs=;
        b=CqPS7hrhZlYeQVoie43MO9NQoOZRofgSyZh2tZDsKe0foFxa1Oeg/5zFpdjyLeUGbo
         R60Uk26WEogDTe1XUWCY3baS+1o/32G+YmEamalZRrGd0uMhnKlUfG9+mm6JfwdJZ6Yy
         FCMDuYKKmgLcTI6X7oiIu2jvj8bdhwlyd6LGqwsM+GWbwVzAr+QyaseabIHokADkeGvp
         hQzTKbMFOiH+U8tAmfU1WGaTJcuRghaueQX2bNhE5s+TZh4Kjblf1Uw33vOoG1UR8j6D
         8ng1BZ5v8CReGkyvVDLcicIiC/1X1pkr9a1ZSnKEtgZX4s/l4f70crp2hOqXb0z2FK3i
         ZDYA==
X-Forwarded-Encrypted: i=1; AJvYcCVfemL6xNgo2wvWFWL4goDBvgQ5B0rWXJecUZxZJxWz4hD9OCyfTrpJzbRe38/hFwoc10u2LgCXx5nE/74=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCFnRXCjHbrslEkefbAbKsM1aN6gsYOMc4OHeTgrJnZqHtDMEw
	VwRwOvI49TmJn99cZdH8g8Zn17HMijxbyMk5F3G2vC0lUsLIpyNDS/mIz+gdfQ==
X-Gm-Gg: ASbGncuRJ1Ch7MP4RsVXx/DVxAwY0fKm3L99NcZbxuuoG9SRCFBvtm9sVCgfB0/dFOW
	gIbBQLid39nvh6R8tkRZn42VcEZfjt7SgT+BdX2jCDxBDPdLYnM/c3z1mznxsPpPA3jLd/o3xNs
	0XmF9UKl6DOqJJSP/XmT62x2NQAD8QKBGxiqxqQG4151RACENWNNkXrdY0E1H1Mt9skCwh8Sfgx
	cRo4h0uARk3dVleSuiSU8sq1PELOEAUm84uyCU1IQcwV6+UZQL9HdizWuo5WKGu/NcJgZwl4mzI
	3TXkksjypYRFdtTr6nHErFD0
X-Google-Smtp-Source: AGHT+IFFo3fcSdPum9b6G5uOLTbU7+t/CJfByumNs2Z5/XcG53j0L97A8+L9Fove8A9qec5bpHOBcA==
X-Received: by 2002:a05:620a:450b:b0:7b6:cf60:3971 with SMTP id af79cd13be357-7b6cf603aa3mr1080045685a.22.1733772340240;
        Mon, 09 Dec 2024 11:25:40 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6cc1cf6fesm217433385a.102.2024.12.09.11.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 11:25:39 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 09 Dec 2024 19:25:37 +0000
Subject: [PATCH 06/10] media: atomisp: Remove vidioc_g/s callback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-queryctrl-v1-6-deff7acfcdcb@chromium.org>
References: <20241209-queryctrl-v1-0-deff7acfcdcb@chromium.org>
In-Reply-To: <20241209-queryctrl-v1-0-deff7acfcdcb@chromium.org>
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
index d24420d8bd57..394b6f06246c 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_ioctl.c
@@ -1566,8 +1566,6 @@ const struct v4l2_ioctl_ops atomisp_ioctl_ops = {
 	.vidioc_g_input = atomisp_g_input,
 	.vidioc_s_input = atomisp_s_input,
 	.vidioc_query_ext_ctrl = atomisp_query_ext_ctrl,
-	.vidioc_s_ctrl = atomisp_s_ctrl,
-	.vidioc_g_ctrl = atomisp_g_ctrl,
 	.vidioc_s_ext_ctrls = atomisp_s_ext_ctrls,
 	.vidioc_g_ext_ctrls = atomisp_g_ext_ctrls,
 	.vidioc_enum_framesizes   = atomisp_enum_framesizes,

-- 
2.47.0.338.g60cca15819-goog


