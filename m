Return-Path: <linux-kernel+bounces-530650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FB1A43632
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 08:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9993A7EA5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 07:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B25C25A2DB;
	Tue, 25 Feb 2025 07:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YeLtH51u"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB09717C79
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 07:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740468635; cv=none; b=tqfYnG1ahtWxbkZfRSO6SbaXZw0kFhYIkECQx9tEMjMFxLN9WWNETFyb+Pgrs1kj5wztMPDhlQnz7vO08yU26XrbpZ2yG6ZDJ3Xr7RH2TuxQwzlOEslcT5cB6F16+F6xMkOJ//XCFEvdUQSyfxqIAm0ZK/logw3QCIvXUenyP3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740468635; c=relaxed/simple;
	bh=lLY/y7/44+oHF/HGys9GOAGZNYPIN8tsHz48KOcoOlA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Onr41a/I36ApxTuS8w3srAV857vbqOQJw5cisEaEQoJb8X/2VjHsIdiVbccyumjfmaqLdoxkygUUF7lZMEd22ooq+/9dgehNoh/aEa9Okk72nK120+fw8avnhPtkkjaZ2BPKWoBSczgkW8Giqqiack1gq/iXybgMJ1VxkM/kc0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YeLtH51u; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5ded69e6134so8666970a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 23:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740468631; x=1741073431; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TfuM5g5b1bzsFznJjaGXX66+r8znKzFeJVWgK6VGC58=;
        b=YeLtH51uj2ZMwpsbrjGousjmJApJDXWareRt2wehq5iJM8azmSSebwmFhbJuwAmxbn
         xMH/gK3mnTSpJJIFtxqcIIOlxBCIMTcDLpH5XJcEXz3tl2l+QlJgnH29PWvIdZW923E9
         /0ZWy1q2fZRjCkBiCF93nW2rjZ6KWoXWweVq5U8iESuDiXBOVhhQp3YkBcD7nQjoONJ/
         eb/JxOpYogOLipxHKpboNqF8BUrpFbHpvn1t1APitjY17D34nQGVlEWBNKKMErLg0LjN
         3t0PnyENuKcaxRZcK4mx7hbhl3cFWCxemgOzghErkN9A9RZMLOz4t0Ex0YBBptbseZU+
         pcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740468631; x=1741073431;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TfuM5g5b1bzsFznJjaGXX66+r8znKzFeJVWgK6VGC58=;
        b=DZw9I210FiTdhyIyrvz6xM+nJquMbyG24nyREba1yErNJ5rHgNn1q6cXme3yD6l5b4
         SmkdQ0TSfNnK5lP9WCG8cMvq2doY0VhNxskY/hAzmT35vW0cMCET2rnEgVodZyVmtupa
         W2MHHj9EnlEf/lZ16Bz99r1Zp9iRGkdE1oWug5TBB3Z/wa1zVoZdyy2bYlmAo7MUbJoN
         ip1BdzppFhQeVZE/nsuWws5ZLxTu1/ONJvi7rw787gKeXnksSqDlELw96gcFttGDPiSj
         QudaNMGEUOxXj4/73lkiY8Thc9Yrh9HXAXdpTCxbfrNL7gM3E13HU19AMwfklgqC9QA+
         Uwgw==
X-Forwarded-Encrypted: i=1; AJvYcCWzgwZ4KfSj1naaKz0X/WmUaiaWCC/7OZhbePE92/5XLmkOuSq69FHDiKTh/WkAvlNNcnuPdNHTpvPX3IY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC4Gg8doUvaSqAdnnKVrqjkgH7KfVV8mwiIM2NlEpuqXBRthgx
	5SYnaBNUmFlY8gIrAntZxmPu+E2n+eUMcH0+ygXUtIVW+6xrMMGsza7Wg5vc+FY=
X-Gm-Gg: ASbGncv/CbggG7JRqX2ie7KDRcelidHqct0hN2jedQB5AQh1Ts3ESg/Udgsx/IrlbaE
	xcx/0UPXex4pXdo5rkc3u6jYxF6+upbgTOu+JNyB571CPf98oH+gGtuQ/Jqh6G3RXIjRtq1l/wy
	j32FiU6P5KhEXheS4+cZtV7DUHJyA0oIc2VhiZ1U9YmYEh+a8wVEdlQxnGjLH7vTaY+epZYbYRP
	YdG3i+8QD8kZaOTDUBSI8YY4u+YmSQVN0ffvUM9+2mzPJ8TZSsvl8dcLp8j66CBxWtE6oQDn4PW
	DozTc4x4HQvSgDahiAtT0SmVI2uz3YQ=
X-Google-Smtp-Source: AGHT+IF1jD1nIi0UqQ/yrLSB611MTk3aZB/2hvtf9cDDpXVP93eDIhNTWNWnPWPNHZu27Gv83YTAhQ==
X-Received: by 2002:a05:6402:27c8:b0:5e0:8261:ebb2 with SMTP id 4fb4d7f45d1cf-5e0b70d6598mr16065265a12.12.1740468631260;
        Mon, 24 Feb 2025 23:30:31 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5e461f3e7f8sm788694a12.69.2025.02.24.23.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 23:30:30 -0800 (PST)
Date: Tue, 25 Feb 2025 10:30:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm/msm/dpu: fix error pointer dereference in
 msm_kms_init_aspace()
Message-ID: <3221e88c-3351-42e6-aeb1-69f4f014b509@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

If msm_gem_address_space_create() fails, then return right away.
Otherwise it leads to a Oops when we dereference "aspace" on the next
line.

Fixes: 2d215d440faa ("drm/msm: register a fault handler for display mmu faults")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/msm/msm_kms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
index b877278888e6..35d5397e73b4 100644
--- a/drivers/gpu/drm/msm/msm_kms.c
+++ b/drivers/gpu/drm/msm/msm_kms.c
@@ -209,6 +209,7 @@ struct msm_gem_address_space *msm_kms_init_aspace(struct drm_device *dev)
 	if (IS_ERR(aspace)) {
 		dev_err(mdp_dev, "aspace create, error %pe\n", aspace);
 		mmu->funcs->destroy(mmu);
+		return aspace;
 	}
 
 	msm_mmu_set_fault_handler(aspace->mmu, kms, msm_kms_fault_handler);
-- 
2.47.2


