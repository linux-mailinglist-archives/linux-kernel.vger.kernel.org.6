Return-Path: <linux-kernel+bounces-425956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 990BF9DECF2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 22:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B225B22065
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 21:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794B41AA1C5;
	Fri, 29 Nov 2024 21:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e/8AYeGv"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D2B1A9B2A
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 21:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732915835; cv=none; b=lEF3VMWdFx3dRc/8QtPr18wCTjz4Oq577S2Q2E6HCEThJUc8HhgGm2pI4VlOZL6zLHOvX1ENYxIno3qn3DN6QIRW5gphEMvprKRBN64G56Oydu3euyhVEbmbugOHtnTJMdDWW9dhzQrTEQEW90PZpAJmP9di1IQO8h/BHooFq7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732915835; c=relaxed/simple;
	bh=hem3w0cqOpuUXnWOHaCYg59eIwff39vWTS7lxdWqD60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PHNulWHpd07dVjZn2P8upp0k7GO01n4TV2grFnMwvs/T7h4kBFghBmEtZiOtm0b2nHpQETcFn+amUxj4SwGnEL7p8FEMaEb2Vf7J/TDRwt9ZU22Llij/eNuH+qPLGjawRG1mvIY3hZ+18mlo2fDpmer2CzSZ9eex106+7qsYUQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=e/8AYeGv; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-514fab8ac5aso494939e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 13:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732915833; x=1733520633; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W2rn5S7/m2AnqfUGp/AXrxEjHYa6ExomvekQA1z9JF8=;
        b=e/8AYeGvFl0mTTpkqIdVoIQlg7ntOEz9BgkVB+GNsqQQnOiS1b0UddHAUVy32Gb/3k
         Cxo7l7cHzHcv6+bm0aOE559bbAd5Xew5Rupki6+dM/QHnxU2kRBFLWpPLxBM6fuDjCnk
         j+3rkyfyyvR4GUpL/fXb5fFXq0bqsjzGO4RcU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732915833; x=1733520633;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2rn5S7/m2AnqfUGp/AXrxEjHYa6ExomvekQA1z9JF8=;
        b=HOIWrrl6fVer6dSlrS9WrwBur18VxonuTcpOwWfiDOYgn2kGMfSK07nuvUNZU+jVSF
         P8q/gQq+vDrUwov5LtInxbGlHhVxvstiGq46fTsFGAEXBWMpV0nOjOGdEOR9jxdlB/9/
         Ge2XiEEisr/DCzhjHBJthF8Yu7GsdILyHhpgQvbsRGU3Z1zbDf/hixH1AUZFg5rla2a3
         LY5fcwae/klQvDLqgTYZfUDfgeXFJ96KpplIGNLN1eopTSVRFHuIEG7HfykRpJrGpdMT
         TQu4XuNHam3xtITdTAsUam1ck2J1XdjbpgOqcDpxaIeQ/YsaQDJ3De4ivVfPSo56bbCH
         YUgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbIRdqpdUfq75rvZP8e3LNOzP7YYI/zFRQXk7vq4a4BablvIbHzL/8dILlUypffokcg82zmp/hP29nG9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YweuXdVI9fmCbn9QkvtZ+JBh8Ha/cGYUMq78tE3kk8hCmgRU9R8
	hs0VNTEgPQVOrK2kUVCkTk38AFWEamVIB/DrvvlMCN/xeSuJh8AojuNEfdM6tQ==
X-Gm-Gg: ASbGncvhVEZTNNHoMvUqKwGAW8CUaNp/FeXF+k4cVZHYb493Up7OMDGYT9/ad6APglM
	wFe0+MaUD2+Nv2rJvDOcNmEd7XmR/tL5RwnK+MNeeX2dtwQNRTbCNWsL1SL46D5HvBr+9BL9e9H
	2bWvV6qA13hvb2Ai/vgGPt8P0iEDDhKHUAV79U5wIxw3aXQpr9yxMru+cTUVKglB5K/N1jngvWj
	xghPKD5KdBFk9lLomQPeK/xs5XZXfdpiC3XFnB2ivSVNy0iOocDn77W8S9NAUDTuv24o7Ptvx8u
	yGP1wUVpB9zAZfNy8Sj2tsu8
X-Google-Smtp-Source: AGHT+IEcGD+/QiSnHqDspBxFeqf8V4eyWtSEYu06OHOVvuFJxL4mfm7VoAcu1T8tpb9Ahblgt2JqVw==
X-Received: by 2002:a05:6122:6089:b0:515:4b68:c37f with SMTP id 71dfb90a1353d-51556926b00mr18430743e0c.6.1732915833363;
        Fri, 29 Nov 2024 13:30:33 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5156d0c1b7asm607254e0c.36.2024.11.29.13.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 13:30:31 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 29 Nov 2024 21:30:17 +0000
Subject: [PATCH v4 3/4] media: uvcvideo: Annotate lock requirements for
 uvc_ctrl_set
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241129-uvc-fix-async-v4-3-f23784dba80f@chromium.org>
References: <20241129-uvc-fix-async-v4-0-f23784dba80f@chromium.org>
In-Reply-To: <20241129-uvc-fix-async-v4-0-f23784dba80f@chromium.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: Hans Verkuil <hverkuil@xs4all.nl>, 
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, 
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Make it explicit that the function is always called with ctrl_mutex
being held.

Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index bc96fb475b9c..e02540162dd4 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1968,6 +1968,8 @@ int uvc_ctrl_set(struct uvc_fh *handle,
 	s32 max;
 	int ret;
 
+	lockdep_assert_held(&chain->ctrl_mutex);
+
 	if (__uvc_query_v4l2_class(chain, xctrl->id, 0) >= 0)
 		return -EACCES;
 

-- 
2.47.0.338.g60cca15819-goog


