Return-Path: <linux-kernel+bounces-233655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A30691BB1A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 11:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8CD8280FDF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 09:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A0E154BE2;
	Fri, 28 Jun 2024 09:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gVJetfdf"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD1B14E2E3
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 09:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719565643; cv=none; b=YLAMZCl9MtYMcimM58m4LOkTmfsE0SeEQT0yRzT6zSzSeviuMgMNYuLg6fl9DktRTozfdD5hZzWzu0BwGv/hKMpzN/9JNDf2U6eEAkP+yBqYa81f6U5X2y/ZFpCMwjR+ADMIhK9QPNUPz6YOw3XxVfA9vcyXJcAYTEAXDX7mugM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719565643; c=relaxed/simple;
	bh=uwPKeY4YAFWk+GuFqb+c0ljykA9M16vP1oj8QsN1i1w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nadYDa7zOMR4+nj7SKNAMo3RC5rTeCSkpyYVbArc7lYOXZeQjH8ucZSVwqcBUn/Z1LelKNdKdlmVwo4K/Tz0D/DxortJVQ1lBs9u7jUjAWN4YD+XrCxgOQ3arf7LDzk9R0VSE2GtpJo/fZ1GLuV9nKAscVTQ9HToxqTS18PDANQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gVJetfdf; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-367601ca463so227157f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 02:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719565640; x=1720170440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAojY8v61Oq5pXWhl+jbz8qnbn0iqqHxroEEAHU3dVw=;
        b=gVJetfdfr38QbLRVVbFr/wn0v2SB4qEduvVTlFZdk8u3h3bzgcoRCYp49YUkA13o2B
         ntP0UEhhS6Te/h+8+fJcRNM+4F2AOLJN9HVTMaTH3W2mtBOal81cYHh5Xzw6laNEI2Ft
         0OyJN72hg+b3hsyXBCdN6jP+6yroCtFy71hnJOOD/CHvTocslAEa53Q+tDV3lk3Jynmj
         d1IGyDSvpJ7uf11oNA6KIT7Lsf2yJ4tOoTh8X2LVqCi9Mp6blsX1FxyWrsvJqbw6acum
         56RrCQMoqc5viJUaDk/Nrzo0+wDEfMpsx5BgFKSgPpzz/Ih94IqYQ07H8k9KtgZy9pnh
         +jpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719565640; x=1720170440;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAojY8v61Oq5pXWhl+jbz8qnbn0iqqHxroEEAHU3dVw=;
        b=YSicO/mq26El9mRZMA77xdRJw772LLROF4o64f0aKqqpSO/0pACbOxGGG0bJLgCQgO
         +7ab+NbIlfQhT9eW7B7vHPYE6VGgER37T/GXrtrQZPPcAA6Lj3i/mwbxyaE6ibtkSZaH
         C7+Re5al7YsbGeGbVhtO0tWrRnoXhjVmSGMh6OjaSYi/icX2WckAXtQzxLw9zrjZix4z
         1wuigiqGhYnb8Ns63+YCAh+VI8x0p5ABCtGM/+EesoaT2YdrUNRCdx6Knu+U29FazMu4
         oCNqyAKxMfR/NTuWKLJWhwB9tHRJlY+liSZVF/SMdywjphGIXlU6gLQpPEBv195Vachx
         26fQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBqswStgpIvMB83gFS+Yxi6rVUHx77rGp5ItvMlM3u3xBWEWSgUiMYu+zN1roqPN3v3v8z+mn5Fc2JhR5/7xhvQwR25v718YPHjVvI
X-Gm-Message-State: AOJu0YyxlkREI5RlXEsrXa1vxHKAq5zkJTkHjg7e7w1ih87kc2RnNLhq
	hHH8UoNpdgXAldKJ3AkY2MXM8IoI4fdwy9bTVWIo4llIznbf5hvPmt3fna9hZD4=
X-Google-Smtp-Source: AGHT+IH1p4Lr0/8BDnffNORPkUxB15wlpiN10FAgg7kp26WVIDI1u2ehlcIyNvLqTtsh8o3u98LDqA==
X-Received: by 2002:adf:fd4b:0:b0:367:2ae1:9c4d with SMTP id ffacd0b85a97d-3672ae19d30mr5031112f8f.29.1719565640035;
        Fri, 28 Jun 2024 02:07:20 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fb967sm1612896f8f.82.2024.06.28.02.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 02:07:19 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Paul Gerber <paul.gerber@ew.tq-group.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240627084446.3197196-1-paul.gerber@ew.tq-group.com>
References: <20240627084446.3197196-1-paul.gerber@ew.tq-group.com>
Subject: Re: [PATCH v2 0/2] Add AUO G104STN01 panel
Message-Id: <171956563914.990484.5258309901602303917.b4-ty@linaro.org>
Date: Fri, 28 Jun 2024 11:07:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

Hi,

On Thu, 27 Jun 2024 10:44:42 +0200, Paul Gerber wrote:
> Changes in v2:
> - put explanatory comment for display binding before the list entry
> - collected Acked-by and Reviewed-by
> 
> Link to v1: https://lore.kernel.org/dri-devel/20240626044727.2330191-1-paul.gerber@ew.tq-group.com/
> 
> Paul Gerber (2):
>   dt-bindings: display: simple: Add AUO G104STN01 panel
>   drm/panel: simple: Add AUO G104STN01 panel entry
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: display: simple: Add AUO G104STN01 panel
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/21335cf6af98d524d01296865fd0a1c6886ace54
[2/2] drm/panel: simple: Add AUO G104STN01 panel entry
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/6c2b2cd33705b43cb19699500bbf7bd77bc8b60b

-- 
Neil


