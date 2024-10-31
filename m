Return-Path: <linux-kernel+bounces-391443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A22AD9B86F0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 00:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D0E1B21F18
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 23:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528571E0DE5;
	Thu, 31 Oct 2024 23:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cI8nZhkJ"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A791E1A12
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 23:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730416674; cv=none; b=upu6IA1yMTD1sDvW5/sbdiHaMMcFTyCSOWfTGnsnJewcJkdM6F0uZZWE7c1SMtKxe1UQ1fbiG/d5452KDThi+OaT4XngBDM9iz4dY94Qskm1z3vkm6zKdK8ltCT59/vVKzDeEkZ7egJe5D4+6N3ZlAkWm/QX/su/1IfB4QTARqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730416674; c=relaxed/simple;
	bh=iIpPnqL50A/jarcK5/fv4DxrO6sb+ob1MtvXevZUq04=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qm7cXq8wC+pB4iEBB8M1V9H9DZZkBZKbAx+jcfMlT338PYT4R6Um/JLs8ic1sWxTdCZYRnF554wZjIZeJ6VPlcQasV3/JFCkYJAuTVRip9JXZ0g+SZVb0N/M5+2reF0ofXUZ3XDiu/UNanb7a3bUKK4EVP5fFrbA6v8+oYHyXMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cI8nZhkJ; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fb58980711so14068521fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 16:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730416667; x=1731021467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frsp46Okfb5QiVmFNAXVWYtRI09WjPuac7vIqiSQUO4=;
        b=cI8nZhkJXSD23lR0RpW4XXpm3jDRZAZVp/+CehJI68wKvUzJuAdC9h/4F2gEz5+R55
         ANtzqDEYbNA+6e/0fjeKvgUI+AGdJc4++pN+9BrkJ7vcHC3BGvGC6jXRXXKZ+3s9BRMS
         KDvO7MzCctklT6NG2kR6ZwYH/l+9utQ6uwmcztG0uyykz/5QUR976jI5xxzPV58BwmPn
         AktBpSZ7E+F1ZH2BhPtzsN2xDwi7jhEuWGcBk1aiT1McaR1X3VxdWkto5yijd5CBMKgT
         ecBEKY9QAGV9NFYCobpv9DRxi7sX6nKlKf0td7buuKcYpL0Z/hR6jsqZrTWMFoxdVyiR
         9B8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730416667; x=1731021467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frsp46Okfb5QiVmFNAXVWYtRI09WjPuac7vIqiSQUO4=;
        b=nuSp0PkQM2CR8aBGHhErCjEmLbga4q2XAuKvCEU7jjv6X1+vi0XN5bYeTmiAEjPrQq
         0hIeDNf3hTXItcwB+qpR0FtvcssH4iorh9arDXxygsWIA4m8ta+GhZjh8Rwb2jPj+PVw
         gi/e7Rq4hS0hAslMVYOAKtkn7v7NuVJqTlshD5VC9sX5iFhNvxmPWjZI3Rgiwt1NHHeB
         clSRQgmGaCyxsqVWQcRoGmSva8mx/mvt0wgUmKNY0eEVqx37zYtsbSmloZ/Gq5aP5WK6
         jciJKLCuhrUB0utauqkIh3mciaTwy37ZXf+5pQWkZIWvLv767J86e/gPePO2qa6CRaqy
         OuzA==
X-Forwarded-Encrypted: i=1; AJvYcCUPeCxU14ekz3f1a/jtxLJmZerqcpoTCEq+kZeBw1lTtitPEKxs7XPGd6QcLVTR3bW4BdXnFzlk6xyqxeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwetWBBp+h9VUVXolx1z6JbYkqlT7C0t0EVOzGtTrsawlhIu55x
	+hoJJfhEa7xDgAmQ0YQ0aVYVNu8C/5f+tyEOlbYxz88aP+ds9uVvCtRkJjKEKsM=
X-Google-Smtp-Source: AGHT+IErIn+8tk3gc2319GvFqnOquZWc1mPt8zpg0mrwwWOluM01t+jVj4/jowjH3KFQAqp0pQvtuw==
X-Received: by 2002:a2e:5109:0:b0:2fb:4428:e0fa with SMTP id 38308e7fff4ca-2fcbe04f435mr79462881fa.36.1730416666587;
        Thu, 31 Oct 2024 16:17:46 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fdef617ad0sm3536041fa.67.2024.10.31.16.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 16:17:45 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] drm/msm: minor msm_drv.h cleanup
Date: Fri,  1 Nov 2024 01:17:41 +0200
Message-Id: <173041664077.3797608.17754324846652823290.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241031-dpu-move-topology-v1-0-8ffa8122d3b6@linaro.org>
References: <20241031-dpu-move-topology-v1-0-8ffa8122d3b6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 31 Oct 2024 23:44:05 +0200, Dmitry Baryshkov wrote:
> As I stumbled upon msm_display_topology define, perform minor cleanup of
> msm_drv.h incldue file.
> 
> 

Applied, thanks!

[1/3] drm/msm: move msm_display_topology to the DPU driver
      https://gitlab.freedesktop.org/lumag/msm/-/commit/f8706bff68cb
[2/3] drm/msm: move MAX_H_TILES_PER_DISPLAY to the DPU driver
      https://gitlab.freedesktop.org/lumag/msm/-/commit/858b64e21217
[3/3] drm/msm: drop MAX_BRIDGES define
      https://gitlab.freedesktop.org/lumag/msm/-/commit/26d841fd1c15

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

