Return-Path: <linux-kernel+bounces-439263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 777D99EACDA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA5521882F55
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C6B237A2B;
	Tue, 10 Dec 2024 09:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V0JLBHHk"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259633DAC19
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823787; cv=none; b=Hm1nZIZg/RPYWHPIXVar09SlS9xSXyscj0LstyDzGt+AmmP46j7x85mhTpgHEgfN74UzRodprUJ70Of1yVWWMrMPUpZuoyM9o7x5ggBDur17glaIpN+I/OMAd8rzWi6JN0JZ2cvjyyadDGFlzPMguOKk+H9xyFpYFAeWGlR8b3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823787; c=relaxed/simple;
	bh=HCkd9QY2OfGozb/+L9hVVayAr5QQOjRc9Dn84hpf1DE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tk3gdItJ3WOF2P+vCm+XLlXb8sM33VxgUdaDwFu40/jnlFigCDlDM9sJ6Jm1nEqWJDZTtSB0o/tTI/tvGLtwCx2dD196/EAPJPYSo6qZaumXDZ2DVVWhfWhggBE8sIrhaoJnZXs9axY4fg9ZlcTfMPdFzRQlizK3E9yRqYtoP0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V0JLBHHk; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6d87fffeb13so44134146d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733823785; x=1734428585; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OHxayE4k42tgzCvBKbSWRnUHa8HIxT/un4VmPqqRwYk=;
        b=V0JLBHHkfNETy6LIQWkMe3tRi7jKLYn3A4HMix+MibqqGpssvFUe0c7Lupo9Y+OgtT
         VoHI0jgCZhPqSrLKDPV9Iotwwt+Uyr457T/S7lYLKITVHhbzo2KQ1qTh9AkuDPoIIybp
         ERrGdyBF3kyFW1F6ZZ7bR1hApBmgJg+9R9PCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733823785; x=1734428585;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OHxayE4k42tgzCvBKbSWRnUHa8HIxT/un4VmPqqRwYk=;
        b=E4fc3ovM8okgL44TNjJ3Ncumx1fBKA3LkTNZbF5AFoO8R4a+P9IOy4QGHKaUgLAW2p
         enEJ6TCrP2CWX+E4Kxfq4WJTY4OOa2BTXA66vV+gP0uJOorahk97JJ3ntxiQd4aBCuI8
         IW4P0zbhmIeU4IOz2oVSDwpYMVefydoek6FWXkrZcF/dDxFlcmpQ3ys+zEnG+jShzK3e
         MqSwcRlEVDEqRi9PJx+lWjSBvGb64Uuc0o1LxMb90HqVqXPp7ImVPOoZM574BSMW3mM1
         NR0+jDeljZxfgopoKyBnVvje52Q7JKR4hTRK4X5QFJUZg8fyYKl/oM+RzjUdiNQDJ/iq
         +3WA==
X-Forwarded-Encrypted: i=1; AJvYcCUK47fqcLSUMxKwVnX/nL3daEDUdcG9G35Uf9Al1HAopuKkSDlwmxkiZxlohw/ZuYwpvcuiRB02cp0+fkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxElgu3XXO9Uan1uQLEAwy0WeBNkPTWHg3hrIywdGcVKVgmgR3U
	1C3pu9orW+rOsJgRdvsaFPc71q0L8qVg4fSdpJgeood6AZss4CNeluFS+znClw==
X-Gm-Gg: ASbGnctJpHMMyAiW0fJvTLOe3OB3LaOjAubmkLAhsbFsMHsqYNCVtKBuDV5zCTNofy1
	RgmzFESmiusdHdsqkzbbWdx5GckMAVkVD20hWj0n6a7Q/jIb8Efwmvey4B78BTwde0bcTM2/wdH
	HkBgO3+vHXQKxzWdbqOZySc/ihnt5b96/eJYGc1iotK8Vk9IQ30Q90OahONVtpWksfvIPfg511p
	3BpbWsMP/saDQ8tLtM4u7aTd57nQLDYf/nmz9NolXI17KAlVrSrrOZgld2owx2Ev0BFUhbjgi3U
	aHj3a+sockavVU6MzKxuKgIbtZMc
X-Google-Smtp-Source: AGHT+IEdReo0MRnNlTyTmOkuTUdcKCx+CoS8N4Bbe9AR14bTkRgBndNrGwfcStRIkm86B2Q5mtIIRQ==
X-Received: by 2002:a05:6214:f62:b0:6d8:a148:9ac9 with SMTP id 6a1803df08f44-6d8e73be7c3mr272587766d6.30.1733823785070;
        Tue, 10 Dec 2024 01:43:05 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d92f7c2bc1sm773326d6.83.2024.12.10.01.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:43:04 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 10 Dec 2024 09:42:52 +0000
Subject: [PATCH v16 16/18] media: uvcvideo: Add sanity check to
 uvc_ioctl_xu_ctrl_map
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-uvc-roi-v16-16-e8201f7e8e57@chromium.org>
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

Do not process unknown data types.

Tested-by: Yunke Cao <yunkec@google.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_v4l2.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
index 5000c74271e0..0d9d056f1bbe 100644
--- a/drivers/media/usb/uvc/uvc_v4l2.c
+++ b/drivers/media/usb/uvc/uvc_v4l2.c
@@ -106,6 +106,12 @@ static int uvc_ioctl_xu_ctrl_map(struct uvc_video_chain *chain,
 	struct uvc_control_mapping *map;
 	int ret;
 
+	if (xmap->data_type > UVC_CTRL_DATA_TYPE_BITMASK) {
+		uvc_dbg(chain->dev, CONTROL,
+			"Unsupported UVC data type %u\n", xmap->data_type);
+		return -EINVAL;
+	}
+
 	map = kzalloc(sizeof(*map), GFP_KERNEL);
 	if (map == NULL)
 		return -ENOMEM;

-- 
2.47.0.338.g60cca15819-goog


