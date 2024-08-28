Return-Path: <linux-kernel+bounces-305260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F78D962C06
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2CD81F218B4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C3913C3D5;
	Wed, 28 Aug 2024 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JtPlOvWw"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD6283A18
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724858395; cv=none; b=VSFcEVRfaYDtV4JRl21nvIx2UPnH2jkedx+MR043k6BHTeANP1oY4Uj5ueuUo7SmlUJC+AwhHFsF6DFtEc+P0NdJ0XqHgl5tzI9MR8cyWGuKQVgGo/HcwmxuMjRQCEMw9Vsx4lBTBDg/DDyzK3lPauLR093gY1K9x9XEFAq1Ohk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724858395; c=relaxed/simple;
	bh=7aD+AzCSeMsuiftPJ5aRODAeiInYCsCGaJyDmBjqgEI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KdppSRbVUZWlDyxKXV69Nog+avybt1dhUSwVfRgUyHxV8BqF62Z4XcSbvpwNhmki3IDOWlVBECgN9kFAmlw9odT/lv/n/Wh0ddctSTW0xcjI0XovYmlz7RkapwYrYdmhN20/TiO1pucG/l6/nNe2b3iE6LCNHe/E2mWjb+kLAkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JtPlOvWw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so57862175e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 08:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724858392; x=1725463192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CpCSPrvHbvgoQAYP88DpEJGLj5yIDmGzU0Kjzww6IQQ=;
        b=JtPlOvWwoph2yJcyWkgGw05FhcEecRvvFjvHCExnZIDA1IDVGagOOGE6XqKSs8AQWq
         aKfuzY2WRNwAA3QfOVaCRjm6Jpx62WmSOmm7VlSNuZKBjSrTHXv091Pwbx4XBz7sDOBY
         OITmRCuWB+JzCkBvviYHpcU/ffR047AOee1uwx8fF6f6H68dVf2xZ9Rlsg2iSqAXz7hJ
         QCNuemwtttr7lR7gutWRyNrNKFcL46NXS7GtKQV1F6mKBekX9w3FIDBlOgIyB4/3e16t
         07rnkrDw7DztzkGzBFYTOBxiX+5DFvq2KtRdDodak8ARiQRc9p0MNvH3Jq74s2cLIlLd
         1FKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724858392; x=1725463192;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CpCSPrvHbvgoQAYP88DpEJGLj5yIDmGzU0Kjzww6IQQ=;
        b=EaeYUJMrrJpRnREZlcKgfV/tRUFfo4hUNg9cphp3MwvatiTYeGEtgI00wopqlLREAu
         ywoEpcmofWOAouUR4SXXyiHHdtRXHUZCXC/CkFUEsE/vyMTx0LAvacaV/gS6RZcNZMmg
         T+QvbKkwMVnp7il72n815N2B6NCOy6xLdqMttnZYg6YktP7v/MQ3jjbGqNykj/skUk1g
         q9F7JeN3uSvE1oCdWy+y1tKdYp/z/KmZg5DbE0ycC2bbV/8eF31ELjwVl9bnVVhrZObZ
         NwIwu/tuWGxslXXZ6BTG5vKZCX+2Qy/K6vCZ1GticyiK0WyIQScha1YSuz4jlNQ72epf
         avmQ==
X-Forwarded-Encrypted: i=1; AJvYcCW09GihqffDxITa0zVBcCqVStkXJhQteU5brH2xkl1Hl/IsoVHdCMlLwrl81p2zum0vLn3+JQGfTCbFOpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4tCu8VBJCS2Z1/FpDTBEIQXLFPP4Z5LGKjONVhp4jaHXRSLM+
	lFyamgEETl7VerdJoo/X+ZJ+OIZn5lnUPAuEVMMULxBT93jzgoP6an0zTMjL530=
X-Google-Smtp-Source: AGHT+IEGSU/UwPVBHorEXHqFGG8jxUW916b7N6C+V6g9017AC5VrtKCvylicZ/00xhSSsodhFPWXdg==
X-Received: by 2002:a05:600c:4f47:b0:426:629f:1556 with SMTP id 5b1f17b1804b1-42acd5e2150mr117558075e9.31.1724858391632;
        Wed, 28 Aug 2024 08:19:51 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba6425a77sm24631045e9.45.2024.08.28.08.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 08:19:51 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Doug Anderson <dianders@chromium.org>, David Airlie <airlied@gmail.com>, 
 Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20240828-topic-sdm450-upstream-tbx605f-panel-v3-0-b792f93e1d6b@linaro.org>
References: <20240828-topic-sdm450-upstream-tbx605f-panel-v3-0-b792f93e1d6b@linaro.org>
Subject: Re: [PATCH v3 0/2] drm/panel: add support for the BOE TV101WUM-LL2
 DSI Display Panel
Message-Id: <172485839079.3445878.15332347279646667687.b4-ty@linaro.org>
Date: Wed, 28 Aug 2024 17:19:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0

Hi,

On Wed, 28 Aug 2024 17:04:18 +0200, Neil Armstrong wrote:
> Document and add support for the 1200x1920 BOE TV101WUM-LL2 DSI
> Display Panel found in the Lenovo Smart Tab M10 tablet.
> The controller powering the panel is unknown.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: display: panel: document BOE TV101WUM-LL2 DSI Display Panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/1da04eac69197032813940426b73fff6f0a84c64
[2/2] drm/panel: add BOE tv101wum-ll2 panel driver
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/aec8485f226c36eb4eea1d489772cd6f2c40144d

-- 
Neil


