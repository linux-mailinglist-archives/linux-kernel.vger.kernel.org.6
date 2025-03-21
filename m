Return-Path: <linux-kernel+bounces-571439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A00F8A6BD30
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D00CF3B6034
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131711F1511;
	Fri, 21 Mar 2025 14:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R8/GRT1B"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BE21EF397
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567762; cv=none; b=L/aUyU2+VgIJhwU6JGtZwrjG+A8ftfR189n+O1+dvBvM2xZ6nOV6YuESD3fW4zjejuqhyiv6UAmK1k8ptKCq52zTXHtj60woxk3BGuBZnYU2J6Q9b9ceKx1CfXvXjAwvMPBO4RqExFtFYDnhmjyADLmIZ67PRwrbJar8Nd1VQQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567762; c=relaxed/simple;
	bh=LssPVw/eR8tGwu63BhqsF4eAyNkjrVfgd8RLy+IzfH0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BjtmXa+CdwofKzT5LrJ43IZkDE8LUX3AmIeWSPNd4lPz6CNlf9v6ftSCxwAK7a/tv/yVIvM7nuD8EjAFAcXivDdzYri5ckPWo+qVVxr5LT43bxi9TF6ayU4IlI464i+M54YMwtAelga/aY8t1EHmyThsVEcOqNQIggsgxeM3zMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R8/GRT1B; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so14110365e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742567758; x=1743172558; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RU2ONVmom1Z3vJLSCiuLTOfrELMOd3Zg4NSQXvpae6E=;
        b=R8/GRT1BGQ6etup3OoW79D89S7ELHnl7rQJDrqraU8AyBo1PfBJqsXDU1SPhIMuocD
         F2JxCuuj4s0aBtGRXIFoRNBHM0bOrBzc0Rz8q8OXGC3AKteD5zblXdx+ap3L1s1dg86/
         3Gq4SYnT5jriyqdWfDTC+2pLQn08cqFO8na8PmjTJTvb/keqys6VIosnirHGzQJ9YLW0
         ZssI4Z8d7CYNR26OuKi5coUEfuo035epotMQH8SSkIGwNUy9QCgdW4TNAhr6m1GjmlmN
         jU5X+NN/F8NeAUiEK9lw/+wccIfu7w/GvHHgY0SmSuKjMQ6lCX/6R0/3Hs4iaEF7yYK+
         iwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742567758; x=1743172558;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RU2ONVmom1Z3vJLSCiuLTOfrELMOd3Zg4NSQXvpae6E=;
        b=G6tlgPbsgqIsIcjES9Y9HWztb9ol7g03v5MiZftMKjISxPpbzb2f9uD5tULGwCJa5D
         djhiBeIBtEHrcR57ce4nbcNpaN3f59GQrE7CykPl/bJyoJjZUsyGLgkW2l+uxOOe6xIC
         4fos/Z1YpKFCogohimT0TsqdDgezIdDjDYOGh8EyWDa/Xd6gSpMxP0So/tR5SMKRDqsi
         O3qRiMLri21WcGiL7Oha51IKwlCqwJe7BMlzZi9bUeaauXYSLnz5OCXmNDivoTTVVQaj
         /U1AtZGSaRyp0uEFuisS2JPmRuSgkweUiiE9Y35I+FCbJDOyYzEjkNWPTqyQ7WD0AZtP
         /zMw==
X-Forwarded-Encrypted: i=1; AJvYcCVGoGPhoY8CT9hHXrjQNLL/vTzBmdgUy2gqX1LNshS+2XYwRbGgQkaCiyA7cKLvn6fk135s2i3ZRcuTQUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeaSx2VZtwwIqKnjUgJ+E4RFv1JVU3sCzNLVz+jLBz0naeUxAH
	GRYHju2+OFtjtslw6rMRbaQv4FwJD/m/eTwL8RSZmXzZqTCvud/xfYKTrBP0BDc=
X-Gm-Gg: ASbGncsjOr357FZa40oyMB2hEyY4rzmnZKtmxHt/CDwQq45WeaXRIpPpcSM/tLJ03De
	7BK+V4HqjV6FJjE15ylY6vC11BKr86Tst387o/jesKBGpWIrkYrEsx2lN+BQcv3AXIcMWzTjgiw
	gQ3PUWNA3dzo2RKxHd7iks4zWvEw4HTlMY3pV3XWy5TYNa85iH4ZwOqEFE47OeXp6OcPfT2MPjT
	1SMY/QAQu6c8I1SgaIEXwyhRovKLzf2GmCFzFH3NqkTuxQtdw1Bo55OWOYoWANUS9BZS8mja9UK
	nKXj3Ppl4LyuTVPpYGGtX0WLCw4Gm9WH24sWZsM3YUxp1re83FvZzEKoa3uL
X-Google-Smtp-Source: AGHT+IFGThZO/X4twcqLKIJCHzcz08tvoomZPsI1WRvkfM0Dku3p8STs9FB5aANY+T8q/jr+pTEbmw==
X-Received: by 2002:a05:600c:3d85:b0:43b:c0fa:f9dd with SMTP id 5b1f17b1804b1-43d50a3c017mr30528695e9.25.1742567758200;
        Fri, 21 Mar 2025 07:35:58 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d440eda26sm79621195e9.36.2025.03.21.07.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:35:57 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:35:55 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] Drivers: hv: mshv: Fix uninitialized variable in
 hv_call_map_stat_page()
Message-ID: <fac96458-fdb9-4166-94bd-f1d135abc6ba@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

If the hv_do_hypercall() succeeds on the first iteration then "ret" is
not initialized.  I re-arranged this code to make the loop clearer and
to make it more clear that we return zero on the last line.

Fixes: f5288d14069b ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/hv/mshv_root_hv_call.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index b72b59a5068b..a74e13a32183 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -733,7 +733,7 @@ int hv_call_map_stat_page(enum hv_stats_object_type type,
 	u64 status, pfn;
 	int ret;
 
-	do {
+	while (1) {
 		local_irq_save(flags);
 		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
 		output = *this_cpu_ptr(hyperv_pcpu_output_arg);
@@ -756,11 +756,11 @@ int hv_call_map_stat_page(enum hv_stats_object_type type,
 					    hv_current_partition_id, 1);
 		if (ret)
 			return ret;
-	} while (!ret);
+	}
 
 	*addr = page_address(pfn_to_page(pfn));
 
-	return ret;
+	return 0;
 }
 
 int hv_call_unmap_stat_page(enum hv_stats_object_type type,
-- 
2.47.2


