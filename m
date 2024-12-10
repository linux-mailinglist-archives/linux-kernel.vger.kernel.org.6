Return-Path: <linux-kernel+bounces-439255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D57C49EACC2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4D5F28C3CB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D38215798;
	Tue, 10 Dec 2024 09:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="euKxpdUE"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9565E2153E9
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823780; cv=none; b=D6+EMbNQYudp8StcY8Y0OI9wyk0R3nT40414QpnB7+jXqJtIAPvxE9qgjOs7UImf9dJNNjJd0ZrmASv7V3Q5H9/Ao00Esifww4USLUgkBl08aSVV8XC/hVIS6wJ52SLUs1Ez6tqFaz9cNfNTVEUW64gdo3ZhtODpuPvzmsU4KYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823780; c=relaxed/simple;
	bh=7tx9tY1TZ7Mz0s7zOjD3n2wpSrIQUzX0lYUD2DrQrH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eeCxhWSjQoie5hDzEWAUMpOSsLhSZmTlsI+IChV4435rMDCZ0hLQ+rLtnDvm6c4uGFgvAS9gHLmyHXWB4l326fe3Jcjirrf1G6X/X55MBhF3YvHtDDdrPIR63HsvCAfdn1JgTAM8TRt7nqcvHByWypOV++w1y3GE6dKtLzzPDyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=euKxpdUE; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b6d23b1449so196607385a.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733823777; x=1734428577; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L0JByQfuAg+uD0hv4jRjMFUtllhDg1QrDpBOUHpuPvE=;
        b=euKxpdUEsJYHEKCJGkqnp1gCNHgT167YD9udhT/UygtsJyV1glI6qwyugzxU2y/GWI
         PHfG29ebCrVh3G4OCRM7Mgg2WEI/jip3dl/a/TMZ+n9CxAqBxbhs4hymXrggUpd5CtuC
         hCIrHihTL/1+yC7ms9c+CvkThFkodQ7jlBYu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733823777; x=1734428577;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L0JByQfuAg+uD0hv4jRjMFUtllhDg1QrDpBOUHpuPvE=;
        b=ZOMBsD/QDleBxcga5X2A8IRdsRHQcvi5pyPbWA9NL9RJ4K3bw3uYKpNGCtV+/82Cgp
         PWbxd04Nsd6/+2ZhxdjwgoChcOk8q0MipoPu9SOWn4jOSQW59oIVg6wIPr07YE7eeoJQ
         K2GKuA75Mw++BgMM1DP/HQ99h1SbX43kQvStlK2egYOIKBgtOuISLAkFNFIuyJ1ji+95
         wCpIE5aomHJ2WaLxDfzWxDj/Fyiru6co4JumHLMN5YysJWmoagDMnwLW82xFEIhUyW/1
         +WB/mnhkeP8E6154TT212ZgK+2ZZBUe9zfH3T5hhsNaM18m4XRAC9VAjRsCbKHhZV1fm
         SpIg==
X-Forwarded-Encrypted: i=1; AJvYcCUXPpBSqguKC1mgJ3T5QAAWWiUyEKD6D4PK83j/VXtkCVaQLeZulDP0GI3j4MZlWVc221/2D6tr5W4N/h4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxADeEWwPdZDoK18kpPXn4Re498s+g/dggl4kGmCxS8dEEBABs1
	kOn+/7MdbCljkP4JxfkExbfNX094BIUDZJSmemiHpSfTXpkMMSmSgpF8C7P0Dg==
X-Gm-Gg: ASbGncvDJn8ViKvvBQLyV+yWynKq96ihQs6Z/KWWGT8+emh8Ivo8ea1Kr76EFAmOo6z
	NZxDF7GVIweklAbcoMQoOlDaxbnRgr+dxk9O/C2485inJgyYCsYFkEHGk42JFeT1P5JzCU7WVFE
	Gioo/og22cDZ6VIsm1580QcRtHfygfiz0JkaXSt9NTKdj+g8E6qExGEosAg1ixXXEmjgmcv4XEX
	3rIOOsBl4G8woDhhZHFLv6LvHU7U002BxHHdL2vxwInITBjk6R/iiK6UKoM45jm/V5RAiBZo1MI
	56LNub5BI9QAhwx6jIZGE1T8bliw
X-Google-Smtp-Source: AGHT+IExR45IaZ1efaic3FpvsqoapdjA78ZUgUcbHZEtkDM1i3ZvkPfWr958oENOEkerIrjSg+Bv6g==
X-Received: by 2002:a05:620a:1922:b0:7b6:d910:5b1a with SMTP id af79cd13be357-7b6dce94fa9mr608857985a.42.1733823777521;
        Tue, 10 Dec 2024 01:42:57 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d92f7c2bc1sm773326d6.83.2024.12.10.01.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:42:56 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 09:42:44 +0000
Subject: [PATCH v16 08/18] media: uvcvideo: uvc_ioctl_(g|s)_ext_ctrls:
 handle NoP case
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-uvc-roi-v16-8-e8201f7e8e57@chromium.org>
References: <20241210-uvc-roi-v16-0-e8201f7e8e57@chromium.org>
In-Reply-To: <20241210-uvc-roi-v16-0-e8201f7e8e57@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Hans Verkuil <hverkuil@xs4all.nl>
Cc: Yunke Cao <yunkec@chromium.org>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>, 
 Yunke Cao <yunkec@google.com>
X-Mailer: b4 0.13.0

If nothing needs to be done. Exit early.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Tested-by: Yunke Cao <yunkec@google.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_v4l2.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 02fd5cbc3474..65dbb53b1e75 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -1081,6 +1081,9 @@ static int uvc_ioctl_g_ext_ctrls(struct file *file, void *fh,
 	u32 which;
 	int ret;
 
+	if (!ctrls->count)
+		return 0;
+
 	switch (ctrls->which) {
 	case V4L2_CTRL_WHICH_DEF_VAL:
 	case V4L2_CTRL_WHICH_CUR_VAL:
@@ -1121,6 +1124,9 @@ static int uvc_ioctl_s_try_ext_ctrls(struct uvc_fh *handle,
 	unsigned int i;
 	int ret;
 
+	if (!ctrls->count)
+		return 0;
+
 	ret = uvc_ctrl_check_access(chain, ctrls, ioctl);
 	if (ret < 0)
 		return ret;

-- 
2.47.0.338.g60cca15819-goog


