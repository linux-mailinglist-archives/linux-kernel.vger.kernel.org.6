Return-Path: <linux-kernel+bounces-438296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF179E9FAF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 20:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75F918818B2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 19:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69549199FC1;
	Mon,  9 Dec 2024 19:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iIu4JGBY"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2404219884C
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 19:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733772339; cv=none; b=RdImwGf6JsZ4gLx+8z/Yi5V9anvS1dcx1Hftd7RQfHApkzc28AQmsGZdGDGbPVw9pzyALOxthkSeETKOOJX9LFpoFKlO7jNGqci8Znh4b4edq+MJwP902gS4A00SZOWfB9eTqCUpcYcgmsoE+MkXazCAvouNqHaLvFDpYiPYXtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733772339; c=relaxed/simple;
	bh=QTPQ1DyM59FTFwoOCCInfTij+St4lWshfJMO2MNF9Jk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oBidjE4byME47WY7Tsv6hR7z77xPrEH4YgQaiTrQeBTtiV74TYhNsgHQD/CeLfDex+v56inFjZG8yu0Hf82KD37dL4b9PxcQ9E44SuXKCG6KTrLpAu0l+yOSvAE5sUF2U69JBYfpTJnnHsUU4j0u4mEEkulyO051zfHUCzaZlmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iIu4JGBY; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d89a727a19so51436476d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 11:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733772337; x=1734377137; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ldrzuJki4Bob493jggNorXy/00Sxo1CNpTeJmfaThng=;
        b=iIu4JGBYFJSNofCrIrysiSZl9FgvesfdhxENnmlefDM0UeeFchhFDA+My5CX+z4pPA
         8Zf9kWY7mboSXqHCRLZ2PIgXIPg+3yZoswhJg0+HvcNkQ69et2SO2G7mvcfZQFjQH0kz
         HVaJ7aWizBd2cQsYf5o627aVW51ZCCx5/WR9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733772337; x=1734377137;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldrzuJki4Bob493jggNorXy/00Sxo1CNpTeJmfaThng=;
        b=e77K/EYatIslbi1wZVn1bK9vNynZszy+L2FFcrC8gdr/4VFB6ttwtXaQOnU63apDvD
         4A64FT5pWjH0DyUyTWTCVizmJKwnYA1OdcrhQqU+MkUCprYNhaTlp6/LIiLbd0PNB+Nf
         c2d99eqf6oUBBR6WKvLuk1jYgiZ+Cd9ow68u+BkuRh6svqv3AF58AsInX6HFJwgtwwmg
         6BpvmHI84ijOKAPDsrA7fea/VbgqUp3jiCSNLhFO7Gh8XBLl2pomUI+PieyLZ8VDXMLH
         y+izt5HkJkR6uTIX2gqNICnRYzVpK+jErhZ9ZW50IFvMJarx/lp0o2zrxWgYT/ZtaE5L
         jR5g==
X-Forwarded-Encrypted: i=1; AJvYcCWAjU4NCYEWd7dqPnxq0iq/UQYog2X7jAbzoYsY2UclrtGLnmgCQWzzIHyFBerCT6CU1kND9FEnJcalEXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwShmrGeqnJ4iEfsFPXtMqNwiDGbBUTyLaDUi8iF97haRPcuSTu
	KvrTpp5XPLabr80Q1Zlzo+2QLLHWQNlsgZYMTqNWK2TlbD5C3ZIg+x14r65ckA==
X-Gm-Gg: ASbGncuFuBm3ma4DAjO7ETlcWRegcSuMgFekNqH6n5NR/zd2+vqZyroe0smUxmGgCpP
	bcgX5NRSl+VP1S0MQTMEFPmjI6oiTrFBVM/JRjCRIhNEVjqMs6Q46Yi8fS7AhlJiQCwka9dikBV
	r80Y/Md/HHwrF8ZJS42kOgnZCfp3hFNJ2wOH+JW++SbkGqPIS5XMGKo0sfv6YaJ/fSseNbOPda7
	ztivgsQpubl/ATSZyqgaRNAEvWdYXZfac7b8OvVjdovHtHU7Dz5KHGfQ/a6elqfx96U5z0vYoSv
	tqJAn9sj7voqd8sJcp/VeqLw
X-Google-Smtp-Source: AGHT+IFHW0/0qUHG8qwMzURyamcTUPmaaCxTzs+9Cce4VEgPbFPUYI69YdWNaUrMvMWP46LE5wus3A==
X-Received: by 2002:a05:6214:27c2:b0:6d9:1532:d8fc with SMTP id 6a1803df08f44-6d9212c7c65mr9382816d6.11.1733772337147;
        Mon, 09 Dec 2024 11:25:37 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6cc1cf6fesm217433385a.102.2024.12.09.11.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 11:25:36 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 09 Dec 2024 19:25:34 +0000
Subject: [PATCH 03/10] media: pvrusb2: Remove g/s_ctrl callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-queryctrl-v1-3-deff7acfcdcb@chromium.org>
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

The ioctl helpers can emulate g/s_ctrl with g/s_ext_ctrl. Simplify the
code.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/pvrusb2/pvrusb2-v4l2.c | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c b/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
index 7c8be6a0cf7c..ad38e1240541 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
@@ -574,31 +574,6 @@ static int pvr2_querymenu(struct file *file, void *priv, struct v4l2_querymenu *
 	return ret;
 }
 
-static int pvr2_g_ctrl(struct file *file, void *priv, struct v4l2_control *vc)
-{
-	struct pvr2_v4l2_fh *fh = file->private_data;
-	struct pvr2_hdw *hdw = fh->channel.mc_head->hdw;
-	int val = 0;
-	int ret;
-
-	ret = pvr2_ctrl_get_value(pvr2_hdw_get_ctrl_v4l(hdw, vc->id),
-			&val);
-	vc->value = val;
-	return ret;
-}
-
-static int pvr2_s_ctrl(struct file *file, void *priv, struct v4l2_control *vc)
-{
-	struct pvr2_v4l2_fh *fh = file->private_data;
-	struct pvr2_hdw *hdw = fh->channel.mc_head->hdw;
-	int ret;
-
-	ret = pvr2_ctrl_set_value(pvr2_hdw_get_ctrl_v4l(hdw, vc->id),
-			vc->value);
-	pvr2_hdw_commit_ctl(hdw);
-	return ret;
-}
-
 static int pvr2_g_ext_ctrls(struct file *file, void *priv,
 					struct v4l2_ext_controls *ctls)
 {
@@ -817,8 +792,6 @@ static const struct v4l2_ioctl_ops pvr2_ioctl_ops = {
 	.vidioc_streamoff		    = pvr2_streamoff,
 	.vidioc_query_ext_ctrl		    = pvr2_query_ext_ctrl,
 	.vidioc_querymenu		    = pvr2_querymenu,
-	.vidioc_g_ctrl			    = pvr2_g_ctrl,
-	.vidioc_s_ctrl			    = pvr2_s_ctrl,
 	.vidioc_g_ext_ctrls		    = pvr2_g_ext_ctrls,
 	.vidioc_s_ext_ctrls		    = pvr2_s_ext_ctrls,
 	.vidioc_try_ext_ctrls		    = pvr2_try_ext_ctrls,

-- 
2.47.0.338.g60cca15819-goog


