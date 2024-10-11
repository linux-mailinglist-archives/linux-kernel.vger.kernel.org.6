Return-Path: <linux-kernel+bounces-361715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A27DC99AC09
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 20:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43A23286C6B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 18:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5F01E9076;
	Fri, 11 Oct 2024 18:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="blS+uvA/"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D221D0DD4
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 18:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672890; cv=none; b=NKaX19ZCVB9XbUKowWfX3Guppj+0F0/FRux8oxBk7nL6aFJz2nGPfKoiLbDXf4RERJguN9OFDqFSy3UCKzeJiiQVCOcnZ1gcdzxe0h+H+GbJYT+pZbkFb/pqqqqAFRxMY5f22SJOvHZWTLnyosBIKekOH3ZTV4q3/FU3vnoMaDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672890; c=relaxed/simple;
	bh=Wza/iRdX5cN5BMLvK7O/031QpQHLKfgshw5BLS3vTXg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fXBSgv5QRuwD+xkAzz1r8jt/j3HD7Ar8SC0LMADU6RIdA0JLr8y4nEvo8jqaJH5OZS38lhh1Zdcf7kTScfz9o48fGFYhMUzUc/gCTzGs3hBQdQV+RCHBzmYjW1NysOfO/MANk0DQiAcm03ZqIdVh3CJhT5+qaPA6SOzUgyA47IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=blS+uvA/; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d4ba20075so1358808f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 11:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728672880; x=1729277680; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=my2XmLLe0oLXzshDoZwtb3c1+4lIWQN1dJeP5uAMxsA=;
        b=blS+uvA/o+/xPY7D7iWYDrtLb4MNqX7PHRvOUyx3fRvt23jAr0Wy8HjqawsSj+aZxR
         gv0CU7OvPrDCCrwLzUKTHLoGHyIG8I83n3WEZk09rWmwMdfeV60SD5LpNXhIwhuIBVe+
         QJYlMAbTzosfMoUwCThdA8t0MpJPkZdfqJKaog5K/BExaPxuKmhlsZV5VbqAQpa0AhiB
         rghf98e79+SE9cfp9Oqdava6TcUzZxEVyOmGr9aklCMMmkWn5Do8OvfXNtiVk1ok9Yca
         gnw6cSM4ugulb2GiNBtc863G5WwpMseJ5xVtUjyDJRozRGZ47JaHekB1/+p+XABSk4LM
         dBuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672880; x=1729277680;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=my2XmLLe0oLXzshDoZwtb3c1+4lIWQN1dJeP5uAMxsA=;
        b=UYMbHYTlMiBMq1tsh+jUOEG+xvzAQAJ1qkcHU6QBCyUCFAeeiC4gkAq0DwiRYliga5
         Suk4Gz+P6bHGONJ5KvrsCfHmT3C40EJlwX/5liZKgAEkcPcc7A3nEuDbhvI//VgeDCAt
         ZjuFIw5op5P7sSa+C4N2+T7sd1bHKkgyufJUSs1UsQc7zd0hqiwRQcqKR9bhNSc+L9k2
         nXStfJdynKbg1oYM5dTeGvXhVD8sl4Vf4KZR7sZd0QcLcaicY0mhMNsyZEvFyGy//984
         BKTq7yeuQuCVNA4jpcuHNJvCvu3Bcr5Wnn9S2gq6pxvKJIJrD7SyCidWfGbJ/2DGxKlx
         tByw==
X-Forwarded-Encrypted: i=1; AJvYcCUMxly+fgATtfiwIHB6Ahmhq3pduXJwX8Q7rvCwLw4N4fQxKYmKFD8nolNVyw9j/BJjMY7pb75D1Yzi/00=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv3el2jF2EmDX7Sq5Uhh0CLuRfdmx4P6hDdhiZDdrPwlpn7DKM
	HaB4wklgYanzEev1Bk4FYDxBhh9suZ2nw7grizI4j/qCp9/AySJ4u6uBOdHdc1E=
X-Google-Smtp-Source: AGHT+IGbn3dzWq62qhjEiOBha1cczQY5CApcqt9d8LPapIwRdeLC8r4MCRAqlB5oVEKWtD3LqRgX4g==
X-Received: by 2002:a5d:6687:0:b0:374:b3a3:3f83 with SMTP id ffacd0b85a97d-37d552cb66cmr3261399f8f.53.1728672879751;
        Fri, 11 Oct 2024 11:54:39 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:68b8:bef:b7eb:538f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b79fe7csm4559161f8f.70.2024.10.11.11.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:54:39 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 11 Oct 2024 20:54:07 +0200
Subject: [PATCH v7 08/17] firmware: qcom: scm: add a call for checking
 wrapped key support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-wrapped-keys-v7-8-e3f7a752059b@linaro.org>
References: <20241011-wrapped-keys-v7-0-e3f7a752059b@linaro.org>
In-Reply-To: <20241011-wrapped-keys-v7-0-e3f7a752059b@linaro.org>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, 
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
 Mikulas Patocka <mpatocka@redhat.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Asutosh Das <quic_asutoshd@quicinc.com>, 
 Ritesh Harjani <ritesh.list@gmail.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Eric Biggers <ebiggers@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
 Jaegeuk Kim <jaegeuk@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Gaurav Kashyap <quic_gaurkash@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-block@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, 
 linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1813;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=IKhAxIosGYUyrB4jLR8PpwNLJS99HlSOS/sX8Ks7vvc=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnCXReUZwO3XEhsZr47jY8a7DDI3iXaG3Rq7CgP
 QgcHMzguU2JAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZwl0XgAKCRARpy6gFHHX
 cg0DD/9dQRMs1HXKw5jYs78wz/2NsZwB2GzXCvcG0TnicxRB+ccJx5OKc/vw1zFxt0LmyVZO/QR
 YZgMIBGtaqmSkGBcNAG6rdTBJxq7HHFvIfp12iVceX//x8JZQJW2/T7DhK3zHIWUPNSvEswpE7D
 FMiWmQnSo5vnOVHgiyPFxuN5a6AqSsbFxvj3GVUD0eAFkXLtIRD8W3GNNnVk3X46xCVvylU5OvP
 tPo9BAQ1TqhSLUfLk2Mp2QOjsvjNlKFV4p07QlvU4orJ+7DlW1KlhmYXBrdjTymFRjRPGmnMat+
 JMMqhxxmH4X2M5/DtQJ7iE/fXKpnpyGeBV0Yiu6mTvlhTk1Naf2E2l4LdJaHzmqBvwjcR8Z1X+O
 KdYZ8NHUHgi0u/4S1/uqAZ5HIZEqscnw+bTKk0BzAxI51oGCZi1K89QAuzK37MTZWiKIRjSynQ+
 X0LSGITk00Nb89EdQbKZT7bTe/oWU4FiT2wRaLbM91iY5xkchJNBJLbEArAdMK0knpYUtbKjngw
 Z9syaFpoz8BXpVfvXoXXacnNv74N9uthQ4aQhRm+2XkTojpNuSxdTu5OlS/Uzz17l3YAmJ30rpa
 wBrqtlTUp191o3unS+q1hgFesrQhxGLNPz+foTZz7P2XrCpiQn5UOwwSLJe2YvbFe1wqWuxQIWP
 JLXlY21s0tzpeqw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add a helper that allows users to check if wrapped key support is
available on the platform by checking if the SCM call allowing to
derive the software secret from a wrapped key is enabled.

Reviewed-by: Konrad Dybcio <konradybcio@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/firmware/qcom/qcom_scm.c       | 7 +++++++
 include/linux/firmware/qcom/qcom_scm.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 3a59fd2a45b5..f1f723b53e8f 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -1252,6 +1252,13 @@ int qcom_scm_ice_set_key(u32 index, const u8 *key, u32 key_size,
 }
 EXPORT_SYMBOL_GPL(qcom_scm_ice_set_key);
 
+bool qcom_scm_has_wrapped_key_support(void)
+{
+	return __qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_ES,
+					    QCOM_SCM_ES_DERIVE_SW_SECRET);
+}
+EXPORT_SYMBOL_GPL(qcom_scm_has_wrapped_key_support);
+
 /**
  * qcom_scm_derive_sw_secret() - Derive software secret from wrapped key
  * @wkey: the hardware wrapped key inaccessible to software
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index b5ab39b35490..94d4e3c96210 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -110,6 +110,7 @@ int qcom_scm_prepare_ice_key(const u8 *lt_key, size_t lt_key_size,
 			     u8 *eph_key, size_t eph_size);
 int qcom_scm_import_ice_key(const u8 *imp_key, size_t imp_size,
 			    u8 *lt_key, size_t lt_key_size);
+bool qcom_scm_has_wrapped_key_support(void);
 
 bool qcom_scm_hdcp_available(void);
 int qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt, u32 *resp);

-- 
2.43.0


