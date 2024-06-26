Return-Path: <linux-kernel+bounces-230235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1B2917A2D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 09:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEFB1B248DF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 07:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B7115F330;
	Wed, 26 Jun 2024 07:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k6niCmol"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8B115CD4D
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719388401; cv=none; b=sMf+/7+8kqUp85a63CWsMlKAcs2N1RGEoPIuepMlHo7tSpHHIv7qJ8NUklCjDg3rpFaizEvJr8rjlQawP3nABAdLq2/HHVAW/vQTXlTAl43qL8Iv4BeyCTKO0cuoBsBdmPxu1hGf9MD2hZao9ZaUvOopkQcOKnT/6zm+iPZBC7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719388401; c=relaxed/simple;
	bh=bUFnBCaoWkPM+lGdjHQoFsITf35bWEg8TZpL0ja8QGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=czP1KT77shbBDzfQxdaSl4fv+LIcNrJgXDQhj7tDO5j6gw4/6cg8I8da3sKJlwZ77RQO0FKRv4DyHClAUbi06ZqxYNz7cw9C+R5y6vieV6fsJpZ4KiaXZvixLMGVNtXlgNiH/6VWk+SDIDTAmfwBfzoWCZmeK/hVmkCLcb0TC64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k6niCmol; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-421bb51d81aso51876105e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 00:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719388398; x=1719993198; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T1area+MaFWUDermRoLera9+4OUrjSIeeXP24Yb/vWo=;
        b=k6niCmoltEvwMZ/G1X+5pgrQ1CA3GA6qsMYx4uOz7QnZ3bpXfVSVQ6qZCx58cUenq9
         yQMnJXgXcOljTWlvjO+Q483RsZJNDuBeaZWW9bS8DuKlUYegcKOANb81EuRYYfbz4fOt
         tYdqBAxmWLQdn5RQ4yXFeTMm3vg2DCp5iL5CVrhc/tEemvbPahe2FQHzCGAgiRxW4NUM
         EdvcW06TXw+ibb1uDtHs/B7LxHnlXuCUyi0hRzDJWXiHyz3y49YwQqSiKfgiPm/6qj4F
         yuIRQUIl2geKkSlF1XvOvnEIdLU3Vz75ZDFwET980z8VUcuzasPEc9rap0ncfUVm8Gp7
         sfyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719388398; x=1719993198;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T1area+MaFWUDermRoLera9+4OUrjSIeeXP24Yb/vWo=;
        b=CWqx1hdByg3YRkX/+0QeMHKl6fyHZaUl5+JTPKPk6wFQvoVryCymtYbiRdC8F6sXW3
         2LRRKVRg0b0LeBPA4sVciTuytsr3nx6HEb/QJrjJ2n1TWgFpxc25yxaqqROdC6syvxhr
         IaBvkqK/9ne7T63GFI/6YMMCcjg5sxNKtkdrg8qKylO++xGo3inVdzbDhbOn7WHFKN7d
         drW1KVypqo6SWamot6VmCoOFONzHWII8G4n03EKQkDUFtGDXGpt7obcUULRvYUBZVY6l
         1iOnpgq0sL/ocln/scg3Lo7CsoehZfTD8rTmjCGBmbwEJkH1Jj/v+1qCzUUIqOlMp5Af
         vwfw==
X-Forwarded-Encrypted: i=1; AJvYcCUPogF9A5GtU7YA3jctbI3DYbPTqjCBt9V4bveXLTXoiTAUkbSUUp10gDU9/MJ4ugbRKQPek5xXJ+yVL4b+41ez+RRgP/w5ZAJYvCgU
X-Gm-Message-State: AOJu0YzT/NoPq8s3u3FlsN3GOyxRLw1vrDyXi3TuIbDI/NQg+5S6e458
	hWPWyGEF/zHYWjKK/Q6NRhRV9QvLZdNtwxmT7npEMWJRKG/QzXjwLEH6UoSeAOI=
