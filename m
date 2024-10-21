Return-Path: <linux-kernel+bounces-374382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEF69A6958
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEFF31C224E8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 12:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D59B1F891C;
	Mon, 21 Oct 2024 12:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ekGQ/cI1"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EB21EB9FC
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729515549; cv=none; b=SYsAiEQdZ0JFi8jpZ50rBsG1GoBzNotiBEf5BSazrsqAZjIxBz9HXXR4IgWwcul5KrCP/cRxCT6kq85nFlbzzuMtVxj5lARLb5MzTCW+/WjlvCOPrlEjZlhd33+4t0R5V6LTH59R4zO62uwsK5kHJ8go52zIYm/wnL3B6iqq7yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729515549; c=relaxed/simple;
	bh=F6wJzVu9nOLdqkjDWsLHKDpSIflO/rVNvCrwaOC2qfI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=inTpsDtuit3uO9rHUVYfZv0hiKyq6hHJsBBlZlFYtSWhI+rSJAdm47y7OTfXO2+x9GPwLIXQN9B+scjVpW/+XzagJ7kpsLiQOqJ9v17+T9k7gicsgfsDQUmcGpBfF8dxr2jfkPgFaRWhVcrUy3vOEgoVzC2KgZmeILRJ0amOvwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ekGQ/cI1; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-37d55f0cf85so3210333f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 05:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729515546; x=1730120346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snkHEJasim77LVJkaTI1NaouVUr0haIlOruAFQp37Sc=;
        b=ekGQ/cI10rlEav0WqUr9ksnffbGz5LpfNZZC9WLzt3X7YqFkxKU0i01Dv2IqNe+yVM
         TnzioturLxZcvR97sHa/tUY2Y6L6ESVbN41aoZVYdQma4gafQ+vQS7YBvKmkR0/k3+tW
         s6S1SPYbQnU/1VWumZt8XtojnWi8JxjEBVa/e+HVxuWGF+CahdLQiQJx55g1YTws3iXY
         KPnb9415+M2stkWHEujlVn0GoEsm82qwWRIpW1HvHIJ5gBPva7OOlApaOiCA8JUmfRLZ
         gt6uucE2AIxWZWGhAt1i9/MWlrp6hc8NchnDCsJpyHdR+uGFM11zIP8ODnheIZ6wzbcP
         pvxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729515546; x=1730120346;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snkHEJasim77LVJkaTI1NaouVUr0haIlOruAFQp37Sc=;
        b=xPLlJF7WhzkjexHdLOZRXju1pooP+mp3Hv0Wtdw388MOuH/DYyDL88JFvPFpDkvrUh
         lCK7fywNilFGwJqgzB2vB2VrbAG07RG2s0Dk76HZj6O7+AN2BqoaYQu+PWl7604SlRWX
         4rt165jmVCrXbpJapyV87HgiXhrS4DwuOK4zLf2QUKI849+obPWmNC+CHqGKgQQcP1zn
         2v5YFH9hyrY0a/h1xG4vfDLWELBIwkMWv+q/aBfLbwAFi/8KMXkOKoifvUzKdUmdznea
         677H+LgxrZRiAY6raD5FJ4i2y8kNGOg6njrzZkSpF7QMXEZAjS89RtQXpEm5kE0zGz2H
         DsnA==
X-Forwarded-Encrypted: i=1; AJvYcCXLtQZgf195f3reFhF4fsr3NaU4Jr1x8JpTPdMUhoqpLcgrofia2ZjBrWwrLHlcjrYLsTUVVL3F7S9P00k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3eb5T2qjMtRgxuAx0orC7x4hz/wb5nimrIRruSFWsBoYCDW5m
	u91qrUVus1rskVZdg955ki2S/id2uQtoY8kBxF/njGm5SJjqTHzrB474KzPk+bLZGw3znpS/N0e
	OvAI=
X-Google-Smtp-Source: AGHT+IFcSRL1L5YHF/PkaNiNkO4kEWCwjKaC1ui26pVWmEyhTmr7noeg3F7eX1DbwNQQs0VgkqCXRQ==
X-Received: by 2002:a5d:4044:0:b0:37d:4e03:ff8e with SMTP id ffacd0b85a97d-37ea21a1f42mr8442388f8f.28.1729515545757;
        Mon, 21 Oct 2024 05:59:05 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cc4dfsm57452995e9.45.2024.10.21.05.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:59:05 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Liu Ying <victor.liu@nxp.com>
Cc: ple@baylibre.com, andrzej.hajda@intel.com, rfoss@kernel.org, 
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch
In-Reply-To: <20241010092643.1048116-1-victor.liu@nxp.com>
References: <20241010092643.1048116-1-victor.liu@nxp.com>
Subject: Re: [PATCH] drm/bridge: ite-it66121: Drop
 hdmi_avi_infoframe_init() function call
Message-Id: <172951554492.1240386.12723814267685320903.b4-ty@linaro.org>
Date: Mon, 21 Oct 2024 14:59:04 +0200
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

On Thu, 10 Oct 2024 17:26:43 +0800, Liu Ying wrote:
> drm_hdmi_avi_infoframe_from_display_mode() called from
> it66121_bridge_mode_set() already calls hdmi_avi_infoframe_init() to
> initialize an HDMI AVI infoframe.  So, drop the redundant
> hdmi_avi_infoframe_init() function call from it66121_bridge_mode_set().
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/bridge: ite-it66121: Drop hdmi_avi_infoframe_init() function call
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/c7671949791fb1142d0ae37343759d608a21bf28

-- 
Neil


