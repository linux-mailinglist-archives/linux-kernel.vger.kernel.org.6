Return-Path: <linux-kernel+bounces-571437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1F1A6BD27
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67A943B710A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEF31DE4D5;
	Fri, 21 Mar 2025 14:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RU6riQhk"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EB01DE3D6
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567751; cv=none; b=R+RJ24FpEHrjFHXg5RDN9Ug0gudzkCcIJyiOLHxUKzFelOU4P7hkj5LDctC/YXjELuMkv7cIwYK3jcctbA2C3+KrupaKXkbCxI/RJg9apQ5azCm4y6JTyEYDo2CNmw08xBdkqE6pTmnVe3ExVVJDEmNNzx0YKwFm2z5y1V9BXDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567751; c=relaxed/simple;
	bh=aDoq2cPAFwpjpI+a6z1ZdwU3wKRRjEG838SxvUMy8+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=r+k3urpCEeQCZZTR+mB5h2IxJ+yd575Ex+XoNOz10Fi0hIytrpo/a4TqY5yjXtPuAxfQgWKHb0W4q4ySK3bQxBFd2PbVYPkplgufjXhCw4PcQ0zY8xKcMhNwBXfSo5pRNloYPjgD/YvWdF7WRRPk+vm0d4O0CHnzaRexLK4gZm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RU6riQhk; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so16718685e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742567747; x=1743172547; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GWwk1F93k2WjXHD1BSOy5Th8h5+cPNdP8aqDclQzOiA=;
        b=RU6riQhkiokRzHfkg4jhxRcbciVUt+PVs9ODgVp+DEr2pJeqNalpK+T6Vk1Ugwv1zz
         nnA6U2OS8ObNklGDlNC/5KyvfyCAxu+YrVU69L2pbnWgHB52+whVYmmIIEhReD52950Z
         stVaH2zPpqqOFAsZ02zV+xcW1eqNGkg/W2ZmgrtNvnHpKq3f4vQFwGpKfwIKHxN9BMm6
         /b0kRq3j0p7HZcm3AUxl8lXgmlxy7gbH4UEULWjuml8i0kxvFg7E/M7OPfkKyn0zQxtv
         /LngvP1POi5wn7OOq8bgVuQ6ZrsU5jK6AoGH6XX+S0PUO/D4LrlPh5mzG5BkfUaHWsKm
         4glw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742567747; x=1743172547;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GWwk1F93k2WjXHD1BSOy5Th8h5+cPNdP8aqDclQzOiA=;
        b=a2I8nzjcDmp2avOtiAVTOMpmUd7nTmbv4I/e7Mr/VS+zgzKlbPE1dX8lL4A7c/wDiZ
         w1gKDRKwQ1pthZhL/nP/r2M+8qBhubDaq3OWyhTG7CZNHPLDx23/uN44MToTE6++gIJt
         bYDPExHlcHtEsRKb+24W7luN1ZVuE8clJOvb6AFxshj7n/sGq1+6ROYq7ZScqbHyJyj6
         q8jHPqYyJpyrh5mqxP6QHX+WGUJrvnL9TSmjsrHkKnnNqqWiuUmtcefhQGnwtok/C8Wr
         CRKW3qrUc+oeuHnMY+wVMOxYgd+5dkzscsdGvn8nREaX2D5FyGV33+w4F0ibWc57AidI
         vR8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOaDWapPQwG1dcSncaVANW6dMhoNqlXAUpjnPHkWrqDoxbckrCsdq0SvGFq0mEkreeoNICj9gITW5x0EQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/IdFGnoGmqMdovLHvk10riMW2Ps5Aytuz5B6FwhtDC5JD14Sc
	SbiBGNewI5HSsp/55S+nFSb0wXMzf63LrnwvwXxNSr3Iuao5cel5tcy9egpQnqk=
X-Gm-Gg: ASbGncvW7KgKizhef7Qnj61RK57RxhGzu8DJH44CMUFt8DdTWKkUnAAh96smRrOhh70
	fTJkJ7krUQYOApor6Y3n1i4WSlT2OPLrhY09UUoIVEh64RcYItbKCzX8Rsapq/qVaOvfJCzwQzh
	FIBjbi6JW0YSh8tAfXYqAJE3Ufm80CLruXfxWPco31IEt5j0HuY3X5vk3l7Gdfhd4NCPq3MHAMH
	aIGqkmunoWg9lhm1oeuo3RAYlpJ7v+mQmdrxPAax/d1y1ddhWUntZjUIEzbf4sUyCbBbyuJ5RQH
	jHcw6+NAa6Btj1CwNnnZd/qNV96OmVs3/B0jW6equ5tclfsf1g==
X-Google-Smtp-Source: AGHT+IG3s7EumH1UWJRshfI79DTisR3g0LyyvxiIy+Ix/0bn7lyq2EKXKwqHEpE8LdI5qX5z0nDHwg==
X-Received: by 2002:a05:600c:4512:b0:43d:160:cd9e with SMTP id 5b1f17b1804b1-43d509f4581mr36639005e9.17.1742567747224;
        Fri, 21 Mar 2025 07:35:47 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d3af0f3b4sm53206595e9.2.2025.03.21.07.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:35:46 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:35:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] remoteproc: sysmon: Update qcom_add_sysmon_subdev() comment
Message-ID: <77a6b65b-5f3f-4a21-a837-7a4a7e09b099@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The comment says the qcom_add_sysmon_subdev() returns NULL on error but
it actually returns error pointers.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/remoteproc/qcom_sysmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_sysmon.c b/drivers/remoteproc/qcom_sysmon.c
index c24e4a882873..660ac6fc4082 100644
--- a/drivers/remoteproc/qcom_sysmon.c
+++ b/drivers/remoteproc/qcom_sysmon.c
@@ -619,7 +619,7 @@ static irqreturn_t sysmon_shutdown_interrupt(int irq, void *data)
  * @name:	name of this subdev, to use in SSR
  * @ssctl_instance: instance id of the ssctl QMI service
  *
- * Return: A new qcom_sysmon object, or NULL on failure
+ * Return: A new qcom_sysmon object, or an error pointer on failure
  */
 struct qcom_sysmon *qcom_add_sysmon_subdev(struct rproc *rproc,
 					   const char *name,
-- 
2.47.2


