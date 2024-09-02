Return-Path: <linux-kernel+bounces-311953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A82F6968FDC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 00:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D06A1F244E2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 22:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF0D187861;
	Mon,  2 Sep 2024 22:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZBz371vk"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7694117966F
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 22:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725317305; cv=none; b=Zd4IkDmrFNGrr6whbsuJ4q2PI+1rbF8XLrkMCXUJpI6IznEI5BmesjJuLF/mc7pLMu5JKhaW3zqLsibcaDzNLypgoOLXKDXGJfWng9q46n896h+2C3PS4RQiMXE0NBVXMk8cmLWqKj+dTZb6C2wD+STLONygQS5D6v04l6VSt3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725317305; c=relaxed/simple;
	bh=mi5t8u/xebX7mhenOTAeq1Xr/3w8JvN1g+BM+B5n2Uo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d1SSF0WKYjv+XRBZ5gXDl3Ak17zt31TahTo6+WgwU35cMnVi6QBJ8LsDgtbE3QWindzmGiktHMNxm/D2h9riAgdUPVj6xzHT1YX3h72WkIb6++dY0nSWfCln75/fVbfKBIifqTzlgsPlW3ZT4pRxC0VdgW1AMywCVB+BSXX7JAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZBz371vk; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53351642021so5001025e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 15:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725317301; x=1725922101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+tHt6YbEYKdIZoRecVjHoZ1hDu+9v6PoBrsVr9Tc8E0=;
        b=ZBz371vkN5VIxm8Q5NkYKTdzxvV/Y3Fxtkh3eDgZfMz2cdIPTJKLTho4b1EbgbUdcv
         h2wuiatvU1OrXGC4T+l82smLia1neNkL1NgzGh4pg57sMJp97ow8S1GNME9NdikJ63bD
         QVUzzK6no3h8ppedasYiNs0AoAbJGZzzwEUfeeBF1fsZljGaVMi09MQGrdlPeh3ubG3g
         M0kwAevlWWaxcrVFzImssYX0rr5ZylMLECdqKbhk0HwJL4iNEJ5AA15FQoU6go/TKLWf
         30MN2ScbhTBveZNSofPTKiTCIpS7BE3hnZR84Bcjwp9vkGTwNdWhpdZ+M2tGG/3vwAQJ
         unEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725317301; x=1725922101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tHt6YbEYKdIZoRecVjHoZ1hDu+9v6PoBrsVr9Tc8E0=;
        b=joeUeb1RIxJXy8OzjJeB1AMcpMJ4tNbf0enKmMuXl0UKAbWlFiZbC4VeO8WoPjI8zw
         wygWlUaP5VG6+DGM8Qu8eZ/6kiqVC0BAeBRTZ+r+gEeJmJkYN8oY4MYJmad2iG0xbOOX
         Ew9qNQISAgjxeTqYr5x2JcS+J/PPQwLS5Qo2JnisgmSj54hytM9Zbb+wh13eY4WihKpH
         I7iVApnfOlHK7kvrHP0ZVxrmVT6RAlqOnK9GD8bQvSqE4OlHWw09IaNZTzPbWbF1t3Ej
         SUSrGsL7ooS3Sql+dZzva927uLNOVaySDg6/E47CBT9zJHOm2cO2u2CUNTS6gb05VZSJ
         vQmg==
X-Forwarded-Encrypted: i=1; AJvYcCWbavyQFfbB/FtiurU0tVUiflIgUueVU00qe8YrYV9ZX/AR/RxK+uqayVw/zSmp38NSgcXOolH1pn7rPnY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy88HkUdpIm6N8EufKe/BhvAspE5+TBk8pUkj7BP7z0pgDW/5LP
	kfNo9O1rhKMIwr5QdALl2iZjXryn1hlows+Uxjy4prc4pIeAGOg0SCdsDJmixh8=
X-Google-Smtp-Source: AGHT+IE5JsLl/nGfRejt5XBymU6zm0pRwvc7ZSu5/JJmpMVNh24v8a2zkgYPPPZHhLnvRh7ndQewkg==
X-Received: by 2002:a05:6512:1091:b0:52b:c1cc:51f1 with SMTP id 2adb3069b0e04-53546b2597emr7683029e87.23.1725317301026;
        Mon, 02 Sep 2024 15:48:21 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5354079bbf2sm1790646e87.20.2024.09.02.15.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 15:48:20 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Viresh Kumar <vireshk@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <quic_kdybcio@quicinc.com>,
	Nikunj Kela <nkela@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Stephan Gerhold <stephan@gerhold.net>,
	Ilia Lin <ilia.lin@kernel.org>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] OPP/pmdomain: Assign the correct required-dev 
Date: Tue,  3 Sep 2024 00:48:13 +0200
Message-Id: <20240902224815.78220-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The recent series for OPP/pmdomains [1] that has been queued for v6.12 via the
pmdomain tree introduces a regression for the Qcom Venus driver, which was
reported to me offlist.

This small series attempts to fix the problem by making the assignment of the
required-devs more robust and correct. More details are available in the commit
messages.

I have tested this on specific test setup with Qemu, trying to model all the
various way required-opps are being used. I would appreciate help with further
test on HW and reviews, of course!

Kind regards
Ulf Hansson

[1]
https://lore.kernel.org/all/20240822224547.385095-1-ulf.hansson@linaro.org/


Ulf Hansson (2):
  OPP: Add helper to retrieve the OF node for an OPP table
  OPP/pmdomain: Fix the assignment of the required-devs

 drivers/opp/core.c      | 15 +++++++-----
 drivers/opp/of.c        | 12 ++++++++++
 drivers/pmdomain/core.c | 52 +++++++++++++++++++++++------------------
 include/linux/pm_opp.h  | 13 +++++++++--
 4 files changed, 61 insertions(+), 31 deletions(-)

-- 
2.34.1


