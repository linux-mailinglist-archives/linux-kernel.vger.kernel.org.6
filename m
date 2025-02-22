Return-Path: <linux-kernel+bounces-527158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63761A407F7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 12:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B51B4232A8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 11:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019F320AF62;
	Sat, 22 Feb 2025 11:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eF+oC2qV"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4092080FB
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 11:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740224346; cv=none; b=sNtiW+PwyTItH7EtKXJU48ZyOTKQGqL80FbNwBD7lHfGNtBdTPC6ZkfNFTG7VWW9frcsluUicc7AFaMcep8x5ErXl5Xlz0sjufX2ZnUL15wg0sIpqcZHnkiozXJoJj0Pd8zQy+PiwPP69ZsW+eHoIjp4vYksP2VdtnXONxGnp9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740224346; c=relaxed/simple;
	bh=STGodYbtojpRzBwDBhIkXxC3zzCqdL+G3w+jmR/EteY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UOAhEtff+1z2knQ1Mq3nXwEnXy2y6x1cTZQSa5qKWKmC3rnpn8pc9oqxBSrAcKPJEJ/SyC9L2aYGDsgDDX3v9RvyynGZRmnnIYVpTEwqmM/9exYDR6KcEabl7ZUNLvOrEpdzLKDmnuKZ7ZRA/AlgoThYgG8GJLBoZbTUZypdM0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eF+oC2qV; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5ded500589aso521293a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 03:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740224343; x=1740829143; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QyqLyGoljlA8lLDgpfeeDuyVTQrzc1QyULf6gL8NNgk=;
        b=eF+oC2qVd9LeszGw+loRkp2mWYTWDJVhuat7lLSmjMleJZaFPcONaYO51KUJWKFH7I
         Gb7FSeFAAbfD/PJrjgQL4iqbiM31FJNNElyVzd0Ajd7vrwSBZQjKBuE0IubCReRzk7Dv
         IoieYAnydmgUEQrvD7fdnZ8ViGsihYuz4BEXAx89NH4yj1XQMAd0VtL/R1/sT2HxUTCB
         3RRCchIFMjedSKPgbkWlLkLx7lUVdo3XDK0sumk0qIBTQDGGZGzhzYEdNNMOhUywf66i
         wneen9LjhE08tA0rMpg9ah6hVJI95lzUuWRvIlX0ILJTEfXsb2diJnSjr7cJ7L/d/ab2
         V1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740224343; x=1740829143;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QyqLyGoljlA8lLDgpfeeDuyVTQrzc1QyULf6gL8NNgk=;
        b=h6kX3vNDqyfXA/TZIarrEQjeYO+ROmvW2NKJuBVIFMPM3KVWSggEVw87N/4EV4DpX9
         0bcOBUpMp0hDDoHtEVf1DyZvfAhZg3vDe5EX1X4nh6QQ5kCaBe0fBOgWYuMY4sDcNYrh
         j13RP5J+c4iOecTIYKsppPwun4Eve5347Nb1XaubUr380f/w+lxJRKPfDf516IBmGWjD
         LUML5mZjVmfObtJ5edjtIuEXGflDUOjVB8VBpmz0qGsTQjaczcG63WYd5TuVIr6jERbB
         xboPoU3w8AuJ70lgf6Q66YrQn03Y6l42hJ4CSsrSOv2Y3TOYbrtkLLvYMFPt9oxRycYR
         /acA==
X-Forwarded-Encrypted: i=1; AJvYcCUqNMMkC5NuGCqR9+1fRTod/GY5llTlAFONak5vqo0V+SXLgQJjLcOSj9HVJzhmU5vAtwBiApFphwjuwyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlfoechS+cTkd+RKeudyGZvDeQrKQrDLuVkewnlCNt3lItJ6ix
	olIuXO88okmzNTYb+Ma5ISHiPDBxmjIBz906fOf4A/cZztiUL3OuYrtpdzFNDAM=
