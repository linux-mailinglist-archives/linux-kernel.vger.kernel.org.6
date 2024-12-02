Return-Path: <linux-kernel+bounces-427680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8B39E04B3
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E132168486
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E266C204080;
	Mon,  2 Dec 2024 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PPoAYwi+"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B645217588
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 14:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733148917; cv=none; b=Tj92k+TFu3nyukiIhUCppfIFCGe5kS80MqJ0bdVxGjKKxqNlwLp4kw1+ULwfAP5QKMyD6LOqBDtI23xBSxYxzGM6sJuxM2IGMbUs80WXuVUmcc24snG+DkV9ng6ZcX4j9QDG6ckBAnIvdiWpicNic88eoeNxPCftwTlqEQXhy0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733148917; c=relaxed/simple;
	bh=ErEwmTVW+AJuBhiJwMY/EZuwY/ewg6Ae7ulD+DF5Jgs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OBkoHGBNx91MILJikx4AJs0GdsAjH7M912YEw920reT9WSg3cnlIAn1zti0Fv/WHz5PZPVdGyGSRGTIv4HGe5QGs+bi6Jx6BzgJQspCNL86riQ21UAFfYxOQAvaV4R9NiQDBLjyRd30xmSurx82l9DTFXs8oR6PQ6CRLUPp85zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PPoAYwi+; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a1095fe4so5093925e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 06:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733148913; x=1733753713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4WY1vAA0r2fKbPXY4KjAS2UpwZ8hfCdwU02a05Yrls=;
        b=PPoAYwi+eUePvErxy+KYvdLvS98V7Pdj0Cj7hD2p03ikjT1l5VaKmhtRSLQxidsAH0
         j363wx3YAEEe9Pds/nm+sm2uEDFo+FzPq4fkq353hzlq3EARaYlXcgXYFcCe3jdiUa9w
         Py+YhpNbogB4b5kUIyiKSil59OBIFu9HBJpdTrNSkqMPiy4h/kzIMbhzkWKYfZhJ2xOM
         We/m7V6fxnK1sxEBpdxNmwLw/v+c1rUsE8ZgLuu8qLAyLXx57nNAD3nyphenx9sxLpW4
         us395mC+EMtg9PXwf+swibPW0283mwuvxy0QiyZ0VjBFN1GHmzasKqjySe9alD4QfGS8
         pqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733148913; x=1733753713;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4WY1vAA0r2fKbPXY4KjAS2UpwZ8hfCdwU02a05Yrls=;
        b=GLnxzAR7PuJj2v3RNhpdd31TMrB1/3gDkksmRf5XYz6rpht4uTrrfo0f4i+olX3FY/
         QrwsT+4G4K00j0JZ606j0lLM+s4YFaiylVjeOtM/RIOFjeuqKWC/20qgWreVS5hilNgb
         wgavO6tYNNSuXauXPbSlz0a5kw5fLATOn68l7LrB7yzmPxfgKdvHrtUf49pzuESAEgKh
         m63KYR5FuFELZA7AmJg0lwYBnP1hMONHmLY/FhrqQXjn+hLrDtEC39Gj/AD346jvxJl+
         M0/e93kGhv68H889gq5UpRYetIezCnR4XO+GOs5mOxzGq29b+7CwMPj31bX9r3aD3awP
         naWw==
X-Forwarded-Encrypted: i=1; AJvYcCVO31gObj+gDHdQBnesrGCIDYtQI7+P4Q3ZPkTu0X2I35akpoH2Okbr9cKqulLX4Mcdw0+0HrfatTDlhHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxAgITdLG1xzZFAQgL+thA3qTk9rsphCntwPRc78/6QlmGlFjy
	4w4ee3q/z4TqeFSgTthLyCwER9ue8rI1LOGJ2RehbjbMzqq6dyY72RouovgUioU=
X-Gm-Gg: ASbGncuUGPFEyJLunincn+kwCYv+18bhHCXm8xvC6+Ek5WPbyqS9nhV2u7TzghpMx1t
	z1tyjKh3qW9OQtATnwwzFQnmoc8hwqiGZ43d53O/PsKPujEvcHzSovUtOsEkyvPsGJMUxTx0k0O
	NtqoJ2j1Zm7+sW6yZsKYuNxVUPl4lFvFGnu7JuAgc7bsooJdrsAG0EEjRrLZNdaz4HMJwVq1670
	nxrvBWxsWfOgWkOlBTMJH/mfasIXinAyBIz1GzKL7V4fTeZ5cLP5VqP/lTiJQ+s
X-Google-Smtp-Source: AGHT+IFElDO2xd8mFJCzbrH8EiF3i2wyF8UmcXsrEdAyTq41fa6hejn4lGjAijspgIkC6zPVj6Q6lw==
X-Received: by 2002:a5d:5984:0:b0:385:de67:229e with SMTP id ffacd0b85a97d-385de672523mr4078648f8f.11.1733148912772;
        Mon, 02 Dec 2024 06:15:12 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.23])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0dbe4ccsm152388855e9.13.2024.12.02.06.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 06:15:12 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Linus Walleij <linus.walleij@linaro.org>, Tomasz Figa <t.figa@samsung.com>, 
 Thomas Abraham <thomas.abraham@linaro.org>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20241106-samsung-pinctrl-put-v1-0-de854e26dd03@gmail.com>
References: <20241106-samsung-pinctrl-put-v1-0-de854e26dd03@gmail.com>
Subject: Re: [PATCH 0/2] pinctrl: samsung: fix fwnode refcount cleanup in
 error path and update comment
Message-Id: <173314891106.48956.4220732642073324618.b4-ty@linaro.org>
Date: Mon, 02 Dec 2024 15:15:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 06 Nov 2024 23:04:38 +0100, Javier Carrasco wrote:
> The first patch completes a previous fix where one error path stayed as
> a direct return after the child nodes were acquired, and the second,
> completely trivial, updates the function name used in the comment to
> indicate where the references are released.
> 
> 

Applied, thanks!

[1/2] pinctrl: samsung: fix fwnode refcount cleanup if platform_get_irq_optional() fails
      https://git.kernel.org/pinctrl/samsung/c/459915f55509f4bfd6076daa1428e28490ddee3b
[2/2] pinctrl: samsung: update child reference drop comment
      https://git.kernel.org/pinctrl/samsung/c/0ebb1e9e1b12ddcb86105a14b59ccbed76b6ce00

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


