Return-Path: <linux-kernel+bounces-444567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E37EE9F08D9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 10:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A78282C66
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 09:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E691D9A6E;
	Fri, 13 Dec 2024 09:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KS2A63yM"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB331B4145
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 09:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734083788; cv=none; b=PpYbhNPUBJc5is/U4SQ+qJe0la7KFJPYhmRHa4PMFq1CxOgaAOyhKA4soVpROYBvMDKAr5U6zutswt9fDAv2Zjmg4vuB1ciSEpKk7YybuBaIfwzY1ho3q/YHVaquxJbgsTVPUlx+qyr8stAdw00t2BYBR5IBLq6FCnMgIODsnO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734083788; c=relaxed/simple;
	bh=HB9RgK2j0duAp6et4ULahwcRO90hvwy8m9fPfUdA3cc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ORCmFC2PpDn7PS7Bbp7VAgZD/1qpEkBtOrjs45NPz41swvy55kRdVgJk4llQmjJEz3hPQ4ETnF1v69j+GIzUn1oBcY9SE/aaPADJ53DTUu2HtUVykb/zTygLy1ounqn6EuOcSlFYOm7GImYH2/FNxga0S7gd2TKAb8ErL/2wgtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KS2A63yM; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4361f796586so18391945e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 01:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734083784; x=1734688584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYSMFonAtajsalSyV6s6zrr5Tp5ZtyTuddWbfCnVYjA=;
        b=KS2A63yMvi/cygUv4xcwjcJfMofZrSaUE0hGJHQCVvmt+yJRAFf0PxR1jLiTVdjooD
         HRJH2RAowRzP25vXlt3RROprZUw7ve/muE1RL3FidnkVemO961J0ikWYHGUix9MmWj1e
         H2RhPeZVhS/S4gyRJ3aBzEw39BNy6jXw6lUs8KpuIUVDYiumq/PfClqRH1NfJlk/mkEN
         ywC+PpcLeg5Gy0u2Y3WcuBjeY0EEu+0dxEQSGlPBA4d+Vwz2HFV4SABkpTDtDwV+311C
         IILDtb5zWSTag3LAEpnfP35cVcDqv5weJ1rKE8eehQ58xA8uKCKiEDrkPbVxzWsqp656
         EbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734083784; x=1734688584;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYSMFonAtajsalSyV6s6zrr5Tp5ZtyTuddWbfCnVYjA=;
        b=wSuaH1Y03K5uiHh3w5W/dJmvDbsRpU9gY4GbNLVbMUa9Uy6XJ8iY1cJmE+TMXnyTfc
         DAvY3HF4sGBXkUjMuu/mOiwBgcNkD93GA0UcO7KXF4APK4/Iz0Mxs1CjeC9N+X7InOZf
         zqW8VqP09UtXX6h7GhV4k1NroQFM//WCAYm7eUCbnyuv+QUpoPTFm3Wxg9Azbb1n3thc
         8XRdnYjpRQ/ECQSJciGSUiqd9sTG4ltgjo1Ilkiy+V//VzVUg6JcfBWzCJP245fZfT3z
         49AVV4S+ccJ6UfIK2RL3afiG5/1Ou+mOx6eh8zNpJHqSQIGSuBpGLFJE4MVknkYHVmyq
         tquA==
X-Gm-Message-State: AOJu0YzfozR4ZniKPn8bqMEVDp7Mpr/NP7H48RZvya4DQTGeOQykKrEZ
	DmojLQ3AXLZ1Zg/qd5qbQ/u0xRr5HbTUw76aadolrweFb6876tapCZ5jRcpeB+g=
X-Gm-Gg: ASbGnctnOC/FbGFDhTUDyDCfM6BNX+3OslOf9zxwEVVZYrS2A89/LSApTYvEEBcs5nS
	HpgZf/h4uSxIATohDhwhTgFeRfCmGwCW/4k69ncKWeIwvGWFIQX2tKsCAbpjKApLsAlI8OP1j8q
	aQRtGT4k+3eOycqOhPQ/nb35OR1wYcIPWnKAmA6cBkbGKveeiO4ugsUmcd9TinPyL1kBpJYZqH5
	Q1zDZCUY+chwAEJbpjAxYbslP2zxBdwzMlcGnKvYyJj85R6JBJ9Qbt1x6SfFluHKmyVzAN78qt5
	Yw==
X-Google-Smtp-Source: AGHT+IF4q9KTXGC2ijxvIDb1UZYnzpmUqKTg5Up3xtoFrYO7Wu+InKzncW4uk4hdu0lbQIMGdI9WRg==
X-Received: by 2002:a05:600c:1e19:b0:434:a734:d279 with SMTP id 5b1f17b1804b1-4362aa5005fmr17219605e9.16.1734083784100;
        Fri, 13 Dec 2024 01:56:24 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43625706c77sm43616845e9.34.2024.12.13.01.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 01:56:23 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: linux-kernel@vger.kernel.org, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: linux-amarula@amarulasolutions.com, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 David Airlie <airlied@gmail.com>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org
In-Reply-To: <20241205163002.1804784-1-dario.binacchi@amarulasolutions.com>
References: <20241205163002.1804784-1-dario.binacchi@amarulasolutions.com>
Subject: Re: [RESEND PATCH v2] drm/panel: synaptics-r63353: Fix regulator
 unbalance
Message-Id: <173408378262.189325.11770535962921437927.b4-ty@linaro.org>
Date: Fri, 13 Dec 2024 10:56:22 +0100
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

On Thu, 05 Dec 2024 17:29:58 +0100, Dario Binacchi wrote:
> The shutdown function can be called when the display is already
> unprepared. For example during reboot this trigger a kernel
> backlog. Calling the drm_panel_unprepare, allow us to avoid
> to trigger the kernel warning.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)

[1/1] drm/panel: synaptics-r63353: Fix regulator unbalance
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/d2bd3fcb825725a59c8880070b1206b1710922bd

-- 
Neil


