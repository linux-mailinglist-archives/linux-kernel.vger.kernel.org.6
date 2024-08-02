Return-Path: <linux-kernel+bounces-272962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3829462D3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 20:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C8B71C20ECA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60ADB15C145;
	Fri,  2 Aug 2024 18:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWvaPVq0"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D71F1AE030;
	Fri,  2 Aug 2024 18:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722621778; cv=none; b=PNuL70wxyBO7PWxmvqDn3wzQLGu88brO6xML/XCPLOVxEV36jeBQJHggQOZuRD0wlPBYxqNxOWN4yG+khnPSlT3wTktkY0g/i3ud8ayvdlioH11dTXix4euCROouGzXzHO4UJoRnpxheDOVO0CDGyFFsOYYnZ7TQD+cRjlu/lV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722621778; c=relaxed/simple;
	bh=6hvbMe9SheGBFUFKV6yIecTRBlDtV2orfIV7/7UFeio=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fR9bzCIeH23aLVZHGRDMggZI887uxZ9MMyfk/YojvRlbaD2Q5I74oD7cefM+nd6pyP35L9CkGDdpHgyXn6C76Vk+VvlElE7UYXPESlZtkfH8AHoU7FTdcMc6Y7PAzgew6LdX9+c5tAERCbBiLXbg6OeyOZAJ5Dh9uzKBufBaj8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWvaPVq0; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fd78c165eeso73586005ad.2;
        Fri, 02 Aug 2024 11:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722621777; x=1723226577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TPYuykDQTpLV0QVmWDRVRbfOLAntW1izmGLDn5w1M+Y=;
        b=BWvaPVq0GXXra9+l1izn4cmzEgOMXPuUJHlNzmn/CpO4k6gIlmkEjmTMEJGKK6hU2Z
         IJfr1qQiGJk3EnTvgdGe2z8o1pqF/NUUTP8AgbVZwjWqs8rvX95WJRw3Wfjz9oVXd7lO
         B5kSI5pFWDPuzTiM0HtqwizPs8HmnaeSc7AMKpeHq00z3Iyshi5gQ4zBsfmPWZux9EAd
         ZdD2mzvWDME1EOYHHx92ny5XbSH83y/2Na9G/m1YkArlk2sptr0qHY5flOKqLoL4Gguj
         fOYvnLUM1FzlxDsaXTUhf+TsHVx8R7bu3KO6mG6Z0jV5/BMbQd9i8Y6302ORMRR7O6NF
         Ycsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722621777; x=1723226577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TPYuykDQTpLV0QVmWDRVRbfOLAntW1izmGLDn5w1M+Y=;
        b=W31Env6rmj60JzJdTxjJ5DhcWtKSR7/Eo9OEUTsvZlBkIIKVP9lJce2pPNKcwpBqDR
         8wpj7TMlRtamjSCAv3G9AZAGmwxbMEybSdekLJ6bMoHfZ0wGplgMEjQJbYYIeoLKGBl7
         w2g7OeA94gtCHJmYxEavAZXrG1kD7FqWc6eAzQ510ZMpsHAEnAu5NLtF2twdRuczb022
         wD0d99hjZur9sLv+ayKNgl+TLbtqtEMMgvRwHJURb2YssKk+suodUa4p3Vr3sWkKKgPB
         gBw/2hfcxO13N65gZIIvl+85qTBSDHpKTJAYacQqGTksVpkaQcyW/YfVP464dupnL8jB
         wXtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUTIrZr/VztmDrbqXBWDwis8yDczNF8UIk0uH2S+uX3wiVwAqpq1YUDgwzBlSLzQLDRV7Ry9MZfgYar419PiU7SKJ6EGDLn057ncZBDzdGQWBbzu6aUlarCHkFuM4Z+lCeZ1vAYP00
X-Gm-Message-State: AOJu0YwbZNxQkJeBmB96IDJzQ2yDSFcQTgVlXpR/4t3tFQAqiYqmv3so
	CbJVBXUAOSxBw4EHEZ/gl6NzIp0TeXIL2PJ7GYDeQ51MISmKpr3o
X-Google-Smtp-Source: AGHT+IEmbXzRbqA4Dm+Dxp5Q8sQ1FoKhxrnpwm3+tkLRLaaAjRfENRwciTj6Hpe7OoQfEyQiMj3I0g==
X-Received: by 2002:a17:903:1245:b0:1fb:3ce5:122d with SMTP id d9443c01a7336-1ff573bfe4amr59659145ad.41.1722621776519;
        Fri, 02 Aug 2024 11:02:56 -0700 (PDT)
Received: from embed-PC.. ([106.205.109.112])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff592979d7sm20082015ad.259.2024.08.02.11.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 11:02:56 -0700 (PDT)
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: laurent.pinchart@ideasonboard.com,
	dan.scally@ideasonboard.com
Cc: gregkh@linuxfoundation.org,
	skhan@linuxfoundation.org,
	dan.carpenter@linaro.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: uvc: Fix ERR_PTR dereference in uvc_v4l2.c
Date: Fri,  2 Aug 2024 23:32:47 +0530
Message-Id: <20240802180247.519273-1-abhishektamboli9@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix potential dereferencing of ERR_PTR() in find_format_by_pix()
and uvc_v4l2_enum_format().

Fix the following smatch errors:

drivers/usb/gadget/function/uvc_v4l2.c:124 find_format_by_pix()
error: 'fmtdesc' dereferencing possible ERR_PTR()
drivers/usb/gadget/function/uvc_v4l2.c:392 uvc_v4l2_enum_format()
error: 'fmtdesc' dereferencing possible ERR_PTR()

Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
---
 drivers/usb/gadget/function/uvc_v4l2.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
index a024aecb76dc..9dd602a742c4 100644
--- a/drivers/usb/gadget/function/uvc_v4l2.c
+++ b/drivers/usb/gadget/function/uvc_v4l2.c
@@ -121,6 +121,9 @@ static struct uvcg_format *find_format_by_pix(struct uvc_device *uvc,
 	list_for_each_entry(format, &uvc->header->formats, entry) {
 		const struct uvc_format_desc *fmtdesc = to_uvc_format(format->fmt);

+		if (IS_ERR(fmtdesc))
+			continue;
+
 		if (fmtdesc->fcc == pixelformat) {
 			uformat = format->fmt;
 			break;
@@ -389,6 +392,9 @@ uvc_v4l2_enum_format(struct file *file, void *fh, struct v4l2_fmtdesc *f)
 		return -EINVAL;

 	fmtdesc = to_uvc_format(uformat);
+	if (IS_ERR(fmtdesc))
+		return -EINVAL;
+
 	f->pixelformat = fmtdesc->fcc;

 	return 0;
--
2.34.1


