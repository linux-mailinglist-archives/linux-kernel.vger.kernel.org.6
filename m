Return-Path: <linux-kernel+bounces-293642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B48A95824B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 11:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16F44283CEF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA67318C01D;
	Tue, 20 Aug 2024 09:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RJ9N1aSw"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7D018E378
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724146298; cv=none; b=hKsjaKoUT/1TfIUWwtyVWB/HnQWy5QAuJsGevDyKfUYbcWSQIbTpO4uokKwu4tF9B0Ac7fbYLSZ2KykqPeSLkcpOK3UQML0nZRJXuvNg50oqjsC4b3NZvl5rMIA5+4jzLZD6jZ3mTqLs+0krykiGP6G290sIVpbFjZEx91449z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724146298; c=relaxed/simple;
	bh=eFTi7zeLLmMAQd57ugmudMTtpCqN7XW5pg8v+Im63kE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fXgQ/5XF0EN32ckM5E5bfeoAG8uf7ToPGF7Lt/OIHZlX4H4Yln0gXLOeHLxVxLuzMGzLDntZXeZvZ8rvCMEimu/kkNXJr/XBHtMthBV5Rkrv+d7cKxtyEHVb1BmRhOrIzsVRJBVuYL5zXQeeqMqc16qTQ4dA1bx9jOUDioNnJMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RJ9N1aSw; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4280ee5f1e3so42372465e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 02:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724146294; x=1724751094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dR0CreoU8vpVj47jDOdAp+cTu5413/pQZmWvPzZH2KA=;
        b=RJ9N1aSw2mFaxuGPeWuw1SXSAM+ynx0W+1Y0iFhY3yhzLaNR1my8zZ6MLTuVU/uZsw
         6ieE9Wm4+RZfq6fVEGF099egvPQ7/2Ejl7ZxC5Xe8VD+wDgvp/F6hVbSbXKVkouDqzF8
         vaUMLqu1Vq+BWSE/ftAetTX9AYNEhX3diy8wtSKVut7iqUicYlly1FkKHp6PSIdaqakF
         gLa2MMaDS/FTzHzT4z8K6d1zEVF4ZN7J+ETgnkUGSRuzGRWC4jw2uoOE5SPS1ZDsKwRY
         Yyv3D8P1w+Hetida/74o8qK9Mk8koJtCSVZoxWcT2mhoImQFdMy2KgI+sMjWW5u7DtZ9
         0l/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724146294; x=1724751094;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dR0CreoU8vpVj47jDOdAp+cTu5413/pQZmWvPzZH2KA=;
        b=goZHm3q0VgrevLKEhQ4Id1sEaRmhbV+EVqFuCxpbrtzm8KcZYwl4WrC7UBJP8Dj7M+
         qFFETg1MClV3ykPMEi6c0jhp6nAgpTTSQDiEkm3EXWDoNx+piysxa9REfAdoBPq647mf
         Pa1PSBmzkF0+dgHP5zea7UNK+17vGJub41Mg4Gr6o85dFTsggd9tKB6m4q6QJkZlAcd+
         QF3FP9V+Cfz9Zx40cW4e0e013KaUpKMAlmhwf1LO5wGQF5al3VRvXOut5O7unQa6/Tij
         pN1w5rhgX+dumQezYdyiMebXBZ0gVecxCuZGeGbkeMAj547PsargND4kxmfBBD04n/3f
         6xpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaiNbfDBOrVdyiUp/nAUBDBJdkK3I/2JSZPgqqT8Lv9ReETAJBiX0w3nY55hR6ywQSpaoab7LRj8wshkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVf4rkMR8BzRc02bHX1U38kC9+t1hT+4XVPN4kpGynuS29hcwC
	UQ0gTtNuOKbTm/fOqdCMnCtOqKGiG+8Y0YAqMpVqctMnsE4gKeLw+6w+istPg88=
X-Google-Smtp-Source: AGHT+IHX+zBO3kMosl5V3wdA7ekb2kmacB5cUU/l4MDgeLTQn+W+q0tXM80DVANeQt+/R4mbjOcPgQ==
X-Received: by 2002:a05:600c:4f8d:b0:427:d713:a5d3 with SMTP id 5b1f17b1804b1-429ed79daa4mr89507445e9.11.1724146293900;
        Tue, 20 Aug 2024 02:31:33 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed648f00sm136597505e9.7.2024.08.20.02.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 02:31:33 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, 
 Abhishek Tamboli <abhishektamboli9@gmail.com>
Cc: quic_jesszhan@quicinc.com, dri-devel@lists.freedesktop.org, 
 skhan@linuxfoundation.org, rbmarliere@gmail.com, 
 linux-kernel-mentees@lists.linuxfoundation.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240819175122.33176-1-abhishektamboli9@gmail.com>
References: <20240819175122.33176-1-abhishektamboli9@gmail.com>
Subject: Re: [PATCH v2] drm/panel: ili9341: Add comments for registers in
 ili9341_config()
Message-Id: <172414629306.2571141.1078174341276677864.b4-ty@linaro.org>
Date: Tue, 20 Aug 2024 11:31:33 +0200
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

On Mon, 19 Aug 2024 23:21:22 +0530, Abhishek Tamboli wrote:
> Add detail comments for registers definitions in struct ili9341_config().
> Replace TODO with comment for each registers.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/panel: ili9341: Add comments for registers in ili9341_config()
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/1453323eac4f13817a07f40e78e76dfc635aab34

-- 
Neil


