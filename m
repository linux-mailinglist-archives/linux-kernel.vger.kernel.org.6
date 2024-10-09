Return-Path: <linux-kernel+bounces-356473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 228DE996199
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B53741F22137
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 07:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1333518950A;
	Wed,  9 Oct 2024 07:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xUzYTU1S"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7B5188734
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 07:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728460566; cv=none; b=Px3+HYEqP8biySJjEAKtJJvE5ezbjmRH9cCzbHxK0NVMchBaIfKuIERcIxgeGcs7PWO7HOJD0JoBNHJ8DB5IcQIPf3aO3toaGlx2a/OvVEGNjgg43JB1l+L0JUgQ8jEc5lw4gjlxQhwPPhvkSd5zat+MXTT2MHxboTjuEAaNVuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728460566; c=relaxed/simple;
	bh=zyQXw4W+dACj8pIpi4uJhjlBxNwkyzSfLPJYrZ67arc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=d/olkebPh6sKE5ov9W9OCaJOya56oXJI+tjSC84rfne2oXuGEhnQdPJwMZy2AQd8Ze0iU0A/FiD/6lYMZ2vYi0yMqkVVdr0tpEeBjgSGUad3Q/sWDu5NgqFktvsap4riE6zSTyGf5aUHYc5Dh5rsBbCIhEPx57Owpa9hJO9MdBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xUzYTU1S; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37ccd50faafso4231075f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 00:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728460563; x=1729065363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kmMlDXGibAdqKrNC/s4tQOqEsl9CbNvY/ixtgVngYk=;
        b=xUzYTU1SKg0L6MZ74eRYVUXjk/s9Y7HoEyvtMdtK/mB4868YdSdyGSaQZRRCrHf6I2
         RYNOajwoIgz4mXxhIaccyvPt2g1o1u0/TVMHs8KGQLR4Z4jll0CnhtV2kH3bZ9Vjpr8X
         CNraHR9vWADhWj2CG3CR2DNr8zYgxQfqiJCsfIRQmEUvQKm/M+jGbSo818tqtk7k4CYA
         ZEW8Sk+6qeB2jqD9raOHExW/3KvWc5SO7Jd5LKwrikJ/1kw9ROgiABYm0AQx59PYzGxd
         bUkGLpRokbRj1W0w1sTPK7M6P/IWvTjtaoMlSn3MtJPT7ITfC8PiukQ+4k4z5UuTyME1
         nD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728460563; x=1729065363;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kmMlDXGibAdqKrNC/s4tQOqEsl9CbNvY/ixtgVngYk=;
        b=dKO9Hj3nxaA5cS9Fl4wIq9c9a2xQj8ErFEgEyzGSvACIJoXxuDJTn5JwJY/HX1icjT
         rXa17P6Vx2LbJ5Py4PxBU5Uj+df//Egk6OCIvEpGftvprZOsbW/ST+wHRibZkzU+zcoY
         ed9Z9O2oHfEDEoLlb/1AVStmpoqRUoXB/stuasLqciSvwkxchdJc6Dw2piw43ZRWCWLN
         zuhR1K3V8770vaKoKnF1PepA3PMCmLVu0DPPkUJNNCR1o3ofisr1SpKGUK2+iHaExQnN
         Jn+6/QXhwaROXBs+A/q1Rs/JSnmkQn+DYiZq9Mc9IemebPE0jYaJLGcXaAl+H9Z4Vmk6
         /zIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWScrxIB0+jxcNkTGH90m2ZCdWdP9D6aX+X25OQrq1XwwMWadgWtK4rU+KLOCHIEzx0O1HxDwfYMh/ZnWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQtZELK6s/01lwXM86xiEeC4yyx9/WaWcwvLevO9T0G3Eo2U4w
	P4sv+uqSYMgcjhcwRHGPMZLFmNB6tuhqS0u4DYNa6fABDC2EgsLNVhTtRw9llw0=
X-Google-Smtp-Source: AGHT+IGVnsvhJt5/bGGQd1j33k6EUf41BaTJwb8mSb1jF2UGlQuMTXhFJYasWIvOI9vvkkF34p+yOA==
X-Received: by 2002:a5d:6990:0:b0:37c:cc60:2c68 with SMTP id ffacd0b85a97d-37d3a9b532dmr846334f8f.5.1728460563207;
        Wed, 09 Oct 2024 00:56:03 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d16972fd9sm9660342f8f.104.2024.10.09.00.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 00:56:02 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: quic_jesszhan@quicinc.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 Danila Tikhonov <danila@jiaxyga.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, adrian@travitia.xyz, degdagmohamed@gmail.com, 
 linux@mainlining.org
In-Reply-To: <20240930202448.188051-1-danila@jiaxyga.com>
References: <20240930202448.188051-1-danila@jiaxyga.com>
Subject: Re: [PATCH v3 0/2] Add Samsung AMS639RQ08 panel support
Message-Id: <172846056170.3028267.4886940070722840412.b4-ty@linaro.org>
Date: Wed, 09 Oct 2024 09:56:01 +0200
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

On Mon, 30 Sep 2024 23:24:46 +0300, Danila Tikhonov wrote:
> This series adds Samsung AMS639RQ08 panel support used in:
> - Xiaomi Mi 9 Lite / CC9 (sdm710-xiaomi-pyxis)
> - Xiaomi Mi 9T / Redmi K20 (sm7150-xiaomi-davinci)
> - Xiaomi Mi 9T Pro / Redmi K20 Pro (sm8150-xiaomi-raphael)
> 
> Was tested on sm7150-xiaomi-davinci and sm8150-xiaomi-raphael. Based on my
> analysis of the downstream DTS, this driver should be fully compatible with
> the sdm710-xiaomi-pyxis (unfortunately not tested) without requiring any
> modifications.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] dt-bindings: display: panel: Add Samsung AMS639RQ08
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/a62528aa539a405f76cc3478f6fd3f842e7c6a4e
[2/2] drm/panel: Add Samsung AMS639RQ08 panel driver
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/bd07dbb929f6c5bbda60d52a0003246e53f48c29

-- 
Neil


