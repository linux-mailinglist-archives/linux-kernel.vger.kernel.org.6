Return-Path: <linux-kernel+bounces-410841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB09E9CE24E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B06CF28318B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A77A1D460E;
	Fri, 15 Nov 2024 14:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iFhfGCzP"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58A61D4352
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731682216; cv=none; b=jK25m0f/wNDEensFeoJOnLm/4urB9vrgJtiXcRkQ/tsflEinFnUpfjUommB0DPzoG9cp4iHFqSUAXqgL2gnlg5UXX3wjmf/8aS0gZnhxPypNR82FPbECX4yI2BAPZHcK+wTtcnmAz/cdcabZcl2voHs2HOuZHDkTJvkagSK2LNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731682216; c=relaxed/simple;
	bh=4Lsb2aNaRxUx71jlMDwJrQPkOjGidkS7CHXpbHyZ9f8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Egy7TE0SqaDlvG09ZBA25KhP8NMWltxXP8PcK32uCg535EXbFLd5RHl+g+ekw5ifGHEQDa3yC9fZ3NLSy7xNUxYtmMiNo1/87fTZuhkNpPmm/3T1edgE4HYtlcn/3Vizg95fQxXBiAxTAmZBgazBFes6ti+SRIvRdVTz5v2adk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iFhfGCzP; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4315e9e9642so6594755e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 06:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731682213; x=1732287013; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I3InoUXqD6T6uxxkojh3IT3+QQg3Pub9UoRpvavO2qI=;
        b=iFhfGCzPaezPQtaNY9U9pPFJtBMcYHrwq1sqbUVh921p++9MMGfkaGFuuQS3Hb4kvh
         ZT2rjAGsYI5oiH13MFBYckdhLLcnPWwIdbcMBd9k2LnLM9HkOhmv1/HOFJw/ss4YDF05
         dth/o91Te3OPgiaWljtkZDqQnyKxIHdfl4uvvRxW7yC6DDL7ScH8x1uz9F6CRjC2fNnc
         2cyCv70ZkzrLwAlBaw4uWkWw1+LEIVUn1KjLmFiylcMEmGzxQJo1VZnEzZxiPgBEMcHM
         9ySi7nnZmdgSY6ISdW4GfuWgLqF5zZ+gO7jlFHchtdznMZRT2+DngZsw3RA9kaGy7Isw
         VTdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731682213; x=1732287013;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I3InoUXqD6T6uxxkojh3IT3+QQg3Pub9UoRpvavO2qI=;
        b=ZdSgQ2BDg7phJPXyd9DvJAqhRUHlvpMcyUJaOUYqvDFsoYDU69CVezFyYT+4Fnyza9
         gqV6lKp/QatYIaJ6PPFq6F1P9eOodA/KDjwsOApQItBKSXC3G6fCrTMzygDKG/cHRg2q
         hGT4hoWKiLFzOy/mXc3xa1vFhYHZvEcNospetjNN4/PwfwuFSJ52Oop6x8kQQBwtHraT
         wEEkx13lL48VauOEJTnKK3XQR+EPoBcBClP5a0fEAw0dHTyl+MaXga7BeBQbzplOqXpg
         j6xkUSwosE4o+OL7NFyZk72MKPCV5rTkTf2cBfamWrsnZZLG0FTu8mGZh4fqid2PcFVZ
         28Vw==
X-Forwarded-Encrypted: i=1; AJvYcCUwnfklRQSebhvVaULD/l7wXnu1VV6RUxSxjBDochu/3ylRMBsXyiWl2CkslXlsijuQEZjxjDF86f0aye0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDUsoVbrf9cgHbuMnJTTzWWvvj2dInQH0aSzcvK1jIdkfJLpcc
	eLD6o8XRgWgH3F6blUehjoHJxxGeN7z9spt7VZtnE38SdIGATqkZ91qUx+JChs4=
X-Google-Smtp-Source: AGHT+IELTncAcPS4YEQroY4QuEM9WQoaNiEMcLaa5qSj7F8nR5Z0m/BEZVxNXK2sXlfnW7v/XbGFkg==
X-Received: by 2002:a05:600c:1548:b0:431:6060:8b16 with SMTP id 5b1f17b1804b1-432df792d1fmr27540505e9.30.1731682212985;
        Fri, 15 Nov 2024 06:50:12 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432da27ffafsm59247175e9.22.2024.11.15.06.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 06:50:12 -0800 (PST)
Date: Fri, 15 Nov 2024 17:50:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/msm/gem: prevent integer overflow in
 msm_ioctl_gem_submit()
Message-ID: <7c1e6300-8eb3-4d10-8ec5-51df5d9149a0@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "submit->cmd[i].size" and "submit->cmd[i].offset" variables are u32
values that come from the user via the submit_lookup_cmds() function.
This addition could lead to an integer wrapping bug so use size_add()
to prevent that.

Fixes: 198725337ef1 ("drm/msm: fix cmdstream size check")
Cc: stable@vger.kernel.org
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index fba78193127d..f775638d239a 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -787,8 +787,7 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 			goto out;
 
 		if (!submit->cmd[i].size ||
-			((submit->cmd[i].size + submit->cmd[i].offset) >
-				obj->size / 4)) {
+		    (size_add(submit->cmd[i].size, submit->cmd[i].offset) > obj->size / 4)) {
 			SUBMIT_ERROR(submit, "invalid cmdstream size: %u\n", submit->cmd[i].size * 4);
 			ret = -EINVAL;
 			goto out;
-- 
2.45.2


