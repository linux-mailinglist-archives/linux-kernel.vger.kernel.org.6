Return-Path: <linux-kernel+bounces-204325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F9D8FE740
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 15:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1337A286024
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 13:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C905C195FDF;
	Thu,  6 Jun 2024 13:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tpaTYL4M"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68210195F08
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 13:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717679480; cv=none; b=B0QuLWvv+ItVUqO5LwdsPzVRWfcfHU4GSk0Syfc0/sDNzPo++ZGAQrBx441tgogEFMIjdHdcWyXIBv4CRA/S+2Kl0UlXCjrcez10oi1sUEZ0Oyk+UvzQGn/AwfeE+84HdbzAgUefV4HSCUDjf/xGeBuxPt/HTZRUwZV4akY/XVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717679480; c=relaxed/simple;
	bh=1iQB0TnxGPQD48SI52BVb8MYGJwHVX92ZuTXrjnYUgk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ue4fEbm3Zp/igz7U7e6hLm+AcxHd8M8Lj5VDIozs+cOcbPuo5ONnlGb7wGN31UjBTYeQbPLTss1RJgX3f94OXgyCmxVnepfWGzqvQ2al//6RLdoU5UhZPlJSLYlP4Kwx2bBuTTv0tFE3D6wWUkVvbMLSqyUkVr+SS5SLqPQOmRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tpaTYL4M; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-35e573c0334so1227578f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 06:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717679478; x=1718284278; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kDW0b/YSgv4QXyctzYjGDcstuFPG7XMfwYDc0c3f2cg=;
        b=tpaTYL4MjR6NGA28zBVjSboSgwRHsHuuo34OuegLpJL7l1KTU5Attxjevp7jb+vlDi
         SUsRtd0k7ecdM0/dwQw9vB8NFnWHBXxx0jdr9MZs2z4XuR8rSqQdjYQmDo+AGD578UTx
         q+5WIUjxV+wELKheHWCBosaUdN8KqVyqP52NnYq7NbME+tMpiQmKJ8V16qL22FOa06Fx
         0h843QD6BHogtFdzwNhRoxWgUbHgStH9lcvp1fOHtsgZp7Y9Ho6ZjCCv5IRMCYoum9iq
         yvGQwq9JVl6PaKPZXKcGWlKT1Pt7EFDzuPaqFuecwoSnLYO/bC+M68JIfsdluO5MnRcT
         gmAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717679478; x=1718284278;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDW0b/YSgv4QXyctzYjGDcstuFPG7XMfwYDc0c3f2cg=;
        b=B1NA0kKQwTtnhEw5ZWgaHBo3KiigfFcf0/OG9mo4TMcE9qwfFqQqrmTe32clnA0LW1
         Ko9Qhq97LZmkI7tYdU5Aul3ur+g94MptzPSIC+nID/30DJuAJ7Mte49KDlr4vCR8VNCi
         d6xw2LPhIwHat//2GqZEktp6OXRKWAGkFeVMhaxdj/aTDIC8JvEEE3mJdoBqCO6OiKHT
         s5azhki+6W42F4D20MRJ/r0Y4997JM5RjWrWRpoYhU05xM+/Zl4xUJ4Z7zlcW0lbnwsO
         iSAmE7IfvN8Tr/GqLqwYKEONFlgUMfDTmXhZjEWFdXdYRYtt9ZwTGYAniJssP/9823OA
         +Byw==
X-Forwarded-Encrypted: i=1; AJvYcCXlnsenTIEeV3Sp5v/zAmSd0tDoNdVoyHbusBCNKqXRZrr31htcnWhvYlP8GiibTdPi9dzoWEmKNfS7S4wscgXhHZL2U+fnE1/sc3+Y
X-Gm-Message-State: AOJu0YwCBwVulg8gLbwqytIl44oJkeIqQLgfBWOthPR+jgtKnnkq9rMm
	8iy8AB0/nAzHvQOgX/FYrVjty5CeVHMAnn05cn6jG9uSzWLy398+1Gf0/jhqS6E=
X-Google-Smtp-Source: AGHT+IHntx+2Ojv0Rn0jPTUKm+w43ccdTFur7Nx5THHhZ+lsv0dWB6JDEnSc1xmfwuc21ISzS7nYzA==
X-Received: by 2002:adf:e543:0:b0:35d:bdb6:4910 with SMTP id ffacd0b85a97d-35ef0da66d5mr2214928f8f.22.1717679477706;
        Thu, 06 Jun 2024 06:11:17 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5e96d8csm1536316f8f.68.2024.06.06.06.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 06:11:17 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 06 Jun 2024 15:11:13 +0200
