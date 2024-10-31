Return-Path: <linux-kernel+bounces-390333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3F59B7884
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 11:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FFF3286CED
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 10:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B51C199253;
	Thu, 31 Oct 2024 10:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x2Vmo253"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78E5196450
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 10:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730369890; cv=none; b=kGp8qgYXhAbZ3a/rvOC2MdiFgd02FX23BjyKsNbHizEIiVCW8wiUZN+sEI1M+PzsJbOCX6lM0o33sOihE99y0obWfSpySbC3jeG6ZXZwHDmP5a5NQE2UqWKFGxD64AZJPs4kFj5Ej+V4bTGIrVeS8FiTxJpYRKkZj5O9gFKdG+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730369890; c=relaxed/simple;
	bh=lss0ssZFSERezwXCbaK4w+WH9Plx1mfahBoDf/KoKYc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VmgIIPbn2f/FbNV9UodHO1QK162cFPzqtIz53Aoqs7pJ8A+2VrVt5JQsVIuwo2fh6nFtq63XbOO8kRyhM8Tjucwb7B4KUY448juGP+Q6BJtsModROlfzI1i+iRIjjLpIoClf/qkq8cxtBKDMLPC9ZKkXMUIpfu3gfJpsyOVEVso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x2Vmo253; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d5689eea8so486187f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 03:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730369886; x=1730974686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++I6VqJCyRbg5qV5kQRdcBUHLFkZ4m5nL8eAAwYYm6w=;
        b=x2Vmo2534DL8c6NjicA/9ZizHLer5FXlzoWaj232l402e6Ma+U3g4vpqY/xtNX34UA
         T1JhAIFWEz0dau552zmLNJFgN3tYmieO/69woVrW5JbP8rf9w7K+u/gsiIR2ar6FfsHe
         ycUS8+TtLqNBkkb6kK6FyOMQb45l3sJtpz4XkWSKGyPlofnZpGHCO+/ZhtoG13e4+8uz
         65m8pa+BnewUY0ghicheB/FBs5mpMX0xUrs29FXUTGS5yt0U/aeQyy1KkHnFDS+CdFtg
         9JO/UqbZOAc6owp3KhJPeH1jOf5/W31bFzW1gC9Yunboap75THo/AMhPNnMD5DiK+eJW
         lvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730369886; x=1730974686;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++I6VqJCyRbg5qV5kQRdcBUHLFkZ4m5nL8eAAwYYm6w=;
        b=hjepFLWim+l5IqIho+9BdBR8uaRCR3nz6GPa7PwByMZtbEI1WdSPCJOs2Xiyztb4I8
         YxksaSg8eTGlEFc+rxvSLqrQ2Eg7Z+c3bJdRMzFJUt0KRk2ufdSXyTx7yXHetk4DtZD7
         TxfjlUzqSyNK55Z4S7hHut1+x7+EmqJ3xA2Lte6K9U4m4BzGj4V6hhUhjqRjweGsB9P+
         ayarHxsjmXPfAW4R3QtBZtJh1pK8x+clcmYuH6TU9I/Oswza6umF+AzTlx7DqzDsYl61
         X79Vkzc5e8oY5HjRz+lfMVym6dDl1HcjEkoEuFEs7hHvN194WoAP+TdDhlIDoVEbASOn
         nkZw==
X-Forwarded-Encrypted: i=1; AJvYcCVNcmE5oiVrm0dmxDy1USomZ6y6Vp8nSh1YlmyqBT8wiqP7oWI4MfropEUOZXXLUH16MDD56YTDueAcTV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMGKn5WM9CXbH9FgU5SxIeKbxxCPcXf0bpB0MXbHzKDwypzxnO
	G27e5c/XhiiudcN5I6S9rgFFna85smN6y/xwkmAIcgHJUR/Rw+mirk5M9xWWvBs=
X-Google-Smtp-Source: AGHT+IFCRLPGtIPF6tRE2AyAxQDhAyV+0h7hIFIEU+Nh/dwxW4Kz5xoW31kwwd/rlL20IjNGyEPQhQ==
X-Received: by 2002:adf:f5d2:0:b0:37d:4afe:8c9b with SMTP id ffacd0b85a97d-3806122165amr11957339f8f.54.1730369886249;
        Thu, 31 Oct 2024 03:18:06 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10e7449sm1678420f8f.49.2024.10.31.03.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 03:18:05 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 Tejas Vipin <tejasvipin76@gmail.com>
Cc: quic_jesszhan@quicinc.com, dianders@chromium.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241026035928.183454-1-tejasvipin76@gmail.com>
References: <20241026035928.183454-1-tejasvipin76@gmail.com>
Subject: Re: [PATCH] drm/panel: leadtek-ltk050h3146w: transition to
 mipi_dsi wrapped functions
Message-Id: <173036988553.2180741.3119878414360083645.b4-ty@linaro.org>
Date: Thu, 31 Oct 2024 11:18:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

Hi,

On Sat, 26 Oct 2024 09:29:28 +0530, Tejas Vipin wrote:
> Changes the leadtek-ltk050h3146w panel to use multi style functions for
> improved error handling.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/panel: leadtek-ltk050h3146w: transition to mipi_dsi wrapped functions
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/766515ab5bba959fc8036e77e875a672916ba8fc

-- 
Neil


