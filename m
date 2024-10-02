Return-Path: <linux-kernel+bounces-347126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B061398CE34
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C3391F2291D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 07:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E5419538A;
	Wed,  2 Oct 2024 07:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QT+Pst90"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5001A194C67
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 07:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727855770; cv=none; b=WC1VqvW9BRftEXRA+VZNZ4R23PXy+oN5bGpMchMkz7/CtxaVqCICTOmVEtDmsDh/YCaviyu2DoOB7clVCVGpFMvqBhpPyiiYgFz4PaCWDbHy+H7kW1PzMyixbZ/Ga/6aLH39E84YpvWZ8veuuhmj5L5BRCg1GjvZ8eosGoWdHkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727855770; c=relaxed/simple;
	bh=BdFqoh25/ziCt0rrHIy/OnM8VCmvKp+9NmDTPKC26f8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XwLViIhZLVoKx0oXJOdiNGxq1GwgdyE15lWRJKK2pba+fsYEOIoaeGwfC/pjQtNvQcIka800xblGtzZO75KAhJEIozCi0OrkWP/1TcqJEzMT+MpDFoR+YhpvbfWgFJSYmrqnjEzFO1u5yI77EQF4krRb2F6GgrfI2XKJ8iQV4H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QT+Pst90; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37cd2cb5615so393041f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 00:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727855766; x=1728460566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAp4KqRCMKdoszZ3EhRlu0o7aNcIHhINgcixo0Grn+8=;
        b=QT+Pst90yhhIjf3kQxDnlM4qBANtjPjngRZHcZIfjF9t26H4Rud8jO90GvjZND0wlB
         1qhLPkyGtTj4FzblX9YIHZS1sFXq0vkYn/DqYihj+TXsnosu5o4x+Vjkf8fdytdMHk1i
         PaUfdBL5RDJIy20h0gVeBYaG/sN2Nn1NgBQszYhA+FyktL1m+rFe2JA66hbGr8OG7DKQ
         c+owYP+8yHYZhw70ZvOb088AItjszFELjDRDlTPVZq3nXsjn1Q4Nk6141Q9z99qWOPkg
         9fYsWx/PR8nnrGYu/2ORHGefyQpLDo5vPgl8CarHqrZmd4Gh6tN7y88JyIkDwjetCccB
         m0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727855766; x=1728460566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gAp4KqRCMKdoszZ3EhRlu0o7aNcIHhINgcixo0Grn+8=;
        b=CXyJsjd8T0T5wNyGhbv7FSLKdqqmgO266IP3BvyaYi55YXFoxyIUiWBuZJ9pHim+GO
         gyE0Lq4nKM0JWvTqVY3eiX71yv1pU2FVTblLTV0a4PVQ8lAi0JneXUkgTcdXjZO9Ie1m
         o1wzwvSxEX4lLAK8E33n8HkJhnO+0l021vAViDkVOIGLAWZkfdx1RJaFyWsF87/fwCkj
         bZ0uvnoJQ63jgyp7t2NZZZMG2iT+ZqH76AGzY/RTa2psdVlpeQhyfye0NNnCDsiV2JBS
         M7C6LAfFdU/aR7DNlKsYagahA989CnIuwhaIv7xxTzMqox5VrZcoC+a47A4+TFCMUATk
         Xe2A==
X-Forwarded-Encrypted: i=1; AJvYcCXcq7ZEFp/5puVCXB0LnofPxHVMqDFHfSGAIEjxB7cr4zOxu8PXsM3rRUYrrHI66uz4YIkxA8AdzzM+B7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8CUDZH8JmckPtRRXrtDXvMFzhB6KzGKm61z20nr4BILl3WlLr
	io5COkEi/RFf8UXLZ9GOWUcwusVya9sGSGLZDBjHUmJwZeVsI5QKLH9Hi7TecTc=
X-Google-Smtp-Source: AGHT+IGd/5hoWfDs8hU174pJPwnTiwCYFT2Js+t9A7qwtxi3HUASZxU/C1Zj23crYIjz4fXoGX8MrA==
X-Received: by 2002:a05:6000:184b:b0:37c:d515:7674 with SMTP id ffacd0b85a97d-37cfb9d65c8mr629639f8f.6.1727855765627;
        Wed, 02 Oct 2024 00:56:05 -0700 (PDT)
Received: from krzk-bin.. ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f7a01f52csm11176545e9.37.2024.10.02.00.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 00:56:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v5 06/10] dt-bindings: pinctrl: samsung: add exynos8895-wakeup-eint compatible
Date: Wed,  2 Oct 2024 09:55:54 +0200
Message-ID: <172785575196.22593.2005129736205573813.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920154508.1618410-7-ivo.ivanov.ivanov1@gmail.com>
References: <20240920154508.1618410-1-ivo.ivanov.ivanov1@gmail.com> <20240920154508.1618410-7-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 20 Sep 2024 18:45:04 +0300, Ivaylo Ivanov wrote:
> Add a dedicated compatible for exynos8895.
> 
> 

Applied, thanks!

[06/10] dt-bindings: pinctrl: samsung: add exynos8895-wakeup-eint compatible
        https://git.kernel.org/pinctrl/samsung/c/e2d58d1e1c61c1e1d4af400cc0ebcebf98efb49f

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

