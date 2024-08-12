Return-Path: <linux-kernel+bounces-283396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4CF94F1F2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D41281D28
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A5018732A;
	Mon, 12 Aug 2024 15:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4vKWvmr"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FEF1862B9;
	Mon, 12 Aug 2024 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477401; cv=none; b=LZZBu3KmGGJ0+Qh19MmhyU2D1JXfpj2bOeL32IcUt/IG6eBUby/cvmOd0HhL/2AIDguQ770xY34fGmBc+prnZOedc2nesWS4J9xHpImXsFKKwmMQ7UTxgolytHg5fUxagNkTD/dsUTknXh4pxh9ztRMkxKZQjQO3hlZHsxNYfzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477401; c=relaxed/simple;
	bh=+qEeRmaVE/yJhvllAM6mSXQP96hC3cxBt77l6bQ4w10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L09RzGn3wz98lD3tTV7wf+hyd2HD8Jc9jZ4cmUohykCPN2ExeWq5YglwzId7CKPbPykByUXl3jtmSl8/WBCBS3TXqk/pJNBWqlYNSJgpRIbJZP3DSYbdgrhagtDO/llSW0zD6Za2bQHQpzY07TEEcFr48ywPxduAFRrpLMiLTVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4vKWvmr; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4280c55e488so26396255e9.0;
        Mon, 12 Aug 2024 08:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723477398; x=1724082198; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mpsmSmGqrOexvhDBQICod60vYYV3sv3m/b8LQyy02Ok=;
        b=I4vKWvmrEJa8PPMWBeFYHYMG8wkOxeY4hO2aU5ojr+GUvri30VqzPdfF37dcmSpqE+
         VFw+6iehciztGhh+DuZAZSe593PFRrKjy6pwVhIvTYhW0CFTmnPGBed/SRfxPisBGpop
         VlD/eMiE/wXby9mP07MbCl9F+oOqOX1rSsKmJgVchyUR9baLy5JZRaNn37THIRJIKfZ2
         Ro468KI/Y4/3y/+7BngcQPVmfAlctzKSeUL/LGIjRV56RxLUS5jZSGj4lrWeHLlVSjmz
         RWiMlPnuY2Sbyc9bnnYGDnkEKn48/NIFtG1VsIiTf6OW4diNOoYUqq4ea9ghnxE7Eg5Q
         UoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723477398; x=1724082198;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mpsmSmGqrOexvhDBQICod60vYYV3sv3m/b8LQyy02Ok=;
        b=iC7PFL9wgLcKdIWzTqZSpg1fOYs28DKHHWfYuQUwvt3wBTm+ecSquQFbJFKp/15YjU
         DctJYE/2JHmCWarTjXl4tPXPvmt+NL92bN/OpwRKDpA+7igvWC0WKZLdArUDMB/6ofvk
         5F/AGGAVmRmI2U8cZnrj0/1FtS8uFq5tVbproIkBy/kAmYBWMxBq0D2xpIiSrqiD9vUN
         Crp30VNRdnK/p5TDgMp49NEe1H4UhD6/OPsKelpW9PeOJMI2ZmTasv+alL1eDQyHkOKD
         mS9oc/h46r5ZHXN0+gPiL0D/0pe/x1uET/1M4wOxsCH7eX7karneLXvr0hVHg+8HHAb/
         QqFA==
X-Forwarded-Encrypted: i=1; AJvYcCVhy9EJxFLk1XkhMAgzpI6mqmwGIXgNfOuPpUC21PdOZrkDdp7zleA47pxU0/vDQDQA+VrmRVV9TQ7WOhPt1vadGCqKMOBii/WZsPyo
X-Gm-Message-State: AOJu0YwoTyRxf48xAVChVEpBOyqD2OYfoOStOQQFwc6D3lp1lw38T+bS
	txD+FtXH4ebAXEqgt31wtoxug7zz6mn7I5ZsbjMKv3H0xFaMlbJy2Yrn5Q==
X-Google-Smtp-Source: AGHT+IFvU6D6BP7UFiJ+pjIbE12qGr7ID88u1ZHFrIjQcLa9MtJwPhJ5nHKgBT8MI7IaMOsfeV8dNQ==
X-Received: by 2002:a05:600c:4514:b0:424:8743:86b4 with SMTP id 5b1f17b1804b1-429d62900cfmr522245e9.6.1723477398042;
        Mon, 12 Aug 2024 08:43:18 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4e51eb47sm7859713f8f.88.2024.08.12.08.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 08:43:17 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 12 Aug 2024 17:43:03 +0200
Subject: [PATCH 2/2] hwmon: chipcap2: disable sensor if request ready irq
 fails
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240812-chipcap2-probe-improvements-v1-2-3cdff6d16897@gmail.com>
References: <20240812-chipcap2-probe-improvements-v1-0-3cdff6d16897@gmail.com>
In-Reply-To: <20240812-chipcap2-probe-improvements-v1-0-3cdff6d16897@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723477394; l=724;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=+qEeRmaVE/yJhvllAM6mSXQP96hC3cxBt77l6bQ4w10=;
 b=S8K0k0DsvELn94xMnOgy3awPzq8XJZAg2bb8TsB6b+ak9BFqm9s3uKkRWiSjSV3+j4c/jw81/
 /ucmIgjyoV2Azh4OwmYojlu4QCo4jR+nbYaGCbrC+AcRX+HUaJcyTwz
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This check is carried out after getting the regulator, and the device
can be disabled if an error occurs.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/hwmon/chipcap2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/chipcap2.c b/drivers/hwmon/chipcap2.c
index 88689f4eb598..02764689ed21 100644
--- a/drivers/hwmon/chipcap2.c
+++ b/drivers/hwmon/chipcap2.c
@@ -747,7 +747,7 @@ static int cc2_probe(struct i2c_client *client)
 	ret = cc2_request_ready_irq(data, dev);
 	if (ret) {
 		dev_err_probe(dev, ret, "Failed to request ready irq\n");
-		return ret;
+		goto disable;
 	}
 
 	ret = cc2_request_alarm_irqs(data, dev);

-- 
2.43.0


