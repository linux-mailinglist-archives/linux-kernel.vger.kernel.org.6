Return-Path: <linux-kernel+bounces-221607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6196A90F616
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 20:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03A5A1F21759
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 18:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6411581F4;
	Wed, 19 Jun 2024 18:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="pBO03XKQ"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC9D22611
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 18:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718821996; cv=none; b=Cbtcqh/KEKojraonJiMaU1tMjU8AYKJIGMg0ABUKwB+YRIKXBEsGfn8vSG+SgiHsLrsaDRhJK2f1fWbL72oY5A1/1NqQi7evGFUwYH5Fj4jqAnT9eqi4Z/lvevNY7EI4yEi7tJ6Pah41o9vh+Ho+T+OmeKC9kcSNX7CjLxrtGMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718821996; c=relaxed/simple;
	bh=92mU/xikCqLLaH2DVhreKySC6u9LEezQMALGQAdfOZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RMnkgUUDKuM/CP32BJvRmXuqdIvGFLuXFKjMXkj253C8mSvNEMjRXFr8jD2+S3tJLnRCuTy4sEG7iHBYgwDLbsPfEI2fSp0HqyGEb2wchFxIJi51nO+F31EssqJZj2r4iS/wKS8CqMEXb7xdGoMHH0mU/L2WTvbtUtVDpZHX+TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=pBO03XKQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-421d32fda86so1447025e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 11:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718821993; x=1719426793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KoU88YQ9ly0f7ZJ/ZbHDiM2tCrY3AmT4ahDXIv2paYY=;
        b=pBO03XKQL093hITRvjZoSgp+NIreIOgMhIL8TvLnVjopYiGMEIWFfyFsWjNuc+8LTt
         RGFnGpPBV739l44pes+fkp+QDDMxStBGUVJJ29r3zCKvNH+bgEymvVcWJHl5wlkL4RgL
         HARaR6x/jkvFBVCVLN/goyGdxQe8DEN12p3IxoCj94uLswM1aq/jxkL11ExdqqhEYi3y
         lSZaK77fvXxvuJfw7kO8eRWo0FfRYbGb8vr07SEdvnhertQ2ktknDc3n1TiJ8C37P7Or
         9miQy95CTCS+NEUSp9i06UccQh3AW32L4aqHUUsg9vi6GsZvX+SghZRswcOratuJDlW+
         Sltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718821993; x=1719426793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KoU88YQ9ly0f7ZJ/ZbHDiM2tCrY3AmT4ahDXIv2paYY=;
        b=G8T81IfjaXs/QtsOHmPY45Wb/ojCVSslowed18hIZ/SoLKdp1dDCVhEd3z/WdeIqWO
         Sb2T2E1/VyIK5YwzGKT8k0scBJsDSHAgTOYXonDbkyR/wKn8JhObzb6xRriHZnIF/is1
         RmqW+Zwa8HsIjID52I/rwLMrm+si9lHK1zHoT++SW5aa2a4mv9eKcQsrPYt4fp/krsN2
         8nMLz67Fc5mTBpOft0qD/64SSGb9tMVUTvwF4IwlyuKL36NLS79/EKrMJT+7wP80NISE
         UyzPczds/f+oib89eB+ybkHWjh4oO5y9n/aqoez+1K1JFg66ix8EVaeBBAqgm1SqJ/Je
         wbtA==
X-Forwarded-Encrypted: i=1; AJvYcCUhwJh5B+it/pFxRQ1gWHs0yR67zTmizzMp8wyXEJE8SPrqk7djkxYsgCA0kWFb5lhd5+XGh9hgXyAHkxE/Jax+aXxO/qgT6fufn2KX
X-Gm-Message-State: AOJu0YwVmi2pG1yCEXbpJ6EPLlkm88/LhJEQITnsorPtzSSEhreROt4k
	N5YGMIZkkckRxFIkRA/HOO9EoySLllJBwunJ5FUQ3w7XG6evi3/ACu7apFjL2nM=
X-Google-Smtp-Source: AGHT+IETG5LcNQbiEWNnEhPt09r+tCBRtoPh1Vb+eCZeeGLMwJUAbUmHsRulZ4D1s8qUlB6O94y7CQ==
X-Received: by 2002:a5d:6945:0:b0:361:1ef3:71d7 with SMTP id ffacd0b85a97d-363170ed44bmr2922036f8f.3.1718821992776;
        Wed, 19 Jun 2024 11:33:12 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:991f:deb8:4c5d:d73d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36262f77ad9sm4603238f8f.109.2024.06.19.11.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 11:33:12 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 0/2] arm64: dts: qcom: sa8775p-ride: support both board variants
Date: Wed, 19 Jun 2024 20:32:52 +0200
Message-ID: <20240619183255.34107-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Split the current .dts into two: the existing one keeps the name and
supports revision 2 of the board while patch 2 adds a .dts for revision 3.

Bartosz Golaszewski (2):
  arm64: dts: qcom: move common parts for sa8775p-ride variants into a
    .dtsi
  arm64: dts: qcom: sa8775p-ride-r3: add new board file

 arch/arm64/boot/dts/qcom/Makefile            |   1 +
 arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dts |  42 +
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts    | 841 +------------------
 arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi   | 817 ++++++++++++++++++
 4 files changed, 882 insertions(+), 819 deletions(-)
 create mode 100644 arch/arm64/boot/dts/qcom/sa8775p-ride-r3.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sa8775p-ride.dtsi

-- 
2.43.0


