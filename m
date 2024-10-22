Return-Path: <linux-kernel+bounces-376873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C19359AB6F1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 458F01F23C45
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CF11CB323;
	Tue, 22 Oct 2024 19:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c84Af6re"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1481465A5;
	Tue, 22 Oct 2024 19:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729625756; cv=none; b=Rma0Ai3HU9lnXh6lvc7oTBPiWCJvIsfAY8gausiuK4urQvRjtMxO53ftpSBfODkoWAyq1gdPNxngZBAKGetRfLEkGKz4ByE9VO83f+lpLjRL8UYS4gp3mTas7Qba+vE28c2L9qPs4PyGKgaz4u4EgL5pkuVLCCbajSIXwLQEEMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729625756; c=relaxed/simple;
	bh=9A5XYtqiRxz39R/mL0VxvfHb1YXuWdaPFz4t+fXvO9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KCJyvMlz90SLKu0TN0AmkpCYEjnTCclS3jUGGsUHS4SI7ih1rZvqne8zMV8zjMILDFtyeZ7kyqmPtIqLIe/eGET/NZKQk9/0JzKGRmkzE8RaW0b3s7y9olr/WxH741H+lc9ty5sAIr8vop+DZ5VpaeTaAxdoBJyUq4c2Ug48mnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c84Af6re; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a3bd422b52so21258455ab.0;
        Tue, 22 Oct 2024 12:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729625754; x=1730230554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ib/ig3/S11byU+V/CcemUiFs2TSic2CNnnx9wlVKppE=;
        b=c84Af6reKOXnRvOI1sNP8km3kPbG3mfKjNzJRBrh0dFy8u9BXVAQRmDlrW2e2GeywN
         8DoguJ1ndFiEJcHrlhcta8kK8vrBxbsOfjlUWk9Eh6HGJZk9iiZgxwATp2jy868l2bVP
         ZVTPXZZOylvUtbXZ2OFRb2t0rIJ5u2HCPqg9QC2Zn7wJOb1C8dMYSvArhSS8CMM/9OK9
         HjSxxSvz7Uvq1IfJV892w5siBB2VJ6ykduzzHOfqQbjBGkONgZIEKJE4fIU5Vye9QugN
         pkx0DQZHFjt4WxTeORLncRNZhhfhkVVnfRhJYUkAflHhYPOVHokHsW6+EcMd4Si3IMr0
         VLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729625754; x=1730230554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ib/ig3/S11byU+V/CcemUiFs2TSic2CNnnx9wlVKppE=;
        b=AM2QisUYq66nCIjwCpB1zvBDFJsrTytG7+sXwu6fN5ld5z60tfAj6iW7FGCwEMF75G
         iKAD/tbA13wmT1apNJv92yCrdE9BhBx0TdwjDRxtsmKVMX0E3DSLG3P9Lu07Jgsmz23L
         qs733PoCsVcm4bSPBH31fZpAsWRnw032AcXTaSzwobim2KzEqe653gpsZ49VZZi7M6af
         UubMDE7e4TUYdUKCOU+yDOhNsXPbA3TOJVNaU8MXm//hJn+AFqBq0yKq9WJ3XgSGgODQ
         pXU75DbEyVsBzumlGYBDxvVHppa5A5AECYe6B49ASl8BzdFpg78MXslRnWKXYwyg6P4a
         PoBA==
X-Forwarded-Encrypted: i=1; AJvYcCVlEXhrlQURsk2kfLfiUWzi3qUDX7YSiZ/dPm6tJpR/N1dalrEj0/AAcKNimeU5e17zLR+FwYt8Ha6Likg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6vYdoL9hQd1eRyWNtjfyN9fdCLjRMlYnqD581sGNQhT+pjaMi
	xpYXCK0EcIbgpcdvdqW65lFOmemLxARdfO+Cqr0+r9cgSrFNqY47
X-Google-Smtp-Source: AGHT+IHnHVKqeEUU87NEuaO+Je6oEbDVQJmeeMVNJ4F961asQttJfoCd2nPE9LF+Dw/EmEboHeEgRg==
X-Received: by 2002:a05:6e02:1569:b0:3a0:a070:b81 with SMTP id e9e14a558f8ab-3a4d59df6c9mr2902825ab.23.1729625754109;
        Tue, 22 Oct 2024 12:35:54 -0700 (PDT)
Received: from CNSZTL-DEB.lan ([2408:8262:245d:4d65:bc4b:53ff:fead:2725])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeaafb1e0sm5467316a12.3.2024.10.22.12.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 12:35:53 -0700 (PDT)
From: Tianling Shen <cnsztl@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Chris Morgan <macromorgan@hotmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Andy Yan <andyshrk@163.com>,
	Jagan Teki <jagan@edgeble.ai>,
	Tianling Shen <cnsztl@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] arm64: dts: rockchip: several fixes for the nanopi r3s
Date: Wed, 23 Oct 2024 03:35:25 +0800
Message-ID: <20241022193537.1117919-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

* Enable eMMC HS200 mode to allow it boot from eMMC
* Sort properties in pmu_io_domains node
* Reorder mmc aliases
* Replace deprecated snps,reset properties
* Use the marketing name for the model name
* Update the website url in copyright

Thanks Jonas Karlman for the review and suggestions :)

Tianling Shen (5):
  arm64: dts: rockchip: fix model name for FriendlyElec NanoPi R3S
  arm64: dts: rockchip: replace deprecated snps,reset props for NanoPi
    R3S
  arm64: dts: rockchip: sort props in pmu_io_domains node for NanoPi R3S
  arm64: dts: rockchip: enable eMMC HS200 mode for NanoPi R3S
  arm64: dts: rockchip: reorder mmc aliases for NanoPi R3S

 .../boot/dts/rockchip/rk3566-nanopi-r3s.dts    | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

-- 
2.47.0


