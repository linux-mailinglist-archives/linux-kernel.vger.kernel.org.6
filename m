Return-Path: <linux-kernel+bounces-374409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 711679A69B9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 15:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BF3728641C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9BE1F891C;
	Mon, 21 Oct 2024 13:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r0s1DiTh"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044001E0B96
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 13:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729516089; cv=none; b=FqsYIzAUfia1XrV2BE/lAuT6EV7DhATkEoYpeSCf/wbacjnuReQrdnfpmiaiGC/el6IPKQL+8jFFiUShotoxkizArxP/O9kcd1EXmjrd0nZZKGgpQeUtRPB9U538sj+el82Cb150rLxRiWs4esNTSS8Po9yyYDTZ3KXU1n5UwFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729516089; c=relaxed/simple;
	bh=/bXjJ6SbA1XotQj51vmzoEUise7v0iCJ4D3+mGm5qEM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lNa/WgtpdpAT5igg9aMjRuaFvsfxaRZKqTU7HdQNsnGzQGdA651SONX+258Mvv6Hxo+fPEdu5dU32EWs58q7N3n6ckUHwZKssf2rzl9g+oAaUgTph5ndbNx6dZJ9tCXFbJI5gswAJfMM9huuDce771N6JE/K7jsY5LSNN7bYONw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r0s1DiTh; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4315f24a6bbso36320325e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 06:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729516085; x=1730120885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FtUpr+A+8LtT2m5vyRDBgWkwHEqK1Wfgx4gBKVx1DVI=;
        b=r0s1DiTh2GDEgBJqGcAZJvz3ALvKsg/BYuZNMSSrL4SYSIRAXPDZ8IKVvTc7k/cccA
         jo6BCbXc+w4CgCA6siQ38q7pSVcBodX/w/+F9w6C1kvbHUV9A+XhLsAEk+YO/sKq3Mbi
         54LGXHsRiUtSSi7CLI+QUtdhlQzOONwK0eRNJpf5cFrL/ii4tavXyMqG1lsM4yFnb8nB
         95SqUYHNwtS2TJ5Q232LdOc0JDYwzmJLOYBR4tGFrTaRUnU8qO0jo6yBj4cQCv7h+2qC
         Q/pDqWO2CR/sfcrE5k2Rcj7GzBSGmYdz7Q/mF1fCxfv0BkX9/WeEKMHiw9sLRBiZeRBE
         HrDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729516085; x=1730120885;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FtUpr+A+8LtT2m5vyRDBgWkwHEqK1Wfgx4gBKVx1DVI=;
        b=ookeHFNKKtkuyKN2Zdk4e4M81qk+F+F5BKyGXTe7QK080Fpg0o4H+tUsUjBxekbsrX
         d+57r9a+ecGvVuzyO2lJW0EeNHE9YBfk/P0krMggyQ5ytuCYVIIPrv1BTPw6CZ8mcDNN
         /SLjtTH+U6uHUgSG1cNWD8LmANaqmkKxOL0ABKBqkcUyWiUw149+pEfswrESjDbXBpO6
         WkYy0BvGsnA/67Bn7HdspIIPeJCbD+qtCIot47c0IO55k7AeV7nkzyG3hk36SwThhaNY
         2u6mYM1YomW5BdozjHaP5xkKxS5Cn4eTqVXRLWr/3g+U0OpVRuHnNlYB3TMlGGhOKUpe
         Rpfw==
X-Forwarded-Encrypted: i=1; AJvYcCVPbTzb7XNnIwOKubWI19jWY8t0abpVfpjU63/8pgK3maoNzcfU+OEJtvrLGpzo9YKUBT2h7urkrC69E2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT+jpMbAssbMzBn3RqdjT0RRKChPqJ8j4g3AZ5PuNFY61gGdto
	FJf3h1EOr82HX/oQgVT04sTZ8a9ZK935fXoRs1WDi5cIvkppu63qkQp2kbj7ZF4=
X-Google-Smtp-Source: AGHT+IEipzMV/DPPme98h3B4GD5zXCo8HzlYNMbwlWUDSxFvwffIlkT58hrTwZJo/fDp/R6yYxaAzA==
X-Received: by 2002:adf:f209:0:b0:37d:4d72:dca3 with SMTP id ffacd0b85a97d-37eab7137dbmr7801233f8f.31.1729516085193;
        Mon, 21 Oct 2024 06:08:05 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a4864csm4327496f8f.35.2024.10.21.06.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 06:08:04 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Marek Vasut <marex@denx.de>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241013-tc358767-of_node_put-v1-1-97431772c0ff@gmail.com>
References: <20241013-tc358767-of_node_put-v1-1-97431772c0ff@gmail.com>
Subject: Re: [PATCH] drm/bridge: tc358767: fix missing of_node_put() in
 for_each_endpoint_of_node()
Message-Id: <172951608433.1285208.7143753103186144460.b4-ty@linaro.org>
Date: Mon, 21 Oct 2024 15:08:04 +0200
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

On Sun, 13 Oct 2024 20:11:29 +0200, Javier Carrasco wrote:
> for_each_endpoint_of_node() requires a call to of_node_put() for every
> early exit. A new error path was added to the loop without observing
> this requirement.
> 
> Add the missing call to of_node_put() in the error path.
> 
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)

[1/1] drm/bridge: tc358767: fix missing of_node_put() in for_each_endpoint_of_node()
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/5c23878252515b8d2b86839bd4cb7dea7088aacd

-- 
Neil


