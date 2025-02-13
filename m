Return-Path: <linux-kernel+bounces-513436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81607A34A47
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 17:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B9AF1896982
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED74C241679;
	Thu, 13 Feb 2025 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="djjLjH50"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCF8142903
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739463903; cv=none; b=QMYcRU/2d9HUZz4Qjdvg52akwaM4Ayp9snHfrCV0D2her0THw3YRHM+C9QTZw/hUL0kuxWTmlgl68MUVb0IPZOJBLXsBXe2gAuXTxRJasgnI4NnQZ8ppQ9feEl6LaGN8j5tSkNAXvYMtgQ3bU/kD4HLSGgU4D0NWU9Mp3ceKvUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739463903; c=relaxed/simple;
	bh=0ow9kxvzDfxgbly3zhndGElrLB3p+gsgWQ3n/gRU4/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SQP4jNEmA7Y/G0apCSjNbQfstwjrv90Y1nUzYtIeY8ZGfkyN2BacFCge9wcCQU1p8By6RKGjFr6LqV0zZtjXKBhRKChrYBeuWMrjsSKcg3IJtMFqis3vNnprBgx6Vkc2stIRAZ+vUsiwciqnUIrOKkqXjQc3P625s/cxUMI6CX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=djjLjH50; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5450408455dso1162591e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739463899; x=1740068699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RP1Frco8mVbDxpufPwI05XZgkOP7lEoWQNwutSthLNA=;
        b=djjLjH50zl8NiYZyt4m6p99qpHMHimsiuK13vTjjp4KQODYv7BKo0rBdkcJooxKALY
         nhj4/CvXiIanKNBYC6oAIOXwPcZ7ho2WN4g7EL96J/B18dmDwIrwkdkxSjihk3EckelP
         Q+Hi+4DIY3qnH+12tu1EnaBRc7g18640sTa1uJS6OfdAdqf+WnDNImLCQSYVcZ8uCyJb
         NwHc9ETtY1Wz6EhgTDW+ODI5WL12Wpo8XUup1s6gnsQc6EZGO6FyZGihN3Pi0wOwQDaV
         aKRu7G1b9Uhrya8zJtQZ+P3Men7neBqGjiTev5slutgql6w3qGZIJvmj6iSTF8AUDTtl
         zhXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739463899; x=1740068699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RP1Frco8mVbDxpufPwI05XZgkOP7lEoWQNwutSthLNA=;
        b=QuAvJZoXVXpTVj2HHOvAquaZ/H2HC10PaIzhyDIL80pRH3vIhsR/9eTFrrPYvbcoEr
         0scYWvtJkMSAgcAdoROabBLQJDgO4yer0N2roNwmW0K6M4/j0oQQ7gLsgZpMddtLtu56
         WLISxDwc3jWq6cqQ60zuMxAlvWH8iS2rqrCHlHyF6vsj4T2nkri7mQl4qPhAmxXF0XUH
         MveyROCH8ZWjurIjYYy0kns2fsVoKkQ4yID+QcIL0GgHcvpItifP+pIvLsIBkcVVRasI
         mFKVP0nq/IEDf7EONvybBL48AfnRFNSGqAjkJOkOMtQdZnhMJsToM16jPfR59E+jWEeK
         FCtg==
X-Forwarded-Encrypted: i=1; AJvYcCXlQ3P6VaxEuUswTVhJupjdRoxtbLSTeYVed3Em99ZkYR0VSMWdq6L4ke6ePPG99XhMgECDhMJdp71wnGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf7n0c6Ixx8PdEgdBRkOhDwjaaybtWGkqg2QfP0kd3nlHWhXZP
	NOs0Zqv2nigN3gJbZks6Abik17fVmwEllQOSrJKC/mLSCYJX5LV7JdEyr9NbnXo=
X-Gm-Gg: ASbGncsjSAnuyYiY35tav8QS25EWi7Bfc9J/D5B/qw07lYtvkiOV9Buh9PbHM9nr+ki
	5rcfB6YXFJnl/jaxBzq6KUKog0d5xGCGqo8UNg70sUXov6SZROE4T5xxSpNWlGXg31b7H/u4uWs
	cn4ZDMrkALBx5UvNzQd5t85FOVEwQUbBgoVJWEru0XxEfPAMHBdLVrKKNSJTbu/U5qzyWX/08rq
	exOomXvy4rJDaXfHPuUcNCCRFem84zs7m9cAZnIVXIU2hV3oZcu24eY7tF5L8bUnGq7/Y9+OLu9
	RUzbAUUFcJUP26C1YBjl1UlErWHs+3OS6XCOMYfPVUNbl83eyd56JlDbrsoO15X6AfAtqpg=
X-Google-Smtp-Source: AGHT+IGfRjD7Tz5iv/1tFAE3Xtx4zjrCq99Q8Fqbxf8sq8iSc86pgj85yDAeiyyxfZEf0fMuxxQU8Q==
X-Received: by 2002:a05:6512:3f9:b0:545:8a1:536b with SMTP id 2adb3069b0e04-5451dde9440mr1199443e87.50.1739463899538;
        Thu, 13 Feb 2025 08:24:59 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f10cafdsm219598e87.169.2025.02.13.08.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:24:58 -0800 (PST)
Date: Thu, 13 Feb 2025 18:24:55 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Douglas Anderson <dianders@chromium.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 28/37] drm/bridge: Provide a helper to retrieve
 current bridge state
Message-ID: <suykislck4eekj7yotvgadjnfuv2ctu23ezxsy3iwjo4mdfrom@7dcec26cqeak>
References: <20250213-bridge-connector-v3-0-e71598f49c8f@kernel.org>
 <20250213-bridge-connector-v3-28-e71598f49c8f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213-bridge-connector-v3-28-e71598f49c8f@kernel.org>

On Thu, Feb 13, 2025 at 03:43:47PM +0100, Maxime Ripard wrote:
> The current bridge state is accessible from the drm_bridge structure,
> but since it's fairly indirect it's not easy to figure out.
> 
> Provide a helper to retrieve it.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  include/drm/drm_bridge.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

