Return-Path: <linux-kernel+bounces-203139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB618FD6ED
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE5E81C216E5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FDC1553BA;
	Wed,  5 Jun 2024 19:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLtYgEav"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7DD154452;
	Wed,  5 Jun 2024 19:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717617513; cv=none; b=AFvky4WTsEU+1aVCnhln35tsQw0Ak+URZPv0Lpn6rBh56RLQanowHqOMRKlwr0drNNC6fi6FEgtCyQKb3T26qMhbv0zNYwXVNq5uUV1LZ1NuFB3xeNqiH1mmKubsJ3FAD1Onhmz5o1TyfcdN1MrM5qCSKZw6Lv7xZF8RedWmF7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717617513; c=relaxed/simple;
	bh=tveU/ZHqabXpBPrR0CzCHYcwmKVkBfaTW8MgVo0tXYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KlXHbCm8ax5Uoi2iXUEFG1oCL3Ul6wa/PoD8TfWjtCRoAkvpRd9k0uxRIq6yHqDoN63/0mkg6J438Mwn25kI8Ksq+DWslhMFSBdfvgm7NjonriYt8XvHqj/AT1x0ccKaLMpH6hda3XqJqtplfP1kO0xPJhvSJRxmGNl5Jq3o+rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLtYgEav; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-35e4aaa0f33so199291f8f.0;
        Wed, 05 Jun 2024 12:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717617510; x=1718222310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pf8r5yLzRWnbsxS/Ko313LwbjIGVpyyp6EBPhDw6O18=;
        b=lLtYgEavFE6yUfKG38jqCpohb2VvDMu/vZ8CMdPVkjDMpjXJdGUprdN6ZmXKeG1SPE
         oVrYJ6sKiFFLahYLW1pOeT8djVt+NHP2kFDuJ4q3iYpfW/JSkKSAqpYNlTdMZxsq08Yx
         CrrjoGxL2gqYaOKH/xLTvLl1IBcrt71+wuE9oPolSw0ACL1N+TaEPyGUcjWmaolC7B6+
         q19EHzXuTQn7rRgjkkUVJTgE+XVLEzpH7VF9khqVQYMpoJskpFl1aCRETTnXPgdzIpA+
         9tSqC0xtV/Ae+DdQ28BzkzLAQj6Ardkb7QxTdwF3VlmNoW6alS3l2qyXnwtFO0nqLmv5
         yeIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717617510; x=1718222310;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pf8r5yLzRWnbsxS/Ko313LwbjIGVpyyp6EBPhDw6O18=;
        b=QfurNfIQWHRPS8kuot8Y3fk5P8TuCO9ys5qIgTuPE2zMurDCUKeL1U5TuaLJVvmNf0
         rLyNGvGWbYMoCRBckqT87sWu5d+cUkYY6pnPvl7e99UDX6y1aiY11ZXPUlfL1XhHV8dB
         EuZuP1YWB/z+gYhKqU+jomKjDMoYqBl83MlbhB6EhGn7+2Og7go+n1RT08wnio0CnbXY
         RiRrCvvG6aJc2s+abFy+RG10TfzLAs5xGLytZo76PAnSgCBBd3Ihdc09QjIStVQPxzYr
         Y4lGFzsOF/envMV2qyZ4ZGUDRvR6ccf2xIRF0aDXHGUDmp/1WPQnLZUsisAGFLDFTrlV
         pf5g==
X-Forwarded-Encrypted: i=1; AJvYcCXetx8HDJHq6qRO6ay/hj0nWR3l/yR1UDnr1AduJAbWSOIcJ/V3YwAt9yjn/5uhjK5N3eFT/Vusv1kloW26oDWcADyHPctOsYAIRNGxRfXM2QXGJctNCsembPX0D1x6yihdy6UZ0GREIw==
X-Gm-Message-State: AOJu0YytPj6XPwkZBPXrYmmEIsOsjM/7VHR4FvxDy8UQVbhQPYZvobD/
	sniyKNmjuHfpt/4bpHM8Um19fP2d5fySAaSt+aFHap18tXFrRdjH
X-Google-Smtp-Source: AGHT+IFIRSDuYx9C8w8Mwft2Esuzx2rYHBnh1PEvECrLGF7NHqqpntJiuiOWp3KIW3ubAgGvnJx6DA==
X-Received: by 2002:a05:6000:dcf:b0:354:fcbf:f3c0 with SMTP id ffacd0b85a97d-35e8406decfmr2999235f8f.4.1717617509710;
        Wed, 05 Jun 2024 12:58:29 -0700 (PDT)
Received: from [192.168.0.9] (cm-83-97-153-254.telecable.es. [83.97.153.254])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35e0f97ba3csm15323756f8f.73.2024.06.05.12.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 12:58:29 -0700 (PDT)
Message-ID: <02e22411-e22e-41f7-8bca-95c8ef5a4346@gmail.com>
Date: Wed, 5 Jun 2024 21:58:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] drm/bridge: synopsys: Add DW HDMI QP TX controller
 driver
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Mark Yao <markyao0591@gmail.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, kernel@collabora.com,
 Alexandre ARNOUD <aarnoud@me.com>, Algea Cao <algea.cao@rock-chips.com>
References: <20240601-b4-rk3588-bridge-upstream-v1-0-f6203753232b@collabora.com>
 <20240601-b4-rk3588-bridge-upstream-v1-13-f6203753232b@collabora.com>
 <2554679.TLnPLrj5Ze@diego>
Content-Language: en-US
From: Luis de Arquer <ldearquer@gmail.com>
In-Reply-To: <2554679.TLnPLrj5Ze@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/5/24 16:48, Heiko Stübner wrote:
> Without this change, connecting to a DVI display does not work, and
> reading the EDID ends in the "i2c read error" below.

I had a lot of problems initially with the vendor driver on my DVI 
display, and am aware that several changes were required.

However, I tested Cristian patch and worked fine. All modes were 
apparently detected from the display and they all worked. But maybe I 
was just lucky and it was using a somehow cached table, I can't say.

This is an AOC DVI display from 2011 with a passive adapter.



Luis

