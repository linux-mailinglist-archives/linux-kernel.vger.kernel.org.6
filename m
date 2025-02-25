Return-Path: <linux-kernel+bounces-531058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D855A43BA5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702D93B9672
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DEC267720;
	Tue, 25 Feb 2025 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TgQsTvv3"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5043266190
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740479142; cv=none; b=VZFoX9tXmI4QbXE2Usgst7ljCI1G/7D1Gc53LRZyYftjLRNgjnagsXNBsKYO1XulHiqQVE5CIhnwvS/SZTZmUfGZci3TrCkM/6qQ+xxMqMOsURvL16kr/SNiwGw2LigsbFG25JN3A6FWgomS0F2hwLdDKMnHOJWqbDYLX15a+gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740479142; c=relaxed/simple;
	bh=JXUEw/mTrCXp4uW0hpKJGSmWwnmo1L+q5KtrwP5O3eg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DAJob8B5EkfG1jep9xiUMA5vJ+fycvJIl8rwvwPVG4vBVbjrOdVey51QLVBa9t+zH3Ea3WB54vSY0+4MZ80DIXVbMEv99Od8VHjM8kBNDPCmRI/Jpqo6YzRE631lFjrjkPYu350r1gTCsdsdoAtvDE10mHlzuQ/H4wEChWgHvvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TgQsTvv3; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-38f6287649eso4250935f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 02:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740479139; x=1741083939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GO+8glDRZ70FolfJHUuyOyuSWWMeXZ0930x4j7bHw1E=;
        b=TgQsTvv3cRqBC82p71ZQ91uUgLlbelNFKPdr1tURFhGoEGqGVn0qHgaaSm4/AS0G5R
         +ClpAg3vpj55o2Je0Zhu+RjS7UHLoWsTYRz+nUkOMrQn7C0XY7BV0T025OihuqmuTNLk
         vjyWrXNxVtiB6OmLlR+9K72KX03IjRbjRmYQSkVomo1dbEV1buisH5AlPf9LaiQwJb2T
         TNoYLatkL4C+ea7LFpDVBXRwKQXvAIpaWsBAxekJJG6mISWdPncl3pKgauJ/TKsSKfIG
         CV/X1o5ra/b2lX7BhPbYXu6ko+859OQRV7y3Lvgr55oc1eyI20m2JpktU21qan8ssgFU
         E4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740479139; x=1741083939;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GO+8glDRZ70FolfJHUuyOyuSWWMeXZ0930x4j7bHw1E=;
        b=AYA7i+tU8lXAh+3bgNeSIIdGYDIzMMVTUDFGlStU9o+DwbOUPXv8imzahwxQf++jPx
         B7dXGAmBsuQJQBvGG9X11ayB3cg/E2tySqN/wOxV8PxV2UeBWULnz87FOM/QbI6UbrEv
         KkalVGpMlyilQq8izBtsZTI6nb++gxmQnVvc1Apuujr1RTO/stkpZD89d6KDP0hBQ1Cy
         99trw0NCRuTztZH+cTw+sZfn3/3erO8LDa5OVm7Y8brVgCpApvk/gtrCndLj/NjmXY9o
         5filtCMjlBmdza+QK+e9T0pazerhFKaW3e+MQcRlejIO7j6E0Q5H0gyvdVdkLPoE/wny
         pGkQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2ONtxb9Eh3fHLNOzRGesWs3rI/4AuxIU/vW1WVS+Vi5X+ur+jMNkortBX6Bo7cQYjjy/eQGsg9b9J3nA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDobvnrCyXQtrZuJIJjlU5vv16TuwQ7ZUzUR4vwixJulAgItxE
	qLHC+8UDwo6Emy93sAB+yAhefTX4gu7f9uiCuwjSXyl+X3+Jn8w2d1jkaIH0gaE=
X-Gm-Gg: ASbGncvGigfZo9o5zM2DrhY/C0aEkd8cNE3Wffevp55JwebbDzCceojisJ4ghGQtpro
	UHWZlnWebSgJm+mgORNVn3kv56j0z8JhUiz0uPHE1/UV/zcU3sNz8OY6f57DNBBycw62FpZQTl4
	8PCWh0VHjZ0naTxzwaNOZiBMyP6hUmc91ckJn0N0CVAreFXsV7F43lGS2yicUOrrAaKJcjV/m8y
	HJQfMYGyvaPc88W4f5EImiNP8RIMxlrlOdEOYY4ETDqu/1bex0igYb1Su1WQpyL8wh6D8THwNtC
	WuLRysVkNaqcI4d0It3TzjQUM4vk8P6+keSNrAgLJlI3sTE=
X-Google-Smtp-Source: AGHT+IGCJja0+bBP6yFXu5tgG751wKC5th2J7f0lmxV62+z2DFSuW2JXXrH5OxE79sHt4myCc7POkw==
X-Received: by 2002:a05:6000:1a86:b0:38a:8906:6b66 with SMTP id ffacd0b85a97d-38f708267ffmr17605833f8f.38.1740479139095;
        Tue, 25 Feb 2025 02:25:39 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86707asm1764378f8f.5.2025.02.25.02.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 02:25:38 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, asahi@lists.linux.dev, 
 Janne Grunau <j@jannau.net>, Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alyssa Ross <hi@alyssa.is>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Neal Gompa <neal@gompa.dev>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20250217-adpdrm-v7-0-ca2e44b3c7d8@gmail.com>
References: <20250217-adpdrm-v7-0-ca2e44b3c7d8@gmail.com>
Subject: Re: (subset) [PATCH v7 0/5] Driver for pre-DCP apple display
 controller.
Message-Id: <174047913824.2131221.6545389561298332217.b4-ty@linaro.org>
Date: Tue, 25 Feb 2025 11:25:38 +0100
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

On Mon, 17 Feb 2025 12:39:30 +0100, Sasha Finkelstein wrote:
> This patch series adds support for a secondary display controller
> present on Apple M1/M2 chips and used to drive the display of the
> "touchbar" touch panel present on those.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[3/5] drm: panel: Add a panel driver for the Summit display
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/40115947b59f2ca361a47615304dff0a2b69a2b4

-- 
Neil