X-Gm-Gg: ASbGnctvuOxB7t0lD3AZDPqnPcSyW3rR6HR0yMCPA7726kvwyjnCmhrg6NpZ0+DDxTF
	u0HHb8LRIBwbUk3hC8RD2QVvALFWRAX8Mi7G4+MqN+XwnCXr35EMXIUTlvgZejrtSTuPDID3o4i
	6Sj91IYPnd2FzPOmyjKRP37fXXx9Bl0+zKR6LYwnyy2oh/RUEojkvYTZGqtfAZPHGJ5haDGsvD3
	r+nvobv18arop+zwDmeW3R+XsAZGZ4YoY1C+b5EOQSQCJjIR4PdHWcrD9plAo/CnYvLPnKWhonb
	O2afNPMVcUEl97ToNEoFxJkm3vkCOOPwQ9ooJ4msph+m4b5mRauQs1OK9VaJQDJcM00rNeeGrEj
	B
X-Google-Smtp-Source: AGHT+IHujKTVj/r91Ef/aaopjdtssNonQEGvU9LNR6WW5J6HQjMTi1TWlBVXqMMYeJjAstJ/4J7egQ==
X-Received: by 2002:a17:907:9722:b0:ab6:d3b6:d825 with SMTP id a640c23a62f3a-abc09a578efmr209735266b.6.1740224342670;
        Sat, 22 Feb 2025 03:39:02 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9723a559sm1202702066b.96.2025.02.22.03.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2025 03:39:02 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/3] hwtracing: coresight: Minor const fixes
Date: Sat, 22 Feb 2025 12:38:56 +0100
Message-Id: <20250222-coresight-const-arm-id-v1-0-69a377cd098b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFC3uWcC/x2MQQqAMAwEvyI5W7DBivgV8SCatjlYJRERxL8bv
 M3A7D6gJEwKQ/WA0MXKezHxdQVLnksix6s5YIOhQUS37ELKKZ9GRU83y2aJi6FF38au9xjAxod
 Q5Ps/Hqf3/QA8z9pIaAAAAA==
X-Change-ID: 20250222-coresight-const-arm-id-f54214f68125
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=634;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=STGodYbtojpRzBwDBhIkXxC3zzCqdL+G3w+jmR/EteY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnubdSbtcWbGeUk4k+qC4pVWWcIjCt+1IVka5op
 zJGB7lwLXKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ7m3UgAKCRDBN2bmhouD
 15OND/92EHwxbamqEoVNKc4qIcj8dgQSBgErtstBlguPoSdbV7MOzkQgiq3/N/eJKW0dE/2PszG
 HUf2SvsP3/ILRVJthX8zql6XERxvIu95gvozOWmtyQsKpIkRph1mdBfbeJhmU6NaDGfFhyWtNzu
 eNKE63nW5P8VLwihe+m3NOy1E1Ni7CCuFht/WLfSf7hpDrWGpeeaaxvs/FTfJZBGfSz1Yp+YnKd
 H1Bb1f82ZTGsdmfbKLnqAbDQHqvX9lyxpePXDErDG7FoSGPNCNQ9shljB+Cv/Al5fXwtyVcxozR
 kZ77FEwQlbaxQMIH0ob1pCwESjG+jeSnusqjXrK9fumnyzwZEKLOIXOOa1XLVWOxB4If2IdAYur
 TPlwUx5JS367jjYPCkhX7L0U31qJLPcp5J8nNHT4ynI8h2DfDGE3i8E8pengZL6qRkSDScnGfFG
 OfS4jgKB+sPGslXx+0qY7R9oFzZlhsRUrnndKfWyRKvyE1Q1l8V1MEBRKHTg2gRXaZ/zG8Uad4k
 SKywDiQxS1KsIpvVzXzlJLSpegj1yMbQXOn4f2LcHG56ZCCpn1GBstWrP4ET+H+/ais64N7rC7Q
 DvbH0hucl5sioCDof5cDCT+FrAGYYZ0HiGlwvjW3ysD5v4lkVkHsLlmpj+EAV/RKC/LpRsUhTQ0
 R/Jn9iSi/hQ8HaA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Just few improvements.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (3):
      coresight: catu: Constify amba_id table
      coresight: tpda: Constify amba_id table
      coresight: tpdm: Constify amba_id table

 drivers/hwtracing/coresight/coresight-catu.c | 2 +-
 drivers/hwtracing/coresight/coresight-tpda.c | 2 +-
 drivers/hwtracing/coresight/coresight-tpdm.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: 8936cec5cb6e27649b86fabf383d7ce4113bba49
change-id: 20250222-coresight-const-arm-id-f54214f68125

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


