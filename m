Return-Path: <linux-kernel+bounces-511354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C193A329E1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E4483A6831
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011DC21149C;
	Wed, 12 Feb 2025 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O8YRSq6Q"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0659211480
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 15:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739373858; cv=none; b=T+hptDa29Tbd0T6ShylwbiR6+I8rg+BGq+2dWECLdTx3kPdJIytx+RauWkzh0e22V0oYSJinGCFvPTAPnPGSeKA6KDXz9RFI2c3mdCjSDqlkbKfm84UFTZjYCXXdubumrEWF7GhsvMtePXacCNkc7Met2dDNU8d3F4tbmO3PyYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739373858; c=relaxed/simple;
	bh=bfhirtH+13nY6B5i7ITAi7el5FlfqSgmoiQ/NTQ5BQo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ikSaGYKQTblAAIcw5OXPNkpVyaJaYz99XkfnkT3/vAFP3aAhgSmUwSlwwZmdFZpPgunIN2gaiZ4jEG3t1x6z4G/30h7et3KFvTnYQQwak5zZ9l5ZdSfsO9cTj1R1fJrFXuTef5MMaxDrQvXFCG28k4T+fbBOJU/40GdvyDD0UXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O8YRSq6Q; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5de74599749so5677814a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 07:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739373853; x=1739978653; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PPKru0l0aVU3WKEJ1///OpkRf3iWaCUXDAkjzEyzYT8=;
        b=O8YRSq6QE0txsM1ZtzklnUvHNx2VaU+U0YgadD6FT+3Q+WMVcoY9jgjW0WEpEeTzZ0
         CMAWDRlSGrUTLja/Pj3eIMn0dwLAAv6MbA8Bxe3HCyZBfNYGRgRWmAHCFpBnaBk2Aak9
         BoYfKX+zbL4pnHE9ESaJpy3zcACWdUba+Ut5T58T3yhl5lIcIJFvmOTnER1VCxClfkTY
         kpvVomQD9unSIAUz9DF3sVU8ek7bDOtQN6Y/suTnTA1EBOzo7SS62+CzEVcQWXBBWKdh
         iJGFqbAE0N9EKqPCgVBnoEv50cknz1hhQPgtbIg2q51mSsbUykriqy2rXWWExf1R96ad
         X5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739373853; x=1739978653;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PPKru0l0aVU3WKEJ1///OpkRf3iWaCUXDAkjzEyzYT8=;
        b=IAsEur+98M3oONZIsKVcfiwoo2jZ1/3LsBG5pbmXE7jAWcUsfLLJiCfy6/0cu1B80A
         BoYE9ab9pVEcXqwxI7WSFTH/LnfHw1y1xnVKvMC14l8wXO+Ex8C0VVQVrc6jBi9/471b
         XmS3m9HiJH2Azpa2OwndgUzFAAiBz+1yQHxDimhBApSuYRUM56gM8A0AaHqRAmrl324S
         lZvp732Ct3Ba0yIDNYUzOsgj1Xs56azh7qNX+MuFXxElxbebXN6p6Zpsyu0j+KAg0b2i
         4y5Snm/4gnB4Y1A5xwP097M+H6bdgKTeqgyhg168O9xgJ90FdmLy7DwhpVewM3rWc2Z7
         +6eA==
X-Forwarded-Encrypted: i=1; AJvYcCXNlVFpUjMNPvPa5agNqxmI3yrNJKXIWvbAVKd00s4k4LqVgFE/f/x7oXT9notJiL6OQO/eMtvCINs2EwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvfVBnSm3EC02/JpSqzhthkGUHDZqn/dqoDDyo0T1iMR90iylK
	UpiqrNjrRHJwlK3TEvBxfD68kpJQL2aHrVJZjg8aac1YwalvYbP03gg5yg2JPNY=
X-Gm-Gg: ASbGncvFzGnRPJPbmpww0Dtf7Q4IEwZaTSfI07inIMVxJzws41c1JTFV/bIFzHA6Djj
	Kh51tbjTZk2xKGLtq8gd0+acq6WhjmR/zhF/ydsvIdDbudKZOyQoNv4IggWQTKGFWEicbbgRp7j
	szAsb+OQX6uNscMuxp/eRFUMyLfv38ydUcoJ5CaRgCgpru4zMrfOpmLu2UkWhk48E4xQvXbmkNt
	hVSIu1/KQNx3M8Mqv9A+5sbCd++wVHQ0dII5h6xIdDsLgYlFK2u+3ChvQze+OICZWJI6nly7IHW
	MuaP8y8GFtf/E0dbs5ev
X-Google-Smtp-Source: AGHT+IFjmw0Zgy4ifMz5CBDov7HZwLscmnRL30CFaXtX/9ilCY9ZxRB02Ln3oI9dpncAe8X2WxdR1Q==
X-Received: by 2002:a17:907:9490:b0:ab6:9d92:6d6 with SMTP id a640c23a62f3a-ab7f33d1036mr294868366b.26.1739373852788;
        Wed, 12 Feb 2025 07:24:12 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ab7eaeb8596sm269915866b.138.2025.02.12.07.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 07:24:12 -0800 (PST)
Date: Wed, 12 Feb 2025 18:24:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] drm/tests: Fix a test in drm_test_check_valid_clones()
Message-ID: <c50f11c7-932c-47dc-b40f-4ada8b9b6679@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The drm_atomic_get_crtc_state() function returns error pointers and not
NULL.  Update the check to check for error pointers as well as NULL.

Fixes: 88849f24e2ab ("drm/tests: Add test for drm_atomic_helper_check_modeset()")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/tests/drm_atomic_state_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tests/drm_atomic_state_test.c b/drivers/gpu/drm/tests/drm_atomic_state_test.c
index 0ab5d9ec4a75..5945c3298901 100644
--- a/drivers/gpu/drm/tests/drm_atomic_state_test.c
+++ b/drivers/gpu/drm/tests/drm_atomic_state_test.c
@@ -283,7 +283,7 @@ static void drm_test_check_valid_clones(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, state);
 
 	crtc_state = drm_atomic_get_crtc_state(state, priv->crtc);
-	KUNIT_ASSERT_NOT_NULL(test, crtc_state);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, crtc_state);
 
 	crtc_state->encoder_mask = param->encoder_mask;
 
-- 
2.47.2


