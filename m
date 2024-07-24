Return-Path: <linux-kernel+bounces-260748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE3C93ADAD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 10:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD278B2285B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 08:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7335613CA93;
	Wed, 24 Jul 2024 08:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NAvkcLlQ"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286E413C661
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 08:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721808007; cv=none; b=EqKMd4UE0pPNmV7fpGnZ6wlgt3nZASE5z+qsM+0QapD4ku417ut3pEdLGnStUTyswDqCzGQAiq0uScxsoi9LhIANUtoydRWvi8flGzSBAsB/f+rfJh/CpWaQ5F5BEnZFlYPmotiqcdMss7Oe+TOaKbF1NtvJawXdUO0QTrsEpF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721808007; c=relaxed/simple;
	bh=yeUAH0g7hbkF6iaezGVTf57lSZ0SBToumjcqPoEGYUI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WEAV/II69qChd/IWyq7qsr1y9J1GiVjYL55ZscklfOmtJQbVHXZrZf6r5LcXyC7s/UNDMJC7W4CKEY1YSmzWXFVbvNZXXm+wsc4jWSrANb/QF3Hk7QVXExvYbycHbiRfWb6vhTky3XOIc5WBQ/Gwcf8hX/LXTN/PbY6WnMme9os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NAvkcLlQ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42793fc0a6dso46699195e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 01:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721808004; x=1722412804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gksPNd/8mTl0AswME5OKgNNN/KzZPdsYR5KlLDDwAY=;
        b=NAvkcLlQTks6wCv4cTo79n0S3Yo7YFCXrvl9IanQOfMuhAlUQS34gQyxMlveGbZrJQ
         9/xsXVjqRH5DOKGDWtxvLbNLZKIQg6VObApg3nXDvl4obk6VL8dzrtIa+62jQRPmmlnJ
         A9gZh5yNkmfWhsNgh92xmJXfSItWMD6orZdE9eN5OXop2AqkeuUhGtdHu2J+TS6Vj4Ge
         HDDUk/J90qvE79x0bQnaHUFnTEltFQRJNti7+GPTAh50MAe56W087dvnHuh9IKojtski
         3iGwDlHqji6e+BoCgmxwIoJIgdirbYWKNT2reEUdxd033PeZmLKK/UArVwh50SZhc4dK
         2dXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721808004; x=1722412804;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9gksPNd/8mTl0AswME5OKgNNN/KzZPdsYR5KlLDDwAY=;
        b=L4S8MCJKnZuR03UJ8nbP7jmaaLN/5vvjbbihZeFctcJxv7u7KO9C0pVpVcQI+3AuP7
         IxPyxX6SEgiYm1cgjNtZqAt238GcJXZ+qawABsUEYzQQAwfAcn3C4s1WUwircINdLQ3L
         b9fRWJ+RzbQHP5OR0jOCaxJmmhWz1pp5mzsJAAyUh+YEkBNxrW7X9hmT2L0B8QzjHkfF
         I3ImSW4mJUZE/Xv8ub3DSd1YkmunPf2luyICa+52tU1ZHyrQmJOaHewgUhoVrzL+y8Vh
         hJwcu7qi7+mkup+8FXyHvQxkkUHqk2VB1fbLVpQT/fJqlNBl7RZIQspsYcw8GgsQxVB4
         H9/Q==
X-Forwarded-Encrypted: i=1; AJvYcCW7ZC+8ZE4CqF0s+vL431oypW+hiMCJOE+fZ3dVt5U62pAS/JoIoNTOps2+2qS7PKOzSkeZMFF1JW/4JZPygLSSqkxSCyuw4CMUVk8f
X-Gm-Message-State: AOJu0YxuGbn6ev3+IWlypIiTHouA+zIFQLGUTq9kEOzR3l8JKUUUGRc9
	XpE1AtlREvH5CU3xcNKVgA6U6iNZU/81ArcFSMNyOEb3Hd4oK3Vphqp5M1Jzq1o=
X-Google-Smtp-Source: AGHT+IH0/YSxaGFFUnlIWu+/ToSP2Peo7hMQ3mRiuobNjGX5FoeFex9AY3X59ni2+Va2L5RP5LR6yg==
X-Received: by 2002:a05:600c:4746:b0:426:6960:34b2 with SMTP id 5b1f17b1804b1-427f95c1e5emr8646555e9.33.1721808003111;
        Wed, 24 Jul 2024 01:00:03 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f1f52b8dsm33884015e9.1.2024.07.24.01.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 01:00:02 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: quic_jesszhan@quicinc.com, sam@ravnborg.org, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 dianders@chromium.org, hsinyi@google.com, awarnecke002@hotmail.com, 
 dmitry.baryshkov@linaro.org, 
 Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240723062615.14796-1-lvzhaoxiong@huaqin.corp-partner.google.com>
References: <20240723062615.14796-1-lvzhaoxiong@huaqin.corp-partner.google.com>
Subject: Re: [PATCH v4 0/2] Modify the method of obtaining porch parameters
Message-Id: <172180800228.4044086.14282905036923611293.b4-ty@linaro.org>
Date: Wed, 24 Jul 2024 10:00:02 +0200
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

On Tue, 23 Jul 2024 14:26:13 +0800, Zhaoxiong Lv wrote:
> The current driver can only obtain the porch parameters
> of boe-th101mb31ig002. Modify it to obtain the porch
> parameters of the panel currently being used.
> 
> Also switch to the drm_connector_helper_get_modes_fixed() function
> to get the porch parameters.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/2] drm/panel: boe-th101mb31ig002 : Fix the way to get porch parameters
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/c60ca14bfd2d399a66f7164e044b63991c6a5a82
[2/2] drm/panel: boe-th101mb31ig002 : using drm_connector_helper_get_modes_fixed()
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/708899133615bdb8087cafa129b8e24397d0c79d

-- 
Neil


