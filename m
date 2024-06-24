Return-Path: <linux-kernel+bounces-226926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 571C49145DA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8846F1C22CDA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 09:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1101304AA;
	Mon, 24 Jun 2024 09:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yVGyrPFW"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA5361FEB
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719219944; cv=none; b=LQ8R2BM/+o3RrkFtzNM0ngpoX3lki2fhImzKsZ+YfhiEsGCpwOT5a0H/fLFdcU6rwSIbYXGKMMUaDgrtrcZg0AnY2aIfM1xDi5vxHh9pmj5s7erjzmRywiZhstIwH4uSVhXxkRqDmIKIUKDdtBExG7tt9m8XUUj+4Um4qBDWD9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719219944; c=relaxed/simple;
	bh=/Yh6dIO/xvutDCiTjVqopncU/9iXA/J9xbbiXmahTrY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SSZ2iyv7PNvBMC32Dqyq5JHZpLPmyixA6BCBFIGeZ+axW8toa1/pMi4fS8wk8eFU35+0k3a/ly/jALuP1WkB61T4ifzDmLRIY+tmnWGt18hd0Q4qrj5ArEE4lc+dRASyHrMVHNo51MBO7XbdCnlYz5ZVo7TslX/laMiIvf3fUwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yVGyrPFW; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3620ee2cdf7so2589302f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 02:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719219941; x=1719824741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5qDsnR1NTYULm2Qyr/0Z4JWIlfl2ul0qrSxAF9LCYgs=;
        b=yVGyrPFWXUli2nLAAZYAVdIXy0tlF63x6Yvqy5mXKmvKbltGuGc/SY3vhRnMThcrDR
         8VjjZXFZ+H40M+3J0S1BYTUk7cBzrTcbFEmLZkknZjAGr5uS6Ir8ULWP9C9LULqHNE7j
         OhCsuvb0MF7LP39sCBS61FMvDWvS8lSNXzmkKhulXf40uAQYeqabQPNEpQXNERQ+ycxq
         EA/yNBZF4oFqrlb6Ovz40n2Vt+/5uGF+zrAfMMHWohaWT/sWPQD2JnSnjNxx5buucSlr
         143CimhDGRJvdIN69wyljKNTv7FQw03xp12Lh0Odhb8QJKKqsKhYyuHiSOLg9cncQUpX
         LwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719219941; x=1719824741;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qDsnR1NTYULm2Qyr/0Z4JWIlfl2ul0qrSxAF9LCYgs=;
        b=wT4r8EIiUoKmy+7+JGcl8TpUphdULwak9KNRS+JHAT5IzWDhAek7sovqnFpdg6CTp+
         5GpWRZzbRB1hUottqQRM+o05maoJ1mIy05wB3lpuFOP/8qXNIWGICwRoeEdd01K1isiC
         WQ1CXx5m0cA7Nll/evOR5RM7yNf6BY9IGenzgfBfAegx9AfxPx9ZxB0F6fSxOQf7w76C
         Z81WZI9Bwx3BOi8xV5B+3kJVjM8B+Th6h9WZNYpKeJrTpZ35Ojh5eNFORU5K7dSq1nzp
         wUxf6KFfxpJEEsszJaBfqDhclYyvRMIBZUcfVH7WuA8iKk9nexCfIxDGeWZ2l4NrxT8F
         a9XQ==
X-Forwarded-Encrypted: i=1; AJvYcCVChbPdJabFSsgCOSHPArDn03VWo1mD6gJS5PvcPvrASwjX886ZkjoW/1aXSWxNXzJJRfu5D6jQXGZRsvcf4cQlyRUtzD5Trs80h61b
X-Gm-Message-State: AOJu0Yz2X46jDgvX8p0TqqqYkNpfDpbvTo7J8VnUObyRc91QSrDQuynH
	El4WJZQfQMoeaEdIH+qJyKm/Zo0yZnDzLGoMfiNKOynoT1LdV2RUKEwq5zDgUFw=
X-Google-Smtp-Source: AGHT+IHJ13EztZCrxyJ2oWYkDSiBq4khT95V1IBke5urv+CpUbkCFJ0o9+6cXaFY/cRJQW7JELbj9w==
X-Received: by 2002:adf:f6d0:0:b0:35f:231e:ef87 with SMTP id ffacd0b85a97d-366e7a3634fmr3398119f8f.29.1719219940648;
        Mon, 24 Jun 2024 02:05:40 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3664178f5f7sm9323088f8f.19.2024.06.24.02.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 02:05:40 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: quic_jesszhan@quicinc.com, Tejas Vipin <tejasvipin76@gmail.com>
Cc: dianders@chromium.org, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240620181051.102173-1-tejasvipin76@gmail.com>
References: <20240620181051.102173-1-tejasvipin76@gmail.com>
Subject: Re: [PATCH v3] drm/panel: raydium-rm692e5: transition to mipi_dsi
 wrapped functions
Message-Id: <171921993991.3622623.9693135969867849523.b4-ty@linaro.org>
Date: Mon, 24 Jun 2024 11:05:39 +0200
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

On Thu, 20 Jun 2024 23:40:49 +0530, Tejas Vipin wrote:
> Use functions introduced in commit 966e397e4f60 ("drm/mipi-dsi:
> Introduce mipi_dsi_*_write_seq_multi()") and commit f79d6d28d8fe
> ("drm/mipi-dsi: wrap more functions for streamline handling") for the
> raydium-rm692e5 panel.
> 
> Additionally, the error handling in rm692e5_prepare() is changed to
> properly power the panel off in the case of a wider range of
> initialization commands failing than before.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/panel: raydium-rm692e5: transition to mipi_dsi wrapped functions
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/699f411dceb4766aabcac05cb4fbeb530e6c257b

-- 
Neil


