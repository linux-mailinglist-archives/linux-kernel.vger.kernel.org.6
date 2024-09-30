Return-Path: <linux-kernel+bounces-343810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EF4989FCF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 12:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 200FA1C21990
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 10:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE58218C90C;
	Mon, 30 Sep 2024 10:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eZSo/vkJ"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB1518C35C
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 10:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727693518; cv=none; b=UbhWt+L93VtEEdomPPWaUrj3J1jZAniEjdNG0tzmzZvpNmdZumlQAOW5DX5f229HCv4V+myzOd+C65PyscuH2N1648mKllT/zB9Eg+rWdnTckVsNEO+4J5vDY4gcFugguaC0XNuHxveSNivcY3kr5DsMBJCO0enSZIjLVzCUYA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727693518; c=relaxed/simple;
	bh=qs7ZJEUvQkDuGY/NdNPSo7a5/3b+K7XWq8qcKl9g+0Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rOaIzlxIvNHwZIZw7OUkggnNEhT/VIQqAz+PPJOxV58Zo8Odw2DF/mjuDpTHum8ehrvCMU3CZu0NRQUftcruWtzoHyDwGLxSLV9Sq7YbAauyQoeuVQ+487hgBuX/5PTzKrHmW9Br4yAlmLxN+K+pvRI2RuVY7wm2BWfcVTbPj9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eZSo/vkJ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42caeb4d671so5838985e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 03:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727693515; x=1728298315; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NrpcGzq2X7FUeooo3oK/NoZGdoCws8o9zjwmd3SwC4=;
        b=eZSo/vkJNw2QUhTp47vWhqDHAXDX5Ph+nFm7KsItW3z3SZ0GvjtKtPMFetYX8sUfBT
         GoBdVqXSuZZjiY0uzgcuHNw/uw+ncDn71HZGcqe5c5P8mpffUckUsMRggzExSHs4MTvI
         aouGbHhxbkD64ErVgr6rbAqnN5UyElu6oXyFZzll3ty3MmPqPTCcUUWC84iGtVPjpIVJ
         1xhtnwmN8GttYO2tfUw3RjkDAVS9HitI2V31ACqbP5vblH3YCjqiRtObQyuTbkBlH7vD
         S7BWNocvGQXDPEmcmPodixFUaN4ZKJ9zSGs1H180n4a1ff+XIyyvQyfvC6xOv4ynaSF/
         WU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727693515; x=1728298315;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5NrpcGzq2X7FUeooo3oK/NoZGdoCws8o9zjwmd3SwC4=;
        b=BEuSjH71HakakcMoyoghZuu6JX85Jbzk7BKOxZX2qu7WPXMreis4ydelu9kNQlJ76S
         VVih0X2ktaQuM/p1UwXSZqI1kDv1sGuDMA/tfAEI6I87q8JXZAk1krdFiHICGULCJMfC
         gVC23Nigq+lXvgLBBUb9OTVVDr0Q8pCaMeT/71wJRj38H36MeGwiUvWAEnA+J7mKsixc
         PwxNhh5tZzzBUHGrYeKaLKflKvK7fqGlbbquNGW51+fnMOaa/bAr0S3cVBZWety5z32P
         gtqhgGaA6/AiGvcPfYipwtytBcqjXf/QUjH/sTwI9tz08Ui+wyyVMVLtf3Amv35trP5P
         tUCw==
X-Forwarded-Encrypted: i=1; AJvYcCW5NOFYDeAYIg07uItK0tpp9msWsVb69+YB56ChAWgrNPnDVgR5WIa47bhZ7ubvQSyFE+lIj8Aw44SpNfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAK7B/YJCJUomxOCl58wxaqlsoI3kxaBGBts9dhid7BJAvf4DN
	PKLknEdpjRTFF/k/fQNqzgJNPoHKONLwT1dsrLkoQqBbUufmC6SBqRf+SvsPeHg=
X-Google-Smtp-Source: AGHT+IEOO29rsmHXOq1A8VX2uRLf7D10lSyWawJH83ILxagvL2rZ5u7vPabfYAr/tIknh/8GVqnDTg==
X-Received: by 2002:a05:600c:4fd2:b0:42c:baba:13cb with SMTP id 5b1f17b1804b1-42f5e37365bmr26702885e9.2.1727693515024;
        Mon, 30 Sep 2024 03:51:55 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57dd3106sm98632815e9.7.2024.09.30.03.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 03:51:54 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: krzk@kernel.org, s.nawrocki@samsung.com, cw00.choi@samsung.com, 
 alim.akhtar@samsung.com, mturquette@baylibre.com, sboyd@kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, 
 devicetree@vger.kernel.org, Inbaraj E <inbaraj.e@samsung.com>
Cc: pankaj.dubey@samsung.com, gost.dev@samsung.com
In-Reply-To: <20240917094355.37887-1-inbaraj.e@samsung.com>
References: <CGME20240917094449epcas5p37c2593fe8f181d6b19a9a1b290488186@epcas5p3.samsung.com>
 <20240917094355.37887-1-inbaraj.e@samsung.com>
Subject: Re: [PATCH 0/2] clk: samsung: remove number of clocks from
 bindings
Message-Id: <172769351330.28623.202959929040095252.b4-ty@linaro.org>
Date: Mon, 30 Sep 2024 12:51:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Tue, 17 Sep 2024 15:13:53 +0530, Inbaraj E wrote:
> This patch series moves number of clock from dt-binding to driver for FSD
> SoC.
> 
> Inbaraj E (2):
>   clk: samsung: fsd: do not define number of clocks in bindings
>   dt-bindings: clock: samsung: remove define with number of clocks for
>     FSD
> 
> [...]

Applied, thanks!

[1/2] clk: samsung: fsd: do not define number of clocks in bindings
      https://git.kernel.org/krzk/linux/c/a86ffa40a64bd4d119c260a99e28f2a71f86d9f4
[2/2] dt-bindings: clock: samsung: remove define with number of clocks for FSD
      https://git.kernel.org/krzk/linux/c/2d3e0135cefccbcd8459112a8afe260e7b51ff6d

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


