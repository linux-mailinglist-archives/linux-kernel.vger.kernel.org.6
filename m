Return-Path: <linux-kernel+bounces-305412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD71962E4F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 19:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 665F71F25329
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 17:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79F018B487;
	Wed, 28 Aug 2024 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G2irFQ2s"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBAC16087B
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 17:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724865448; cv=none; b=VbZtdI5QsH5NCklF3xOqyyqR9e9WCgEx54Nkb4bT2W6DoBpyuLRGGNLSm8Z94NQd+0fgz7oRBpbA2/fTyyMX3Ybf0rxxnotO5jFtO1c78kAYrjy73O5YYYEXMfoDNyK3Crw1juGSvtdDX+cPEdHfw7a8Th9QPIVwxv9g8mWF/KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724865448; c=relaxed/simple;
	bh=p1GvsN04RrnLY0X7JsqpE8JtBOcwD2Nm4oXAW17AAKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=swIAr8Zt2PsKD81W9VQoXgLdnN3CvSCdl/tDNega2TmR0Yvaw5JQcPcpYasJDPGbQzaqAKYTJ6dA3jiXpnV9jFQJQ6V718V0vf47EufRTE2o9xNjVUN0ZseD7BWPewsh+1wYj3SMQ5L6RJSKkDdZHtWwvwGFPo4a27w2O7hOdrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=G2irFQ2s; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2020ac89cabso65988735ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 10:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724865446; x=1725470246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4kJ5hpnL3/FBGpLHASzo1BcvnUs7S3nSY7lVkr92lVk=;
        b=G2irFQ2sPAcjjjjLKAl5rffyEzNWBL9HE4wkRUiKvR65hNwvjQ+E1CHVZFjY3cLda7
         CV59KgwG0XP7EHGqZFlFZjsNpg/JSWsIFzYzx4eFEoARjNtkCfZfPGi2j92DYcvgWJxO
         BQZUPMyApK1C5YERy87tgekKy1C++Iscu8Evw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724865446; x=1725470246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4kJ5hpnL3/FBGpLHASzo1BcvnUs7S3nSY7lVkr92lVk=;
        b=KAAYbz+m8OuKueDGjaUqY9/lhZfpEcWRMMZZkAFX8p71E/VTcLIkTs3jEEwXQTFmQU
         efqRS69eVbrhI87KOm5MoQhT/1iLY3YKuZLL9Px/FqKFgGoifnDB8rKcIdko1MMwQqnv
         mkakiA8AWLwqVZbPUKE1Uhp27ZKG2oWQIg2Ah5FEyRX8N0t2QvicSPq7iQOvxuTiHtBC
         MFM6ZqfJEffZZBfq3l0MGBVRGhPkBs0QYWVag1ATbqceYWOiKJM3k3yD1iiRLE81ys8y
         CKYX2CFoumK6KGIGdFDQ1SZQc6/NgNm57Q3B5p81xVoXSqLPxwHhXlRcIEauwtRTNfW5
         gqnw==
X-Gm-Message-State: AOJu0Yw3uBa3VSs3XeUZdtiKjQAfxCtOIY0caiIl8RdiY/KLChShZALV
	tvJMAtmVWjhp93nw0mVxRKlyTAQZyaGRu2TXzmoHktr/p8KAnlDlxpzHD2JSnQ==
X-Google-Smtp-Source: AGHT+IFS7ZURBYUCOol3v8lGedBydTXmTI3cDaFTKt6acXzQU+49QjTiAkXmr7wLO/8x1OSBOaOUWQ==
X-Received: by 2002:a17:902:c40e:b0:202:54b8:72d5 with SMTP id d9443c01a7336-2050c49692dmr1849355ad.59.1724865445848;
        Wed, 28 Aug 2024 10:17:25 -0700 (PDT)
Received: from localhost (210.73.125.34.bc.googleusercontent.com. [34.125.73.210])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-203855dbcf2sm101566235ad.146.2024.08.28.10.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 10:17:25 -0700 (PDT)
From: Stephen Boyd <swboyd@chromium.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	patches@lists.linux.dev,
	linux-clk@vger.kernel.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Amit Pundir <amit.pundir@linaro.org>,
	Taniya Das <quic_tdas@quicinc.com>
Subject: [PATCH v3 0/2] clk: qcom: gcc-sm8550: Fix shared clk parking breakage
Date: Wed, 28 Aug 2024 10:17:06 -0700
Message-ID: <20240828171722.1251587-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Amit Pundir reported[1] that a recent commit 01a0a6cc8cfd ("clk: qcom:
Park shared RCGs upon registration") broke USB and audio on sm8550-hdk.
These two patches fix the issue by skipping the parking bit of the
shared RCGs for all clks except for the ones that were causing trouble,
i.e. the display RCGs on sc7180.

The first patch is all that's required, while the second patch can be
applied anytime to simplify the QUP clks that don't need to be parked.

Changes from v2: https://lore.kernel.org/r/20240827231237.1014813-1-swboyd@chromium.org
 * Reword first patch commit text to clarify further

Changes from v1: https://lore.kernel.org/r/20240819233628.2074654-1-swboyd@chromium.org
 * Revert most of the bad patch, except for the sc7180 display clks that still
   want to park at init
 * Re-order series

[1] https://lore.kernel.org/CAMi1Hd1KQBE4kKUdAn8E5FV+BiKzuv+8FoyWQrrTHPDoYTuhgA@mail.gmail.com/

Stephen Boyd (2):
  clk: qcom: dispcc-sc7180: Only park display clks at init
  clk: qcom: gcc-sm8550: Don't use shared clk_ops for QUPs

 drivers/clk/qcom/clk-rcg.h       |  1 +
 drivers/clk/qcom/clk-rcg2.c      | 36 ++++++++++++++++++++--
 drivers/clk/qcom/dispcc-sc7180.c |  8 ++---
 drivers/clk/qcom/gcc-sm8550.c    | 52 ++++++++++++++++----------------
 4 files changed, 64 insertions(+), 33 deletions(-)


base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
-- 
https://chromeos.dev


