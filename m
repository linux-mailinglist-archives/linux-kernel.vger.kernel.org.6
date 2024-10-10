Return-Path: <linux-kernel+bounces-358979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE249985F3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B750428304C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B122A1C578E;
	Thu, 10 Oct 2024 12:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f1Qs5t6K"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1571C461F
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728563372; cv=none; b=IALHaP3Rg/1FcOVq0AB8Nv3jAvC49F02LxI1zgMSmVaFmOANDwwsXtLAeJQ+a9dcpau8ptWqJXk/TxeKuvve/wSDPmffNl45T9qNtuSy5tAx5HNb05zg7iOS1V0gZzDpBoX6n1XOBIQVd23It2CTk4Qn7cZe8q7CvQUha7TJ7sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728563372; c=relaxed/simple;
	bh=AIdK/19ypy5kk740+qy1+VM0qazswZp6OEh+k1uRQ20=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nj7m7lhaRIc6wNxujp8fhlV4b740lwXImejC0bETM8wW8XOJnHKV+DZ88U75N4kxY5OSBhwEZAlXAEvM+PmuUcOYf0SRfmaGendFf1jtf8VJxCSp3G7nw01xJbJ8b6/RdcmEcFGXaAhIXMvOuptCbp+AIcKd8P/pTsFYBhRwve4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f1Qs5t6K; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-431160cdbd0so5168795e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 05:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728563369; x=1729168169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8z7nt9hm4L9Wbt/Qrv08MzgIyMq4q2v0TRMhiPpwzsg=;
        b=f1Qs5t6KGPkrKK6P2zbr3a0ASoPMKLhSVAL4OGLvEN2tIxfhrCMDnH4VzsDrWvUEcm
         Yc5x/cHPQ7oEJZkalYbhnoHYVmyVYPUeVAY471UKa3knF68C0ESduCBMNdVYWGtnAJJ+
         atE4xCxuNzA6/EK7w1PMZzNj02baih3sCFx97R+ohCUaQdsGhr5O0DONdyJ518O3kkKo
         FJwUeEcsm8VcRinKKnT8c88pMJ9sZo99/0UfsqmQBkdKSvoy50Al9AdccXXUyh0P8vS3
         MZdk3qkfqBB7JSBvn4C4fJ0rd/BPsxQmcn6xrz7jpkwh4Yfjy8BbWBUypU1V2TN/a1a7
         /8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728563369; x=1729168169;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8z7nt9hm4L9Wbt/Qrv08MzgIyMq4q2v0TRMhiPpwzsg=;
        b=cCiA4srlOTd0Ds2tC0ANPoMI7BARs+X4rB8++Xkgd9FmOf1Va/K6UUF7+lRcFl9jbm
         pHRM/MoQqZckUgYl/qWCnLndOdJIRJhFzMRBp6/qasArRgkmLMf9zQlPq5vpbL2JDxYP
         uOs0cub+xo9zLNq+yt73rRgkXLaSBrh1Pm9Bdi6+C1UXwmpoNuI3U5+zJRFVYe6Om0ie
         vqCrd3Ct3D+zMxhawl5ge5p/dJkYs62O1P3hEPF27ohOl4+Zo+l6q5mtVMlVIiKDJaKi
         l1D0JjXUMshGWI5Emwj1h/NTfKz4pids4KxDGT//35y+/av6fF+iZqHtJG/AFH9IIu2x
         iTjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnqIpf4dr8xKlWVjobTG43Ynru0fkH+9bi+jwSDpY2z18WwLHd4iuebQK39ZJ1BFmrPuC1EfZuDDGoi4w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc31WScrz5VFvM8loLQqUZDE5eQ71KxJYpE5kA6dofLxwO46Ke
	YZ+pq3K4+0rbssDlAcuTEMySB1ZwH/HI/bXr9yYhXNppE9T8ach9158GWXeF2yY=
X-Google-Smtp-Source: AGHT+IG/EYLHroZcvJh8nma4py7JsMUSVTGtZA/Fbfk2ouXe5EuZm5DlzdbXIS/aNPR+Tt1KWDSebA==
X-Received: by 2002:a05:600c:3ba3:b0:42f:8515:e4ad with SMTP id 5b1f17b1804b1-43115accd0cmr25605465e9.14.1728563368489;
        Thu, 10 Oct 2024 05:29:28 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182d790fsm15127835e9.6.2024.10.10.05.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 05:29:28 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dzmitry Sankouski <dsankouski@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>
In-Reply-To: <20241010-starqltechn_integration_upstream_drm_fix-v1-1-cf3cb1d1ce77@gmail.com>
References: <20241010-starqltechn_integration_upstream_drm_fix-v1-1-cf3cb1d1ce77@gmail.com>
Subject: Re: [PATCH] drm/mipi-dsi: fix kernel doc on
 mipi_dsi_compression_mode_multi
Message-Id: <172856336776.1392280.4931078237815172701.b4-ty@linaro.org>
Date: Thu, 10 Oct 2024 14:29:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

Hi,

On Thu, 10 Oct 2024 13:31:42 +0300, Dzmitry Sankouski wrote:
> Replace dsi parameter on ctx in kernel doc of
> mipi_dsi_compression_mode_multi function.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/mipi-dsi: fix kernel doc on mipi_dsi_compression_mode_multi
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/33c255312660653cf54f8019896b5dca28e3c580

-- 
Neil


