Return-Path: <linux-kernel+bounces-316269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C781996CD56
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 063E81C22108
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A8514EC71;
	Thu,  5 Sep 2024 03:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZRh5Rf3w"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22301442E8
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 03:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725507224; cv=none; b=DT7N0AvYWc9Og/yIuvRE+zrEtIDE9dgG/RD7xbarn5rPuO5jEE1UZIGqXo8wpRge1jQzZrnyT8vS0qfzdxtnRaPGjfGuz9f8NSSv1utumOJJ//e5Hsh6FDbLlkwHi5BINfE+/bQFKtWUWCJXHJt6x3kU/qrSlXPugYANwgLcof8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725507224; c=relaxed/simple;
	bh=3uylGRMnMHHB5thN+jMPYIiN8sybyqQguQ60rIY0wSM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aCQy5JkeX+uvTxJNOSYZpbl1RM/E4pdS8EaPZPXbekV+3Lq1GTWtcuIvyOsyca0Hj9haEB8sKtbZsDAi7tD9H/+0qYG8FKCK8IUy8mCp/1XCGWypvxAhvTq1HPN8Fc1Q1CVj/RyL4G223kj3HtJxr+036eufO6kSz5cDFV+3bns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZRh5Rf3w; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5334a8a1b07so201803e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 20:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725507221; x=1726112021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aqec3x8yKQ8GNkqH8zbywynntlgO/egZS4W8KKVbNqw=;
        b=ZRh5Rf3wAB4tkLXY4X7Uhs0UC4eR2ID6HtSE25iuBF35x9AJp8F73UCaKtCkfv3jDN
         WLZMHIVd1nJEzMOPjDbLFwzHMTuu5L1kFOfANc2xMnbTJoyKBOG38pypjM+gAD2ijbh7
         Rsaw1wTLXdBxY1PLqb1Qj8gAXuJsEYr4J9aFfTRtmWsr97CBAPJT+f1vMFCL59WxJfxL
         tWe2XUwryLQdl0cYkzdzLgfQo2Uv7piBDud83TexU26lDxA9KmIaM0cfK8ap9BVhUDbi
         iSsBw6rCrbWBVgj3dXuNAwR43ZHwzfVyRDToGDp+i7kx1jkS2qPdkx3Yhn0Fa0kyej0l
         jbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725507221; x=1726112021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aqec3x8yKQ8GNkqH8zbywynntlgO/egZS4W8KKVbNqw=;
        b=RETB1Clwv9z8W7YaQEP2630wlQyWJSN+IHpkeN/kwNK1jPjdJJqP7egYrHoEK2O7rw
         c3z/8nrL6MpeBsH1plyCoP1jOnwpGJrVr3K8lYZ5LsjgMO8Ow73AAnRW6oUtkz9Aftx9
         7pt+fzJVIWiga4LDyg948Cg63//9kX9P45Fzqs2qonj0hgAW1KEQhKxA7csU+BzqBAKt
         Qb3GUKDmAQhOYlGVquMYnkrlTYHcOf/2C5xVfMUCQqYs4QiNEfyuXnywLCtvEX1K4Yw5
         z/Usqs6BcEvcXdylA5y2YVJC3P1gmqQJijEiZqKPeY/7qzt5MBzgnEw3SijCFVcg9S6q
         uSgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJkrRLHsXVuqgxjsB3J0jp0owyhqvkILse9WQ6/zFAVdfG+z8EmB8FmOsyIkEesJc3sdUuJHXxrNkLy2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9eiSfqMfcYTyYamZI9db177GVOw1I/cn40NXx3MDmkmZC+2og
	RQLmRgYLhRj8eQyBPFKgNwzbGaQBCwlpE0k6i7oraVMB7Nh63ftI3g51bEsdrOFIa0f2hSNSBPm
	R
X-Google-Smtp-Source: AGHT+IHwr2P89i+YoHLpfciOuqT/Ni+vf4PPY9+DaJVEGxa0pgv2FB8yOQMf3G/eqwSKdCDS2nyzfg==
X-Received: by 2002:a05:6512:3e0d:b0:52c:f2e0:db23 with SMTP id 2adb3069b0e04-53546ba07ffmr12737991e87.40.1725507220865;
        Wed, 04 Sep 2024 20:33:40 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53565f6d409sm389165e87.35.2024.09.04.20.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 20:33:40 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v3] drm/msm/dpu: Configure DP INTF/PHY selector
Date: Thu,  5 Sep 2024 06:33:34 +0300
Message-Id: <172550712143.3299484.13998129049671917393.b4-ty@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240625-dp-phy-sel-v3-1-c77c7066c454@linaro.org>
References: <20240625-dp-phy-sel-v3-1-c77c7066c454@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 25 Jun 2024 23:24:58 +0300, Dmitry Baryshkov wrote:
> Some platforms provides a mechanism for configuring the mapping between
> (one or two) DisplayPort intfs and their PHYs.
> 
> In particular SC8180X requires this to be configured, since on this
> platform there are fewer controllers than PHYs.
> 
> The change implements the logic for optionally configuring which PHY
> each of the DP INTFs should be connected to and marks the SC8180X DPU to
> program 2 entries.
> 
> [...]

Applied, thanks!

[1/1] drm/msm/dpu: Configure DP INTF/PHY selector
      https://gitlab.freedesktop.org/lumag/msm/-/commit/be3415c620d1

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

