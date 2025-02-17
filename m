Return-Path: <linux-kernel+bounces-517113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7462CA37C55
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 08:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15983168A06
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 07:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA781AA79C;
	Mon, 17 Feb 2025 07:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m9KU0cwi"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BEF1AA1DA
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 07:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739777538; cv=none; b=aBMvTuZEGaNf0jdOZFnOg1UbTznp+SyOXfk4WZB5mJkaF+xIomAL7mL7uQlvzIWmgjy1yCmH76dtfGD8Af0ei0GInTzX0Tf6wa6G6Fjo0Ef3XwWVm7jU5lyagGRWdHmwB4Y3uniWvOaBMeeR75qhG1aIHyBHAL8YQxnqrsv+jIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739777538; c=relaxed/simple;
	bh=D1P6HRkRSuWuGIyFa3FIxyItrNqE/YBTIxKXZkYDpZs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=erlegfQMno/ySjc4iiRAYMzSZu5xPH8XFHZLhC0FcFkGhH+AmwNh/gErJ2S8LaR7XioS+wWFS9u+NlbxTg1nb+O70LOyrDGpet9seLKqY+mVBRaYeCqpUShQlHCKEJXoNVp6s08dE5qHX80LHbt4QoyDIP+x7gQeym/zMu7n7cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m9KU0cwi; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abb8f586d68so135278966b.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 23:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739777535; x=1740382335; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hO2J1j2m5X6qQF5wOtrAqeimkscPDnsoO2uRIRbK0t0=;
        b=m9KU0cwiicIeYiizaiCHFyu2MmbjQPk2nn5VQp0Mdq20mf2kJ+F+9Lfe2cKph/Vo+R
         z33sb3x3NZVYSPD0d3Ab85S/88jJn1P+rHuRSSe+u2RO3sQ0//PPS3N/hu/9SajP6+6g
         MRrwf66gM31TmiU5RWwv7Z1GAU08Xjc4yXIwQtnYBO5IiCy3XDBlQbvR17I1UQL1ZHKn
         H/K24yVfO+v2RdkdcKC3MUJKfvbslQhc2pjwT6p0g1Itj9VVv2PLx9RRzc3PeMYa9E9+
         5fnGcrGldDNKaZbJfgmFrLP2ENhoxluMuHwk00katDPwEqUKZMlEMvQd706geiJZsNLB
         y1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739777535; x=1740382335;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hO2J1j2m5X6qQF5wOtrAqeimkscPDnsoO2uRIRbK0t0=;
        b=udaIfL4oIRAiCaAkW9VikdYFAvagKDDcV89yIYvoAIW9yV+tam36qB06g78w6mSIWH
         cAogoN3iDueHR7BoFlk4n3Zhx0G/1utNhi0oTr2BzX20tk6qUZjO4M91b8yzY33tu/ek
         oYJi8vnzLrINKYxPOpeLERtefInluwPkhO//+WRNVqhWYn5aGFIJ1RN10uFZMt+4Hb0K
         LQJnBxVgERDS1yE+u8mYNpfgLLpke6C4Y+4RsfPqtbtVrLQ+88fpEMQVIIv6pCUeVQwx
         vxuHAUYWlsAUosXN/f4ld81GlOuPfmpR4sVR6JgNY+Jrb/Bd+lVHWe5Ok74el2GEqFWb
         yNBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL8K3+Du49WOaldwnDUU/4oRL6aDUe22lcZfYusjCHWBPW6lzUXb8QSjJgo0V9UwK5P0/sorF5lFkd6cA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN55bnS11WoOAGx7twnNC+NsK0k7lplVe0hkDplTq5TLDVRXrg
	4JMa1kVoT0/V3cJGrTvytlkvy6Jn22jwAaPWs1pRyJ1JJOTlyta4kSQRyHnwl5U=
X-Gm-Gg: ASbGncsnNB7plOq8l+cNTo4S3ujfxy7Wraj4AROsYgoLiUUuzW/+gm/UZef++bJkABv
	tcddrFe2N4R+QStiVWw/HTxzBSK8P/pK5RY/lo7VoHYL9+KQcCpZfG8jyplSNkUooAfbA9CoStT
	7h/2M6AeNdoFoteekoeko7Pc9EyqdhrtdcuuFCepPvDKARPY5pTZB/MB5jswHJMfjUW3nAx2Ogl
	zH6sAQx54+rC26kKbXIf3DgmoCGlXfBWEsR4EO1T3cBQNwYL8o831EfUs+Bwq62lUX0flclt8FS
	8Vm7tOsyW/l41chgRotI
X-Google-Smtp-Source: AGHT+IEXChx9P0XiKZoNkZiSog2lL7kqWeWWaA+fbxmQW7+pyPDaxfCj2UqyTeAJOchNetAsSy3KVQ==
X-Received: by 2002:a17:907:c1f:b0:ab6:8bc1:9b5a with SMTP id a640c23a62f3a-abb70da2ad5mr751573366b.41.1739777534951;
        Sun, 16 Feb 2025 23:32:14 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-aba910e8b11sm556516266b.21.2025.02.16.23.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 23:32:14 -0800 (PST)
Date: Mon, 17 Feb 2025 10:32:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rob Clark <robdclark@chromium.org>
Cc: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Akhil P Oommen <quic_akhilpo@quicinc.com>,
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] drm/msm/gem: Fix error code msm_parse_deps()
Message-ID: <75a78610-281b-458e-b703-57c7e7de573c@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The SUBMIT_ERROR() macro turns the error code negative.  This extra '-'
operation turns it back to positive EINVAL again.  The error code is
passed to ERR_PTR() and since positive values are not an IS_ERR() it
eventually will lead to an oops.  Delete the '-'.

Fixes: 866e43b945bf ("drm/msm: UAPI error reporting")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index dee470403036..3e9aa2cc38ef 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -509,7 +509,7 @@ static struct drm_syncobj **msm_parse_deps(struct msm_gem_submit *submit,
 		}
 
 		if (syncobj_desc.flags & ~MSM_SUBMIT_SYNCOBJ_FLAGS) {
-			ret = -SUBMIT_ERROR(EINVAL, submit, "invalid syncobj flags: %x", syncobj_desc.flags);
+			ret = SUBMIT_ERROR(EINVAL, submit, "invalid syncobj flags: %x", syncobj_desc.flags);
 			break;
 		}
 
-- 
2.47.2


