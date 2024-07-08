Return-Path: <linux-kernel+bounces-244385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 730EA92A39D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A47291C21472
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 13:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CA7137937;
	Mon,  8 Jul 2024 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BdQ3oy5q"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66AAB665
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 13:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720445268; cv=none; b=NIfa2ZUZouOXvKHjpxXZFffREhiPFMatdYuIynjASjkFMsGcTu5sgo4b++2NNOPeQLzuljnwV+yu3aHunV0Qt2zCPATWGfvhjXa1wE6tXAQ1L7t5kA5nfzPwdMCbVS70OwrAnewqzTowU6SQvUK0ugfu9frJBSiHMu9ROVKkdNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720445268; c=relaxed/simple;
	bh=73VJ3oRcmaW0D5gYS80xsbaqZzrj0Skp8XVKmterxcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sl48mzN9+VvLeaS90RHpaoGtY5UA0vAQkQ/Ie0z0PC6KKGC4CoeEbGhM64+GLUPGRtFL4x6Q2Yt5VnovEOs4HGmSkNoh/ATY11290GfIefW3SLDGcb55/9PhhlvRqBRu1/nIvY1ZKVZkb6q8KH9IrgkGw6mNONDOQlscY/teZW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BdQ3oy5q; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52ea2b6a9f5so4071291e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 06:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720445265; x=1721050065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLz+pzXsJ6l5mFHOSKbiVfzHPETHq+grSYLHo5ZTzRY=;
        b=BdQ3oy5qEq0qxFqbn8H4lv0fEa3N/ifQDFXJHNu7yukbPyHsgP6RQxGTjwtxA/h4cr
         uE6kotKekGO8KR8KAF2wx98aMw7AXYvrcjBUJTR9+Ykb3prOBSEMwAjRwgf68A8JjjHg
         E1clGTruQZcETw+VUEhKBmxHMx/nD2W1OLM7rwsySpfbH3TS8N8Dy2BtYzwidKdh6W3i
         cRms9vw/iw8Sls3OXlpKltVJbVI4YNIp4ydKXFyMjKfPHH7nx4xIuoIEaXqIhNiyc2hu
         /7PZ5GXVB104HzwFnrT8BTrDlbBRNDbr77xlCQyEnqFI2u1f96Ke+1uWUHP8BQhzvAlK
         k1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720445265; x=1721050065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLz+pzXsJ6l5mFHOSKbiVfzHPETHq+grSYLHo5ZTzRY=;
        b=hJ6pIBU5ZK3hKGV9jFAc+JLkSWoj+Chld8E+d7lqdfwFOyYueC+vKOMxfLmBMt/FzX
         sk297twwRZ3nEspcpBTUMVKjjq7ZvNFMA1uKI1cMjwiFGtspb3fAWbeOmEIRnBOdjfCv
         MAaYK92S/2dD1m62Ugfpy/vtEnWsPDTh5ySJgpuAKmvEFOqej0Y+wb/HS6K7Mf6OdelW
         g8JuKM10MZISdDNLni+xHTKd0MBqa6lRMkcJS21CdOqezYG0fzpkPxGIzgiU+nAOQXdy
         Ju9Wtp2Vaczz/8YtndhKYr3ncZ+aTPSkQevH+6SMzBV9Fp+cv0xvUbwo8Qc/xHo6FBA9
         CVvw==
X-Forwarded-Encrypted: i=1; AJvYcCWSwCpgOYJuCUMyMdPPIwpIkw0Tz03Ld4zh0pIHtPIsHfQtvD/hXIHqWPJimnsuz0rFjtJxQPa2pQHP1T+1YJOUbPXLPRfuJ7ECoVbQ
X-Gm-Message-State: AOJu0Yz3w7XQ0H+yefn2pOyD3tpEB7zr1jQyR3WlJ0Zhm5pF4CCbouC6
	TNKz/gh+enQVztwIK6JguSwgsQk1wrtPRuvA/EFJFY5qh5Cud7JU3MSM8qRG/1Y=
X-Google-Smtp-Source: AGHT+IFzFef/Tv8RS12QfjZA7cDHgbrsywJxw7p2DpGff9CwZ0w/u5TnUJ6q/+bCZgefSX1bAM+WBQ==
X-Received: by 2002:a19:c204:0:b0:52c:8df9:2e6f with SMTP id 2adb3069b0e04-52ea06cc913mr7432147e87.42.1720445265038;
        Mon, 08 Jul 2024 06:27:45 -0700 (PDT)
Received: from eriador.lan (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ea910a4b8sm728047e87.202.2024.07.08.06.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 06:27:42 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: dri-devel@lists.freedesktop.org,
	Adam Ford <aford173@gmail.com>
Cc: aford@beaconembedded.com,
	Liu Ying <victor.liu@nxp.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] drm/bridge: adv7511: Fix Intermittent EDID failures
Date: Mon,  8 Jul 2024 16:27:38 +0300
Message-ID: <172044524823.2537680.15499072146875099672.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240630221931.1650565-1-aford173@gmail.com>
References: <20240630221931.1650565-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 30 Jun 2024 17:19:31 -0500, Adam Ford wrote:
> In the process of adding support for shared IRQ pins, a scenario
> was accidentally created where adv7511_irq_process returned
> prematurely causing the EDID to fail randomly.
> 
> Since the interrupt handler is broken up into two main helper functions,
> update both of them to treat the helper functions as IRQ handlers. These
> IRQ routines process their respective tasks as before, but if they
> determine that actual work was done, mark the respective IRQ status
> accordingly, and delay the check until everything has been processed.
> 
> [...]

Applied to drm-misc-fixes, thanks!

[1/1] drm/bridge: adv7511: Fix Intermittent EDID failures
      commit: 91f9f4a37124044089debb02a3965c59b5b10c21

Best regards,
-- 
With best wishes
Dmitry


