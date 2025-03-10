Return-Path: <linux-kernel+bounces-554002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C971A591B7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 303EC18909F7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682C4227E94;
	Mon, 10 Mar 2025 10:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RElzG8fW"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F080122ACC6
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741603653; cv=none; b=g2ZWUIaODvAEwtPh2nSkL8uOatFkkRWOz5YqEEmp1s/V7teP88ZSj5iAdaMR8uj/FMKxkTW5jcCnCLhPqkzfou8EzWDRM0wYm7pyfnWrDE+tV95WFjwNq5uGXJrrImbNRLNSWw3ihHlAj5vblToB3VlWbReXgRdcG1Du1KoqGPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741603653; c=relaxed/simple;
	bh=jdP/eKZQYM28TtBJS491PMB9Uu5FsjtBa5QxRx4Jcxs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z98Ku3+cNJJLBSDqLsOeZXU6yt1lLhQfv3FkMuvcW7PpubWLhv+hozKk1mRgUiSENyrMsZhLov96cD+6XQsh+tZacmLUxBINPIIbk0Noji6sX8x7cEHVThKkuWvPPIAL1205ecDQAeRwyXxRjjyxyePj64AiT24ybSgKKkblN9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RElzG8fW; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3912c09be7dso2156504f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 03:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741603650; x=1742208450; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sR/CcMTKsdlA9AlU4rM5jg8thXN0o1ZO9YRyBCXqGLI=;
        b=RElzG8fW9AMZ7UESFP+oQnWFlfRSRHj7BQ3Ja3SlkAmIIBEiH3lofJq3dvOmGCBaLL
         DA2rz4g6kQJHTilwfLEG2n/t0n82xJV8HPPcYBaRy4YdImak1KGdgWpjXglL9v8QpPTN
         V0SuegDTqn+qiW5P6xiYLqxsK+CzWyubuiOrLJXXYLYyh3k47CyO9vEiBxblgQc+egn7
         sAZEPysH2euzmVdywy6iF+23cqykP2xYDUZYUpQHnXf7G/0xG3mn/NhyFevSI96asuZU
         Zd9v5fzZSPuMyRDkhIqIyCJ/7pkUBNQj0Qs6Q7TrPVDbI0UI1IRlx9N0cH1EhSr0Pvp+
         xqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741603650; x=1742208450;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sR/CcMTKsdlA9AlU4rM5jg8thXN0o1ZO9YRyBCXqGLI=;
        b=O2z5l054zejlcGJXWmQNWSlSA71GJfOU/gSNGh5amkdQxwJWh4oSh3occH9PcTFr2e
         oPWaXYoaVhE5c4xSbQ48UY1hBtvOCxyv1jIIHBOAacK/qdSSPVkSfyPJiR/DBwvO41Ys
         P2LjfXNsjEscqBenm6TrrU0SAm621TaIqP4xyMFJ4UWIxHbw81LCmsMQ0+Ll3FE9D54n
         etYJfn5LaNfZaVVqD9UW+tzhjyD4FbkzJU0BZnqVaksgW8jPaKefaVXhGm5HcJlQlUWd
         f78sAk7uT9htvOEhsLDoLdvntwSLPxy7h4pqo8MNjA++iuh+S5xZLXcnBBqzD6XVH0si
         Vvvg==
X-Forwarded-Encrypted: i=1; AJvYcCWezM7NxKAaWE0uDbKVnln0bU59lwI6m74XwD1oYmpnBr/gQpGMKfldyQ2k3o4CBXqDx3imoOmYAZvG1Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy52XSy7jK/lcTwa1nWtZ9Yjs/XBEdWsj/E4SHWe1JO/sIGtyle
	V2BMVrNJO5/0+laHDqhYPmhLtL0q5UZEnZXz+3D9oTEDMqAmIDsqw2Jl2kEah74=
X-Gm-Gg: ASbGncu1xz7qzAbtR7AQTq+bAKJDo92pispjHpIwie68x77UNfu/NhvVq13hwyMN8Wu
	a8cnf44RvBMtKiwPqGyo5d4UKCu21bS/mKTO3otlW2HRYZQCsX/yVvLJccJogXysKc6Y2A98Ah5
	4XU+lD/hfn+NDQU3oC9AMhcwJ3qHqZu8YYir0C9Y0E11Zq2QqrJClmambpI8iZpR+UQ3K+6Wecu
	8iWFopHfrdR46HDY8Z9x9VUzkqToxcot3aej8RKDfIdSpUSNrvHFhkfpNXIe/biQtXJxCOB/+pR
	56/waPtLLRmqFedTzBvMINIvCpso+hDIRd9Pox9FsDmHlppr6vmmRLw0RV0G
X-Google-Smtp-Source: AGHT+IG8QM+WxzxCzm0SZiOEb6aIF64Be3WE+Zs9nuUEYTEOzCjQ3A3RPLHlKVFRDpcen2hFRlv+hw==
X-Received: by 2002:a5d:5f45:0:b0:390:fb37:1bd with SMTP id ffacd0b85a97d-39132da8e47mr7295090f8f.46.1741603649926;
        Mon, 10 Mar 2025 03:47:29 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912c01952dsm14227332f8f.45.2025.03.10.03.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 03:47:29 -0700 (PDT)
Date: Mon, 10 Mar 2025 13:47:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/amdkfd: delete stray tab in kfd_dbg_set_mes_debug_mode()
Message-ID: <ece8324f-0d58-4c83-adca-7187f730c56f@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

These lines are indented one tab more than they should be.  Delete
the stray tabs.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 12456c61ffa5..ba99e0f258ae 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -357,12 +357,12 @@ int kfd_dbg_set_mes_debug_mode(struct kfd_process_device *pdd, bool sq_trap_en)
 		return 0;
 
 	if (!pdd->proc_ctx_cpu_ptr) {
-			r = amdgpu_amdkfd_alloc_gtt_mem(adev,
-				AMDGPU_MES_PROC_CTX_SIZE,
-				&pdd->proc_ctx_bo,
-				&pdd->proc_ctx_gpu_addr,
-				&pdd->proc_ctx_cpu_ptr,
-				false);
+		r = amdgpu_amdkfd_alloc_gtt_mem(adev,
+			AMDGPU_MES_PROC_CTX_SIZE,
+			&pdd->proc_ctx_bo,
+			&pdd->proc_ctx_gpu_addr,
+			&pdd->proc_ctx_cpu_ptr,
+			false);
 		if (r) {
 			dev_err(adev->dev,
 			"failed to allocate process context bo\n");
-- 
2.47.2


