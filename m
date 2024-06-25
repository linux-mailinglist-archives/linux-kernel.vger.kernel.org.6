Return-Path: <linux-kernel+bounces-228638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2319163A7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAA8BB266C0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0C1149DEF;
	Tue, 25 Jun 2024 09:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="idv8vaaj"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37061465A8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 09:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719308947; cv=none; b=bhvXmAtEnCIPOGp8aTeCPhU5eJqX/MuZVredHHnv1IALcOQDGbiUO5CznM6y0fnu9+x048VDMpgGl9brzm4fmDr5HxT3iZ+y9xRiPZ+DX8l7a1K/Kpp5wyEfBkNRmDVs4x58dG5qt7VjYP46GToKafS7ONCVlKjayq/s1RUCshU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719308947; c=relaxed/simple;
	bh=MR7WVjHtT0vzX5FNA9HFNz7gSVF0jx1l79NRJQA3Nlg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YJDATKrJ/Tr1271rmsEwAIwYkM5JFfZSzoh7PiNIBgHc6arFY+ON9W9mvRfN+IkEuILjEvGbxrk44PluGu9X/wayhL0mmJLBzR80M675U8vb+RncD4Jg9hFyQV9Ow7qSSh1Ndlm30Xzxz/QgJid7ajBZ2BqHKn5hPvO9amxEw4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=idv8vaaj; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-421f4d1c057so42988125e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 02:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719308944; x=1719913744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJpTx18M/ty64g67woNbXjQvBnNl49GFFpng+yfXaok=;
        b=idv8vaajX9uv8lupy3djeLyau+6DvW9rI8oQiLeiZK16YPboAup3zz6WrcVaoGm1dD
         knnfRTuHGAMart8ur17yAOiABFC2o7QcZ++F9QPoGXkFuy3KRtZQoBb7HghDUP6jWixc
         rHCDeUUabafowka99LjfrLkPm+1CB00hMGpHAHmLtRSfqEP6Aw4+r2ngERv6DpZB7tOr
         FBVnV/9So7Xscjbs+BcEGVVNslZz4VAe2VY8jmc7rbuuYsYloJiX8jfJBXjfM9WjPQ6B
         1teUvKWv977dAPGENlR1QNWuHpD31svRw0VDWXuwpHJ47b6fopz7/3mKEBM8LQje8DZQ
         bFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719308944; x=1719913744;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJpTx18M/ty64g67woNbXjQvBnNl49GFFpng+yfXaok=;
        b=pZvRhAwQnOdeD+tTEmi2lBqwoe9f8UAqT5PfXJCDNpsw57XDewcfEZ1ml3aOQNIlHe
         W+EIhtieoUARtR9BPvqg6Oe6gpOly0FzSbKR9gVt1kjkl2fpAFiInv9Q0CE11jHdd/TC
         imGpcqd08ZYuMu+qRglr1hrG1QWWN5Ro9WkdAz7oPi6exUE/m9IygY/4LZZIz53jtxAM
         sNXTVLHb4johzNAowWwgvmwg+ZKKTzioV/DJz14fLiB/hk9hvtPmWLzhatjkA7FNeyLC
         sCXbTDWCFS2guNayHqvu3bF6z6JxUjXyBMYunqrwu5gNNMtirdFEsO6XbA4LSDILoAQY
         8vJA==
X-Forwarded-Encrypted: i=1; AJvYcCVqF73Ohcx/wDdAf8JjSzHOjDwnIe8BBhvYiiLdEGNZct+3QbO3FxLtVIqHGSkf5A5EwodgHPOH3a5LDnWy00s7vt//E17dpz8kIG/D
X-Gm-Message-State: AOJu0YwKLMJr+3la02fg51kKGN0Y36Bo/0Dqnn4bZdUj7TPytkgPIi4u
	yjuyNjE2/K0fvRFcpEDogghburATFDu2BXDgrMh8K/3V/c9FHZ4AW9Dkazn9qyw=
X-Google-Smtp-Source: AGHT+IGZFy25ev3nUeuvrjQIowttwOuo93D7i0Ci98/mU5zOORqhKQlmx0xUKbo8Q47Lb7IM95F94g==
X-Received: by 2002:a05:6000:18a1:b0:366:ee9b:847 with SMTP id ffacd0b85a97d-366ee9b09a1mr5482044f8f.14.1719308943620;
        Tue, 25 Jun 2024 02:49:03 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366388c40c3sm12452424f8f.30.2024.06.25.02.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 02:49:03 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Liu Ying <victor.liu@nxp.com>
Cc: quic_jesszhan@quicinc.com, sam@ravnborg.org, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, daniel@ffwll.ch, emil.l.velikov@gmail.com
In-Reply-To: <20240624015612.341983-1-victor.liu@nxp.com>
References: <20240624015612.341983-1-victor.liu@nxp.com>
Subject: Re: [PATCH RESEND] drm/panel: simple: Add missing display timing
 flags for KOE TX26D202VM0BWA
Message-Id: <171930894282.652957.8854208216460459572.b4-ty@linaro.org>
Date: Tue, 25 Jun 2024 11:49:02 +0200
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

On Mon, 24 Jun 2024 09:56:12 +0800, Liu Ying wrote:
> KOE TX26D202VM0BWA panel spec indicates the DE signal is active high in
> timing chart, so add DISPLAY_FLAGS_DE_HIGH flag in display timing flags.
> This aligns display_timing with panel_desc.
> 
> 

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-fixes)

[1/1] drm/panel: simple: Add missing display timing flags for KOE TX26D202VM0BWA
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/37ce99b77762256ec9fda58d58fd613230151456

-- 
Neil