Subject: [PATCH v2 1/4] usb: typec-mux: ptn36502: unregister typec switch
 on probe error and remove
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-topic-sm8x50-upstream-retimer-broadcast-mode-v2-1-c6f6eae479c3@linaro.org>
References: <20240606-topic-sm8x50-upstream-retimer-broadcast-mode-v2-0-c6f6eae479c3@linaro.org>
In-Reply-To: <20240606-topic-sm8x50-upstream-retimer-broadcast-mode-v2-0-c6f6eae479c3@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
 Luca Weiss <luca.weiss@fairphone.com>, linux-arm-msm@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1460;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=1iQB0TnxGPQD48SI52BVb8MYGJwHVX92ZuTXrjnYUgk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmYbVy+BHa85tAv1ttJWzOYAVF/BPHgf0KwQiABt0e
 joBVqJiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZmG1cgAKCRB33NvayMhJ0ce6D/
 4ykGsXqyzHoq1EFglS1lBaAeQ8q4ROGVHl5Yg1P5BIZXnctOWZHkNJ4oLfT1K3hhgA29uVO8vt8s34
 uA8WiV+7LfZQ59pdLpwxCm74waNUGAZ6tXoUGAWCBnbMUhGgN1/4ecX0meAfZextzAZogEIhGD72O/
 Jb6xAJpMMt4MeAx8yFwXamtuoAEGatNE2lRw0vFRbwBeeuVx9P29XgkQoheP4RRUNLVzBTLgMC5Vft
 FpskOU7X1QfsanAvi0gfbtNreq1ditQOl4p4CJtdV+YtQZXNBUfjdQfcG49bLc2N7RGap+KDebFy7n
 s8YNSvefeX7cQrFJ/N9C75ZfkWNipE0LzE1nmpYQeNeOxjVIr7b5nMQkaw4W7KH06WdXVUHW/fiBpK
 kIynjwiEP2YGyZyVbf3UFRCFEGPF2Mm1bZPojQlWGzuqeMP4uOqRHrmFR/gOysems2kVO0tRpUqEIl
 WbYxU6q6Hg1Hs0hA1KgPsCguB2YiSCp9pKa5CdOILGSOpDsajTViqzs9fZ9zgsRSh8QvJNpTwxFDKg
 xiBp6u6w5Y0vLnYbz/E+nGBvw9568MdRZ5PZkvdmo+T6V5m2OQx2C+O9ipgeC9JqpwxxGndnP+H5mt
 yr30IqKChY4qXEdlHdk4p2IpS6WCwgJkQnKi5iThFJGkmtVJdJstxETmee9A==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Add the missing call to typec_switch_put() when probe fails and
the ptn36502_remove() call is called.

Fixes: 8e99dc783648 ("usb: typec: add support for PTN36502 redriver")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/usb/typec/mux/ptn36502.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/mux/ptn36502.c b/drivers/usb/typec/mux/ptn36502.c
index 0ec86ef32a87..88136a6d6f31 100644
--- a/drivers/usb/typec/mux/ptn36502.c
+++ b/drivers/usb/typec/mux/ptn36502.c
@@ -322,8 +322,10 @@ static int ptn36502_probe(struct i2c_client *client)
 				     "Failed to acquire orientation-switch\n");
 
 	ret = regulator_enable(ptn->vdd18_supply);
-	if (ret)
-		return dev_err_probe(dev, ret, "Failed to enable vdd18\n");
+	if (ret) {
+		ret = dev_err_probe(dev, ret, "Failed to enable vdd18\n");
+		goto err_switch_put;
+	}
 
 	ret = ptn36502_detect(ptn);
 	if (ret)
@@ -363,6 +365,9 @@ static int ptn36502_probe(struct i2c_client *client)
 err_disable_regulator:
 	regulator_disable(ptn->vdd18_supply);
 
+err_switch_put:
+	typec_switch_put(ptn->typec_switch);
+
 	return ret;
 }
 
@@ -374,6 +379,8 @@ static void ptn36502_remove(struct i2c_client *client)
 	typec_switch_unregister(ptn->sw);
 
 	regulator_disable(ptn->vdd18_supply);
+
+	typec_switch_put(ptn->typec_switch);
 }
 
 static const struct i2c_device_id ptn36502_table[] = {

-- 
2.34.1


