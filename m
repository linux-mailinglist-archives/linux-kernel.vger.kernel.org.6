Return-Path: <linux-kernel+bounces-241540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F2C927C5C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 172C91F2446E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676A23D97A;
	Thu,  4 Jul 2024 17:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rpxcdwzn"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378D529428;
	Thu,  4 Jul 2024 17:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720114884; cv=none; b=qMTk28AJHDmUhFFDGtcL8iyocJkzJIPyNqt4/aNZbZpy1a9NlQOFaYRRZAHN622Z2dKT7iMkZYMmsnBN1M5u7MnMzC5X06LlOdIGbT+EC34W2KGIAk0NRVuBRTirjoAoDRT1r5ynt19CckVJGXD6YPry69Y54IiH3sMumh9TE8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720114884; c=relaxed/simple;
	bh=fq2ZOObELeucCMbuB+1QLCEduCQvBbBvZrzOojdx2Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hYLaWx2W+Tr1lf/eWb+sCzVoEjHP1XSLSkzVPpnFJ24wXDYk8lBTfUJRCX4nwDSATwYir7twHJ8gI8IWFagETDNXJSqsgRqRY3iM2RCF7LAgy6c22deK/FB2V2WnnZ1jHaTanWGCaIg5PnVHVRjNu3hdER4FU5C19xG7sZ3OeE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rpxcdwzn; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-36796aee597so519632f8f.1;
        Thu, 04 Jul 2024 10:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720114881; x=1720719681; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bU9New5YXvNCAbdFkg8Rto3vxKPmznkuBPhNxkpNEwQ=;
        b=RpxcdwznQxBTPo1ODnmTnmvLBpAM8MbN3OZd++b2HHghfy4DO/B4b5Cw3psnvAC+gS
         oc/ulNLSxrAJ8DuX8tCyQZi7s2rXmZxTcm53NunNxcT2GkjJ1IUHsydmKYp7sEyumb/b
         BP4xcDlcgzDbp869yY+9pUoLFCaG1pDXY1yXgoTduDdO2OQmPC1flsWqc62i8w59ISLY
         QWyWBmHyMfm9ldIp/ZbUYODgLOuJSkprDy5hTWzaN6J6UCHNg1N8ck9RSY7FECcSO665
         IXRAW4C1PLK841yhsHF0T6iUEkv1s1++NNNjqc9oobwUC1TNMfj/Dz3OmlE/p185C64X
         +irQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720114881; x=1720719681;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bU9New5YXvNCAbdFkg8Rto3vxKPmznkuBPhNxkpNEwQ=;
        b=Y4R17XEdz/4kLcaVkv3bDnBBtWjvlN4jM+6xjuSG3m3kpKdrJ34Ry8ynrSOa9us8fq
         oZfTIlHBrWlAyyFb9FZPis3eSVCvec/CQumQn84cTsj4teIKZ+o8xuB2/AsPRnCJwyRH
         SgP/32UaHrjDwojPQ1Yle23wfjIdfCCwRgEBWg/f7jaNudJrN7C0hM6P/hU3Z7sWmKtS
         iwYqMHXWu1JtXzruW/NkNrEjxYejfPIntn/f6eFycuJFGuwayJ8I6pmbdN6SXpXKf0LB
         x9IPp/kTql3Rssw2d+H33Vzfut9t+1drowmDlDxTy+vaXCkETsqW06Th9aiEi7uE2wnA
         8gZA==
X-Forwarded-Encrypted: i=1; AJvYcCXjPKQxc5t6YtgjeUVE72swqHt9INKNrS1TxBIqf34j06ZY4bd9uUU/MbucInjhs+RoQLyItctOhHzag44TgX/tBBTYZYz0CF3XPvQ0
X-Gm-Message-State: AOJu0YygkH8EBgUMkekTEKGO6VMW9hJT0BoE4MdNeOd8VkrsOQb0eceP
	eMhWo1xbYkCDVupp/Gi7cxBVKok8syYySSaBRuY6bEl7+laa/z6N
X-Google-Smtp-Source: AGHT+IEujWzpcsdU3i1XXemVlfoBXoV8tmZvP0Aqbp543/z9LQGHRC2A6YImFamVJ6SpXGAXqSQXaA==
X-Received: by 2002:a05:6000:1363:b0:364:8e3f:89f8 with SMTP id ffacd0b85a97d-3679dd721ffmr1867763f8f.67.1720114881377;
        Thu, 04 Jul 2024 10:41:21 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3679983882csm2760366f8f.78.2024.07.04.10.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 10:41:20 -0700 (PDT)
Date: Thu, 4 Jul 2024 19:41:18 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baolin Wang <baolin.wang7@gmail.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Cleanup Spreadtum/Unisoc ARM64 DT
Message-ID: <cover.1720112081.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This series contains various minor cleanups for Spreadtum/Unisoc ARM64
DeviceTrees.

Stanislav Jakubek (3):
  arm64: dts: sprd: rename SDHCI nodes to mmc
  arm64: dts: sprd: reorder clock-names after clocks
  arm64: dts: sprd: move/add SPDX license to top of the file

 arch/arm64/boot/dts/sprd/sc2731.dtsi          |  3 +-
 arch/arm64/boot/dts/sprd/sc9836-openphone.dts |  3 +-
 arch/arm64/boot/dts/sprd/sc9836.dtsi          |  3 +-
 arch/arm64/boot/dts/sprd/sc9860.dtsi          |  3 +-
 arch/arm64/boot/dts/sprd/sc9863a.dtsi         |  8 ++--
 arch/arm64/boot/dts/sprd/sharkl64.dtsi        |  3 +-
 arch/arm64/boot/dts/sprd/sp9860g-1h10.dts     |  3 +-
 arch/arm64/boot/dts/sprd/ums512.dtsi          |  4 +-
 arch/arm64/boot/dts/sprd/whale2.dtsi          | 43 ++++++++++---------
 9 files changed, 35 insertions(+), 38 deletions(-)

-- 
2.34.1


