Return-Path: <linux-kernel+bounces-228916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F169168A1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 721781C2269B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1088415ECE5;
	Tue, 25 Jun 2024 13:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WFXMpgCS"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9B01482F8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 13:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719321099; cv=none; b=FWjES5lOChyd25CMLZGaP1jmQISF9WZBCJNZx/1vn6C+B3XERLY8su/8ilxxfQvi3ecooX3znxU4SAvYwd1/JcC+d5V5ZhuksY4gRNsQJtBXxqSNN5MbI5NsNKtcRHgm1ySaWunKdboWgIslmsliyuncIKCGq3YsGKKxSHQB+24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719321099; c=relaxed/simple;
	bh=7l4Uime447ech62qmw3e1+CoLS03F5S+sN0ntrzvEbs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ll8qmyH6dqVf1Q+CcAwMGiGNG6KjqlA6C4CaOpTJvlmOoTBtN80adZx/sfAocPPHvhejKWMtlO5XSqefWYBf1PBZ0bYruhshX+XJGMERjX+Tb9CiBtLvfz1l0VLj7UAD6XHA9hlR3FF5ZTGBZNiEiFOUOT4epf//FaBvk3L+RSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WFXMpgCS; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42108856c33so38675095e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 06:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719321095; x=1719925895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWdwFGLisZTjIZj5f6mqYa4O5wFiRQ0vmR5lx8cA8wI=;
        b=WFXMpgCSWug6jpE7OTEl1G5vwUM1qJSZWKA1ZOE6/Bn3reE1jy9+XeDdJoYMWF4EwJ
         uuF1kZq/pcNopLP4KBFV48mNL1JRmTbaIttpMe5csd3xP0l0HsXxcOqXNsN/ZWto3NsA
         sounLQ1l+kMRIMqmKDMBdAXm71MEzA6QiAUdBDcQeJBKnhUyKgsWqN4f3LzDE+V4BCcP
         bxIkTnKLRn4956I6/iaBPUsdcD2zCF43GlsoNX6SNSamy0NgL6NsxvXcSMNwGuePGwJz
         Z5lkmigS2N+Ap4r7d8za5Psi56rrYFzEIaa4WVxK4WaenbjiQWxyGRy0nggPQvH9p2S4
         xpDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719321095; x=1719925895;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWdwFGLisZTjIZj5f6mqYa4O5wFiRQ0vmR5lx8cA8wI=;
        b=MX4BzVXi9A9SyNPANT8cvvj7TNC7aKksTYhNGucpxs+ZVjEKlCRPrV032HshcrgoB2
         dLmmUIgd/R/Wl2VWvovu6byZvco6vvuWCC6kA7VQKpzbzpI/SXebptpze+itJfm40lTN
         +4toyWTG0SNw657j2UYhIjbum+kSHRbWl0yo9xUycdjKlZo27blISjS7ZWIix+6+li9W
         IZpmXeMzag0ogFGEqIIYgTwNsYFY99E7BH49QTG+/flE2Wkj83uryYJI7sDAPi5yUCY2
         g1ICj3SEbzZ+MU/mFDll4xdvZUJSyk3c48cTkzv/Nf5OPJjkwLtM0oG6RjFCoMVsmcic
         JwGA==
X-Forwarded-Encrypted: i=1; AJvYcCX4off+upNCFzlKtW2qpgn4eSkRRi55E8gMo/wgHkZaNKbvy+QsMVcNZB0V+/0V3EXmdv1ny06kPcPMNh+oju8EYKdUI7p4vAMD46DQ
X-Gm-Message-State: AOJu0YwZxnjC3/wTtYAuX08OoutaEiYBKQ9lRHG18tpPeLyPRIBA4SIF
	PnTbmwWG4d77fVBsCX2anPUjImCE0BBkeCVAgPxQRMsHr/2E8e1SzCRIupraUVM=
X-Google-Smtp-Source: AGHT+IHMvZCbIGUwTjA6XAJc7GaXn40HqxJWlWqt76/dBBaT8glx/jIewK3UrGIK55zvb4ODd+CG6A==
X-Received: by 2002:a05:600c:56d6:b0:424:8acb:7d53 with SMTP id 5b1f17b1804b1-4248acb7f20mr72630725e9.1.1719321093913;
        Tue, 25 Jun 2024 06:11:33 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0b62basm216005375e9.8.2024.06.25.06.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 06:11:33 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20240625111845.928192-1-jbrunet@baylibre.com>
References: <20240625111845.928192-1-jbrunet@baylibre.com>
Subject: Re: [PATCH] arm64: dts: amlogic: sm1: fix spdif compatibles
Message-Id: <171932109316.875193.8293227942667432366.b4-ty@linaro.org>
Date: Tue, 25 Jun 2024 15:11:33 +0200
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

On Tue, 25 Jun 2024 13:18:43 +0200, Jerome Brunet wrote:
> The spdif input and output of g12 and sm1 are compatible but
> sm1 should use the related compatible since it exists.
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.11/arm64-dt)

[1/1] arm64: dts: amlogic: sm1: fix spdif compatibles
      https://git.kernel.org/amlogic/c/b0aba467c329a89e8b325eda0cf60776958353fe

These changes has been applied on the intermediate git tree [1].

The v6.11/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil


