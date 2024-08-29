Return-Path: <linux-kernel+bounces-307540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDFE964EBA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E194DB22E13
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 19:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E38D1B8EBA;
	Thu, 29 Aug 2024 19:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DekIvRRD"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8215E1B86EB
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 19:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724959394; cv=none; b=llVT90eAf03Y5QuwZLtSqdX2UodSZW/jOvKBrvPkkw3HhudixttymvqlhNZrsu7Iozt5I49isBL1WPcWIIiz0M8A0z8ClIR3yBtnw/FL0GkeEDSMEW4VUeXlGKBl18lk/02VrSdf2SFalllGGmyj9WkfJPO32y7Ls7v3kgJ+BM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724959394; c=relaxed/simple;
	bh=ukuhjIxgkFrw5P/9mVNrV8Qq3LbAA9wjABoHcIrvHsw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=l7kZY8bDE4hA7lUl0UyOEhjgaJJFULvG7cYuBgCclW5JOXT+og90Sls1XBMj6lmk7jwL/ufYWx5pf7l7cAisMNWUBpFvuWojmjOY1XpMJEs3qcgFHQy+oLRb7+rs5eY0yg09cfnfwuR2VdfBlXyhNnadLo5EvrdTWY/JVF726w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DekIvRRD; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-371936541caso634915f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 12:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724959390; x=1725564190; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kb+/gPdGEJGskPrMhsAh3708IPHwwoKYQn4i2knABsE=;
        b=DekIvRRDqYfQ0XWYv6AoaSdL8i6r+m1JNTFzWQO+w8mtH541fO1S2AhWvLhoQXnNkO
         hs/hOsghtggXyGQZrVHwOEcSI/iJSQqpQOBSKU2AofBl3dC94ebXKsRIesJpuDF1IQoj
         aLdlqjv6lOaCE3qL/AX45ILOvYDTcDbvfV41yKE0UAbe2MheBI1tv/uh/afVu+kIGsJo
         XdWCPPPVcuv6VdjPj0cJ4ist0BUAzHgIYN8Vs3ykfoJCEqrhVJiCA9TP1gmQG0O556u4
         mvUX1llCH782AFLr20MD69Ep2y+Q0QuxyHIbN9BPwHXo/8JpwUITNSNVpUmytHHujrne
         tq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724959390; x=1725564190;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kb+/gPdGEJGskPrMhsAh3708IPHwwoKYQn4i2knABsE=;
        b=ZdP1f16Jzvd1nAxq4fvBO26XPBilT0Pdorz1RyDu3mAl+NjIubyc9zMFZ99Mho0/TL
         Ur/jcr/uYilI5zxAHkyD0t3qmwvIHmO7z+/+KCDztfGty+tunl6oiuRLLFgOeMgv6xXD
         z9VvTH8HYXl1yCUC7pPWk+6AQKi7pmeSNcH6YBI3BBBWpqK/Kdl/L8RNNBSY5EujgrgG
         ce57yDwotykMpS+pOaL3zNwGkfCRIopY4lXIbK7rHSjgzewcr2UBoJWY57otThnvAWTp
         ZwXzqUHwrsMtwzCDPcGqiTNeWfOCcsk2VeKXEBN7x2yysO/Qlw7YBe9+xtKSQjnyI4xe
         ZlyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwBqK3hAtGygyOaoITwtyRCfQUOKDc5OoyyOHmAOTr4df3qMLja1j8GVk9BNiqrzVKzTRepyBXHQ6fjv4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3KQbsJZ4V5Kgvc59uOKsqCgdQSffO/ecPLxgwXBhE/pfB3a8D
	8UMrSC6ptJbKKeRFQZHPIklX5cBAGGoCWcKRPltaPVvpFCS+oywcU0jLIdt7aUM=
X-Google-Smtp-Source: AGHT+IE4wYbt9jCHc5S83ZfW88uhbElBJKmpOtRl+dxUob9KomXWqzq1uB65e6/dHM7+SpafO+b45g==
X-Received: by 2002:adf:f510:0:b0:371:8682:467e with SMTP id ffacd0b85a97d-3749b58168emr2590741f8f.46.1724959389644;
        Thu, 29 Aug 2024 12:23:09 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee7475dsm2115161f8f.27.2024.08.29.12.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 12:23:09 -0700 (PDT)
Date: Thu, 29 Aug 2024 22:23:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] firmware: qcom: uefisecapp: Fix deadlock in qcuefi_acquire()
Message-ID: <19829bc4-1b6f-47f7-847a-e90c25749e40@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

If the __qcuefi pointer is not set, then in the original code, we would
hold onto the lock.  That means that if we tried to set it later, then
it would cause a deadlock.  Drop the lock on the error path.  That's
what all the callers are expecting.

Fixes: 759e7a2b62eb ("firmware: Add support for Qualcomm UEFI Secure Application")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/firmware/qcom/qcom_qseecom_uefisecapp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c b/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
index 6fefa4fe80e8..447246bd04be 100644
--- a/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
+++ b/drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
@@ -715,6 +715,10 @@ static int qcuefi_set_reference(struct qcuefi_client *qcuefi)
 static struct qcuefi_client *qcuefi_acquire(void)
 {
 	mutex_lock(&__qcuefi_lock);
+	if (!__qcuefi) {
+		mutex_unlock(&__qcuefi_lock);
+		return NULL;
+	}
 	return __qcuefi;
 }
 
-- 
2.45.2


