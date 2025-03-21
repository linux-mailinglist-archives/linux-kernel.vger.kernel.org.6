Return-Path: <linux-kernel+bounces-571438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19810A6BD2A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67DA53B84BE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033801D63DD;
	Fri, 21 Mar 2025 14:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DKE3+r+4"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B461D1D61AA
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567757; cv=none; b=F5v0Zt/sxloK1S4frRwKV1IfZkGX5tToxFc9b73T4/z7JzgudV51U5CdbbBgRLr5vKhV0Ch3wy6ZFcsi5l3nUpXDrOiuprXmOe7ttI8W0wGkr6eelTuGTffryZRVbv3PUwPhW2TfLHiyyStmO/eGg8JCIBKSZ24UUpHE5LnEmu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567757; c=relaxed/simple;
	bh=zewkcsreTAIYS7PHyX+Qg+PK84VPiklh12ShuEBHSeo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OMRGXHvwn6HtyDIeILDMo0sI9aIpxe4eYSBF4zgC0jCWoWmf3PwY9DrFjnCwTefaY3gwyrm0qRAnYEZtRUUJQ2J8woWrEIJ28PraM8blUFxeyZuS81zmx1BnhC1QAsT+LVsfgsIV9KcTSnkf9G2WC0Jfwj1n5+zmL4uVqcSb8y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DKE3+r+4; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43d04ea9d9aso9731285e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742567754; x=1743172554; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jhrcb/mTWviEZZ7YzcelEEpsaZNAgBebPczHwX9f7os=;
        b=DKE3+r+4X2pN1mTf4btc6K08Jo6IBxqc3fpE8DwsT/Yjhj56lj0mnxHHQl6Pql8O2H
         1q0hy80hyInP532X4gjbVhyvUkdfJFyovESh5SvYvpkblbmYJVeH/+txxwsXqFo5k1Xo
         54oEdae/1/htQzyra5WMWQTvYh1qsbXdE/5f/fQ6yhpPUmgT0opOdP93vc8f2uCbAje+
         fbmzhJ+nOr+SdF2tH/jkM4T81ErOGYcDZlK9rhChgsAFXXUQ20hTj+0t1I9CVHa/uxl4
         5AeezBxjoke9jayxqCawXNiKDp5/T3P0Texjic96WmjmmzCG7Rb5aBQHzKe1cp8+iVKw
         5ZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742567754; x=1743172554;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jhrcb/mTWviEZZ7YzcelEEpsaZNAgBebPczHwX9f7os=;
        b=kaP1Xdtia0q+WZnGHTG72J4I3Q6ieIQj9wcucsjqJrimmX6Bkuumgm/Y6SYAdIvpR4
         x/VkSw8c7nHoqXre8FeXr2lHQJxjrSRebrgEiqoUowD3d6WHnGDo5k6ImJGEn9ZGpUbT
         VqGOm/mnY+8JzAGkp5rV+Fd9gWbzK71Fla1liwCWFyn6HYPqQ+qi5VovVxIbAbIrse6f
         A/Cw4l8EsWxDJXL4LaOkyvjSNUVphANPFLBWU7UfLO6C9lqwE78ERFNtEC5LpDmOAcH8
         ongPCz+Myuw8GBJ71YC9tlg+oFid7ZMCmltFgBPiIHsSkVd/KajDMOVjTTb98+2VwP2j
         ohxw==
X-Forwarded-Encrypted: i=1; AJvYcCXAPgyT1SLNhaRnMHvDj/0rgBru4i1BQDC8WY+rCi3JFlAEvK42aCIyw/bzQ8jin68DVOi+Li68cntdtsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUuVzu2d4zZJ/4GQ02QobeVNxTg7Mcugq+qpBWd4p2HcSUdb73
	U7h//hcZaMYP7p5wopyEVGEkzlnCGumWo6HBYp0BW97d82btdpO3kvjQ9LFG/o4=
X-Gm-Gg: ASbGncueFcDgaNcaxZJwp3GW18hAwWuQ31fOaXcB3xAdc2ccLy4XYK0U7Zpgsdd7Svb
	S/vX80yrQS+ic8vNGHPiNX3ODuJj5Y/DlEvJblqjk797wZpOMRir/GOEaPcoHhrJOTccfqNw+aF
	ear7KUed5RjVy/EUUvvhLGObIt5v7DlFJbhSpjDzBQBgyhtFOH6JZnKf7ylTIlFJZJWEIpWRYXg
	CAOfZ7lxqEe7AjrpazpFnpRC9iYIi1W/LhfQT7yQXKPYPZ4px+wxmFxHFYT/DxP4O9T7sA6ehMf
	AAOOAiRH81Ph388Gmidp37YjX8ey4Up6YQVQWOl/LB8bThpmDgX5RSoMRnu+
X-Google-Smtp-Source: AGHT+IFTlIYuugJCayoKps7oOfO+nEY2lgoAtdOqm9RkYPvK6VO/88fiHmYrMJaHHiCsISy8+YmeUg==
X-Received: by 2002:a05:600c:1548:b0:43c:f513:958a with SMTP id 5b1f17b1804b1-43d509f4d23mr32282675e9.13.1742567753912;
        Fri, 21 Mar 2025 07:35:53 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d43f43ed6sm79077865e9.13.2025.03.21.07.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:35:53 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:35:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] Drivers: hv: mshv: Prevent potential NULL dereference
Message-ID: <9fee7658-1981-48b1-b909-fb2b78894077@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Move the NULL check on "partition" before the dereference.

Fixes: f5288d14069b ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/hv/mshv_synic.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
index a3daedd680ff..88949beb5e37 100644
--- a/drivers/hv/mshv_synic.c
+++ b/drivers/hv/mshv_synic.c
@@ -151,13 +151,12 @@ static bool mshv_async_call_completion_isr(struct hv_message *msg)
 	rcu_read_lock();
 
 	partition = mshv_partition_find(partition_id);
-	partition->async_hypercall_status = async_msg->status;
-
 	if (unlikely(!partition)) {
 		pr_debug("failed to find partition %llu\n", partition_id);
 		goto unlock_out;
 	}
 
+	partition->async_hypercall_status = async_msg->status;
 	complete(&partition->async_hypercall);
 
 	handled = true;
-- 
2.47.2


