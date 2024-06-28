Return-Path: <linux-kernel+bounces-233813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEA091BDB7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 13:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 876B91C22F37
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A3F158A32;
	Fri, 28 Jun 2024 11:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S1Neeqin"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698DB158868
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 11:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719575185; cv=none; b=RaDwWcyOEBLs0D9lLEi1gmVnWIWoTuJcXguPX1la0pYmLpM0jcs++dqWy1APOCl0i8ztUq/EYKezxPBea5ZFWh9BcQZW8nDJK1A504zHCrY+T8iftsYInBBrlnlG1by03bpjpb/sfp3dlBxrlqndzlhVOeR0O1Rp2dyMsAD7thc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719575185; c=relaxed/simple;
	bh=vEmfiAne+KiyRDNj/Ak3IyzdvfzPeulyHZoEEcDhrpM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F5VgEX5DGaKxJs82rxE2BJJ/fxOJzsO7yE7HFO80r3D8HfmYVbTfRlVgPLj1+p2TuSFMmrsFgRhgJ4IvgxdEYUWPE4UzqzMEwlWWqd+kNbRPzHU9QJzvtRZLGM3/9/l3tvWUHIKvU6M51gtCXzyy2yb0UqMjxk2ZpjnSjhisknI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S1Neeqin; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52db11b1d31so739264e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 04:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719575182; x=1720179982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAh6YJurawpdJpQCh05sfaX1aygIRQvrJqh39cFL9CA=;
        b=S1NeeqinostdNZN3VUNkN7VWWuXAAPAX/mTnq+grA0b8abjuqHGQahVvpdUnhCCwo0
         Srbq6pYO67F7iDpZsHNQbg2bTU2KnNTEXRtXdXve+lidoQxAYDVg5Tv93OVaKHgydggQ
         lROIOgUIx4/ey6bMu6+jfFqm2pvF96RqX4WrW1Y1E73XehcIXo6wz6FI/nZElUncVRvq
         /t3Ze6Da56aDOmvqXzj5icGo7uUSj2sykMnOWDKb671koS/YWeE/c8zFjPYubxsHXx+A
         0AIkDqhDZ5UBqesXcGHplSb1iER3xwOXtG3pvR3xBZgrVZl+Eiwra9KDpx2BlpXytoxR
         kIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719575182; x=1720179982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAh6YJurawpdJpQCh05sfaX1aygIRQvrJqh39cFL9CA=;
        b=uwe2TO/O1z0rip/kBFTJ7jVGmmuiNkTQj0PtNayGOCKarS5Atr/m+ZpczUNgvYuu0D
         pV+KyUfK+BOWgRo6KDEOua9ymrQR91hl8lko7Wd4knW6goikGrmODESYyi+V+Msqma/s
         Oes4PgaHa+KlBt4r4J9pPhCjbBcyRJJeq463lVKJiuRCGL1sI7jEIGl/VkuOET4tcC2u
         0RT3FJG3hv57xX07wMANA++KaAgMTvvslEO84YyXBe65ZnmLPfC1rJ+JdA6RdaqKm+4R
         tLXxyCKyH744O2hHZRqdYvrnTHR0BK2ndFGBMq9mcnGgynA8JYEPFwQ/IaKfCO7XN0Tt
         oBrg==
X-Gm-Message-State: AOJu0YyNusaBwIF2K6kl7y0eEEQ2MAYOmzNulTC5VzgF+hUGvjOa1wJq
	E8jXEUgr69eqf1/MeiYmbsSt8Co1HI13cTEv2C6buc7P0Qmr+iiO/SvWDxyWbis=
X-Google-Smtp-Source: AGHT+IFQzaKHtbdyPVLmhhs+ndV7Msu7/7CKnByqlEuHg4e/gYuGli+et9+ae2RloelwpikS4MN9Pg==
X-Received: by 2002:a19:a413:0:b0:52c:dc4d:acbe with SMTP id 2adb3069b0e04-52cdf82094bmr10669099e87.45.1719575181812;
        Fri, 28 Jun 2024 04:46:21 -0700 (PDT)
Received: from srini-hackbase.lan ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af389b3sm32721345e9.1.2024.06.28.04.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 04:46:20 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Ekansh Gupta <quic_ekangupt@quicinc.com>,
	stable <stable@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/6] misc: fastrpc: Fix memory leak in audio daemon attach operation
Date: Fri, 28 Jun 2024 12:44:59 +0100
Message-Id: <20240628114501.14310-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240628114501.14310-1-srinivas.kandagatla@linaro.org>
References: <20240628114501.14310-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=949; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=CvPcYqEU0+U/QHHokAP76ysndTMG1WzJfZje+PK0MFY=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmfqI9Ml5beaATGm6wYQujunlhS3CiU1fa5ouhA cv0lzqCVDOJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZn6iPQAKCRB6of1ZxzRV N/s3B/90LVXZ6HiWD+ofIR4+oUoDSIWvEpsIOwcUjj/YdKohf2UcoMbJYpGYaiPFlt8E9fZC+6P zWkbQRMHxUzoh2cH14ImhulGrX7kNdqhYuf3mS3PIa9kYNvz7i5/82FgDgF/vrfQBN7InENOzv8 JhCOLM0+Lk+CZ1E4xnlWkFo9y9LxEouOOCg0+Qtu1sWW2D83WVeXZD3zJl8dhAS8C0zNPr/o5MU E1eH63suyVZ0UEaTBLif1IECAByReVMA9C+amPhMVSswl/Cs+wuupwehaPoUsx6b270Fk6IVuUI v+Bikp1AXWEPHWt+T/9byf7Gx7Ux/jK1dacwthdeuDiTXkjm
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Ekansh Gupta <quic_ekangupt@quicinc.com>

Audio PD daemon send the name as part of the init IOCTL call. This
name needs to be copied to kernel for which memory is allocated.
This memory is never freed which might result in memory leak. Free
the memory when it is not needed.

Fixes: 0871561055e6 ("misc: fastrpc: Add support for audiopd")
Cc: stable <stable@kernel.org>
Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 3fef3eecb88c..11d53b9322f1 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1320,6 +1320,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
 		goto err_invoke;
 
 	kfree(args);
+	kfree(name);
 
 	return 0;
 err_invoke:
-- 
2.25.1


