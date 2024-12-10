Return-Path: <linux-kernel+bounces-439189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE12D9EAC09
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A6ED16524C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBA123873C;
	Tue, 10 Dec 2024 09:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oFjv7dbs"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F85F3DAC1E
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822936; cv=none; b=RoIaSG2GnFmQtIY0fpTwEy1Ewk93F2KzdwkwwttMXYGa4AbKXSaS3bUTI/zWkVstuhpbc6iw5KuLXR6VNZdtG1KkvjLsWuH0s+UdSvOckKKJ8a3uvVMeFJqBtnv5leJkrf2m3ICu4u7Y4pbgsMTVEc2uitFcCUyoRbJ/trLJ7cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822936; c=relaxed/simple;
	bh=QTPQ1DyM59FTFwoOCCInfTij+St4lWshfJMO2MNF9Jk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IWEis0O7JgPLJh18j8VYteeHjTZOAmRbx4sAfCgvV+fLMkyiDpdQwOJWQjG463CuczwukM8iWc2ti4mLlSDOQm6Cf+FHbdSNSmZwf46N49IcBhVwOdWhutnRAWWAueb+jsGd2g7FtZ8AWcBvG4MThd7knpppBA+W2uES2MQNkoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oFjv7dbs; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-467777d7c83so4322711cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733822934; x=1734427734; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ldrzuJki4Bob493jggNorXy/00Sxo1CNpTeJmfaThng=;
        b=oFjv7dbs4fTghKaTgXmydmb0q2pp6SL3AQf5k0vgT4+t9iFQxKwg3BNZ1yZn/SPTsR
         Rhjj+aY69aiclQQEFg8pqNYc1L+yyPB65sq8b4ABJ9LDjjsMgxhxUudgaSUdJWpSSzRM
         wktubWoFYBaOMz5fMgo1+xtSLTMUS6WZaYKLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733822934; x=1734427734;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ldrzuJki4Bob493jggNorXy/00Sxo1CNpTeJmfaThng=;
        b=UlbgKRnEOYUssVo40VhRnrkZKWrstV+Fuxlo6FtObc5CvummEbV/7Z1aIFmiwBfPCx
         dbRkfhD+1Hg1iUfC/mi7EDx4ETYV0uUxepAy5nVq4CcgBlhuzg5c95t1v/sEO0jIphHJ
         o/At6gcA51iGBO+g/zIkURbO4F64TmHlWK7g3kjFQ37UbUTANFXWs2XYz/MfNcRMrEgZ
         HkqjhC+/NLlX/LKJPa6nVGxj++FgIjEW9mPixqGyWKChWZqj3Y4L7gsUn2iRvsv90iir
         ZA5iptdipH0kPF1/Af3xSbtbQ8cRLAjC+t2WB0iE+rlQe5Wy9aeYJKoob0jhN2Ysjgka
         5BsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxl7y/1GnO44zQCt3Cf7unUauQOT/1MYhOE12+ncxj70uPY2lu8qQXOAyydT3aLtjgEEBYIC1GyL9Ho3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYoC+7OBOupPH7xCIoiPx7QcP2679/MnKAz3rqJUoGwxHLY0cb
	yuPq5NrUywKD0DkrUKoHhAEkt1z6kaGBdKvuuJXv1fltoR+ZNglF2QP3aGpcBA==
X-Gm-Gg: ASbGncvJ3D1xcSLbVrJEGNTfwzRRueVJF8c+8TCoYe+jYwtaE0HTWhqxp+wsm3TCdt3
	/bJmsDAz+7dfDKHfnzveBge7m6gL5Y16gmJuxesWQX6jgxSgH9AL7Y56+z/hhIExltBJqcqZbw0
	CPl70Ltm1fzN2+TpR8sJyjPYK0632QXyVdSUGBJkMPteA4R1fo3ZSgnQHyxyJSbUSCMae75vH9n
	C+/U3cp+TFSzeZmrfFT10ExtTPFODPBcVopHTD3qO+V5Hw2xx7tYEHcSdskfIvv5XdxViIhAQAq
	ahjUBFqC3BVjqfMcA0wkPG50sM5T
X-Google-Smtp-Source: AGHT+IGAAxP3Bb8dp8EUNxps8UjQFg2XrkM8eTt6qptwkb9cgt4CUX5Y2k7W1aHCNPf6K0Nheydqdg==
X-Received: by 2002:a05:622a:118d:b0:467:6092:8414 with SMTP id d75a77b69052e-4676092879amr124695261cf.0.1733822934276;
        Tue, 10 Dec 2024 01:28:54 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4675dd86ce4sm24343241cf.30.2024.12.10.01.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:28:53 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 09:28:47 +0000
Subject: [PATCH v2 03/11] media: pvrusb2: Remove g/s_ctrl callbacks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-queryctrl-v2-3-c0a33d69f416@chromium.org>
References: <20241210-queryctrl-v2-0-c0a33d69f416@chromium.org>
In-Reply-To: <20241210-queryctrl-v2-0-c0a33d69f416@chromium.org>
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


