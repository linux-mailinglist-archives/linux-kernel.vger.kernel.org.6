Return-Path: <linux-kernel+bounces-327867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC22D977C0F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9532128948A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 09:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE5D1D6DA7;
	Fri, 13 Sep 2024 09:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d4aVTumP"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707251D6C6E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 09:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726219119; cv=none; b=QbN/H2hwHYpwxRe0isfgG3SiD3yFIYqjvRUsu4zfp5qVZKOkyxo76WIppYUbyGI5ba3weC616I5KgRknoAaQuElDvYHzTzIx29YLEl1QWzFTm90I0uXYr1dBnGwgxKnZCeTcNDKv2L6Xt+fgCjPJOlfugsVbg9ghAirTnjn8nRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726219119; c=relaxed/simple;
	bh=YhB+wAPiYSd3F8HFZRKEj44c+JWLnWOJGRstcM/WADg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iggge4tLlPlpriINMtAPcrWSXhMiIqGKysXAT2uFbwGMp4uXTqHxzqPLGmpFgAHM5iVBCDH1J/3DZCH/3k/n/4cUk15Z+OtFMECPmA1uY+Wzc0B571nK3rwJUpiaiEjZwgzPssotiW3i5DzB47b6pXpBv6dNvndnA/WdsTHuuak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d4aVTumP; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-374c3eef39eso1219345f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 02:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726219116; x=1726823916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaqlJSHsnewVm2em4WrxriA9s7od43kYT88LXwLPapY=;
        b=d4aVTumPe7varfhX6QQiwWW9gqQrkmXktmp+1jlvvdq/Nuxs1ARpOfeA9+Haud0JLf
         zU4ddfOF0rqQ5RZIyxEF3bO2LRSPXChW1CbtgHRRTAFeeX09kgRsRb6or5n/KHs6RD+4
         Qt8dOIaDP7idUn8qjmJXc2AjvIp2sdH0Wm/ZLpdbZQoho4P0/LfNH1RHhpJm7/fAOEGl
         oMONoOjFonLroNKNHK97mP2MTn6mZ9bsVMoFYk/LxQo/Jef6jf6aKlQ5m0O45nstqNN3
         mMkimCK7OedHcxixnYA2SgkKmo/9vp2beurR4+FUIut4oSHGxumIHwYXCgVFc54s4k7t
         PF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726219116; x=1726823916;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kaqlJSHsnewVm2em4WrxriA9s7od43kYT88LXwLPapY=;
        b=Rn+bkz6gWCsIznChAdFpyA/HcrAawxP5jDR9NFMBxT25Y0N7/JaV+5saCfI5JpzEjV
         wg2szAoLbw4SEXiNqprqHTMFKMXnPCRxGY8YKq/cga2AXhaBdsVV1D7btsZOoW8QA9VT
         8slwIRllz0nIO1l9hKY4SVCVYEHZ526ffBawX1fmN3Nj6TIrzC8/bp36B42ywg7hc0Ts
         RYaV07aVDSA+M9hmFqfcY2ArvnbxiL5MJnCalymaDWUXSSU9lqsS3GhxWYSsDkEo954U
         GgmmuelCuaalo5fAjAlJItGjYg7KZ1m43TGZsRS4KcvNjvbo4/8DZgMMr6UnmFXGnGsI
         zXzQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8qLl6vUkb0npHeiJHYi6rYN7RNHT4e/oIeIUrPBJp+VFftOB5lC1vwiAS5EGu6bfJcNJMLnhBgOnjlH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDP2qkIaxI4ABVkJAW2LmMyzawUAyIJTgs3tmnITzo+jJ0aTa9
	h8FaeSXH6AniVFcDg3DCwBcWozYKYcTWIXFXD9SkwetwWpZGBJxPwy36t3Cras0=
X-Google-Smtp-Source: AGHT+IGCqWSH9YxA72B8MbCebnxY2+ZE05yklBj0RjAp4qiWjLJCbRGUykl+6byjkUE7YWjPxAFfow==
X-Received: by 2002:a5d:6b8b:0:b0:374:8f90:b78b with SMTP id ffacd0b85a97d-378c2d512f3mr2723645f8f.44.1726219115490;
        Fri, 13 Sep 2024 02:18:35 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956de0e2sm16258982f8f.105.2024.09.13.02.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 02:18:34 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Min-Hua Chen <minhuadotchen@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240908133533.112894-1-minhuadotchen@gmail.com>
References: <20240908133533.112894-1-minhuadotchen@gmail.com>
Subject: Re: [PATCH] drm/panel: khadas-ts050: make ts050[v2]_panel_data
 static
Message-Id: <172621911461.1200554.12665559180853848377.b4-ty@linaro.org>
Date: Fri, 13 Sep 2024 11:18:34 +0200
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

On Sun, 08 Sep 2024 21:35:30 +0800, Min-Hua Chen wrote:
> make ts050_panel_data and ts050v2_panel_data static because they
> are only used in drivers/gpu/drm/panel/panel-khadas-ts050.c,
> and fix the following sparse warnings:
> 
> drivers/gpu/drm/panel/panel-khadas-ts050.c:620:32:
> sparse: warning: symbol 'ts050_panel_data' was not declared. Should it be static?
> drivers/gpu/drm/panel/panel-khadas-ts050.c:625:32:
> sparse: warning: symbol 'ts050v2_panel_data' was not declared. Should it be static?
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/panel: khadas-ts050: make ts050[v2]_panel_data static
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/d5acba46ebf5a4fd9ea9ae5121dd381ce85e94ff

-- 
Neil


