Return-Path: <linux-kernel+bounces-305259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2F0962C03
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85AD01F218B4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DF9189BAA;
	Wed, 28 Aug 2024 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TViLa98J"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DBE381C2
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724858394; cv=none; b=hwfuelal3XRVsqMhRMTnCOqaA6I+7bl/q9cI9e3neuhsuPrFjGvCURnoM0DRNPG/XhxAUFk6sXE12tCRTeb1Kp3FIxXKNnVpEZhZVmdYEcbqgZOb0h76S8/g62tocswj0qrcLvAqviiEfuyri8TgPAMHaWGB1HkxzXq+d4qx2cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724858394; c=relaxed/simple;
	bh=X+peiDrXTIYDihlg0CAbxJgqgItqImm3NMc4Ciesws0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jNbBtEMABIhhRWTscrcGJK71VnOY+yR3pgt3wJJNRlQqShGJNdXjSB9i1el1ATjYWj6bRREMqwmAbl8Lc2asHhH+fOqOQRmCOkwlK71oZDMvFSGjfkrgvrK2zBdu1g+MxPhs3OmnX4Rq8/+xvXU+UqH+7NgAKQO/YIvfvGZC5LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TViLa98J; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-428178fc07eso57852565e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 08:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724858391; x=1725463191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKzhVfzM1gLnruc2o5OAiEHsW1nJqMKHAmAUvz6neTg=;
        b=TViLa98JG0FOBZDlZi0C/a9m2sR8lZLq4Hq1Y9SFGPC4C/1ZMMWaChlJDjL48YHSQw
         nxaojU4c3+XPEbikTBuiRbcloSCkwTFR0ArgO/t1sXLv0L+k69sSEu2T2z+oc0aSxWXz
         Q2Ne2k3cdxbA4waObIZkupvFspVSrJUw9AQwBYvK7RR3WA1wOn6pJsO837Ls9PMtjDB7
         m6Eht3vM8/ppgJIesFxhotpnUU+cCbPOBS73iMG4K9ZyAAGnihGdVRReTvUqxKetIuyY
         VQOfrnjQtKmUkrahBzWtgE97LXMGqEalWTDQjbwbEBcHrAoPu5s4t01iyql5uRHKQ/sx
         F/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724858391; x=1725463191;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zKzhVfzM1gLnruc2o5OAiEHsW1nJqMKHAmAUvz6neTg=;
        b=obZIpTNHoSTMfqwDOR54tHVvFwBsOpYJZI//aF71JaGro6Q4tA+lqUxevOcGz0mzdQ
         u540cu887VdvK5s+oRv7trikZrU080nhICNGJFMVi0fnAmVtWGvIBcQ6jI9M8ScbRWn5
         OCFmx7HqpynFvjrW4bRAcfjfLBFdKOQCv4z7uZo9oZWqallKPxMDFxjkxEemPNCJ42Mb
         Jye1XoAvKfEUNxOzKPwMs0tim90CgXJOj5p2IEyvUq1IeeU81DOWR7bCco/pz8MX+pZG
         jwk8LBx/H5QUaXnyFJYLuNpju/SoYO9ONDq0/6DbG4p9L9ADTFAcsGtXI3SCb7U8MWP3
         34tw==
X-Forwarded-Encrypted: i=1; AJvYcCUqYiV+C5vlCfIVRAjB8IAn/PL/GPHG4XpYRVXjrKPy0vwwjZJv3gh9yghVa3lOPlugjwThmVkdklKz/rs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjgvjZTEXliyakqR7cCJ7M48MBxqahIgS9mk2XbethKZn0xTji
	dNa5kMVmU/czBklYeIG8wA3Ue9ObXXDmAJztRP19Ogr+l5VxFA/z5juFgzaqArc=
X-Google-Smtp-Source: AGHT+IFVfUCOhOIxDhfQgATHF/iqyCLKMA6nOmtrObiUtTUI7YU9bTeWtwuoYi7HFfanctZ74lgrnw==
X-Received: by 2002:a05:600c:4707:b0:426:62c6:4341 with SMTP id 5b1f17b1804b1-42acd57c086mr125961655e9.20.1724858390674;
        Wed, 28 Aug 2024 08:19:50 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba6425a77sm24631045e9.45.2024.08.28.08.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 08:19:50 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240709-topic-sdm450-upstream-tbx605f-panel-v1-0-af473397835d@linaro.org>
References: <20240709-topic-sdm450-upstream-tbx605f-panel-v1-0-af473397835d@linaro.org>
Subject: Re: [PATCH 0/2] drm/panel: add support for the BOE TV101WUM-LL2
 DSI Display Panel
Message-Id: <172485838985.3445878.265354752188488947.b4-ty@linaro.org>
Date: Wed, 28 Aug 2024 17:19:49 +0200
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

On Tue, 09 Jul 2024 15:05:43 +0200, Neil Armstrong wrote:
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


