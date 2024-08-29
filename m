Return-Path: <linux-kernel+bounces-306748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E419642E8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 13:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C54671C22649
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 11:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E08E191F99;
	Thu, 29 Aug 2024 11:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jgEIPi9+"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBE9189F36
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 11:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724930550; cv=none; b=jIM/aartXQLG8+/K+XRT4AYyo/hMv7F+NY/TecRck2MDaBlgGDbKmT5Jm4HJ3OCMEqLKGqn/w3s9hFvAfqkUk0ocs4K9jEXlskwkxlFz7fIYGHJ5GeKi1E0AA6HF2/AfOLVdiyGj+OlF0/bYArtltasHTsIawMDZ4St1dz+/KQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724930550; c=relaxed/simple;
	bh=m0zGPee70htKLNG1aroZHLqSMeK6wL0UCCQrWEPQUg8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=noPNTUyyDgF9izBxiT3cJqDTTsp9iLEHUKfBX6m/WYOwO29u3KcZQ1r8rMI2DBjDKR8Qt5ObzmQ1+p+RiuTX8tr13wzbQ/tQq89DZ2O8dwSBV0DHPtt+K8aqiDpPvM803TxC30DZEbXg/rm5ScltMF+ah4GYEspV2dWG7UiFi4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jgEIPi9+; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso5078255e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 04:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724930547; x=1725535347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGUXNcN04Y9MaZPBhh9adsoWjhrmOFV1DxQRKRls/NY=;
        b=jgEIPi9+qFUS+ShoTtkowsdXAKBX/KXsrrHIHzXjcU9KPdGzLpPwiwYwpCmZGjRS4S
         EcxrXsGOD3IHOv9A4RpvvjWyIUGuCvS/NsBEgBmc+mgGdtfJxaRKIZnCmp2TcviJPn1Q
         3OQo5gQq5+regr+A5eBl9KAzBzjHr9UMVWkzZlr0KRIp+bu6ysxxFzSSQxaS6KnMEKM6
         fWk1Gl+aAKDBCxJSEuMRlLblS6GJlPBLZuyjMVWbpqr4uw0N1Q9agu3VMqeAE9GZe8AO
         G9TqV1BCwN8FglA7tewY+iSmpjI3VyDUnaUgf1MakFqtwvosY+CDwov50m6rFV0zrbnx
         yKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724930547; x=1725535347;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGUXNcN04Y9MaZPBhh9adsoWjhrmOFV1DxQRKRls/NY=;
        b=loxQQTdMz09kVd8t24R2Fg7qIpKYFtQboBfZesAVD4qXGVF9k8p3xfVicXdQwiCirR
         qNW4dDEoiW9xmyhrFI/Erk0Ub7R1b98iBB9NYUocgFjLVSAQvNd3GlRLNngr8ZGS83z6
         2QjV1bnECYwTErb7VdRZC2/z3RlIfi3r03mXiR1skOGCaGf4uVHpeYouVTrXCfWxA4sE
         0imVCd1Nf+nY3b7uavhfYwWjHyqagHDO+tkPpIn2bMWOrpuBivkR9kGxD6Vu7RnRILra
         HY63gz/w70EddRbt7jNylDV9yruUXO08qpx0g9otqrXnlXdPfRfgBUGzDw/h9aGHpM0Z
         sTsg==
X-Forwarded-Encrypted: i=1; AJvYcCV37g78JBK7txfUOHtFVTPeSKwi1R08sVBzD30nHhWngYgVn8LOKp/th8M7tHaapM6k90rl70oyUQCwXsw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Pe3dIE1w9cafLVRhbwB2RIXKigqfZlQ3ZiB/3Ix7EwSDCmxa
	eJhCk8sZGDQjFOPPOXyW/nojmt7N6/g/aweMN1q7d09VPPTMlIunvclv+LiuKZY=
X-Google-Smtp-Source: AGHT+IGpqUMCzEBAM6RTehWTEXC3oIO+Obb9EuLNoraNM2SjW5aJQ09jYdcjL27yffI4QE1CzaO0TA==
X-Received: by 2002:a05:600c:3b97:b0:426:59aa:e2fe with SMTP id 5b1f17b1804b1-42bb01c2071mr19975075e9.19.1724930546877;
        Thu, 29 Aug 2024 04:22:26 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e33d60sm14122015e9.43.2024.08.29.04.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 04:22:26 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
 Abhishek Tamboli <abhishektamboli9@gmail.com>
Cc: quic_jesszhan@quicinc.com, skhan@linuxfoundation.org, 
 rbmarliere@gmail.com, linux-kernel-mentees@lists.linuxfoundation.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240827152504.30586-1-abhishektamboli9@gmail.com>
References: <20240827152504.30586-1-abhishektamboli9@gmail.com>
Subject: Re: [PATCH] drm/panel: nv3051d: Transition to
 mipi_dsi_dcs_write_seq_multi
Message-Id: <172493054606.1145269.2440128121534341021.b4-ty@linaro.org>
Date: Thu, 29 Aug 2024 13:22:26 +0200
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

On Tue, 27 Aug 2024 20:55:04 +0530, Abhishek Tamboli wrote:
> Replace deprecated 'mipi_dsi_dcs_write_seq()' macro
> to 'mipi_dsi_dcs_write_seq_multi' macro in
> panel_nv3051d_init_sequence function.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/panel: nv3051d: Transition to mipi_dsi_dcs_write_seq_multi
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/bfbdf72d6c145e008805f0745ff79f9b8e301e0e

-- 
Neil


