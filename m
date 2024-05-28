Return-Path: <linux-kernel+bounces-193088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E5A8D26AB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 23:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA2B0B2B443
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 21:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42A717B427;
	Tue, 28 May 2024 21:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jgFI8wOQ"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC40C17B4ED
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 21:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716930095; cv=none; b=JuOcB3VjBj2/DiQ+anLjklLKx+ah/o/gpZbOJSucBDKmClffcC8A6Pyrcv7trKlih+wWNMEkHlcqo+8PHAURtrk5Hn5gEOK9PYZYjiOY20X+EbQrPTHwbP7h2Rvld72mmdQ/uDN1FHxGDuUhUpDPa8SNxLk16cPo1IAXbB9kKsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716930095; c=relaxed/simple;
	bh=swL6fUffSZT4iCOYaoX/1Pr804zyody9kswGWy0J4gI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=j+LplotANjhMwLLuBnmuFx0cZ3YnE7KNYu25vJF/Q9QYlzr/iS4vyr+nA+LfkJve5QQ8kI6j+yvKAUfdmKvQGVXQwoJr2cPsABSyB/Pwgm8ZHc3hiGyCaJdECoKHUjD8U/q6woGy6E1e0Y5I3XGAsyRGsTvfWLzU6rCMqt5gXDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jgFI8wOQ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f4a5344ec7so1821935ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 14:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716930093; x=1717534893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfMy6c3Znd6tavzTLRzjdvXWxxk0QstMx+psfmFRnqU=;
        b=jgFI8wOQvO5dquAEMHOZ3KEwgAU1DJbDmNSn0NTHY7NNkDkuMYRCq6JQ8THQZoCKXx
         d9N2meOCXhnkJOeUS98ZcU4+pKdsekQA1p8zY36tlOY/sGB+bYWUy02VdcCiWZDhcZso
         qkL0lJ+2jOxld3x9rjEM16iXc0+yGzahckMu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716930093; x=1717534893;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZfMy6c3Znd6tavzTLRzjdvXWxxk0QstMx+psfmFRnqU=;
        b=XJHgV1XU/46RpjdU6S2u62Egr1HQKyvCufwdBtMOWEI43p/8jtVKo2eBl6X/r57UU6
         t3vjPK8VE0WN7G/1P2Jv6ACd4cm51l0F0JNlbTA7Nsl1wBfcvttIdQM8DJOLBoVlTrZX
         xARkxEj4dajsaXZQpZJbc6L/eP2kDpP3lc9zu/OYWjw66Cs7YmM0MYR3heIkEtEfOTc+
         ygwQW+B22Q0DWVAf5kpmzcR4C1NNk07/jgxwt+sOUR7qBlYy1DZ1W1Fdrny9uTob0BkR
         ypcKU78Is8LOwFFi/VtoICjjJYqb/ATLmTz/IC7vG4sJaBxH7NcA+Ycq+tIZRKueLcwg
         qC3A==
X-Gm-Message-State: AOJu0YyQQX5/hSmCnfgIViQKZizOuWYX/pDyQ44DqlNFTtEjMJk0zfmP
	mNowRq716Amo0169qTCe5gmzDznOtjBrfK6UmCOaRAftuzMU1COdBvG3WPcyYw==
X-Google-Smtp-Source: AGHT+IHnKMx/amFBiavBsFKrgADkUZUSzat6ZPtDirfE8fDJucf2GWJKt1cP+KaATFveOkt12/R3ow==
X-Received: by 2002:a17:902:daca:b0:1f4:adcb:37c9 with SMTP id d9443c01a7336-1f4eac8863emr3286335ad.25.1716930093006;
        Tue, 28 May 2024 14:01:33 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:8d59:feec:9939:40d7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f481d5a77bsm53167725ad.298.2024.05.28.14.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 14:01:32 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Pin-yen Lin <treapking@chromium.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20240527095511.719825-3-treapking@chromium.org>
References: <20240527095511.719825-1-treapking@chromium.org>
 <20240527095511.719825-3-treapking@chromium.org>
Subject: Re: (subset) [PATCH 2/2] drm/panel-edp: Add more panels with
 conservative timings
Message-Id: <171693009035.3691502.2472086074502512286.b4-ty@chromium.org>
Date: Tue, 28 May 2024 14:01:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 27 May 2024 17:54:50 +0800, Pin-yen Lin wrote:
> Same as commit 7c8690d8fc80 ("drm/panel-edp: Add some panels with
> conservative timings"), the 3 panels added in this patch are used by
> Mediatek MT8173 Chromebooks and they used to work with the downstream
> v4.19 kernel without any specified delay.
> 
> These panel IDs were found from in-field reports, but their datahseets
> are not available. For BOE 0x0623 and SHP 0x153a, their product names
> are retrieved from the EDIDs. The EDID of AUO 0x1999 does not contain
> such information, so list as "Unknown" in this patch.
> 
> [...]

Applied, thanks!

[2/2] drm/panel-edp: Add more panels with conservative timings
      commit: 336dca397dcefc5d7436be1fee3c814ed6512996

Best regards,
-- 
Douglas Anderson <dianders@chromium.org>


