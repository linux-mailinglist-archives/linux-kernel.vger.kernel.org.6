Return-Path: <linux-kernel+bounces-327755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B44F977ABE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 10:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61C77B25B3E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6BF1D5CC0;
	Fri, 13 Sep 2024 08:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KR1iI5iV"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE7E1D58A2
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 08:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726215143; cv=none; b=qgTnhdEu5aBs4+q1JLqppkaeWYf7aWhKJ246Ek8RdQG6k2p7zndlo06nrrEM14fZJMGjrINa/pFFvJlrHMSDyW9cVi53kf9Dc6DVUlFnxHK75GqvLazmJz7jsmdyKHcqPUCgLjNq3xz8AHZGd21vLhj9IMOUigK+KfGzMM1QdTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726215143; c=relaxed/simple;
	bh=hXeaxmc3DyeXngWYscY86rme60s50CRR2a6cKcCFxSw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D1yr65ud6l6atHlb1Wj5jL4re2xrpxOVcixYlrw0zT8cBfYEh+PcpQTIfOnFypiRAvxBQFv0PwBZjrLQYeKFHZZY8zhxBO4l8WtDOYrzyomi+1nCsubmC12UhjlIyOHV74rphWDbqStWaj7/wmXDoya8xkmp8jTcvhWmFErIS+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KR1iI5iV; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-374c5bab490so1884939f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 01:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726215140; x=1726819940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9k9rYJMM4C+oTJ2nVf0030SJZ/ekryk/JdGG7NGdvs=;
        b=KR1iI5iVBqgCxq2sF1WBhM40NrnEvCEzCY+BcgyoAA5cN0Ky2J92uTxRISraB38MSZ
         qvI86go2Rv0M9Jtfkvm6WuRdxynAnPOqihxUKBllDi5IlPvveZlSDtTttVPBC2Kd/u6H
         V5iiAdpd4m2DhJ/uF/aFoWwJxLSNAaEgbNa3oJ1osiiX1Adgno2+r9bC6Qoh9pnWbRGD
         SqzZp6XYA0fIAZjSVLPU0d6UrK8GMK0rHaQUZRrweL6rR3RKBw1MmbDxwCIO/o7fmOC2
         icz+tWW9xHgDhP2tOMqMQq01jBYXtLz9IC2pa0637npV1ZJTNlciXW7L5esQnNVcQ4VO
         3+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726215140; x=1726819940;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9k9rYJMM4C+oTJ2nVf0030SJZ/ekryk/JdGG7NGdvs=;
        b=RjksoxulJnVeDKOKs6Y7gf+euQiLQ1hOOr8aR68bqrvWdUz0zia86xFlUvuN4XyJsd
         rV5lB8tXWxygOafrDLgXCvjIaeGvUgszyK/RF7CuEOZNZUhJkjO7RMaKV6kHN9oK4IZ7
         5Q5U7BWJAskhLCMgKkRDi/P/xf+pwEVfA/VdBXbbRbJDI/V6n1m05vGNQB8GnSC/yTXe
         ioBDCIfcJa9x5FoKJw5jTEjyDQtcLUIAjakI4yCzmo/NuM+RzNH0Jn5dV8RA2ARJ12UR
         q6Ty6sW+8MNkPZywbLdYjPIjxssyXyPcniaKAFMJxUD/oz9or2iKSlR2AOooj2yF+p/W
         0w0w==
X-Forwarded-Encrypted: i=1; AJvYcCWg29l/vMN6Ve39Mb3e21uzZS3/gkuftAGk1pVn5NTFLUN120s33jkwua4XSIb0A7au1I8g4XFWq2QwbAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVhgV7jjlfUOaQhnTDM0/jkfXN9ploImxgJbcGtrXXpyuDi8zL
	8QFmvtFYMidYtJGXMl6vvr1gML8gF4ydA+GN4Xwr6cbhhLxxFwo6Mt5Fa6kEIIs=
X-Google-Smtp-Source: AGHT+IGUnlSGK+OFJ+A4+PSD8enQEtq3Bf6LxAtm0vLDr//sYtSjZ+IjAZVM1wrdWRVB6siwKSkUvw==
X-Received: by 2002:adf:ef06:0:b0:374:c692:42e2 with SMTP id ffacd0b85a97d-378a8a0b8d9mr7708566f8f.9.1726215139924;
        Fri, 13 Sep 2024 01:12:19 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cc137556esm106939955e9.1.2024.09.13.01.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 01:12:19 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Liu Ying <victor.liu@nxp.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>, 
 Dominique Martinet <asmadeus@codewreck.org>
Cc: Adam Ford <aford173@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Dominique Martinet <dominique.martinet@atmark-techno.com>
In-Reply-To: <20240907-hdmi-tolerance-v2-1-b9d7abd89f5c@codewreck.org>
References: <20240907-hdmi-tolerance-v2-1-b9d7abd89f5c@codewreck.org>
Subject: Re: [PATCH v2] drm/bridge: imx8mp-hdmi-tx: allow 0.5% margin with
 selected clock
Message-Id: <172621513881.966490.122670380841730948.b4-ty@linaro.org>
Date: Fri, 13 Sep 2024 10:12:18 +0200
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

On Sat, 07 Sep 2024 14:54:33 +0900, Dominique Martinet wrote:
> This allows the hdmi driver to pick e.g. 64.8MHz instead of 65Mhz when we
> cannot output the exact frequency, enabling the imx8mp HDMI output to
> support more modes
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/bridge: imx8mp-hdmi-tx: allow 0.5% margin with selected clock
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/0d4b950e03fb1c1873c51916fd01ebafbbc48222

-- 
Neil


