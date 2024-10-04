Return-Path: <linux-kernel+bounces-351464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6829D991180
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 23:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B8BD284C61
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 21:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C256F1B4F06;
	Fri,  4 Oct 2024 21:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WUlDdGX6"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9E914373F
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 21:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728077897; cv=none; b=q4c8PDWTe/x4ApNDYdBSRA7+qF5ij/TqV5QxQF75wQ4zXtuEgK0Z+hEybXs+6vYz6wFmlLFXi/JIcZY1GcbBjuiTrih1+VPMR5DV3jxeUu1BUpGNrN3FlrcnVlBG1uOtpUf6e11p4HrGamN7vy35hLC7x9l7KR1gPEqqQU5L4ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728077897; c=relaxed/simple;
	bh=xL6oYs7txqJE5TKT/Uno4YPofgUAfebhf5IadXGF0yc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=av8CTjW2QpsXtCYzvnkcdKTY9OhwkJ8YJYn59n330Ffsn4CJsCnHNQUdAQ/3hDEdjmFSVHd4o8Rkc7jVMIUM/UnM4w+udPtnNdfDyS+nVfOmGgQ5yLttosFuhpGAT8CF4PT/Rn3baS9PPKoFT5op9UpgJBaLgEM4TagcmviDD1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WUlDdGX6; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71dee13061dso618016b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 14:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728077895; x=1728682695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gYgjsDPjP7HrNwnpk8YBK3/LqbS1xGGqsLZX+Agvmc=;
        b=WUlDdGX6+XcJE/mP5jK/wmuYy024E6vuUU9wzY30uH/94+FtS5lxNwkfRXGjbnue+4
         Kfwak8DMVu4dOOdqItc/6WfiQmgzZpKFSDPck3n5/4EmUaylGNyAnSNmidwIL6SCihXW
         B/7OPjiBdRj6kiiDbDjE4viJ1tSR+wHvkZRPTok8DAUyuHY7mYrloCEGnx0TUn0P7Kfr
         NtYZ0FGCodfTmxwyM2bIsIIJoyZtNcrxBxjqmvJabvmq/+lD5Zg4w9dAq1itAiexWDV0
         ExeEdI7D4VLLUjAguTQlhs1M0E9303mSGAzH9KlPvKDhDLUjPNwuTQXVzKUo8n0q+cpE
         DQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728077895; x=1728682695;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8gYgjsDPjP7HrNwnpk8YBK3/LqbS1xGGqsLZX+Agvmc=;
        b=SJCuswzSMUwxgJbjJRc1n5AgByFJye10WpCwXpt94g1PsSAmBlM3NO3hPPbjz40kYt
         xQ2yEPbjVxECrzcmWOQTloFoE+zRCJTwwG0IsFZXiLDNcp62/r8fuJt8Mri6FxmPO+/d
         gEee+UUud+dSjjleKpLt25EYsqHx8O67lwRzZLJocrsnNG9WezkVQOXt76QNLkHPr883
         tAxeU0yl4mmlUyZAJgb03rBPkm+/cogQI2NVP4Ekj6xiMQUlaj6p77W+Uc7EFfUVlIJh
         MfA8Fgt3l5Xi2NJCnvfmNqpY86/IeQrorew+6RYY6nNiTHwoIUOFBYRomQelSnPuRAKe
         R9ng==
X-Forwarded-Encrypted: i=1; AJvYcCUKeqZH5RMIDRlK5JI4GNbKTX66sHM1QVnRdMvy2v6pSSL6++aHPnXytq2Pk+d87RUnkRS4SgdxdQjqk4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ9ADURkxOu1xDAvEpyImVNpDBVhEOTZUE1lhiXWxVM7Jj7RFT
	G89oL/5sELntERuQATUGKAG+dGvnn/HktpqD3RJAhfb6ZrZDEQBIBJDu63KybSQ=
X-Google-Smtp-Source: AGHT+IH3L/srL/M09LlQZunlLjeQulGlZd5i2/4jd/ZSLaq2ZBDuaJvJcMPXaGd40sqB8zTBbVklhA==
X-Received: by 2002:a05:6a00:1ad3:b0:717:839c:6822 with SMTP id d2e1a72fcca58-71de245154dmr6642242b3a.17.1728077895176;
        Fri, 04 Oct 2024 14:38:15 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d46312sm327900b3a.121.2024.10.04.14.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 14:38:14 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Eduardo Valentin <edubezval@gmail.com>, Keerthy <j-keerthy@ti.com>, 
 "Rafael J . Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Andrew Kreimer <algonell@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 Matthew Wilcox <willy@infradead.org>
In-Reply-To: <20240913093713.12376-1-algonell@gmail.com>
References: <20240913093713.12376-1-algonell@gmail.com>
Subject: Re: [PATCH] thermal/ti-soc-thermal: Fix typos
Message-Id: <172807789446.805985.12207310389436873259.b4-ty@baylibre.com>
Date: Fri, 04 Oct 2024 14:38:14 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cb14d


On Fri, 13 Sep 2024 12:37:05 +0300, Andrew Kreimer wrote:
> Fix typos in comments.
> 
> 

Applied, thanks!

[1/1] thermal/ti-soc-thermal: Fix typos
      commit: d8ee46b226ace0110f82233ba4c06ff1742ae443

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


