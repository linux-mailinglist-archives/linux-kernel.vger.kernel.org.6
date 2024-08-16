Return-Path: <linux-kernel+bounces-289650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C419548C5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 226151C23F2C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BE31BB698;
	Fri, 16 Aug 2024 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dpF4LyFB"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DA51B3F05
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 12:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723811437; cv=none; b=qUTygoxJbdHrFryKtj248IpulW2Lds+nbAcaA4sY/tRiRq7DUbIcF22OcNiBpELO6k29lnRPg28xoYbmbZAWDY6mBIE/QAYo0pAZoH7eGxeT4U+Ew15YtSVj8dh0B1Vl+6c2JxDE9hFlqk2V+FHB1lhcRwmDmuIWjgfz58f1u+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723811437; c=relaxed/simple;
	bh=AN2zkbqD250EjGBEmwuzJlE8f9nO0nY/af0JFueOjQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tm3KN9HHd31p5DNrGxvFU0goubxXtaTlAfVlENa6O/e2zOC730kgLt5FH0tTbZ1ce+0GtOR2IoX/f5OwuEfBU9E+UWf7oED0S8aCjFR1U6oRPPveZRCZfkTMRb1vo4sTN/zQUk85Gt0gnczv+kiknonqpM9P+ynapMsvYcl0EVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dpF4LyFB; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-44fded90c41so9413301cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 05:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723811433; x=1724416233; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s0nrBOsUAqUgapKq+R34S7oSUAMCsQPiLYdOB0fBvGY=;
        b=dpF4LyFByvsA4sBvf6xOcUq9BpW5B7BT3TTHaXWX2SQNvq3vU45R5VLRinRWtt03CI
         Hizt6+FWPAPpVgxCgWSpEeBJKLzBBarSKmT32AQXKXAsisfDl4nkHoB5HBnHgunoUa56
         NNcK3h3/9IJU2gruXljdIieKAS3+BN2Ox3gDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723811433; x=1724416233;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s0nrBOsUAqUgapKq+R34S7oSUAMCsQPiLYdOB0fBvGY=;
        b=Zx8ImHMQ88IQeFihBBYT9e3NCdVi21TNj9nkyXl1/6A2FrsqPOm12l4zVQEVmez8mP
         HEeEhzxe2jLOY0h8+07zQ8uPB+CAsMVy946ZvFFuKwh9eoMfanRVEpBRvmS3TSsmBQRh
         eo0izLTLOaX4jHKVWyouZ7DmMDorg76rxbgkZoELmbEL9Vs7ZyqHX3KP0SO4dYgHCp81
         NeiCLI44RIehQXi8xcbPrK6sV4h4AJdc6WwQ2uzQ+IS/V6fLsRYAhW/iiWxEfF6qHm0s
         7LvPZCs2WD9bzdqY4WBM33LFJS00Wrwre7PCyQjwTDUu3psmXWE2XcJzEMMl0GIz0QoI
         BACA==
X-Forwarded-Encrypted: i=1; AJvYcCVOwvQnRu+F2azvgHgWlX5YyZ/T00IyJ/Rqw0Aa2khzLLoclPfdsSoGoNf6YFd2LRf6RF5XoqhfzCWwNsei8qHPdxxtDld5rtMkS72L
X-Gm-Message-State: AOJu0Yw/VsyLRAQf6irmUZvUhWmpMT1hKehaHNKWEFFmFFgUQAKtmyWL
	4P/0c8SuBm/scLLFI2P4KWDZFEGKFD84mbByfQftWXxGF5K6bX/3vJfHxMAcWQ==
X-Google-Smtp-Source: AGHT+IGQPFo/pK6ONr5jhdyaMMEVlTHiYM6Dy3SXIYXya/U1WD7/VoBzANNiaowrEjln8pWihHYKBg==
X-Received: by 2002:a05:622a:1c19:b0:44f:feef:efe1 with SMTP id d75a77b69052e-453743a947fmr24457181cf.54.1723811433219;
        Fri, 16 Aug 2024 05:30:33 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369fd9e39sm15853051cf.2.2024.08.16.05.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 05:30:32 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 16 Aug 2024 12:30:31 +0000
Subject: [PATCH v3 3/3] media: drivers/media/dvb-core: CodoStyle for
 dvb_frontend_open()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-coccinelle-followup-v3-3-79fbc2742fa8@chromium.org>
References: <20240816-coccinelle-followup-v3-0-79fbc2742fa8@chromium.org>
In-Reply-To: <20240816-coccinelle-followup-v3-0-79fbc2742fa8@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

We can rearrange a bit the function to reduce the indentation levels.

No functional change added to this patch.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/dvb-core/dvb_frontend.c | 49 ++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 27 deletions(-)

diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
index 16d21ec6ff35..f714fc432dea 100644
--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -2875,7 +2875,6 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
 	struct dvb_device *dvbdev = file->private_data;
 	struct dvb_frontend *fe = dvbdev->priv;
 	struct dvb_adapter *adapter = fe->dvb;
-	int ret;
 
 	dev_dbg(fe->dvb->device, "%s:\n", __func__);
 	if (fe->exit == DVB_FE_DEVICE_REMOVED)
@@ -2893,36 +2892,32 @@ static int dvb_frontend_open(struct inode *inode, struct file *file)
 				return -EBUSY;
 			adapter->mfe_dvbdev = dvbdev;
 		}
-	} else {
-		if (!adapter->mfe_dvbdev) {
+		return __dvb_frontend_open(inode, file);
+	}
+
+	if (!adapter->mfe_dvbdev) {
+		adapter->mfe_dvbdev = dvbdev;
+	} else if (adapter->mfe_dvbdev != dvbdev) {
+		struct dvb_device *mfedev = adapter->mfe_dvbdev;
+		struct dvb_frontend *mfe = mfedev->priv;
+		struct dvb_frontend_private *mfepriv = mfe->frontend_priv;
+		int ret;
+
+		ret = wait_dvb_frontend(adapter, mfedev);
+		if (ret)
+			return ret;
+
+		if (adapter->mfe_dvbdev != dvbdev) {
+			mfedev = adapter->mfe_dvbdev;
+			mfe = mfedev->priv;
+			mfepriv = mfe->frontend_priv;
+			if (mfedev->users != -1 || mfepriv->thread)
+				return -EBUSY;
 			adapter->mfe_dvbdev = dvbdev;
-		} else if (adapter->mfe_dvbdev != dvbdev) {
-			struct dvb_device
-				*mfedev = adapter->mfe_dvbdev;
-			struct dvb_frontend
-				*mfe = mfedev->priv;
-			struct dvb_frontend_private
-				*mfepriv = mfe->frontend_priv;
-
-			ret = wait_dvb_frontend(adapter, mfedev);
-			if (ret)
-				return ret;
-
-			if (adapter->mfe_dvbdev != dvbdev) {
-				mfedev = adapter->mfe_dvbdev;
-				mfe = mfedev->priv;
-				mfepriv = mfe->frontend_priv;
-				if (mfedev->users != -1 ||
-				    mfepriv->thread)
-					return -EBUSY;
-				adapter->mfe_dvbdev = dvbdev;
-			}
 		}
 	}
 
-	ret = __dvb_frontend_open(inode, file);
-
-	return ret;
+	return __dvb_frontend_open(inode, file);
 }
 
 static int dvb_frontend_release(struct inode *inode, struct file *file)

-- 
2.46.0.184.g6999bdac58-goog