X-Google-Smtp-Source: AGHT+IEKkrz0XZ/FGEkp/KPMY67ejxiTdOZ2Rr+AaQrnwx9g/w+KQHYoLnBiwYIQALSatGlYPyNnbA==
X-Received: by 2002:a05:600c:54e1:b0:424:9024:d45e with SMTP id 5b1f17b1804b1-4249024d4c3mr52628185e9.4.1719388398204;
        Wed, 26 Jun 2024 00:53:18 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424c846a8f0sm15220405e9.42.2024.06.26.00.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 00:53:17 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 26 Jun 2024 09:53:16 +0200
Subject: [PATCH] drm/msm/adreno: fix a7xx gpu init
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-topic-sm8x50-upstream-fix-a7xx-gpu-init-v1-1-ff0a0b7c778d@linaro.org>
X-B4-Tracking: v=1; b=H4sIAOvIe2YC/x2NQQqDMBAAvyJ77kKa2qT2K6WHNV3tHowhG0tA/
 Luhx4FhZgflLKzw7HbI/BOVNTa4XjoIX4ozo3wagzW2N846LGuSgLo86t3glrRkpgUnqUi+Vpz
 ThhKl4DAFGnzvRvI3aLWUuUn/0+t9HCcYzCoBeQAAAA==
To: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Rob Clark <robdclark@chromium.org>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1250;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=bUFnBCaoWkPM+lGdjHQoFsITf35bWEg8TZpL0ja8QGc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBme8jssCMYsrSvaqz+TTf5G43VRs8w40xKxUjTe1ob
 Oi2BEbKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZnvI7AAKCRB33NvayMhJ0Rl8EA
 CTLPfyc5SoiA/wMMY88mBc4/bIBJu7jvcEe9ZWRP2vZij3UYKZ8m3vriQasDVE5InlydLVkg6NPDya
 x9k0G9sB4fUth9fcDSkLPwYRNd/boSaBKHdMVE21RYmI6Ey6j5c0l3Y3ImR8qk+pUsaWThoXD77zaW
 FS6C7W6uBc2kANexdq5RzGjmKsD18q8GFrUA8e7sS1q0FODY5NmLoCWt/R25Xb2V/CcRkvXuZpbdQ3
 vTtoHxb6D+BhciasoGg5vxGDaSjDboUT8pGIUGE7rK29NDz1GLCqDWkIQZ7xG5uOqJ4BENhwwDHCSb
 ibaklVDg9H4cCZNguEoeEaFezXp4PAExiQocS93ubxtyqbYl+fxn2NZLZ29s5TYmfElTEaN4k11XIc
 l6c/Z7TYgDKfgwte0OGXaRP/cEln/0NJddsOnAqHEJMnIPoD9jbEtr2HfaaJ6Z3W1XPIyHwDY76P5y
 SMAPFgdVKK59j5ySK9ykgRqnr0AHXgEfhcMCx9Vm7dJA3skalFaIKirgQwUYCpsXugXZRurkoiF8h8
 0q0jccQYhyd8OxbW3ONfn39pO/JcDEkbyRIDy9H2TKxQSOLuvJ9XX/86OLlHtcHqFH+4vlz1qsNupc
 xb3qT/JL4cSCDqcqT3oDtgXeAovGoZ2fN+62prqnqdZOSjhjaUECz4L1rgVA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The gpulist has twice the a6xx gpulist, replace the second one
with the a7xx gpulist.

Solves:
msm_dpu ae01000.display-controller: Unknown GPU revision: 7.3.0.1
msm_dpu ae01000.display-controller: Unknown GPU revision: 67.5.10.1
msm_dpu ae01000.display-controller: Unknown GPU revision: 67.5.20.1

on SM8450, SM8550 & SM8560.

Fixes: 8ed322f632a9 ("drm/msm/adreno: Split up giant device table")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 1e789ff6945e..cfc74a9e2646 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -33,7 +33,7 @@ static const struct adreno_gpulist *gpulists[] = {
 	&a4xx_gpulist,
 	&a5xx_gpulist,
 	&a6xx_gpulist,
-	&a6xx_gpulist,
+	&a7xx_gpulist,
 };
 
 static const struct adreno_info *adreno_info(uint32_t chip_id)

---
base-commit: 62c97045b8f720c2eac807a5f38e26c9ed512371
change-id: 20240626-topic-sm8x50-upstream-fix-a7xx-gpu-init-9fca9746ba73

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>


