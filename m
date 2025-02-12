Return-Path: <linux-kernel+bounces-511352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F12A329DB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A60316684B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AAD213E89;
	Wed, 12 Feb 2025 15:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mb6xursd"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1152116E0
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 15:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739373835; cv=none; b=DhVwLA3hu5FBOnzmd2UygvlOJ75JiW/HQHObm4c2ODqRT0VhEr7G1OHan6U5pBUVvbNvIdwdvHPEXuKF38mp4erhgZbBH0zlrghLOsU9RTq0aTiuOHDFsM0KO1lJdP2VUbIQ5kUMiva1lpePCtfVKlDeH+QDoL3HvJLHkEo3DBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739373835; c=relaxed/simple;
	bh=86qB8ew8BVa0Q5G77e+HrHDhk+DjhCNNMYNdXYgMu/M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LPJA/1jZRK9skQXGswBxb9M/+zfJKa7WfheH8uEPyHFMl4GReeK860CZPoF2sv+6GhWsoewms8E2z6H6yrQieE2MC6XzFTPWAVDukmFKKCjmpXxpR/NJRHD6YLbc7frxLpeo5jKhaqpExZJFo/fYqq3AWXW6vclkFdDN4mydM5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mb6xursd; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab7e80c4b55so333287866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 07:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739373831; x=1739978631; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fiMAJYYbGqQGrN9mqZ/PjIuMsY86kljhaikfZKAgMZU=;
        b=Mb6xursdUwNHTKKiG35gwXPTGhhX48w3sErwGBtVoHvntSJKnLo64Df0rfrQBlI31n
         5LeFysn2CjrLb4sosMvpwyfQQ2W9Hg0W/qX2twt1tdWVhcYzDXAbShtOnJd2zAYWwoSy
         iiZ+3Bw+vZ1AaY8/QW+4Q6UwwKGAqc6qTjgmQN+2KYDo04O9z0hQOZYa10UZEi2kvVnz
         EIfsgCTI29OgfaCbxNqNKe6z9NPl1KDPsszwlg+KKjm1tmcOG0jhmuf27lCTgwLt2lLG
         Jf8EQELmebV8nQ9ndPCz5N5qUzvS5DeRmjwOVfU23rFMIgaX024Qpo8eUSlb61l/1Xf8
         KzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739373831; x=1739978631;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fiMAJYYbGqQGrN9mqZ/PjIuMsY86kljhaikfZKAgMZU=;
        b=gUuh8y4hPwvZPBK0T4/IqZjaN35ck6QBgsjQalwyIu+uCPNUbB+Cxr81aUpC9pQwIm
         NZCrBSsuEImBxyhmuYDFn3A6mCx7vZQqtWABbFcZWRWlH1vNGULGpf4Rvho2ykkxwrkE
         eKD0esXbEkZFLopOOYQSi/wFVSt9VQGpKehtETipwUMCb6gQtdmcyb7vo3bf1Enjbj4Y
         EQwUpwo9RLdOPYZLHbVkaEeVQ5Mw7ca6ZP7Y5uDlmEM/Pg9uQEUw6PZXnRYikQsDrK9R
         XI929tvOSYuK1EJbW3XkJWzhqyL5RDCBufUQ/Jmt2wsiFo6pYncz0HAjM49gM+ztY60/
         4X9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVukYHo/aKCPSGeimF3fjcfata1zmqbPkufOyhbFiOHDI4dSCNqENI66b1uVwfBcNhVhuEAriQ5I7Z1qbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCyChinYB22SjzaW94BSO2nvTHDIoxN5htAD3XvvvmEJP9XElP
	wzWgkVv1rLMqL4YaS5rjxCFEJeQ+AOhLHEbEPVbUkiB6pMfgnbmeN0nTAD1TVko=
X-Gm-Gg: ASbGnctqQOo7LuMZz8+epX52yx8c51kSdj1zycFeaynocivaalj+4iurQasDW61y2Di
	gZPOjJei7MRifQP3OFi15MqiT/MJ8TRjeYiJC3ZbNOMCOYHz2ecVRc+u10YZNsZ6l02Zil5Z2g/
	cKRVbtJ/QUpuJ9Y7Llmg2jS2hG1q8X4yKdvLyKc+B8+eCyQGH+cBbrjIS0Eh7utrQ/v0torFd1e
	SyDx33IRm4ErziOaTIK0Vlq4l04infPNiOl4XGPvpk1VoqACZBWYT2hQciyqOJtNerejnP7Zw5X
	PnE9rgkpzbJRV6yAMbxi
X-Google-Smtp-Source: AGHT+IFd6/CTFsxOYTPNP3SwAZh6B2Q1L2fFN/auo0EoMrFbeVu/aPClhmCGWE7ZbkOLcltvypHlJg==
X-Received: by 2002:a17:907:6e8c:b0:ab6:53fb:9683 with SMTP id a640c23a62f3a-ab7f34ad061mr329677866b.54.1739373831457;
        Wed, 12 Feb 2025 07:23:51 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ab7a98974aasm866825966b.47.2025.02.12.07.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 07:23:51 -0800 (PST)
Date: Wed, 12 Feb 2025 18:23:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm: writeback: Fix use after free in
 drm_writeback_connector_cleanup()
Message-ID: <78abd541-71e9-4b3b-a05d-2c7caf8d5b2f@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The drm_writeback_cleanup_job() function frees "pos" so call
list_del(&pos->list_entry) first to avoid a use after free.

Fixes: 1914ba2b91ea ("drm: writeback: Create drmm variants for drm_writeback_connector initialization")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/drm_writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
index 3628fbef7752..f139b49af4c9 100644
--- a/drivers/gpu/drm/drm_writeback.c
+++ b/drivers/gpu/drm/drm_writeback.c
@@ -360,8 +360,8 @@ static void drm_writeback_connector_cleanup(struct drm_device *dev,
 
 	spin_lock_irqsave(&wb_connector->job_lock, flags);
 	list_for_each_entry_safe(pos, n, &wb_connector->job_queue, list_entry) {
-		drm_writeback_cleanup_job(pos);
 		list_del(&pos->list_entry);
+		drm_writeback_cleanup_job(pos);
 	}
 	spin_unlock_irqrestore(&wb_connector->job_lock, flags);
 }
-- 
2.47.2


