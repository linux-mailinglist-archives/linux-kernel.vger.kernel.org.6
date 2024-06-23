Return-Path: <linux-kernel+bounces-226118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96214913A7E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 14:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53B72282594
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 12:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB8B12FF71;
	Sun, 23 Jun 2024 12:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mMaUtuwE"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B304CDF9
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 12:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719145356; cv=none; b=hUuGidHiTl0Vbyl4qEK6NwuIbVj+RoNb2XoXov9ZWjfZhtECFJWGXWVCMCT23/CTqT0Nz6h2qX+kqqds9N/A4F+2YdohxVv0k9E1cG+ui7BSQSsTuBzNB5MU4gYvGH728xuAIG/EtGmRYduZ7+0o9JE9NQboLeAobVwrwcmn4Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719145356; c=relaxed/simple;
	bh=q4YZf13d1nktOQ8KChvk+I4nUMTY2mqyfyNabtCh/44=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cxCJzXFPmdUNAPADbX0dNlx0UyfIQGLSwmKPiFpjEfjyGNQ/yK3AzGak1dKozwEetrOebwk0qGbmvfJehCWhMnsdq0Oa8BCVKNBeKFKhJhivQR9g7Ab2LXxNucaf04s3I/FVuaQfbVxP/Who+sIHmCvOhpJmU6PuCqLJv9mC8dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mMaUtuwE; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42189d3c7efso38050545e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 05:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719145353; x=1719750153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uCngDWXR5xLT7dNGS6wKeQXz34zWbBoZqNqT6a3rtyM=;
        b=mMaUtuwENYm+rO2JN6Q1e03uRdjjTx2rAY6xnD8ahEq7wZWV41E5ACPm42NYfAlqY4
         oQC/tjPtIvk0W+wLrMlwqT+DEvKFOfXwKzqPpqfOVW+Zlq81SSaoPAeXeQPD0/+nCgCZ
         pvzRWEkclyqkbxYaH6FAO4Bo0ty+iREtQqzsIdgPPDZA8VW36k2rlnhMB7i7sJLqijWJ
         vYuLmhqtylJm4UhPByqDsodOFUMWMry46WSrdwEpZpNlJK9agaXPxo723zV2lLdlNVXM
         hF+Tzi9fELqQRbQQBiE9Ae+pFJxqM9Dn1QndgPStm+H4OZxU7dQOMnZ3cfFplP1imTMN
         k4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719145353; x=1719750153;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uCngDWXR5xLT7dNGS6wKeQXz34zWbBoZqNqT6a3rtyM=;
        b=NkJIx+51zOjEbocdX+GevGN9SMGNDJk2AXADUx+XKOFI0L9AiJr5HM9tsU0NyOTczR
         FVstmNfU3MZnuXan6QVBhSvLTcfmjE41m1ZeUj1qPxLds0h8bnlCerbnll+rkumfLBt/
         KKdA+doQS1eoC6v58+ltaCOZ7dFtweaXbWZ86uQ+HNQjEiM/86Sqk3c+F5JNKsSOCvHj
         /BR2uD3H+qEGihTm/fz8N/AS4FDI/NvATVpyJDr1raQWlyBTrg3Jc9NLNFhGQf4UVexA
         AWPI056ZiTiwljuYh3hynd5tKf3hpeNg+Vo4UR/vrjTzmg8NJZUCLK+RAxglIn4dXpuo
         CvJA==
X-Forwarded-Encrypted: i=1; AJvYcCWs0YB08EwzzY3WJWXesL94oJd/txjl3icOEIDcZkA0Jwu15FBGQ1WctJfOgWrNOjosD/fv0tIfoaY3jtn4QAwBxOvbKRhfwb703TTv
X-Gm-Message-State: AOJu0YwFmUSpFylywra5z6uPJu/Oh7UjMK8kMzv6eVU/k7TNT7ZWLQMW
	lHbt44jgQm79a/AxEgMapG9Qi9+Md+9vdiqhL0lp8A0qBBCvC27LGAonJD270r8=
X-Google-Smtp-Source: AGHT+IG1ajDJwHzlbEYhg6OIEi3VvA/YKrK5c/OvtnDMI+KP/GPDROApZPX+ndF9eQ6DUcTbb2FxCg==
X-Received: by 2002:a05:600c:3146:b0:422:6755:17de with SMTP id 5b1f17b1804b1-4248cc73dd6mr18288105e9.41.1719145353394;
        Sun, 23 Jun 2024 05:22:33 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0be841sm136955455e9.20.2024.06.23.05.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 05:22:32 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Olof Johansson <olof@lixom.net>, Krzysztof Kozlowski <krzk@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240613134910.7862-1-krzysztof.kozlowski@linaro.org>
References: <20240613134910.7862-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: ARM: axm: add Krzysztof Kozlowski as
 maintainer
Message-Id: <171914535207.46985.16943803331169294823.b4-ty@linaro.org>
Date: Sun, 23 Jun 2024 14:22:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 13 Jun 2024 15:49:10 +0200, Krzysztof Kozlowski wrote:
> There is no maintainers entry for the ARM LSI AXM SoC, thus patches end
> up nowhere.  Add such entry, because even if platform is orphaned and on
> its way out of the kernel, it is nice to take patches if someone sends
> something.
> 
> I do not plan to actively support/maintain AXM but I can take odd fixes
> now and then.
> 
> [...]

Applied, thanks!

[1/1] MAINTAINERS: ARM: axm: add Krzysztof Kozlowski as maintainer
      https://git.kernel.org/krzk/linux-dt/c/296c0bb50e31f9077c391e57bf43f3e23a73835e

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


